Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17C1C25B48
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 09:48:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16B423C8711
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 11:48:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED70B3C8207
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 11:48:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E9AE9616624
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 11:48:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D88CD21B44;
 Thu, 26 Oct 2023 09:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698313681;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RmZZeqsVOBiJ+h233WnZcuZnIRXKJjHLK70cEgSZtEw=;
 b=MpKBTMOvu8NZ6QbWPMCNsrPPnVCK9TmoMtWG7+YCJWlQtLkDJc0CotnUGsPrsJw2WcQ0r5
 66YRTHKmKd9BWzcUofi/aVT1Vzkr6eIfdJDoDCl1PaY0p+LXbiapsUK/3duCEh6k0y+Mmj
 HICOzAWI6nFt4YBrJVGhj+VF3b+66Os=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698313681;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RmZZeqsVOBiJ+h233WnZcuZnIRXKJjHLK70cEgSZtEw=;
 b=wc1OJdXuONBvy1r3ftSdXHCzCKkGxoyxzx+FTriySGskYS3HUCOFCteBVdjR1m2MsZ+XSZ
 WSjWZqnPk+k1gaCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3E951358F;
 Thu, 26 Oct 2023 09:48:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iWA5KtE1OmVBOgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Oct 2023 09:48:01 +0000
Date: Thu, 26 Oct 2023 11:48:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <20231026094800.GA584918@pevik>
References: <20231011142927.29699-1-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231011142927.29699-1-mkittler@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.04 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.74)[83.97%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Prevent vma05 from passing wrongly when no
 coredump generated at all
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

Hi Marius,

> When debugging this test I noticed that it passes when no coredump could
> be generated at all. This change adds a check to verify whether the test is
> provoking a coredump as intended.

I'm sorry, I haven't noticed this when I was merging my old patch doing
similar check:

https://patchwork.ozlabs.org/project/ltp/patch/20230926124647.152972-3-pvorel@suse.cz/
https://lore.kernel.org/ltp/20230926124647.152972-3-pvorel@suse.cz/

> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>  testcases/kernel/mem/vma/vma05.sh | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/mem/vma/vma05.sh b/testcases/kernel/mem/vma/vma05.sh
> index c9e4becdb..bcc3b9623 100755
> --- a/testcases/kernel/mem/vma/vma05.sh
> +++ b/testcases/kernel/mem/vma/vma05.sh
> @@ -54,6 +54,7 @@ vma_report_check()

>  	rm -rf core*
>  	{ vma05_vdso; } > /dev/null 2>&1
> +	[ -s ./core* ] || tst_brk TBROK "[vdso] no backtrace generated"

Maybe checking with -s (size > 0) is better than for simple -f (file exists).
But OTOH how often can happen that backtrace gets generated but it's empty?
When no space left? But half of the LTP tests would blow up.

I'm closing this in patchwork because it's not applicable now, but feel free to
send rebased v2.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
