Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5949AC433FE
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 06:51:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8C5F3C9545
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 07:51:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 724B23C8B2B
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 07:51:31 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 46E22200B9A
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 07:51:29 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 666DC9FE98;
 Fri, 14 Jan 2022 06:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1642143088; bh=28K2iCB1M6bce6M8QMQsmROtSrLsdxG/LRIxmtpRnOM=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=u+21Jb24e/xA96a0KPJPJaSi/ZiKGLD8XFnIiUZvu1XJLi6XWNdkY3wp/yR8wb2TM
 OcqoYN7zuo7eS8oYgeEA5dhFB1eS8IBTnGRHLw/qqFR0Yj2UFcL3tMjuXQZvUXpUBd
 ox5UxWBQ9r9ZcBCrYPOXivrT2u5wUKo4OB3LV7Oo=
Message-ID: <d68d8f72-fdc9-3a2e-991d-682d8274070f@jv-coder.de>
Date: Fri, 14 Jan 2022 07:51:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To: rpalethorpe@suse.de
References: <YSz36VZ18+N4YsM/@yuki>
 <20210831091005.25361-1-rpalethorpe@suse.com>
 <20210831091005.25361-4-rpalethorpe@suse.com>
 <7cf81226-52ca-5016-5041-ce12b93b534f@jv-coder.de> <875yqq1fo7.fsf@suse.de>
 <5de1ae7d-139a-8f76-1e99-27d4491eae15@jv-coder.de> <871r1c10my.fsf@suse.de>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <871r1c10my.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] bpf_prog05: Drop CAP_BPF and check if ptr
 arithmetic is allowed
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

Hi Richard,

Am 1/13/2022 um 8:48 AM schrieb Richard Palethorpe:
> Hello Joerg,
> 
> Joerg Vehlow <lkml@jv-coder.de> writes:
> 
>> Hi Richard,
>>
>> Am 1/11/2022 um 3:36 PM schrieb Richard Palethorpe:
>>>>> +	if (log[0] != 0)
>>>>> +		tst_brk(TCONF | TERRNO, "No pointer arithmetic:\n %s", log);
>>>> This check now fails for me with the following output, where the test
>>>> was successful, before this patch. The kernel is a non-standard suse
>>>> 5.3.18 with realtime patches.
>>>>
>>>> bpf_prog05.c:100: TCONF: No pointer arithmetic:
>>>>   0: (bf) r2 = r10
>>>> 1: (b7) r3 = -1
>>>> 2: (0f) r2 += r3
>>>> 3: (72) *(u8 *)(r2 +0) = 0
>>>> 4: (b7) r0 = 0
>>>> 5: (95) exit
>>>>
>>>> from 2 to 3 (speculative execution): R1=ctx(id=0,off=0,imm=0) R2_w=fp0
>>>> R3_w=invP-1 R10=fp0
>>>> 3: (72) *(u8 *)(r2 +0) = 0
>>>> invalid stack off=0 size=1
>>>> processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0
>>>> peak_states 0 mark_read 0
>>>> : EACCES (13)
>>>>
>>>>
>>>> Is this too old? But then again, the test was successful before this
>>>> patch and your commit message states, that it was not successful on
>>>> "older kernels".
>>> Are you testing on ARM? eBPF adopted the ARM behavior when dividing
>>> by
>>> zero.
>>>
>>
>> No this is x86 and I was expecting 5.3 to not be "very old". IIRC
>> patches for the bug tested here are partly already integrated into
>> 4.19, so I guess 5.3 shouldn't be "very old" in that context?
>>
>> I am not sure what you tried to test, I guess accessing the stack
>> using indirect pointer arithmetic? Because changing the store to "*(u8
>> *)(r10 - 1) = 0", works. But if this indirection is required for the
>> actually test, it should fail, but it doesn't -> I think the check
>> tests something, that is not actually required for the actual test.
> 
> The actual test just checks what the result of modulo and division by
> zero are against the 'arbitrary' values chosen by ARM/upstream (simlar
> to the selftests BTW). This is because there are multiple different
> values, which can be exploited depending on what patches are applied.
> 
> However they require different logic to detect if pointer arithmetic
> resulted in an OOB read or write. Note that even if you can do pointer
> arithmetic and it results in the wrong value being accessed. It doesn't
> matter if it's not OOB or if the validator blocks it because it has
> calculated the offset in the wrong direction. It may still be
> exploitable in these cases, but the test will pass.
> 
> I can't remember what the exact problems were; it got very complicated
> so I just checked that the results of division/modulo by zero matched
> upstream. This resulted in a false positive on some kernel which in
> theory would be vulnerable if unprivileged pointer arithmetic were
> possible. So I added the ptr arithmetic check to prevent the test from
> running on kernels like this.
> 
> This also appears to prevent the test from running on your kernel which
> is not vulnerable in any case. Thinking about it, this may be due to a
> configuration option you have set
> (i.e. sys/kernel/unprivileged_bpf_disabled). Perhaps the problem is this
> is not mentioned in the test description or TCONF message?
> 
> IIRC We chose TCONF instead of TPASS to give a hint that we're not
> running the full test. You could also have a vulnerable kernel, but with
> unpriveleged BPF disabled by a config option. In this case the test
> should not return TCONF because a user could change the option and make
> themselves vulnerable.

