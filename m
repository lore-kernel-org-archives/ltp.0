Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60EC9CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 17:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778088189; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=oIZqd5L8M1UL4WDcavbRiOV7gtQUXAted72moDr9wCQ=;
 b=fGgSx6gWIpwjZXN/Dg8NraII4EnglOHStBluP6FUrsM2lD/OmvEtCf2RRrLYGWlahzwwO
 xg8Ua+j3uweOS9csZI155/uI4DWdlwnd9fyqcdb8orq5PCYsEyY1lmOx4oq8zG3+DR1Aftd
 SfLdRYnSqyFMtlrJt0HPwAINVMg3Eao=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FB363E6A98
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 19:23:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 742513E21CD
 for <ltp@lists.linux.it>; Wed,  6 May 2026 19:22:45 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D5EA5200B03
 for <ltp@lists.linux.it>; Wed,  6 May 2026 19:22:44 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so788541f8f.0
 for <ltp@lists.linux.it>; Wed, 06 May 2026 10:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778088164; x=1778692964; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=KeZYULBY7mkghtJpFidG4D/u5C80ANoAnLA9HX+U0Ew=;
 b=GOeEPzjRCsvQrrEyhZ3Rtt7BAyXPawcTAQes6D4tG7CxKPQju6N86E0tAUy2Bz7wJo
 gf3hNMTxf7G1MXhtvOSvCTh+F8TJV2xYfCNELnjplxWivD03dOZB2eTc1UqrsmPHRVOR
 5LdU6ZzY7nIurQx91h7Djbu4tG/AUYWZgHMr/qs3nCzw9qHuWmQDYy95oLg3fLl3oIui
 Jp42JbnzUuinjSfWB22V5YgV158yQQ7mafvKkwgGmcXzM+gmX0td14osfvqZQpL4/vGk
 jpJEJR7j/HCneewZ1/osjYwKeJA+VHwxRvD3gzNBWrqrIQEIC8Sr3Yvmk8OLPJGkBAru
 pSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778088164; x=1778692964;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeZYULBY7mkghtJpFidG4D/u5C80ANoAnLA9HX+U0Ew=;
 b=jJGNYW45GPhZ3GmpSxLtx5aGToY+vqIQ3YeBWZXYC7qzKHVIw3aqOMeBbY6rDcbcSt
 sPMcUYHcAeBvb9Q5tXLx98TXI6SxQQalw0yP4VYU4d8pffXeffEZm9ZHhkP1p5vBvmxM
 xc7fal5cwADNKYFKDo30xJ4auVFTn+hE8durQhm5YrdZ681Me73JZ5qaEfh7iaVRMa1T
 jsRYOnqO3ois1l1YrzjS7mkufujBJCfBbCdOo6qN3K3bF9re1Z6m5bOq45FM0kB9w/cz
 3UKcmN4GXI8mpU7WC55Qcncq1RnBFTcJPi9VDF1ZuIlGERqyrm4i+NezNwb3JlGcBnQP
 B6PQ==
X-Gm-Message-State: AOJu0YwjPBwC1evGmFfhl0BjqqiRKgTV2ZwNlX1B5m/LZhHMj4oZxmRb
 ZWvAL5MFA1e7B6Dq0bfyGTHEDKLO3Wuy9hxSoNVN1R/MJzlBwTkHi9ppMj+P3L9NaNExM1is8LS
 SZKtQY2zImw==
X-Gm-Gg: AeBDietuBQHg2zcJsbN2Wed6pEFKukVjkF9xqs1+du+r+ZNfXt/reo4LtguOyPUKh5p
 HI3daZgql6jaI2FyKyeUPekQPrbNO103PS/n56SX5ezjiwE9p9Iwh8lpeYrWFzyt7Z5aAB0XVaS
 Ctg9VctpUY/6Iy+HQIRI5jPRFebqewl2FnnmnjWYb6UWt7KU8b/0WlQPXCruvzjCfC+aJ6QrMny
 FuPPZ7hEB9Mw6AZYQZZRQJccPEUJ6R7d/tpVpiLsObVcZq3KuzEMxMcGvnQ9YHyTrH+YE21ug2g
 XcTjS4JzDLIk8zaZql1y78234jc09RJFAx/xVynECSdv/qZoDi62RefwAVaPULtss1N4PfiN+E6
 7Y9Nw7JIjUd5pd45madKkDnaBJku2W556DbFY0BrWmm+WZrZejw+RHWf4qpQHOGGrOeg+GcRvuh
 1m2ybVDSGmq4wJPxC63OEVYVQH2SJCZLB7/Hn1QPpIVg4vfqixiUikAbJMJyD7SuojCPRQB/5ky
 4bSODhx0FCPrEfJRvPnplSP7oJQcXPDutsirH5l3AmfAw==
X-Received: by 2002:a5d:5d0b:0:b0:43d:7606:5a47 with SMTP id
 ffacd0b85a97d-4516247bc66mr7286470f8f.2.1778088164142; 
 Wed, 06 May 2026 10:22:44 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4511d8cd160sm9260628f8f.8.2026.05.06.10.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:22:43 -0700 (PDT)
