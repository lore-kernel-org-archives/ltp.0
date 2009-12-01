Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NFbiv-0000K3-TZ
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:01:33 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFbiq-0001VM-5P
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:01:33 +0000
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id AF6A5136AD2BB
	for <ltp-list@lists.sourceforge.net>;
	Wed,  2 Dec 2009 00:01:22 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314) id 1NFbik-00035Q-00
	for ltp-list@lists.sourceforge.net; Wed, 02 Dec 2009 00:01:22 +0100
Date: Tue, 01 Dec 2009 23:55:56 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u397kstqcfnueu@debian>
Subject: [LTP] [PATCH] Fix small errors in the runtest files
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20091201225556.AENR5N_xLcmv-OIupVP1o-WehCiRXJbaxXoSXNVGly8@z>

Hello,

this patch fixes the following problems in the runtest files:

 - rwtest has been renamed to rwtest.sh

 - there is no ipv6 variant of rlogin test

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 runtest/fs          |   10 +++++-----
 runtest/ipv6_expect |    1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/runtest/fs b/runtest/fs
index 717336a..9042c87 100644
--- a/runtest/fs
+++ b/runtest/fs
@@ -29,11 +29,11 @@ gf27 growfiles -W gf27 -b -D 0 -w -g 8b -C 1 -b -i 1000 -u gfsparse-1-$$ -d $TMP
 gf28 growfiles -W gf28 -b -D 0 -w -g 16b -C 1 -b -i 1000 -u gfsparse-2-$$ -d $TMPDIR
 gf29 growfiles -W gf29 -b -D 0 -r 1-4096 -R 0-33554432 -i 0 -L 60 -C 1 -u gfsparse-3-$$ -d $TMPDIR
 gf30 growfiles -W gf30 -D 0 -b -i 0 -L 60 -u -B 1000b -e 1 -o O_RDWR,O_CREAT,O_SYNC -g 20480 -T 10 -t 20480 gf-sync-$$ -d $TMPDIR
-rwtest01 export LTPROOT; rwtest -N rwtest01 -c -q -i 60s  -f sync 10%25000:$TMPDIR/rw-sync-$$
-rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f buffered 10%25000:$TMPDIR/rw-buffered-$$
-rwtest03 export LTPROOT; rwtest -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
-rwtest04 export LTPROOT; rwtest -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
-rwtest05 export LTPROOT; rwtest -N rwtest05 -c -q -i 50 -T 64b 500b:$TMPDIR/rwtest01%f
+rwtest01 export LTPROOT; rwtest.sh -N rwtest01 -c -q -i 60s  -f sync 10%25000:$TMPDIR/rw-sync-$$
+rwtest02 export LTPROOT; rwtest.sh -N rwtest02 -c -q -i 60s  -f buffered 10%25000:$TMPDIR/rw-buffered-$$
+rwtest03 export LTPROOT; rwtest.sh -N rwtest03 -c -q -i 60s -n 2  -f buffered -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-buff-$$
+rwtest04 export LTPROOT; rwtest.sh -N rwtest04 -c -q -i 60s -n 2  -f sync -s mmread,mmwrite -m random -Dv 10%25000:$TMPDIR/mm-sync-$$
+rwtest05 export LTPROOT; rwtest.sh -N rwtest05 -c -q -i 50 -T 64b 500b:$TMPDIR/rwtest01%f
 
 #must be run as root
 #iogen01 iogen -i 120s -s read,write 500b:doio.f1.$$ 1000b:doio.f2.$$ | doio -akv -n 2
diff --git a/runtest/ipv6_expect b/runtest/ipv6_expect
index 522082e..fbed53d 100644
--- a/runtest/ipv6_expect
+++ b/runtest/ipv6_expect
@@ -1,2 +1 @@
 #DESCRIPTION:IPV6 related tests which require expect
-rlogin6 rlogin01 -6
-- 
1.6.4.3




------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
