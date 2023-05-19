Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F3DC7EE26
	for <ltp@archiver.kernel.org>; Mon, 22 May 2023 08:44:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58A8A3CD390
	for <ltp@archiver.kernel.org>; Mon, 22 May 2023 10:44:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A3333CB260
 for <ltp@lists.linux.it>; Fri, 19 May 2023 19:53:11 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E033314010EF
 for <ltp@lists.linux.it>; Fri, 19 May 2023 19:53:09 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-953343581a4so538302166b.3
 for <ltp@lists.linux.it>; Fri, 19 May 2023 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=colorfullife-com.20221208.gappssmtp.com; s=20221208; t=1684518789;
 x=1687110789; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DPki2kVedYBkUAnsyHX8bgELTNrSWdqM1kLCtkWIKP4=;
 b=CqOEJ9y6sewFdUXSDUTsiMr6es2vloNq2KnGrw6fH2Hl8YD9G+jpliaygnZaF7C6H5
 N/cMNs2gvDLYn6Ge3XqOMnPAJCUyNt47I/Gkni3hJ8opanrP5RHlACjZ/xpWwFbZy7/S
 3Fj5yFs99VlQpLV15lhIKPzRpQtt0hFWgzJT94iNCoqbkyFzsFXQ4Tu/kMni+/CXbAh7
 uwHRpTU2vgB0soE2lH/34HxrZd5Mi71hGQ8KVCbExle5IDbjiYK8B4DBR44l88z7wGjR
 +WxedqqcYw7sy/EX5pbo9JspxsXwXsoQbshasnvipYrtvGtonW8D0Pxc1M+4X+o3Mnky
 NU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684518789; x=1687110789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DPki2kVedYBkUAnsyHX8bgELTNrSWdqM1kLCtkWIKP4=;
 b=MzE53YvHGhWpjf909+upD+ItpaTUXyY8ifqjba0XkVazUxLwzgb/Z6CBFSa6RQHN03
 AqjzTGaCkeW8xk3BXt/8f5EA0oY/tGLdG4Nk2iEbvwlKVLJckG0YeDl+dXKA+Dj+hkea
 5yC/h00V9mvyhP0OBg26Lf4J3Tb+Am5QarH84AAK8f6WOYUpP8TunfuNmjvbfpO4GQX1
 uOD9/lxhRktNU19+q9ROdqnTmzZhf37JNZaLxD9GS+6U1wUzbBL9cIUgbT2cHHFHecbX
 PVNxZ34OLatOwMEIp7NH4Z1fLwKgnuSXHcQc6Uo8v+Lq+H6gx/3zL4PqCdpJ0eEPum9O
 NAKg==
X-Gm-Message-State: AC+VfDzaS14W98WMDhkrHFFD9i7yP3JoLeMEkp6Bl1rB6NxUCPqHes0+
 OkoKNIry6DjwTKa3IsaRm2NcVw==
X-Google-Smtp-Source: ACHHUZ5RgJD6BJtA+67fYSx0macSbw7DTob9kArFehfqSHZvkwsdWEGvFJhnhcbWc65vG4XLFH+1rQ==
X-Received: by 2002:a17:906:9b86:b0:94e:54ec:1a10 with SMTP id
 dd6-20020a1709069b8600b0094e54ec1a10mr3052962ejc.29.1684518789159; 
 Fri, 19 May 2023 10:53:09 -0700 (PDT)
Received: from ?IPV6:2003:d9:9741:2000:44f:a939:9f33:a662?
 (p200300d997412000044fa9399f33a662.dip0.t-ipconnect.de.
 [2003:d9:9741:2000:44f:a939:9f33:a662])
 by smtp.googlemail.com with ESMTPSA id
 e16-20020a170906649000b0096f6647b5e8sm1091443ejm.64.2023.05.19.10.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 10:53:08 -0700 (PDT)
Message-ID: <b3b0d222-b745-07bc-8dcd-38f762343c84@colorfullife.com>
Date: Fri, 19 May 2023 19:53:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, open list <linux-kernel@vger.kernel.org>,
 LTP List <ltp@lists.linux.it>, lkft-triage@lists.linaro.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Davidlohr Bueso <dbueso@suse.de>
References: <CA+G9fYuKehraq_kcHdVgqWnwQWHN2QiE7ze53mXJvtL0DLc0uQ@mail.gmail.com>
 <9677ced3-8386-47f0-a2d6-de27ec84207e@app.fastmail.com>
