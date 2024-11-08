Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2607FD64072
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 17:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731088736; h=mime-version :
 date : message-id : references : in-reply-to : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ZsCftdY1FtVfocOsbJ5CPmtBayUmoeumtsntAMFuRBo=;
 b=dBVeR4c24DUw4VzODNFUGwU08Vv29KV3KRzd93butjzrceZgL+JZjNfKPPCzAnDqu/3uX
 nUaAwi8CKIf1nnQmhlnuN1I9NyOyrzCmRMJjiqAg+7TsV5HnAo/Puxm0i1GETtMwkvqZLsy
 3glNRs3M9I61FjFLI9ZSHfLqI4OBj5Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C08CC3D4B8B
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 18:58:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FF383D4B6E
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 18:58:36 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 754906296DC
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 18:58:34 +0100 (CET)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso3236729a12.1
 for <ltp@lists.linux.it>; Fri, 08 Nov 2024 09:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731088714; x=1731693514; darn=lists.linux.it;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:from:to:cc:subject:date:message-id
 :reply-to; bh=43BqJ8jzQiSvV5QYTAdkshOVIAn2WP8wQnXEHj9rEZA=;
 b=C7Yv1mu5HqztZfUQowNsyXUcvRHGC02gvIKzWxV00zrMx8EZvd2kC159Oh3vI0oaUq
 LV7aPwJd0CLdfUuNJ4qhQByV4GPc10YwuLTYwXAzqFcZagM3VWGpmi5BKxtLUQ/BEGO7
 iOSs2NldyaSDTiwQwQ5mGItvyg3Pt4fcr9N56tBrBGlim7mHL3t01Qh6CHUyUm3gBzGv
 ZYEqTjrbKChRdT/IODtgCzC2+LBmyAkJO7d1gTelnJBh4dO4eBHa922ZFOXT+6YG76qJ
 WT0Y7fp/5RurMAm9sLzL9ZPt6ro6UofobdfU//ZZYjisDraIiRgnq8o9LJLxyggqMnTi
 eQKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088714; x=1731693514;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=43BqJ8jzQiSvV5QYTAdkshOVIAn2WP8wQnXEHj9rEZA=;
 b=fSTOWRb5m7vDXjmM4NIMHM6yBX+gsAbZgq2Qalx8jnBHV5GS+4yr3uto7nOSPTkVlj
 aWSM6VFlmDMsVJw1WXX63CTOdUSOtHECMMWoQwN92d9R2Wy35vtLcM5GmlouWcPdN73z
 MAMn0Nu2vVzA8g+J7GO4oOqK+4Calrl2VEC+WP5fyMpeLQ1wNtZ3+GNQcSe9DMOMluvi
 BMJWYWb5XBC/bM4ey/VJ9dL5tcoXqrV+fnCS8AWsV8ieS5XixoudAEB/hSQzfZqvENX1
 32ipQupZxHF/0IJJ28Qhwow0k5nSNfWWp4BTwoS3R/raet+aElmtUj/tTWZ+7hYffJ2N
 488A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoXFZmfByqHhd1KOHMOKm0oEHczvPWx4vjdelLblxYq5pZsdHtCU6X2PXmApT2GBQ6EQ0=@lists.linux.it
X-Gm-Message-State: AOJu0YxTsqwFlYeATus0FHNFwplQV4g4j7YeXL31bwhkxqxbe2Wb1jcH
 iBEb+WJHd5OEmYRsCy7ya6upMAqQEQ8BFbmUBRuDcpUMC5xGPcaSJWOiG5xHrG5wTOlp7z7MdaM
 F
X-Google-Smtp-Source: AGHT+IGYrYgugFt5xtnsk7n/lOQJw0zOS116UctDIhxEytr2hFKWC9Cn2FIl5ZtzEPQ3ha3cW4lRJA==
X-Received: by 2002:a17:907:a03:b0:a9a:294:cb30 with SMTP id
 a640c23a62f3a-a9eefeecae5mr325396666b.16.1731088713815; 
 Fri, 08 Nov 2024 09:58:33 -0800 (PST)
Received: from smtpclient.apple ([2a00:20:6046:63e6:5587:bbc4:675c:2bfc])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0e2e8basm259573266b.194.2024.11.08.09.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Nov 2024 09:58:33 -0800 (PST)
Mime-Version: 1.0 (1.0)
Date: Fri, 8 Nov 2024 18:58:21 +0100
Message-Id: <52C460ED-16D1-44BA-8273-2DB44C2F5C60@suse.com>
References: <Zy4z-VvTyGScU5tQ@yuki.lan>
In-Reply-To: <Zy4z-VvTyGScU5tQ@yuki.lan>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mailer: iPhone Mail (22B83)
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] Fallback landlock network support
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgp5b3UgY2Fu4oCZdCBiZWNhdXNlIHRoZXkgYXJlIGFsd2F5cyBkZWZpbmVkLiBU
aGV5IGNhbiBiZSAwIG9yIDEuIENoZWNrIGNvbmZpZy5oCgpBbmRyZWEKCj4gT24gOCBOb3YgMjAy
NCwgYXQgMTY6NTMsIEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKPiAKPiDv
u79IaSEKPj4gKyNpZiAhSEFWRV9ERUNMX0xBTkRMT0NLX1JVTEVfUEFUSF9CRU5FQVRICj4gCj4g
SSBhc2tlZCB0aGVzZSB0byBiZSBjaGFuZ2VkIHRvIGlmbmRlZiBzaW5jZSB0aGV5IGFyZSBtb3Jl
IHN0YW5kYXJkIGFuZAo+IG1vcmUgdmlzaWJsZS4KPiAKPj4gKyMgZGVmaW5lIExBTkRMT0NLX1JV
TEVfUEFUSF9CRU5FQVRIIDEKPj4gKyNlbmRpZgo+PiArCj4+ICsjaWYgIUhBVkVfREVDTF9MQU5E
TE9DS19SVUxFX05FVF9QT1JUCj4gCj4gSGVyZSBhcyB3ZWxsLgo+IAo+PiArIyBkZWZpbmUgTEFO
RExPQ0tfUlVMRV9ORVRfUE9SVCAyCj4+ICNlbmRpZgo+IAo+IC0tCj4gQ3lyaWwgSHJ1YmlzCj4g
Y2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
