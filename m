Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FB3C47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 16:27:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6544C3CFB75
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 17:27:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F0AE3CB939
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 17:26:54 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 81A031A027AC
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 17:26:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CBE00222FF;
 Tue, 23 Jan 2024 16:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706027212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gEZ0ocnlrCVpMTAzCOuU9Bk9p7S58WnKpUvBYNQjILM=;
 b=sQv9CCA5w4GulG9kkVVpHr9FjA87ni7mwR9MLa0/hvFBHlUyRJeJvmmiyIGyKboGrrHh/j
 Mfo+UgKLrV6B2geOgY7c9RbLNTyMCSs2QWtaZjHAWLDwYrDL/+ywbDy5wCm/8vu+NV0z+i
 VXVtns3CWW5olclt0uOgmL+Nj6GY2x4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706027212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gEZ0ocnlrCVpMTAzCOuU9Bk9p7S58WnKpUvBYNQjILM=;
 b=99RZpg5i9FXNeqHLIqh8YwvhD+i7Omz4DU0PZKIo6RPCIOV4Qr0KCd60xOUkYLLajjmXtG
 lhPIorj3VcutLGDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706027212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gEZ0ocnlrCVpMTAzCOuU9Bk9p7S58WnKpUvBYNQjILM=;
 b=sQv9CCA5w4GulG9kkVVpHr9FjA87ni7mwR9MLa0/hvFBHlUyRJeJvmmiyIGyKboGrrHh/j
 Mfo+UgKLrV6B2geOgY7c9RbLNTyMCSs2QWtaZjHAWLDwYrDL/+ywbDy5wCm/8vu+NV0z+i
 VXVtns3CWW5olclt0uOgmL+Nj6GY2x4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706027212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gEZ0ocnlrCVpMTAzCOuU9Bk9p7S58WnKpUvBYNQjILM=;
 b=99RZpg5i9FXNeqHLIqh8YwvhD+i7Omz4DU0PZKIo6RPCIOV4Qr0KCd60xOUkYLLajjmXtG
 lhPIorj3VcutLGDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51339139B1;
 Tue, 23 Jan 2024 16:26:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uDO9EMzor2V+CwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Jan 2024 16:26:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 23 Jan 2024 17:26:44 +0100
Message-ID: <20240123162647.210424-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123162647.210424-1-pvorel@suse.cz>
References: <20240123162647.210424-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.56 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[6];
 NEURAL_HAM_LONG(-0.99)[-0.992]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.17)[-0.874]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.17)[70.06%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/4] tst_test.sh: Improve info on wrong tst_brk param
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

Print wrong $res parameter in tst_brk helps searching wrong code.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 05a920156..0d2fccb95 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -135,7 +135,7 @@ tst_brk()
 	fi
 
 	if [ "$res" != TBROK -a "$res" != TCONF ]; then
-		tst_res TBROK "tst_brk can be called only with TBROK or TCONF"
+		tst_res TBROK "tst_brk can be called only with TBROK or TCONF ($res)"
 	else
 		tst_res "$res" "$@"
 	fi
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
