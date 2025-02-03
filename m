Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DE6C02192
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 14:22:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE3613C8EE0
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 15:22:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE0043C53E9
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 15:22:22 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2FCA3212FED
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 15:22:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8089021109;
 Mon,  3 Feb 2025 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738592538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vor17O0OG8Sq1ICAZjzQ0Muu5CJsE8FRGX8BREPUNJw=;
 b=zXtkAsRid4zoiboUFzt53s70FtwsNAcgjFdq0O48bASa3+l3gDmcawpGZ1KnOCZ9pZF6qF
 +h6CJ8y7xdDz73gjkRbi8W0cxaxkE+gbzar47S+6smNdJyuJxOSs22W3lkNbBAivl+gnwQ
 jWaA0OwhuFuwsTwsXT8KkjP0ZakkwyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738592538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vor17O0OG8Sq1ICAZjzQ0Muu5CJsE8FRGX8BREPUNJw=;
 b=VPfxH4gGAyrO7COFm4UuJbRSpAkixtOHArSYFoWen+ue5tvzGK7FW3x5I2oFL7Mj2V1AZM
 7U+k7sKdP0/F91Aw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=zXtkAsRi;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VPfxH4gG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738592538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vor17O0OG8Sq1ICAZjzQ0Muu5CJsE8FRGX8BREPUNJw=;
 b=zXtkAsRid4zoiboUFzt53s70FtwsNAcgjFdq0O48bASa3+l3gDmcawpGZ1KnOCZ9pZF6qF
 +h6CJ8y7xdDz73gjkRbi8W0cxaxkE+gbzar47S+6smNdJyuJxOSs22W3lkNbBAivl+gnwQ
 jWaA0OwhuFuwsTwsXT8KkjP0ZakkwyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738592538;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vor17O0OG8Sq1ICAZjzQ0Muu5CJsE8FRGX8BREPUNJw=;
 b=VPfxH4gGAyrO7COFm4UuJbRSpAkixtOHArSYFoWen+ue5tvzGK7FW3x5I2oFL7Mj2V1AZM
 7U+k7sKdP0/F91Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D58513795;
 Mon,  3 Feb 2025 14:22:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id O71xFRrRoGcUQgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 03 Feb 2025 14:22:18 +0000
Date: Mon, 3 Feb 2025 15:22:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20250203142213.GA1268944@pevik>
References: <20240530144406.7626-1-akumar@suse.de>
 <20240530144846.10915-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240530144846.10915-1-akumar@suse.de>
X-Rspamd-Queue-Id: 8089021109
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 FUZZY_BLOCKED(0.00)[rspamd.com]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] flock: Add test for verifying EINTR errno
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh, all,

...
> +++ b/testcases/kernel/syscalls/flock/flock07.c
...
> +static void handler(int sig)
> +{
> +	tst_res(TINFO, "Received signal: %d", sig);
How about print a signal constant/name?

	tst_res(TINFO, "Received signal: %s (%d)", tst_strsig(sig), sig);
> +}
...
> +static void verify_flock(void)
> +{
> +	pid_t pid;
> +	int fd1 = SAFE_OPEN(TEMPFILE, O_RDWR);
> +	int fd2 = SAFE_OPEN(TEMPFILE, O_RDWR);
How about to setup file descriptors in setup() and close them in cleanup()?

I suggest to merge with the change below.

> +
> +	TST_EXP_PASS(flock(fd1, LOCK_EX));
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		child_do(fd2);
> +		exit(0);
> +	} else {
> +		sleep(1);
> +		SAFE_KILL(pid, SIGUSR1);
> +		SAFE_WAITPID(pid, NULL, 0);
> +	}
> +
> +	SAFE_CLOSE(fd1);
> +	SAFE_CLOSE(fd2);
> +}

Kind regards,
Petr

+++ testcases/kernel/syscalls/flock/flock07.c
@@ -17,14 +17,27 @@
 
 #define TEMPFILE "test_eintr"
 
+static int fd1 = -1, fd2 = -1;
+
 static void handler(int sig)
 {
-	tst_res(TINFO, "Received signal: %d", sig);
+	tst_res(TINFO, "Received signal: %s (%d)", tst_strsig(sig), sig);
 }
 
 static void setup(void)
 {
 	SAFE_TOUCH(TEMPFILE, 0777, NULL);
+	fd1 = SAFE_OPEN(TEMPFILE, O_RDWR);
+	fd2 = SAFE_OPEN(TEMPFILE, O_RDWR);
+}
+
+static void cleanup(void)
+{
+	if (fd1 >= 0)
+		SAFE_CLOSE(fd1);
+
+	if (fd2 >= 0)
+		SAFE_CLOSE(fd2);
 }
 
 static void child_do(int fd)
@@ -42,8 +55,6 @@ static void child_do(int fd)
 static void verify_flock(void)
 {
 	pid_t pid;
-	int fd1 = SAFE_OPEN(TEMPFILE, O_RDWR);
-	int fd2 = SAFE_OPEN(TEMPFILE, O_RDWR);
 
 	TST_EXP_PASS(flock(fd1, LOCK_EX));
 
@@ -56,13 +67,11 @@ static void verify_flock(void)
 		SAFE_KILL(pid, SIGUSR1);
 		SAFE_WAITPID(pid, NULL, 0);
 	}
-
-	SAFE_CLOSE(fd1);
-	SAFE_CLOSE(fd2);
 }
 
 static struct tst_test test = {
 	.setup = setup,
+	.cleanup = cleanup,
 	.test_all = verify_flock,
 	.needs_tmpdir = 1,
 	.needs_root = 1,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
