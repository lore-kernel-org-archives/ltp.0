Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42609C27C79
	for <ltp@archiver.kernel.org>; Mon, 17 Jun 2024 23:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1718666869; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Lxv3AUs28gk7HAoJnVJB4ifjz55UYUMSjccfw/BoCE4=;
 b=hvJuAZA0Pg9PFP4z+bzWF9jsKTHmRcRKU2yEOTne6UcUKIlceYqGdu5LuRR3moxwot0Lb
 rXOu3jgKzySlZYCNsIo9PYtjXALT9+w1xeMNDS98nlLMtIT/xA7XDdw10wDeNt3OS1WTsKF
 fUZoGN5fpGWglIpcQXJHJlrwg1IbF0o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 613233D0D3C
	for <ltp@archiver.kernel.org>; Tue, 18 Jun 2024 01:27:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE2293C02E7
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 01:27:27 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2B0AE1A008BB
 for <ltp@lists.linux.it>; Tue, 18 Jun 2024 01:27:27 +0200 (CEST)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52bc274f438so5171100e87.0
 for <ltp@lists.linux.it>; Mon, 17 Jun 2024 16:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1718666846; x=1719271646; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NlqYt8wEPiR/Knz/Qr9RX/tWipWCyUqOtNerP7QgnO0=;
 b=JGLJKcabuPCiHFHka1o6oPgQmKV8cxd1IHyHoc+kpcD4qWTQ8BESfYq/FUcDkuRU4v
 J9OSNA34TAArRbWCLac5FFoceM2s49pC0v8lbJsLCgWYDh5H5zCj6vomgj0qtsEwZuGe
 qfO7jx+Be6sn4AU85ZiqNdiwzaunZO1HGHLOivQrdAIvJIC6xU3onjEbYQzndqmpMVze
 ak4TKNqjN8q8vZYlL6XeYVFFoXaN0CHLcyLIvQ5QplMaC+f9LQ1gZ3GQcH7vkeoCyLFZ
 H7j8o7WG7AH68o/4UHrV60U/NZG0g5nJIDHS/ukv4FK5T4i0Gpl02JiHPwz0KkGHAHWD
 RQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718666846; x=1719271646;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NlqYt8wEPiR/Knz/Qr9RX/tWipWCyUqOtNerP7QgnO0=;
 b=WN2ZwePOcues1lWraAd3AbcX/33823UpWqraH2Hti9kuTPNRo5Ce154eHzxlf3fNOE
 NQcUnx+qRH2ftW3J0CwBnjkW3tC9+CWazEUR+53eNDjyAx6hZ2wWYs6gZpDO1WINxshm
 8+gllTgjT4HfCSszTieTFLQz+0GYzDiRrSKoS2DLmJFaXBDscKl/fgOfcXl2GII/H3bR
 tpV7vVGlRTviCGqdqKg5lzgDRz4j5Txm4SkYbecH831B4Wye92CAHF3v6E2XqMplmwOR
 nLPSusenX5SygLZGjF9VOA4dhysT6/4cffurUxPTvU706AhEfiML2DLCYwY9wfgdEpeo
 BzcQ==
X-Gm-Message-State: AOJu0YxHKgTPWRZqtDX04wtK+1PLwPPdIHpHiIEBLQy6P01UVvsehsoN
 CvmMhW4c8bgoXs6kVbvFpb6ngIbYyn/6B1pk91PelNy46BMPoy2DK0SYdhWma0c4X54HgVdAZUg
 =
X-Google-Smtp-Source: AGHT+IGZt+xVgch7wT4JK1koURVMlr18rDAwfcQJCs0tU6ByJYzWMABKPAiVapJGOsT3hDuv5bmnpw==
X-Received: by 2002:ac2:4c02:0:b0:52c:943e:9ecd with SMTP id
 2adb3069b0e04-52ca6e6436dmr8002198e87.16.1718666846344; 
 Mon, 17 Jun 2024 16:27:26 -0700 (PDT)
