Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97025CCA476
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 14:32:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15AD93CE425
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 16:32:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C48963CE194
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 16:32:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 41BED20097F
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 16:32:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D4CEE21A37
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 14:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759847528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Og5HFglEehJmXev5KFWn5qag4PZtNnxXXpbsYZnxCoM=;
 b=smbkHOwPnnMpymdq6JRh06NBUiENm9VfJJUBhF91YCrvxtNwBHKthT4DqdTUOW70+w+lEY
 aNcDQ3jI6TyltV67BzzmrjEdVOYhMj4uCRqqJjzGuy/XFjIAPZJ0cTyZ70qH020wEoFbc1
 kfAC3rL1a9OBicJnxObQm5C3J+c6h/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759847528;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Og5HFglEehJmXev5KFWn5qag4PZtNnxXXpbsYZnxCoM=;
 b=EnZzxTDdxpg2rhQP/COlWB0Ry3BMv+UMNSCxlEiwbHxk4Go5Dx+/h9e5xo+hZDzZp71O8S
 1oDLads1HdMiUNBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UKsENOBk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/7VeWPrD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759847527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Og5HFglEehJmXev5KFWn5qag4PZtNnxXXpbsYZnxCoM=;
 b=UKsENOBk5dAc2a7S41fycPOG8IejDMT/vp2vl0f30HQSBkNoMZMBJQnzhPTjiCl7e1aMMD
 IsKNSBu4hMZ2kZhlpodCAuQaTO86y1EFmUYOFVr6P/l8/RuxpJcnVrKJDAGbYTS54mafYc
 J/pLisVOIt57JaMGdGeCoPM0xnefnoY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759847527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Og5HFglEehJmXev5KFWn5qag4PZtNnxXXpbsYZnxCoM=;
 b=/7VeWPrDrucBMVIHnxdISo9jvvUqoDXUy6XvrEBLgExPzeuu5kBUIPzhJh2+Cl3THN2RBv
 b5sbL4Mun9IDivAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAEEB13AAC;
 Tue,  7 Oct 2025 14:32:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HjiEMWck5WhkPQAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 07 Oct 2025 14:32:07 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Tue,  7 Oct 2025 16:32:06 +0200
Message-ID: <20251007143207.27848-1-akumar@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aOODn-CZ7F1A777o@yuki.lan>
References: <aOODn-CZ7F1A777o@yuki.lan>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: D4CEE21A37
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] openposix: update invalid clock id to accomodate
 new auxiliary clock ids
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
Cc: pvore@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Starting kernel v6.17, there are 8 more auxiliary clock ids reserved on
systems with CONFIG_POSIX_AUX_CLOCK=y [1] and moreover posix systems can
define and support any number of clocks beyond the mandatory ones.

[1] https://lore.kernel.org/lkml/20250519083025.905800695@linutronix.de/

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 .../conformance/interfaces/clock_getres/6-2.c                | 5 ++---
 .../conformance/interfaces/clock_gettime/8-2.c               | 4 ++--
 .../conformance/interfaces/clock_settime/17-2.c              | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c
index c44809012..af45e27c9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c
@@ -17,8 +17,7 @@
  *   unassigned value = -1073743192 (ex. of what gcc will set to)
  *   unassigned value = 1073743192 (ex. of what gcc will set to)
  *   -1
- *   17 (currently not = to any clock)
- *
+ *   50 (hopefully big enough value not to be a valid clock id)
  */
 #include <stdio.h>
 #include <time.h>
@@ -33,7 +32,7 @@ int main(void)
 	struct timespec res;
 	int invalid_tests[NUMINVALIDTESTS] = {
 		INT32_MIN, INT32_MAX, 2147483647, -2147483647, -1073743192,
-		1073743192, -1, 17
+		1073743192, -1, 50
 	};
 	int i;
 	int failure = 0;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c
index ed4cd4078..92263ce87 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c
@@ -15,7 +15,7 @@
  *   unassigned value = -1073743192 (ex. of what gcc will set to)
  *   unassigned value = 1073743192 (ex. of what gcc will set to)
  *   -1
- *   17 (currently not = to any clock)
+  *   50 (hopefully big enough value not to be a valid clock id)
  */
 #include <stdio.h>
 #include <time.h>
@@ -27,7 +27,7 @@
 
 static int invalid_tests[NUMINVALIDTESTS] = {
 	INT32_MIN, INT32_MAX, 2147483647, -2147483647, -1073743192,
-	1073743192, -1, 17
+	1073743192, -1, 50
 };
 
 int main(void)
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/17-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/17-2.c
index 990e41470..7504b7692 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/17-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/17-2.c
@@ -16,7 +16,7 @@
  *   unassigned value = -1073743192 (ex. of what gcc will set to)
  *   unassigned value = 1073743192 (ex. of what gcc will set to)
  *   -1
- *   17 (currently not = to any clock)
+ *   50 (hopefully big enough value not to be a valid clock id)
  *
  * The date chosen is Nov 12, 2002 ~11:13am (date when test was first
  * written).
@@ -34,7 +34,7 @@
 
 static int invalid_tests[NUMINVALIDTESTS] = {
 	INT32_MIN, INT32_MAX, 2147483647, -2147483647, -1073743192,
-	1073743192, -1, 17
+	1073743192, -1, 50
 };
 
 int main(void)
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
