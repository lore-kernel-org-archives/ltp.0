Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D69C433FE
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 14:13:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7945B3CAFF0
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 16:13:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 055533CAFC3
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 16:12:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 207601400450
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 16:12:53 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5A14233E5B;
 Mon, 17 Oct 2022 14:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666015973;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TDFQfg7JSR2DDPCdA+yF4zd0oGN6bbTYfxwaxw1OV3E=;
 b=NwsNBd/BFZTpY6ExgZ7PNIoZfNxf8tJ2fo6cH1dPc66OwsxeuPSlx7F97cYvDf7aVoih09
 RiE5SUOI+PaIRi3+Frwb4MZgTrQ+wZiJ/ACzmsob6gm+LqREh073EvD07WKiBSu9OVFCnX
 H/3wRmyQeAXwd12trOViabpAKe84+4E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666015973;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TDFQfg7JSR2DDPCdA+yF4zd0oGN6bbTYfxwaxw1OV3E=;
 b=7rulyvs+z265ZC28oD5SHnesDp/5TNq4XZQD/WxMpYoGYMaLd1xkm+thFulFvy1fswJ+vo
 PmkEgeXm50in4JCQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2CE3B2C141;
 Mon, 17 Oct 2022 14:12:52 +0000 (UTC)
References: <cover.1664418361.git.pengfei.xu@intel.com>
 <466821336a63ab9b6c236a0a1c4dbe056b7a5ac3.1664418361.git.pengfei.xu@intel.com>
 <Y0kD/eENxCPGYjOg@xpf.sh.intel.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Pengfei Xu <pengfei.xu@intel.com>
Date: Mon, 17 Oct 2022 14:55:29 +0100
In-reply-to: <Y0kD/eENxCPGYjOg@xpf.sh.intel.com>
Message-ID: <871qr6o7xc.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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

> Hi,
>
> This patch fixes ptrace07 spurious failures when the platform xstate maxium
> size is bigger than 4096bytes(512*8 bytes).
>
> Thanks for comments!

This patch causes the test to fail on my Xeon workstation. The problem
seems to be the cpuid function which just fills the args with zeros.

>
> BR.
>
> On 2022-09-29 at 10:30:20 +0800, Pengfei Xu wrote:
>> Should not use a hard-coded xstate size(512 * 8 = 4096 bytes) which is
>> wrong, should use maximum XSAVE size specified by CPUID.(EAX=0DH, ECX=0H):EBX.
>> If the CPU's maximum XSAVE size exceeds the hard-coded xstate size 4096 bytes,
>> it will cause the ptrace07 case to fail as below:
>> "
>> ./ptrace07
>> tst_test.c:1528: TINFO: Timeout per run is 0h 00m 30s
>> ptrace07.c:142: TBROK: PTRACE_SETREGSET failed with unexpected error: EFAULT (14)
>> tst_test.c:1571: TINFO: Killed the leftover descendant processes
>> 
>> Summary:
>> passed   0
>> failed   0
>> broken   1
>> skipped  0
>> warnings 0
>> "
>> 
>> Reported-by: Eric DeVolder <eric.devolder@oracle.com>
>> Reviewed-by: Chang S. Bae <chang.seok.bae@intel.com>
>> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
>> ---
>>  testcases/kernel/syscalls/ptrace/ptrace07.c | 25 +++++++++++++++++----
>>  1 file changed, 21 insertions(+), 4 deletions(-)
>> 
>> diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
>> index da62cadb0..0accaceb5 100644
>> --- a/testcases/kernel/syscalls/ptrace/ptrace07.c
>> +++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
>> @@ -35,6 +35,7 @@
>>  #include "config.h"
>>  #include "ptrace.h"
>>  #include "tst_test.h"
>> +#include "ltp_cpuid.h"

This is from the old API (starts with ltp_) so we shouldn't use it
anymore. If it is being used at all, then it's being used in a way that
would allow it to silently fail AFAICT.

>>  
>>  #ifndef PTRACE_GETREGSET
>>  # define PTRACE_GETREGSET 0x4204
>> @@ -48,6 +49,8 @@
>>  # define NT_X86_XSTATE 0x202
>>  #endif
>>  
>> +#define CPUID_LEAF_XSTATE 0xd
>> +
>>  static void check_regs_loop(uint32_t initval)
>>  {
>>  	const unsigned long num_iters = 1000000000;
>> @@ -83,8 +86,15 @@ static void do_test(void)
>>  	int i;
>>  	int num_cpus = tst_ncpus();
>>  	pid_t pid;
>> -	uint64_t xstate[512];
>> -	struct iovec iov = { .iov_base = xstate, .iov_len = sizeof(xstate) };
>> +	uint32_t eax, ebx, ecx = 0, edx;
>> +	uint64_t *xstate;
>> +	/*
>> +	 * CPUID.(EAX=0DH, ECX=0H):EBX: maximum size (bytes, from the beginning
>> +	 * of the XSAVE/XRSTOR save area) required by enabled features in XCR0.
>> +	 */
>> +	cpuid(CPUID_LEAF_XSTATE, &eax, &ebx, &ecx, &edx);
>> +	xstate = aligned_alloc(64, ebx);
>> +	struct iovec iov = { .iov_base = xstate, .iov_len = ebx };
>>  	int status;
>>  	bool okay;

Adding:

tst_res(TINFO, "EAX=%u, ECX=%u, EBX=%u", eax, ecx, ebx);

prints:

ptrace07.c:101: TINFO: EAX=0, ECX=0, EBX=0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