Message-ID: <69fb78e3.5d0a0220.177bae.1b21@mx.google.com>
To: lepillai@linux.ibm.com
In-Reply-To: <20260410062407.2839810-1-lepillai@linux.ibm.com>
Date: Wed, 06 May 2026 17:22:43 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] growfiles:fix test failure due to missing
 directory /test/growfiles/reiser
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpvdXIgQWdlbnQgcmV2aWV3IHdhcyBtaXNzaW5nIGluIHRoZSBNTC4KSGVyZSBpdCBpcyB0
aGUgcmVzdWx0LCB3aGljaCBzZWVtcyBvaywgdW5sZXNzIHlvdSB3YW50IHRvCmFkZCBzb21lIG5v
dGVzIHRvIGl0LgoKT24gRnJpLCAxMCBBcHIgMjAyNiwgbGVrc2htaS1jcGlsbGFpIHdyb3RlOgo+
IGdyb3dmaWxlczpmaXggdGVzdCBmYWlsdXJlIGR1ZSB0byBtaXNzaW5nIGRpcmVjdG9yeSAvdGVz
dC9ncm93ZmlsZXMvcmVpc2VyCgpIaSBsZWtzaG1pLAoKPiAtVGhlIHRlc3QgYXR0ZW1wdHMgdG8g
Y3JlYXRlcyB0aGUgcmVxdWlyZWQgZGlyZWN0b3J5IHN0cnVjdHVyZSByZWN1cnNpdmVseSh3aGlj
aCB3YXMgbm90Cj4gaW4gY3VycmVudCBjb2RlKSxTZXRzIGFwcHJvcHJpYSB0ZSBwZXJtaXNzaW9u
cyAoMDc1NSlhbmQgIFZlcmlmaWVzIHRoZSBkaXJlY3RvcnkgaXMgYWNjZXNzaWJsZQoKVGhlIGJv
ZHkgb25seSBkZXNjcmliZXMgd2hhdCB3YXMgY2hhbmdlZCwgbm90IHdoeSB0aGUgZGlyZWN0b3J5
IGlzIG1pc3NpbmcgYXQKcnVudGltZS4gUGxlYXNlIGV4cGxhaW4gdGhlIHJvb3QgY2F1c2U6IHVu
ZGVyIHdoYXQgY29uZGl0aW9ucyBkb2VzIGdyb3dmaWxlcwplbmNvdW50ZXIgYSBwYXRoIHdob3Nl
IGludGVybWVkaWF0ZSBkaXJlY3RvcmllcyBkbyBub3QgZXhpc3QsIGFuZCB3aHkgaXMKL3Rlc3Qv
Z3Jvd2ZpbGVzL3JlaXNlciBzcGVjaWZpY2FsbHkgYWZmZWN0ZWQ/CgpUaGUgYm9keSBhbHNvIGhh
cyB0eXBvcyAoImFwcHJvcHJpYSB0ZSIg4oaSICJhcHByb3ByaWF0ZSIsICJhdHRlbXB0cyB0byBj
cmVhdGVzIgrihpIgImF0dGVtcHRzIHRvIGNyZWF0ZSIpIGFuZCB0aGUgc3ViamVjdCBpcyBtaXNz
aW5nIGEgc3BhY2UgYWZ0ZXIgdGhlIGNvbG9uCigiZ3Jvd2ZpbGVzOmZpeCIg4oaSICJncm93Zmls
ZXM6IGZpeCIpLgoKPiArCXN0cnVjdCBzdGF0IHN0Owo+IC4uLgo+ICsJCWlmIChzdGF0KHRtcCwg
JnN0KSA9PSAtMSkgewo+ICsJCQlpZiAobWtkaXIodG1wLCBtb2RlKSA9PSAtMSAmJiBlcnJubyAh
PSBFRVhJU1QpIHsKClRoZSBzdGF0KCkgcmVzdWx0IChzdCkgaXMgbmV2ZXIgcmVhZCDigJQgb25s
eSBpdHMgcmV0dXJuIHZhbHVlIGlzIHVzZWQuIERyb3AgdGhlCnN0YXQoKSBjYWxsIGFuZCBjYWxs
IG1rZGlyKCkgZGlyZWN0bHk7IHRyZWF0IEVFWElTVCBhcyBzdWNjZXNzLiBUaGlzIHNpbXBsaWZp
ZXMKdGhlIGNvZGUgYW5kIGF2b2lkcyBhIFRPQ1RPVSB3aW5kb3cgYmV0d2VlbiBzdGF0IGFuZCBt
a2Rpci4KClJlZ2FyZHMsCkxUUCBBSSBSZXZpZXdlcgoKLS0KQW5kcmVhIENlcnZlc2F0bwpTVVNF
IFFFIEF1dG9tYXRpb24gRW5naW5lZXIgTGludXgKYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
