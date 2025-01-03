Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517A2E77188
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 12:19:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8DF53C0652
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 13:19:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F33C13C04FC
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 13:19:06 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 93F9565F21D
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 13:19:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0EB1321114;
 Fri,  3 Jan 2025 12:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735906744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gCCmtVwgPhrDKWKe0rGu0fanaPp9HeohivRvCaksz4o=;
 b=v1SaE3Xa0iZ4w6ejzVfteBVu/apDPVclN6i9QpBypBCNy5t5e3glE0TejQII/L8ASgeU31
 Cjdi4dHh7ax3AYLMzryLOUAKIROtukMOkdXYqca4ZCXucjs5L3Ma/719ICyoJTC19NVBpG
 g0BPXY50z6a9YV9sfu1sUcc+mBSfz98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735906744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gCCmtVwgPhrDKWKe0rGu0fanaPp9HeohivRvCaksz4o=;
 b=4ekhy6GmZLFl9Wg0qWNrCngnV2UfqYTSE1RPZDX1S/WRIzVlPdbY7P1dJGSQR/Wio//AYY
 yAnapeiZ3kAWm4Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735906744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gCCmtVwgPhrDKWKe0rGu0fanaPp9HeohivRvCaksz4o=;
 b=v1SaE3Xa0iZ4w6ejzVfteBVu/apDPVclN6i9QpBypBCNy5t5e3glE0TejQII/L8ASgeU31
 Cjdi4dHh7ax3AYLMzryLOUAKIROtukMOkdXYqca4ZCXucjs5L3Ma/719ICyoJTC19NVBpG
 g0BPXY50z6a9YV9sfu1sUcc+mBSfz98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735906744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gCCmtVwgPhrDKWKe0rGu0fanaPp9HeohivRvCaksz4o=;
 b=4ekhy6GmZLFl9Wg0qWNrCngnV2UfqYTSE1RPZDX1S/WRIzVlPdbY7P1dJGSQR/Wio//AYY
 yAnapeiZ3kAWm4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9515F134E4;
 Fri,  3 Jan 2025 12:19:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Xr1GILfVd2fiOgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 03 Jan 2025 12:19:03 +0000
Date: Fri, 3 Jan 2025 13:18:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20250103121858.GC211314@pevik>
References: <20241213222014.1580991-1-pvorel@suse.cz>
 <20241213222014.1580991-3-pvorel@suse.cz>
 <a617f000c69875b5c02743c8f0a8fee72cb1ea55.camel@linux.ibm.com>
 <20241231100057.GB36475@pevik>
 <b577405f0c6d2af8de6650eb1cd8c69305f616bf.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b577405f0c6d2af8de6650eb1cd8c69305f616bf.camel@linux.ibm.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/8] ima_setup.sh: Allow to load predefined
 policy
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Mimi,

...
> > Do I understand correctly you talk about policy containing func=POLICY_CHECK [1]?

> Yes.  On a secure boot enabled system, the architecture specific policy might
> require the IMA policy itself to be signed.

> Snippet from ima_fs.c:

> #if IS_ENABLED(CONFIG_INTEGRITY_MACHINE_KEYRING) &&
> IS_ENABLED(CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY)
>         "appraise func=POLICY_CHECK appraise_type=imasig",
> #endif

> > Maybe there could be a test based on example [2].

> > echo /home/user/tmpfile > /sys/kernel/security/ima/policy
> > cp tmpfile /sys/kernel/security/ima/policy
> > cat tmpfile > /sys/kernel/security/ima/policy

> All of the above will load a policy, assuming the policy itself doesn't need to
> be signed.  Only "echo /home/user/tmpfile > /sys/kernel/security/ima/policy" can
> load a signed policy.

> Loading a CA key (mokutil), signing (evmctl)[1] and loading (keyctl) an IMA
> policy is probably beyond LTP.  The purpose of this test would be to detect
> whether policies need to be signed.

The most advanced for LTP is currently solving reboot [3].

FYI we plan to add support [4] to our kirk tool [5] (currently supports running LTP,
kselftest and liburing, testing via SSH, qemu).

I suppose given how sparse is IMA/EVM testing in LTP this can wait (there are
more basic features not covered by testing). I suppose most of the testing you
have in ima-evm-utils repo (at least I found only IMA related code in kselftest
in BPF tests).

> Going forward what's probably needed is a new package containing a set of pre-
> defined sample custom policies, which are signed by the distro.

Please let me now once you or other IMA devs are doing any work in this.

Kind regards,
Petr

> [1] Directions for signing and loading a custom policy,
> https://ima-doc.readthedocs.io/en/latest/ima-utilities.html#sign-and-install-a-custom-policy

> Thanks,

> Mimi


> > Kind regards,
> > Petr

> > [1] https://ima-doc.readthedocs.io/en/latest/policy-syntax.html#func-policy-check
> > [2] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#runtime-custom-policy

[3] https://github.com/linux-test-project/ltp/issues/868
[4] https://github.com/linux-test-project/kirk/issues/12
[5] https://github.com/linux-test-project/kirk

> > > > +}

> > > Mimi




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
