Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A17C43334
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 07:56:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AB673C9293
	for <ltp@archiver.kernel.org>; Fri, 10 Jun 2022 09:56:55 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 237A53C72FC
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 09:56:43 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 581366011FA
 for <ltp@lists.linux.it>; Fri, 10 Jun 2022 09:56:42 +0200 (CEST)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 0AF029F7FD;
 Fri, 10 Jun 2022 07:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1654847801; bh=UcxItkrDeA53KDoAn9EK9iz11MbqK/qHgy6LNmyGSwo=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=VrTbZwazEy7cTQf/F4D4tg0cYgyyKm1MCngLs2JM9VI8CUnn4bn6Pr02hxkPVvPyb
 0anQW+YpZg7yZB/bGC7xW0D4GsoH584s8vyKKSfE1Cn7MWT5+PLh8xmzBvWoe65agW
 Xk8TBwuCLMMmFsM2SQFZDQ6ZOGLRkyHQ6z7DFKqM=
Message-ID: <024cf3d9-f9c1-80a4-8b06-799309912c7f@jv-coder.de>
Date: Fri, 10 Jun 2022 09:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: Martin Doucha <mdoucha@suse.cz>, Petr Vorel <petr.vorel@gmail.com>,
 ltp@lists.linux.it
References: <20220606184320.8210-1-petr.vorel@gmail.com>
 <20220606184320.8210-3-petr.vorel@gmail.com>
 <5d4a4e2b-4d1d-88d6-4905-67083c154775@suse.cz>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <5d4a4e2b-4d1d-88d6-4905-67083c154775@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] kvm: Fix undefined reference to
 __stack_chk_fail()
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
Cc: Fabrice Fontaine <fontaine.fabrice@gmail.com>,
 "Yann E. MORIN" <yann.morin.1998@free.fr>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Buildroot Mailing List <buildroot@buildroot.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,


Am 6/9/2022 um 10:26 AM schrieb Martin Doucha:
> On 06. 06. 22 20:43, Petr Vorel wrote:
>> Some x86_64 buildroot toolchains (bootlin-x86-64-glibc,
>> bootlin-x86-64-musl) try to link to __stack_chk_fail().
>> -nostdlib is not enough, it requires also -fstack-protector.
>>
>> x86_64-buildroot-linux-gnu/bin/ld: /tmp/ccgBXEoR.o: in function `handle_page_fault':
>> kvm_pagefault01.c:(.text+0x5d): undefined reference to `__stack_chk_fail'
>> collect2: error: ld returned 1 exit status
>>
>> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
>> ---
>>  testcases/kernel/kvm/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/kvm/Makefile b/testcases/kernel/kvm/Makefile
>> index 8d5193d8e..bce1a4eb5 100644
>> --- a/testcases/kernel/kvm/Makefile
>> +++ b/testcases/kernel/kvm/Makefile
>> @@ -9,7 +9,7 @@ ASFLAGS =
>>  CPPFLAGS += -I$(abs_srcdir)/include
>>  GUEST_CPPFLAGS = $(CPPFLAGS) -DCOMPILE_PAYLOAD
>>  GUEST_CFLAGS = -ffreestanding -O2 -Wall -fno-asynchronous-unwind-tables -mno-mmx -mno-sse
>> -GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none
>> +GUEST_LDFLAGS = -nostdlib -Wl,--build-id=none -fstack-protector
> 
> We should use -fno-stack-protector here instead. Your patch probably
> enables linking of libssp despite -nostdlib which we don't want. The GCC
> stack protector may also break tests because bootstrap initializes stack
> manually instead of letting GCC handle it.
I can confirm, that adding -fno-stack-protector to GUEST_LDFLAGS fixes
the linker error.

> 
>>  GUEST_LDLIBS =
>>  
>>  FILTER_OUT_MAKE_TARGETS := lib_guest lib_host lib_x86
> 
> 

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
