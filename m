Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TU6Ye-0003Sv-Rd
	for ltp-list@lists.sourceforge.net; Fri, 02 Nov 2012 02:00:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TU6Yd-0005Di-Pw
	for ltp-list@lists.sourceforge.net; Fri, 02 Nov 2012 02:00:28 +0000
Message-ID: <5093294D.3030202@cn.fujitsu.com>
Date: Fri, 02 Nov 2012 10:00:45 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1351256774.git.jstancek@redhat.com>
	<89a0734ced2f62af05e4d3c9aee853950d5ab848.1351256774.git.jstancek@redhat.com>
In-Reply-To: <89a0734ced2f62af05e4d3c9aee853950d5ab848.1351256774.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v3 2/3] new syscall test: migrate_pages01
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 10/26/2012 09:31 PM, Jan Stancek wrote:
> errno tests for migrate_pages(2).
> Note, that older kernels (~2.6.18) are likely to panic during this test.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  runtest/syscalls                                   |    2 +
>  testcases/kernel/syscalls/.gitignore               |    1 +
>  testcases/kernel/syscalls/migrate_pages/Makefile   |   32 +++
>  .../syscalls/migrate_pages/migrate_pages01.c       |  280 ++++++++++++++++++++
>  .../syscalls/migrate_pages/migrate_pages_common.c  |   62 +++++
>  .../syscalls/migrate_pages/migrate_pages_common.h  |   33 +++
>  6 files changed, 410 insertions(+), 0 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/migrate_pages/Makefile
>  create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
>  create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages_common.c
>  create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h

Pushed with Zhouping's Reviewed-by, thank you.

Wanlong Gao


------------------------------------------------------------------------------
LogMeIn Central: Instant, anywhere, Remote PC access and management.
Stay in control, update software, and manage PCs from one command center
Diagnose problems and improve visibility into emerging IT issues
Automate, monitor and manage. Do more in less time with Central
http://p.sf.net/sfu/logmein12331_d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
