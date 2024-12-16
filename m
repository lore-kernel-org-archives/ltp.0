Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 732FDE7717F
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 22:05:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0C2C3EC5B5
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 23:05:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 854A33CE345
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 23:04:58 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD1721A00897
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 23:04:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9C6EE1F38C;
 Mon, 16 Dec 2024 22:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734386696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h5F4PjLHWUhceKwVDD2NBcaGdCVUqweIFSOBz2mtg7s=;
 b=X5hmlACgmnf3veMdBm0tVffzFUJ0uuxDKfi/Oe2AdBjbwZ6WoHRjnamg1ZlT7zFhpR6t4M
 ZMw2fpUpfPDJqimUWew6OcCLtH5f01ZadiYU68Vwq+olaAUaG7996foRyeJwJX/h7aEHz7
 EgESgrc6I+H4LzhyusLT3Ll7oQh2T9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734386696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h5F4PjLHWUhceKwVDD2NBcaGdCVUqweIFSOBz2mtg7s=;
 b=t9CuvudRCaGtguihtF7U8riO/4xzFbVf70JujnZOmwprt/I88mw7lbs4iNSXht0uHmgbdG
 XE1aZB8Xy3msDuDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734386696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h5F4PjLHWUhceKwVDD2NBcaGdCVUqweIFSOBz2mtg7s=;
 b=X5hmlACgmnf3veMdBm0tVffzFUJ0uuxDKfi/Oe2AdBjbwZ6WoHRjnamg1ZlT7zFhpR6t4M
 ZMw2fpUpfPDJqimUWew6OcCLtH5f01ZadiYU68Vwq+olaAUaG7996foRyeJwJX/h7aEHz7
 EgESgrc6I+H4LzhyusLT3Ll7oQh2T9g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734386696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h5F4PjLHWUhceKwVDD2NBcaGdCVUqweIFSOBz2mtg7s=;
 b=t9CuvudRCaGtguihtF7U8riO/4xzFbVf70JujnZOmwprt/I88mw7lbs4iNSXht0uHmgbdG
 XE1aZB8Xy3msDuDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 455DF139D4;
 Mon, 16 Dec 2024 22:04:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MaPbDAikYGf3eAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 16 Dec 2024 22:04:56 +0000
Date: Mon, 16 Dec 2024 23:04:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <20241216220454.GA652340@pevik>
References: <20240913094615.245573-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240913094615.245573-1-maxj.fnst@fujitsu.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_getattr02: refactor with new LTP API
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

Hi Ma Xinjian,

There was missing static:

$ make check-sched_getattr02
CHECK testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
sched_getattr02.c:28:19: warning: Symbol 'attr_copy' has no prototype or library ('tst_') prefix. Should it be static?

> +static void verify_sched_getattr(unsigned int n)
>  {
> -	TEST(sched_getattr(*(test->pid), test->a, test->size,
> -			test->flags));
> +	struct test_case *tc = tcase + n;
> +
> +	TEST(sched_getattr(*(tc->pid), tc->a, tc->size, tc->flags));

> -	if (TEST_RETURN != -1) {
> -		tst_resm(TFAIL, "sched_getattr() succeeded unexpectedly.");
> +	if (TST_RET != -1) {
> +		tst_res(TFAIL, "sched_getattr() succeeded unexpectedly.");
>  		return;
>  	}

> -	if (TEST_ERRNO == test->exp_errno) {
> -		tst_resm(TPASS | TTERRNO,
> -			"sched_getattr() failed expectedly");
> +	if (TST_ERR == tc->exp_errno) {
> +		tst_res(TPASS | TTERRNO, "sched_getattr() failed expectedly");
>  		return;
>  	}

> -	tst_resm(TFAIL | TTERRNO, "sched_getattr() failed unexpectedly "
> +	tst_res(TFAIL | TTERRNO, "sched_getattr() failed unexpectedly "
>  		": expected: %d - %s",
> -		test->exp_errno, tst_strerrno(test->exp_errno));
> +		tc->exp_errno, tst_strerrno(tc->exp_errno));
>  }

We have TST_EXP_FAIL() for it. Merged with following diff.
Thanks!

Kind regards,
Petr

+++ testcases/kernel/syscalls/sched_getattr/sched_getattr02.c
@@ -7,7 +7,7 @@
 /*\
  * [Description]
  *
- * Verify that, sched_getattr(2) returns -1 and sets errno to
+ * Verify that, sched_getattr(2) returns -1 and sets errno to:
  *
  * 1. ESRCH if pid is unused.
  * 2. EINVAL if address is NULL.
@@ -18,18 +18,16 @@
 #define _GNU_SOURCE
 
 #include <errno.h>
-#include <string.h>
-
 #include "tst_test.h"
 #include "lapi/sched.h"
 
 static pid_t pid;
 static pid_t unused_pid;
-struct sched_attr attr_copy;
+static struct sched_attr attr_copy;
 
 static struct test_case {
 	pid_t *pid;
-	struct sched_attr *a;
+	struct sched_attr *attr;
 	unsigned int size;
 	unsigned int flags;
 	int exp_errno;
@@ -42,23 +40,11 @@ static struct test_case {
 
 static void verify_sched_getattr(unsigned int n)
 {
-	struct test_case *tc = tcase + n;
-
-	TEST(sched_getattr(*(tc->pid), tc->a, tc->size, tc->flags));
-
-	if (TST_RET != -1) {
-		tst_res(TFAIL, "sched_getattr() succeeded unexpectedly.");
-		return;
-	}
-
-	if (TST_ERR == tc->exp_errno) {
-		tst_res(TPASS | TTERRNO, "sched_getattr() failed expectedly");
-		return;
-	}
+	struct test_case *tc = &tcase[n];
 
-	tst_res(TFAIL | TTERRNO, "sched_getattr() failed unexpectedly "
-		": expected: %d - %s",
-		tc->exp_errno, tst_strerrno(tc->exp_errno));
+	TST_EXP_FAIL(sched_getattr(*(tc->pid), tc->attr, tc->size, tc->flags),
+				 tc->exp_errno, "sched_getattr(%d, ..., %d, %d)", *tc->pid,
+				 tc->size, tc->flags);
 }
 
 static void setup(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
