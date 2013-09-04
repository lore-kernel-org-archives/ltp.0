Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VHBnR-0002or-BD
	for ltp-list@lists.sourceforge.net; Wed, 04 Sep 2013 12:02:53 +0000
Date: Wed, 4 Sep 2013 14:03:04 +0200
From: chrubis@suse.cz
Message-ID: <20130904120304.GA12344@rei>
References: <521C4688.9020305@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <521C4688.9020305@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2 v2] Check if xfs quota is available
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> 
> Define HAVE_XFS_QUOTA to show if xfs quota is available.
> 
> +AC_DEFUN([LTP_CHECK_XFS_QUOTACTL],[dnl
> +	AC_LINK_IFELSE([AC_LANG_SOURCE([
> +#include <xfs/xqm.h>
> +#include <sys/quota.h>
> +int main(void) {
> +	struct fs_quota_stat qstat;
> +	return quotactl(QCMD(Q_XGETQSTAT, USRQUOTA), "/dev/null", geteuid(),
> +			(caddr_t) &qstat);
> +}])],[has_xfs_quota="yes"])
> +
> +if test "x$has_xfs_quota" = xyes; then
> +	AC_DEFINE(HAVE_XFS_QUOTA,1,[Define to 1 if you have xfs quota])
> +else
> +	AC_MSG_WARN(No xfs quota support)
> +fi
> +])

I've modified this part to print the more standard:

Checking for XFS quota (xfs/xqm.h)...{yes,no}

rather than issuing the warning and commited both patches.

Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn the latest--Visual Studio 2012, SharePoint 2013, SQL 2012, more!
Discover the easy way to master current and previous Microsoft technologies
and advance your career. Get an incredible 1,500+ hours of step-by-step
tutorial videos with LearnDevNow. Subscribe today and save!
http://pubads.g.doubleclick.net/gampad/clk?id=58040911&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
