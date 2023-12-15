Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016E6C4167B
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 18:31:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3F413CE441
	for <ltp@archiver.kernel.org>; Fri, 15 Dec 2023 19:31:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C3BF3CB385
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 19:31:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 32CEF1007C93
 for <ltp@lists.linux.it>; Fri, 15 Dec 2023 19:31:24 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30CC4220BE;
 Fri, 15 Dec 2023 18:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702665084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wn8OxJ7PsEwuoqvsIZSw1296xgoWeYaDulh6u7/Ch9Y=;
 b=k6a3/cLEB5bFeNm/SKwwkgO/QnI1iaNJeJJz6VY8P67Gm4kYsc7nmF1e7Zdp+IAwsQjwyB
 9KcywA4W7gTuFechYy8nZVCINsgn0dVRbXwtyy7ao0F3AhV+/LqSmq8jORRm0vr1UJ7JP3
 KLmv9/j9J2o3po9CvLjYwrKEyR8h8EE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702665084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wn8OxJ7PsEwuoqvsIZSw1296xgoWeYaDulh6u7/Ch9Y=;
 b=bp4Y25xOqz3PxCyJt41OXSPHEPloMSCOVITaQ5TcR1JhmPX6tlqJPrWjWqCae0fN1DoUXD
 08wyck86Qtop3XBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702665084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wn8OxJ7PsEwuoqvsIZSw1296xgoWeYaDulh6u7/Ch9Y=;
 b=k6a3/cLEB5bFeNm/SKwwkgO/QnI1iaNJeJJz6VY8P67Gm4kYsc7nmF1e7Zdp+IAwsQjwyB
 9KcywA4W7gTuFechYy8nZVCINsgn0dVRbXwtyy7ao0F3AhV+/LqSmq8jORRm0vr1UJ7JP3
 KLmv9/j9J2o3po9CvLjYwrKEyR8h8EE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702665084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wn8OxJ7PsEwuoqvsIZSw1296xgoWeYaDulh6u7/Ch9Y=;
 b=bp4Y25xOqz3PxCyJt41OXSPHEPloMSCOVITaQ5TcR1JhmPX6tlqJPrWjWqCae0fN1DoUXD
 08wyck86Qtop3XBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id F30F113BA0;
 Fri, 15 Dec 2023 18:31:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id oLJoOnubfGW2LwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 15 Dec 2023 18:31:23 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 15 Dec 2023 19:31:19 +0100
Message-ID: <20231215183121.57632-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231215183121.57632-1-pvorel@suse.cz>
References: <20231215183121.57632-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [2.03 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.37)[77.06%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; R_MISSING_CHARSET(2.50)[];
 TAGGED_RCPT(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,suse.cz,redhat.com,suse.com];
 RCVD_TLS_ALL(0.00)[]; SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] fsx-linux: Add .max_runtime = 60
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

From: Petr Vorel <petr.vorel@gmail.com>

fsx-linux has entry in the runtest file, where it runs quite long via
-N 100000 (number of operations). While this is ok on normal worker
(runs ~20s), it timeouts on slightly overbooked SUT.

On heavily overbooked SUT it will still require LTP_TIMEOUT_MUL or
LTP_RUNTIME_MUL, but that's expected.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/fs/fsx-linux/fsx-linux.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/fs/fsx-linux/fsx-linux.c b/testcases/kernel/fs/fsx-linux/fsx-linux.c
index 658fc99c3..32fc70e01 100644
--- a/testcases/kernel/fs/fsx-linux/fsx-linux.c
+++ b/testcases/kernel/fs/fsx-linux/fsx-linux.c
@@ -367,6 +367,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
+	.max_runtime = 60,
 	.options = (struct tst_option[]) {
 		{ "l:", &str_file_max_size, "Maximum size in MB of the test file(s) (default 262144)" },
 		{ "o:", &str_op_max_size, "Maximum size for single operation (default 65536)" },
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
