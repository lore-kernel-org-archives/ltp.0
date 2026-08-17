Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE82C5B572
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 16:31:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A4E43CB970
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 18:31:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE5F03C1C6B
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 18:31:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8B536140042E
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 18:31:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 742CF3E47;
 Mon, 17 Aug 2026 16:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786984273;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=23VqEHMv+CS45Md72mvYiNXP/iIRQC+5wOUMznhIc74=;
 b=GJrwx04vMngzkm68XSKbIVEayid8Da+9QH++dbNe7yiJawWfiCrG4iSqP98gWuZ1li5I6z
 KWXpRPS+AU5gRj4tynMdMTTk+WbTYX6/OT9wLn5gccBvX/yyKdI/b4060dKeeS/tAgXRw7
 YA5LeGgy1nTcBkBFeEyOJlyXPN/bIeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786984273;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=23VqEHMv+CS45Md72mvYiNXP/iIRQC+5wOUMznhIc74=;
 b=0ewHL6ZLdsPOzy4QygN2O2SR3N5gwEmmemDk40QLSa+4mz7QTb0nN34939fg8qRboRQTRO
 fDeEEuUB8Mi4R3Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786984269;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=23VqEHMv+CS45Md72mvYiNXP/iIRQC+5wOUMznhIc74=;
 b=nK5z3k6wFRurXB2qXvQ4PUeQVMhU6Ajjm9lh8rtMz4PMn/H3q9KazmBwl9CdhAaQAdxExl
 Sxn5Yym+Cc34mVBISwl9ny8Y3dtHZji4Amny98NdB92PGFU+ZIwG0oPRFcmMCBXx4vyL3V
 UyPPGq5LV16cEia+gVmv+GJy7+h/dwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786984269;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=23VqEHMv+CS45Md72mvYiNXP/iIRQC+5wOUMznhIc74=;
 b=K4BvnAz1HdeikFXECnSXL6lwBJi0uNSTYaA9XICGmeNjqmeBoQYu3P1C3Z9zzk8/0uZEKV
 ZOSiTZ8Xs/BHEABQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA32379568;
 Mon, 17 Aug 2026 16:31:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 09OGJUs3g2o5fQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 17 Aug 2026 16:31:07 +0000
Date: Mon, 17 Aug 2026 18:31:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260817163100.GA2025511@pevik>
References: <20260810160048.1040517-1-pvorel@suse.cz>
 <20260810160048.1040517-4-pvorel@suse.cz>
 <anxTyVyeeMo6EQfG@yuki.lan> <20260812130025.GB1758016@pevik>
 <an7pLCWfdgEPV6G1@yuki.lan> <20260814104002.GA1950245@pevik>
 <an7y_pMz9noBnKcW@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <an7y_pMz9noBnKcW@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/7] lib: Add support for max_kver to struct
 tst_test and tst_fs
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

> Hi!
> > > Which ones?

> > I'm about to merge the original approach for fanotify20 (just to join split
> > string):
> > https://lore.kernel.org/ltp/20260616210448.12175-2-anonymemeow@gmail.com/

> Yes please. Feel free to add my Reviewed-by:

I'm very sorry, I read this after merging the original solution:
936dc02725 ("fanotify20: Skip FAN_REPORT_PIDFD | FAN_REPORT_TID test on v7.2+")

Next time I double check my mailbox before merging (I have checked the patch
itself).

> > I guess these 2 could be merged:
> > https://lore.kernel.org/ltp/20260810160048.1040517-6-pvorel@suse.cz/
> > https://lore.kernel.org/ltp/20260810160048.1040517-5-pvorel@suse.cz/

> Reviewed.

Thank you (merged).

> > And then we are done with the test fixes, I wonder if it's worth to add
> > lib/newlib_tests/tst_max_kver_old.c (only this one) from this patchset

> > https://lore.kernel.org/ltp/20260810160048.1040517-8-pvorel@suse.cz/

> So you stil want to add .max_kver to the tst_test structure?

No, at least not now. We really have only single test to be used (fanotify20.c),
for which I have merged the original approach.

Let's see in the future if more tests need it. From the docs point it'd be nice
to have it, but you were right that one test is really not enough. Also whole
discussions about the ideal functionality are waste of time for a single test.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
