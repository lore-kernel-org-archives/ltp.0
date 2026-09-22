Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA007C982F1
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 09:51:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D73573E6C93
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 11:51:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9799C3E2563
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 11:51:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2CF8A600906
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 11:51:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE84C1F816;
 Tue, 22 Sep 2026 09:51:32 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790070692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5KjZhq+91uSFsVMRbML9aJy2Jm+cKonbT6/uB/DlbI=;
 b=b3cW13Ooji0KwZ95cKuYf4aqW65r4IDRGVEbiMiTvFAbZe99SETMbbqL70tOpFGycwSTLU
 bWCyDbjSERWEJmDaTd2e3MUKJ6R1HrJpJG9fBJPJMLJirEm8lYnJ+blY5eSkK2ArGf2fiQ
 lJmgYw9YIZy4ft33lHF/HQB//TWbCXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790070692;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M5KjZhq+91uSFsVMRbML9aJy2Jm+cKonbT6/uB/DlbI=;
 b=/LY4tmnSwHc6OlALjNY3U7ESR+mTE0BMWXR7Q6y4OrlDikNWI4b11gqvQ9ic5/wOUciqrg
 nt/8ImqSw5CDqoBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7521C139EE;
 Tue, 22 Sep 2026 09:51:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +4HeBKRPsmrAfgAAD6G6ig:T2
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 09:51:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 22 Sep 2026 11:51:26 +0200
Message-ID: <20260922095126.2169599-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922095126.2169599-1-pvorel@suse.cz>
References: <20260922095126.2169599-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: DE84C1F816
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] autotools: Move into configure.ac
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

Checking <linux/keyctl.h> is unrelated on checking of libkeyutils,
therefore it's probably better to have it together with other struct
checks.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2.

 configure.ac       | 4 ++++
 m4/ltp-keyutils.m4 | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 18bfdb88c7..bc6df5ada3 100644
--- a/configure.ac
+++ b/configure.ac
@@ -300,6 +300,10 @@ AC_CHECK_TYPES([struct uffdio_move],,,[#include <linux/userfaultfd.h>])
 AC_CHECK_TYPES([struct uffdio_poison],,,[#include <linux/userfaultfd.h>])
 AC_CHECK_TYPES([struct uffdio_writeprotect],,,[#include <linux/userfaultfd.h>])
 
+# see also m4/ltp-keyutils.m4
+AC_CHECK_TYPES([struct keyctl_kdf_params, struct keyctl_pkey_query, struct keyctl_pkey_params],,,
+[#include <linux/keyctl.h>])
+
 # Tools knobs
 
 # Bash
diff --git a/m4/ltp-keyutils.m4 b/m4/ltp-keyutils.m4
index b073183405..23132664c7 100644
--- a/m4/ltp-keyutils.m4
+++ b/m4/ltp-keyutils.m4
@@ -8,7 +8,4 @@ AC_DEFUN([LTP_CHECK_KEYUTILS_SUPPORT], [
 	AC_CHECK_LIB([keyutils], [add_key],
 	[AC_DEFINE(HAVE_LIBKEYUTILS, 1, [Define to 1 if you have libkeyutils installed.])
 	      AC_SUBST(KEYUTILS_LIBS, "-lkeyutils")])
-
-	AC_CHECK_TYPES([struct keyctl_kdf_params, struct keyctl_pkey_query, struct keyctl_pkey_params],,,
-			[#include <linux/keyctl.h>])
 ])
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
