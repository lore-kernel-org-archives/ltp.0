Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BE4C021B2
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 14:23:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F1F83C678D
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 15:23:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15FF93C02C9
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 15:22:56 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CA8B0630AF1
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 15:22:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5899D1F766;
 Thu, 20 Feb 2025 14:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740061373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K8wSQg7gaSNctwncLVzH4kE/Xy0MctaT0+T8iAtX444=;
 b=EhTEruYi6VpIuhTT2dQ2uydNMjFBeGbgIuoc/MlmgptERD49NAbG0qOIote1Y+RSkG/7mP
 HpPQ9HghU5vNIa7j5nDeKsT9yPVelJU810m9JeBZ8kG4kSdoeetWcZEDYC1Sw0RctDwgFo
 ne89jP7AVWcEuZr07y0rU+gznQOiWwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740061373;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K8wSQg7gaSNctwncLVzH4kE/Xy0MctaT0+T8iAtX444=;
 b=c4VNSg27JxJzWwoa+81d+b2oWj0KEEfdhacn691GctZv4Y0kQ3mQP9bD07FCijsCsitUse
 yZVMUo+/NRRXY1Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EhTEruYi;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=c4VNSg27
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740061373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K8wSQg7gaSNctwncLVzH4kE/Xy0MctaT0+T8iAtX444=;
 b=EhTEruYi6VpIuhTT2dQ2uydNMjFBeGbgIuoc/MlmgptERD49NAbG0qOIote1Y+RSkG/7mP
 HpPQ9HghU5vNIa7j5nDeKsT9yPVelJU810m9JeBZ8kG4kSdoeetWcZEDYC1Sw0RctDwgFo
 ne89jP7AVWcEuZr07y0rU+gznQOiWwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740061373;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K8wSQg7gaSNctwncLVzH4kE/Xy0MctaT0+T8iAtX444=;
 b=c4VNSg27JxJzWwoa+81d+b2oWj0KEEfdhacn691GctZv4Y0kQ3mQP9bD07FCijsCsitUse
 yZVMUo+/NRRXY1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 480A913301;
 Thu, 20 Feb 2025 14:22:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Iwp5EL06t2dUVgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 20 Feb 2025 14:22:53 +0000
Date: Thu, 20 Feb 2025 15:23:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Dorinda Bassey <dbassey@redhat.com>
Message-ID: <Z7c6xizj4wUgVWA1@yuki.lan>
References: <20250217124804.143890-2-dbassey@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250217124804.143890-2-dbassey@redhat.com>
X-Rspamd-Queue-Id: 5899D1F766
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kcmp03: Add check for KCMP_SYSVSEM before
 running test
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
Cc: sbertram@redhat.com, javierm@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This commit introduces a new function
> `is_kcmp_supported()` to check if the kernel supports the
> `KCMP_SYSVSEM` operation. In the `verify_kcmp()` function,
> we add logic to detect when the kernel does not support
> `KCMP_SYSVSEM` and skip the test for that case with a TCONF
> result. This ensures that the test does not fail when the
> Kconfig that supports `KCMP_SYSVSEM` is unavailable.
> 
> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> ---
> v2 changes
> fix coding style
> use `kcmp()` instead of `syscall()`
> do `is_kcmp_supported()` check in the setup and
> cache result
> use `tst_res` instead of `tst_brk`
> 
>  testcases/kernel/syscalls/kcmp/kcmp03.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
> index 37d5118d5..8610cea46 100644
> --- a/testcases/kernel/syscalls/kcmp/kcmp03.c
> +++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
> @@ -42,9 +42,19 @@ static struct tcase {
>  	{ARGS(CLONE_SYSVSEM, KCMP_SYSVSEM)}
>  };
>  
> +static int is_kcmp_supported_flag = -1;
> +
> +static int is_kcmp_supported(void)
> +{
> +	return kcmp(getpid(), getpid(), KCMP_SYSVSEM, 0, 0) == 0;
> +}
> +
>  static void setup(void)
>  {
>  	stack = SAFE_MALLOC(STACK_SIZE);
> +
> +	if (is_kcmp_supported_flag == -1)
> +		is_kcmp_supported_flag = is_kcmp_supported();

The setup is executed once so all we need to do here is:

	is_kcmp_supported_flag = is_kmcp_supported();

>  }
>  
>  static void cleanup(void)
> @@ -64,6 +74,14 @@ static void verify_kcmp(unsigned int n)
>  	int res;
>  	struct tcase *tc = &tcases[n];
>  
> +    // Handle the case for KCMP_SYSVSEM specifically

This comment is not add any information because the if does exactly what
the comment say. We do not add comments like this into LTP.

> +	if (tc->kcmp_type == KCMP_SYSVSEM) {
> +		if (is_kcmp_supported_flag == 0) {
> +			tst_res(TCONF, "Kernel does not support KCMP_SYSVSEM, skipping test.");
> +			return;
> +		}
> +	}
> +
>  	pid1 = getpid();
>  	tst_res(TINFO, "Testing %s", tc->desc);

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
