Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C42E7E0B4
	for <ltp@archiver.kernel.org>; Mon,  9 Feb 2026 09:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770630187; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=6ivn4dFpKbMRF8EMiCkMqVPKNvvdAqeqHmvMMa/Shzc=;
 b=pqKD2gtzsnuolL0ZBEFda0BJv/VnR7ug7W6oNMUvIDFcFbJd/dci43qBgUR5zQxAeG4L1
 QeNBCiiE0IctryaelIPNmSII+YDJDBGylo8Xmjt9dbxEj3HCloYdfhfqKZlL7meDO7yptiH
 VCJD+Bk+PJ4tpTonjC1V/k/AVx9YFI8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FB243C8C2C
	for <ltp@archiver.kernel.org>; Mon,  9 Feb 2026 10:43:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA8183C59D2
 for <ltp@lists.linux.it>; Mon,  9 Feb 2026 10:42:42 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 01945600942
 for <ltp@lists.linux.it>; Mon,  9 Feb 2026 10:42:41 +0100 (CET)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5116B3F1CE
 for <ltp@lists.linux.it>; Mon,  9 Feb 2026 09:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1770630161;
 bh=5QFHEw9UvOb3yc2UkTfZF9dfsCGh88fCaBQs0NSpt80=;
 h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To;
 b=I7+20E2531LtZ17iSLit7Yjnj0xEYXu1Hz+aeLmVaBd/pZYU++S199QzXu7oyfRRP
 l+pReB1OH6k9LT4EmNMKBj5zoROqsddYZ3+yEmhRgqfWDypVY5xv0qqdbpYNqrOjmt
 25jEjQdytTSAq8EmUvU2Htg33iUGWmxbZz4LTb5BuKjSJr0zeS4tDVDOm7Q2BtETb2
 poRX/mVpGxi3S/l3GZASfktIcNdv7MMDLIM9wSjAu2ujPyDHQrVKxW1G7Y0DRNiEVa
 +a3N6DrjIZ3wg67LAOPcSweZLgJRmx3meaQfXl7S5EhO6+Q9B+xe75g7BhM4TPOonc
 G3lR+WWUSaVtxLLESIQaEWlwRmgx+xOLC+WZ5TiudXY4kBaVwYdslDmRtOyGhlnwyx
 dMPyhSc66KNw4jHWWbaSChg06JsM2K2BH79YbrZYwIe9ftvKrVTa0qG4rXG0guVuyO
 ZQbjAzpYOJ8lhtwYaBBxc7t8uVnmDhTs+c/INo0DOqpCs45zGaLonIbCWjnidBl9Yb
 lm7xVzlN3MmmoKpSw9Xydh1cT0389jrg3KCqQepaSErBICLDyHnZctiQg6AJs1gwFH
 9HU2OD9NSrO/o+rOdFluyfnk8wAUQkQdhO8c0/bh/6aqBxRF2Y3Sgd3ySlN7WEgKPA
 KpzkCOXUG0UFyiX2yoN/44N4=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2a75ed2f89dso29257425ad.1
 for <ltp@lists.linux.it>; Mon, 09 Feb 2026 01:42:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770630160; x=1771234960;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5QFHEw9UvOb3yc2UkTfZF9dfsCGh88fCaBQs0NSpt80=;
 b=lZ3nMXx8qnEPcOIEc6626QxATo84pQK00PqAGUJVEBV76Y6WsNAKxOek6ifa2Ubken
 Su3ZGILT0eueFWFxpLZDLXxTo3BRwUELLkt+T3MMpkldmSw9PrJdWzepKu9E82MtCJ8y
 sI/39R+Zr9Zz31N9gAyp+URL+i2OpVl+aDCxS2Q2DTyvGjRsxX9O+2ajYrxdso5bO8bY
 2F5WHj7CRE4DSVlOA1rNc+yFzYX0T/Ytdl98OxoSPZ82Jvo4zHm3GuBGU3N0bH/Q0yKL
 lDc0E6woYNMhsq6DxHpfvuMRxHKDQePBYSbNFPdkURo3sx5Xt+hl/kyo7P1dKV3m/Mrl
 lqHA==
X-Gm-Message-State: AOJu0Yw8gQIG0KT8r4UlkTqmFCKTQzvlGWRwn5cIuNbZAJqCRju46roC
 z4aQTPBiHWKD8SKVstCwozEnBSRkuTVGvr0GT6V9B0Op/XYPBl7eCIwEKJd2mU7pEsTyDRykJL1
 sVGjNcRJ7zQQsrgAr1crmrOW3K+Ahdf5SxNkr5F57jB9UNWXpu91MnLla3r4tP2mM7Gut
X-Gm-Gg: AZuq6aIMDoTNpaxYoPJc5q6mOtARMW65Np89g/WqSp6/38exAWetc/KuhnM5omRIyC1
 OvwYzxiSgPb3jHr3qpdCR7dCUY2DEU+6Si5OXO0xl1oMrCXTnU51+Us92nrW6fpQgEcJBWrU/S6
 SMWsmdBWVkcmBMkQcA4sxcOm5G8YUkyT/NMMrUBAMngwB6wZ+AaaqjM18wZmQx9bYyakVnfz+0C
 bLVmSyHIqcVmOTWE3ifE/2VyuvE06xivPmc50ENZYMYp+MUFrJwdepick1EyA/gebm0R0ryYHCy
 TR4Qi1pOxKyb+ngPEdI8xTRuLLF03RVTTSK1Yz5lHIwE8B7+5cu7zqbi1tPqv5b6lOgJha0Vlrl
 hLkyJILT6k43LiDUVEILVLCnq8PnFuhPoo2vAZWE=
