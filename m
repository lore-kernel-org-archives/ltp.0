Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C819FE77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 08:56:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36E663C1E22
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 09:56:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C3A43C1D6B
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 09:55:52 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B7B3C1BDF401
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 09:55:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F20B61F391;
 Thu,  9 Jan 2025 08:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736412950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/0KWKiaM0BwRuKaV4zlLwtpnMCS3oGFCYEPD1KbbE4E=;
 b=dqw1QXljH+h3VZuvTOZYay4QqMw3etc/w+6ZS+G7+OL0PkSeSnGoJoB83XwB0I5PbI2/+3
 H9seqBX4TYXAyX01mVVPrZPpXOanEE7qD405zjXO2OW8ApHhhmnGwVGAlbFvDhGXqg5wn6
 GHc4zMt9fUNjF9wRa7bh2KGu73penmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736412950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/0KWKiaM0BwRuKaV4zlLwtpnMCS3oGFCYEPD1KbbE4E=;
 b=N9Ji73OaHa6VIsb6XBpbmJ5RRYRl+dPqkRWMpkeWqVaSeiKSGfXeMaiipme0KiWf7pohXs
 NDEKmXSmneY1k9Dw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=otM8u9BD;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lKrdnMPT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736412949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/0KWKiaM0BwRuKaV4zlLwtpnMCS3oGFCYEPD1KbbE4E=;
 b=otM8u9BDpOa1eR1BfJlbvhUQcKDeF9j0kWJttlwd73B3eYZdxImToKgV0I6EEH4ubYsokn
 dlPhrbHTMYkHtd/qUmbzlUkJGxIiuiWauyUGoIBo/kfvLB1J/qd3kJIccAqVlG2YJqOYTU
 kXpdvR9h0pU7ekBC+sJ3jKN+DsI6cbw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736412949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/0KWKiaM0BwRuKaV4zlLwtpnMCS3oGFCYEPD1KbbE4E=;
 b=lKrdnMPTt99qx0/oi5MD6YoHX+s8+nZg4ATJqDHaaqKk6pCXThUOYA6+Wqw2Wp7s8F6Kb0
 7PrwaZ6uWRhkxuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75F7D139AB;
 Thu,  9 Jan 2025 08:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RlrEGhWPf2f8cAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 Jan 2025 08:55:49 +0000
Date: Thu, 9 Jan 2025 09:55:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250109084402.GA177252@pevik>
References: <20240603103553.8318-1-wegao@suse.com>
 <20241217061636.16366-1-wegao@suse.com>
 <20241217061636.16366-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241217061636.16366-3-wegao@suse.com>
X-Rspamd-Queue-Id: F20B61F391
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/2] ptrace06: Refactor the test using new LTP
 API
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

Hi Wei,

> +static inline char *strptrace(int request)
> +{
> +	return strings[request];
> +}
Why not just use strings[tc->request] directly?
> +
> +static void child(void)
> +{
> +
Blank line.

> +	char path[512];
Unused variable (it's always nice to compile test and pay attention to the
warnings before sending it to ML).

The rest LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

I suggest to merge with following diff.

Thanks!

Kind regards,
Petr

+++ testcases/kernel/syscalls/ptrace/ptrace06.c
@@ -8,7 +8,7 @@
 /*\
  * [Description]
  *
- * check out-of-bound/unaligned addresses given to
+ * Check out-of-bound/unaligned addresses given to
  *
  *  - {PEEK,POKE}{DATA,TEXT,USER}
  *  - {GET,SET}{,FG}REGS
@@ -24,11 +24,11 @@
  */
 
 #if defined(__i386__)
-#define SIZEOF_USER 284
+# define SIZEOF_USER 284
 #elif defined(__x86_64__)
-#define SIZEOF_USER 928
+# define SIZEOF_USER 928
 #else
-#define SIZEOF_USER 0x1000	/* just pick a big number */
+# define SIZEOF_USER 0x1000	/* just pick a big number */
 #endif
 
 static struct test_case_t {
@@ -177,16 +177,8 @@ static char *strings[] = {
 	SPT(SINGLESTEP)
 };
 
-static inline char *strptrace(int request)
-{
-	return strings[request];
-}
-
 static void child(void)
 {
-
-	char path[512];
-
 	SAFE_PTRACE(PTRACE_TRACEME, 0, NULL, NULL);
 	raise(SIGSTOP);
 	exit(0);
@@ -217,7 +209,7 @@ static void run(void)
 		TST_EXP_FAIL_ARR(ptrace(tc->request, pid, (void *)tc->addr,
 					(void *)tc->data), exp_errnos, ARRAY_SIZE(exp_errnos),
 					"ptrace(%s, ..., %li, %li) failed as expected",
-					 strptrace(tc->request), tc->addr, tc->data);
+					 strings[tc->request], tc->addr, tc->data);
 	}
 
 	SAFE_PTRACE(PTRACE_CONT, pid, NULL, NULL);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
