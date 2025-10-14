Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEBBCCD192
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 14:50:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8669D3CEB56
	for <ltp@archiver.kernel.org>; Tue, 14 Oct 2025 16:50:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB6593CADA5
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 16:50:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 35F23600BB5
 for <ltp@lists.linux.it>; Tue, 14 Oct 2025 16:50:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 72E2021C92;
 Tue, 14 Oct 2025 14:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760453423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nQoCI7V1jVSv8lwac3IoQ/ZG4K5wgfRKnTCwUn8xj8I=;
 b=A6L55/uN+F7FdeFJROvtsBaLZksEzvWinxXFhH09AhCIfjQPQOwPRulvi4H57Ol170Io2p
 aLJ0NdnjD3UwpAy5yS0taQLMjFcQBmSARwQM18KOIMHkDpDGZNw1QvawEsoFjUD85Wwk8w
 XgbrSljxM7eqbeITOlT4yPV/56E5RU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760453423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nQoCI7V1jVSv8lwac3IoQ/ZG4K5wgfRKnTCwUn8xj8I=;
 b=ymiGy8htNq26cvTZK53PyWsL//MKewwd19BjxxmFb0Q0+xUNuYB4SeM1xgfnatyCsThUh+
 1ktQRM+YfZwDlaAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760453423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nQoCI7V1jVSv8lwac3IoQ/ZG4K5wgfRKnTCwUn8xj8I=;
 b=A6L55/uN+F7FdeFJROvtsBaLZksEzvWinxXFhH09AhCIfjQPQOwPRulvi4H57Ol170Io2p
 aLJ0NdnjD3UwpAy5yS0taQLMjFcQBmSARwQM18KOIMHkDpDGZNw1QvawEsoFjUD85Wwk8w
 XgbrSljxM7eqbeITOlT4yPV/56E5RU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760453423;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nQoCI7V1jVSv8lwac3IoQ/ZG4K5wgfRKnTCwUn8xj8I=;
 b=ymiGy8htNq26cvTZK53PyWsL//MKewwd19BjxxmFb0Q0+xUNuYB4SeM1xgfnatyCsThUh+
 1ktQRM+YfZwDlaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4443513A44;
 Tue, 14 Oct 2025 14:50:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KS8RDy9j7mhvEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 14 Oct 2025 14:50:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 Oct 2025 16:50:19 +0200
Message-ID: <20251014145020.178840-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] doc: Convert tst_kvercmp.h to RST
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

Could you please check my English.
@Cyril you're the author of the functions, please check my description.

Kind regards,
Petr

 doc/developers/api_c_tests.rst |  1 +
 include/tst_kvercmp.h          | 78 +++++++++++++++++++++++++++++-----
 2 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index ad384a1bbd..5ab945fe51 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -41,6 +41,7 @@ Guarded buffers
 Kernel
 ------
 .. kernel-doc:: ../../include/tst_kernel.h
+.. kernel-doc:: ../../include/tst_kvercmp.h
 
 NUMA
 ----
diff --git a/include/tst_kvercmp.h b/include/tst_kvercmp.h
index fbefa0f793..bfe943a304 100644
--- a/include/tst_kvercmp.h
+++ b/include/tst_kvercmp.h
@@ -6,39 +6,97 @@
 #ifndef TST_KVERCMP_H__
 #define TST_KVERCMP_H__
 
-/*
+/**
+ * tst_kvcmp() - Compare given kernel version with kernel in string.
+ *
+ * @cur_kver: Kernel version in string (struct utsname.release).
+ * @r1: Required major kernel version.
+ * @r2: Required minor kernel version.
+ * @r3: Required kernel patch level.
+ *
  * The same as tst_kvercmp() but running kernel version is passed as parameter
  * instead of utilizing uname().
+ *
+ * Return: Negative if older, 0 if the same and positive if newer.
  */
 int tst_kvcmp(const char *cur_kver, int r1, int r2, int r3);
 
-/*
- * Parsers string into three integer version.
+/**
+ * tst_parse_kver() - Parsers string into three integer version.
+ *
+ * @str_kver: Kernel version in string (struct utsname.release).
+ * @v1: Major kernel version.
+ * @v2: Minor kernel version.
+ * @v3: Kernel patch level.
+ *
+ * Return: 0 on success, 1 on error.
  */
 int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3);
 
-/*
- * Returns distribution name parsed from kernel version string or NULL.
+/**
+ * tst_kvcmp_distname() - Get the distribution name from kernel version string.
+ *
+ * @cur_kver: Kernel version in string (struct utsname.release).
+ *
+ * Return: The distribution name parsed from kernel version string or NULL.
  */
 const char *tst_kvcmp_distname(const char *cur_kver);
 
-/*
- * Compares versions up to five version numbers long.
+/**
+ * tst_kvexcmp() - Compares versions up to five version numbers long.
+ * @tst_exv: The tested kernel version in string (struct utsname.release).
+ * @cur_kver: The current version in string (struct utsname.release).
+ *
+ * The return value is similar to the 'strcmp()' function, i.e. zero means
+ * equal, negative value means that the kernel is older than the expected value
+ * and positive means that it's newer.
+ *
+ * Return: negative if older, 0 if the same and positive if newer.
  */
 int tst_kvexcmp(const char *tst_exv, const char *cur_kver);
 
-/*
- * Compare given kernel version with currently running kernel.
+/**
+ * tst_kvercmp() - Compare given kernel version with the currently running kernel.
  *
- * Returns negative if older, 0 if the same and positive if newer.
+ * @r1: Required major kernel version.
+ * @r2: Required minor kernel version.
+ * @r3: Required kernel patch level.
+ *
+ * Parse the output from 'uname()' and compare it to the passed values.
+ *
+ * The return value is similar to the 'strcmp()' function, i.e. zero means
+ * equal, negative value means that the kernel is older than the expected value
+ * and positive means that it's newer.
+ *
+ * Return: negative if older, 0 if the same and positive if newer.
  */
 int tst_kvercmp(int r1, int r2, int r3);
 
+/**
+ * struct tst_kern_exv - describe vendor kernel.
+ *
+ * @dist_name: A distribution name, e.g. "SLES", "RHEL9", "UBUNTU"
+ * @extra_ver: A vendor kernel version to check, e.g. "5.14.0-441".
+ */
 struct tst_kern_exv {
 	char *dist_name;
 	char *extra_ver;
 };
 
+/**
+ * tst_kvercmp2() - Compare given *distro* kernel version with the currently running kernel.
+ *
+ * @r1: Major kernel version.
+ * @r2: Minor kernel version.
+ * @r3: Kernel patch level.
+ * @vers: struct tst_kern_exv.
+ *
+ * The return value is similar to the 'strcmp()' function, i.e. zero means
+ * equal, negative value means that the kernel is older than the expected value
+ * and positive means that it's newer.
+ *
+ * Return: negative if older, 0 if the same and positive if newer.
+ */
 int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers);
 
 #endif	/* TST_KVERCMP_H__ */
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
