Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3D2D68B2C
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 14:42:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 424B03D6F55
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 15:42:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A33AA3D6F13
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:40:38 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 247592001B0
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 15:40:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8ACC71F395;
 Thu, 14 Nov 2024 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AROeS1omfolUKlsPA6RMLEZBS8iAU3LQ0K+uSQazKuk=;
 b=FfPDrZNvJ+nd6x42F84ZNvtapSiJeMCkIXQSJ/8WGeFQc/OOt7GUHDUcnyUTp8V1O6Ntdx
 N77rWCQWEo0ajeJ5XklAlZXMUvcvgPxxdh3tQJaOj7ZvEHYF4NcP+uF/UeIwzDFUUf8BnO
 3RrhTF63xg0sjh0nHTik2FizvWKXKIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AROeS1omfolUKlsPA6RMLEZBS8iAU3LQ0K+uSQazKuk=;
 b=9vxBGYI/dVRYVSeaetU8heEnnseBv1cYB38wTS0C2IktNl1XjIu1rwSCtbMsCYsY4Ko1j3
 yov2DGvb+C/EXvDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FfPDrZNv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="9vxBGYI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731595235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AROeS1omfolUKlsPA6RMLEZBS8iAU3LQ0K+uSQazKuk=;
 b=FfPDrZNvJ+nd6x42F84ZNvtapSiJeMCkIXQSJ/8WGeFQc/OOt7GUHDUcnyUTp8V1O6Ntdx
 N77rWCQWEo0ajeJ5XklAlZXMUvcvgPxxdh3tQJaOj7ZvEHYF4NcP+uF/UeIwzDFUUf8BnO
 3RrhTF63xg0sjh0nHTik2FizvWKXKIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731595235;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AROeS1omfolUKlsPA6RMLEZBS8iAU3LQ0K+uSQazKuk=;
 b=9vxBGYI/dVRYVSeaetU8heEnnseBv1cYB38wTS0C2IktNl1XjIu1rwSCtbMsCYsY4Ko1j3
 yov2DGvb+C/EXvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6974513B14;
 Thu, 14 Nov 2024 14:40:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AN3XGOMLNmeSdwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 14 Nov 2024 14:40:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 14 Nov 2024 15:40:26 +0100
Message-ID: <20241114144029.349559-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114144029.349559-1-pvorel@suse.cz>
References: <20241114144029.349559-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 8ACC71F395
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] mq_timedsend01: Remove unneeded designated
 initializers
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
 .../kernel/syscalls/mq_timedsend/mq_timedsend01.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index 2636066861..35bf4445f5 100644
--- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
+++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
@@ -22,28 +22,19 @@ static void *bad_addr;
 static struct test_case tcase[] = {
 	{
 		.fd = &fd,
-		.len = 0,
-		.ret = 0,
-		.err = 0,
 	},
 	{
 		.fd = &fd,
 		.len = 1,
-		.ret = 0,
-		.err = 0,
 	},
 	{
 		.fd = &fd,
 		.len = MAX_MSGSIZE,
-		.ret = 0,
-		.err = 0,
 	},
 	{
 		.fd = &fd,
 		.len = 1,
 		.prio = MQ_PRIO_MAX - 1,
-		.ret = 0,
-		.err = 0,
 	},
 	{
 		.fd = &fd,
@@ -53,19 +44,16 @@ static struct test_case tcase[] = {
 	},
 	{
 		.fd = &fd_invalid,
-		.len = 0,
 		.ret = -1,
 		.err = EBADF,
 	},
 	{
 		.fd = &fd_maxint,
-		.len = 0,
 		.ret = -1,
 		.err = EBADF,
 	},
 	{
 		.fd = &fd_root,
-		.len = 0,
 		.ret = -1,
 		.err = EBADF,
 	},
@@ -86,7 +74,6 @@ static struct test_case tcase[] = {
 		.fd = &fd,
 		.len = 16,
 		.tv_sec = -1,
-		.tv_nsec = 0,
 		.rq = &ts,
 		.send = 1,
 		.ret = -1,
@@ -95,7 +82,6 @@ static struct test_case tcase[] = {
 	{
 		.fd = &fd,
 		.len = 16,
-		.tv_sec = 0,
 		.tv_nsec = -1,
 		.rq = &ts,
 		.send = 1,
@@ -105,7 +91,6 @@ static struct test_case tcase[] = {
 	{
 		.fd = &fd,
 		.len = 16,
-		.tv_sec = 0,
 		.tv_nsec = 1000000000,
 		.rq = &ts,
 		.send = 1,
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
