Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8233EA3F0F
	for <ltp@archiver.kernel.org>; Tue, 10 Feb 2026 07:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770707030; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=1k5X3brpeMR4ZzEyWFeF86eQ0vIU7cs+TsznoGJRfyI=;
 b=bnqhnUnRMz0fdSFjdraCDB8AKxoKBBDg0zAwkktEEaRJkW6ELLT/o1dZJLtpxSwv5D9yS
 4Vcb9qzO4Hk0SBFt5UP3bUXmJKBRhRmLJCJDFA9ihB6j21PDVo/e9ot80llcyLFrHKY9sCN
 2w1Y44yuKl9KEo72bZjIoJyOy/5X/6o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFBE93CBEDC
	for <ltp@archiver.kernel.org>; Tue, 10 Feb 2026 08:03:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B1D53CBC12
 for <ltp@lists.linux.it>; Tue, 10 Feb 2026 08:03:27 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4AF19600860
 for <ltp@lists.linux.it>; Tue, 10 Feb 2026 08:03:26 +0100 (CET)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 432323F2C8
 for <ltp@lists.linux.it>; Tue, 10 Feb 2026 07:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1770707005;
 bh=SnkYNtArDwb/swmlF61zHu9VPp6pjPuxCzq8MogKnic=;
 h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To;
 b=RKlUqH3ovFw6aYQC7R35CIbCpntW2iyUcykXMPT+toeC4CxXJ6U9VRxCZvAlHX2Nh
 xzmcFMTXCH8Ls4ldbO+edXLb+7UA54SphWx/fJNHSvCIuKqf+nnOzL4j+cdFLF5hXJ
 rOv537EvQdOuX5ZWg8poprL7URVvb4MMJtB8xrBOmgIM6XQxlfxKdU6GGpByC87kn7
 jUkuGsqBlvk1xKCGsLsHfPAH9sOKqeIX0HaoMVOTI4uUYlhcFkVxRSwYYuhzcxZu6Q
 hyIOVoAqGo0vWnoRTkt/oodzsVuMI1aiUmaqc9phKDXsSFm6TW10VAaPszDbZrFBow
 xHNHEQV3Oqp6XilH2cEdI1MLV9LrAPLl2LrFrFmYR8kTUc7AUeLbiGaf3v0isuIbvc
 rrDEWd8sNlpvvxygI0Hc8s/2bUyG3vcUZ+DFW0LhxchnhiZtlix9SFD5EfVdKjYV7j
 IBoVqJMrBFs/qgH5wB32SykkPSZvOQNBqZlr9tJ3Hyyip1Ab8KzP4uUtIs6xSyQ2lh
 WgPH0wh4gVyjpoZhtp2Mksporxw4C3fpd+vv53OOFDgilZnAihz1w++XehE1LagXdT
 fmZz2TyE0MuTwG7XLthQZuTKQm0yTr6HeeZ5YPRMJNend9hsZrVak1lyjUJM+v4ro/
 9DlrzF2j2lcVosefvAjMDaXs=
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c68b97c0adeso3792273a12.1
 for <ltp@lists.linux.it>; Mon, 09 Feb 2026 23:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770707004; x=1771311804;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SnkYNtArDwb/swmlF61zHu9VPp6pjPuxCzq8MogKnic=;
 b=L5dXTK2J+y+WSxV3PutEL6EQ1/5zfOMqlfN/9N5cenIO0G/CNsZBIN6SdSQUGdM636
 pgBLu4gPWGavijmABnNV7E7wueWcFkmTf8h+AbE63ixcK9dxIwlsI9NYVvAbzR8eBNgc
 wLjEGLspDpIR4WrfuxFbpFNYstCXsHzL5QEzURE8BQXjrWX5sB8pYD966yZBcctQudT7
 JFgMlFi4MfcRRsj73JcnRZ6+AFNXsY4la1xikzA8vyJXf152EypdGxvqlTy60IIEY6c5
 nqbZlHpVzElC6rFtqQUYf0BHWKbJNpVzonRCOtFY2G6i7kQUeXD5TvJncm10GrPFt8Y+
 MYTA==
