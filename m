Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZZDrg-00084j-Ho
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 08:02:52 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZZDrf-0007iG-2M
	for ltp-list@lists.sourceforge.net; Tue, 08 Sep 2015 08:02:52 +0000
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 31BBDC0798E1
	for <ltp-list@lists.sourceforge.net>;
	Tue,  8 Sep 2015 08:02:45 +0000 (UTC)
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id t8882h2t011126
	for <ltp-list@lists.sourceforge.net>; Tue, 8 Sep 2015 04:02:44 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  8 Sep 2015 10:02:40 +0200
Message-Id: <16f324dac1804ac5d787d210b97187e07766b47d.1441699315.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] linux_syscall_numbers: speed up generation
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

Replace cat with echo, which should be a builtin function
for most shells. Avoiding to spawn 'cat' for every syscall
entry can save time when generating linux_syscall_numbers.h:

$ time ./regen.sh

Before:
 real    0m24.642s
 user    0m1.263s
 sys     0m7.135s

After:
 real    0m0.130s
 user    0m0.241s
 sys     0m0.056s

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/include/regen.sh | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/include/regen.sh b/testcases/kernel/include/regen.sh
index eebac0f67308..9efc4f17cf88 100755
--- a/testcases/kernel/include/regen.sh
+++ b/testcases/kernel/include/regen.sh
@@ -71,11 +71,9 @@ for arch in $(cat "${srcdir}/order") ; do
 		if [ $# -eq 0 ] ; then
 			err "invalid line found: $line"
 		fi
-		cat <<-EOF
-		# ifndef ${nr}
-		#  define ${nr} $*
-		# endif
-		EOF
+		echo "# ifndef ${nr}"
+		echo "#  define ${nr} $*"
+		echo "# endif"
 	done < "${srcdir}/${arch}.in"
 	echo "#endif"
 	echo
@@ -97,11 +95,9 @@ echo "/* Common stubs */"
 echo "#define __LTP__NR_INVALID_SYSCALL -1" >> "${output_pid}"
 for nr in $(awk '{print $1}' "${srcdir}/"*.in | sort -u) ; do
 	nr="__NR_${nr}"
-	cat <<-EOF
-	# ifndef ${nr}
-	#  define ${nr} __LTP__NR_INVALID_SYSCALL
-	# endif
-	EOF
+	echo "# ifndef ${nr}"
+	echo "#  define ${nr} __LTP__NR_INVALID_SYSCALL"
+	echo "# endif"
 done
 echo "#endif"
 ) >> "${output_pid}._footer"
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
