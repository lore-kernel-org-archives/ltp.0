Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <brianzhang2007@gmail.com>) id 1NSD8J-0006n1-E0
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 17:23:51 +0000
Received: from mail-qy0-f190.google.com ([209.85.221.190])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSD8I-0000US-II
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 17:23:51 +0000
Received: by qyk28 with SMTP id 28so7634132qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 05 Jan 2010 09:23:44 -0800 (PST)
Message-ID: <2FB9CEFCF4B24FC7AE1D718C54B63F55@jacksimba>
From: "Yongjian Zhang" <brianzhang2007@gmail.com>
Date: Tue, 5 Jan 2010 10:23:40 -0700
MIME-Version: 1.0
Subject: [LTP] disktest question
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

Hi all,

I'm trying to use disktest to measure the performance of an iSCSI device but 
get extremely low throughput...

For example, I did

disktest -w -S0:1k -B 1024 /dev/sdb (/dev/sdb is the iSCSI device file, no 
partition or file system on it)

And the result was:
| 2010/01/05-02:58:26 | START | 27293 | v1.4.2 | /dev/sdb | Start
args: -w -S0:1024k -B 1024 -PA (-I b) (-N 8385867) (-K 4) (-c) (-p R)
(-L 1048577) (-D 0:100) (-t 0:2m) (-o 0)
| 2010/01/05-02:58:26 | INFO  | 27293 | v1.4.2 | /dev/sdb | Starting
pass
^C| 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
bytes written in 85578 transfers: 87631872
| 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
write throughput: 701055.0B/s (0.67MB/s), IOPS 684.6/s.
| 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
Write Time: 125 seconds (0d0h2m5s)
| 2010/01/05-03:00:58 | STAT  | 27293 | v1.4.2 | /dev/sdb | Total
overall runtime: 152 seconds (0d0h2m32s)
| 2010/01/05-03:00:58 | END   | 27293 | v1.4.2 | /dev/sdb | User
Interrupt: Test Done (Passed)

As you can see, the throughput was only 0.67MB/s and only 85578
written in 87631872 transfers...
I also tweaked the options with "-p l" and/or "-I bd" (change seek
pattern to linear and/or speficy IO type as block and direct IO) but
no improvement happened...

I thought this low throughput could be caused by the link rate or disk 
problem, but dd ruled it out..

$ dd if=/dev/zero of=/dev/sdb bs=1024 count=1048576

The throughput is 7.2 MB/s.

There must be something I've done wrong with disktest... Could anyone maybe 
help me out here?

Thanks a lot!

jack 


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