X-Gm-Message-State: AOJu0YwMzeZffUlkBAVrM8y5kXv9oaAxeGQDfyWwSRcNWaZ1HWBG5hp3
 f1HzlfnGozioo44Vymur2zQCe4Vo1TLYGWQFyc7BbDYFyaQGpsNG1vNsU6xKIXOnDPpsSGKmNLO
 aPQaXVa3Cchh9HC0O3L3h8HEpe0Om97kj972yUPwD43L4yZYQvF7/BGuSwMAFxmoCJgfs
X-Gm-Gg: AZuq6aJeQw0LZ47YUf862QW/fpF3P4iGKpuYsp5S8DO2rlpVk7YR82+w8ECkw8G0RuL
 i3rlEAZrbuNCTjjPCvCWaGoimu7EvLAtXimXbTr5fmqvtGmJA2vTuPqHwZBxGlBtbO4UsQ9H9de
 RLZ4ZUiOnwYxXU7snBz4Usd/k4hYH9dYlmodC9YFcOMENVOwcUKXGIZ88PYIPo7srgURRtutFAR
 vJj4Aa8wLU8/I7XexVwekfQ22POdm4niyOS87Eqm61koYryMJeL8j7bv/8953slbwVgkxhJcjI2
 ukKCbZS6mZ+JLa3uX+QztacO8bf2/lN2xiOe8lXoej9TMRRKaQH+6T49+JUC58+g9LkuOHBQiv/
 LF4f70HO8nbe40L54RkLria0diPYQx9gQL4jR90jhem/6uDDRun0=
X-Received: by 2002:a17:902:f684:b0:2a7:a1f3:f327 with SMTP id
 d9443c01a7336-2ab0fe4c119mr14111325ad.20.1770707003828; 
 Mon, 09 Feb 2026 23:03:23 -0800 (PST)
X-Received: by 2002:a17:902:f684:b0:2a7:a1f3:f327 with SMTP id
 d9443c01a7336-2ab0fe4c119mr14111055ad.20.1770707003326; 
 Mon, 09 Feb 2026 23:03:23 -0800 (PST)
