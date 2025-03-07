Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7C9C19F32
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 09:26:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73B523CA15A
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 10:26:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB6553CA0CC
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 10:26:09 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 26A1C1A00653
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 10:26:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2668921163;
 Fri,  7 Mar 2025 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741339568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+URSxYtcWw7yyn+ZO/M7eiY/RIxFJe3gYnuR2J1vV4=;
 b=FPRY5ndriYTE7jKzT/UqtH8jrAiTaKLF5XBI7ibjm6g104rkSho8bJQMBirRwVAKKKF5F4
 JIdBVtHPdUJZC2deaFDNSeB7D/Xk3dpoXoGPshl4oepsTpI/L0P7OfRLsB9MHF1bh35X38
 4vOmXOZeFWkAJXSq+TNtIPTAUp9jgnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741339568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+URSxYtcWw7yyn+ZO/M7eiY/RIxFJe3gYnuR2J1vV4=;
 b=LC/5hTcnX4vr7X1Vno2lnXCvmKRY7rJh3WXTmynO7SiKuZyWISw4Fxd/bIaZcW6wlrXoxa
 Lpn0UqO14tJ7v9DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741339568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+URSxYtcWw7yyn+ZO/M7eiY/RIxFJe3gYnuR2J1vV4=;
 b=FPRY5ndriYTE7jKzT/UqtH8jrAiTaKLF5XBI7ibjm6g104rkSho8bJQMBirRwVAKKKF5F4
 JIdBVtHPdUJZC2deaFDNSeB7D/Xk3dpoXoGPshl4oepsTpI/L0P7OfRLsB9MHF1bh35X38
 4vOmXOZeFWkAJXSq+TNtIPTAUp9jgnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741339568;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E+URSxYtcWw7yyn+ZO/M7eiY/RIxFJe3gYnuR2J1vV4=;
 b=LC/5hTcnX4vr7X1Vno2lnXCvmKRY7rJh3WXTmynO7SiKuZyWISw4Fxd/bIaZcW6wlrXoxa
 Lpn0UqO14tJ7v9DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3B7913A22;
 Fri,  7 Mar 2025 09:26:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hKT+Na+7ymciRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Mar 2025 09:26:07 +0000
Date: Fri, 7 Mar 2025 10:26:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250307092606.GA263657@pevik>
References: <67cabd64-fb43-4d1a-a471-995fd51a0e2b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <67cabd64-fb43-4d1a-a471-995fd51a0e2b@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Meetings schedule
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
Cc: "Ricardo B. Marliere" <rbm@suse.com>, Xiao Yang <yangx.jy@fujitsu.com>,
 Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, all,

[ Cc hopefully all relevant people ]

Thanks for raising this, I'm sorry you have to wait 2 months to reply.

> Hello everyone,

> As you may have noticed, we haven't been able to follow our regular monthly
> schedule for LTP meetings. This has been due to time constraints on my end,
> as well as holidays and other commitments. As we enter the new year, I
> believe it would be beneficial to establish a consistent schedule so we can
> meet more frequently via public video calls.

> I have a few proposals for our meeting frequency:

> - Monthly meetings
> - Meetings every two months
> - Meetings after each release

I guess once a month is OK. Or, if it's too much to somebody once every 2
months. I'm not sure if it should be aimed before the release or after the
release.

> I suggest we aim to hold our meetings during the first week of the month. If
> a meeting cannot be held due to public holidays, we can consider
> rescheduling it for the following week.

LGTM. Which day? I would prefer not Friday.

Also, I would prefer it not clash with OATS monthly call: which is  *second*
Thursday in month, 14:00 UTC (15h CET).

Kind regards,
Petr

> Please feel free to share your suggestions and vote based on your
> preferences. I look forward to hearing your thoughts! :-)

> Best regards,
> Andrea Cervesato

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