I was looking for kernel config options, that could modify bpf behavior
and also unprivileged_bpf_disable (set to 0 for me), but nothing stood out.

> 
>> I guess what you wanted to check is what BPF_MAP_ARRAY_STX does. There
>> is one major difference between your implementation of the check and 
>> BPF_MAP_ARRAY_STX: BPF_MAP_ARRAY_STX uses an immediate value, to add
>> to r2 compared to a register in your check:
>>
>>  * r2 = fp
>>  * r2 += r2 - 4
>>
>> vs
>>
>>  * r2 = r10
>>  * r3 = -1
>>  * r2 += r3
>>
>> That is actually what makes the difference here...
> 
> No, BPF_MAP_ARRAY_STX is just used to output the result of div/mod by
> zero and I don't think it needs testing.
> 
>>
>> If I modify the check like this it works:
>>
>> --- a/testcases/kernel/syscalls/bpf/bpf_prog05.c
>> +++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
>> @@ -67,13 +67,11 @@ static void ensure_ptr_arithmetic(void)
>>  {
>>         const struct bpf_insn prog_insn[] = {
>>                 /* r2 = r10
>> -                * r3 = -1
>> -                * r2 += r3
>> +                * r2 += -1
>>                  * *(char *)r2 = 0
>>                  */
>>                 BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
>> -               BPF_MOV64_IMM(BPF_REG_3, -1),
>> -               BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
>> +               BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -1),
>>                 BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0),
>>
>>                 /* exit(0) */
>>
>>
>> Is this still checking what it is supposed to? Then I would send it
>> post this as a patch
>>
>> Joerg
> 
> This will reintroduce the false positive.

Ok, I get that.


I did some more digging and bisecting. First I bisected the mainline
kernel and found, that the commit 2c78ee898 ("bpf: Implement CAP_BPF")
makes the check run successful. This is only in linux >= 5.8.
But my 5.4 ubuntu kernel also successfully ran the check, so I also
bisected ubuntu sources [1] and found this commit to be the fix here:
2fa9ab45c ("bpf: No need to simulate speculative domain for immediates")
This commit is also in the mainline kernel, but only in >= 5.13.

I guess the check you implemented now disables the test for a lot of
kernels, that do not have a patch like this... I will stop here and just
accept, that the test is not running successfully in my case. But still
wanted to share this information.

Joerg


[1]
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/focal/commit/?id=2fa9ab45c53e8b104ba8f7d3a953131cc818fcc0



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
