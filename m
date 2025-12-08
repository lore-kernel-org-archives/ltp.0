Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959FDD3B7E2
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 11:23:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D0F133CF351
	for <ltp@archiver.kernel.org>; Mon,  8 Dec 2025 12:23:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C95A3CEC75
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 12:23:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5EE0C140045F
 for <ltp@lists.linux.it>; Mon,  8 Dec 2025 12:23:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AFE2933875;
 Mon,  8 Dec 2025 11:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765193018;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJniQ39ekK+cJOXDIssn8Q/PpxdUrE0zuf0EPd01JsQ=;
 b=eGYKR49TNbSwvHKocTjoZfcX8oalGQ/zgvjlM2Ghq666/1h+81ifq2Oc7AUt/A3rZwS5+X
 E6QpPO67SGiKGrh5oFG6kv5R5LEmP33I/imsVqZbjpIc6oDo2HqJuM9AKZif+1LsitffF/
 kIISkOFx4DGSOhKvAt5SR/erUxKuR0k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765193018;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJniQ39ekK+cJOXDIssn8Q/PpxdUrE0zuf0EPd01JsQ=;
 b=9rEeNv4Si5Pn5hTC6eE5grbwqWLLwZdWekvDtBppgDAPGBNFc7qYIRonyB9T2KtpntHp62
 IDhkFD9dmugJ/oBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765193016;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJniQ39ekK+cJOXDIssn8Q/PpxdUrE0zuf0EPd01JsQ=;
 b=yd5k4oAvIpaxzlSc+wQU6j1XOf26CCusBQmXjDLktxg8+hEcj5deaBS++3Vb5L/qxtVEwL
 yqcvmhnnke/wOGgTE4FFrcLf4zYKXr92ch3WFgW1qRCiaclG7RBlo8NvcZPyxARoFi139F
 uDeniDXmyTQqYgp2C2i9VI84vrpWqB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765193016;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJniQ39ekK+cJOXDIssn8Q/PpxdUrE0zuf0EPd01JsQ=;
 b=/LMp6OejRZ+4XbeTlEbU78xUbfWoIW3t65D8BhdMb0GaKl+4Vj+cu4xBzYkxGc9PWn9t93
 4/XqMzviu0GDfaAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 921C93EA63;
 Mon,  8 Dec 2025 11:23:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h+C+Iji1NmmcCQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 08 Dec 2025 11:23:36 +0000
Date: Mon, 8 Dec 2025 12:23:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Masahiro Yamada <masahiro.yamada@canonical.com>
Message-ID: <20251208112335.GA683201@pevik>
References: <20251203081226.1148236-1-masahiro.yamada@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251203081226.1148236-1-masahiro.yamada@canonical.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.991]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 URIBL_BLOCKED(0.00)[canonical.com:email,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,canonical.com:email,suse.cz:replyto,suse.cz:email];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] listmount04: require kernel version 6.11
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
Cc: Christian Brauner <brauner@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Masahiro,

> On Linux kernel 6.8, the listmount04 test fails as follows:

>   Running tests.......
>   tst_buffers.c:57: TINFO: Test is using guarded buffers
>   tst_test.c:2025: TINFO: LTP version: 20250930
>   tst_test.c:2028: TINFO: Tested kernel: 6.8.0 #71 SMP PREEMPT_DYNAMIC Wed Dec  3 16:00:27 JST 2025 x86_64
>   tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
>   tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected which might slow the execution
>   tst_test.c:1846: TINFO: Overall timeout per run is 0h 02m 00s
>   listmount04.c:128: TPASS: request points to unaccessible memory : EFAULT (14)
>   listmount04.c:128: TPASS: mnt_ids points to unaccessible memory : EFAULT (14)
>   listmount04.c:128: TPASS: invalid flags : EINVAL (22)
>   listmount04.c:128: TPASS: insufficient mnt_id_req.size : EINVAL (22)
>   listmount04.c:128: TPASS: invalid mnt_id_req.spare : EINVAL (22)
>   listmount04.c:128: TFAIL: invalid mnt_id_req.param invalid retval 20: SUCCESS (0)
>   listmount04.c:128: TFAIL: invalid mnt_id_req.mnt_id expected EINVAL: ENOENT (2)
>   listmount04.c:128: TPASS: non-existant mnt_id : ENOENT (2)

>   Summary:
>   passed   6
>   failed   2
>   broken   0
>   skipped  0
>   warnings 0
>   INFO: ltp-pan reported some tests FAIL
>   LTP Version: 20250930
>   INFO: Test end time: Wed Dec  3 07:01:33 UTC 2025


> This test passes only after kernel commit 4bed843b1000 ("fs: reject
> invalid last mount id early"), i.e. kernel version 6.11.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Good catch.
FYI we have in LTP policy to not hide kernel bugs. But given 4bed843b1000 has
not been merged to stable kernels (checking still supported 6.6 and unsupported
6.11) it's probably considered as a new feature from 6.11-rc1.

@Christian please correct me if I'm wrong.

Kind regards,
Petr

> Signed-off-by: Masahiro Yamada <masahiro.yamada@canonical.com>
> ---
>  testcases/kernel/syscalls/listmount/listmount04.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
> index a52bad064c0e..a6921a24975d 100644
> --- a/testcases/kernel/syscalls/listmount/listmount04.c
> +++ b/testcases/kernel/syscalls/listmount/listmount04.c
> @@ -133,7 +133,7 @@ static void run(unsigned int n)
>  static struct tst_test test = {
>  	.test = run,
>  	.tcnt = ARRAY_SIZE(tcases),
> -	.min_kver = "6.8",
> +	.min_kver = "6.11",
>  	.bufs = (struct tst_buffers []) {
>  		{ &request, .size = MNT_ID_REQ_SIZE_VER0 },
>  		{},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
