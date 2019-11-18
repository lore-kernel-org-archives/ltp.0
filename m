From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon, 18 Nov 2019 19:07:29 +0100
Subject: [LTP] [PATCH v1] travis: add ppc64le and s390x builds (issue:
 #615)
In-Reply-To: <20191118145419.GA26714@dell5510>
References: <20191118105735.15012-1-cfamullaconrad@suse.de>
 <20191118145419.GA26714@dell5510>
Message-ID: <1574100449.4879.2.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Mon, 2019-11-18 at 15:54 +0100, Petr Vorel wrote:
<snip>
> 
> LGTM, I'd just move these 2 jobs higher (above fedora), as these
> builds are not
> usual so have higher priority to find a bug.
> Change ppc64le to to debian:testing (we already have stable build for
> ppc64le
> cross compilation).

Makes sense
> 
> Something like: 
> https://travis-ci.org/pevik/ltp/builds/613539454
> https://github.com/pevik/ltp/commit/2b69957b5838eb9f27e65ba172a71c24f
> 15af6bd
> (No need to resend a patch, both can do during merge.)

Thanks a lot
looks good to me as well.
