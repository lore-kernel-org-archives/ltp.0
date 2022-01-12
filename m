Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCBF9C433EF
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 06:55:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3AC1C3C94C1
	for <ltp@archiver.kernel.org>; Wed, 12 Jan 2022 07:55:21 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 161083C4EC5
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 07:55:10 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EF8811000435
 for <ltp@lists.linux.it>; Wed, 12 Jan 2022 07:55:09 +0100 (CET)
Received: from [192.168.178.40] (unknown [188.192.100.83])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 5DE3D9F75E;
 Wed, 12 Jan 2022 06:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1641970508; bh=Fqz2+5bZnAFIiyhyqbvFMxu5rEpF3dFiOvxqV9S1A5c=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=KaAu3Fx2hgzYuFZX/wDD+Wb14cbp7ejAJwq9k2XHjPLj/Czrvb8SrwwBXridLOXnZ
 fWaL5gW0lS6p+m421bHFJcyPZOb6xPLdAo04dieLX7bChZQn+EkBnzMp9O2L0m7IXX
 0gYywCA0MaP90LaIiCNqH09c6544c8lpDjKAZRIs=
Message-ID: <5de1ae7d-139a-8f76-1e99-27d4491eae15@jv-coder.de>
Date: Wed, 12 Jan 2022 07:55:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: rpalethorpe@suse.de
References: <YSz36VZ18+N4YsM/@yuki>
 <20210831091005.25361-1-rpalethorpe@suse.com>
 <20210831091005.25361-4-rpalethorpe@suse.com>
 <7cf81226-52ca-5016-5041-ce12b93b534f@jv-coder.de> <875yqq1fo7.fsf@suse.de>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <875yqq1fo7.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richard,

Am 1/11/2022 um 3:36 PM schrieb Richard Palethorpe:
>>> +	if (log[0] != 0)
>>> +		tst_brk(TCONF | TERRNO, "No pointer arithmetic:\n %s", log);
>> This check now fails for me with the following output, where the test
>> was successful, before this patch. The kernel is a non-standard suse
>> 5.3.18 with realtime patches.
>>
>> bpf_prog05.c:100: TCONF: No pointer arithmetic:
>>   0: (bf) r2 = r10
>> 1: (b7) r3 = -1
>> 2: (0f) r2 += r3
>> 3: (72) *(u8 *)(r2 +0) = 0
>> 4: (b7) r0 = 0
>> 5: (95) exit
>>
>> from 2 to 3 (speculative execution): R1=ctx(id=0,off=0,imm=0) R2_w=fp0
>> R3_w=invP-1 R10=fp0
>> 3: (72) *(u8 *)(r2 +0) = 0
>> invalid stack off=0 size=1
>> processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0
>> peak_states 0 mark_read 0
>> : EACCES (13)
>>
>>
>> Is this too old? But then again, the test was successful before this
>> patch and your commit message states, that it was not successful on
>> "older kernels".
> 
> Are you testing on ARM? eBPF adopted the ARM behavior when dividing by
> zero.
> 

No this is x86 and I was expecting 5.3 to not be "very old". IIRC 
patches for the bug tested here are partly already integrated into 4.19, 
so I guess 5.3 shouldn't be "very old" in that context?

I am not sure what you tried to test, I guess accessing the stack using 
indirect pointer arithmetic? Because changing the store to "*(u8 *)(r10 
- 1) = 0", works. But if this indirection is required for the actually 
test, it should fail, but it doesn't -> I think the check tests 
something, that is not actually required for the actual test.
I guess what you wanted to check is what BPF_MAP_ARRAY_STX does. There 
is one major difference between your implementation of the check and 
BPF_MAP_ARRAY_STX: BPF_MAP_ARRAY_STX uses an immediate value, to add to 
r2 compared to a register in your check:

  * r2 = fp
  * r2 += r2 - 4

vs

  * r2 = r10
  * r3 = -1
  * r2 += r3

That is actually what makes the difference here...

If I modify the check like this it works:

--- a/testcases/kernel/syscalls/bpf/bpf_prog05.c
+++ b/testcases/kernel/syscalls/bpf/bpf_prog05.c
@@ -67,13 +67,11 @@ static void ensure_ptr_arithmetic(void)
  {
         const struct bpf_insn prog_insn[] = {
                 /* r2 = r10
-                * r3 = -1
-                * r2 += r3
+                * r2 += -1
                  * *(char *)r2 = 0
                  */
                 BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
-               BPF_MOV64_IMM(BPF_REG_3, -1),
-               BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_3),
+               BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -1),
                 BPF_ST_MEM(BPF_B, BPF_REG_2, 0, 0),

                 /* exit(0) */


Is this still checking what it is supposed to? Then I would send it post 
this as a patch

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
