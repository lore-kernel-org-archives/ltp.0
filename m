Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E8ACCF9E0
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 09:03:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 611D83CF500
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 10:03:43 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 205953CA985
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 10:03:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 82ED3600879
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 10:03:26 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 581811F387;
 Mon, 27 Oct 2025 09:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761555805; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ky+z6HQaV3pxUKCXtAhjbzChBhXMdaMWrRzYSABQQio=;
 b=UyBPMTbzMAXQ7V/FBgdobjYxfx3RkW6NzV7pDH+hHTvwePSYULEBztwLcJqQRWBPOhiktR
 nG0rsIfZqFSlfQv8sg4RVc0PLEm6jz8jrhWEqxZeINUCjDNv9WJCVVgFr7eL79op0Q6giq
 DPbwfKUxcPIl+D1AH+GJcPaXOsGePgc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761555805;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ky+z6HQaV3pxUKCXtAhjbzChBhXMdaMWrRzYSABQQio=;
 b=s7xGflN/uOjShmt1FUbKcX4zor1ui50LOikSz8OS3rKTUBl38y/lAuOb8Rw7jwdPx+ZSUS
 RVQUxkm+oxx1EyDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761555803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ky+z6HQaV3pxUKCXtAhjbzChBhXMdaMWrRzYSABQQio=;
 b=w8t3ud3mmyUJ8MeqaMSlEqssyvQCVbjUE502lWGCGccl4wpUw8tXc/NH7UxHJeg6ZOtMlg
 5D3JtENJpCXjnAHE/Je4Lb7l04d5eOgsXWFnpf9xPQmk3tlrk+BVzL486s3rh8KzUStp55
 l5NeOpy0Ts99Ybo0ttxkkMb++Qo0Bh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761555803;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ky+z6HQaV3pxUKCXtAhjbzChBhXMdaMWrRzYSABQQio=;
 b=00Vq2EW9gi4/4pS+dpQNsjga4KRXVP43SET5Oe5yn5jhokZiD+K3nZIQB+67/Sw0PfBck3
 23i3PLVJkDNLnHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47758136CF;
 Mon, 27 Oct 2025 09:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wDZkEFs1/2iNQgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 27 Oct 2025 09:03:23 +0000
Date: Mon, 27 Oct 2025 10:02:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <aP81KaVnfcm1sj8j@rei>
References: <20251024125649.2343520-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251024125649.2343520-1-anders.roxell@linaro.org>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] isofs: Add ISO9660 kernel config requirement
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
Cc: dan.carpenter@linaro.org, ltp@lists.linux.it, benjamin.copeland@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  TST_NEEDS_CMDS="mount umount"
>  TST_NEEDS_TMPDIR=1
> +TST_NEEDS_KCONFIGS="CONFIG_ISO9660_FS=y | CONFIG_ISO9660_FS=m"

If you add just TST_NEEDS_KCONFIGS="CONFIG_ISO9660_FS" it will match both
=y and =m I've added this shortcut to the library so that we do not need
to write it as you did above.

>  TST_TESTFUNC=do_test
>  TST_CNT=3
>  TST_SETUP="setup"
> -- 
> 2.51.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