Received: from ?IPV6:2001:67c:1560:8007::aac:c224?
 ([2001:67c:1560:8007::aac:c224]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a95220c4e9sm129694425ad.83.2026.02.09.23.03.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 23:03:22 -0800 (PST)
Message-ID: <9ca90f43-f8c9-4f7d-ae7c-5ea9653c7742@canonical.com>
Date: Tue, 10 Feb 2026 18:03:09 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260207145942.299366-1-changwei.zou@canonical.com>
 <20260209075146.GA450151@pevik>
 <46bdaf39-4d82-4b33-94c6-0ef8525ffaf1@canonical.com>
 <20260209114700.GA488389@pevik>
Content-Language: en-US
In-Reply-To: <20260209114700.GA488389@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lapi/tls: reserve pre-TCB space to avoid
 undefined behavior in clone10.c
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
From: Changwei Zou via ltp <ltp@lists.linux.it>
Reply-To: Changwei Zou <changwei.zou@canonical.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,
LTP uses glibc.
Even a simple library function like write(),
which wraps the sys_write system call,
is involved in the memory model of pthreads.
Therefore, touch_tls_in_child() must behave almost exactly like a pthread.
Otherwise, memory corruption can occur when executing functions inside 
glibc.
In the current version of clone10.c, according to the assembly code,
the statement tls_var = 0x65; already constitutes a buffer overflow on 
x86_64.
Unfortunately, the struct pthread is opaque and may vary between 
different versions of glibc.
I assume the purpose of clone10.c is to test whether the CLONE_SETTLS 
flag works.
Making touch_tls_in_child() behave exactly like a pthread, however, is 
extremely difficult.
static __thread int tls_var;
static int touch_tls_in_child(void *arg)
{
// 0xfffffffffffffffc is -4
// movl $0x65,%fs:0xfffffffffffffffc
tls_var = 0x65;
}
```sh
(gdb) disassemble touch_tls_in_child
Dump ofassemblercodeforfunctiontouch_tls_in_child:
0x000055555555be40 <+0>:endbr64
0x000055555555be44 <+4>:push%rbx
0x000055555555be45 <+5>:mov0x33c0c(%rip),%rdx# 0x55555558fa58 <tls_ptr>
0x000055555555be4c <+12>:xor%eax,%eax
0x000055555555be4e <+14>:mov$0x1002,%esi
0x000055555555be53 <+19>:mov$0x9e,%edi
0x000055555555be58 <+24>:call0x55555555b500<syscall@plt>
0x000055555555be5d <+29>:cmp$0xffffffffffffffff,%rax
0x000055555555be61 <+33>:je0x55555555bf1d<touch_tls_in_child+221>
0x000055555555be67 <+39>:movl$0x65,%fs:0xfffffffffffffffc//bufferoverflow?
```
On 2/9/26 22:47, Petr Vorel wrote:
> Hi Changwei,
>
>> Hi Petr,
>> With the original upstream LTP,
>> I ran clone10 -i 1000 on three machines (including AArch64 and AMD64), and
>> it failed on all of them.
>> This suggests there may be another bug that we still need to identify.
> Yes, it's a separate bug, not relevant to your fix. I trigger it on x86_64.
>
> Kind regards,
> Petr
>
>> Thank you very much for your invaluable information.
>> Kind regards,
>> Changwei
>> *1. On an AArch64 cloud instance*
>> ```sh
>> azure@clone10-aarch64-kcp:~/orig/ltp$
>> ./testcases/kernel/syscalls/clone/clone10-i1000
>> clone10.c:68:TPASS:Parent(PID: 106163,TID:106163): TLS value correct: 100
>> clone10.c:48:TINFO:Child(PID: 106163,TID:106200): TLS value set to: 101
>> tst_test.c:1953:TBROK:TestkilledbySIGBUS!
>> Summary:
>> passed 36
>> failed 0
>> broken 1
>> skipped 0
>> warnings 0
>> ```
>> *2. On an AMD64 machine*
>> ```sh
>> ubuntu@ZBook:~/orig/ltp$ ./testcases/kernel/syscalls/clone/clone10-i1000
>> clone10.c:48:TINFO:Child(PID: 125560,TID:125870): TLS value set to: 101
>> clone10.c:68:TPASS:Parent(PID: 125560,TID:125560): TLS value correct: 100
>> double freeorcorruption(out)
>> clone10.c:48:TINFO:Child(PID: 125560,TID:125871): TLS value set to: 101
>> clone10.c:68:TPASS:Parent(PID: 125560,TID:125560): TLS value correct: 100
>> tst_test.c:1953:TBROK:TestkilledbySIGIOT/SIGABRT!
>> Summary:
>> passed 311
>> failed 0
>> broken 1
>> skipped 0
>> warnings 0
>> ```
>> *3. On an AArch64 machine*
>> ```sh
>> ubuntu@asus-pe100a:~/orig/ltp$
>> ./testcases/kernel/syscalls/clone/clone10-i1000
>> clone10.c:68:TPASS:Parent(PID: 158953,TID:158953): TLS value correct: 100
>> clone10.c:48:TINFO:Child(PID: 158953,TID:159029): TLS value set to: 101
>> tst_test.c:1953:TBROK:TestkilledbySIGSEGV!
>> Summary:
>> passed 75
>> failed 0
>> broken 1
>> skipped 0
>> warnings 0
>> ```
>
>> On 2/9/26 18:51, Petr Vorel wrote:
>>> Hi Changwei,
>>>> Allocate extra space before the TLS area to hold a struct pthread, ensuring
>>>> THREAD_SELF->cancelhandling is initialized to 0. This prevents undefined
>>>> behavior in __pthread_disable_asynccancel(), which is called at thread
>>>> cancellation points such as write().
>>>> Without this, touch_tls_in_child() could get stuck in tst_res().
>>> LGTM, but I'd prefer others had a look on it.
>>> Acked-by: Petr Vorel<pvorel@suse.cz>
>>> BTW clone10.c segfaults w/a the patch when run with more iterations:
>>> ./clone10 -i200
>>> clone10.c:48: TINFO: Child (PID: 4271, TID: 4285): TLS value set to: 101
>>> clone10.c:68: TPASS: Parent (PID: 4271, TID: 4271): TLS value correct: 100
>>> clone10.c:48: TINFO: Child (PID: 4271, TID: 4286): TLS value set to: 101
>>> clone10.c:68: TPASS: Parent (PID: 4271, TID: 4271): TLS value correct: 100
>>> tst_test.c:1953: TBROK: Test killed by SIGSEGV!
>>> Summary:
>>> passed   15
>>> failed   0
>>> broken   1
>>> skipped  0
>>> warnings 0
>>> Kind regards,
>>> Petr
>>>> (gdb) bt
>>>>     0  futex_wait () at ../sysdeps/nptl/futex-internal.h:141
>>>>     1  futex_wait_simple () at ../sysdeps/nptl/futex-internal.h:172
>>>>     2  __libc_disable_asynccancel () at ../nptl/cancellation.c:100
>>>>     3  __GI___libc_write () at ../sysdeps/unix/sysv/linux/write.c:26
>>>>     4  __GI___libc_write () at ../sysdeps/unix/sysv/linux/write.c:24
>>>>     5  print_result ()  at tst_test.c:387
>>>>     6  tst_vres_ () at tst_test.c:401
>>>>     7  tst_res_ () at tst_test.c:512
>>>>     8  touch_tls_in_child (arg=<optimized out>)atclone10.c:48
>>>>     9  thread_start () at ../sysdeps/unix/sysv/linux/aarch64/clone.S:78
>>>> Signed-off-by: Changwei Zou<changwei.zou@canonical.com>
>>>> ---
>>>>    include/lapi/tls.h | 16 +++++++++++++---
>>>>    1 file changed, 13 insertions(+), 3 deletions(-)
>>>> diff --git a/include/lapi/tls.h b/include/lapi/tls.h
>>>> index 468fe3086..7f2fa18a1 100644
>>>> --- a/include/lapi/tls.h
>>>> +++ b/include/lapi/tls.h
>>>> @@ -22,6 +22,15 @@
>>>>    #define TLS_SIZE 4096
>>>>    #define TLS_ALIGN 16
>>>> +/*
>>>> + * Space allocated large enough to hold a struct pthread.
>>>> + *
>>>> + * Zero-initialized to ensure THREAD_SELF->cancelhandling starts at 0,
>>>> + * avoiding undefined behavior (e.g., in clone10.c) in __pthread_disable_asynccancel(),
>>>> + * which is called at thread cancellation points such as write().
>>>> + */
>>>> +#define TLS_PRE_TCB_SIZE (TLS_ALIGN * 256)
>>>> +
>>>>    #if defined(__x86_64__)
>>>>    typedef struct {
>>>>    	void *tcb;
>>>> @@ -36,10 +45,11 @@ extern void *tls_ptr;
>>>>    static inline void *allocate_tls_area(void)
>>>>    {
>>>> -	void *tls_area = aligned_alloc(TLS_ALIGN, TLS_SIZE);
>>>> +	char *tls_area = aligned_alloc(TLS_ALIGN, TLS_PRE_TCB_SIZE + TLS_SIZE);
>>>>    	if (!tls_area)
>>>>    		tst_brk(TBROK | TERRNO, "aligned_alloc failed");
>>>> -	memset(tls_area, 0, TLS_SIZE);
>>>> +	memset(tls_area, 0, TLS_PRE_TCB_SIZE + TLS_SIZE);
>>>> +	tls_area += TLS_PRE_TCB_SIZE;
>>>>    #if defined(__x86_64__)
>>>>    	tcb_t *tcb = (tcb_t *)tls_area;
>>>> @@ -59,7 +69,7 @@ static inline void free_tls(void)
>>>>    {
>>>>    	usleep(10000);
>>>>    	if (tls_ptr) {
>>>> -		free(tls_ptr);
>>>> +		free(((char *)tls_ptr) - TLS_PRE_TCB_SIZE);
>>>>    		tls_ptr = NULL;
>>>>    	}
>>>>    }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