Received: from wegao.248.176.137 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db62c3sm558982966b.76.2024.06.17.16.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 16:27:26 -0700 (PDT)
Date: Mon, 17 Jun 2024 19:27:20 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <ZnDGWE/Jr8W4OoRc@wegao.248.176.137>
References: <20240617032400.298906-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240617032400.298906-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rpc_svc_1: Fix incompatible pointer type error
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

T24gTW9uLCBKdW4gMTcsIDIwMjQgYXQgMTE6MjQ6MDBBTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBUbyBnZXQgcmlkIG9mIHRoZSBjb21waWxlIGVycm9yIHdpdGggR0NDLTE0Ogo+IAo+IHJwY19z
dmNfMS5jOjEwOToxMjogZXJyb3I6IGFzc2lnbm1lbnQgdG8g4oCYc3RydWN0IHNvY2thZGRyX2lu
ICrigJkgZnJvbQo+IGluY29tcGF0aWJsZSBwb2ludGVyIHR5cGUg4oCYc3RydWN0IHNvY2thZGRy
X2luNiAq4oCZCj4gWy1XaW5jb21wYXRpYmxlLXBvaW50ZXItdHlwZXNdCj4gICAxMDkgfCAgICAg
ICAgIHNhID0gc3ZjX2dldGNhbGxlcih0cmFuc3ApOwo+ICAgICAgICAgfCAgICAgICAgICAgIF4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPiAtLS0KPiAg
Li4uL25ldHdvcmsvcnBjL3JwYy10aXJwYy90ZXN0c19wYWNrL3JwY19zdmNfMS9ycGNfc3ZjXzEu
YyAgICAgIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL25ldHdvcmsvcnBjL3JwYy10aXJwYy90
ZXN0c19wYWNrL3JwY19zdmNfMS9ycGNfc3ZjXzEuYyBiL3Rlc3RjYXNlcy9uZXR3b3JrL3JwYy9y
cGMtdGlycGMvdGVzdHNfcGFjay9ycGNfc3ZjXzEvcnBjX3N2Y18xLmMKPiBpbmRleCBkMWM0ZGY5
N2YuLmQzNjc2OTFjNCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMvbmV0d29yay9ycGMvcnBjLXRp
cnBjL3Rlc3RzX3BhY2svcnBjX3N2Y18xL3JwY19zdmNfMS5jCj4gKysrIGIvdGVzdGNhc2VzL25l
dHdvcmsvcnBjL3JwYy10aXJwYy90ZXN0c19wYWNrL3JwY19zdmNfMS9ycGNfc3ZjXzEuYwo+IEBA
IC0xMDYsNyArMTA2LDcgQEAgY2hhciAqc3ZjX2dldGNhbGxlcl90ZXN0KHVuaW9uIHVfYXJndW1l
bnQgKmluVmFyLCBTVkNYUFJUICogdHJhbnNwKQo+ICAJc3RydWN0IHNvY2thZGRyX2luICpzYSA9
IE5VTEw7Cj4gIAlzdGF0aWMgaW50IHJlc3VsdDsKPiAgCj4gLQlzYSA9IHN2Y19nZXRjYWxsZXIo
dHJhbnNwKTsKPiArCXNhID0gKHN0cnVjdCBzb2NrYWRkcl9pbiAqKSBzdmNfZ2V0Y2FsbGVyKHRy
YW5zcCk7Cj4gIAkvL0lmIHRoZSByZXN1bHQgaXMgbm90IE5VTEwgd2UgY29uc2lkZXIgdGhhdCBm
dW5jdGlvbiBjYWxsIHN1Y2NlZWRzCj4gIAkvL3NvIHJldHVybnMgMCAoUEFTUykKPiAgCXJlc3Vs
dCA9IChzYSAhPSBOVUxMKSA/IDAgOiAxOwo+IC0tIAo+IDIuNDUuMgo+IAo+IAo+IC0tIAo+IE1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cApSZXZp
ZXdlZC1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+CgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
