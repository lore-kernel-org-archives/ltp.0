Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F15C4332F
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 08:18:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1A3A3C7319
	for <ltp@archiver.kernel.org>; Tue, 18 Oct 2022 10:18:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 792673C7319
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:18:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B1D4C6008DF
 for <ltp@lists.linux.it>; Tue, 18 Oct 2022 10:18:12 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D50AE33DFE;
 Tue, 18 Oct 2022 08:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666081091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0i1oDp11p3IsivIMPF5s9RbuzJsnnhhi7gyJRakz4Fk=;
 b=bxA8S5JkpriZr1nN6qe0GqWT1+d5iloMu15zdQBgoQp0TVV5pORYBVEgE7GF3Uiyo5l6wn
 Me/N9EbATq6NIkCxr6v1aa7HUNs5McIXj26CVn66fuTtmIL2xVPj6jXrqLDl/d0f71RlEm
 mFHzdQDyoK4Cm4k3XunH49WN/M12Yus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666081091;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0i1oDp11p3IsivIMPF5s9RbuzJsnnhhi7gyJRakz4Fk=;
 b=u6nUWMGrVyH6Sze9SXZU9UDet0Zhon2hMCygr1LHF4n3xxqCoDq8gxsAJ1JIDbKfSvsm+r
 UONZrHS9cxh5XgAw==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 13A782C141;
 Tue, 18 Oct 2022 08:18:10 +0000 (UTC)
References: <cover.1664418361.git.pengfei.xu@intel.com>
 <466821336a63ab9b6c236a0a1c4dbe056b7a5ac3.1664418361.git.pengfei.xu@intel.com>
 <Y0kD/eENxCPGYjOg@xpf.sh.intel.com> <871qr6o7xc.fsf@suse.de>
 <Y05VnBdOKEGXFUCk@xpf.sh.intel.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Pengfei Xu <pengfei.xu@intel.com>
Date: Tue, 18 Oct 2022 09:11:47 +0100
In-reply-to: <Y05VnBdOKEGXFUCk@xpf.sh.intel.com>
Message-ID: <87o7u9mtog.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ptrace07: should not use a hard-coded
 xstate size and use CPUID specified instead
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
Cc: Heng Su <heng.su@intel.com>, eric.devolder@oracle.com,
 chang.seok.bae@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Pengfei Xu <pengfei.xu@intel.com> writes:

> Hi Richard,
>
> On 2022-10-17 at 14:55:29 +0100, Richard Palethorpe wrote:
>> Hello,
>> 
>> Pengfei Xu <pengfei.xu@intel.com> writes:
>> 
>> > Hi,
>> >
>> > This patch fixes ptrace07 spurious failures when the platform xstate maxium
>> > size is bigger than 4096bytes(512*8 bytes).
>> >
>> > Thanks for comments!
>> 
>> This patch causes the test to fail on my Xeon workstation. The problem
>> seems to be the cpuid function which just fills the args with zeros.
>   Sorry, I didn't meet this issue,  I think I should use a new cpuid function.
>   Thanks for the report!
>
>> 
>> >
>> > BR.
>> >
>> > On 2022-09-29 at 10:30:20 +0800, Pengfei Xu wrote:
>> >> Should not use a hard-coded xstate size(512 * 8 = 4096 bytes) which is
>> >> wrong, should use maximum XSAVE size specified by CPUID.(EAX=0DH, ECX=0H):EBX.
>> >> If the CPU's maximum XSAVE size exceeds the hard-coded xstate size 4096 bytes,
>> >> it will cause the ptrace07 case to fail as below:
>> >> "
>> >> ./ptrace07
>> >> tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
>> >> ptrace07.c:142: TBROK: PTRACE_SETREGSET failed with unexpected error: EFAULT (14)
>> >> tst_test.c:1571: TINFO: Killed the leftover descendant processes
>> >> 
>> >> Summary:
>> >> passed   0
>> >> failed   0
>> >> broken   1
>> >> skipped  0
>> >> warnings 0
>> >> "
>> >> 
>> >> Reported-by: Eric DeVolder <eric.devolder@oracle.com>
>> >> Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
>> >> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
>> >> ---
>> >>  testcases/kernel/syscalls/ptrace/ptrace07.c | 25 +++++++++++++++++----
>> >>  1 file changed, 21 insertions(+), 4 deletions(-)
>> >> 
>> >> diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
>> >> index da62cadb0..0accaceb5 100644
>> >> --- a/testcases/kernel/syscalls/ptrace/ptrace07.c
>> >> +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
>> >> @@ -35,6 +35,7 @@
>> >>  #include "config.h"
>> >>  #include "ptrace.h"
>> >>  #include "tst_test.h"
>> >> +#include "ltp_cpuid.h"
>> 
>> This is from the old API (starts with ltp_) so we shouldn't use it
>> anymore. If it is being used at all, then it's being used in a way that
>> would allow it to silently fail AFAICT.
>> 
>   Thanks for the comments, I plan to add below __cpuid_count() macro function
> as below in ltp/include/tst_cpu.h first, there seems to be some other place to
> use the cpuid function.
>
> /*
>  * gcc cpuid.h provides __cpuid_count() since v4.4.
>  * Clang/LLVM cpuid.h provides  __cpuid_count() since v3.4.0.
>  *
>  * Provide local define for tests needing __cpuid_count() because
>  * ltp needs to work in older environments that do not yet
>  * have __cpuid_count().
>  */
> #ifndef __cpuid_count
> #define __cpuid_count(level, count, a, b, c, d)				\
> 	({								\
> 	__asm__ __volatile__ ("cpuid\n\t"				\
> 			      : "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
> 			      : "0" (level), "2" (count));		\
> 	})
> #endif

Looks good. Although this should go in ltp/include/lapi/cpuid.h as this
is where we put system header fallbacks.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
