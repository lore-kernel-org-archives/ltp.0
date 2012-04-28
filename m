Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SO5xj-0001Ur-AY
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 11:37:15 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SO5xg-0001aK-Vm
	for ltp-list@lists.sourceforge.net; Sat, 28 Apr 2012 11:37:15 +0000
Message-ID: <4F9BD61D.8010705@cn.fujitsu.com>
Date: Sat, 28 Apr 2012 19:35:57 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <9f6a3874d522c848218b164f61ff207760ed2b22.1335599279.git.zliu@redhat.com>
In-Reply-To: <9f6a3874d522c848218b164f61ff207760ed2b22.1335599279.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH 1/3] m4/ltp-numa.m4: fixed numa config
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Zhouping Liu <zliu@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

On 04/28/2012 03:48 PM, Zhouping Liu wrote:

> numa_alloc_onnode() and numa_move_pages() all need numa lib '-lnuma',
> but in ltp-numa.m4, we just checked the two functions using
> AC_CHECK_FUNCS, without the patch, it always report such error
> log in numa system: "undefined reference to `numa_alloc_onnode`",
> which blocked syscalls/move_pages/* cases, the patch fixed it.



pushed the series, thanks

Wanlong Gao

> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  m4/ltp-numa.m4 |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/m4/ltp-numa.m4 b/m4/ltp-numa.m4
> index bcc5e6b..d03bc80 100644
> --- a/m4/ltp-numa.m4
> +++ b/m4/ltp-numa.m4
> @@ -26,7 +26,14 @@ AC_DEFUN([LTP_CHECK_SYSCALL_NUMA],
>  [dnl
>  AC_CHECK_HEADERS([linux/mempolicy.h numa.h numaif.h],[
>  	LTP_SYSCALL_NUMA_HEADERS=yes
> -	AC_CHECK_FUNCS(numa_alloc_onnode,numa_move_pages)
> +	AC_CHECK_LIB(numa,numa_alloc_onnode,[have_numa_alloc_onnode="yes"])
> +	if  test "x$have_numa_alloc_onnode" = "xyes"; then
> +		AC_DEFINE(HAVE_NUMA_ALLOC_ONNODE,1,[define to 1 if you have 'numa_alloc_onnode' function])
> +	fi
> +	AC_CHECK_LIB(numa,numa_move_pages,[have_numa_move_pages="yes"])
> +	if  test "x$have_numa_move_pages" = "xyes"; then
> +		AC_DEFINE(HAVE_NUMA_MOVE_PAGES,1,[define to 1 if you have 'numa_move_pages' function])
> +	fi
>  ]
>  	AC_CHECK_LIB(numa,numa_available,[
>  NUMA_CPPFLAGS="-DNUMA_VERSION1_COMPATIBILITY"



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
