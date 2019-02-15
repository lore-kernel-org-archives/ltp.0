From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Feb 2019 14:45:42 +0100
Subject: [LTP] [PATCH 2/4] netstress: allow setting MSG_ZEROCOPY for
 other protocols
In-Reply-To: <71eb61bc-4a65-bc35-d039-8b4099256c10@oracle.com>
References: <1549908467-15609-1-git-send-email-alexey.kodanev@oracle.com>
 <1549908467-15609-3-git-send-email-alexey.kodanev@oracle.com>
 <20190214233442.GB12954@x230>
 <71eb61bc-4a65-bc35-d039-8b4099256c10@oracle.com>
Message-ID: <20190215134542.GA30668@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > BTW MSG_ZEROCOPY is enabled only for TCP and UDP, but we allow it to be set on
> > all, which leads to BROK:
> > ./netstress -z -T sctp
> > tst_test.c:1096: INFO: Timeout per run is 0h 05m 00s
> > netstress.c:938: INFO: max requests '3'
> > netstress.c:990: INFO: SCTP server
> > netstress.c:693: INFO: assigning a name to the server socket...
> > netstress.c:700: INFO: bind to port 37196
> > safe_net.c:186: BROK: netstress.c:717: setsockopt(3, 1, 60, 0x7fff155701a4, 4) failed: ???

> This is expected fail, I would keep it.
Agree, other protocols might gain the support one day.

> Hmm, there is no error description. I've checked the errno returned and the
> kernel sources, found that it is actually returning ENOTSUPP(524). I think it
> should rather be EOPNOTSUPP(95), since the error is returned to user-space [1]:

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 6aa2e7e..f6c57de 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -1023,9 +1023,9 @@ int sock_setsockopt(struct socket *sock, int level, int optname,
>                                sk->sk_protocol == IPPROTO_TCP) ||
>                               (sk->sk_type == SOCK_DGRAM &&
>                                sk->sk_protocol == IPPROTO_UDP)))
> -                               ret = -ENOTSUPP;
> +                               ret = -EOPNOTSUPP;
>                 } else if (sk->sk_family != PF_RDS) {
> -                       ret = -ENOTSUPP;
> +                       ret = -EOPNOTSUPP;
>                 }
>                 if (!ret) {
>                         if (val < 0 || val > 1)
Interesting. IMHO it'd make sense to fix it.

> For LTP library: may be we need to return the actual errno if strerror()
> returns nothing?
yes, that'd be useful. Assume you send a patch.

> [1] https://lists.gt.net/linux/kernel/2207071


Kind regards,
Petr
