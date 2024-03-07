Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CA8C5475B
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 06:40:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 328D93CE974
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 07:40:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA6683CC75A
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 07:39:53 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F2A6C60227A
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 07:39:52 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 401003739A;
 Thu,  7 Mar 2024 23:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709853921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+bcd8Gu1HttZrARDKVKk5up3oP/zlk3Rkk71x8WxoU=;
 b=vAM4iNzDKhUdWctKw6+6APJfW75anBaAZaSHZv8VGX9j57TNL2Ln2qI4Toj+ecJcjxwVDF
 atq6jXfNzMnSs9FaZp0zlCh3EYoGZskzPL8LI3DwjiWVOpf3gH3gW3U46JtaY/BKM4Elf4
 Ta2YRTWtuEoHKaks/vshFgfNdQLbCr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709853921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+bcd8Gu1HttZrARDKVKk5up3oP/zlk3Rkk71x8WxoU=;
 b=O2LQCBJjhH1OCPSPeH5emNHHdl8KSKqypk9K12AgGBk4LAkgx5GMfeGSsX6XL7kb+ettKD
 qL3o1KhJKRjyN4Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709853921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+bcd8Gu1HttZrARDKVKk5up3oP/zlk3Rkk71x8WxoU=;
 b=vAM4iNzDKhUdWctKw6+6APJfW75anBaAZaSHZv8VGX9j57TNL2Ln2qI4Toj+ecJcjxwVDF
 atq6jXfNzMnSs9FaZp0zlCh3EYoGZskzPL8LI3DwjiWVOpf3gH3gW3U46JtaY/BKM4Elf4
 Ta2YRTWtuEoHKaks/vshFgfNdQLbCr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709853921;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c+bcd8Gu1HttZrARDKVKk5up3oP/zlk3Rkk71x8WxoU=;
 b=O2LQCBJjhH1OCPSPeH5emNHHdl8KSKqypk9K12AgGBk4LAkgx5GMfeGSsX6XL7kb+ettKD
 qL3o1KhJKRjyN4Bw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0ED2F13ACE;
 Thu,  7 Mar 2024 23:25:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id SI2iAOFM6mWrSQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Mar 2024 23:25:21 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  8 Mar 2024 00:25:11 +0100
Message-ID: <20240307232511.228396-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240307232511.228396-1-pvorel@suse.cz>
References: <20240307232511.228396-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Bar: ++++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vAM4iNzD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O2LQCBJj
X-Spamd-Result: default: False [4.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,wikipedia.org:url];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Queue-Id: 401003739A
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] doc: Mention tst_get_tmpdir() need to be freed
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
 doc/C-Test-API.asciidoc                        | 8 ++++++++
 doc/Maintainer-Patch-Review-Checklist.asciidoc | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
index 90cf1df43..2bc3d6255 100644
--- a/doc/C-Test-API.asciidoc
+++ b/doc/C-Test-API.asciidoc
@@ -2446,6 +2446,14 @@ static struct tst_test test = {
 };
 -------------------------------------------------------------------------------
 
+1.44 Path to the temporary directory
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+'tst_get_tmpdir()' returns a path to the test temporary directory in a newly
+allocated buffer. Therefore it's needed to either 1) call it only once in the setup,
+or 2) free the variable after use if it's reused (i.e. run in the test function).
+Alternatively '"."' (relative path) can be used (test chdir to the temporary directory).
+
 2. Common problems
 ------------------
 
diff --git a/doc/Maintainer-Patch-Review-Checklist.asciidoc b/doc/Maintainer-Patch-Review-Checklist.asciidoc
index 452de0d49..12d323171 100644
--- a/doc/Maintainer-Patch-Review-Checklist.asciidoc
+++ b/doc/Maintainer-Patch-Review-Checklist.asciidoc
@@ -126,6 +126,8 @@ New test should
 * When rewriting old tests, https://en.wikipedia.org/wiki/%CE%9CClinux[uClinux]
   support should be removed (project has been discontinued).
   E.g. remove `#ifdef UCLINUX`, replace `FORK_OR_VFORK()` with simple `fork()` or `SAFE_FORK()`.
+* 'tst_get_tmpdir()' should be called in the setup function or the variable must be freed after use
+  (more in https://github.com/linux-test-project/ltp/wiki/C-Test-API#144-path-to-the-temporary-directory[C API]).
 
 ### Shell tests
 * Use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell[shell API]
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
