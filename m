Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559FF1090247
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 16:04:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDE913E30BC
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 17:04:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16E913E4831
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 17:03:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7E4B56003C9
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 17:03:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B8ECA5BD49;
 Thu, 19 Mar 2026 16:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773936213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3wB4WIw2UijUFLSx3Kqyxt3dbJDidjeRTzc+ZFDcfU=;
 b=aTd+jRfHJT4aja5xfyxK94tPWtDJzIRBBzcjkmjOo/fSSeqh3A/FQ2iG0cJmntNNA/8wYS
 QDYIJJkK0Nn/HL1l73ddm9NJvL3desvVjK3psBHBxokE0a5aaPlRegWdZ1XiafS3dY0bmu
 MDsmKvB+4VbWHNfDNd2cXo7pN9GDH5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773936213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3wB4WIw2UijUFLSx3Kqyxt3dbJDidjeRTzc+ZFDcfU=;
 b=ocF32PnlD0fFWtB2fHVmC5M7DVvOTCpvp/CzUpQ1xsSCNlCEMHih9gxJxTwYFiuOI0PcaQ
 4LzGMwxpCr7em5BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2QIoEoJW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iAaCS+jN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773936212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3wB4WIw2UijUFLSx3Kqyxt3dbJDidjeRTzc+ZFDcfU=;
 b=2QIoEoJW8gB0CWXNUYWJ12TD2f/aOh4JcqRWXKThFwPLxtI3d6WntJ32k6WFD/F56Aon+g
 /n7Pnv8PkwEMqVvRepGj96bT5EaeduMXoE8lRw8gIi6INi0031B05PkdGosP5LlY/9LffL
 D2GqrETnNedlIC06XwcCro1DuvI+Zu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773936212;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K3wB4WIw2UijUFLSx3Kqyxt3dbJDidjeRTzc+ZFDcfU=;
 b=iAaCS+jNr4T8h0/Vi15i83bOdN7HBD/1ZzHKxBSEHegm04nsUMQIRgg3rB0CFfI0jMsX88
 eeQQs+KctO4jMcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A30AE4273B;
 Thu, 19 Mar 2026 16:03:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HpuDJlQevGnzWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Mar 2026 16:03:32 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 19 Mar 2026 17:03:18 +0100
Message-ID: <20260319160318.6867-3-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260319160318.6867-1-chrubis@suse.cz>
References: <20260319160318.6867-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: B8ECA5BD49
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] runtest: ltp-aiodio.part2: Limit the maximal
 filesize
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

The test was operating with filesize up to ~500MB which, in certain
cases, was making the runtime too slow. Some test variants, especially
with many processes, were running up to 15 mintues on modern hardware.
After a discussion we agreed that we can reduce the maximal file size to
one quater without sacrificing test coverage.

I've also assumed that there was a typo in ADSP072 since the buffer size
was set to be order of magnitude bigger than the file size.

CC: Jan Kara <jack@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/ltp-aiodio.part2 | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/runtest/ltp-aiodio.part2 b/runtest/ltp-aiodio.part2
index 599c9fd2f..c82f6fd02 100644
--- a/runtest/ltp-aiodio.part2
+++ b/runtest/ltp-aiodio.part2
@@ -25,8 +25,8 @@ ADSP023 aiodio_sparse -o 4 -w 1024k -s 4096k -n 6
 ADSP024 aiodio_sparse -o 4 -w 2048k -s 8192k -n 6
 ADSP025 aiodio_sparse -o 4 -w 4096k -s 16384k -n 6
 ADSP026 aiodio_sparse -o 4 -w 18192k -s 72768k -n 6
-ADSP027 aiodio_sparse -o 4 -w 18192k -s 518192k -n 6
-ADSP028 aiodio_sparse -o 4 -w 65536k -s 262144k -n 6
+ADSP027 aiodio_sparse -o 4 -w 18192k -s 129548k -n 6
+ADSP028 aiodio_sparse -o 4 -w 65536k -s 129548k -n 6
 ADSP029 aiodio_sparse -o 6 -w 65536k -n 6
 ADSP030 aiodio_sparse -o 8 -w 128k -s 1024k -n 6
 ADSP031 aiodio_sparse -o 16 -w 256k -s 4096k -n 6
@@ -55,7 +55,7 @@ ADSP053 dio_sparse  -w 2048k -s 2048k -n 2
 ADSP054 dio_sparse  -w 4096k -s 4096k -n 2
 ADSP055 dio_sparse  -w 8192k -s 8192k -n 2
 ADSP056 dio_sparse  -w 18192k -s 18192k -n 2
-ADSP057 dio_sparse  -w 518192k -s 518192k -n 2
+ADSP057 dio_sparse  -w 129548k -s 129548k -n 2
 ADSP058 dio_sparse  -w 58192k -s 58192k -n 4
 ADSP059 dio_sparse  -w 58192k -s 58192k -n 6
 ADSP060 dio_sparse  -w 256k -s 256k -n 6
@@ -65,14 +65,14 @@ ADSP063 dio_sparse  -w 2048k -s 2048k -n 6
 ADSP064 dio_sparse  -w 2048k -s 4096k -n 6
 ADSP065 dio_sparse  -w 8192k -s 8192k -n 6
 ADSP066 dio_sparse  -w 18192k -s 18192k -n 6
-ADSP067 dio_sparse  -w 58192k -s 518192k -n 6
-ADSP068 dio_sparse  -w 518192k -s 518192k -n 6
+ADSP067 dio_sparse  -w 58192k -s 129548k -n 6
+ADSP068 dio_sparse  -w 129548k -s 129548k -n 6
 ADSP069 dio_sparse  -w 1024k -s 2048k -n 6
 ADSP070 dio_sparse  -w 4096k -s 4096k -n 32
 ADSP071 dio_sparse  -w 8192k -s 8192k -n 64
-ADSP072 dio_sparse  -w 518192k -s 18192k -n 128
-ADSP073 dio_sparse  -w 518192k -s 518192k -n 512
-ADSP074 dio_sparse  -w 518192k -s 518192k -n 1000
+ADSP072 dio_sparse  -w 129548k -s 129548k -n 128
+ADSP073 dio_sparse  -w 129548k -s 129548k -n 512
+ADSP074 dio_sparse  -w 129548k -s 129548k -n 1000
 ADSP075 dio_sparse  -w 4k -s 2k -o 2k -n 2
 ADSP076 dio_sparse  -w 2k -s 1k -o 1k -n 2
 ADSP077 dio_sparse  -w 1k -s 512 -o 512 -n 2
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
