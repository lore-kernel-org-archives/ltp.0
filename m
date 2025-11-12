Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3016CD37B2
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 19:37:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E67E3CF7D4
	for <ltp@archiver.kernel.org>; Wed, 12 Nov 2025 20:37:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99F1B3CF7B4
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 20:37:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ACF61600701
 for <ltp@lists.linux.it>; Wed, 12 Nov 2025 20:37:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC9471F798;
 Wed, 12 Nov 2025 19:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762976258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Levh202Pa8wLng4pj1Lyx6KxJ2HQdR08AdlR7STAq/g=;
 b=PLr/k49/QvdtYrjeTTICrFF9FkbNBdDqJEd3TIJgGpOmXxJmu0dT5AxTL+m4yenoYR+L75
 sXO5zu3l/RRwSoWPtXEhNBhyF/LxbUqoSuIPra2nsz05jbF0eR5Qq2/UgPl2lAH47JQ8zD
 2ehxHvyqeyUBCV5Did4n8HujXqdwZ1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762976258;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Levh202Pa8wLng4pj1Lyx6KxJ2HQdR08AdlR7STAq/g=;
 b=zqHwa1XTS0gpC1CMTZBjECaXeCXC5k9FmMHxe4W8zGg3xu6k/VM2mq7+sVz1V8AHKqqMMQ
 GokItjvQZE9Go1AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762976257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Levh202Pa8wLng4pj1Lyx6KxJ2HQdR08AdlR7STAq/g=;
 b=uBZz8PiNA8/zQrIxTZGm0FsBuyUu2GO+JUoKfaz9UVZeAxWv72TFVZHOXgcQqDQ5v78fBB
 JilOujgIKbayql4iRXzdY8blhZEJ7Pmr0Tot6ZC7ZkepEAO160w23Cg44xplJc4ELyLcn7
 FRYla1tnxFjwIjb192VHxeGjyLUBeV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762976257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Levh202Pa8wLng4pj1Lyx6KxJ2HQdR08AdlR7STAq/g=;
 b=tf0GH7aTSrvswNkhfN3JyGTniMmoaL/hklu6/9FA6Ca9OJzsdaviktJn3F/UommJ9Oyfwc
 BlrJ24y7ciYWapBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0A6A3EA61;
 Wed, 12 Nov 2025 19:37:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hkgdIAHiFGmEYwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Nov 2025 19:37:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 12 Nov 2025 20:37:33 +0100
Message-ID: <20251112193733.156974-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.996];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] doc: Convert tst_kvercmp.h to RST
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

Co-developed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2 (mostly from Cyril):
* Rewrite tst_kvercmp2() description.
* Remove "Required" from params.
* Remove wrongly used "in".
* Improve wording in tst_parse_kver() and tst_kvercmp() first line
  description.
* Add note "Everything after first three version numbers ... ignored" to
  tst_kvcmp() and tst_parse_kver().
* Mention array in struct tst_kern_exv->vers.
* Use :man2: and :man3: links (me).
* Use links to structs (me).

Hopefully I addressed everything.

Link to v1:
https://patchwork.ozlabs.org/project/ltp/patch/20251014145020.178840-1-pvorel@suse.cz/
https://lore.kernel.org/ltp/20251014145020.178840-1-pvorel@suse.cz/

 doc/developers/api_c_tests.rst |  1 +
 include/tst_kvercmp.h          | 85 ++++++++++++++++++++++++++++++----
 2 files changed, 76 insertions(+), 10 deletions(-)

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
index fbefa0f793..ab9779f281 100644
--- a/include/tst_kvercmp.h
+++ b/include/tst_kvercmp.h
@@ -6,39 +6,104 @@
 #ifndef TST_KVERCMP_H__
 #define TST_KVERCMP_H__
 
-/*
+/**
+ * tst_kvcmp() - Compare given kernel version with kernel in string.
+ *
+ * @cur_kver: Kernel version string (struct utsname.release).
+ * @r1: Major kernel version.
+ * @r2: Minor kernel version.
+ * @r3: Kernel patch level.
+ *
+ * Everything after first three version numbers till the end of the string is
+ * ignored.
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
+ * tst_parse_kver() - Parses a version string into three integers.
+ *
+ * @str_kver: Kernel version string (struct utsname.release).
+ * @v1: Major kernel version.
+ * @v2: Minor kernel version.
+ * @v3: Kernel patch level.
+ *
+ * Everything after first three version numbers till the end of the string is
+ * ignored.
+ *
+ * Return: 0 on success, 1 on error.
  */
 int tst_parse_kver(const char *str_kver, int *v1, int *v2, int *v3);
 
-/*
- * Returns distribution name parsed from kernel version string or NULL.
+/**
+ * tst_kvcmp_distname() - Get the distribution name from kernel version string.
+ *
+ * @cur_kver: Kernel version string (struct utsname.release).
+ *
+ * Return: The distribution name parsed from kernel version string or NULL.
  */
 const char *tst_kvcmp_distname(const char *cur_kver);
 
-/*
- * Compares versions up to five version numbers long.
+/**
+ * tst_kvexcmp() - Compares versions up to five version numbers long.
+ * @tst_exv: The tested kernel version string (struct utsname.release).
+ * @cur_kver: The current version in string (struct utsname.release).
+ *
+ * The return value is similar to the :man3:`strcmp` function, i.e. zero means
+ * equal, negative value means that the kernel is older than the expected value
+ * and positive means that it's newer.
+ *
+ * Return: negative if older, 0 if the same and positive if newer.
  */
 int tst_kvexcmp(const char *tst_exv, const char *cur_kver);
 
-/*
- * Compare given kernel version with currently running kernel.
+/**
+ * tst_kvercmp() - Compare a kernel version against currently running kernel.
+ *
+ * @r1: Major kernel version.
+ * @r2: Minor kernel version.
+ * @r3: Kernel patch level.
+ *
+ * Parse the output from :man2:`uname` and compare it to the passed values.
+ * This is shortcut for calling tst_kvcmp() with ``uname -r`` as str_kver.
  *
- * Returns negative if older, 0 if the same and positive if newer.
+ * Return: Negative if older, 0 if the same and positive if newer.
  */
 int tst_kvercmp(int r1, int r2, int r3);
 
+/**
+ * struct tst_kern_exv - describe vendor kernel.
+ *
+ * @dist_name: A distribution name, e.g. "SLES", "RHEL9", "UBUNTU".
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
+ * @vers: A {} terminated array of :ref:`struct tst_kern_exv`.
+ *
+ * Attempts to look up a distro specific kernel version from the struct
+ * tst_kern_exv table first and if no match is found falls back to the version
+ * passed in r1, r2, r3 (see tst_kvercmp()).
+ *
+ * The distribution name is detected either from the kernel release string e.g.
+ * el9 is mapped to RHEL9 or as a capitalized value of the ``ID=`` variable from
+ * ``/etc/os-release``.
+ *
+ * Return: Negative if older, 0 if the same and positive if newer.
+ */
 int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers);
 
 #endif	/* TST_KVERCMP_H__ */
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
