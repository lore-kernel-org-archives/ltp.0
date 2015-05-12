Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ys8G4-0005YV-LR
	for ltp-list@lists.sourceforge.net; Tue, 12 May 2015 11:21:56 +0000
Date: Tue, 12 May 2015 13:21:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150512112118.GA6526@rei.suse.de>
References: <1431065595-23843-1-git-send-email-ramya@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1431065595-23843-1-git-send-email-ramya@linux.vnet.ibm.com>
Subject: Re: [LTP] test_fs_bind.sh testcase fails to clean up files which it
 had created during the first run
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
To: ramya@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

Hi!
> Description:
> when we run the script for the first time, all the test will run successfully and PASS .
> but on the same machine if we run the same script for the 2nd time we see TBROK .
> 
> TBROK was seen because the script was not cleaning the files it created during the first run.
> so added TWARN "did not properly clean up files" and then removing the files and continuing with the test .
> 
> Signed-off-by: ramya BS <ramya@linux.vnet.ibm.com>
> ---
>  testscripts/test_fs_bind.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testscripts/test_fs_bind.sh b/testscripts/test_fs_bind.sh
> index 792fff2..348f320 100755
> --- a/testscripts/test_fs_bind.sh
> +++ b/testscripts/test_fs_bind.sh
> @@ -343,8 +343,8 @@ save_sandbox()
>  
>  	if [ -e "$2/files.before" ]; then
>  		if [ -e "$2/files.after" ]; then
> -			tst_brkm TBROK true "${tname}: stale catalog of \"${sandbox}\""
> -			return 1
> +			tst_resm TWARN true "${tname}: did not properly clean up files"
> +                        rm -f "$2/files.after" 

The second line is indented by spaces while the rest of the file uses
tabs, be consistent and use tabs as well. It also ends with trailing
whitespace, which should be removed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
