From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Nov 2017 23:50:38 +0100
Subject: [LTP] network/stress/ltp_net_stress_ipsec_tcp: problems with IP
 Payload Compression (comp) transform protocol on VTI
Message-ID: <20171109225038.iwrgxdt3qgeeg4sm@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

I'm trying to debug problems with IP Payload Compression (comp) transform protocol on VTI.
I.e. tcp4_ipsec_vti03 and tcp6_ipsec_vti03 tests:
tcp4_ipsec_vti03 tcp_ipsec_vti.sh -p comp -m tunnel -s "100 1000 65535"
tcp6_ipsec_vti03 tcp_ipsec_vti.sh -6 -p comp -m tunnel -s "100 1000 65535"

netstress server gets killed after calling accept():

write(2, "netstress.c:659: \33[1;34mINFO: \33["..., 106) = 106
socket(AF_INET6, SOCK_STREAM, IPPROTO_IP) = 6
setsockopt(6, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
write(2, "netstress.c:579: \33[1;34mINFO: \33["..., 75) = 75
bind(6, {sa_family=AF_INET6, sin6_port=htons(27102), inet_pton(AF_INET6, "::", &sin6_addr), sin6_flowinfo=htonl(0), sin6_scope_id=0}, 28) = 0
listen(6, 100)                    = 0
write(2, "netstress.c:595: \33[1;34mINFO: \33["..., 73) = 73
getpid()                          = 2127
accept(6,  <unfinished ...>
<... wait4 resumed> <unfinished ...>) = ?
+++ killed by SIGKILL +++
<... accept resumed> <unfinished ...>) = ?
+++ killed by SIGKILL +++

Any idea what can cause it? Tests tcp{4,6}_ipsec_vti02 running with esp protocol on VTI
work well.


Kind regards,
Petr
