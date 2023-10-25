Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93696C25B6B
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 22:14:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B90173CF4D8
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 00:14:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E2FF3CCB57
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 00:13:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1795F1A00997
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 00:13:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6C6F21F37C;
 Wed, 25 Oct 2023 22:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698272031;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PlXXhEfog1Mn64jbIfuDsHe5EkpaQSO502YerD8rRKs=;
 b=xisILtDiQkFSvhvzrq5DLAFYYuo8pF564fNYs7fOnlE6a8OBAJ/jS/HSZzfqYRzjMB6WoV
 bU7xDSnVTXHMOaiaGWxQAAt0jYiW8gSOmGlMyldnwxJFEAGsFJ4Aw0+IYh43EmH4sUrpLz
 3h6Sp9Ro36pXOpVVv+ecrGnercLKsHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698272031;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PlXXhEfog1Mn64jbIfuDsHe5EkpaQSO502YerD8rRKs=;
 b=Ho8TeOPIWyueD8Ur4Fak/KFX2pt9sy8h2MzC1tay5MTPUT3SqofELD076Vrt99TvwXNzx1
 8tj3bGRgctDLqyDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 50300138E9;
 Wed, 25 Oct 2023 22:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rw0NEh+TOWWsQQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 22:13:51 +0000
Date: Thu, 26 Oct 2023 00:13:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <20231025221349.GD477570@pevik>
References: <20231025110835.28832-1-mkittler@suse.de>
 <20231025110835.28832-5-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231025110835.28832-5-mkittler@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-8.81 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.51)[91.81%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 4/4] Extend ioctl02 to test termio and termios
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

Hi Marius

...
> -	if (termio.c_iflag != (BRKINT | IGNPAR | INPCK | ISTRIP
> -		 | ICRNL | IUCLC | IXON | IXANY | IXOFF)) {
> -		tst_res(TFAIL, "iflag has incorrect value. %o",
> -			 termio.c_iflag);
> -		flag++;

> +#define CMP_ATTR(tcexp, tcval, attr) \
> +	do { \
> +		if ((tcval).attr != (tcexp).attr) { \
> +			tst_res(TINFO, #attr " has incorrect value %o", \
> +				(tcval).attr); \
> +			flag++; \
> +		} \
> +	} while (0)
> +
> +#define CECK_CONTROL_CHARS(tcval) \
> +	for (i = 0; i < NCC; i++) { \
> +		if (i == VEOL2) { \
> +			if (!(tcval).c_cc[i]) { \
> +				continue; \
> +			} else { \
> +				tst_res(TFAIL, "control char %d has " \
> +					 "incorrect value %d", i, (tcval).c_cc[i]); \
> +				flag++; \
> +				continue; \
> +			} \
> +		} \
> +		if ((tcval).c_cc[i] != CSTART) { \
> +			tst_res(TFAIL, "control char %d has incorrect " \
> +				 "value %d.", i, (tcval).c_cc[i]); \
> +			flag++; \
> +		} \
>  	}

Could be this written as a function? Or what is the benefit of it?  Because
readability suffers. (We prefer avoid macros, tst_test_macros.h is the exception
due using kernel syscalls, but readability also suffers).

I know you mentioned C++ in cover letter, but please no C++ :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
