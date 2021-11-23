Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD32C433F5
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 09:14:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 244263C8DC0
	for <ltp@archiver.kernel.org>; Tue, 23 Nov 2021 10:14:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C3013C8982
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 10:14:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1C3701A009B6
 for <ltp@lists.linux.it>; Tue, 23 Nov 2021 10:14:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A969218B0;
 Tue, 23 Nov 2021 09:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637658846; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0BsCI5au1OhVtEK7irGEN31UeiYvwLKt5QBWIYycWk=;
 b=ufVVaWkIW15ubVYjVQXkUhru0CmIYw6COyO4RbUHN4g8bO/GDCzv37Oinm/BG7DLIhEa8+
 iZblCe/qFyl4pRAPrvhAVJFGCNBpMDsXZZF2PZdZz8JpJ57O9OrBx2TZSPISokQ1tw0/3y
 bHsRMkPI23ILl6I2Bt+E2fcgBytQGgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637658846;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C0BsCI5au1OhVtEK7irGEN31UeiYvwLKt5QBWIYycWk=;
 b=d+9ikYoA/1XAAYQ2wBoAXvFWgv8FR8YhiJGkjXmT4fpLNozLVyDvfrlhXdekUbCHoASI59
 Tyo0QALogRIS6lBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4874113DA3;
 Tue, 23 Nov 2021 09:14:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mwvtD96wnGHsDgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 23 Nov 2021 09:14:06 +0000
Date: Tue, 23 Nov 2021 10:15:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Zack Weinberg <zack@owlfolio.org>
Message-ID: <YZyxIJ9LGiCx2N74@yuki>
References: <YZvIlz7J6vOEY+Xu@yuki>
 <c5993ee9-1b5d-4469-9c0e-8d4e0fbd575a@www.fastmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c5993ee9-1b5d-4469-9c0e-8d4e0fbd575a@www.fastmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] uapi: Make __{u, s}64 match {u,
 }int64_t in userspace
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
Cc: linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
 libc-alpha@sourceware.org, linux-kernel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I am all for matching __uN / __sN to uintN_t / intN_t in userspace, but may I suggest the technically simpler and guaranteed-to-be-accurate
> 
>  /*
> - * int-ll64 is used everywhere now.
> + * int-ll64 is used everywhere in kernel now.
> + * In user space match <stdint.h>.
>   */
> +#ifdef __KERNEL__
>  # include <asm-generic/int-ll64.h>
> +#elif __has_include (<bits/types.h>)
> +# include <bits/types.h>
> +typedef __int8_t __s8;
> +typedef __uint8_t __u8;
> +typedef __int16_t __s16;
> +typedef __uint16_t __u16;
> +typedef __int32_t __s32;
> +typedef __uint32_t __u32;
> +typedef __int64_t __s64;
> +typedef __uint64_t __u64;
> +#else
> +# include <stdint.h>
> +typedef int8_t __s8;
> +typedef uint8_t __u8;
> +typedef int16_t __s16;
> +typedef uint16_t __u16;
> +typedef int32_t __s32;
> +typedef uint32_t __u32;
> +typedef int64_t __s64;
> +typedef uint64_t __u64;
> +#endif
> 
> The middle clause could be dropped if we are okay with all uapi headers potentially exposing the non-implementation-namespace names defined by <stdint.h>.  I do not know what the musl libc equivalent of <bits/types.h> is.

If it's okay to depend on a header defined by a libc this is better
solution.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
