Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YqM5c-0003OR-M7
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 13:43:48 +0000
Date: Thu, 7 May 2015 15:43:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150507134313.GH28637@rei.suse.de>
References: <5549F751.3070503@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5549F751.3070503@linux.vnet.ibm.com>
Subject: Re: [LTP] test_fs_bind.sh testcase fails to clean up files which it
 had created during the first run .
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
To: Ramya <ramya@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>   testscripts/test_fs_bind.sh |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testscripts/test_fs_bind.sh b/testscripts/test_fs_bind.sh
> index 792fff2..348f320 100755
> --- a/testscripts/test_fs_bind.sh
> +++ b/testscripts/test_fs_bind.sh
> @@ -343,8 +343,8 @@ save_sandbox()
> 
>       if [ -e "$2/files.before" ]; then
>           if [ -e "$2/files.after" ]; then
> -            tst_brkm TBROK true "${tname}: stale catalog of 
> \"${sandbox}\""
> -            return 1
> +            tst_resm TWARN true "${tname}: did not properly clean up 
> files"
> +                        rm -f "$2/files.after"
>           fi
>           when="after"
>       fi

Your patch was mangled, possibly line wrapped by your mail client.

Configure your mail client correctly or use git send-email and resend.

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
