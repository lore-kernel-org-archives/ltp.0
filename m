From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 18 Nov 2019 15:54:19 +0100
Subject: [LTP] [PATCH v1] travis: add ppc64le and s390x builds (issue:
 #615)
In-Reply-To: <20191118105735.15012-1-cfamullaconrad@suse.de>
References: <20191118105735.15012-1-cfamullaconrad@suse.de>
Message-ID: <20191118145419.GA26714@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Clemens,

thanks a lot!
> Travis started to support ppc64le and s390x
> https://blog.travis-ci.com/2019-11-12-multi-cpu-architecture-ibm-power-ibm-z

> This patch enable ppc64le and s390x build on debian:stable.

> Remove `-i` switch from docker command as it isn't needed and caused
> trouble running docker 'The input device is not a tty'.
Interesting. Indeed, fails with -i. Don't remember, why I needed it.

LGTM, I'd just move these 2 jobs higher (above fedora), as these builds are not
usual so have higher priority to find a bug.
Change ppc64le to to debian:testing (we already have stable build for ppc64le
cross compilation).

Something like: 
https://travis-ci.org/pevik/ltp/builds/613539454
https://github.com/pevik/ltp/commit/2b69957b5838eb9f27e65ba172a71c24f15af6bd
(No need to resend a patch, both can do during merge.)

Kind regards,
Petr
