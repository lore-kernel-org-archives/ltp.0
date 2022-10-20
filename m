Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8747C433FE
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 07:56:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6776F3CB170
	for <ltp@archiver.kernel.org>; Thu, 20 Oct 2022 09:56:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E672F3CB0D1
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 09:56:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 242901401114
 for <ltp@lists.linux.it>; Thu, 20 Oct 2022 09:56:33 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9DB201F9C4;
 Thu, 20 Oct 2022 07:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666252591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RgTMzXK5MshcK4Y53vf06dsSjAhP7Lf8JJ7wmc+2Wt8=;
 b=AQ3RylTzmOx7iGXd8rWuor6TIs1ScSuG2laVfXEaBJ7T79dyMJ/ZqXBzvzx5Vw5xHw1gRi
 CvyXX+px3wtcMmYJdMiLMrgp+tYWsGtu1cphcz7MDU9dV6xSWsSjXdv20N9zEboaEZHI0c
 Kc3CnV7LtYXwu4JtSRQ6+s+OsUvvNe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666252591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RgTMzXK5MshcK4Y53vf06dsSjAhP7Lf8JJ7wmc+2Wt8=;
 b=rDkdEOheidrUzjy9qEUWFuzs1mFuxflUFyuTE8vE+VRaKyEWqmoZ13CLRpgH7FJOAoT3LZ
 /rNbXzIozQF8hvCA==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2AFF32C141;
 Thu, 20 Oct 2022 07:56:31 +0000 (UTC)
References: <20221018152527.4636-1-rpalethorpe@suse.com>
 <f15cfed9-b389-b176-9d7d-8f2fcc8aaff0@suse.cz>
 <CAEemH2fVhxhZNsMx0_CU8am_MRoOxnJ1fgu=qJTRag5z1=o0Yw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 20 Oct 2022 08:31:35 +0100
In-reply-to: <CAEemH2fVhxhZNsMx0_CU8am_MRoOxnJ1fgu=qJTRag5z1=o0Yw@mail.gmail.com>
Message-ID: <87edv3vsgh.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ptrace07: Fix compilation when not on x86
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> On Wed, Oct 19, 2022 at 5:30 PM Martin Doucha <mdoucha@suse.cz> wrote:
>
>  On 18. 10. 22 17:25, Richard Palethorpe via ltp wrote:
>  > Strictly cpuid.h should not be included on non-x86, but this means
>  > each test author has to remember not to include it. Instead we can set
>  > a blank macro to allow compilation.
>  > 
>  > Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>  > ---
>
>  Hi,
>  defining an empty macro is a bad idea because it'll allow a broken test 
>  to be compiled and then it'll behave erratically for no apparent reason. 
>  It's better to get a build failure.
>
>  Reverting 1df4de06206b079f24dde7157d037b48727c743d is the best solution 
>  here. Building ptrace07 and similar arch-specific tests without a key 
>  piece of code does not make sense. The preprocessor arch checks should 
>  wrap around the whole file, not just a small non-portable bit that's 
>  crucial for the test to work.
>
> From what I know, one of the uses of "empty macro" is to conditionally
> include certain portions of a program. In ptrace07, it invokes that useless
> macro for compiling pass on non-x86 arch but does not allow execute it.
>
> I don't see why that's crucial for a test, if we wrap around the whole file and
> avoid it compiling on non-x86, isn't this essentially same as that? 
>
> The only distinction between them is partly or wholly skipping the key
> code compilation. or maybe I completely misunderstood this part.

Yes that's it. Since we decided to skip arches depending on what is
tst_test instead of compiling out the whole test. Which we want to do
because it provides meta-data.

I guess we could define the macro as ts_brk(TCONF, ...). However another
problem I just thought of is that cpuid.h might exist on a non-x86
system. So we'll still get a compilation failure.

Ideally we want compilation to fail even on x86 if the correct guards
are not in place and we include cpuid.h.

So we could use some macros like TST_ARCH_GUARD_X86 which is defined by
TST_IF_X86 and undefined by TST_ELSE_X86/TST_ENDIF_X86. Then cpuid.h can
check for that macro.

We could also define assembly in TST_ASM_X86 etc., although it's more
obvious that won't compile on non x86.

Alternatively I could try doing something in Sparse, but the macro pass
is maybe not as easy to hook into.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
