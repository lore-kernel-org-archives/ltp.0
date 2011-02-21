Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <lizf@cn.fujitsu.com>) id 1PrQQ1-00082B-MO
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 07:42:53 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1PrQPz-0002zY-Oz
	for ltp-list@lists.sourceforge.net; Mon, 21 Feb 2011 07:42:53 +0000
Message-ID: <4D6217CB.1040506@cn.fujitsu.com>
Date: Mon, 21 Feb 2011 15:44:11 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
References: <20110210072315.GA7909@hpt.nay.redhat.com>
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
To: Han Pingtian <phan@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Han Pingtian wrote:
> It seems we need echo -1 to set_ftrace_pid to disable in. Or we'll get
> these error message when running ftrace_stress:
> 

kernel version?

This is the result from latest kernel:

# echo > set_ftrace_pid
# echo -1 > set_ftrace_pid
bash: echo: write error: Invalid argument

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
