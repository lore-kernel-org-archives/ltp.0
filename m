Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623F4C5478C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 14:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709561884; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=vH8OVLTJJL+1j5ywICP/bnL9TvqogWsOH0NAmW4eDcw=;
 b=nwWe1PYqBQPYmokdJE+MBDVJVDqjTHs+QpnOIFDemegLJ9AIdv3LYKGTGtI0BWdp9sg8v
 5Nbm2BKbwTWdilo8RHH3TNING4t6FzcB3a2opZDIbXmiTqVfQ33dgDLgs92kKyLvSeOf5tH
 /wSjyAVZMjed9GP3ySmF22e9um1saJQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 550873CEBF8
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 15:18:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C1CA3CC4DA
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 15:17:43 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 046D120116E
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 15:17:41 +0100 (CET)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5649c25369aso6456645a12.2
 for <ltp@lists.linux.it>; Mon, 04 Mar 2024 06:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709561861; x=1710166661; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c0y6ZbvRTkMxtt+EfccXSYbd2k776Lr/YM0GUp/oDh8=;
 b=OxnEE/CNsHZzEH+bwNMd/gxakf3Co3S268BLOrjMlKbtyH4yCAhJWn4FsmFwB5oCK5
 qmVn9r6nFrqmrRFmZPXBMZwDhwUf7VLrl4lsUhd6JKHxFwWNkh3DiDIYC92DOzA6I0K7
 I070Sc5i/ArLWgTqerdEg1Fd/qxJ+g7v/0PMydR9qBsSNjtkjC5HWJIISwA4rqEtoHYa
 0I3/JYoiHYR3D+JfV1CxuVjgGIOwU0YrUEsAKJQqHCcplyYUUqy4v3I8vB4szbASpDkK
 S0oGmnFkIN7wkd0mw653qUVcKVsCPn2kmltt3ufwbFLglWpK9Cd1FIbOlMMVSWO9Pvx7
 sdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709561861; x=1710166661;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c0y6ZbvRTkMxtt+EfccXSYbd2k776Lr/YM0GUp/oDh8=;
 b=MaRQ1siYDmAT+G8DVoxBGzB5rb5wLgCLwGN/461ag4XdtdzpPu6hytzhN4M8/8c5SL
 VAQLIcY8bfx4IrFKPaPhOCq/l+hJGxPKWv2/hAe/VYA/bYOaFSCPAeFCwqRIIYEg1CAe
 /xopICdWc0wYpMIpptXEfOa+2Kg6MLihxb8hh1M61EU5c8NXj1AY6wl2KXPzB7sVTCGu
 9yk2i7UebpbqNEvWAnKdj5TPxPesrBoe3sg7jrzpVxy+7BXoGXKtPq86VpweJ1HsAzD9
 qdsa54qnjkPUY8sVpTAvMbZwUrZbVcHhbj7zxEiwTjipQSpwiQ2kY2sI+3Q8iLNcpa4u
 wH+g==
X-Gm-Message-State: AOJu0Yw/rZBcZ86+6c8fYSprjCF0Z1a6WlOULiiD2/n6j4+bD1i/ncl1
 FHtj1lAKisyzcd9LG0sfJAIYt7qOmhTdLtGWocLH8xAj8gzqIn1LIguOB3Iz3xH2WB8wILMr3mW
 p
X-Google-Smtp-Source: AGHT+IEA4FV2q5NBSbRmpSXpe5pQUmixuf4WHSPDJiJxDVtIOq/eNJ9jJBDT1UgsdM7JZlTsQFwYIg==
X-Received: by 2002:a50:c94b:0:b0:565:6e57:fa3d with SMTP id
 p11-20020a50c94b000000b005656e57fa3dmr5674148edh.10.1709561861380; 
 Mon, 04 Mar 2024 06:17:41 -0800 (PST)
Received: from [10.232.133.85] ([88.128.88.176])
 by smtp.gmail.com with ESMTPSA id
 dh18-20020a0564021d3200b0056760e830f0sm755750edb.81.2024.03.04.06.17.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 06:17:40 -0800 (PST)
