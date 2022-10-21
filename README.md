# naumoff.tech
A scalable and fault tolerant web application

Notable Features:
- Deploy a containerized reverse proxy and Flask web server across Docker Swarm, with three replications for each worker node and one replication for each manager node
- Implement a virtual private cloud housing each worker node on a private subnet, protected by an access-control list. Create a private container registry to deploy new updates across the swarm
- Harden the reverse proxy at the application layer by implementing two-stage rate limiting, a content security policy, and a custom bot blocking configuration
