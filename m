From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 22 Mar 2018 18:34:58 +0100
Subject: [LTP] [PATCH] cve: new regression test-case for CVE-2018-5803
In-Reply-To: <a26d2a06-429a-b0dd-995a-c01dbb7a4718@oracle.com>
References: <1520872613-30423-1-git-send-email-alexey.kodanev@oracle.com>
 <20180320140051.mxh5mqndc4gp72og@dell5510>
 <a26d2a06-429a-b0dd-995a-c01dbb7a4718@oracle.com>
Message-ID: <20180322173458.mcpm3jikk57rkhrr@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > LGTM.
> > Tested-by: Petr Vorel <pvorel@suse.cz>
> > Found one BROK on EINVAL on setsockopt(), most of older kernels in VM don't crash, bug generate
> > heavy load.

> Does it happen with a single address parameter? We could also lower parameter
> size in the second test, e.g. from 10000 to 4000.
I didn't notice before that it actually calls BUG() in skb_put(), test does not end.
Adding -a 4000 does not help.

> Also change SOCK_STREAM to SOCK_SEQPACKET

> diff --git a/testcases/cve/cve-2018-5803.c b/testcases/cve/cve-2018-5803.c
> index 3f03d8a..6bee914 100644
> --- a/testcases/cve/cve-2018-5803.c
> +++ b/testcases/cve/cve-2018-5803.c
> @@ -63,7 +63,7 @@ static void setup_client(void)
>         struct sockaddr_in6 addr_buf[addr_num];
>         int i;

> -       cfd = SAFE_SOCKET(AF_INET6, SOCK_STREAM, IPPROTO_SCTP);
> +       cfd = SAFE_SOCKET(AF_INET6, SOCK_SEQPACKET, IPPROTO_SCTP);
>         rmt.sin6_family = AF_INET6;
>         rmt.sin6_addr = in6addr_loopback;
>         rmt.sin6_port = htons(port);


> I could also add IPv4 version...
I have no idea if it's useful.

> Thanks,
> Alexey


Kind regards,
Petr
