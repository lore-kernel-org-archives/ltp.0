Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C3FC4345F
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 04:29:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8989D3CFE85
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 06:29:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 766933CF38F
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 06:28:59 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2CB22600FE9
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 06:28:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E15735CC59;
 Fri, 26 Apr 2024 04:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714105738; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=prpKRPZQFCM/0phVZU0p/w4qKSv0I1znLJssJHqCO80=;
 b=gtm2u/UUMpZMh42TETUPkgXC2d180ugHIEEz+3CcT3M7p6qEGUjeqydzW/Rc93p0MEOWDZ
 KTGp1pA+I7wYmafDvnaNysItkc6FJWDV8FouNiHVvH0j1ufIjd/vg+Pti4EXMwv+LKFygr
 5BjFtzMVJcfCOXrfcQOhzDRBK2xaTpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714105738;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=prpKRPZQFCM/0phVZU0p/w4qKSv0I1znLJssJHqCO80=;
 b=7yqKMsq6JedgSOycXiJqK3hkuqRE52V7I/mvZBTR+hliC2PT2F/pMb2sqVQnCeRt1KipXa
 Hbb5hEThIyIMtdCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714105737; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=prpKRPZQFCM/0phVZU0p/w4qKSv0I1znLJssJHqCO80=;
 b=D7+VxfF9GXmm4hhSJrLa+BsESnEDFCW0a0JVhO2X8x2F1XhzRzG8e0kf3+ZHcFprjMJJK9
 iUKD2pHKHK80wg3zryHOMpm4LEfKLAZZnuYDvkqXWSyI3zvlyIzY28VqrxFbBPUPQL78TE
 rahjSbEfoGOknTbI6CvCWOMtR1Ckj1o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714105737;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=prpKRPZQFCM/0phVZU0p/w4qKSv0I1znLJssJHqCO80=;
 b=nAcg6ruRF2gkVD96g1kW7SXXq7EZls246GJGWMSqkN1BwSqgE92yTbzDJDGTSvkrp8SF09
 QcWEU0WXVhtm4RCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C7BF01398B;
 Fri, 26 Apr 2024 04:28:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id a4j0L4ktK2aeVQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Apr 2024 04:28:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 26 Apr 2024 06:28:51 +0200
Message-ID: <20240426042851.333269-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc: libltpswap: Add kerneldoc
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
 doc/developers/api_c_tests.rst |  4 +++
 include/libswap.h              | 61 +++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index 2c0c8419d..ec53ab33c 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -31,3 +31,7 @@ Capabilities
 ------------
 
 .. kernel-doc:: ../../include/tst_capability.h
+
+libltpswap
+----------
+.. kernel-doc:: ../../include/libswap.h
diff --git a/include/libswap.h b/include/libswap.h
index f757073cc..681849166 100644
--- a/include/libswap.h
+++ b/include/libswap.h
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
+ * Copyright (c) Linux Test Project, 2021-2024
  * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
  */
 
 /*
- * Contains common content for all swapon/swapoff tests
+ * Contains common content for all swapon/swapoff tests.
  */
 
 #ifndef __LIBSWAP_H__
@@ -27,60 +28,96 @@ int make_swapfile(const char *file, const int lineno,
 #define MINIMAL_SWAP_SIZE_MB 1
 
 /**
- * Macro to create minimal swapfile.
+ * MAKE_SMALL_SWAPFILE - create small swap file.
+ *
+ * Macro to create small small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
+ *
+ * @swapfile: swap filename.
  */
 #define MAKE_SMALL_SWAPFILE(swapfile) \
     make_swapfile(__FILE__, __LINE__, swapfile, MINIMAL_SWAP_SIZE_MB, 0, \
 		  SWAPFILE_BY_SIZE)
 
 /**
- * Macro to create minimal swapfile.
+ * SAFE_MAKE_SMALL_SWAPFILE - create small swap file (safe version).
+ *
+ * Macro to create small small swap file. Size defined with MINIMAL_SWAP_SIZE_MB.
  * Includes safety checks to handle potential errors.
+ *
+ * @swapfile: swap filename.
  */
 #define SAFE_MAKE_SMALL_SWAPFILE(swapfile) \
     make_swapfile(__FILE__, __LINE__, swapfile, MINIMAL_SWAP_SIZE_MB, 1, \
 		  SWAPFILE_BY_SIZE)
 
 /**
- * Macro to create swapfile size in megabytes (MB).
+ * MAKE_SWAPFILE_SIZE - create swap file (MB).
+ *
+ * Macro to create swap file, size specified in megabytes (MB).
+ *
+ * @swapfile: swap filename.
+ * @size: swap size in MB.
  */
 #define MAKE_SWAPFILE_SIZE(swapfile, size) \
     make_swapfile(__FILE__, __LINE__, swapfile, size, 0, SWAPFILE_BY_SIZE)
 
 /**
- * Macro to create swapfile size in block numbers.
+ * MAKE_SWAPFILE_BLKS - create swap file (blocks).
+ *
+ * Macro to create swap file, size specified in block numbers.
+ *
+ * @swapfile: swap filename.
+ * @blocks: number of blocks.
  */
 #define MAKE_SWAPFILE_BLKS(swapfile, blocks) \
     make_swapfile(__FILE__, __LINE__, swapfile, blocks, 0, SWAPFILE_BY_BLKS)
 
 /**
- * Macro to safely create swapfile size in megabytes (MB).
+ * SAFE_MAKE_SWAPFILE_SIZE - create swap file (MB, safe version).
+ *
+ * Macro to safely create swap file, size specified in megabytes (MB).
  * Includes safety checks to handle potential errors.
+ *
+ * @swapfile: swap file name.
+ * @size: swap size in MB.
  */
 #define SAFE_MAKE_SWAPFILE_SIZE(swapfile, size) \
     make_swapfile(__FILE__, __LINE__, swapfile, size, 1, SWAPFILE_BY_SIZE)
 
 /**
- * Macro to safely create swapfile size in block numbers.
+ * SAFE_MAKE_SWAPFILE_BLKS - create swap file (block, safe version)
+ *
+ * Macro to safely create swap file, size specified in block numbers.
  * Includes safety checks to handle potential errors.
+ *
+ * @swapfile: swap file name.
+ * @blocks: number of blocks.
  */
 #define SAFE_MAKE_SWAPFILE_BLKS(swapfile, blocks) \
     make_swapfile(__FILE__, __LINE__, swapfile, blocks, 1, SWAPFILE_BY_BLKS)
 
-/*
+/**
+ * is_swap_supported() - Check swapon/swapoff support.
+ *
  * Check swapon/swapoff support status of filesystems or files
  * we are testing on.
+ *
+ * @filename: swap file name.
+ * Return: true if swap is supported, false if not.
  */
 bool is_swap_supported(const char *filename);
 
-/*
- * Get kernel constant MAX_SWAPFILES value.
+/**
+ * tst_max_swapfiles() - Get kernel constant MAX_SWAPFILES value.
  *
+ * Return: MAX_SWAPFILES value.
  */
 int tst_max_swapfiles(void);
 
-/*
- * Get the used swapfiles number.
+/**
+ * tst_count_swaps() - Get the used swapfiles number.
+ *
+ * Return: used swapfiles number.
  */
 int tst_count_swaps(void);
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
