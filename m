From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 7 May 2020 10:12:39 +0200
Subject: [LTP] [PATCH] pty04: Correct struct member sizes and add to CVE
 runtest file
In-Reply-To: <20200506170407.5562-1-rpalethorpe@suse.com>
References: <20200506170407.5562-1-rpalethorpe@suse.com>
Message-ID: <20200507081239.GA20239@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

...
> +++ b/runtest/cve
> @@ -50,3 +50,4 @@ cve-2018-1000199 ptrace08
>  cve-2018-1000204 ioctl_sg01
>  cve-2018-18559 bind06
>  cve-2018-19854 crypto_user01
> +cve-2020-11494 pty04
BTW Also Jan was proposing to disable test in runtest.

But it'd be great to fix that before release, so I'm ok to take merge it (we can
disable it in both pty and cve runtest files just before release).

Kind regards,
Petr
