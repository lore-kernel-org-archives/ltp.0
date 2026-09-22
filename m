Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B776C982F1
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 07:35:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3E633E6C87
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 09:35:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 017013CAF9C
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 09:35:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 85B8F600956
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 09:35:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9CE5821C9E;
 Tue, 22 Sep 2026 07:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790062529;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7OOPAp16Oi53+E42OXDEzZc/YZ+gHx+HfgXkfsfri44=;
 b=uReaJKzEVeK5ElVihWQ5OzJj5HVVDkonA0NfvABCogYO+NzvnHFStqc5Eack3Odm6NpeHo
 kgEBuCPkbxDxfjnQWCoHfuaggtxqIM+X8Xr0Ugsi0AITCE6T2kY4eCt8BX37lNhJEMx0uD
 oR7boDmNpgQj1D7msuDuDPIZosoUDJ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790062529;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7OOPAp16Oi53+E42OXDEzZc/YZ+gHx+HfgXkfsfri44=;
 b=dBYgu6qzmPMUypbrtu75pAFp2abfyFHOdqoydakY6W8L6AGW9czmdgfSaWwdVTT+g8eBP5
 bNn8nYy7b4OZQ9AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790062525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7OOPAp16Oi53+E42OXDEzZc/YZ+gHx+HfgXkfsfri44=;
 b=2MlnNcl5ael+9LZn5lZ7XJ22M0MI8qQ3P73nocz1L/EHvZdO2Io8ixsiRpfWoVSXRFsiMy
 mNJafCna67ddXK5KVQSJtZwCWBCnZxapwA3BEbcH1tqwAFLDCN/3/jNkwwA/uFoQpLSUfo
 FD+57iR0htnQA+PDcSVbqexvMP9GjJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790062525;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7OOPAp16Oi53+E42OXDEzZc/YZ+gHx+HfgXkfsfri44=;
 b=JIRZRC9kiN/CIWMrHkubbTZMiNwMsleErooaUXlpcnwixsdlIr734Nr5n694na+bAXnK78
 Gnc13jrMy7i6HKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4DC18139EE;
 Tue, 22 Sep 2026 07:35:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XPQFCL0vsmqgZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 07:35:25 +0000
Date: Tue, 22 Sep 2026 09:35:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260922073519.GA2146856@pevik>
References: <20260918125021.1939455-2-pvorel@suse.cz>
 <20260918170642.4762-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260918170642.4762-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 TAGGED_RCPT(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_assert: Use 'long long' to fix 32bit compat mode
 truncation
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

Hi all,

> Hi Andrea,

> On Fri, 18 Sep 2026, Andrea Cervesato wrote:
> > [PATCH 1/2] tst_assert: Use 'long long' to fix 32bit compat mode truncation

> --- [PATCH 1/2] ---

> > -	if (val == sys_val) {
> > +	if (val == (unsigned long)sys_val) {
> >  		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
> >  		return;
> >  	}

> > -	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu", path, val, sys_val);
> > +	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu",
> > +		path, val, (unsigned long)sys_val);

> Casting sys_val to unsigned long causes false passes on 32-bit systems
> whenever sys_val exceeds ULONG_MAX and (sys_val & 0xFFFFFFFF) equals val,
> while masking the actual value read in the failure log. Compare
> val == sys_val directly and report sys_val with %llu on mismatch;
> compat-mode truncation should be handled in test-specific code instead of
> altering generic assertion semantics.

I don't understand why casting is problem when the original code used unsigned
long for sys_val.

-	unsigned long sys_val;
+	unsigned long long sys_val;

=> I would say agent is wrong.

But the suggestion to modify the behavior for all tests due single 32bit mode
failure is something to be considered.

@Li @Cyril WDYT? Is this patchset safe, or we use the one contributed by Wei?
Other option would be to handle everything with custom code in shmctl03.c
(wait for library helper until it's really needed).

Also, if we change tst_assert(), do we want to somehow document in the kerneldoc
that code is ready for 32bit?

Kind regards,
Petr

> Verdict - Needs revision

> ---
> Note:

> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.

> Regards,
> LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
