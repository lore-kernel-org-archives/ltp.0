Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2206CC47258
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 11:08:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 802CD3CE305
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 12:08:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75F413CC9ED
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 12:07:47 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D34911BC2F22
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 12:07:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CA116220DC;
 Wed, 17 Jan 2024 11:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705489665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVksMnPZaLpqXH6edcRUfbj83TKiA3M7mAXLsFIfFEw=;
 b=BBAYY3d6YgnwoOm3rTzpbC4Og2x1BdPpaw/lvlQARqp8pulslIMFSVQFHzWfM4iHXuK5D6
 CN/ovD0F+iuXuCjw2GHlGkD2w6m4jb27195ZW2sjurFYYD2UQNf8Xlh+1quk4LgVGnoCVg
 3cxf/vCvGDubDHDcRVm6Dc8LkLC9L5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705489665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVksMnPZaLpqXH6edcRUfbj83TKiA3M7mAXLsFIfFEw=;
 b=xMjfhjRmeDAMbaWeETTfbMP84e71BWJRNbHn9Y+GAtwWFBu7uWs8VQIxArhpJlyW7qzbt5
 nvlMqLVm3XLAS3Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705489665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVksMnPZaLpqXH6edcRUfbj83TKiA3M7mAXLsFIfFEw=;
 b=BBAYY3d6YgnwoOm3rTzpbC4Og2x1BdPpaw/lvlQARqp8pulslIMFSVQFHzWfM4iHXuK5D6
 CN/ovD0F+iuXuCjw2GHlGkD2w6m4jb27195ZW2sjurFYYD2UQNf8Xlh+1quk4LgVGnoCVg
 3cxf/vCvGDubDHDcRVm6Dc8LkLC9L5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705489665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MVksMnPZaLpqXH6edcRUfbj83TKiA3M7mAXLsFIfFEw=;
 b=xMjfhjRmeDAMbaWeETTfbMP84e71BWJRNbHn9Y+GAtwWFBu7uWs8VQIxArhpJlyW7qzbt5
 nvlMqLVm3XLAS3Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A065813800;
 Wed, 17 Jan 2024 11:07:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PZvBJAG1p2VLPQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Jan 2024 11:07:45 +0000
Date: Wed, 17 Jan 2024 12:07:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240117110744.GA2692706@pevik>
References: <20240117101801.12536-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240117101801.12536-1-chrubis@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-5.09 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.59)[81.64%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: TST_EXP_FAIL: Fix the *_ARR_() macros
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

Hi Cyril,

> This is basically the same fix as:
> d7e5e102364b (tst_test_macros.h: fix "too many arguments")

> The point is that the SCALL parameter has to be stringified in the first
> pass otherwise it ends up expandend and as long as it contains coma the
> number of parameters will increase breaking the printf() formatting
> again.

> Fixes: #1120

> Fixes: 1cfe61428982 ("lib: TST_EXP_FAIL: Add array variants")

Reported-by: Wei Gao <wegao@suse.com>
(missing credit)

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks quick fix, please merge!
I'm sorry, I haven't noticed the problem. tst_test_macros.h is getting quite
complex, maybe we should add some comments into the header.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