From: Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <9677ced3-8386-47f0-a2d6-de27ec84207e@app.fastmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 22 May 2023 10:44:30 +0200
Subject: Re: [LTP] LTP: shmget02 fails on compat mode - 64-bit kernel and
 32-bit userspace
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
Cc: Ard Biesheuvel <ardb@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

On 5/19/23 12:57, Arnd Bergmann wrote:
> On Fri, May 19, 2023, at 11:17, Naresh Kamboju wrote:
>> LTP running on compat mode where the tests run on
>> 64-bit kernel and 32-bit userspace are noticed on a list of failures.
>>
>> What would be the best way to handle this rare combination of failures ?
>>
>> * arm64: juno-r2-compat, qemu_arm64-compat and qemu_x86_64-compat
>>      - shmget02
>>
>> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>>
>> tst_hugepage.c:83: TINFO: 0 hugepage(s) reserved
>> tst_test.c:1558: TINFO: Timeout per run is 0h 02m 30s
>> tst_kconfig.c:87: TINFO: Parsing kernel config '/proc/config.gz'
>> shmget02.c:95: TPASS: shmget(1644199826, 2048, 1024) : ENOENT (2)
>> shmget02.c:95: TPASS: shmget(1627422610, 2048, 1536) : EEXIST (17)
>> <4>[   84.678150] __vm_enough_memory: pid: 513, comm: shmget02, not
>> enough memory for the allocation
>> shmget02.c:95: TPASS: shmget(1644199826, 0, 1536) : EINVAL (22)
>> shmget02.c:95: TFAIL: shmget(1644199826, 4278190080, 1536) expected
>> EINVAL: ENOMEM (12)
> Adding Liam Howlett, Davidlohr Bueso and Manfred Spraul to Cc, they
> have worked on the shm code in the past few years.
>
> This is the line
>
> 	{&shmkey1, SHMMAX + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
>
> from
>
> https://github.com/linux-test-project/ltp/blob/04e8f2f4fd949/testcases/kernel/syscalls/ipc/shmget/shmget02.c#LL59C1-L59C61
>
> right?
>
> I think this is a result of SHMMAX being defined as
> #define SHMMAX (ULONG_MAX - (1UL << 24)), so the kernel would
> likely use a large 64-bit value here, while the 32-bit user
> space uses a much smaller limit.
>
> The expected return code likely comes from
>
> static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
> {
> ...
>          if (size < SHMMIN || size > ns->shm_ctlmax)
>                  return -EINVAL;
>          
> but if ns->shm_ctlmax is probably set to the 64-bit value here.
> It would then trigger the accounting limit in __shmem_file_setup():
>
>          if (shmem_acct_size(flags, size))
>                  return ERR_PTR(-ENOMEM);
>
> My feeling is that the kernel in this case works as expected,
> and I wouldn't see this as a bug. On the other hand, this
> can probably be addressed in the kernel by adding a check for
> compat tasks like
>
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -714,7 +714,8 @@ static int newseg(struct ipc_namespace *ns, struct ipc_params *params)
>          char name[13];
>          vm_flags_t acctflag = 0;
>   
> -       if (size < SHMMIN || size > ns->shm_ctlmax)
> +       if (size < SHMMIN || size > ns->shm_ctlmax ||
> +          in_compat_syscall() && size > COMPAT_SHMMAX))
>                  return -EINVAL;
>   
>          if (numpages << PAGE_SHIFT < size)
>
I would consider this as ugly: ns->shm_ctlmax can be configured by 
writing to /proc/sys/kernel/shmmax.

You can break the test case on 64-bit as well, just by writing SHMMAX+1 
to /proc/sys/kernel/shmmax

Thus I think the test case is flawed:

It is testing the overflow behavior for a configurable value by testing 
with default+1. But sometimes the actual value is not the default.

Are the tests running as root?

What about intentionally setting the value to something useful?

tmp=$(cat /proc/sys/kernel/shmmax)

echo "1234" > /proc/sys/kernel/shmmax

semget() based on {&shmkey1, 1234 + 1, IPC_CREAT | IPC_EXCL, 0, 0, EINVAL},
echo $tmp >/proc/sys/kernel/shmmax

Or, alternatively: read /proc/sys/kernel/shmmax, and skip the test if 
the value is larger than ULONG_MAX-1.

--
	Manfred



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
