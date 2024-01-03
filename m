Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AC08C3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 08:44:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 612403CE773
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 09:44:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 267403C8BA4
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 09:44:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3FF7E1A00FCB
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 09:44:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7D1981F799;
 Wed,  3 Jan 2024 08:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704271468;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4lJ4CeWHYiseSDSLA5q3mYcxhZHIlU/VlWfg2Gn9A0=;
 b=fqU4bT4Zzusk9WAzqnP3NNOXgS+TSW0+CX0ofUm1twkAZz/FuJdkX5paeGY7M8fuBN4Hz4
 6+iu6LkNz+h7CY5RDEARtcrzRGPAi7K1NbarNAs5M61uUKFc+DMwDMuKKJyhYwxJYDsva4
 Te2kLIu0lpgbG2xz4ySN5ZQRO+E8hNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704271468;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4lJ4CeWHYiseSDSLA5q3mYcxhZHIlU/VlWfg2Gn9A0=;
 b=RoMuEZdXo90imtpOuMsBD/NCrCGVwy9BAFwL7Adp7X3JBJhfajTnOM+2knliUEUhbMHnDR
 WYph4Zr4dsEXpRAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704271468;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4lJ4CeWHYiseSDSLA5q3mYcxhZHIlU/VlWfg2Gn9A0=;
 b=fqU4bT4Zzusk9WAzqnP3NNOXgS+TSW0+CX0ofUm1twkAZz/FuJdkX5paeGY7M8fuBN4Hz4
 6+iu6LkNz+h7CY5RDEARtcrzRGPAi7K1NbarNAs5M61uUKFc+DMwDMuKKJyhYwxJYDsva4
 Te2kLIu0lpgbG2xz4ySN5ZQRO+E8hNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704271468;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l4lJ4CeWHYiseSDSLA5q3mYcxhZHIlU/VlWfg2Gn9A0=;
 b=RoMuEZdXo90imtpOuMsBD/NCrCGVwy9BAFwL7Adp7X3JBJhfajTnOM+2knliUEUhbMHnDR
 WYph4Zr4dsEXpRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13C3A1340C;
 Wed,  3 Jan 2024 08:44:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HAz9OmselWW0YgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 03 Jan 2024 08:44:27 +0000
Date: Wed, 3 Jan 2024 09:44:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240103084425.GB1073466@pevik>
References: <20231206105318.11832-1-wegao@suse.com>
 <20231222100611.12661-1-wegao@suse.com>
 <20231227132144.GA740736@pevik> <20231227144839.GB757946@pevik>
 <ZZUZBfdTGaQ7huVg@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZUZBfdTGaQ7huVg@rei>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.12 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.62)[92.61%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcwd01: Implement .test_variants
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

Hi Cyril, all,

> Hi!
> > @Li @Cyril: are you ok to test libc getcwd() wrapper implementations on NULL
> > buffer in getcwd01.c? Or we just skip NULL buffer test on all libc?
> > I would be ok to test it, because change in the implementation can influence
> > lots of user space software, although glibc or any other libc can obviously
> > change it's behavior.

> I guess that the easiest solution is to run the test in a child and pass
> the test both on EFAULT and child being killed by SIGSEGV. Any special
> cases and ifdefs are assuming something that is not promised and will
> have to be changed sooner or later.

Good point. I guess something like testcases/kernel/syscalls/mmap/mmap05.c
approach right? Wei, could you try that?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
