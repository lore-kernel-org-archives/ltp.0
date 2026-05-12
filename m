Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E774BCD4F24
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 16:28:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A65193D7B90
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 18:28:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D9C13CCB46
 for <ltp@lists.linux.it>; Tue, 12 May 2026 18:27:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C5C3D600481
 for <ltp@lists.linux.it>; Tue, 12 May 2026 18:27:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 835AF6C475
 for <ltp@lists.linux.it>; Tue, 12 May 2026 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778603260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggBI7S2RknSkkJ1MXq8uoFX60b6D8ZJwsmCACWF8zY8=;
 b=1dzF5yLflRu0pbAUE85sKEAc3sr01/peOICImWd6rnvJEgMmgvWb5W9u3g8D2x68VNHI/4
 0OxOjE+EJzCgQ6GNHricvs1edH6V6JQ6O1xNMTFGy+4qBedanzdz1W9UtA/Hr7t4Vz7nOS
 lweTzMFhjgNSFEnwp1p74EYDK8e+Sv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778603260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggBI7S2RknSkkJ1MXq8uoFX60b6D8ZJwsmCACWF8zY8=;
 b=74imAtVJXX/scm5xrhN8VaHOx6CfugU+y0QYjMbEo0l4i44awaRWSr1rRGywdowClAF/xW
 INNzCQx4nWXP+1Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778603260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggBI7S2RknSkkJ1MXq8uoFX60b6D8ZJwsmCACWF8zY8=;
 b=1dzF5yLflRu0pbAUE85sKEAc3sr01/peOICImWd6rnvJEgMmgvWb5W9u3g8D2x68VNHI/4
 0OxOjE+EJzCgQ6GNHricvs1edH6V6JQ6O1xNMTFGy+4qBedanzdz1W9UtA/Hr7t4Vz7nOS
 lweTzMFhjgNSFEnwp1p74EYDK8e+Sv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778603260;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ggBI7S2RknSkkJ1MXq8uoFX60b6D8ZJwsmCACWF8zY8=;
 b=74imAtVJXX/scm5xrhN8VaHOx6CfugU+y0QYjMbEo0l4i44awaRWSr1rRGywdowClAF/xW
 INNzCQx4nWXP+1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78D0E593AA
 for <ltp@lists.linux.it>; Tue, 12 May 2026 16:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sJY8HfxUA2oyDAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 12 May 2026 16:27:40 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 12 May 2026 18:27:17 +0200
Message-ID: <20260512162735.80055-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512162735.80055-1-mdoucha@suse.cz>
References: <20260512162735.80055-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] af_alg08: Allow recv() to return EINVAL
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

Recent kernels return EBADMSG from recv() when the crypto operation
fails. However, older kernels return EINVAL instead. Accept both
errno values.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/crypto/af_alg08.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/crypto/af_alg08.c b/testcases/kernel/crypto/af_alg08.c
index 5e04b579c..937ab1758 100644
--- a/testcases/kernel/crypto/af_alg08.c
+++ b/testcases/kernel/crypto/af_alg08.c
@@ -60,6 +60,10 @@ static int algfd = -1;
 static int reqfd = -1;
 static int pipefd[2] = { -1, -1 };
 static int file_fd = -1;
+static const int exp_errnos[] = {
+	EBADMSG,
+	EINVAL
+};
 
 static void try_corrupt(void)
 {
@@ -100,7 +104,8 @@ static void try_corrupt(void)
 	SAFE_SPLICE(pipefd[0], NULL, reqfd, NULL, OVERWRITE_SIZE, 0);
 
 	/* Expected to fail (invalid ciphertext); triggers the scratch write */
-	TST_EXP_FAIL_SILENT(recv(reqfd, recvbuf, sizeof(recvbuf), 0), EBADMSG);
+	TST_EXP_FAIL_ARR_SILENT(recv(reqfd, recvbuf, sizeof(recvbuf), 0),
+		exp_errnos, ARRAY_SIZE(exp_errnos));
 
 	SAFE_CLOSE(pipefd[0]);
 	SAFE_CLOSE(pipefd[1]);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
