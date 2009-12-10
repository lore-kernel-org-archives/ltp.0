Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NIssr-0007j0-P0
	for ltp-list@lists.sourceforge.net; Thu, 10 Dec 2009 23:57:21 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-2.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NIssl-0001UP-Ei
	for ltp-list@lists.sourceforge.net; Thu, 10 Dec 2009 23:57:21 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Fri, 11 Dec 2009 08:57:04 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 11 Dec 2009 08:57:02 +0900
Message-ID: <000101ca79f4$7af702b0$70e50810$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] Tests of "iogen01" et al. fail with ltp-2009-12-10 cvs
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

Hi,

In the following thread, "rwtest has been renamed to rwtest.sh" is written.
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg08896.html

But, I got following message when I ran tests of "rwtest{01...05}" and
"iogen01" in my system with "ltp-2009-12-10" cvs.

------------
sh: rwtest.sh: command not found
------------

I think that "rwtest.sh" has been renamed to "rwtest" at about 2009/11/14.

Here is a patch that reverts the previous patch applied to runtest/fs.
After applied this patch, "rwtest{01...05}" and "iogen01" passed in my
system.

============
--- fs	2009-12-10 10:23:21.000000000 +0900
+++ fs.new	2009-12-10 11:23:53.000000000 +0900
@@ -29,15 +29,15 @@
 gf28 growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$
-d $TMPDIR
 gf29 growfiles -W gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u
gfsparse-3-$$ -d $TMPDIR
 gf30 growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o
O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$ -d $TMPDIR
-rwtest01 export LTPROOT; rwtest.sh -N rwtest01 -c -q -i 60s  -f sync
10%25000:$TMPDIR/rw-sync-$$
-rwtest02 export LTPROOT; rwtest.sh -N rwtest02 -c -q -i 60s  -f buffered
10%25000:$TMPDIR/rw-buffered-$$
-rwtest03 export LTPROOT; rwtest.sh -N rwtest03 -c -q -i 60s -n 2  -f
buffered -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
-rwtest04 export LTPROOT; rwtest.sh -N rwtest04 -c -q -i 60s -n 2  -f sync
-s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
-rwtest05 export LTPROOT; rwtest.sh -N rwtest05 -c -q -i 50 -T 64b
500b:$TMPDIR/rwtest01%f
+rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync
10%25000:$TMPDIR/rw-sync-$$
+rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered
10%25000:$TMPDIR/rw-buffered-$$
+rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered
-s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
+rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s
mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
+rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b
500b:$TMPDIR/rwtest01%f
 
 #must be run as root
 #iogen01 iogen -i 120s -s read,write 500b:doio.f1.$$ 1000b:doio.f2.$$ |
doio -akv -n 2
-iogen01 export LTPROOT; rwtest.sh -N iogen01 -i 120s -s read,write -Da -Dv
-n 2 500b:doio.f1.$$ 1000b:doio.f2.$$
+iogen01 export LTPROOT; rwtest -N iogen01 -i 120s -s read,write -Da -Dv -n
2 500b:doio.f1.$$ 1000b:doio.f2.$$
 
 fs_inod01 fs_inod $TMP 10 10 10
 linker01 linktest.sh 1000 1000

============




------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
