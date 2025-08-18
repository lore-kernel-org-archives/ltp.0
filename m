Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6021CA0ED1
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 13:17:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DB6C3CC842
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 15:17:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 174803C82CD
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 15:17:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 80B0420092C
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 15:17:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ABA4D2116C;
 Mon, 18 Aug 2025 13:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755523059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wzTWsIUyNA5+RGjt9ZXN5Qe56yK4gUShXTp+Zv/Xq2A=;
 b=PDrRBFSaud8tJbjsoWIl6d6ARgWKkU6GyyF5Rkuz+UMsvFS8JTwd2AW+cstNAGffhIymke
 4yTsb7hZvOSP6CgPLVBomYiKeIjMBls4Dm3aXF6PEmMkgtRf2vrxLPNPQzg3QTd92StdU6
 A11UrMjm6TksTsYo+7NZ2hZCx6crfCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755523059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wzTWsIUyNA5+RGjt9ZXN5Qe56yK4gUShXTp+Zv/Xq2A=;
 b=EDvyoQTLXaw2BckVjVDLx1CH29OUVlMHfOOCXEZ46fUIfmVa5zgl5tegk0obkLgTcbvITd
 kiHPO9oKRe6FpNAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755523059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wzTWsIUyNA5+RGjt9ZXN5Qe56yK4gUShXTp+Zv/Xq2A=;
 b=PDrRBFSaud8tJbjsoWIl6d6ARgWKkU6GyyF5Rkuz+UMsvFS8JTwd2AW+cstNAGffhIymke
 4yTsb7hZvOSP6CgPLVBomYiKeIjMBls4Dm3aXF6PEmMkgtRf2vrxLPNPQzg3QTd92StdU6
 A11UrMjm6TksTsYo+7NZ2hZCx6crfCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755523059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wzTWsIUyNA5+RGjt9ZXN5Qe56yK4gUShXTp+Zv/Xq2A=;
 b=EDvyoQTLXaw2BckVjVDLx1CH29OUVlMHfOOCXEZ46fUIfmVa5zgl5tegk0obkLgTcbvITd
 kiHPO9oKRe6FpNAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 679D313A55;
 Mon, 18 Aug 2025 13:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lsnIFfMno2gmBQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 18 Aug 2025 13:17:39 +0000
Date: Mon, 18 Aug 2025 15:17:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Liheng Chen <791960492@qq.com>
Message-ID: <20250818131733.GB21418@pevik>
References: <tencent_05DE07BA6C168B5D5A26E2E54EC881EB6509@qq.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <tencent_05DE07BA6C168B5D5A26E2E54EC881EB6509@qq.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[qq.com]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[qq.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sigaltstack01: Fix check about alternative stack
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

Hi Liheng,

> Hi all,

> This check seems should be (alt_stk < sigstk.ss_sp) || (alt_stk > (sigstk.ss_sp + SIGSTKSZ)), not &&

You're right. IMHO the error goes down to the original addition in
865695bbc89088b9526ea9045410e5afb70a985c

Out of curiosity, did you find a system where it should fail but it didn't?

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Kind regards,
> Liheng Chen

> Signed-off-by: Liheng Chen <791960492@qq.com>
> ---
>  testcases/kernel/syscalls/sigaltstack/sigaltstack01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c b/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
> index 9a2e3a440..147659467 100644
> --- a/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
> +++ b/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
> @@ -142,7 +142,7 @@ int main(int ac, char **av)
>  			 * Check that main_stk is outside the
>  			 * alternate stk boundaries.
>  			 */
> -			if ((alt_stk < sigstk.ss_sp) &&
> +			if ((alt_stk < sigstk.ss_sp) ||
>  			    (alt_stk > (sigstk.ss_sp + SIGSTKSZ))) {
>  				tst_resm(TFAIL,
>  					 "alt. stack is not within the "

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
