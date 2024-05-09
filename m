Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B01C10F1A
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 12:57:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 592F93CE235
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 14:57:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A2BC3CE0E7
 for <ltp@lists.linux.it>; Thu,  9 May 2024 14:57:18 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A1F4C1000F1A
 for <ltp@lists.linux.it>; Thu,  9 May 2024 14:57:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A87F4385AC;
 Thu,  9 May 2024 12:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715259436;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jT7jpd70ZrOkgd/fod50GBbx7D2t0aUn+LZ+mbUF8KM=;
 b=ZldLC8WxlJ/h6z0R4vV72ZGhEv2c4g4rGeK5uS7ViacQQRIBXIl/VZ8RxU1Pw/p8hKsgCo
 ArUUSviUBaIqu4AtsxQV8xl8HOwfTelnJXCcwQEaHCEDrr2NuZOJQ3dH7hieQx7woEX8qp
 IQ1aqh5R4WjPidWBi5Cj0US74tHIMJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715259436;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jT7jpd70ZrOkgd/fod50GBbx7D2t0aUn+LZ+mbUF8KM=;
 b=KYrrphMXIGStHbdwR9JLB02YnRrCe8n9m+ZRsq1gpLMABrJXHo1RQwjgh/oRxPjGL5eOU6
 ph9IDvl2i8ntMzCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715259436;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jT7jpd70ZrOkgd/fod50GBbx7D2t0aUn+LZ+mbUF8KM=;
 b=ZldLC8WxlJ/h6z0R4vV72ZGhEv2c4g4rGeK5uS7ViacQQRIBXIl/VZ8RxU1Pw/p8hKsgCo
 ArUUSviUBaIqu4AtsxQV8xl8HOwfTelnJXCcwQEaHCEDrr2NuZOJQ3dH7hieQx7woEX8qp
 IQ1aqh5R4WjPidWBi5Cj0US74tHIMJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715259436;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jT7jpd70ZrOkgd/fod50GBbx7D2t0aUn+LZ+mbUF8KM=;
 b=KYrrphMXIGStHbdwR9JLB02YnRrCe8n9m+ZRsq1gpLMABrJXHo1RQwjgh/oRxPjGL5eOU6
 ph9IDvl2i8ntMzCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BC1F13A24;
 Thu,  9 May 2024 12:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0auFICzIPGaZaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 09 May 2024 12:57:16 +0000
Date: Thu, 9 May 2024 14:57:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240509125714.GA291089@pevik>
References: <20240418071422.10221-1-wegao@suse.com>
 <20240422124050.3598-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240422124050.3598-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] swapping01.c: Add sleeps in the loop that
 dirties the memory
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

> +++ b/testcases/kernel/mem/swapping/swapping01.c
> @@ -47,6 +47,7 @@
>  #define COE_DELTA       1
>  /* will try to alloc 1.3 * phy_mem */
>  #define COE_SLIGHT_OVER 0.3
> +#define MEM_SIZE 1024 * 1024

>  static void init_meminfo(void);
>  static void do_alloc(int allow_raise);
> @@ -101,6 +102,13 @@ static void init_meminfo(void)
>  				swap_free_init, mem_over_max);
>  }

> +static void memset_blocks(char *ptr, int mem_count, int sleep_time_ms) {
> +	for (int i = 0; i < mem_count / 1024; i++) {
> +		memset(ptr + (i * MEM_SIZE), 1, MEM_SIZE);
> +		usleep(sleep_time_ms * 1000);
> +	}
> +}
> +
>  static void do_alloc(int allow_raise)
>  {
>  	long mem_count;
> @@ -115,7 +123,7 @@ static void do_alloc(int allow_raise)
>  	if (allow_raise == 1)
>  		tst_res(TINFO, "try to allocate: %ld MB", mem_count / 1024);
>  	s = SAFE_MALLOC(mem_count * 1024);
> -	memset(s, 1, mem_count * 1024);
> +	memset_blocks(s, mem_count, 1);
nit: Actually when we have custom function used on single place, we might want
to avoid the last parameter 1, right? We could usleep(1000) directly.

We use MEM_SIZE definition outside of the function anyway.

I can change it before merge:

diff --git testcases/kernel/mem/swapping/swapping01.c testcases/kernel/mem/swapping/swapping01.c
index 79dd2b4d5..09820e3d9 100644
--- testcases/kernel/mem/swapping/swapping01.c
+++ testcases/kernel/mem/swapping/swapping01.c
@@ -102,10 +102,10 @@ static void init_meminfo(void)
 				swap_free_init, mem_over_max);
 }
 
-static void memset_blocks(char *ptr, int mem_count, int sleep_time_ms) {
+static void memset_blocks(char *ptr, int mem_count) {
 	for (int i = 0; i < mem_count / 1024; i++) {
 		memset(ptr + (i * MEM_SIZE), 1, MEM_SIZE);
-		usleep(sleep_time_ms * 1000);
+		usleep(1000);
 	}
 }
 
@@ -123,7 +123,7 @@ static void do_alloc(int allow_raise)
 	if (allow_raise == 1)
 		tst_res(TINFO, "try to allocate: %ld MB", mem_count / 1024);
 	s = SAFE_MALLOC(mem_count * 1024);
-	memset_blocks(s, mem_count, 1);
+	memset_blocks(s, mem_count);
 
 	if ((allow_raise == 1) && (raise(SIGSTOP) == -1)) {
 		tst_res(TINFO, "memory allocated: %ld MB", mem_count / 1024);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
