Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A441CD342F
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 07:46:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F0E73C4E8C
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 09:46:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F6353C2EEC
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 09:46:05 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C0CD2200D17
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 09:46:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D26BC21A53;
 Tue,  3 Sep 2024 07:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725349563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uEhru2d1NqeLCDrfrwHhUk2ymT21nA7A56YklUyhbgE=;
 b=iQUSRlZJuSR983q2VcdbZtmCsWFwEjkrG2Bv+uo/DfyBgdFpc/Iy5d9M5ATJ4f8NOIJQD7
 MlF6+suZKZpaDGrCj9zNaXmBOXeqN8F0gxVhm7P8bDVxcZ/b665pcC0rnELsKKfTCXFIeI
 BXWLHxEjzznIn+Xa2lqtAIMNli/VqAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725349563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uEhru2d1NqeLCDrfrwHhUk2ymT21nA7A56YklUyhbgE=;
 b=LEzQjMbNNBXm2TIgJwCDNW48xF+PD9kIbr8gMVZLjVifWiUTg/MXd/3cLPwvqbw9lTaboQ
 fDaxMWIPfmQqWOAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725349563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uEhru2d1NqeLCDrfrwHhUk2ymT21nA7A56YklUyhbgE=;
 b=iQUSRlZJuSR983q2VcdbZtmCsWFwEjkrG2Bv+uo/DfyBgdFpc/Iy5d9M5ATJ4f8NOIJQD7
 MlF6+suZKZpaDGrCj9zNaXmBOXeqN8F0gxVhm7P8bDVxcZ/b665pcC0rnELsKKfTCXFIeI
 BXWLHxEjzznIn+Xa2lqtAIMNli/VqAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725349563;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uEhru2d1NqeLCDrfrwHhUk2ymT21nA7A56YklUyhbgE=;
 b=LEzQjMbNNBXm2TIgJwCDNW48xF+PD9kIbr8gMVZLjVifWiUTg/MXd/3cLPwvqbw9lTaboQ
 fDaxMWIPfmQqWOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B80E213A52;
 Tue,  3 Sep 2024 07:46:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K0GsK7u+1mbqVAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 03 Sep 2024 07:46:03 +0000
Date: Tue, 3 Sep 2024 09:46:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240903074602.GA728268@pevik>
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240827120237.25805-2-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] include: tst_clone.h: Fix possible MUSL
 build failures
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

> The problem is that on musl sched.h exposes clone() when _GNU_SOURCE is
> defined and at the same time sched.h does not get pulled before
> tst_clone.h gets included, which means that the macro from tst_clone.h
> that rewrites clone() functions actually rewrites the function
> declaration in the system header.

BTW glibc guards clone() with #ifdef __USE_GNU, which should have the same
effect as _GNU_SOURCE. I wonder why only musl got broken.

> We remove the tst_clone.h from the old library because the newly
> included sched.h causes conflicts in the cpuset/cpuset_lib/ directory
> and the tst_clone.h header is used only in a single old library test
> i.e. clone02.c.

> This commit is needed in order to avoid build failures in the next
> commits that add support for the shell test library.

Thanks for fixing this!

Reported-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
