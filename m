Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA4BE674BA
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 09:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730451908; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=K5828Q29fmJ9ONkIg7rxrUPq2k9uKOIIi7VLVkVtMJg=;
 b=Mo1tSJD6asKzh4SeCk9Y6aGlUWPQi0MLKhp+oRP4Q/Z7+IauHoMAg2s9Yl06FRyXvJbzh
 JUYbFHOEMt+dBuDFv+3O7eFqj2I+GJd21FgAf7Hl4PdGMVNGjunH8sQzNLj/vfVEfDr0zCm
 NrTkM4DP4ANqpRSTcq8O456FKZmuHUo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A2E13CD039
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 10:05:08 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB6993CCABD
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 10:04:47 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9458E1435386
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 10:04:44 +0100 (CET)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c957d8bce2so957077a12.2
 for <ltp@lists.linux.it>; Fri, 01 Nov 2024 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730451884; x=1731056684; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YPCjCVtzClriJ2eMsFNd2vYEUuq8zP4wU9I/LS3HW4s=;
 b=P7gf6d2t5qIw4jKusni98QiSlp5MBMLi/oUFt9nC5ajjcAdDvFzTUiWG/pTv6SHXB1
 Z4jM/lL4keTIoiZOSkA6NYZumAualw8MtOin5AB7vILAoRvAaumFnhFUlBQVOVxFI5sc
 hZtSQ7pLtMRxEh4xYTKzgAaTTpmYTtOs/jrfTf5SWLqu7QozzqL968OSUnSs4fu8qwUt
 Zk+UsM6L1GMZTKQDo0azEivVduAPaYfI6IlXjEFZ02kZqO4L/7Fa6ZB3tTM+aPd/6nKU
 EWRdO9A4YN8eo/7wfN4/jJrEN1jNyuThvE+o4JZQ3gxWvn+W5/f0cX5mkWsM+4t1Zf/s
 wBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730451884; x=1731056684;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPCjCVtzClriJ2eMsFNd2vYEUuq8zP4wU9I/LS3HW4s=;
 b=BqRfl7iz0UvXcLUrkwu9rz5vJchw3AeL6TjfSgTMcnogaKfRhmvzC3VQZVaF+XS5xE
 SoZ6Ya0jLLyHURWpmy6C57P02Oe+IthfjTekmdthgHmbNIRGIassIq05s0TSAvEpWVBE
 fced2C0fuX6EcPJmwAqqmeDcP5OEpNyhsytTfp2SnYv6hSIHDaRSOHOHa4jUDw0S0zNe
 0LJrlcNb3IebwsXn8T4sGAYkfFi72giHVYvDh2deQV5OiSQDlbgbS5V5tq1DIxxaUOyy
 rLMXrctADX54PKc69rMD0/4XPZlrGAFnG4iUAd41iFQihyROkQBT7113BptTXqRPP/Z1
 Wm9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJH4MI37PjpSQ2iQF2mHFcokrLPYzmqkZZs54bCabhXUzm//KSronS70xgwwzQT6664o4=@lists.linux.it
X-Gm-Message-State: AOJu0YwLm7TWXehp/LplLm6yQ74lkjnDykuVTTMTNcDBnZFWraJp2TEb
 QleaoiLDtvpapWdDeyJ3Zs2TXyd82VPWNWBPYhsKgspseqRShjFhf/9U2eaysg==
X-Google-Smtp-Source: AGHT+IHxbFJQR3ggvOS6BIzWf2F8dPCWhVDlyCvkf+IQ5EE36dLCPa/gmRwD0HpTxu/tsqU8bccr8Q==
X-Received: by 2002:a50:ee0f:0:b0:5c9:21aa:b145 with SMTP id
 4fb4d7f45d1cf-5ceb93a1325mr2439903a12.36.1730451883931; 
 Fri, 01 Nov 2024 02:04:43 -0700 (PDT)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ceac78cad7sm1305047a12.49.2024.11.01.02.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 02:04:43 -0700 (PDT)
Date: Fri, 1 Nov 2024 05:04:32 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZySZoKXDdTJHrJJB@wegao>
References: <20240927101813.12643-1-chrubis@suse.cz>
 <2748318.lGaqSPkdTl@localhost> <20241015161950.GA35679@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241015161950.GA35679@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include: Better documentation for TFAIL and TBROK\
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

