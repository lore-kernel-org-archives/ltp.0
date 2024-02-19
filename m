Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1564C48BF8
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 21:29:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6BF53CDB95
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 22:29:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 441373CDB95
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 22:29:43 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B310F140043B
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 22:29:42 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C092D2201F;
 Mon, 19 Feb 2024 21:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708378181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bj9eKd+VYQrFgyNfYchB2JeWE46ivR33WBRrl43g+Ms=;
 b=Y6RQGOjH42s/G7d44dUGQrb4tSF/V+iMrEAFb45KQhEc6/ScyVHS6A94Q2VpFV3YVkBT0+
 vk3YuZEPboyjU/7ulMfc14QHLDNaUZjBfjOPx0P3ER9P88v7W9asMQUDLOBgyFlQyv5xYa
 cMLGu3UQRLw2cdKScTGUaIdrbEPw5xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708378181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bj9eKd+VYQrFgyNfYchB2JeWE46ivR33WBRrl43g+Ms=;
 b=0lAApxG2aSii22CDHQOx8UmTfd2+3bcawq5A3Zrzhf6GnK4QTyYz1eHBYlNuWpkpPRvFsr
 vjvhe4/mNA67nUCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708378181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bj9eKd+VYQrFgyNfYchB2JeWE46ivR33WBRrl43g+Ms=;
 b=Y6RQGOjH42s/G7d44dUGQrb4tSF/V+iMrEAFb45KQhEc6/ScyVHS6A94Q2VpFV3YVkBT0+
 vk3YuZEPboyjU/7ulMfc14QHLDNaUZjBfjOPx0P3ER9P88v7W9asMQUDLOBgyFlQyv5xYa
 cMLGu3UQRLw2cdKScTGUaIdrbEPw5xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708378181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bj9eKd+VYQrFgyNfYchB2JeWE46ivR33WBRrl43g+Ms=;
 b=0lAApxG2aSii22CDHQOx8UmTfd2+3bcawq5A3Zrzhf6GnK4QTyYz1eHBYlNuWpkpPRvFsr
 vjvhe4/mNA67nUCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FD3B13585;
 Mon, 19 Feb 2024 21:29:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 21xlJUXI02VOaAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 19 Feb 2024 21:29:41 +0000
Date: Mon, 19 Feb 2024 22:29:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240219212940.GA1067220@pevik>
References: <20231108074935.1409644-1-pvorel@suse.cz>
 <20231108074935.1409644-2-pvorel@suse.cz>
 <0cfbe8ce-f705-4cb1-bf74-a43376fda51e@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0cfbe8ce-f705-4cb1-bf74-a43376fda51e@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.68 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.02)[53.49%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] link05: Use constant for number of links
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

Hi Andrea,

> Hi!

> LGTM

> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Thanks for your review, merged.

Could you please use "reply to all" when posting your review?
That way you reply directly to the autor (and possibly other people in the
thread), which speedups the process (I guess I'm not the only one who expects to
get comments directly, I find this just by change). Thank you!

Kind regards,
Petr

> Regards,
> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
