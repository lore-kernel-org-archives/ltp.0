Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5106CC71155
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 12:29:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE3AE3CC0BC
	for <ltp@archiver.kernel.org>; Mon, 16 Jun 2025 14:29:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 088473CC041
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 14:29:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 629CD1400DA2
 for <ltp@lists.linux.it>; Mon, 16 Jun 2025 14:29:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0BA441F46E;
 Mon, 16 Jun 2025 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750076947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6g2p3hlpQK4pAnEzNZQOe8BBMxFwpc9DdtucHcVFWGQ=;
 b=P8bcEZTRr8AJSHOVqSg/Kb1GiG+aERSNrUYDFG3WQRvMVN+QCLuuCITt+uCI5Y/bE48Xmh
 7pdqYDVK4Vax+TRTztdNEc0o+jpIZZphyUiUJWY6ESuBHdtPNeUTMXGeeFKr7+fpX2+EX2
 6bPrS4PklVqzvUJcumEIL/tCTyndZMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750076947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6g2p3hlpQK4pAnEzNZQOe8BBMxFwpc9DdtucHcVFWGQ=;
 b=NAvGmfAIBjpbU57qOy1MriKH/YYvIhkezXzryAbF9JLJWxKIU/gxu6Uc7LX+iKDWbsSien
 eaKWPk54unVvFGBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1750076947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6g2p3hlpQK4pAnEzNZQOe8BBMxFwpc9DdtucHcVFWGQ=;
 b=P8bcEZTRr8AJSHOVqSg/Kb1GiG+aERSNrUYDFG3WQRvMVN+QCLuuCITt+uCI5Y/bE48Xmh
 7pdqYDVK4Vax+TRTztdNEc0o+jpIZZphyUiUJWY6ESuBHdtPNeUTMXGeeFKr7+fpX2+EX2
 6bPrS4PklVqzvUJcumEIL/tCTyndZMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1750076947;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6g2p3hlpQK4pAnEzNZQOe8BBMxFwpc9DdtucHcVFWGQ=;
 b=NAvGmfAIBjpbU57qOy1MriKH/YYvIhkezXzryAbF9JLJWxKIU/gxu6Uc7LX+iKDWbsSien
 eaKWPk54unVvFGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1D79139E2;
 Mon, 16 Jun 2025 12:29:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wmI7OhIOUGgjCAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 16 Jun 2025 12:29:06 +0000
Date: Mon, 16 Jun 2025 14:29:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aFAON7OktrvRxyfK@yuki.lan>
References: <20250612034229.310523-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250612034229.310523-1-liwang@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] safe_mmap: Avoid using TDEBUG before IPC is
 initialized
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
> Notes:
>     I admit that this removal may result in the loss of early debug
>     output from the LTP library. However, after reviewing the codebase,
>     it appears that this was the only place using TDEBUG during early
>     initialization, so removing it simplifies the behavior without
>     significant loss of functionality.
>     
>     But, if someone argues that we need this, I guess we can add a
>     macro tst_early_debug(fmt, ...) to replace the tst_res_(TDEBUG, ...).

Actually I was thinking of adding TDEBUG messages into more
SAFE_MACROS() in order to make test debugging easier.

Maybe we can just skip the TDEBUG messages for the test library process
I do not think that we are interested SAFE_MACROS() being called from
there.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
