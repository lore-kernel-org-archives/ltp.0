Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EF2CD4F24
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 13:08:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4ADE3D073E
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 15:07:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E1C63D06EA
 for <ltp@lists.linux.it>; Tue, 12 May 2026 15:07:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7FB55200773
 for <ltp@lists.linux.it>; Tue, 12 May 2026 15:07:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4E7176C259;
 Tue, 12 May 2026 13:07:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AD6D593A9;
 Tue, 12 May 2026 13:07:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jL4QDhcmA2pjPwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 12 May 2026 13:07:35 +0000
Date: Tue, 12 May 2026 15:07:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <agMmGMyPJdvqD2zO@yuki.lan>
References: <20260512124909.27094-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260512124909.27094-1-mdoucha@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4E7176C259
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] af_alg08: Don't check recv() errno
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
> Recent kernels return EBADMSG from recv() when the crypto operation
> fails. However, older kernels return EINVAL instead. Remove check
> for specific errno and only check that recv() failed.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/kernel/crypto/af_alg08.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/crypto/af_alg08.c b/testcases/kernel/crypto/af_alg08.c
> index 5e04b579c..4cc3e5c4e 100644
> --- a/testcases/kernel/crypto/af_alg08.c
> +++ b/testcases/kernel/crypto/af_alg08.c
> @@ -100,7 +100,14 @@ static void try_corrupt(void)
>  	SAFE_SPLICE(pipefd[0], NULL, reqfd, NULL, OVERWRITE_SIZE, 0);
>  
>  	/* Expected to fail (invalid ciphertext); triggers the scratch write */
> -	TST_EXP_FAIL_SILENT(recv(reqfd, recvbuf, sizeof(recvbuf), 0), EBADMSG);
> +	TEST(recv(reqfd, recvbuf, sizeof(recvbuf), 0));
> +
> +	if (TST_RET >= 0) {
> +		tst_res(TFAIL, "Decryption succeeded unexpectedly");
> +	} else if (TST_RET != -1) {
> +		tst_res(TFAIL | TTERRNO, "Invalid recv() return value %ld",
> +			TST_RET);
> +	}

Maybe allowing all errnos is bit to broad.

I wonder why we haven't added TST_EXP_FAIL_ARR_SILENT() since that
should be as simple as:

#define TST_EXP_FAIL_ARR_SILENT(SCALL, EXP_ERRS, EXP_ERRS_CNT, ...) \
	TST_EXP_FAIL_SILENT_(TST_RET == 0, SCALL, #SCALL, EXP_ERRS, EXP_ERRS_CNT, ##__VA_ARGS__)


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
