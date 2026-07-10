Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0FDC43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 12:28:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B06303E6092
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 14:28:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90E383E273F
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 14:28:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A03CB1A00F75
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 14:27:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C14C57589B;
 Fri, 10 Jul 2026 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783686477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hpmJT/Gm5jjqj8AiRjg6KcnxP6g8nKjToCrASEUgANc=;
 b=NDsNAtQ7eL6D3Vy9FGMcZN1EMBJcWB/ig0ga+myW6S6VimNBnlJ4/Abm+IM53awAZoevz0
 ru6JoLayqq2NzL8pnsIO9LpCeTGrHRzjYgM4Wagp0CccUVaNLEXr7Onhe1vaZqlVQPwYIB
 FiI+Wsb1+KPpLIlRV8Wt3UKxtKuxaf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783686477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hpmJT/Gm5jjqj8AiRjg6KcnxP6g8nKjToCrASEUgANc=;
 b=KXjvmrVyZPIGRkQ62h4eH4c5RwFmZg9ql5uaFM7YhaiUHSsc8ngo2YepnPXEPm0U88gRCC
 j+3wcmI0QgV0WnBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783686477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hpmJT/Gm5jjqj8AiRjg6KcnxP6g8nKjToCrASEUgANc=;
 b=NDsNAtQ7eL6D3Vy9FGMcZN1EMBJcWB/ig0ga+myW6S6VimNBnlJ4/Abm+IM53awAZoevz0
 ru6JoLayqq2NzL8pnsIO9LpCeTGrHRzjYgM4Wagp0CccUVaNLEXr7Onhe1vaZqlVQPwYIB
 FiI+Wsb1+KPpLIlRV8Wt3UKxtKuxaf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783686477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hpmJT/Gm5jjqj8AiRjg6KcnxP6g8nKjToCrASEUgANc=;
 b=KXjvmrVyZPIGRkQ62h4eH4c5RwFmZg9ql5uaFM7YhaiUHSsc8ngo2YepnPXEPm0U88gRCC
 j+3wcmI0QgV0WnBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B162C779BD;
 Fri, 10 Jul 2026 12:27:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id O4BkKk3lUGqFTwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 10 Jul 2026 12:27:57 +0000
Date: Fri, 10 Jul 2026 14:27:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <alDlHzYiak61OLRZ@rei>
References: <20260709102837.54583-1-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260709102837.54583-1-japo@linux.ibm.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] kill11: Skip pipe-based core dumps per
 signal
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Alternative we may change the core pattern for the duration of the test.
Does this patch fixes the issue for you?

diff --git a/testcases/kernel/syscalls/kill/kill11.c b/testcases/kernel/syscalls/kill/kill11.c
index 3cf62feae..191587368 100644
--- a/testcases/kernel/syscalls/kill/kill11.c
+++ b/testcases/kernel/syscalls/kill/kill11.c
@@ -126,7 +126,12 @@ static void setup(void)
 static struct tst_test test = {
        .needs_tmpdir = 1,
        .forks_child = 1,
+       .needs_root = 1,
        .setup = setup,
        .tcnt = ARRAY_SIZE(tcases),
        .test = verify_kill,
+       .save_restore = (const struct tst_path_val[]) {
+               {PATH_KERN_CORE_PATTERN, "core", TST_SR_TBROK},
+               {}
+       }
 };


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
