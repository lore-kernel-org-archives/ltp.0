Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A24C5478C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 16:30:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A24B3CEBD0
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 17:30:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 540883CCA8E
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 17:30:17 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1C3021405168
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 17:30:15 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 377E61FDD0;
 Mon,  4 Mar 2024 16:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709569815;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iregUSFEGNm8o+NKWB64YhNZrmcur8OkMF+e/rVGxX4=;
 b=NYCKninWTfCU3Wqji/Vv2EptorUGWAMHNWRV1Ctjg/oZArRH5YoHuqE4RaNdZpPf+bUzYc
 /x/LZOfgRt+krBlgl2A4++mr3ZLCTWvEuthGyAIFqDUUKgF7ALy34Y7k2g78oVvAO5bop7
 3ZoN6evhv4xrppFGgfcpS11Y5xBxn/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709569815;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iregUSFEGNm8o+NKWB64YhNZrmcur8OkMF+e/rVGxX4=;
 b=ct+K5G/1Hw56xhvSIEdFo1R44p0Nbzk8gF1r4Ognh6KfRIzHYTCvLhIbdMrET8jAuJUBi0
 98cUgvFV+CczvsDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709569815;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iregUSFEGNm8o+NKWB64YhNZrmcur8OkMF+e/rVGxX4=;
 b=NYCKninWTfCU3Wqji/Vv2EptorUGWAMHNWRV1Ctjg/oZArRH5YoHuqE4RaNdZpPf+bUzYc
 /x/LZOfgRt+krBlgl2A4++mr3ZLCTWvEuthGyAIFqDUUKgF7ALy34Y7k2g78oVvAO5bop7
 3ZoN6evhv4xrppFGgfcpS11Y5xBxn/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709569815;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iregUSFEGNm8o+NKWB64YhNZrmcur8OkMF+e/rVGxX4=;
 b=ct+K5G/1Hw56xhvSIEdFo1R44p0Nbzk8gF1r4Ognh6KfRIzHYTCvLhIbdMrET8jAuJUBi0
 98cUgvFV+CczvsDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 11EF4139C6;
 Mon,  4 Mar 2024 16:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id tLCVAhf35WWmfwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 04 Mar 2024 16:30:15 +0000
Date: Mon, 4 Mar 2024 17:30:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240304163012.GA3191855@pevik>
References: <20240226153754.24998-1-andrea.cervesato@suse.de>
 <20240226153754.24998-2-andrea.cervesato@suse.de>
 <20240304143512.GB3115761@pevik> <ZeXe_WJcPDfea8eC@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZeXe_WJcPDfea8eC@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.48 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.22)[72.09%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Add SAFE_MPROTECT() macro
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

> Hi!
> > > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > > ---
> > >  include/tst_safe_macros.h |  5 +++++
> > >  lib/safe_macros.c         | 18 ++++++++++++++++++
> > >  2 files changed, 23 insertions(+)

> > Although Cyril acked this I wonder why we are adding it into the old API.
> > Shouldn't it be added only into tst_safe_macros.c?

> To be honest I do not care that much as long as we do not expose the
> functions into the headers for old API. We will have to convert the
> safe_macros.c with coccinelle once all tests are converted and one more
> function in there does not really matter that much.

OTOH we have tst_* file, moving it there (+ remove 'm' from functions) would be
trivial (and less confusing). Sure, finally coccinelle will be used.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
