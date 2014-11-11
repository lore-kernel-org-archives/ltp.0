Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Xo1Hg-0003io-M1
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 02:34:20 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Xo1Hf-0003BL-2A
	for ltp-list@lists.sourceforge.net; Tue, 11 Nov 2014 02:34:20 +0000
Message-ID: <1415673144.3244.11.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Tue, 11 Nov 2014 10:32:24 +0800
In-Reply-To: <1415639518-4906-1-git-send-email-jack@suse.cz>
References: <1415639518-4906-1-git-send-email-jack@suse.cz>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] syscalls/fanotify: Verify that inode ignore
 masks are properly reflected
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
To: Jan Kara <jack@suse.cz>
Cc: ltp-list@lists.sourceforge.net

Hi,
On Mon, 2014-11-10 at 18:11 +0100, Jan Kara wrote:
> Verify that when inode has an ignore mask set, it is properly reflected
> when notifying a mountpoint. The test verifies fix "fanotify: Fix notification
> of groups with inode & mount marks" in the Linux kernel.
> 

I have tested in RHEL7(3.10.0-123.el7.x86_64), but it output like:
[root@RHEL7U0GA fanotify]# ./fanotify06 -i 10
fanotify06    1  TPASS  :  group 0 get event: mask 2 pid=16410 fd=12
fanotify06    2  TPASS  :  group 1 get event: mask 2 pid=16410 fd=12
fanotify06    3  TPASS  :  group 2 get event: mask 2 pid=16410 fd=12
fanotify06    4  TFAIL  :  fanotify06.c:217: group 3 got event
fanotify06    5  TPASS  :  group 4 got no event
fanotify06    6  TPASS  :  group 5 got no event
fanotify06    7  TPASS  :  group 6 got no event
fanotify06    8  TPASS  :  group 7 got no event
fanotify06    9  TPASS  :  group 8 got no event
fanotify06   10  TPASS  :  group 0 get event: mask 2 pid=16410 fd=13
fanotify06   11  TPASS  :  group 1 get event: mask 2 pid=16410 fd=13
fanotify06   12  TPASS  :  group 2 get event: mask 2 pid=16410 fd=13
fanotify06   13  TFAIL  :  fanotify06.c:217: group 3 got event
fanotify06   14  TPASS  :  group 4 got no event
fanotify06   15  TPASS  :  group 5 got no event
fanotify06   16  TPASS  :  group 6 got no event
fanotify06   17  TPASS  :  group 7 got no event
fanotify06   18  TPASS  :  group 8 got no event
fanotify06   19  TPASS  :  group 0 get event: mask 2 pid=16410 fd=14
fanotify06   20  TPASS  :  group 1 get event: mask 2 pid=16410 fd=14
fanotify06   21  TPASS  :  group 2 get event: mask 2 pid=16410 fd=14
fanotify06   22  TPASS  :  group 3 got no event
fanotify06   23  TPASS  :  group 4 got no event
fanotify06   24  TPASS  :  group 5 got no event
fanotify06   25  TPASS  :  group 6 got no event
fanotify06   26  TPASS  :  group 7 got no event
fanotify06   27  TPASS  :  group 8 got no event
fanotify06   28  TPASS  :  group 0 get event: mask 2 pid=16410 fd=14
fanotify06   29  TPASS  :  group 1 get event: mask 2 pid=16410 fd=14
fanotify06   30  TPASS  :  group 2 get event: mask 2 pid=16410 fd=14
fanotify06   31  TPASS  :  group 3 got no event
fanotify06   32  TPASS  :  group 4 got no event
fanotify06   33  TPASS  :  group 5 got no event
fanotify06   34  TPASS  :  group 6 got no event
fanotify06   35  TPASS  :  group 7 got no event
fanotify06   36  TPASS  :  group 8 got no event
fanotify06   37  TPASS  :  group 0 get event: mask 2 pid=16410 fd=14
fanotify06   38  TPASS  :  group 1 get event: mask 2 pid=16410 fd=14
fanotify06   39  TPASS  :  group 2 get event: mask 2 pid=16410 fd=14
fanotify06   40  TFAIL  :  fanotify06.c:217: group 3 got event
fanotify06   41  TFAIL  :  fanotify06.c:217: group 4 got event
fanotify06   42  TFAIL  :  fanotify06.c:217: group 5 got event
fanotify06   43  TPASS  :  group 6 got no event
fanotify06   44  TPASS  :  group 7 got no event
fanotify06   45  TPASS  :  group 8 got no event
fanotify06   46  TPASS  :  group 0 get event: mask 2 pid=16410 fd=17
fanotify06   47  TPASS  :  group 1 get event: mask 2 pid=16410 fd=17
fanotify06   48  TPASS  :  group 2 get event: mask 2 pid=16410 fd=17
fanotify06   49  TFAIL  :  fanotify06.c:217: group 3 got event
fanotify06   50  TFAIL  :  fanotify06.c:217: group 4 got event
fanotify06   51  TPASS  :  group 5 got no event
fanotify06   52  TPASS  :  group 6 got no event
fanotify06   53  TPASS  :  group 7 got no event
fanotify06   54  TPASS  :  group 8 got no event
fanotify06   55  TPASS  :  group 0 get event: mask 2 pid=16410 fd=19
fanotify06   56  TPASS  :  group 1 get event: mask 2 pid=16410 fd=19
fanotify06   57  TPASS  :  group 2 get event: mask 2 pid=16410 fd=19
fanotify06   58  TFAIL  :  fanotify06.c:217: group 3 got event
fanotify06   59  TPASS  :  group 4 got no event
fanotify06   60  TPASS  :  group 5 got no event
fanotify06   61  TPASS  :  group 6 got no event
fanotify06   62  TPASS  :  group 7 got no event
fanotify06   63  TPASS  :  group 8 got no event
fanotify06   64  TPASS  :  group 0 get event: mask 2 pid=16410 fd=20
fanotify06   65  TPASS  :  group 1 get event: mask 2 pid=16410 fd=20
fanotify06   66  TPASS  :  group 2 get event: mask 2 pid=16410 fd=20
fanotify06   67  TFAIL  :  fanotify06.c:217: group 3 got event
fanotify06   68  TFAIL  :  fanotify06.c:217: group 4 got event
fanotify06   69  TFAIL  :  fanotify06.c:217: group 5 got event
fanotify06   70  TPASS  :  group 6 got no event
fanotify06   71  TPASS  :  group 7 got no event
fanotify06   72  TPASS  :  group 8 got no event
fanotify06   73  TPASS  :  group 0 get event: mask 2 pid=16410 fd=23
fanotify06   74  TPASS  :  group 1 get event: mask 2 pid=16410 fd=23
fanotify06   75  TPASS  :  group 2 get event: mask 2 pid=16410 fd=23
fanotify06   76  TPASS  :  group 3 got no event
fanotify06   77  TPASS  :  group 4 got no event
fanotify06   78  TPASS  :  group 5 got no event
fanotify06   79  TPASS  :  group 6 got no event
fanotify06   80  TPASS  :  group 7 got no event
fanotify06   81  TPASS  :  group 8 got no event
fanotify06   82  TPASS  :  group 0 get event: mask 2 pid=16410 fd=23
fanotify06   83  TPASS  :  group 1 get event: mask 2 pid=16410 fd=23
fanotify06   84  TPASS  :  group 2 get event: mask 2 pid=16410 fd=23
fanotify06   85  TFAIL  :  fanotify06.c:217: group 3 got event
fanotify06   86  TFAIL  :  fanotify06.c:217: group 4 got event
fanotify06   87  TFAIL  :  fanotify06.c:217: group 5 got event
fanotify06   88  TFAIL  :  fanotify06.c:217: group 6 got event
fanotify06   89  TFAIL  :  fanotify06.c:217: group 7 got event
fanotify06   90  TPASS  :  group 8 got no event

Best regards,
Zeng


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
