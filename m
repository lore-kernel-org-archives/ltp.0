Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jbastian@redhat.com>) id 1XlO2D-0000HN-EO
	for ltp-list@lists.sourceforge.net; Mon, 03 Nov 2014 20:15:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XlO2A-0001yk-ES
	for ltp-list@lists.sourceforge.net; Mon, 03 Nov 2014 20:15:29 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sA3KFJ6j022129
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Nov 2014 15:15:19 -0500
Received: from tarantula.localdomain (ovpn-113-179.phx2.redhat.com
	[10.3.113.179])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id sA3KFItZ014073
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Nov 2014 15:15:19 -0500
Date: Mon, 3 Nov 2014 14:15:17 -0600
From: Jeffrey Bastian <jbastian@redhat.com>
Message-ID: <20141103201517.GA9814@tarantula.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [PATCH] file_test: fix testcase for ppc64le
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

The file_test.sh test assumes all PPC systems are big-endian (MSB), but
this assumption is incorrect on the new ppc64le little-endian (LSB)
systems and file06 and file10 report false failures:

file06      0  TINFO  :  TEST #6: file command recognizes ELF executables
file06      6  TFAIL  :  ltpapicmd.c:156: file: Failed to Recognize ELF binary executable. Reason:
/tmp//cprog: ELF 64-bit LSB executable, version 1 (SYSV), dynamically linked (uses shared libs), ...
...
file10      0  TINFO  :  TEST #10: file command recognizes vmlinu file
file10     10  TFAIL  :  ltpapicmd.c:156: file: Failed to Recognize vmlinu correctly. Reason:
/boot/vmlinuz: ELF 64-bit LSB shared object, version 1 (SYSV), statically linked, ...

This patch fixes the test so ppc64le is checked for "LSB", not "MSB".

Signed-off-by: Jeff Bastian <jbastian@redhat.com>
---
 testcases/commands/ade/file/file_test.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/testcases/commands/ade/file/file_test.sh b/testcases/commands/ade/file/file_test.sh
index 101a8cca8bc9..fd7943807bdb 100755
--- a/testcases/commands/ade/file/file_test.sh
+++ b/testcases/commands/ade/file/file_test.sh
@@ -332,10 +332,10 @@ fi
 
 
 # TEST #6
-# Test if file command can recognize ELF binay executables
+# Test if file command can recognize ELF binary executables
 
-# Check ppc architecture
-  TEST_ARCH=LSB   # Assume the architecture is Intel
+# Check architecture endianness
+  TEST_ARCH=LSB   # Assume the architecture is little-endian
 
   if uname -m |
     grep -qe '\(m68k\)\|\(sparc\)\|\(mips\b\)\|\(mipseb\)\|\(sh.eb\)' \
@@ -343,6 +343,11 @@ fi
      TEST_ARCH=MSB
   fi
 
+  # ppc is usually big-endian, but not necessarily
+  if uname -m | grep -qe '\(ppc64le\)'; then
+     TEST_ARCH=LSB
+  fi
+
 export TCID=file06
 export TST_COUNT=6
 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
