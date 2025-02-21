Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0541C021AA
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 09:23:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6DF73C551A
	for <ltp@archiver.kernel.org>; Fri, 21 Feb 2025 10:23:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 252AC3C551A
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 10:23:34 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6E153633962
 for <ltp@lists.linux.it>; Fri, 21 Feb 2025 10:23:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4C6321F385;
 Fri, 21 Feb 2025 09:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740129812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=95V7o/VIJV0AqYb73Td1GlL2gKsvUotvOUFF80N1vYg=;
 b=dLEU/IN51uxkn6dbLabO+ynP+Qhfsbfzgda9CPITdyX6YPbE9PiSXHCGsazL9GOhxGgz/+
 VFsN2IrDxP/gxXtcyqImwF2DpgFTORSX3QBRVF4Wu79O3609J7h79YIr7DMMtPV8hVGrT/
 HUszjBm+yiAKxySjpXNUobeJr5PKXLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740129812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=95V7o/VIJV0AqYb73Td1GlL2gKsvUotvOUFF80N1vYg=;
 b=u2cmGiXBTZ4mEvslVgRzbDj1UIkpCBU0JZ8/VTlvReU9cYLb6PnFyqYfu3RxD6UWqL+bp3
 XyZ35hMQTFLcWdBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740129812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=95V7o/VIJV0AqYb73Td1GlL2gKsvUotvOUFF80N1vYg=;
 b=dLEU/IN51uxkn6dbLabO+ynP+Qhfsbfzgda9CPITdyX6YPbE9PiSXHCGsazL9GOhxGgz/+
 VFsN2IrDxP/gxXtcyqImwF2DpgFTORSX3QBRVF4Wu79O3609J7h79YIr7DMMtPV8hVGrT/
 HUszjBm+yiAKxySjpXNUobeJr5PKXLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740129812;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=95V7o/VIJV0AqYb73Td1GlL2gKsvUotvOUFF80N1vYg=;
 b=u2cmGiXBTZ4mEvslVgRzbDj1UIkpCBU0JZ8/VTlvReU9cYLb6PnFyqYfu3RxD6UWqL+bp3
 XyZ35hMQTFLcWdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3258313888;
 Fri, 21 Feb 2025 09:23:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VNgbCxRGuGdkJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 21 Feb 2025 09:23:32 +0000
Date: Fri, 21 Feb 2025 10:23:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250221092330.GA2745682@pevik>
References: <20250219160143.2589026-1-pvorel@suse.cz>
 <f2a0be74-94c4-480f-b53c-7ba4673014f1@suse.com>
 <20250220230000.GB2726725@pevik>
 <8240dcd3-fc9f-4c52-bf16-8c7a940cb470@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8240dcd3-fc9f-4c52-bf16-8c7a940cb470@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.982]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc: Link struct tst_test and tst_tag
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

> Hi Petr,

> On 2/21/25 00:00, Petr Vorel wrote:
> > I was although thinking about it, but haven't checked the code. I suppose you'll
> > be much faster than me with this as you're more familiar with sphinx. I gave up
> > because reader is nearly at the correct location.

> > I suppose missing code needs to be done in linuxdoc.rstKernelDoc extension.
> > Because although it's possible to link to the member in linuxdoc.rstKernelDoc
> > (e.g. &tst_test.needs_root), but it leads to "struct tst_test" [1] definition,
> > which has only anchors for Definitions [2] and Members [3]. I guess it's somehow
> > possible to link it via C domain [4], but it's not used in linuxdoc.rstKernelDoc
> > extension.

> > I tried linuxdoc [5] update to the latest 20240924 (not much changes anyway),
> > but members still do not have id sections.

> > Kind regards,
> > Petr

> > [1]https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#struct-tst-test
> > [2]https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#tst-test-definition
> > [3]https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#tst-test-members
> > [4]https://www.sphinx-doc.org/en/master/usage/domains/c.html#role-c-var
> > [5]https://github.com/return42/linuxdoc.git

> > > Andrea

> Thanks for the references, I took a look at it. It doesn't seem to be
> supported unless we change the code base of kerneldoc. I don't know if the
> effort is worth the result honestly. And the reference to tst_test for each
> struct attribute is a bit an overkill.

Well, I disagree it's an overkill. It help people to quickly see the related
structure. Also, structure members are just pretty close to the section of the
link.

Kind regards,
Petr

> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
