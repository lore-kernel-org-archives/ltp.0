Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE52BE7E630
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 12:47:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D72EF3CDC87
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 14:47:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 662793CE1C8
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 14:46:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A399120175A
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 14:46:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 04BE31F86C;
 Tue, 26 Sep 2023 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695732417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CevMjABn4ph+qULrqktbBjIx4OK2sdQTOZLzHwN7CfA=;
 b=fAeDLuCoo4EiE7UMSXx5bOC6Z/D3rBD+GWzBEY+tbsf1vQchadefo8L0ZgJoBLrjS0XZyo
 FHzVsElJpg0mbwuFTHUorYouVGdEUzZf976IwMjPXimPXSRy3aZY15zMeJgiuoZ9CS+M/f
 BkyWfeGkP23Tpu8Hn/cr2JakmBCQCv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695732417;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CevMjABn4ph+qULrqktbBjIx4OK2sdQTOZLzHwN7CfA=;
 b=4ZXP17nKt4S4PY+6Az0LnpSJffmTjq79KhYepfiGCUkkonS6I7548cXli1EblIJ8T4nXdl
 jMSTfyX24fvfiZBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C85FE13A6A;
 Tue, 26 Sep 2023 12:46:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eNeeL8DSEmXxHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Sep 2023 12:46:56 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 26 Sep 2023 14:46:47 +0200
Message-Id: <20230926124647.152972-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230926124647.152972-1-pvorel@suse.cz>
References: <20230926124647.152972-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC][PATCH 2/2] vma05.sh: Add check for core file presence
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Because we redirect gdb output, add sanity check for core file being
created.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Maybe this sanity check is useless. WDYT?

Kind regards,
Petr

 testcases/kernel/mem/vma/vma05.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
index c9e4becdb..30b1d689a 100755
--- a/testcases/kernel/mem/vma/vma05.sh
+++ b/testcases/kernel/mem/vma/vma05.sh
@@ -54,6 +54,8 @@ vma_report_check()
 
 	rm -rf core*
 	{ vma05_vdso; } > /dev/null 2>&1
+	[ -f core ] || tst_brk TCONF "missing core file"
+
 	TRACE=$(gdb -silent -ex="thread apply all backtrace" -ex="quit"\
 		vma05_vdso ./core* 2> /dev/null)
 	if echo "$TRACE" | grep -qF "??"; then
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
