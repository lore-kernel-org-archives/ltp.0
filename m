Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gadi.golan@rnanetworks.com>) id 1NY6Oj-0007Zz-45
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 23:25:09 +0000
Received: from mx1.myoutlookonline.com ([64.95.72.238])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NY6Oi-0002hf-3n
	for ltp-list@lists.sourceforge.net; Thu, 21 Jan 2010 23:25:09 +0000
From: Gadi Golan <gadi.golan@rnanetworks.com>
Date: Thu, 21 Jan 2010 18:12:45 -0500
Message-ID: <C77E1F6D.658%gadi.golan@rnanetworks.com>
Content-Language: en
MIME-Version: 1.0
Subject: [LTP] =?iso-8859-1?q?FS_Tests_4x_Slower_on_CentOS_5=2E3/HP_ProLia?=
 =?iso-8859-1?q?nt_=AD_Stuck_in_unlink=28=29?=
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Greetings,
I have been running the LTP File System tests (runtest/fs) from the December
O09 Stable release and uncovered an interesting situation that I am unable
to make any progress on.  In simplest of terms the combination of an HP
ProLiant BL465c G1 and a standard install of CentOS 5.3 (2.6.18-128.el5 on
x86_64) causes the fs test suite to take approximately 2 hours to complete
which is four times longer than the common 30 minute runtime I am used to
seeing.  This issue replicates on multiple blades in multiple enclosures and
using an older version of LTP (September '09).

Using the same hardware but with CentOS 5.2 (2.6.18-92.el5 on x86_64) the
same test suite takes approximately 30 minutes.  Switching to a Dell
PowerEdgeM600 using the same CentOS 5.3 setup also takes approximately 30
minutes to complete.  The suite has been run against the system's local
disks as well as an NFS share, all yielding the same 30 minute/2 hour
runtimes.  Updating the CentOS 5.3 kernel to 2.6.18-164.11.1.el5 on the
ProLiant system does not alleviate the issue, with the fs test suite still
taking approximately 2 hours to complete.

After exploring which tests were taking a long period of time the most
common instances where gf01 (7-20min), gf14 (13min), and gf15(4min).
Attaching strace to the growfile process did offer a look into what was
causing the slowdown.  Occasionally an unlink() call would sit unfinished
for minutes before progressing to the next system call.  An example of this
is shown here, where the first unlink takes 4 minutes, the second takes 2
minutes, and the next 3 all complete in a fraction of a second:

14:56:55 close(5)                       = 0
14:56:55 unlink("/tmp/ltp/ltp-gCVtc15250/Lgf02_1") = 0
15:00:37 unlink("/tmp/ltp/ltp-gCVtc15250/Lgf02_2") = 0
15:02:34 unlink("/tmp/ltp/ltp-gCVtc15250/Lgf02_3") = 0
15:02:34 unlink("/tmp/ltp/ltp-gCVtc15250/Lgf02_4") = 0
15:02:34 unlink("/tmp/ltp/ltp-gCVtc15250/Lgf02_5") = 0

Using the sysrq-trigger to collect a call trace while growfiles is paused on
an unlink call I see the following with consistency.  I can get the call
trace multiple times while the strace shows growfile is sitting in the
unlink and the only thing that varies is the very top of the stack.  It is
either as below or with an extra call to do_gettimeoffset_hpet+0x7:

growfiles     D ffff81000100c980     0  3838   3837
(NOTLB)
ffff810220167c68 0000000000000082 0000000083b8eb1b 000000001e958328
0000000000000086 0000000000000007 ffff81022fd1e100 ffff81042ff550c0
0000002c39fb6379 0000000000000f05 ffff81022fd1e2e8 0000000207b34f38
Call Trace:
[<ffffffff8006dd27>] do_gettimeofday+0x40/0x8f
[<ffffffff80015008>] sync_buffer+0x0/0x3f
[<ffffffff8006389b>] io_schedule+0x3f/0x67
[<ffffffff80015043>] sync_buffer+0x3b/0x3f
[<ffffffff800639df>] __wait_on_bit_lock+0x36/0x66
[<ffffffff80015008>] sync_buffer+0x0/0x3f
[<ffffffff80063a7b>] out_of_line_wait_on_bit_lock+0x6c/0x78
[<ffffffff8009db4f>] wake_bit_function+0x0/0x23
[<ffffffff800270f4>] try_to_free_buffers+0x89/0x9d
[<ffffffff88032241>] :jbd:journal_invalidatepage+0x92/0x358
[<ffffffff8001cc70>] truncate_complete_page+0x1b/0x40
[<ffffffff8002b11c>] truncate_inode_pages_range+0x9b/0x2ba
[<ffffffff88050116>] :ext3:ext3_delete_inode+0x0/0xd5
[<ffffffff8805012d>] :ext3:ext3_delete_inode+0x17/0xd5
[<ffffffff88050116>] :ext3:ext3_delete_inode+0x0/0xd5
[<ffffffff8002f114>] generic_delete_inode+0xc6/0x143
[<ffffffff8003c1c3>] do_unlinkat+0xd5/0x141
[<ffffffff8005d229>] tracesys+0x71/0xe0
[<ffffffff8005d28d>] tracesys+0xd5/0xe0

The call trace does not yield an obvious smoking gun to me and searching
around does not show any other examples of this happening.  Any help
debugging this issue and sorting out what is the root cause of this slowness
would be very helpful.

Thanks,

Gadi Golan
QA Engineer
RNA Networks

ProLiant BL465c G1 - RHEL5 Certified & HW Information
https://hardware.redhat.com/show.cgi?id=228786


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
