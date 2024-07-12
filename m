Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564E4C3DA45
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 08:14:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 901F83D198D
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 10:14:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07E8F3C1037
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 10:14:03 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5CD831BB931C
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 10:14:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75B9F21A8F;
 Fri, 12 Jul 2024 08:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720772042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5ZEY356s4agG8lEPDxlmoIPQ0Shh7u4Fj/v8h7o/PQ=;
 b=EwrJQ5kBRo8buY3DXMK6ZMfZCBQLkK+jNoJkJLhMLHEy/lvmue9Ra0EUg2mL8CkpksXO6G
 HENpfSt5Ole2H6xO7CtPWOx19zMhTvq1/3Rso/uMfXnvqyNCMTH2EpJh5XCzLHi6nhmJeU
 0s/Q+Jq7+NDtn7g1gEMMmyySwW1rkqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720772042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5ZEY356s4agG8lEPDxlmoIPQ0Shh7u4Fj/v8h7o/PQ=;
 b=wdzQ/iO3NaQWgcVpLmWpeH4mZ6aUzsuZM+ibtYk5GYPQ8InDCMeKM8SR2GlYLz8vTyMLTw
 mMLew9J7/T//IGDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720772042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5ZEY356s4agG8lEPDxlmoIPQ0Shh7u4Fj/v8h7o/PQ=;
 b=EwrJQ5kBRo8buY3DXMK6ZMfZCBQLkK+jNoJkJLhMLHEy/lvmue9Ra0EUg2mL8CkpksXO6G
 HENpfSt5Ole2H6xO7CtPWOx19zMhTvq1/3Rso/uMfXnvqyNCMTH2EpJh5XCzLHi6nhmJeU
 0s/Q+Jq7+NDtn7g1gEMMmyySwW1rkqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720772042;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y5ZEY356s4agG8lEPDxlmoIPQ0Shh7u4Fj/v8h7o/PQ=;
 b=wdzQ/iO3NaQWgcVpLmWpeH4mZ6aUzsuZM+ibtYk5GYPQ8InDCMeKM8SR2GlYLz8vTyMLTw
 mMLew9J7/T//IGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D77D1373E;
 Fri, 12 Jul 2024 08:14:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EKz+DcrlkGYOfwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 12 Jul 2024 08:14:02 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 12 Jul 2024 10:13:59 +0200
Message-ID: <20240712081359.116227-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240712081359.116227-1-pvorel@suse.cz>
References: <20240712081359.116227-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [1.20 / 50.00]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] doc/C API: Add tst_tmpdir.h
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

Header created in the previous commit.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/api_c_tests.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/developers/api_c_tests.rst b/doc/developers/api_c_tests.rst
index 164f825044..74185c29ec 100644
--- a/doc/developers/api_c_tests.rst
+++ b/doc/developers/api_c_tests.rst
@@ -37,3 +37,7 @@ Capabilities
 libltpswap
 ----------
 .. kernel-doc:: ../../include/libswap.h
+
+Temporary directory
+-------------------
+.. kernel-doc:: ../../include/tst_tmpdir.h
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
