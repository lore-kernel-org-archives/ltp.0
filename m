From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 10 Nov 2017 18:01:11 +0300
Subject: [LTP] network/stress/ltp_net_stress_ipsec_tcp: problems with IP
 Payload Compression (comp) transform protocol on VTI
In-Reply-To: <20171109225038.iwrgxdt3qgeeg4sm@dell5510>
References: <20171109225038.iwrgxdt3qgeeg4sm@dell5510>
Message-ID: <760c45ad-6802-400d-c527-818d599ffa12@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/10/2017 01:50 AM, Petr Vorel wrote:
> Hi Alexey,
>
> I'm trying to debug problems with IP Payload Compression (comp) transform protocol on VTI.
> I.e. tcp4_ipsec_vti03 and tcp6_ipsec_vti03 tests:
> tcp4_ipsec_vti03 tcp_ipsec_vti.sh -p comp -m tunnel -s "100 1000 65535"
> tcp6_ipsec_vti03 tcp_ipsec_vti.sh -6 -p comp -m tunnel -s "100 1000 65535"
>
> netstress server gets killed after calling accept():
>
> write(2, "netstress.c:659: \33[1;34mINFO: \33["..., 106) = 106
> socket(AF_INET6, SOCK_STREAM, IPPROTO_IP) = 6
> setsockopt(6, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
> write(2, "netstress.c:579: \33[1;34mINFO: \33["..., 75) = 75
> bind(6, {sa_family=AF_INET6, sin6_port=htons(27102), inet_pton(AF_INET6, "::", &sin6_addr), sin6_flowinfo=htonl(0), sin6_scope_id=0}, 28) = 0
> listen(6, 100)                    = 0
> write(2, "netstress.c:595: \33[1;34mINFO: \33["..., 73) = 73
> getpid()                          = 2127
> accept(6,  <unfinished ...>
> <... wait4 resumed> <unfinished ...>) = ?
> +++ killed by SIGKILL +++
> <... accept resumed> <unfinished ...>) = ?
> +++ killed by SIGKILL +++
>
> Any idea what can cause it? Tests tcp{4,6}_ipsec_vti02 running with esp protocol on VTI
> work well.

Server killed by LTP timeout in this case, looks like there
is no incoming connections... I'll take a look.

Thanks,
Alexey