IFR1ZSwgT2N0IDE1LCAyMDI0IGF0IDA2OjE5OjUwUE0gKzAyMDAsIFBldHIgVm9yZWwgd3JvdGU6
Cj4gSGkgQ3lyaWwsIEF2aW5lc2gsCj4gCj4gbml0OiB0aGVyZSBpcyB0cmFpbGluZyAiXCIgaW4g
dGhlIHRlc3Qgc3ViamVjdC4KPiAKPiA+IEhpIEN5cmlsLAo+IAo+ID4gT24gRnJpZGF5LCBTZXB0
ZW1iZXIgMjcsIDIwMjQgMTI6MTg6MTPigK9QTSBHTVQrMiBDeXJpbCBIcnViaXMgd3JvdGU6Cj4g
PiA+IEZpeGVzOiAjMTE2Mgo+IAo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNo
cnViaXNAc3VzZS5jej4KPiAKPiA+IFJldmlld2VkLWJ5OiBBdmluZXNoIEt1bWFyIDxha3VtYXJA
c3VzZS5kZT4KPiAKPiA+IFRoYW5rIHlvdSwKPiA+IEF2aW5lc2gKPiAKPiA+ID4gLS0tCj4gPiA+
ICBpbmNsdWRlL3RzdF9yZXNfZmxhZ3MuaCB8IDIzICsrKysrKysrKysrKysrKysrKystLS0tCj4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiAK
PiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHN0X3Jlc19mbGFncy5oIGIvaW5jbHVkZS90c3Rf
cmVzX2ZsYWdzLmgKPiA+ID4gaW5kZXggODA2OTQwZTBkLi5hNzk0MjhmYTIgMTAwNjQ0Cj4gPiA+
IC0tLSBhL2luY2x1ZGUvdHN0X3Jlc19mbGFncy5oCj4gPiA+ICsrKyBiL2luY2x1ZGUvdHN0X3Jl
c19mbGFncy5oCj4gPiA+IEBAIC05LDExICs5LDI2IEBACj4gPiA+ICAvKioKPiA+ID4gICAqIGVu
dW0gdHN0X3Jlc19mbGFncyAtIFRlc3QgcmVzdWx0IHJlcG9ydGluZyBmbGFncy4KPiA+ID4gICAq
Cj4gPiA+IC0gKiBAVFBBU1M6IFJlcG9ydHMgYSBzaW5nbGUgc3VjY2Vzcy4KPiA+ID4gLSAqIEBU
RkFJTDogUmVwb3J0cyBhIHNpbmdsZSBmYWlsdXJlLgo+ID4gPiAtICogQFRCUk9LOiBSZXBvcnRz
IGEgc2luZ2xlIGJyZWFrYWdlLgo+ID4gPiArICogQFRQQVNTOiBSZXBvcnRzIGEgc2luZ2xlIHN1
Y2Nlc3MuIFN1Y2Nlc3NlcyBpbmNyZW1lbnQgcGFzc2VkIGNvdW50ZXIgYW5kCj4gPiA+ICsgKiAg
ICAgICAgIHNob3cgdXAgaW4gdGhlIHRlc3QgcmVzdWx0cy4KPiA+ID4gKyAqCj4gPiA+ICsgKiBA
VEZBSUw6IFJlcG9ydHMgYSBzaW5nbGUgZmFpbHVyZS4gRmFpbHVyZXMgaW5jcmVtZW50IGZhaWx1
cmUgY291bnRlciBhbmQKPiA+ID4gKyAqICAgICAgICAgc2hvdyB1cCBpbiB0aGUgdGVzdCByZXN1
bHRzLiBBIGZhaWx1cmUgb2NjdXJzIHdoZW4gdGVzdCBhc3NlcnRpb24KPiA+ID4gKyAqICAgICAg
ICAgaXMgYnJva2VuLgo+ID4gPiArICoKPiA+ID4gKyAqIEBUQlJPSzogUmVwb3J0cyBhIHNpbmds
ZSBicmVha2FnZS4gQnJlYWthZ2VzIGluY3JlbWVudCBicmVha2FnZSBjb3VudGVyIGFuZAo+ID4g
PiArICogICAgICAgICBzaG93IHVwIGluIHRoZSB0ZXN0IHJlc3VsdHMuIEJyZWFrYWdlcyBhcmUg
cmVwb3J0ZWQgaW4gY2FzZXMgd2hlcmUgYQo+ID4gPiArICogICAgICAgICB0ZXN0IGNvdWxkbid0
IGJlIGV4ZWN1dGVkIGR1ZSB0byBhbiB1bmV4cGVjdGVkIGZhaWx1cmUgd2hlbiB3ZSB3ZXJlCj4g
bml0OiBtYXliZSB1c2UgcGFzc2l2ZSBmb3JtPyAid2hlbiB3ZSB3ZXJlIHNldHRpbmcgdGhlIHRl
c3QgZW52aXJvbm1lbnQiID0+Cj4gImR1cmluZyB0aGUgdGVzdCBzZXR1cCIgb3IgImR1cmluZyBz
ZXR0aW5nIHRoZSB0ZXN0IGVudmlyb25tZW50Ij8KPiAKPiA+ID4gKyAqICAgICAgICAgc2V0dGlu
ZyB0aGUgdGVzdCBlbnZpcm9ubWVudC4gVGhlIFRCUk9LIHN0YXR1cyBpcyBtb3N0bHkgdXNlZAo+
ID4gPiArICogICAgICAgICB3aXRoIHRzdF9icmsoKSB3aGljaCBleGl0IHRoZSB0ZXN0IGltbWVk
aWF0ZWxseS4gVGhlIGRpZmZlcmVuY2UKPiA+IHMvaW1tZWRpYXRlbGx5L2ltbWVkaWF0ZWx5IAo+
IAo+ICsxCj4gCj4gPiA+ICsgKiAgICAgICAgIGJldHdlZW4gVEJST0sgYW5kIFRDT05GIGlzIHRo
YXQgVENPTkYgaXMgdXNlZCBpbiBjYXNlcyB3aGVyZQo+ID4gPiArICogICAgICAgICBvcHRpb25h
bCBmdW5jdGlvbmFsaXR5IGlzIG1pc3Npbmcgd2hpbGUgVEJST0sgaXMgdXNlZCBpbiBjYXNlcyB3
aGVyZQo+ID4gPiArICogICAgICAgICBzb21ldGhpbmcgdGhhdCBpcyBzdXBwb3NlZCB0byB3b3Jr
IGlzIGJyb2tlbiB1bmV4cGVjdGVkbHkuCj4gbml0IChub3QgcmVhbGx5IHN1cmUpOiAidGhhdCIg
PT4gIndoaWNoIgo+IAo+ID4gPiArICoKPiA+ID4gICAqIEBUV0FSTjogUmVwb3J0cyBhIHNpbmds
ZSB3YXJuaW5nLiBXYXJuaW5ncyBpbmNyZW1lbnQgYSB3YXJuaW5nIGNvdW50ZXIgYW5kCj4gPiA+
IC0gKiAgICAgICAgIHNob3cgdXAgaW4gdGVzdCByZXN1bHRzLgo+ID4gPiArICogICAgICAgICBz
aG93IHVwIGluIHRlc3QgcmVzdWx0cy4gV2FybmluZ3MgYXJlIHNvbWV3aGVyZSBpbiB0aGUgbWlk
ZGxlIGJldHdlZW4KPiA+ID4gKyAqICAgICAgICAgVEJST0sgYW5kIFRDT05GLiBXYXJuaW5ncyB1
c3VhbGx5IGFwcGVhciB3aGVuIHNvbWV0aGluZyB0aGF0IGlzCj4gbml0IChub3QgcmVhbGx5IHN1
cmUpOiAidGhhdCIgPT4gIndoaWNoIgo+IAo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9y
ZWxAc3VzZS5jej4KPiAKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+IAo+ID4gPiArICogICAgICAg
ICBzdXBwb3NlZCB0byBiZSB3b3JraW5nIGlzIGJyb2tlbiBidXQgdGhlIHRlc3QgY2FuIHNvbWVo
b3cgY29udGludWUuClJldmlld2VkLWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4KCj4gCj4g
LS0gCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