Message-ID: <a1092d18-8f31-49d9-80b8-1436a0c9bd86@suse.com>
Date: Mon, 4 Mar 2024 15:17:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240226153754.24998-1-andrea.cervesato@suse.de>
 <20240226153754.24998-3-andrea.cervesato@suse.de> <Zdy26zz-_23brAlB@yuki>
Content-Language: en-US
In-Reply-To: <Zdy26zz-_23brAlB@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Add shmat04 SysV IPC bug reproducer
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 2/26/24 17:06, Cyril Hrubis wrote:
> Hi!
>> +static void change_access(void *addr, int size, int prot)
>> +{
>> +	switch (prot) {
>> +	case PROT_NONE:
>> +		tst_res(TINFO, "Disable memory access. addr: %p - size: %d",
>> +			addr, size);
>> +		break;
>> +	case PROT_WRITE:
>> +		tst_res(TINFO, "Enable write memory access. addr: %p - size: %d",
>> +			addr, size);
>> +		break;
>> +	default:
>> +		tst_res(TINFO, "Change memory access. addr: %p - size: %d",
>> +			addr, size);
>> +		break;
>> +	}
>> +
>> +	SAFE_MPROTECT(addr, size, prot);
>> +}
> Hmm, it's kind of ugly how we wrap the macro here like that...
>
> What about we instead add debugging messages to all the SAFE_MACROS()?
>
> Given that we added TDEBUG flag recently we can do soemthing as:
>
> 	tst_res_(TDEBUG, file, lineno, "mprotect(%p, %d, %s)",
> 	         addr, size, prot_to_str(prot));
>
> To the SAFE_MPROTECT() and get the verbose output for free with verbose
> flag passed to the test.
>
> We can do that with all SAFE_MACROS() then we do not have to print most
> of the messages in this test...
Is this comment related with the previous patch of the set?
>> +
>> +static void run(void)
>> +{
>> +	struct shmid_ds shmid_ds;
>> +	void *sh_mem;
>> +
>> +	segment_id = SAFE_SHMGET(
>> +		key_id,
>> +		segment_size,
>> +		IPC_CREAT | IPC_EXCL | 0600);
>> +
>> +	sh_mem = SAFE_SHMAT(segment_id, NULL, 0);
>> +
>> +	tst_res(TINFO, "Attached at %p. key: %d - size: %lu",
>> +		sh_mem, segment_id, segment_size);
>> +
>> +	SAFE_SHMCTL(segment_id, IPC_STAT, &shmid_ds);
>> +
>> +	tst_res(TINFO, "Number of attaches: %lu", shmid_ds.shm_nattch);
>> +
>> +	change_access(sh_mem + page_size, page_size, PROT_NONE);
>> +	change_access(sh_mem, 2 * page_size, PROT_WRITE);
>> +
>> +	SAFE_SHMCTL(segment_id, IPC_STAT, &shmid_ds);
>> +
>> +	tst_res(TINFO, "Number of attaches: %lu", shmid_ds.shm_nattch);
>> +	tst_res(TINFO, "Delete attached memory");
>> +
>> +	SAFE_SHMDT(sh_mem);
>> +	SAFE_SHMCTL(segment_id, IPC_STAT, &shmid_ds);
>> +
>> +	tst_res(TINFO, "Number of attaches: %lu", shmid_ds.shm_nattch);
>> +
>> +	SAFE_SHMCTL(segment_id, IPC_RMID, NULL);
>> +	segment_id = -1;
>> +
>> +	if (shmid_ds.shm_nattch)
>> +		tst_res(TFAIL, "The system is affected by the SysV IPC bug");
>> +	else
>> +		tst_res(TPASS, "Test passed");
> These messages are not really that useful, we can as well do:
>
> TST_EXP_EQ_LU(shmid_ds.shm_nattach, 0);
>
> That will provide better message than "PASS: Test passed"
>
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	key_id = GETIPCKEY();
>> +	page_size = getpagesize();
>> +
>> +	tst_res(TINFO, "Key id: %d", key_id);
>> +	tst_res(TINFO, "Page size: %d", page_size);
>> +
>> +	segment_size = 3 * page_size;
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (segment_id != -1)
>> +		SAFE_SHMCTL(segment_id, IPC_RMID, NULL);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +};
>> -- 
>> 2.35.3
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
