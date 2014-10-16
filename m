Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Xek5k-0007jF-Uv
	for ltp-list@lists.sourceforge.net; Thu, 16 Oct 2014 12:23:40 +0000
Date: Thu, 16 Oct 2014 14:23:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141016122318.GD20676@rei.suse.de>
References: <1409480940.6575.1.camel@G08JYZSD130126>
	<1411638835.24531.2.camel@G08JYZSD130126>
	<20140930122027.GB9190@rei.suse.cz>
	<1412659252.2433.19.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1412659252.2433.19.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [PATCH v2 4/4] multicast/mc_opts: Some cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> * Delete trace_logic that is used to debug.
> * Use test.sh script and use tst_* instead of end_testcase.
> * Delete some unuseful comments.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/network/multicast/mc_opts/mc_opts  | 164 ++++++---------------------
>  testcases/network/multicast/mc_opts/opts.c   |   7 +-
>  testcases/network/multicast/mc_opts/opts_e.c |   6 +-
>  3 files changed, 37 insertions(+), 140 deletions(-)
> 
> diff --git a/testcases/network/multicast/mc_opts/mc_opts b/testcases/network/multicast/mc_opts/mc_opts
> index f40112c..7e99733 100755
> --- a/testcases/network/multicast/mc_opts/mc_opts
> +++ b/testcases/network/multicast/mc_opts/mc_opts
> @@ -35,142 +35,46 @@ unset LIBPATH
>  #      -Ported
>  #
>  #******************************************************************************
> -#Uncomment the line below for debug output.
> -#trace_logic=${trace_logic:-"set -x"}
> -$trace_logic
>  
> -if [ -z $LTPBIN ]; then
> -  PATH=../../../bin/:./:$PATH
> -fi
>  TC=mc_opts
> -TCtmp=${TCtmp:-$LTPROOT/bin/$TC$$}
> -CLEANUP=${CLEANUP:-ON}
>  EXECUTABLES=${EXECUTABLES:-"opts opts_e"}

The same applies here, it should for example be: mc_opts_helper and
mc_opts_e_helper.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://p.sf.net/sfu/Zoho
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
