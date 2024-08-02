Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5564C3DA4A
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 11:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722598502; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=s4+FCHqdSShWtCupVKIq0DMA6n+sFS6rwqAUcyHyrv4=;
 b=LnWQ1BuxF/3BVV5L15Gxg7zIn+umpw16MlRQ5bx8YTGCPC8PwZnh8vEoirWDmkIfxFgfO
 /1z+o/c0SsQJ70Qi7K4V8UvCcalrOjz9L5xubohv+wxXlSE5UTrS3WgeshAH1LUCNT+x8+S
 yKA5iQN7+c4zkeii121Kp4EQv4ZmNzA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 159363D1CFF
	for <ltp@archiver.kernel.org>; Fri,  2 Aug 2024 13:35:02 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17A293D1C3E
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 13:34:41 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 792DA1000485
 for <ltp@lists.linux.it>; Fri,  2 Aug 2024 13:34:40 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42812945633so54615495e9.0
 for <ltp@lists.linux.it>; Fri, 02 Aug 2024 04:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722598480; x=1723203280; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W0suh7FkBNrFuFgb7AjQTlwgiqFlJ1vpXrcgUwPoqrY=;
 b=XsIKFM8oxr1CH0GLtfLAzA2GGIEwtrDoSP3liMLJ5adzeQVNN6YiDcD/HWUmwRO8BN
 iKmdMPctMbDaXcfEMln6tZikPJsZCQqZXr/jPBtnWTImKkRJpc3T83F8ybiuNNUhT2VQ
 Y0iRqt246j/Ql2FTArD59kMnjifEYdmva0v5ACrwcnu97ZlLmD2NB85r+ruGQ/nrZEnF
 n2Mq+Mop8sz7toi31Vg12F9DvG7bqZ8Lu0n8P/fc8I0Ek5D4lTCuCQGDt7gUfTdwt4x1
 VbyUlJxQ/TxHFHfJXuj+1A9RjTpe0GeQlX0AeR49plS01Sw3Npd21buNsJeHw9aW3Sxq
 cARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722598480; x=1723203280;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W0suh7FkBNrFuFgb7AjQTlwgiqFlJ1vpXrcgUwPoqrY=;
 b=igvlu/NSVUlfQCFwipViJxv3UJQKUTRZnUCDS22C4qb+K+AiJbZ3FU1XRG247nhyqa
 4wYNbdEwsUXhxmnd3TV3bTQytJY0C7iyAZPsgfWSi8gEmCBsENFYI610scSxwX3LKdsU
 /fXGEPNG6UG6WPMzwh/FTVH2DekP8P0EXVJDpxarP9NWNzMGdNA+gWNAWk+OI3Rp3yff
 tS7VTTGgG1VuCzsYXuhRu3lsEDi30lRURGT5wAubMzp2TWPB7qZb7uPCYtFOjR71Ctyh
 DkNNeD1qDB6b+aTcFcrm+62sTAiu5nBFblyU0N+jF2t2B6U+4XbVmXf0e1JxOO5rGEN2
 +FyQ==
X-Gm-Message-State: AOJu0YwPsL21JD6mKUref4pEW/6oJSMDUAFeBsMakIcdU52ASPegJdSd
 fyBrY612RDR9tZW1yPQOeYcVmizbmavXD7eYQ2B9JiWkIJEYUo1t1n/8Pq8GaASExWivERkchgP
 iLXU=
X-Google-Smtp-Source: AGHT+IGRugSkU2PgZ6pcXDBcIJ22bmn+qoRQGrCSRWQhc6HAnI+E7WMowO0H/TPML+jWluAk7KDhkw==
X-Received: by 2002:a05:600c:3587:b0:426:593c:935f with SMTP id
 5b1f17b1804b1-428e6ae27f7mr21305985e9.1.1722598479293; 
 Fri, 02 Aug 2024 04:34:39 -0700 (PDT)
Received: from [192.168.1.59] ([151.51.15.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb9d786sm90885195e9.44.2024.08.02.04.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 04:34:38 -0700 (PDT)
Message-ID: <8984a9e6-6b13-4e34-a709-3d45202f03ad@suse.com>
Date: Fri, 2 Aug 2024 13:34:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240802-fchmodat2-v6-0-dcb0293979b3@suse.com>
 <20240802-fchmodat2-v6-3-dcb0293979b3@suse.com>
 <20240802113032.GA1626431@pevik>
Content-Language: en-US
In-Reply-To: <20240802113032.GA1626431@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 3/5] Add fchmodat2 fallback definition
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

On 8/2/24 13:30, Petr Vorel wrote:
> Hi Andrea,
>
>
>> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>> ---
>>   include/lapi/stat.h | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
>> index 3606c9eb0..8e38ecfef 100644
>> --- a/include/lapi/stat.h
>> +++ b/include/lapi/stat.h
>> @@ -229,4 +229,20 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>>   # define STATX_ATTR_VERITY	0x00100000
>>   #endif
>> +#define SAFE_FCHMODAT2(dfd, filename, mode, flags) \
>> +	safe_fchmodat2(__FILE__, __LINE__, (dfd), (filename), (mode), (flags))
>> +
>> +static inline int safe_fchmodat2(const char *file, const int lineno,
>> +		int dfd, const char *filename, mode_t mode, int flags)
>> +{
>> +	int ret;
>> +
>> +	ret = tst_syscall(__NR_fchmodat2, dfd, filename, mode, flags);
>> +	if (ret == -1)
>> +		tst_brk_(file, lineno, TBROK | TERRNO, "%s(%d,%s,%d,%d) error",
>> +			__func__, dfd, filename, mode, flags);
> I'm sorry, I overlook that errno check is not needed. tst_syscall() does it
> (see include/lapi/syscalls.h). Please remove it before merge.
>
> With this:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr

As far as I see, tst_syscall() only handles ENOSYS and invalid syscalls, 
so it makes sense to handle TBROK | TERRNO inside the safe_* function.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
