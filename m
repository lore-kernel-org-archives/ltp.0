Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <phan@redhat.com>) id 1PrQGv-0007cX-Vc
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 07:33:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PrQGs-0008Bq-R7
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 07:33:27 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p1L7XLfY020536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Feb 2011 02:33:21 -0500
Received: from hpt.nay.redhat.com (dhcp-65-65.nay.redhat.com [10.66.65.65])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id p1L7XIar009328
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Feb 2011 02:33:20 -0500
Received: from hpt.nay.redhat.com (localhost.localdomain [127.0.0.1])
	by hpt.nay.redhat.com (8.14.4/8.14.4) with ESMTP id p1L7bKLs009080
	for <ltp-list@lists.sourceforge.net>; Mon, 21 Feb 2011 15:37:20 +0800
Received: (from hpt@localhost)
	by hpt.nay.redhat.com (8.14.4/8.14.4/Submit) id p1L7bJ4k009078
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 15:37:19 +0800
Date: Mon, 21 Feb 2011 15:37:19 +0800
From: Han Pingtian <phan@redhat.com>
Message-ID: <20110221073719.GE2904@hpt.nay.redhat.com>
References: <20110210072315.GA7909@hpt.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110210072315.GA7909@hpt.nay.redhat.com>
Subject: Re: [LTP] [PATCH] Fix disable set_ftrace_pid in
 ftrace_set_ftrace_pid.sh
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
To: ltp-list@lists.sourceforge.net

Hello, 

Any comments to this patch?

Thanks.
On Thu, Feb 10, 2011 at 03:23:15PM +0800, Han Pingtian wrote:
> It seems we need echo -1 to set_ftrace_pid to disable in. Or we'll get
> these error message when running ftrace_stress:
> 
> ...
> ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh: line 39: echo: write error: Invalid argument
> ...
> ---
>  .../ftrace_stress/ftrace_set_ftrace_pid.sh         |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> index 541215c..bd08f04 100755
> --- a/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> +++ b/testcases/kernel/tracing/ftrace_stress_test/ftrace_stress/ftrace_set_ftrace_pid.sh
> @@ -36,7 +36,7 @@ for ((; ; ))
>  			eval echo $str >> "$TRACING_PATH"/set_ftrace_pid
>  		}
>  
> -		echo > "$TRACING_PATH"/set_ftrace_pid
> +		echo -1 > "$TRACING_PATH"/set_ftrace_pid
>  	}
>  
>  	sleep 1
> -- 
> 1.7.1
> 
> ------------------------------------------------------------------------------
> The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
> Pinpoint memory and threading errors before they happen.
> Find and fix more than 250 security defects in the development cycle.
> Locate bottlenecks in serial and parallel code that limit performance.
> http://p.sf.net/sfu/intel-dev2devfeb
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Han Pingtian
Quality Engineer
hpt @ #kernel-qe
Red Hat, Inc
Freedom ... courage ... Commitment ... ACCOUNTABILITY

------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
