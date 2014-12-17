Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Y19c9-0004MQ-KC
	for ltp-list@lists.sourceforge.net; Wed, 17 Dec 2014 08:05:45 +0000
Date: Wed, 17 Dec 2014 09:05:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141217080523.GA23215@rei>
References: <1418780643.28978.64.camel@G08JYZSD130126.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1418780643.28978.64.camel@G08JYZSD130126.localdomain>
Subject: Re: [LTP] [REPORT] fs_perms.c issue
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
> I have test fs_perms in the latest version, but output:
> "Segmentation fault"
> In commit 9fa8ad01f33c6390cc08626a185111631c8df495
> -------------------------------------------------------------------------------------
> -       tst_resm((exp_res == res1) && res2 ? TPASS : TFAIL,
> -                "%c a %03o file owned by (%d/%d) as user/group (%d/%d)",
> +       tst_brkm((exp_res == res1) && res2 ? TPASS : TFAIL,
> +                tst_rmdir, "%c a %03o file owned by (%d/%d) as user/group (%d/%d)",
>                  fperm[0], fmode, fuser_id, fgroup_id, user_id, group_id);
> -
> -       tst_rmdir();
> -       tst_exit();
> -------------------------------------------------------------------------------------
> TPASS should not be return from tst_brkm. We should use tst_resm still.

Right, I've missed that in the automatic cleanup. Will fix ASAP.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
