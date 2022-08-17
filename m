Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C12C32771
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 13:36:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6800C3C9F4E
	for <ltp@archiver.kernel.org>; Wed, 17 Aug 2022 15:36:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DA333C9B4F
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 15:35:55 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 8751C2009E5
 for <ltp@lists.linux.it>; Wed, 17 Aug 2022 15:35:54 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7390113E;
 Wed, 17 Aug 2022 06:35:51 -0700 (PDT)
Received: from e129169.arm.com (usa-sjc-imap-foss1.foss.arm.com
 [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34DE33F67D;
 Wed, 17 Aug 2022 06:35:50 -0700 (PDT)
From: Tudor Cretu <tudor.cretu@arm.com>
To: ltp@lists.linux.it
Date: Wed, 17 Aug 2022 14:37:00 +0100
Message-Id: <20220817133700.233524-1-tudor.cretu@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] IDcheck: Add check for root user/group
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Some tests (e.g. getgid, getegid, etc.) need to have a valid user id and
group for root. Add the check to IDcheck.sh. Also, make a user and a group
for root if necessary.

Signed-off-by: Tudor Cretu <tudor.cretu@arm.com>
---
 IDcheck.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/IDcheck.sh b/IDcheck.sh
index 591695915..c6c41b965 100755
--- a/IDcheck.sh
+++ b/IDcheck.sh
@@ -26,9 +26,11 @@ echo "Checking for required user/group ids"
 echo ""
 
 # Check ids and create if needed.
+NO_ROOT_ID=1
 NO_NOBODY_ID=1
 NO_BIN_ID=1
 NO_DAEMON_ID=1
+NO_ROOT_GRP=1
 NO_NOBODY_GRP=1
 NO_BIN_GRP=1
 NO_DAEMON_GRP=1
@@ -49,7 +51,7 @@ fe() {
 prompt_for_create() {
 	if [ -z "$CREATE_ENTRIES" ] ; then
 
-		if [ $NO_NOBODY_ID -ne 0 -o $NO_BIN_ID -ne 0 -o $NO_DAEMON_ID -ne 0 -o $NO_NOBODY_GRP -ne 0 -o $NO_BIN_GRP -ne 0 -o $NO_DAEMON_GRP -ne 0 -o $NO_USERS_GRP -ne 0 -o $NO_SYS_GRP -ne 0 ] ; then
+		if [ $NO_ROOT_ID -ne 0 -o $NO_NOBODY_ID -ne 0 -o $NO_BIN_ID -ne 0 -o $NO_DAEMON_ID -ne 0 -o $NO_ROOT_GRP -ne 0 -o $NO_NOBODY_GRP -ne 0 -o $NO_BIN_GRP -ne 0 -o $NO_DAEMON_GRP -ne 0 -o $NO_USERS_GRP -ne 0 -o $NO_SYS_GRP -ne 0 ] ; then
 			echo -n "If any required user ids and/or groups are missing, would you like these created? [y/N]"
 			read ans
 			case "$ans" in
@@ -74,10 +76,12 @@ for i in "$passwd" "$group"; do
     fi
 done
 
+fe root "$passwd"; NO_ROOT_ID=$?
 fe bin "$passwd"; NO_BIN_ID=$?
 fe daemon "$passwd"; NO_DAEMON_ID=$?
 fe nobody "$passwd"; NO_NOBODY_ID=$?
 
+fe root "$group"; NO_ROOT_GRP=$?
 fe bin "$group"; NO_BIN_GRP=$?
 fe daemon "$group"; NO_DAEMON_GRP=$?
 fe nobody "$group" || fe nogroup "$group"; NO_NOBODY_GRP=$?
@@ -91,9 +95,11 @@ debug_vals() {
 echo "Missing the following group / user entries:"
 echo "Group file:		$group"
 echo "Password file:		$passwd"
+echo "root			$NO_ROOT_ID"
 echo "nobody:			$NO_NOBODY_ID"
 echo "bin:			$NO_BIN_ID"
 echo "daemon:			$NO_DAEMON_ID"
+echo "root grp:			$NO_ROOT_GRP"
 echo "nobody[/nogroup] grp:	$NO_NOBODY_GRP"
 echo "bin grp:			$NO_BIN_GRP"
 echo "daemon grp:		$NO_DAEMON_GRP"
@@ -130,6 +136,7 @@ make_user_group() {
 		fi
 	fi
 }
+make_user_group root 0 $NO_ROOT_ID $NO_ROOT_GRP
 make_user_group nobody 65534 $NO_NOBODY_ID $NO_NOBODY_GRP
 make_user_group bin 1 $NO_BIN_ID $NO_BIN_GRP
 make_user_group daemon 2 $NO_DAEMON_ID $NO_DAEMON_GRP
@@ -149,7 +156,7 @@ fi
 MISSING_ENTRY=0
 
 # For entries that exist in both $group and $passwd.
-for i in bin daemon; do
+for i in root bin daemon; do
     for file in "$group" "$passwd"; do
         if ! fe "$i" "$file"; then
             MISSING_ENTRY=1
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
