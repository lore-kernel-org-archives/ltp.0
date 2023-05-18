Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 022CDC77B7D
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 09:19:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28FC93CDC1F
	for <ltp@archiver.kernel.org>; Thu, 18 May 2023 11:19:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D555D3CB28B
 for <ltp@lists.linux.it>; Thu, 18 May 2023 11:19:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2B6FC600071
 for <ltp@lists.linux.it>; Thu, 18 May 2023 11:19:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6A0F11F8C2;
 Thu, 18 May 2023 09:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684401552;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N+0SJWYSVafVtS8HBeTiu2g7mpjGQgMWj3qPUF2ze/c=;
 b=LC9EUuayNBt5bPp6/pWLoskgqb62ool4EV2nACpDLuZzz+9TCuHd+kbfeyxkvN/ghtZ1Ds
 JCjlCX+b2Qsj1tC5SAcKYJZUem7oIxXCjBdMJFeOS57cUrbjsiwepz/dcbDOMNtpGGq56Y
 F0XNNUDKlw8pvXZoxvFRxKy2VxOMH8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684401552;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N+0SJWYSVafVtS8HBeTiu2g7mpjGQgMWj3qPUF2ze/c=;
 b=D0k2DxsIRl1wA+sXoXdtrBp7w8IfnpIzYAjAPMUUpiUeRmwXtYMcopGEtLNOlGutnFsvfc
 3JiinF0vuhhTq5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C9D4138F5;
 Thu, 18 May 2023 09:19:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ziGSEZDtZWSiUQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 18 May 2023 09:19:12 +0000
Date: Thu, 18 May 2023 11:56:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230518095602.GD6467@pevik>
References: <20230517153642.26919-1-mdoucha@suse.cz>
 <20230517153642.26919-3-mdoucha@suse.cz>
 <20230517223238.GB8914@pevik>
 <c2b0aa7c-8cca-e6a7-38aa-a96e65d9a7c0@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c2b0aa7c-8cca-e6a7-38aa-a96e65d9a7c0@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/7] Add test for CVE 2021-3656
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

> On 18. 05. 23 0:32, Petr Vorel wrote:
> > Hi Martin,

> > > +++ b/testcases/kernel/kvm/kvm_svm02.c
> > ...
> > > +
> > > +#ifdef COMPILE_PAYLOAD
> > > +#if defined(__i386__) || defined(__x86_64__)
> > > +
> > > +#include "kvm_x86_svm.h"
> > > +
> > > +#define AVIC_REG_ADDR 0x280
> > > +#define AVIC_TEST_VAL 0xec
> > > +#define AVIC_READ_FAIL 0x12ead
> > > +
> > > +#define AVIC_INFO_MASK ((1ULL << 32) | 0xff0)
> > > +#define AVIC_INFO_EXP ((1ULL << 32) | AVIC_REG_ADDR)

> > These five constants aren't used at all.
> > Maybe copy paste from kvm_svm01.c ?

> Yes, the AVIC constants are leftovers from copying kvm_svm01.c, sorry about
> that. Should I send a v2 after other patches get merged?

It'd be trivial to remove it, but if you send v2, please fix it there.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
