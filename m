From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 11 May 2021 14:21:15 +0200
Subject: [LTP] [PATCH] bugfix for network/lib6/getaddrinfo_01.c
In-Reply-To: <20210511091630.23257-1-dongshijiang@inspur.com>
References: <20210511091630.23257-1-dongshijiang@inspur.com>
Message-ID: <YJp2u+lUy9VMq9Wb@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

[ Cc: Alexey, Martin and Cyril ]

> For test cases (test2 ,IPV4 canonical name) and (test13 ,IPV6 canonical name)

> The gethostname() API returns the official name of host, not the canonical name of host.
> The canonical name of host needs to be obtained through the gethostbyname() API;

Yes, test 2 and 13 fails systems which don't use FQDN as hostname and have DNS records
due mismatch short name and FQDN, e.g.:
getaddrinfo_01    2  TFAIL  :  getaddrinfo_01.c:140: getaddrinfo IPv4 canonical name ("foo.suse.cz") doesn't match hostname ("foo")

It's a bit strange to use deprecated gethostbyname() in getaddrinfo() tests :).
Yes, it's the easiest way to get FQDN instead of just "short" hostname. But
Maybe simple check if we have FQDN with strchr for dot and TCONF it's just short
name would be better.

> Signed-off-by: dongshijiang <dongshijiang@inspur.com>
> ---
>  testcases/network/lib6/getaddrinfo_01.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)

> diff --git a/testcases/network/lib6/getaddrinfo_01.c b/testcases/network/lib6/getaddrinfo_01.c
> index db252a998..bf5af7b4a 100644
> --- a/testcases/network/lib6/getaddrinfo_01.c
> +++ b/testcases/network/lib6/getaddrinfo_01.c
> @@ -75,6 +75,14 @@ static void gaiv4(void)
>  	if (gethostname(hostname, sizeof(hostname)) < 0)
>  		tst_brkm(TBROK | TERRNO, NULL, "gethostname failed");
>  	strncpy(shortname, hostname, MAXHOSTNAMELEN);
> +
> +	//get official name of host
Useless comment.

> +	struct hostent *phostent = NULL;
This should go below other struct definitions, IMHO can be without NULL.
> +
> +	phostent = gethostbyname(hostname);
> +	if (phostent == NULL)
> +		tst_brkm(TBROK | TERRNO, NULL, "gethostbyname failed");
> +
>  	shortname[MAXHOSTNAMELEN] = '\0';
>  	p = strchr(shortname, '.');
>  	if (p)
> @@ -134,10 +142,10 @@ static void gaiv4(void)
>  				 "entries with canonical name set");
>  			freeaddrinfo(aires);
>  			return;
> -		} else if (strcasecmp(hostname, pai->ai_canonname)) {
> +		} else if (strcasecmp(phostent->h_name, pai->ai_canonname)) {
>  			tst_resm(TFAIL, "getaddrinfo IPv4 canonical name "
>  				 "(\"%s\") doesn't match hostname (\"%s\")",
> -				 pai->ai_canonname, hostname);
> +				 pai->ai_canonname, phostent->h_name);
>  			freeaddrinfo(aires);
>  			return;
>  		}
> @@ -533,6 +541,14 @@ static void gaiv6(void)
>  	if (gethostname(hostname, sizeof(hostname)) < 0)
>  		tst_brkm(TBROK, NULL, "gethostname failed - %s",
>  			 strerror(errno));
> +
> +	//get official name of host
> +	struct hostent *phostent = NULL;
The same here.
> +
> +	phostent = gethostbyname(hostname);
> +	if (phostent == NULL)
> +		tst_brkm(TBROK | TERRNO, NULL, "gethostbyname failed");
> +
>  	strncpy(shortname, hostname, MAXHOSTNAMELEN);
>  	shortname[MAXHOSTNAMELEN] = '\0';
>  	p = strchr(shortname, '.');
> @@ -593,10 +609,10 @@ static void gaiv6(void)
>  				 "entries with canonical name set");
>  			freeaddrinfo(aires);
>  			return;
> -		} else if (strcasecmp(hostname, pai->ai_canonname)) {
> +		} else if (strcasecmp(phostent->h_name, pai->ai_canonname)) {
>  			tst_resm(TFAIL, "getaddrinfo IPv6 canonical name "
>  				 "(\"%s\") doesn't match hostname (\"%s\")",
> -				 pai->ai_canonname, hostname);
> +				 pai->ai_canonname, phostent->h_name);
>  			freeaddrinfo(aires);
>  			return;
>  		}

FYI Workaround on systems which do not have DNS record is to use /etc/fstab.
We should document in testcases/network/README.md that when using /etc/fstab,
well recommended order FQDN and *then* short name is required, e.g.:
::1 foo.suse.cz foo

Other setup fails, e.g.:
::1 foo
::1 foo foo.suse.cz

leads to error:
getaddrinfo_01   13  TFAIL  :  getaddrinfo_01.c:611: getaddrinfo IPv6 canonical name ("foo") doesn't match hostname ("foo.suse.cz")

and setup:
::1 foo.suse.cz

leads to
getaddrinfo_01   12  TFAIL  :  getaddrinfo_01.c:594: getaddrinfo IPv6 basic lookup ("foo") returns -5 ("No address associated with hostname")

The best would be if the test checked the correct setup itself
but not sure how do it to not complicate this test too much.
I guess during rewrite of this test we might decide to split it.

Other TODO (not related to this patch:
e.g.: it fails when there no DNS record nor records in /etc/hosts:

getaddrinfo_01    1  TFAIL  :  getaddrinfo_01.c:117: getaddrinfo IPv4 basic lookup ("myhost") returns -2 ("Name or service not known")
...
getaddrinfo_01   12  TFAIL  :  getaddrinfo_01.c:599: getaddrinfo IPv6 basic lookup ("myhost") returns -2 ("Name or service not known")

Any distro installer should add them, but I guess we should TCONF in this case.

or when there is DNS A record, but not AAAA: 
getaddrinfo_01   12  TFAIL  :  getaddrinfo_01.c:596: getaddrinfo IPv6 basic lookup ("myhost.suse.cz") returns -5 ("No address associated with hostname")

During rewriting to new API test would deserve cleanup, e.g.
remove duplicity in gaiv4() and gaiv6() (getaddrinfo() can deal with IPv4
and IPv6 in a nice way through hints, see safe_getaddrinfo()).

Kind regards,
Petr
