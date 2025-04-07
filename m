Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5432CC36010
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 12:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744028326; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : cc : content-type : content-transfer-encoding
 : sender : from; bh=7arxZQRvfJx3Si5l3Auje5hWYTDEq5Ky8s/9Axnf57Q=;
 b=Yl15YqwLNFRumSTrBG0ypnhTCvOwsjcGW4VGlCOO9svpmQvrwNJqgfVwfjaGG5ZoitYaz
 PvqV0uM8YoAo3s2vx7iNXcI0imp8AAOfggYc/kEPYu9fNLmYgHui0/9fE0HeWtelMfhh6fC
 dxiSaVGGMBKXO0yZqxQ7IfMDbzrN/0g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEE1C3CAF20
	for <ltp@archiver.kernel.org>; Mon,  7 Apr 2025 14:18:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id B899C3CA0EF
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:18:24 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with UTF8SMTPS id BAC85140098B
 for <ltp@lists.linux.it>; Mon,  7 Apr 2025 14:18:22 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so3713623f8f.3
 for <ltp@lists.linux.it>; Mon, 07 Apr 2025 05:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744028302; x=1744633102;
 h=in-reply-to:references:cc:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qbwh7ZYCoCOUtLPkjMxGdgEwr3CxsW0V8rsBDNvvu3M=;
 b=k48hSFFcrfDKCxYiA2kqhoMOeRJLer2jDtHa+5iYZmaUgET2QTgqGxddh+vEWV2Uy5
 jHZCbtEf99z6JaWcV7nn0isc5Mw0C7Rms2BDZkVDaNxZE3HH75zjT/ILszpiu45tp5CQ
 C+IbHFiHxKuvy9OzR+CDjj2hzA8GVE2VEa414T0IByD6HLHUabSPLlBq2k1LOfv7selx
 oNJj6vccUiJDNKaszX0kp3MUkaqq08QUOqUg4XH/0nYTz3WsLbIdfeEvaYxBKFTfeUv5
 W5HwnS2MgBdpurGihFHMAzCpEgFdwNvWy/knQqqSIgPHgJ1N60mmFKUp/U0QnUPqOs3k
 laUg==
X-Gm-Message-State: AOJu0YzSbPvboazNTqRiTq7N+gT7AG8rC2M910asV7i9if6NQUb7UxwL
 flugGhtTbZ8674CPI9QT7RubsXOMVlDDhZ8GUO944lkrqKo7jpWpBdpLSgv7JRi2Hrghd83fHjr
 7
X-Gm-Gg: ASbGncuOvXRsyOUlkhyW7CUwE+Vb1kpL7wfG1UABSfdNu8Zjd5O007arp8DML5oS9sZ
 PDg7Uj93qG7W7TJnRElSNero5rHn4YbOA7mg715WzdNmcla65R5hzRQFX9oeymnjlYWVlornKsM
 2qdpMLBaUXp89BXRoE0c0EK9HatJYrmzA/2hGwlx4ewkGogCf1b+bC1Y9vVuzVljTHEa20Ucx7H
 dNeTK6NaNb6bPcEXMYbge3LqgxWU/sa9rH4Q4AibHs6XtvPnVRx7amlg+8eZhx6IFFGluIuBE6g
 cGLHV6IvDdTAOKy89PE95bhzccv1NjbLvQ==
X-Google-Smtp-Source: AGHT+IGsLJoWFkT+osz3ulOBqSa+GUVn7m69Zc4J2hljVog4e/XYH9pFBATO3Qc2UEoGY7Hy9awW+g==
X-Received: by 2002:a5d:6d81:0:b0:391:2bcc:11f2 with SMTP id
 ffacd0b85a97d-39d0873fccdmr10050450f8f.1.1744028302140; 
 Mon, 07 Apr 2025 05:18:22 -0700 (PDT)
Received: from localhost ([179.228.213.210]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785ad899sm79662635ad.14.2025.04.07.05.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 05:18:21 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 07 Apr 2025 09:18:16 -0300
Message-Id: <D90EFMZN80VM.342MIYQMFIK8N@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
X-Mailer: aerc 0.20.1-31-gf6db7c329ce0-dirty
References: <20250402-conversions-modify_ldt-v6-0-2e4b0e27870e@suse.com>
 <20250402-conversions-modify_ldt-v6-1-2e4b0e27870e@suse.com>
 <Z_PAd1a_oIVnREsQ@yuki.lan>
In-Reply-To: <Z_PAd1a_oIVnREsQ@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] syscalls/modify_ldt: Add lapi/ldt.h
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
From: =?utf-8?b?UmljYXJkbyBCLiBNYXJsae+/ve+/vXJlIHZpYSBsdHA=?=
 <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marlière" <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon Apr 7, 2025 at 9:09 AM -03, Cyril Hrubis wrote:
> Hi!
>> +static inline int modify_ldt(int func, const struct user_desc *ptr,
>> +			     unsigned long bytecount)
>> +{
>> +	return tst_syscall(__NR_modify_ldt, func, ptr, bytecount);
>> +}
>> +
>> +static inline int safe_modify_ldt(const char *file, const int lineno, int func,
>> +				  const struct user_desc *ptr,
>> +				  unsigned long bytecount)
>> +{
>> +	int rval;
>> +
>> +	rval = modify_ldt(func, ptr, bytecount);
>> +	if (rval == -1)
>> +		tst_brk_(file, lineno, TBROK | TERRNO,
>> +			 "modify_ldt(%d, %p, %lu)", func, ptr, bytecount);
>
> We should make sure that we only accept the success value here (as we do
> in the rest of the safe macros) so that we catch the cases when kernel
> returns an invalid value.
>
> This should be:
>
> 	if (rval == -1) {
> 		tst_brk_(...);
> 	} else if (rval) {
> 		tst_brk_("modify_ltd(...) invalid retval %i", ...);
> 	}

Makes sense! Unfortunately I just sent a v7, will wait some more before
sending the next one :)

>
>
> With that fixed:
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks for reviewing,
-	Ricardo.



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
