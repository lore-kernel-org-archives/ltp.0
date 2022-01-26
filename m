Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 854FFC28CF5
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 12:37:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06AE53C96DD
	for <ltp@archiver.kernel.org>; Wed, 26 Jan 2022 13:37:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 748E93C9664
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0D254601D42
 for <ltp@lists.linux.it>; Wed, 26 Jan 2022 13:35:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DA5B218E7;
 Wed, 26 Jan 2022 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643200556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPKWjbZ/cFTETwaBTAvP7p+He0SHCkoj5X9byYNKQxk=;
 b=bjJrwoQG7Ei3cm6AQEYhnNbMHb2GaAd2B/sGuXYrt7vEIyK0DRtmLdaQByE2Fp5BbPl3m9
 PRAPJX27OqnSEwwLxzyAmTE6N1BfzMVr5LzbU8NnEXXvTg1pDJ/gIVvQ9ZYFxvPMHYbQHO
 2PTAaIla6++pdf3gckc4L7yhdl99MAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643200556;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FPKWjbZ/cFTETwaBTAvP7p+He0SHCkoj5X9byYNKQxk=;
 b=WsfFFIlxWoM+qIEHQ7HZk+41c8jK9pjaaHCL7NpbCQKaMR0h+tVcSByF57ggZi+dfGNnYi
 l8+hY3gqoxsIGECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7555713BB5;
 Wed, 26 Jan 2022 12:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wLkfGyxA8WGkOQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Jan 2022 12:35:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Jan 2022 13:35:44 +0100
Message-Id: <20220126123547.13298-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220126123547.13298-1-pvorel@suse.cz>
References: <20220126123547.13298-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH v2 4/7] realtime/m4: Simplify exp10 check
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
Cc: automated-testing@yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Yes, uclibc-ng still haven't defined exp10, thus still needed.

Link: https://github.com/linux-test-project/ltp/issues/13

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2

 testcases/realtime/configure.ac    |  4 ++--
 testcases/realtime/m4/ltp-exp10.m4 | 37 ------------------------------
 2 files changed, 2 insertions(+), 39 deletions(-)
 delete mode 100644 testcases/realtime/m4/ltp-exp10.m4

diff --git a/testcases/realtime/configure.ac b/testcases/realtime/configure.ac
index e483caf0d2..6f50f1490f 100644
--- a/testcases/realtime/configure.ac
+++ b/testcases/realtime/configure.ac
@@ -35,8 +35,8 @@ else
 	AC_MSG_RESULT(no)
 fi
 
-REALTIME_CHECK_PRIO_INHERIT
+AC_CHECK_LIB([m], [exp10], [AC_DEFINE([HAVE_EXP10], 1, [Define to 1 if you have exp10 function])])
 
-LTP_CHECK_EXP10
+REALTIME_CHECK_PRIO_INHERIT
 
 AC_OUTPUT
diff --git a/testcases/realtime/m4/ltp-exp10.m4 b/testcases/realtime/m4/ltp-exp10.m4
deleted file mode 100644
index 3d2320a206..0000000000
--- a/testcases/realtime/m4/ltp-exp10.m4
+++ /dev/null
@@ -1,37 +0,0 @@
-dnl
-dnl Copyright (c) Linux Test Project, 2014
-dnl
-dnl This program is free software;  you can redistribute it and/or modify
-dnl it under the terms of the GNU General Public License as published by
-dnl the Free Software Foundation; either version 2 of the License, or
-dnl (at your option) any later version.
-dnl
-dnl This program is distributed in the hope that it will be useful,
-dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
-dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
-dnl the GNU General Public License for more details.
-dnl
-dnl You should have received a copy of the GNU General Public License
-dnl along with this program;  if not, write to the Free Software
-dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
-dnl
-
-dnl
-dnl LTP_CHECK_EXP10
-dnl ---------------
-dnl
-AC_DEFUN([LTP_CHECK_EXP10],[
-AH_TEMPLATE(HAVE_EXP10,
-[Define to 1 if you have 'exp10' function.])
-AC_MSG_CHECKING([for exp10])
-backup_ldlibs="$LIBS"
-LIBS+=" -lm"
-AC_TRY_LINK([#define _GNU_SOURCE
-             #include <math.h>],
-            [
-             volatile float val;
-             exp10(val);
-            ],
-             AC_DEFINE(HAVE_EXP10) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
-LIBS="$backup_ldlibs"
-])
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
