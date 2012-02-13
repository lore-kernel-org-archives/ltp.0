Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1RwwmK-0003uw-Ka
	for ltp-list@lists.sourceforge.net; Mon, 13 Feb 2012 14:21:16 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1RwwmE-00015Q-TI
	for ltp-list@lists.sourceforge.net; Mon, 13 Feb 2012 14:21:16 +0000
Received: by mail-iy0-f175.google.com with SMTP id y12so5289050iab.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 13 Feb 2012 06:21:10 -0800 (PST)
Message-ID: <4F391C27.2040905@casparzhang.com>
Date: Mon, 13 Feb 2012 22:20:23 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <541a69a479af6ba8c2ce0af8ab890851dfed4caa.1329113234.git.zliu@redhat.com>
	<1cf48238f2cc23c9e93310ca22617296cb8a8f51.1329113234.git.zliu@redhat.com>
In-Reply-To: <1cf48238f2cc23c9e93310ca22617296cb8a8f51.1329113234.git.zliu@redhat.com>
Subject: Re: [LTP] [PATCH] mem/tunable: new testcase about max_map_count
	tunable
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

On 02/13/2012 02:18 PM, Zhouping Liu wrote:
> 
> The program is designed to test max_map_count tunable file
> 
> The kernel Documentation say that:
> /proc/sys/vm/max_map_count contains the maximum number of memory map
> areas a process may have. Memory map areas are used as a side-effect
> of calling malloc, directly by mmap and mprotect, and also when
> loading shared libraries.
> 
> Each process has his own maps file: /proc/[pid]/maps, and each line
> indicates a map entry, so it can caculate the amount of maps by reading
> the file lines' number to check the tunable performance.
> 
> The program trys to invoke mmap() endless until triggering MAP_FAILED,
> then read the process's maps file /proc/[pid]/maps, save the line number
> to map_count variable, and compare it with /proc/sys/vm/max_map_count,
> map_count should less than max_map_count.
> Note: There are two special vmas VDSO and VSYSCALL, which are allocated
> via install_special_mapping(), install_specail_mapping() allows the VMAs
> to be allocated and inserted without checking the sysctl_map_map_count,
> and each /proc/<pid>/maps has both at the end:
> ...
> ...
> 7fff7b9ff000-7fff7ba00000 r-xp 00000000 00:00 0           [vdso]
> ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0   [vsyscall]
> 
> so during comparing with map_count and /proc/sys/vm/max_map_count,
> we should except the two special vmas from map_count:
> map_count -= 2;
> 
> While most applications need less than a thousand maps, and the tunable
> default value is 65530.
> When the value is too large or too little, the system would hang, so I
> choose four special value to test, which can coverage most situation:
> a) Default value / 100
> b) Default value / 10
> c) Default value
> d) Default value * 10
> 
> Signed-off-by: Zhouping Liu <zliu@redhat.com>
> ---
>  runtest/mm                                   |    2 +
>  testcases/kernel/mem/tunable/max_map_count.c |  197 ++++++++++++++++++++++++++
>  2 files changed, 199 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/mem/tunable/max_map_count.c
> 

Acked-by: Caspar Zhang <caspar@casparzhang.com>


------------------------------------------------------------------------------
Try before you buy = See our experts in action!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-dev2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
