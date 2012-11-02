Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TU6aY-00060O-Gs
	for ltp-list@lists.sourceforge.net; Fri, 02 Nov 2012 02:02:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TU6aX-0005Rm-Rx
	for ltp-list@lists.sourceforge.net; Fri, 02 Nov 2012 02:02:26 +0000
Message-ID: <509329C4.9000406@cn.fujitsu.com>
Date: Fri, 02 Nov 2012 10:02:44 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <cover.1351256774.git.jstancek@redhat.com>
	<0800ef411c4f06c7cb570bfe4595958fde0471a3.1351256774.git.jstancek@redhat.com>
In-Reply-To: <0800ef411c4f06c7cb570bfe4595958fde0471a3.1351256774.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v3 3/3] new syscall test: migrate_pages02
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
> Use migrate_pages() syscall and check that
> shared/non-shared memory is migrated to desired node.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  runtest/syscalls                                   |    1 +
>  testcases/kernel/syscalls/.gitignore               |    1 +
>  .../syscalls/migrate_pages/migrate_pages01.c       |    2 +-
>  .../syscalls/migrate_pages/migrate_pages02.c       |  419 ++++++++++++++++++++
>  4 files changed, 422 insertions(+), 1 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c

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
