Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE7AC25B0E
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 09:14:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 662443CA249
	for <ltp@archiver.kernel.org>; Fri, 19 Aug 2022 11:14:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17BA93C010E
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 11:14:36 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4AF2160087F
 for <ltp@lists.linux.it>; Fri, 19 Aug 2022 11:14:35 +0200 (CEST)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 677C79FA5E;
 Fri, 19 Aug 2022 09:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1660900474; bh=uYWTguWAKfYdnQ3qDEl2LYL6JoxWInADl3h/gBZ042o=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=WSbR9GGdoBYJuLm1+/agXdNQE9LiXb1E7B3AQAuKXEE/KcWQMT8aM64a2rkkf/xeT
 ZnUxHgSafdLZiP7dqz2kddXMblJNb3/IYAowjuiezA2tat4w2QIKtVwPAd8mYhwQmb
 97/X6UnmNZ1vlKet1BsJFw6kbfq2VWzi4okJ8Clc=
Message-ID: <18f40cb4-1641-4f96-4b0c-85bee0df9e1f@jv-coder.de>
Date: Fri, 19 Aug 2022 11:14:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
References: <YtaFddMFjVPMTpme@rei>
 <CAG4es9Wn+wZRu6xr-FgZ=pTq4ReGdrmsmGYO4ZXvKj8ee3QH8w@mail.gmail.com>
 <CAG4es9XhZ7ksvLxwRNO73FC4DQc7KteUQAUPwipbks6kGsvFmw@mail.gmail.com>
 <YvUhZ/9Yf7eZ4a32@yuki> <YvuRAR1DSi67PDzh@pevik>
 <CAG4es9XdXgmPOQK3i+FL3VD-Y8C39sAShwdM6bi7U-CJjk7BQg@mail.gmail.com>
 <YvyxCXTGYpLd8kbQ@pevik>
 <CAG4es9XkRDYnwDr9huepzGhEiHxWdu40DOK9ouA2yWGqv842ow@mail.gmail.com>
 <CAG4es9WmHd52fmjdt7RBkSXEtnGuC2jkBO6UdCTbaHOq8CDgVw@mail.gmail.com>
 <Yv9F8MnPGyLLE0Zm@pevik> <Yv9Msztwn77epwCP@yuki>
From: Joerg Vehlow <lkml@jv-coder.de>
Organization: AOX Technologies GmbH
In-Reply-To: <Yv9Msztwn77epwCP@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] syscalls/signal06: add volatile to loop
 variable
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
Reply-To: Joerg.Vehlow@aox.de
Cc: kernel-team <kernel-team@android.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Am 8/19/2022 um 10:41 AM schrieb Cyril Hrubis:
> Hi!
>> Thanks! The bug was closed as 'adding "cx" worked'. Reading topperc's comment it
>> looks like there no other way to fix the issue on clang than workaround with
>> volatile. Does it mean that it's a syscall problem and clang can do nothing
>> about it?
> 
> It's problem with the inline assembly in the body of the while loop, the
> call to the syscall changes the register value that is used for the D
> variable in the case of clang, so the loop exits prematurely. We have to
> add cx register to the clobber list for that asm statement so that
> compiler knows that it's changed by the assembly.
> 
> Interfacing assembly with C is a bit tricky since you have to explain
> to compiler which registers are changed from the assembly otherwise the
> results are undefined.
> 
> The patch should look like:
> 
> diff --git a/testcases/kernel/syscalls/signal/signal06.c b/testcases/kernel/syscalls/signal/signal06.c
> index 64f886ee3..78efd0fb9 100644
> --- a/testcases/kernel/syscalls/signal/signal06.c
> +++ b/testcases/kernel/syscalls/signal/signal06.c
> @@ -73,7 +73,7 @@ void test(void)
>                 /* sys_tkill(pid, SIGHUP); asm to avoid save/reload
>                  * fp regs around c call */
>                 asm ("" : : "a"(__NR_tkill), "D"(pid), "S"(SIGHUP));
> -               asm ("syscall" : : : "ax");
> +               asm ("syscall" : : : "ax", "cx");
Why is this even split up into two asm instructions?
I guess there is nothing, that prevents the compiler from reordering the
asm instructions, because it does not know, that they have side effects
(they are not marked volatile).

asm volatile ("syscall" : : "a"(__NR_tkill), "D"(pid), "S"(SIGHUP):
"rax", "rcx", "r11");


I am not sure if there is any good reason, to split this up into two asm
instructions and if there is a good reason, to use the short names of
the registers.

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
