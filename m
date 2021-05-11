From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 May 2021 15:47:50 +0200
Subject: [LTP] [PATCH] bugfix for network/lib6/getaddrinfo_01.c
In-Reply-To: <d1dc697b-f73a-3be4-c5df-151aae021265@oracle.com>
References: <20210511091630.23257-1-dongshijiang@inspur.com>
 <YJp2u+lUy9VMq9Wb@pevik>
 <d1dc697b-f73a-3be4-c5df-151aae021265@oracle.com>
Message-ID: <YJqLBoT36RG1Icon@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

thank you for your input!

> >> For test cases (test2 ,IPV4 canonical name) and (test13 ,IPV6 canonical name)

> >> The gethostname() API returns the official name of host, not the canonical name of host.
> >> The canonical name of host needs to be obtained through the gethostbyname() API;

> > Yes, test 2 and 13 fails systems which don't use FQDN as hostname and have DNS records
> > due mismatch short name and FQDN, e.g.:
> > getaddrinfo_01    2  TFAIL  :  getaddrinfo_01.c:140: getaddrinfo IPv4 canonical name ("foo.suse.cz") doesn't match hostname ("foo")

> > It's a bit strange to use deprecated gethostbyname() in getaddrinfo() tests :).

> Yeah, gethostbyname() is obsolete, we shouldn't compare both here,
> i.e. getaddrinfo() vs gethostbyname()...

> > Yes, it's the easiest way to get FQDN instead of just "short" hostname. But
> > Maybe simple check if we have FQDN with strchr for dot and TCONF it's just short
> > name would be better.

> +1, and instead of TCONF we could check the "shortname" that
> we pass to getaddrinfo():
shortname variable always contains "short name" (obviously).
But with correct configuration (e.g. search example.com in /etc/resolv.conf for
DNS or valid IP setup ADDR foo.suse.cz foo in /etc/hosts) it works.
The problem is really with value we use to check the result (i.e. now hostname).

> >>  	shortname[MAXHOSTNAMELEN] = '\0';
> >>  	p = strchr(shortname, '.');
> >>  	if (p)

> ...

> > FYI Workaround on systems which do not have DNS record is to use /etc/fstab.
> > We should document in testcases/network/README.md that when using /etc/fstab,

> /etc/hosts

Lol, sorry :)


Kind regards,
Petr
