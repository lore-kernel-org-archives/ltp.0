Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CC3CC433EF
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 09:09:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D6A553CA6B3
	for <ltp@archiver.kernel.org>; Wed, 20 Apr 2022 11:09:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 497AE3CA63D
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 11:09:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 27E031A00914
 for <ltp@lists.linux.it>; Wed, 20 Apr 2022 11:09:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 370E021115;
 Wed, 20 Apr 2022 09:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650445747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9S5xaUwarV22FXLfw/4A4P+Jzyy6SoMYpCmBoWK8qxc=;
 b=iaUKxkaa49c7wBO5UVsPALzNPSYMr/c8z762lNsv8x+GJ2NjA1yOZ8vIERm6/Twg4hZXBt
 QqHEGmu0SUIJTsmGFBqv1E6rJI7hfPjRQ38jGngQRoft7cSYjBJNd2jDCho6D9B0X/AdrW
 Qo3mKlSZBhK4+LuA1UNcutzSqwzRGS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650445747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9S5xaUwarV22FXLfw/4A4P+Jzyy6SoMYpCmBoWK8qxc=;
 b=GQ2geLzpFxdQGCq1jSzjn+JVy8JI6cLXP2mSjDh/P4R6N9W1sN0eHX3T7eEBwRD9/BHfol
 x4FfBOwQKMsctcAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20A0B13AD5;
 Wed, 20 Apr 2022 09:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MulsBrPNX2ItCQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 20 Apr 2022 09:09:07 +0000
Date: Wed, 20 Apr 2022 11:11:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Yl/OO5mBXW5h1e91@yuki>
References: <20220331113324.14742-1-mdoucha@suse.cz>
 <20220331113324.14742-3-mdoucha@suse.cz> <Ylf2hd82r1pLFlbd@yuki>
 <a4feb22e-d4f8-00dd-5970-0832dc90ddfa@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a4feb22e-d4f8-00dd-5970-0832dc90ddfa@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] KVM test infrastructure
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >> +/*
> >> + * These constants must match the value of corresponding constants defined
> >> + * in tst_res_flags.h.
> >> + */
> >> +#define TPASS	0	/* Test passed flag */
> >> +#define TFAIL	1	/* Test failed flag */
> >> +#define TBROK	2	/* Test broken flag */
> >> +#define TWARN	4	/* Test warning flag */
> >> +#define TINFO	16	/* Test information flag */
> >> +#define TCONF	32	/* Test not appropriate for configuration */
> > 
> > The tst_res_flags.h header has been created so that there will be no
> > need to copy these definitions around like this. Why not just include
> > the header?
> 
> I didn't #include the tst_res_flags.h because the main LTP include
> directory is not passed to the preprocessor when compiling KVM payload.
> I'd have to do it like this:
> #include "../../../../include/tst_res_flags.h"

And I guess that this is on purpose right?

As we can easily add it by adding -I$(top_src_dir)/include/ to the
CFLAGS.

> >> +void tst_res_(const char *file, const int lineno, int result,
> >> +	const char *message);
> >> +#define tst_res(result, msg) tst_res_(__FILE__, __LINE__, (result), (msg))
> >> +
> >> +void tst_brk_(const char *file, const int lineno, int result,
> >> +	const char *message) __attribute__((noreturn));
> >> +#define tst_brk(result, msg) tst_brk_(__FILE__, __LINE__, (result), (msg))
> > 
> > I think that it may be slightly better to name these kvm_res() and
> > kvm_brk() to make clear that these are used in the guest context and
> > that the implementation is actually different. I guess that it would
> > make sense to have all the functions called from the guest prefixed with
> > kvm_ just to make the boundary clearer.
> 
> My idea was different:
> - kvm_* prefix for low-level arch-specific functions
> - tst_* prefix for reimplementation of standard LTP library functions
> and any other platform-independent helper functions
> 
> tst_res() and tst_brk() currently lack the printf-like formatting
> features (and the TERRNO/TTERRNO/TRERRNO flags are not applicable) but
> otherwise they do the exact same thing as the standard LTP functions.
> I'm planning to add some limited printf-like formatting later since
> sprintf() implementation will be needed eventually anyway.

Ack.

> >> +void *tst_heap_alloc_aligned(size_t size, size_t align)
> >> +{
> >> +	uintptr_t addr = (uintptr_t)heap_end;
> >> +	void *ret;
> >> +
> >> +	addr += align - 1;
> >> +	addr -= addr % align;
> >> +	ret = (void *)addr;
> >> +	addr += size + 3;
> >> +	addr -= addr % 4;
> >> +	heap_end = (char *)addr;
> >> +	return ret;
> >> +}
> >> +
> >> +void *tst_heap_alloc(size_t size)
> >> +{
> >> +	void *ret = heap_end;
> >> +
> >> +	size += 3;
> >> +	size -= size % 4;
> >> +	heap_end += size;
> >> +	return ret;
> > 
> > We do have a few similar pieces scattered around the code, can put the
> > code into a macro that would make the code slightly easier to
> > understand?
> > 
> > We do have LTP_ALIGN() in tst_common.h but I guess that we do not want
> > to include it here in the guest library.
> 
> I guess that copying LTP_ALIGN() to the KVM headers would be useful.

Can you please respin the patchset with this change then?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