X-Received: by 2002:a17:902:d4cc:b0:2aa:e6c1:cea9 with SMTP id
 d9443c01a7336-2aae6c1d04fmr25043845ad.50.1770630159864; 
 Mon, 09 Feb 2026 01:42:39 -0800 (PST)
X-Received: by 2002:a17:902:d4cc:b0:2aa:e6c1:cea9 with SMTP id
 d9443c01a7336-2aae6c1d04fmr25043725ad.50.1770630159333; 
 Mon, 09 Feb 2026 01:42:39 -0800 (PST)
Received: from ?IPV6:2001:67c:1560:8007::aac:c224?
 ([2001:67c:1560:8007::aac:c224]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951c9189bsm108300245ad.36.2026.02.09.01.42.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 01:42:38 -0800 (PST)
Message-ID: <473f0757-a2de-4e98-a24f-3b0bf4b22000@canonical.com>
Date: Mon, 9 Feb 2026 20:42:28 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20260207145942.299366-1-changwei.zou@canonical.com>
 <20260209075146.GA450151@pevik>
Content-Language: en-US
In-Reply-To: <20260209075146.GA450151@pevik>
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
Additional details can be found on the following page:
https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/2139127/comments/1
Thank you very much.
Kind regards,
Changwei


On 2/9/26 18:51, Petr Vorel wrote:
> Hi Changwei,
>
>> Allocate extra space before the TLS area to hold a struct pthread, ensuring
>> THREAD_SELF->cancelhandling is initialized to 0. This prevents undefined
>> behavior in __pthread_disable_asynccancel(), which is called at thread
>> cancellation points such as write().
>> Without this, touch_tls_in_child() could get stuck in tst_res().
> LGTM, but I'd prefer others had a look on it.
> Acked-by: Petr Vorel<pvorel@suse.cz>
>
> BTW clone10.c segfaults w/a the patch when run with more iterations:
>
> ./clone10 -i200
> clone10.c:48: TINFO: Child (PID: 4271, TID: 4285): TLS value set to: 101
> clone10.c:68: TPASS: Parent (PID: 4271, TID: 4271): TLS value correct: 100
> clone10.c:48: TINFO: Child (PID: 4271, TID: 4286): TLS value set to: 101
> clone10.c:68: TPASS: Parent (PID: 4271, TID: 4271): TLS value correct: 100
> tst_test.c:1953: TBROK: Test killed by SIGSEGV!
>
> Summary:
> passed   15
> failed   0
> broken   1
> skipped  0
> warnings 0
>
> Kind regards,
> Petr
>
>> (gdb) bt
>>    0  futex_wait () at ../sysdeps/nptl/futex-internal.h:141
>>    1  futex_wait_simple () at ../sysdeps/nptl/futex-internal.h:172
>>    2  __libc_disable_asynccancel () at ../nptl/cancellation.c:100
>>    3  __GI___libc_write () at ../sysdeps/unix/sysv/linux/write.c:26
>>    4  __GI___libc_write () at ../sysdeps/unix/sysv/linux/write.c:24
>>    5  print_result ()  at tst_test.c:387
>>    6  tst_vres_ () at tst_test.c:401
>>    7  tst_res_ () at tst_test.c:512
>>    8  touch_tls_in_child (arg=<optimized out>) atclone10.c:48
>>    9  thread_start () at ../sysdeps/unix/sysv/linux/aarch64/clone.S:78
>> Signed-off-by: Changwei Zou<changwei.zou@canonical.com>
>> ---
>>   include/lapi/tls.h | 16 +++++++++++++---
>>   1 file changed, 13 insertions(+), 3 deletions(-)
>> diff --git a/include/lapi/tls.h b/include/lapi/tls.h
>> index 468fe3086..7f2fa18a1 100644
>> --- a/include/lapi/tls.h
>> +++ b/include/lapi/tls.h
>> @@ -22,6 +22,15 @@
>>   #define TLS_SIZE 4096
>>   #define TLS_ALIGN 16
>> +/*
>> + * Space allocated large enough to hold a struct pthread.
>> + *
>> + * Zero-initialized to ensure THREAD_SELF->cancelhandling starts at 0,
>> + * avoiding undefined behavior (e.g., in clone10.c) in __pthread_disable_asynccancel(),
>> + * which is called at thread cancellation points such as write().
>> + */
>> +#define TLS_PRE_TCB_SIZE (TLS_ALIGN * 256)
>> +
>>   #if defined(__x86_64__)
>>   typedef struct {
>>   	void *tcb;
>> @@ -36,10 +45,11 @@ extern void *tls_ptr;
>>   static inline void *allocate_tls_area(void)
>>   {
>> -	void *tls_area = aligned_alloc(TLS_ALIGN, TLS_SIZE);
>> +	char *tls_area = aligned_alloc(TLS_ALIGN, TLS_PRE_TCB_SIZE + TLS_SIZE);
>>   	if (!tls_area)
>>   		tst_brk(TBROK | TERRNO, "aligned_alloc failed");
>> -	memset(tls_area, 0, TLS_SIZE);
>> +	memset(tls_area, 0, TLS_PRE_TCB_SIZE + TLS_SIZE);
>> +	tls_area += TLS_PRE_TCB_SIZE;
>>   #if defined(__x86_64__)
>>   	tcb_t *tcb = (tcb_t *)tls_area;
>> @@ -59,7 +69,7 @@ static inline void free_tls(void)
>>   {
>>   	usleep(10000);
>>   	if (tls_ptr) {
>> -		free(tls_ptr);
>> +		free(((char *)tls_ptr) - TLS_PRE_TCB_SIZE);
>>   		tls_ptr = NULL;
>>   	}
>>   }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
