Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258E2C53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 10:27:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AF543E727F
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 12:27:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7ABB73D0FDB
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 12:27:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B5C2C1400153
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 12:27:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5548E3DF8;
 Wed, 29 Jul 2026 10:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785320837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UQJXRYjsWGj6h1rEhEZH4T4E25MYEiZz4N52H8AkY84=;
 b=Hex4NWNDbbYGcPKGKYPSiZNF8bUTzYDkieSv90wBLguoyi2Qc0W4pLXAlFzyYv0w2WjlHP
 zBZ9QrMzQhSYQVvhM0qsU19Kqq53AbKT96srxEnib77W744DH+JINTgNv/iI9RyeiN7wxi
 i/KbsQ+d1vOrDtLiMv8JKRB7c6QYILs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785320837;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UQJXRYjsWGj6h1rEhEZH4T4E25MYEiZz4N52H8AkY84=;
 b=NLDpKxDnWVxZUimAfguh3IhH6upP2NiOKl2fo9wKI/KMngOL7G0kIzE0DtRrPosy4FvXY1
 AdYiNHSnTurDg0DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785320833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UQJXRYjsWGj6h1rEhEZH4T4E25MYEiZz4N52H8AkY84=;
 b=e2qU5Vc+lf5ZmTjzwBYW7eL95TFYUHhU4EUiS4+BzvHpuS5ub/Rh5uXhnMYLNN6840u6Dd
 Uso37eK2yc/djZpGuAqghvBjUXNWPsGswux/Vfj7Qk8Zhra7+fYJNLCng40wd/ppml4sU4
 6/8noTbvYj1fTwtSPRBii3Ipnoij268=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785320833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UQJXRYjsWGj6h1rEhEZH4T4E25MYEiZz4N52H8AkY84=;
 b=blq/6wl3fb4vsRJ3ISwFo8HXuqzR2uNSE9VjAgCgPhMHCMkrWVw2Ae1iDSMrdHDxK8J8cd
 tleweIzk81NGhOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C1E4779A1;
 Wed, 29 Jul 2026 10:27:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JE6PEoHVaWqxQwAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 29 Jul 2026 10:27:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id EC0AEA131F; Wed, 29 Jul 2026 12:26:57 +0200 (CEST)
Date: Wed, 29 Jul 2026 12:26:57 +0200
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ikh22h3smbjn7fvmulqcuyjvjhsu4a57atjh7mecmkg5cvakfs@hlrwv6ex7qko>
References: <20260729095730.29185-1-pvorel@suse.cz>
 <20260729095730.29185-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260729095730.29185-6-pvorel@suse.cz>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_LAST(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_THREE(0.00)[3]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.cz,suse.com,gmail.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] fanotify20: Skip on v7.2
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
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 AnonymeMeow <anonymemeow@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed 29-07-26 11:57:30, Petr Vorel wrote:
> fanotify_init() used to reject FAN_REPORT_PIDFD combined with
> FAN_REPORT_TID with EINVAL. Since Linux v7.2, fanotify supports
> reporting pidfds for thread IDs, so this combination is expected to
> succeed.
> 
> The test that these flag combinations are allowed:
>                 FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_TID),
> 		FLAGS_DESC(FAN_REPORT_PIDFD | FAN_REPORT_FID |
> 			   FAN_REPORT_DFID_NAME),
> 
> Because the above flag combinations are already "tested" by the tests
> that use them and we don't have any tests that >= 5.10 has support for
> FAN_MARK_FILESYSTEM etc just simply skip the test on v7.2.
> 
> Reported-by: AnonymeMeow <anonymemeow@gmail.com>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes v1->v2:
> * Fixed version 7.2 => 7.1
> 
> More changes needed => v2. I'm sorry for the noise.
> 
>  testcases/kernel/syscalls/fanotify/fanotify20.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify20.c b/testcases/kernel/syscalls/fanotify/fanotify20.c
> index b32ecf6aa3..db4a5ba63b 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify20.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify20.c
> @@ -15,6 +15,9 @@
>   *
>   * NOTE: FAN_REPORT_PIDFD support was added in v5.15-rc1 in
>   * af579beb666a ("fanotify: add pidfd support to the fanotify API").
> + *
> + * NOTE: since v7.2, fanotify supports reporting pidfds for thread IDs => skip
> + * the test.
>   */
>  
>  #define _GNU_SOURCE
> @@ -75,6 +78,7 @@ static void do_cleanup(void)
>  
>  static struct tst_test test = {
>  	.setup = do_setup,
> +	.max_kver = "7.1",
>  	.test = do_test,
>  	.tcnt = ARRAY_SIZE(test_cases),
>  	.cleanup = do_cleanup,
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
