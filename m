Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDBFC77B7A
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 09:18:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92F9E3CDC1D
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 11:18:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 862113CB28B
 for <ltp@lists.linux.it>; Thu, 18 May 2023 11:18:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E78D4600700
 for <ltp@lists.linux.it>; Thu, 18 May 2023 11:18:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4BDE52263F;
 Thu, 18 May 2023 09:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684401488;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MG/TSooHXoztff4l7vtclIjKntLUu82Bv97SOxTkANk=;
 b=JDf0n4pVhuox11OV49YP2d4+y9ok1FbqVxrFUP9vZlaPejvv1qsPlN3mMHdiCEMnlsL1/c
 UY2m9EqCUxS2WNDgXhDZRDB28jcxYcFJ+G+CdYweIxF51PyzgBqh3jRSFxXv7SMf2hDgSS
 DBpviz3IjGKXQpHJr+srH3VIOCwSDlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684401488;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MG/TSooHXoztff4l7vtclIjKntLUu82Bv97SOxTkANk=;
 b=4fYuzAsOglEuByxngqGXNUvuG2xMWtdfirbwqntK24ueZx+6YC+nQlQDC7F3/NdY6Lo7/L
 p1wPY1mdar58uSBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3262F138F5;
 Thu, 18 May 2023 09:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qq8+C1DtZWQ8UQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 18 May 2023 09:18:08 +0000
Date: Thu, 18 May 2023 11:55:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230518095503.GC6467@pevik>
References: <20230517153642.26919-1-mdoucha@suse.cz>
 <20230517153642.26919-5-mdoucha@suse.cz>
 <20230517224746.GC8914@pevik>
 <18915cfd-8866-a01f-8562-1c6023a8e47f@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <18915cfd-8866-a01f-8562-1c6023a8e47f@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/7] KVM: Add async communication helper functions
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
Cc: ltp@lists.linux.it, Nicolai Stange <nstange@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 18. 05. 23 0:47, Petr Vorel wrote:
> > Hi Martin,

> > Acked-by: Petr Vorel <pvorel@suse.cz>

> > >   /*
> > >    * Result value indicating end of test. If the test program exits using
> > >    * the HLT instruction with any valid result value other than KVM_TEXIT or
> > > diff --git a/testcases/kernel/kvm/include/kvm_guest.h b/testcases/kernel/kvm/include/kvm_guest.h
> > > index ec13c5845..96f246155 100644
> > > --- a/testcases/kernel/kvm/include/kvm_guest.h
> > > +++ b/testcases/kernel/kvm/include/kvm_guest.h
> > > @@ -64,6 +64,20 @@ void tst_brk_(const char *file, const int lineno, int result,
> > >   	const char *message) __attribute__((noreturn));
> > >   #define tst_brk(result, msg) tst_brk_(__FILE__, __LINE__, (result), (msg))

> > BTW (unrelated to this commit, as it was not added to this commit) tst_brk()
> > definition from include/tst_test.h contains also
> > TST_BRK_SUPPORTS_ONLY_TCONF_TBROK().

> > And tst_res() has also TST_RES_SUPPORTS_TCONF_TFAIL_TINFO_TPASS_TWARN().

> The support macros are not needed, the controller program always handles
> TBROK using tst_brk() even if the guest incorrectly called tst_res(TBROK).

ack

> > We could rename tst_res_flags.h to tst_res.h and add there tst_brk() and
> > tst_res() definitions and tst_brk_() and tst_res_() signatures.

> I don't think that's a good idea. The guest library currently does not
> support variadic parameters for tst_res() and tst_brk() so the function
> signatures are slightly different.

Ah, right.

> > > diff --git a/testcases/kernel/kvm/lib_guest.c b/testcases/kernel/kvm/lib_guest.c
> > > index d3b2ac3d5..f3e21d3d6 100644
> > > --- a/testcases/kernel/kvm/lib_guest.c
> > > +++ b/testcases/kernel/kvm/lib_guest.c
> > > @@ -155,6 +155,22 @@ void tst_brk_(const char *file, const int lineno, int result,
> > >   	kvm_exit();
> > >   }

> > > +void tst_signal_host(void *data)
> > > +{
> > > +	test_result->file_addr = (uintptr_t)data;
> > > +	test_result->result = KVM_TSYNC;
> > > +}
> > > +
> > > +void tst_wait_host(void *data)
> > > +{
> > > +	volatile int32_t *vres = &test_result->result;
> > > +
> > > +	tst_signal_host(data);
> > > +
> > > +	while (*vres != KVM_TNONE)
> > > +		;
> > Interesting there is no any usleep().

> usleep() does not exist in the guest library. And even if it did, yielding
> the CPU to the host would prevent kvm_svm03 from ever reproducing the CLGI
> bug.

Ah, I thought I'm missing something obvious, thanks for an explanation.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
