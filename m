Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB81C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 15:04:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E2143CA609
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 17:04:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8A383CA5C9
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 17:04:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CA305600973
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 17:04:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF2A41F747;
 Thu, 14 Apr 2022 15:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649948676; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Gu1qAGskpYVLCGWC3Gdry/XgtgZrD8NQVuLWH9AyrI=;
 b=bABgmp86X3wtKFHAbb/sGneOF2DU7lE/vc0hgQP7FPW0r7Jl743r/tejUO/WNwleJFTwXl
 YYB3Iv53uBgZZo6kM1Q8Exd0h+KDuc8403nDVyohj2T9FAE/uPbITW/0rEOlkmrzQ8F+7b
 ni+cKD3BCEuh2IU3dXeR80qJLZAwRQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649948676;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Gu1qAGskpYVLCGWC3Gdry/XgtgZrD8NQVuLWH9AyrI=;
 b=NQE8kh/oc3OTS3gOBS2EPcyqxSRhETYCXHt2VOqVZibAYypQoN4gXbbEdpM+sDZ2FQonG5
 33rrlTZZuzYLW/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CF68313A86;
 Thu, 14 Apr 2022 15:04:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1HZtMQQ4WGI1agAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 14 Apr 2022 15:04:36 +0000
Message-ID: <a4feb22e-d4f8-00dd-5970-0832dc90ddfa@suse.cz>
Date: Thu, 14 Apr 2022 17:04:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>
References: <20220331113324.14742-1-mdoucha@suse.cz>
 <20220331113324.14742-3-mdoucha@suse.cz> <Ylf2hd82r1pLFlbd@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Ylf2hd82r1pLFlbd@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

On 14. 04. 22 12:25, Cyril Hrubis wrote:
> Hi!
>> +/*
>> + * These constants must match the value of corresponding constants defined
>> + * in tst_res_flags.h.
>> + */
>> +#define TPASS	0	/* Test passed flag */
>> +#define TFAIL	1	/* Test failed flag */
>> +#define TBROK	2	/* Test broken flag */
>> +#define TWARN	4	/* Test warning flag */
>> +#define TINFO	16	/* Test information flag */
>> +#define TCONF	32	/* Test not appropriate for configuration */
> 
> The tst_res_flags.h header has been created so that there will be no
> need to copy these definitions around like this. Why not just include
> the header?

I didn't #include the tst_res_flags.h because the main LTP include
directory is not passed to the preprocessor when compiling KVM payload.
I'd have to do it like this:
#include "../../../../include/tst_res_flags.h"

>> +void tst_res_(const char *file, const int lineno, int result,
>> +	const char *message);
>> +#define tst_res(result, msg) tst_res_(__FILE__, __LINE__, (result), (msg))
>> +
>> +void tst_brk_(const char *file, const int lineno, int result,
>> +	const char *message) __attribute__((noreturn));
>> +#define tst_brk(result, msg) tst_brk_(__FILE__, __LINE__, (result), (msg))
> 
> I think that it may be slightly better to name these kvm_res() and
> kvm_brk() to make clear that these are used in the guest context and
> that the implementation is actually different. I guess that it would
> make sense to have all the functions called from the guest prefixed with
> kvm_ just to make the boundary clearer.

My idea was different:
- kvm_* prefix for low-level arch-specific functions
- tst_* prefix for reimplementation of standard LTP library functions
and any other platform-independent helper functions

tst_res() and tst_brk() currently lack the printf-like formatting
features (and the TERRNO/TTERRNO/TRERRNO flags are not applicable) but
otherwise they do the exact same thing as the standard LTP functions.
I'm planning to add some limited printf-like formatting later since
sprintf() implementation will be needed eventually anyway.

>> +void *tst_heap_alloc_aligned(size_t size, size_t align)
>> +{
>> +	uintptr_t addr = (uintptr_t)heap_end;
>> +	void *ret;
>> +
>> +	addr += align - 1;
>> +	addr -= addr % align;
>> +	ret = (void *)addr;
>> +	addr += size + 3;
>> +	addr -= addr % 4;
>> +	heap_end = (char *)addr;
>> +	return ret;
>> +}
>> +
>> +void *tst_heap_alloc(size_t size)
>> +{
>> +	void *ret = heap_end;
>> +
>> +	size += 3;
>> +	size -= size % 4;
>> +	heap_end += size;
>> +	return ret;
> 
> We do have a few similar pieces scattered around the code, can put the
> code into a macro that would make the code slightly easier to
> understand?
> 
> We do have LTP_ALIGN() in tst_common.h but I guess that we do not want
> to include it here in the guest library.

I guess that copying LTP_ALIGN() to the KVM headers would be useful.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
