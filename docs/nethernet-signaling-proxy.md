# Nethernet Signaling Proxy

This guide covers the Bedrock Signaling Proxy egg for a Nethernet-enabled
Minecraft Bedrock server. The proxy uses Traefik to provide the signaling
service over HTTPS and to obtain and renew TLS certificates.

## Ports

Nethernet requires two reachable ports: one TCP port for the signaling service
and one UDP port for WebRTC. `19132` is the default Bedrock port.

Pterodactyl currently allocates TCP and UDP together, and the protocols cannot 
be selected independently. To avoid assigning the same port
to both Nethernet services, use separate port numbers. For example:

| Service | Protocol | Example port |
| --- | --- | --- |
| Signaling proxy | TCP | `19132` |
| Bedrock WebRTC | UDP | `19133` |

Configure the Bedrock server's WebRTC port to a port other than `19132`.
`19133`, or another nearby port. Ensure both required ports are allowed through 
the host firewall and are reachable.

## Backend HTTP service

The proxy needs an HTTP address to contact the signaling service. 
Use an address that is reachable from the proxy container but 
is not exposed publicly. Suitable options include:

- The backend container's Pterodactyl UUID as its container hostname, when
  both containers can resolve and reach each other on their Docker network.
- Another private address bound to the machine, such as a private LAN or
  Docker-network address.

Do not point the backend service at a public address unless it is intentionally
publicly reachable. Verify that the proxy container can connect to the chosen
address and backend HTTP port.

## TLS certificate setup

The proxy obtains and renews TLS certificates from Let's Encrypt. Cloudflare
is used to automatically create the DNS records required for the ACME DNS
challenge; Configure the proxy with the hostname that clients will use 
and a Cloudflare API token with permission to manage DNS records for that zone. 
