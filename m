From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 7 May 2018 10:09:00 +0200
Subject: [LTP] [PATCH 1/3] lib/tst_net.sh: Append 6 to the end of
	$TST_OPTS
In-Reply-To: <5AF000B1.9070106@cn.fujitsu.com>
References: <1525663451-32016-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180507064343.ahqhsbadjpho2xry@dell5510>
 <5AF000B1.9070106@cn.fujitsu.com>
Message-ID: <20180507080900.4ebs7f3vysql7wpv@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xiao,

> > Good catch. Although I propose to get rid of ':' at the beginning for users of new shell
> > API (as it's IMHO better to see errors).
> Hi Petr,

> If getopts is in silent mode,  the invalid option is  placed  in OPTARG, so
> we can see errors by printing
> the value of OPTARG.  But it is reasonable for me to get rid of ':' at the
> beginning of optstring. :-)
I know, TBROK inform us, so it can stay how it is for legacy API.
I meant it for the new API, where is going to be removed (the TBROK as well) as error is
handled in tst_run in tst_test.sh.

> Thanks,
> Xiao Yang


Kind regards,
Petr Vorel
