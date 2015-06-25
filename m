Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Z84zE-0002OE-HX
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 11:06:28 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Z84zC-0001WK-4f
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 11:06:28 +0000
Message-ID: <1435230494.10891.6.camel@G08FNSTD140232.g08.fujitsu.local>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Thu, 25 Jun 2015 19:08:14 +0800
In-Reply-To: <94d1ed7d81ae24abe9ae8a8d4a8ef8b5e6e78f66.1435223906.git.jstancek@redhat.com>
References: <94d1ed7d81ae24abe9ae8a8d4a8ef8b5e6e78f66.1435223906.git.jstancek@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] getrandom: fix compilation with older kernels
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

Test in RHEL6 and RHEL7. All looks good to me.
------------------------------------------------------------------------------------------------
[root@RHEL6 getrandom]# ./getrandom01 
getrandom01    1  TCONF  :  getrandom01.c:69: GRND_NONBLOCK / GRND_RANDOM not defined
getrandom01    2  TCONF  :  getrandom01.c:69: Remaining cases not appropriate for configuration
[root@RHEL6 getrandom]# ./getrandom02 
getrandom02    1  TCONF  :  getrandom02.c:107: GRND_NONBLOCK / GRND_RANDOM not defined
getrandom02    2  TCONF  :  getrandom02.c:107: Remaining cases not appropriate for configuration
[root@RHEL6 getrandom]# ./getrandom03 
getrandom03    1  TCONF  :  getrandom03.c:54: syscall __NR_getrandom not supported on your arch
getrandom03    2  TCONF  :  getrandom03.c:54: Remaining cases not appropriate for configuration
[root@RHEL6 getrandom]# ./getrandom04 
getrandom04    1  TCONF  :  getrandom04.c:54: syscall __NR_getrandom not supported on your arch
getrandom04    2  TCONF  :  getrandom04.c:54: Remaining cases not appropriate for configuration
------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
[root@RHEL7 getrandom]# ./getrandom01 
getrandom01    1  TCONF  :  getrandom01.c:69: GRND_NONBLOCK / GRND_RANDOM not defined
getrandom01    2  TCONF  :  getrandom01.c:69: Remaining cases not appropriate for configuration
[root@RHEL7 getrandom]# ./getrandom02
getrandom02    1  TCONF  :  getrandom02.c:107: GRND_NONBLOCK / GRND_RANDOM not defined
getrandom02    2  TCONF  :  getrandom02.c:107: Remaining cases not appropriate for configuration
[root@RHEL7 getrandom]# ./getrandom03 
getrandom03    1  TCONF  :  getrandom03.c:54: syscall __NR_getrandom not supported on your arch
getrandom03    2  TCONF  :  getrandom03.c:54: Remaining cases not appropriate for configuration
[root@RHEL7 getrandom]# ./getrandom04
getrandom04    1  TCONF  :  getrandom04.c:54: syscall __NR_getrandom not supported on your arch
getrandom04    2  TCONF  :  getrandom04.c:54: Remaining cases not appropriate for configuration
------------------------------------------------------------------------------------------------

Thanks,
Zeng


On Thu, 2015-06-25 at 11:23 +0200, Jan Stancek wrote:
> Add configure check for GRND_* defines
> Add getrandom to syscalls number list for common architectures
> Replace syscall with ltp_syscall
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  configure.ac                                      |  1 +
>  m4/ltp-getrandom.m4                               | 25 +++++++++++++++++
>  testcases/kernel/include/arm.in                   |  1 +
>  testcases/kernel/include/i386.in                  |  1 +
>  testcases/kernel/include/ia64.in                  |  1 +
>  testcases/kernel/include/linux_syscall_numbers.h  | 27 ++++++++++++++++++
>  testcases/kernel/include/powerpc.in               |  1 +
>  testcases/kernel/include/powerpc64.in             |  1 +
>  testcases/kernel/include/regen.sh                 |  2 +-
>  testcases/kernel/include/s390.in                  |  1 +
>  testcases/kernel/include/s390x.in                 |  1 +
>  testcases/kernel/include/x86_64.in                |  1 +
>  testcases/kernel/syscalls/getrandom/getrandom01.c | 34 +++++++++++++----------
>  testcases/kernel/syscalls/getrandom/getrandom02.c | 30 ++++++++++++--------
>  testcases/kernel/syscalls/getrandom/getrandom03.c | 11 ++------
>  testcases/kernel/syscalls/getrandom/getrandom04.c | 13 ++-------
>  16 files changed, 105 insertions(+), 46 deletions(-)
>  create mode 100644 m4/ltp-getrandom.m4



------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
