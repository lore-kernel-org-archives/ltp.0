Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EB2C54EBD
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 09:51:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76A503CCA6F
	for <ltp@archiver.kernel.org>; Thu, 12 Jan 2023 10:51:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 620813CA19D
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 10:51:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7EE972009E5
 for <ltp@lists.linux.it>; Thu, 12 Jan 2023 10:51:46 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 66EE83EE10;
 Thu, 12 Jan 2023 09:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673517105;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b3+9clgffESsFTcN4DAs7GMsFGYXdb5XSLK4HYtPUZU=;
 b=vRow922R+n4JybTjguAXTyUJOkRFHLh8aLSjmO1tQMxdmlrKL27bmWQU9UkuX9OtzjBKoB
 GVPL1PHQl7dn1Q1hDdm12XBN4CLVNeP20Kkw4ROyaF5oRb6AKmbtEHytszlOKwXD+WepA1
 X6fh17t6nr8nuCAsSlQcLQRPhA0YOtE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673517105;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b3+9clgffESsFTcN4DAs7GMsFGYXdb5XSLK4HYtPUZU=;
 b=bDUl2A9XSEZjvz5lKd3pTE/JoNnQhG0+i4ceMwZMB5RLzQhb3hKvFJ324pRMBbK9uIDyGx
 sCVEEmBBNQmJbUBw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 36A972C141;
 Thu, 12 Jan 2023 09:51:45 +0000 (UTC)
References: <20230110141616.1449-1-rpalethorpe@suse.com>
 <20230110141616.1449-2-rpalethorpe@suse.com> <Y725Bp/EcVM3U4Cu@pevik>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Jan 2023 08:54:19 +0000
Organization: Linux Private Site
In-reply-to: <Y725Bp/EcVM3U4Cu@pevik>
Message-ID: <877cxsjd1r.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] fcntl{34,
 36}: Always use 64-bit flock struct to avoid EINVAL
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
Cc: Khem Raj <raj.khem@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
> [ Cc Khem Raj ]
>
>> Recently we switched to using struct fcntl with _FILE_OFFSET_BITS
>> instead of the transitional type fcntl64 which has been removed from
>> some libcs.
>
> Do you mean b0320456cd ("testcases: Fix largefile support") ?
> Because this commit really broke both 32 bit emulation
> + (obviously) LTP on native 32bit.
>
> Please add before merge:
>
> Fixes: b0320456c ("testcases: Fix largefile support")

I suppose, thanks. I'm not sure how much fixes tags help in LTP? In
kernel they are used in automatic backporting and such.

>
> (although this needs also previous fix)
>
>> This broke testing with 32-bit executables on a 64bit kernel when
>> FILE_OFFSET_BITS was not set to 64. Because the fcntl64 syscall does
>> not exist on 64 bit kernels.
>
>> The reason we are making the syscall directly is because of old
>> glibc's which don't do any conversion.
>
>> So we now do a conversion unconditionally and call fcntl64 if the
>> kernel is 32-bit.
> +1.
>
>> When we no longer support old glibcs we can drop this compat function
>> altogether.
> I wonder which glibc these are. And how about musl?

I find it difficult to tell honestly. Pre 2.28 perhaps which is just
what "git describe --contains" suggests.

Muslc appears to always use 64-bit fcntl.

>
> Anyway, thanks!
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>

Will merge, thanks!

>
> Few unimportant notes below.
> ...
>
>> +++ b/testcases/kernel/syscalls/fcntl/fcntl_common.h
>> @@ -1,38 +1,71 @@
>>  #ifndef FCNTL_COMMON_H__
>>  #define FCNTL_COMMON_H__
>
>> +#include <inttypes.h>
>> +
>> +#include "tst_test.h"
>> +#include "tst_kernel.h"
>> +
>>  #include "lapi/syscalls.h"
>>  #include "lapi/abisize.h"
>> +#include "lapi/fcntl.h"
>> +
>> +struct my_flock64 {
>> +	int16_t l_type;
>> +	int16_t l_whence;
>> +	int64_t l_start;
>> +	int64_t l_len;
>> +	int32_t l_pid;
>> +#if defined(__sparc__)
> nit: #ifdef __sparc__
>
> Well, we still support 32bit sparc (you did support for atomic in
> include/tst_atomic.h), but IMHO it's dead (I might ask if John Paul Adrian
> Glaubitz knows about anybody using LTP for testing on sparc).  But as this is in
> kernel struct, there is no harm to keep it for LTP as well.

Yes, my main thinking was that it is easy to include and I'm not sure if
__sparc__ also gets set on sparc64 or whatever is actually in use.

>
>> +	int16_t padding;
>> +#endif
>> +};
>
> ...
>
>> +static inline int fcntl_compat(const char *file, const int line, const char *cmd_name,
>> +			       int fd, int cmd, struct flock *lck)
>>  {
>> -	int ret = tst_syscall(__NR_fcntl64, fd, cmd, lck);
>> -	if (ret == -1)
>> -		tst_brk(TBROK|TERRNO, "fcntl64");
>> +	struct my_flock64 l64 = {
>> +		.l_type = lck->l_type,
>> +		.l_whence = lck->l_whence,
>> +		.l_start = lck->l_start,
>> +		.l_len = lck->l_len,
>> +		.l_pid = lck->l_pid,
>> +	};
>> +	const long sysno = tst_kernel_bits() > 32 ? __NR_fcntl : __NR_fcntl64;
>> +	const int ret = tst_syscall(sysno, fd, cmd, &l64);
>> +
>> +	lck->l_type = l64.l_type;
>> +	lck->l_whence = l64.l_whence;
>> +	lck->l_start = l64.l_start;
>> +	lck->l_len = l64.l_len;
>> +	lck->l_pid = l64.l_pid;
>> +
>> +	if (ret != -1)
>> +		return ret;
>> +
>> +	tst_brk_(file, line, TBROK | TERRNO,
>> +		 "%s(%d, %s, { %d, %d, %"PRId64", %"PRId64", %d })",
>> +		 tst_kernel_bits() > 32 ? "fcntl" : "fcntl64",
> nit: maybe cache tst_kernel_bits() to variable?

The function already does it.

>
> Kind regards,
> Petr
>
>> +		 fd,
>> +		 cmd_name,
>> +		 l64.l_type, l64.l_whence, l64.l_start, l64.l_len, l64.l_pid);
>> +
>>  	return ret;
>>  }
>> -#endif
>> +
>> +#define FCNTL_COMPAT(fd, cmd, flock) \
>> +	fcntl_compat(__FILE__, __LINE__, #cmd, fd, cmd, flock)
>
>>  #endif /* FCNTL_COMMON_H__ */


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
