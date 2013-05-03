Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <riku.voipio@linaro.org>) id 1UYGXT-0002nY-Ak
	for ltp-list@lists.sourceforge.net; Fri, 03 May 2013 14:00:43 +0000
Received: from afflict.kos.to ([92.243.29.197])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1UYGXR-0002y9-71
	for ltp-list@lists.sourceforge.net; Fri, 03 May 2013 14:00:43 +0000
From: riku.voipio@linaro.org
Date: Fri,  3 May 2013 16:45:16 +0300
Message-Id: <1367588717-18162-3-git-send-email-riku.voipio@linaro.org>
Subject: [LTP] [PATCH 2/3] Set invalid syscall as -1 instead of 0
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

From: Riku Voipio <riku.voipio@linaro.org>

System call number 0 might be in use in selected syscalls.

Signed-off-by: Riku Voipio <riku.voipio@linaro.org>
---
 testcases/kernel/include/regen.sh |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/include/regen.sh b/testcases/kernel/include/regen.sh
index 86cdc09..08a2669 100755
--- a/testcases/kernel/include/regen.sh
+++ b/testcases/kernel/include/regen.sh
@@ -27,7 +27,7 @@ cat << EOF > "${output_pid}"
 
 #define ltp_syscall(NR, ...) ({ \\
 	int __ret; \\
-	if (NR == 0) { \\
+	if (NR == __LTP__NR_INVALID_SYSCALL) { \\
 		errno = ENOSYS; \\
 		__ret = -1; \\
 	} else { \\
@@ -71,11 +71,12 @@ done
 echo -n "Generating stub list ... "
 echo "" >> "${output_pid}"
 echo "/* Common stubs */" >> "${output_pid}"
+echo "#define __LTP__NR_INVALID_SYSCALL -1" >> "${output_pid}"
 for nr in $(awk '{print $1}' "${srcdir}/"*.in | sort -u) ; do
 	nr="__NR_$nr"
 	cat <<-EOF >> "${output_pid}"
 	# ifndef $nr
-	#  define $nr 0
+	#  define $nr __LTP__NR_INVALID_SYSCALL
 	# endif
 	EOF
 done
-- 
1.7.10.4


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
