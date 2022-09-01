Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A8BECAAD1
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 11:33:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC6583CA827
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 13:33:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5C143CA71E
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 13:33:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AA9F36009E5
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 13:32:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8D966226FF;
 Thu,  1 Sep 2022 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662031978;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fEgu4nBtOgzycl0RtQPvW4aG+j9dIUsI6Ezkm/sVPds=;
 b=WS/TGPkYtrHTqqZAtO9UMMIKTOj1LLQfhLnLxMEB39dBMAvVm5sflBKasR/VeUZJ+ToCUF
 1Z9xDxhIHGXqMFxyPdI/oEq+sAyrl2AMQISs/RSTj2WWUxvjj47WmC6xLShLnyEpcz1mem
 MCEsH9oe442n0idXfL1ABvTtNiIhwbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662031978;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fEgu4nBtOgzycl0RtQPvW4aG+j9dIUsI6Ezkm/sVPds=;
 b=ASE4ANUC0xfcNDeVOgkHjA2HgmXHCLCzeYhm16RmuN7e53uFdVeYvdmHvu7B8B8BGC2GKT
 XLSEJBOFjRAeWuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 65BE413A79;
 Thu,  1 Sep 2022 11:32:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uFp2F2qYEGN2CQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 01 Sep 2022 11:32:58 +0000
Date: Thu, 1 Sep 2022 13:32:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YxCYZ+AuGihd8dhK@pevik>
References: <20220715142520.6632-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220715142520.6632-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/truncate03.c: use TST_EXP_FAIL() macro
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

Hi Avinesh,

...
> -	TEST(truncate(tc->pathname, tc->length));
> -	if (TST_RET == 0) {
> -		tst_res(TFAIL, "truncate() succeeded when failure expected");
> -		return;
> -	}
> -
> -	if (TST_RET != -1) {
> -		tst_res(TFAIL, "truncate() returned invalid value %ld",
> -			TST_RET);
> -		return;
> -	}
> -
> -	if (TST_ERR == tc->exp_errno) {
> -		tst_res(TPASS | TTERRNO, "truncate() failed as expected");
> -	} else {
> -		tst_res(TFAIL | TTERRNO,
> -			"truncate() failed unexpectedly; expected: %d - %s",
> -			tc->exp_errno, strerror(tc->exp_errno));
> -	}
> +	TST_EXP_FAIL(truncate(tc->pathname, tc->length),
> +				tc->exp_errno);

I put this on single line, updated copyright and merged.
Thanks!

Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
