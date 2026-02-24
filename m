Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40337EFB810
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 08:31:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE6893D0F7E
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 09:31:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F37923CB958
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:31:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7C88A1A00811
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:31:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A52733F10D;
 Tue, 24 Feb 2026 08:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771921868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=luiss0Dprj9jWF7LIYmCsX/LNBQV11BH6RRO3WwrisI=;
 b=xfjlqpP3p6TKy2jNzce7quMaHETlcKYlfeWtQ+Vr1L/6hl+BI4nisdCXp6FZ63n2YzAIwK
 7Stft0n0lLhjKWdkYRnjy07uStjosQGwL798+fjOCt2Ty3116v/slCmjX9o93mIUYXKxUv
 kpPG/gFhcQVBnONMRmwvPU/pOHVKX6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771921868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=luiss0Dprj9jWF7LIYmCsX/LNBQV11BH6RRO3WwrisI=;
 b=KHaWpYZKfJxIENlGKUWX04uvSsdDy+acwGLB7BWK/6PC6GZwssOWO8QlKVTuvfFk/y7twy
 i+ZaKYsPxcd+TFBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771921868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=luiss0Dprj9jWF7LIYmCsX/LNBQV11BH6RRO3WwrisI=;
 b=xfjlqpP3p6TKy2jNzce7quMaHETlcKYlfeWtQ+Vr1L/6hl+BI4nisdCXp6FZ63n2YzAIwK
 7Stft0n0lLhjKWdkYRnjy07uStjosQGwL798+fjOCt2Ty3116v/slCmjX9o93mIUYXKxUv
 kpPG/gFhcQVBnONMRmwvPU/pOHVKX6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771921868;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=luiss0Dprj9jWF7LIYmCsX/LNBQV11BH6RRO3WwrisI=;
 b=KHaWpYZKfJxIENlGKUWX04uvSsdDy+acwGLB7BWK/6PC6GZwssOWO8QlKVTuvfFk/y7twy
 i+ZaKYsPxcd+TFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77D103EA68;
 Tue, 24 Feb 2026 08:31:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D8FwG8xhnWkyRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 24 Feb 2026 08:31:08 +0000
Date: Tue, 24 Feb 2026 09:31:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260224083107.GC28159@pevik>
References: <20260224-remove_runltp-v2-1-f38862a85b97@suse.com>
 <20260224083017.GB28159@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260224083017.GB28159@pevik>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Remove runltp `scenario_groups` leftovers
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Andrea,

> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > ---
> > Changes in v2:
> > - forgot to keep runltp script
> > - Link to v1: https://lore.kernel.org/r/20260224-remove_runltp-v1-1-7baa79b65acd@suse.com
> > ---
> >  scenario_groups/Makefile | 38 --------------------------------------
> >  scenario_groups/default  | 28 ----------------------------
> >  scenario_groups/network  | 20 --------------------

> I thought people are using scenario_groups as kind of list of runtest files.
> But maybe I'm wrong.

> Also, you need to modify top level Makefile, otherwise make install/clean fails.
> => v3 or don't forget to fix before merge.

Actually also doc/developers/writing_tests.rst mentions scenario_groups.

Kind regards,
Petr

> Kind regards,
> Petr

> >  3 files changed, 86 deletions(-)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
