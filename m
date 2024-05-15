Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65654C25B75
	for <ltp@archiver.kernel.org>; Wed, 15 May 2024 23:10:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F5833CF923
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 01:10:26 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BC073C81B3
 for <ltp@lists.linux.it>; Thu, 16 May 2024 01:10:08 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CCAC6100861B
 for <ltp@lists.linux.it>; Thu, 16 May 2024 01:10:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B34C33415D;
 Wed, 15 May 2024 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715814606;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u7Fk0o64NtpY8sxjj+SLr+yrGjin4ygGzaVCBArNzeM=;
 b=Gg5T7XT71nHenOo7x/f0Bf/s1B4rUutG27/sQqRQE4/SGLiNFDGh8lOEkQj/M6RzI3O6g7
 ECdwaD8UyQxA0TrCeZtjiugLdEywzofP6Hz0U4ECLk1RBTMXGba+WeOlO4fDLh3oY1U3YT
 FJH+vsmbEuUVcPg/SX+VdaQJlEhvwP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715814606;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u7Fk0o64NtpY8sxjj+SLr+yrGjin4ygGzaVCBArNzeM=;
 b=KHOnZbdLQMHJ8t32jec07XrpE+MKOJDoh8Ji16QTcz0Ey07qk9GgIrS+jwnPSAuI0ms3Kt
 2Mn7/7ruj0iFLkCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715814606;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u7Fk0o64NtpY8sxjj+SLr+yrGjin4ygGzaVCBArNzeM=;
 b=Gg5T7XT71nHenOo7x/f0Bf/s1B4rUutG27/sQqRQE4/SGLiNFDGh8lOEkQj/M6RzI3O6g7
 ECdwaD8UyQxA0TrCeZtjiugLdEywzofP6Hz0U4ECLk1RBTMXGba+WeOlO4fDLh3oY1U3YT
 FJH+vsmbEuUVcPg/SX+VdaQJlEhvwP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715814606;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u7Fk0o64NtpY8sxjj+SLr+yrGjin4ygGzaVCBArNzeM=;
 b=KHOnZbdLQMHJ8t32jec07XrpE+MKOJDoh8Ji16QTcz0Ey07qk9GgIrS+jwnPSAuI0ms3Kt
 2Mn7/7ruj0iFLkCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 98A15136A8;
 Wed, 15 May 2024 23:10:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zeUcJM5ARWaLZwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 15 May 2024 23:10:06 +0000
Date: Thu, 16 May 2024 01:10:04 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240515231004.GA234656@pevik>
References: <bbcfed6d-caff-43f8-96ce-77e6cb6afd2a@suse.com>
 <20240515142234.GA227672@pevik> <ZkTF2a0-z3Ok_PYO@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZkTF2a0-z3Ok_PYO@yuki>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] Refactor fork14 using new LTP API
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
> > +#ifndef TST_ABI32
> > +
> >  #define LARGE		(16 * 1024)
> >  #define EXTENT		(16 * 1024 + 10)

> > @@ -48,7 +52,7 @@ static void run(void)
> >  			if (failures > 10) {
> >  				tst_brk(TCONF, "mmap() fails too many "
> >  					"times, so it's almost impossible to "
> > -					"get a vm_area_struct sized 16TB.");
> > +					"get a vm_area_struct sized 16TB");
> >  			}

> >  			continue;
> > @@ -115,9 +119,11 @@ static struct tst_test test = {
> >  	.setup = setup,
> >  	.cleanup = cleanup,
> >  	.forks_child = 1,
> > -	.skip_in_compat = 1,
> >  	.tags = (const struct tst_tag[]) {
> >  		{"linux-git", "7edc8b0ac16c"},
> >  		{}
> >  	}
> >  };
> > +#else
> > +TST_TEST_TCONF("Not supported on x86 in 32-bit");
> > +#endif

> I think that adding ifdefs and removing metadata is actually a step
> back. I suppose that we need .skip_on_32bit or something similar.

OK, because it's trivial I'll send a patch with rebased Andrea's commit.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
