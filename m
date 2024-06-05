Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D0AC27C53
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717582609; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=n05RrfVp9NeZcMjHvGE18rsVzwZTsqbM3zp1VZfX3BU=;
 b=pxx13bBxd7cHGh1BQS/QgQjRgJzQ6u4xkTmoAXMA/6aAyeb0zaW/WVvEkFF1Ry+RQERvj
 /otIPjdrH/eJEl0LkEXLH3iG36gzQ62gUOE6l8iuvrqITXnATUdC8sWxLkWli+Y8fxWfj1C
 cZqFRMmAkcgLqhXsEDWNs5wkIDA/xss=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B3243D098A
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 12:16:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66C343CFFBF
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 12:16:28 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E30260080C
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 12:16:27 +0200 (CEST)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2eaa89464a3so41385451fa.3
 for <ltp@lists.linux.it>; Wed, 05 Jun 2024 03:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717582586; x=1718187386; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2y5qra+u4vIcnc51473aKOdJyeGa8eCMl4GcIRuwf3U=;
 b=B9WK4HkeQmQOwPFi01TgvEd8SKAaRazvLvjZmW1jMr1aoJV2SQLGsYZrlQKJILdLvA
 GjhiFf9Skzfo5yQGsrJSwMei5rhha8nCuz0mCIYDIkh+Wq+OlQvFCHZO9xwyU3WHjfvE
 8DXDLsTc7IW7IAKfYDnryE8lGJ+XD/TOntCd4z+wDtv/jSF/ZYzG/sFKM00+dq+0SOPj
 mWiyWgMVDnLddYL01uoFNOxeUzuyel5bWiypzOd99HsuOc/w/g1ctiuxLMzYBChwU/K+
 7/j1wfaZAOxgQ4wry6XBKtZnf5ZGLxhofgJvvqZkOd5vC1+gGvplKkoRMKh0lefrwB1o
 mHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717582586; x=1718187386;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2y5qra+u4vIcnc51473aKOdJyeGa8eCMl4GcIRuwf3U=;
 b=FjBYmzZSQVwKEY5yXl+Py8jYbDUQlRn2wouCS7uU7GbHZG6bihLStquvphTlvgiHZG
 slkAjmCvsAFvsmtCDnxd+cKyh0eyCMkLhZkce2mhqAJ4JYoXvWvHEbSSr202B6MdEt1m
 tv9AZTWnuzbBaZxvJSMXFdQOwjhU/OXIGusvwUMBpmoIRLGCtB2aMMAl7zy9cx15LcU3
 6yUYLYE9wsYL8QT1j4UWDpy2d9TyqGeOkOszt4PoHjDY2ZVtVRsSuL28qAmhmWnPLJAM
 8yRhw4NZPHOjqzmNCjifQBk0gaDaojFp1vlT4fyFPP5jP+8bwfgCurhCSn9JDS2FHI6c
 GjNw==
X-Gm-Message-State: AOJu0YwkSwaD3YHpDzzDRhMRpCuMHPtTg8k2NwWmH/WanO5anencdvId
 IfluYr13yRsIz1/iVkP8YxQS0TVlfJmQNuY5gOe1bGSFPKvtuHPtUtYoGQ7nQA3kQsjB9MDoKQy
 MtGQ=
X-Google-Smtp-Source: AGHT+IGf5ptWxDBEhCcsEHROp6IxG0NMvp34q2p4211LTHSdAhqc66dPkIEEABDrrBARjKN2UtrdHw==
X-Received: by 2002:a2e:860e:0:b0:2ea:75c5:69cb with SMTP id
 38308e7fff4ca-2eac79ed8cfmr10090051fa.27.1717582586550; 
 Wed, 05 Jun 2024 03:16:26 -0700 (PDT)
Received: from [192.168.178.40] ([212.86.36.118])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6c35a88cfaasm8103197a12.94.2024.06.05.03.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 03:16:26 -0700 (PDT)
Message-ID: <58dbd04d-95f7-4e56-9ea1-2ef0a87d7f18@suse.com>
Date: Wed, 5 Jun 2024 12:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
 <ZmAdqhv-VCWqJ3yf@rei>
Content-Language: en-US
In-Reply-To: <ZmAdqhv-VCWqJ3yf@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix unlink09 test
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpPbiA2LzUvMjQgMTA6MTEsIEN5cmlsIEhydWJpcyB3cm90ZToKPiBIaSEKPj4gKwlmZF9p
bW11dGFibGUgPSBTQUZFX0NSRUFUKFRFU1RfRVBFUk1fSU1NVVRBQkxFLCAwNjAwKTsKPj4gKwlU
RVNUKGlvY3RsKGZkX2ltbXV0YWJsZSwgRlNfSU9DX0dFVEZMQUdTLCAmYXR0cikpOwo+PiArCj4+
ICsJaWYgKFRTVF9SRVQgPT0gLTEgJiYgVFNUX0VSUiA9PSBFTk9UVFkpIHsKPj4gKwkJU0FGRV9D
TE9TRShmZF9pbW11dGFibGUpOwo+PiArCQl0c3RfYnJrKFRDT05GIHwgVFRFUlJOTywgIklub2Rl
IGF0dHJpYnV0ZXMgbm90IHN1cHBvcnRlZCIpOwo+PiArCX0KPiBJIHNlZSBvbmUgcHJvYmxlbSB3
aXRoIHRoaXMgYXBwcm9hY2guIElmIGtlcm5lbCBhY2NpZGVudGFsbHkgcmVtb3ZlcyBhCj4gc3Vw
cG9ydCBmb3IgaW1tdXRhYmxlIGZpbGVzIGZvciBhIGNlcnRhaW4gZmlsZXN5c3RlbSB0aGlzIHRl
c3Qgd2lsbCBiZQo+IGdyZWVuLiBBbmQgdGhlIGZpbGVzeXN0ZW1zIHRoYXQgbWlzcyB0aGlzIHN1
cHBvcnQgYXJlIHZlcnkgdW5saWtlbHkgdG8KPiBnYWluIGl0LCBlLmcuIHdpbGwgdmZhdCBnZXQg
c3VwcG9ydCBmb3IgaW1tdXRhYmxlIGZpbGVzPyBUaGF0IHdvdWxkIGJlCj4gYW4gYXJndW1lbnQg
Zm9yIGV4cGxpY2l0IHNraXBsaXN0IGluIHRoZSBmb3JtIG9mCj4gdHN0X3Rlc3QtPnNraXBfZmls
ZXN5c3RlbXMuCj4KVGhhdCdzIGEgdmFsaWQgc3RhdGVtZW50LsKgIEZvciBub3cgSSB3b3VsZCBs
aWtlIHRvIGZpeCB0aGUgdGVzdCBmaXJzdCwgCnRoZW4gd2UgY2FuIGZpeCB0aGlzIG90aGVyIHBy
b2JsZW0gd2l0aCBhbiBhbm90aGVyIHBhdGNoLgoKQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
