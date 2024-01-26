Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2618C47DDF
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 12:16:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 308453D060C
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 13:16:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEDBF3D00E5
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 13:16:09 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0D90A603290
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 13:16:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DBCDA1FB7F;
 Fri, 26 Jan 2024 12:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706271367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FPbGIEE5AI8OQq4UCsd4Edc0507cGpaorwrdYeG5sOo=;
 b=YBP/UaBrnFLePxKrRNJQZgaXvXdjdAVAnhBzh8gn3Ce4hi6pUVi3cbuB+4cLKZDeFFhoOj
 O0h7h0ZB/HQHb6XrWRiHOCKk5FuL8Fvz29CVHiNWtkGxQRkxF/JXCRs8AdgNVMDqXBb8Qx
 rtyBjX3eiisAQjbNOK7dj9h1oWUw1S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706271367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FPbGIEE5AI8OQq4UCsd4Edc0507cGpaorwrdYeG5sOo=;
 b=xjnTZnn1XJogV7wyPvYRDoLdi/g2GMiZ2DioAvf99XUacAoYwB1V5zmo/KO9V6XMrhj0ry
 Eao+1ybjATn5CMAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706271367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FPbGIEE5AI8OQq4UCsd4Edc0507cGpaorwrdYeG5sOo=;
 b=YBP/UaBrnFLePxKrRNJQZgaXvXdjdAVAnhBzh8gn3Ce4hi6pUVi3cbuB+4cLKZDeFFhoOj
 O0h7h0ZB/HQHb6XrWRiHOCKk5FuL8Fvz29CVHiNWtkGxQRkxF/JXCRs8AdgNVMDqXBb8Qx
 rtyBjX3eiisAQjbNOK7dj9h1oWUw1S0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706271367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=FPbGIEE5AI8OQq4UCsd4Edc0507cGpaorwrdYeG5sOo=;
 b=xjnTZnn1XJogV7wyPvYRDoLdi/g2GMiZ2DioAvf99XUacAoYwB1V5zmo/KO9V6XMrhj0ry
 Eao+1ybjATn5CMAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 914EA13A22;
 Fri, 26 Jan 2024 12:16:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id StfOIYeis2U9RgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 26 Jan 2024 12:16:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 26 Jan 2024 13:16:03 +0100
Message-ID: <20240126121603.500470-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [4.87 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.03)[56.45%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] splice07: Whitelist /dev/zero on pipe write
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

/dev/zero on pipe write started to succeeded on kernel 6.7.

This is due commit 1b057bd800c3 ("drivers/char/mem: implement splice()
for /dev/zero, /dev/full") from kernel 6.7.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v1->v2:
* Skip only for kernel >= 6.7

 testcases/kernel/syscalls/splice/splice07.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
index 135c42e47..c7b1c9ee5 100644
--- a/testcases/kernel/syscalls/splice/splice07.c
+++ b/testcases/kernel/syscalls/splice/splice07.c
@@ -44,6 +44,10 @@ static void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
 		/* And this complains about socket not being connected */
 		case TST_FD_INET_SOCK:
 			return;
+		/* 1b057bd800c3 implemented splice() for /dev/zero, /dev/full */
+		case TST_FD_DEV_ZERO:
+			if (tst_kvercmp(6, 7, 0) >= 0)
+				return;
 		default:
 		break;
 		}
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
