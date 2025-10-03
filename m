Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA35DCAC5B0
	for <ltp@archiver.kernel.org>; Fri,  3 Oct 2025 10:13:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04E6D3CE521
	for <ltp@archiver.kernel.org>; Fri,  3 Oct 2025 12:13:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08BB93CDD07
 for <ltp@lists.linux.it>; Fri,  3 Oct 2025 12:13:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5251C600C60
 for <ltp@lists.linux.it>; Fri,  3 Oct 2025 12:13:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0D4273389B;
 Fri,  3 Oct 2025 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759486391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yK8AyqDFyzdRY5dcHgJHqU6s6VLvDHVoFisy1pdslmI=;
 b=JBQHfFkzl7oifCd1G1TzN+lwTz4Chj0OTuHdrjPcm/jGFk1+uXDKyl44xj3yC/OVBW+qPx
 6uODqJVcVByU1BQOIMf2dcP4rsi0F0ju9dkyj6LgmAeKHMSJJQmdZgw2lSIsJnoiOMSPyo
 SA6fCS26A0SiLy7+DU3OkPL9wYwN65E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759486391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yK8AyqDFyzdRY5dcHgJHqU6s6VLvDHVoFisy1pdslmI=;
 b=eH3/jKUcLDexShth036Nn7lm8uBgBvpPBFG8MMaTYMyI+YmRWxRNaqDI5fd7bXV5AioG6E
 P594zOsGzrZIZyBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JBQHfFkz;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="eH3/jKUc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759486391; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yK8AyqDFyzdRY5dcHgJHqU6s6VLvDHVoFisy1pdslmI=;
 b=JBQHfFkzl7oifCd1G1TzN+lwTz4Chj0OTuHdrjPcm/jGFk1+uXDKyl44xj3yC/OVBW+qPx
 6uODqJVcVByU1BQOIMf2dcP4rsi0F0ju9dkyj6LgmAeKHMSJJQmdZgw2lSIsJnoiOMSPyo
 SA6fCS26A0SiLy7+DU3OkPL9wYwN65E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759486391;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=yK8AyqDFyzdRY5dcHgJHqU6s6VLvDHVoFisy1pdslmI=;
 b=eH3/jKUcLDexShth036Nn7lm8uBgBvpPBFG8MMaTYMyI+YmRWxRNaqDI5fd7bXV5AioG6E
 P594zOsGzrZIZyBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0477D13AAD;
 Fri,  3 Oct 2025 10:13:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3AiMALeh32hNDgAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 03 Oct 2025 10:13:11 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri,  3 Oct 2025 12:13:08 +0200
Message-ID: <20251003101310.13359-1-akumar@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0D4273389B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[lkml.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[4];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] openposix: update invalid clock id to accomodate new
 auxiliary clock ids
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

There can be 8 more clock ids reserved on systems with
CONFIG_POSIX_AUX_CLOCK=y [1]
consequently clock 17 no longer remains an invalid id.

[1] https://lkml.org/lkml/2025/5/19/341

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 .../conformance/interfaces/clock_getres/6-2.c                 | 4 ++--
 .../conformance/interfaces/clock_gettime/8-2.c                | 4 ++--
 .../conformance/interfaces/clock_settime/17-2.c               | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c
index c44809012..62de33c4f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_getres/6-2.c
@@ -17,7 +17,7 @@
  *   unassigned value = -1073743192 (ex. of what gcc will set to)
  *   unassigned value = 1073743192 (ex. of what gcc will set to)
  *   -1
- *   17 (currently not = to any clock)
+ *   25 (not associated to any clock, considering posix auxiliary clocks also)
  *
  */
 #include <stdio.h>
@@ -33,7 +33,7 @@ int main(void)
 	struct timespec res;
 	int invalid_tests[NUMINVALIDTESTS] = {
 		INT32_MIN, INT32_MAX, 2147483647, -2147483647, -1073743192,
-		1073743192, -1, 17
+		1073743192, -1, 25
 	};
 	int i;
 	int failure = 0;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c
index ed4cd4078..66bed9332 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_gettime/8-2.c
@@ -15,7 +15,7 @@
  *   unassigned value = -1073743192 (ex. of what gcc will set to)
  *   unassigned value = 1073743192 (ex. of what gcc will set to)
  *   -1
- *   17 (currently not = to any clock)
+ *   25 (not associated to any clock, considering posix auxiliary clocks also)
  */
 #include <stdio.h>
 #include <time.h>
@@ -27,7 +27,7 @@
 
 static int invalid_tests[NUMINVALIDTESTS] = {
 	INT32_MIN, INT32_MAX, 2147483647, -2147483647, -1073743192,
-	1073743192, -1, 17
+	1073743192, -1, 25
 };
 
 int main(void)
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/17-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/17-2.c
index 990e41470..3580ade5b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/17-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/17-2.c
@@ -16,7 +16,7 @@
  *   unassigned value = -1073743192 (ex. of what gcc will set to)
  *   unassigned value = 1073743192 (ex. of what gcc will set to)
  *   -1
- *   17 (currently not = to any clock)
+ *   25 (not associated to any clock, considering posix auxiliary clocks also)
  *
  * The date chosen is Nov 12, 2002 ~11:13am (date when test was first
  * written).
@@ -34,7 +34,7 @@
 
 static int invalid_tests[NUMINVALIDTESTS] = {
 	INT32_MIN, INT32_MAX, 2147483647, -2147483647, -1073743192,
-	1073743192, -1, 17
+	1073743192, -1, 25
 };
 
 int main(void)
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
