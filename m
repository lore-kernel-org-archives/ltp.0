Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D462C36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 09:18:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7262F3CAEAC
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 11:18:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D2C23C1948
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 11:18:14 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9197C1A00995
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 11:18:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C749E21179;
 Mon,  7 Apr 2025 09:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744017490;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5oQz+H4JqqlhsIeThOGdpMf00VyvdxnkzXSUfCQm8SQ=;
 b=FizsFzXbHVqduNPsfle1mmHbskb1lBX0A4bGLNp7w6/YGO6rtITGLKmmmgsGwhMZP+pWAo
 z38mZJiU8wGokRphRrrlQ4RZAYD6zuNY+6REBGHuGFEYgRHce4jhf2sEk+3WJ34Nj3k+BI
 xlmq4bn8h3wptXNe0IyXSBxLVZbQCvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744017490;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5oQz+H4JqqlhsIeThOGdpMf00VyvdxnkzXSUfCQm8SQ=;
 b=Q6vaujst2ymo0xt1RJYrjvt4U8wkWlQtM21eOAlTPXXJpJn4GLf77rk7yg37O65YuZLHXA
 HFjetoy3YgxIn/Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744017490;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5oQz+H4JqqlhsIeThOGdpMf00VyvdxnkzXSUfCQm8SQ=;
 b=FizsFzXbHVqduNPsfle1mmHbskb1lBX0A4bGLNp7w6/YGO6rtITGLKmmmgsGwhMZP+pWAo
 z38mZJiU8wGokRphRrrlQ4RZAYD6zuNY+6REBGHuGFEYgRHce4jhf2sEk+3WJ34Nj3k+BI
 xlmq4bn8h3wptXNe0IyXSBxLVZbQCvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744017490;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5oQz+H4JqqlhsIeThOGdpMf00VyvdxnkzXSUfCQm8SQ=;
 b=Q6vaujst2ymo0xt1RJYrjvt4U8wkWlQtM21eOAlTPXXJpJn4GLf77rk7yg37O65YuZLHXA
 HFjetoy3YgxIn/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE4FA13A4B;
 Mon,  7 Apr 2025 09:18:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LoG1KVKY82fYPgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 07 Apr 2025 09:18:10 +0000
Date: Mon, 7 Apr 2025 11:18:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20250407091809.GA74858@pevik>
References: <20250402170718.1710388-1-siddhesh@gotplt.org>
 <20250404181406.2385612-1-siddhesh@gotplt.org>
 <20250404181406.2385612-2-siddhesh@gotplt.org>
 <a24e920b-4254-4cae-895d-64fdc0f5452e@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a24e920b-4254-4cae-895d-64fdc0f5452e@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] cve-2015-3290: Disable AVX for x86_64
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

> Hi,
> one nit below.

> On 04. 04. 25 20:14, Siddhesh Poyarekar wrote:
> > When the input compiler enables AVX, stack realignment requirements
> > causes gcc to fail to omit %rbp use, due to which the test fails to
> > clobber %rbp in inline asm.  Disable AVX to build the test on x86_64 so
> > that the test continues working.

> > Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
> > Reviewed-by: Martin Doucha <mdoucha@suse.cz>
> > ---
> >   testcases/cve/Makefile | 6 ++++++
> >   1 file changed, 6 insertions(+)

> > diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
> > index 01b9b9ccb..d545a7f93 100644
> > --- a/testcases/cve/Makefile
> > +++ b/testcases/cve/Makefile
> > @@ -22,6 +22,12 @@ ifneq (,$(filter $(HOST_CPU),x86 x86_64))
> >   meltdown: CFLAGS += -msse2
> >   endif
> > +# The test needs to clobber %rbp, which requires frame pointer omission.  Also
> > +# for x86_64, disable AVX since that could sometimes require a stack
> > +# realignment, which gets in the way of frame pointer omission.
> >   cve-2015-3290:	CFLAGS += -pthread -fomit-frame-pointer
> > +ifneq (,$(filter $(HOST_CPU),x86_64))

> If you don't want to add the command line option for 32bit x86 builds, then
> this condition would be cleaner:
> ifeq ($(HOST_CPU),x86_64)

+1. IMHO this works as expected. I suppose Siddhesh got inspiration for filter
due the above meltdown, where it is needed because it compares 2 archs. But
I will also appreciate an explicit confirmation.

Kind regards,
Petr

> We can fix that during merge but please confirm that we should.

> > +cve-2015-3290: CFLAGS += -mno-avx
> > +endif
> >   include $(top_srcdir)/include/mk/generic_leaf_target.mk

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
