From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 9 Sep 2020 21:51:47 +0200
Subject: [LTP] [PATCH] route{4,
 6}-rmmod: Declare variables before using them
In-Reply-To: <1599555370-11375-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1599555370-11375-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <20200909195147.GA27395@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Feiyu,

> When running route4-rmmod case, it reports the following error:
> /opt/ltp/testcases/bin/route4-rmmod: line 100: lhost_module: unbound variable.

> It fails because "set -u" is used in .testcases/lib/cmdlib.sh and
> "set -u" treats unset variables and parameters as errors.

Right, this is the only reason to take these patches.
Because these patches wait for rewrite, see
https://github.com/linux-test-project/ltp/issues/310

Reviewed-by: Petr Vorel <pvorel@suse.cz>

>  testcases/network/stress/route/route4-rmmod | 3 +++
>  testcases/network/stress/route/route6-rmmod | 3 +++
>  2 files changed, 6 insertions(+)

> diff --git a/testcases/network/stress/route/route4-rmmod b/testcases/network/stress/route/route4-rmmod
> index 5947bb3..e449cc7 100644
> --- a/testcases/network/stress/route/route4-rmmod
> +++ b/testcases/network/stress/route/route4-rmmod
> @@ -125,6 +125,9 @@ do_setup()
>  	exit $TST_TOTAL
>      fi

> +    # The module name of the interface at the local host
> +    lhost_module=""

I'd prefer
       lhost_module=
> +
>      # Make sure to clean up
>      do_cleanup

> diff --git a/testcases/network/stress/route/route6-rmmod b/testcases/network/stress/route/route6-rmmod
> index 73f26f2..ffd09bd 100644
> --- a/testcases/network/stress/route/route6-rmmod
> +++ b/testcases/network/stress/route/route6-rmmod
> @@ -121,6 +121,9 @@ do_setup()
>  	exit $TST_TOTAL
>      fi

> +    # The module name of the interface at the local host
> +    lhost_module=""
And obviously here as well.

> +
>      # Make sure to clean up
>      do_cleanup

Kind regards,
Petr
