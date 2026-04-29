Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D29EFF8864
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:33:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4512B3E28C0
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:33:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E75333CA6DC
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:33:21 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id ECD1B601926
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:33:15 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50e63771d91so110008131cf.0
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 00:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777447995; x=1778052795; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+VlCl07V9/Ht0oJhsLCIjqxiORDxVBiu/UU3zDZHPjk=;
 b=gpejEGaTGghEbMcTfDz5ceBqf3zjxFGsbXpTZneDsi/lGypkSfgiZ9IkXOlR0+rpX/
 QDFUcXieHVs4FaFXKDIj3ChYb2+7DMGWr2pqbzH80QuJqsP07a02Pbr/Cky5GbHpLM7y
 Le3rScEZtDtA2fonizZ9pHxBvO89ndBEFawCJZY+k8vjKy7DYdH87GQc18ZuGIlEEUmb
 N7dUYlwIrXjdPomz+aLbzuF4Sebi2fo82cU9NyyN134x5MeqV492K4L+Okk+pHx26cqi
 p5XTHvRIr77vilxn0KRMZI4ZYoYN5nO+zw0FhCdfJPbsqOsMz+G4odGGsEtCDmbFxOVr
 6yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777447995; x=1778052795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+VlCl07V9/Ht0oJhsLCIjqxiORDxVBiu/UU3zDZHPjk=;
 b=A96Vj+JUbvCEfxZPoP5JJ023sRBMVfXrvzPVVpxJFdXMbZt2RSgXyAv5hBVAgyNU61
 HH7noa0fdi9LVtLD0SaSrjDt8blipaTPW2I19OTE0zjcuBd3U41n35qpNcDaEB1taTxy
 gTIgvse1jWEWK++KW2OFJCC6kWktvEKow6sN0oN/5IZaVmeJ7teZevc8KypffZcGmo8D
 liVMkiBdjmytlNMPZ6dPFRmFweExYmwgaHyPLyXJMCuAeCOu1XL6YVEhwcNGH+4QaWkr
 U/DXpYQB/KyV2JaEz6dDx3Z67asfdhX9MvUJNQcp33agr6qE4n7smehP0gE817xDMgWS
 7xZQ==
X-Gm-Message-State: AOJu0YyH/0kT/V7cvAWOdE01692VfDDwZFcSMbXIT6eQ34gYG5ciCOOx
 Hs5/9/bmaYWqE7CTLlUroFBvcLpMhxkrjWjRJ3dDBufMqUI73cxIOTNx
X-Gm-Gg: AeBDievn9wALg1rA8hUXrPQoysWbMlIK6a77YqKqnWB5G8YkIfvAtjWtJK7lic6CNZR
 T237JxuyIqF/Sq3yNCsu2SBH/ZRQclFvxMmJOfOj4jl1bkQ3+KWsqU7hTcoHKy4jDyP/xPaOvVm
 O1sMm+aOPHfx4k/Gh2KKulY8nU3g99Jx2aqzUjHJO1wVgDrPhxaXR/fy3D4c6sJJsEuLEQevBk4
 2t7Fjjl53zENV9B/kFKXH+/ib5Qeshq6RjL3x6b26fD3h6fBE6Mr+QNGBkgJ8BVX1Tm5/KDYKWf
 5f76ahb9GAdyaEadrNC5OBQQ0gl6IlqClIie6o3Wad+uc35XYsfWfE9h6SRHAEWrhd0oK37Rklu
 iCsxOurCYMwuhlM6lFyDy3Lkujkhz1X6yE/VoDjo8RfvkHOrrfzQTVw39t5H9YViDbj+Ykpt4nY
 7p67KXAx6Mng0tCFV+IKo+TaKFgEcEwXShQT2pueITBCyT9D5pqkz6acwazOPXBj5dNtuKwoUj5
 xdnvX+45nFHMumjfUl/PQQ7s+5wzbJr8D/USgPuJFxgAUDB7SM9TyoZpd6zlQ==
X-Received: by 2002:ac8:5f85:0:b0:50d:a1c4:e154 with SMTP id
 d75a77b69052e-5100e19a1b9mr88528941cf.36.1777447994588; 
 Wed, 29 Apr 2026 00:33:14 -0700 (PDT)
Received: from
 runnervmeorf1.ilqebtjoo3redgtn5bhhrwy0we.ex.internal.cloudapp.net
 ([135.232.185.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5101ae3cf8fsm10974561cf.17.2026.04.29.00.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 00:33:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: priyama2 <priyama2@linux.ibm.com>
Date: Wed, 29 Apr 2026 07:33:13 +0000
Message-ID: <20260429073313.4011-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430154852.896072-1-priyama2@linux.ibm.com>
References: <20260430154852.896072-1-priyama2@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] testcases/nvme: Add NVMe device discovery and
 identification test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUHJpeWEsCgpPbiBUaHUsIDMwIEFwciAyMDI2IDE1OjQ4OjUyICswMDAwLCBwcml5YW1hMiB3
cm90ZToKPiB0ZXN0Y2FzZXMvbnZtZTogQWRkIE5WTWUgZGV2aWNlIGRpc2NvdmVyeSBhbmQgaWRl
bnRpZmljYXRpb24gdGVzdAo+Cj4gVGhpcyB0ZXN0IHZlcmlmaWVzIE5WTWUgZGV2aWNlIGRpc2Nv
dmVyeSBhbmQgaWRlbnRpZmljYXRpb24gYnk6Cj4gLSBEZXRlY3RpbmcgTlZNZSBjb250cm9sbGVy
cyBpbiAvZGV2Cj4gWy4uLl0KClRoZSBjb21taXQgYm9keSBkZXNjcmliZXMgd2hhdCB0aGUgdGVz
dCBkb2VzIGJ1dCBub3Qgd2h5IGl0IGlzIG5lZWRlZCDigJQKd2hhdCBjb3ZlcmFnZSBnYXAgZG9l
cyB0aGlzIGZpbGw/IEFsc28sICJDaGFuZ2VzIGluIHYyOiIgYmVsb25ncyBpbiB0aGUKY292ZXIg
bGV0dGVyLCBub3QgdGhlIGNvbW1pdCBib2R5OyBzdHJpcCBpdCBiZWZvcmUgc2VuZGluZy4KCj4g
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9kZXZpY2UtZHJpdmVycy9udm1lL252bWUwMQo+IG5ldyBm
aWxlIG1vZGUgMTAwNzU1Cj4gIEJpbiAwIC0+IDk5NTUzNiBieXRlcwoKRG8gbm90IGNvbW1pdCBj
b21waWxlZCBiaW5hcmllcy4gUmVtb3ZlIG52bWUwMSBmcm9tIHRoZSBwYXRjaCBhbmQgYWRkIGEK
LmdpdGlnbm9yZSBpbiB0aGUgdGVzdCBkaXJlY3RvcnkgbGlzdGluZyBpdC4KCj4gKyAqIENvcHly
aWdodCAoYykgMjAyNCBJQk0gQ29ycG9yYXRpb24KClRoaXMgZmlsZSBpcyBuZXcgYW5kIGFkZGVk
IGluIDIwMjY7IHVzZSB0aGUgY3VycmVudCB5ZWFyLgoKPiArc3RhdGljIGludCBudm1lX2Rldmlj
ZV9mb3VuZDsKPiArc3RhdGljIGNoYXIgbnZtZV9kZXZfbmFtZVsyNTZdOwoKVGhlc2Ugc3RhdGlj
cyBhcmUgc2V0IGluIGNhc2UgMCBvZiBydW4oKSBidXQgbmV2ZXIgY2xlYXJlZC4gV2l0aCAtaSwK
c3RhbGUgc3RhdGUgZnJvbSBhIHByaW9yIGl0ZXJhdGlvbiBwZXJzaXN0cyBpbnRvIHN1YnNlcXVl
bnQgb25lcy4gUmVzZXQKdGhlbSBhdCB0aGUgdG9wIG9mIHJ1bigpLgoKPiArCS5uZWVkc19yb290
ID0gMSwKCk5vIG9wZXJhdGlvbiBpbiB0aGlzIHRlc3QgcmVxdWlyZXMgcm9vdC4gQWxsIHJlYWRz
IGZyb20gL2RldiBhbmQgc3lzZnMKYXJlIGFjY2Vzc2libGUgdG8gdW5wcml2aWxlZ2VkIHVzZXJz
LiBEcm9wIG5lZWRzX3Jvb3QuCgpUaGUgcGF0Y2ggaXMgYWxzbyBtaXNzaW5nIGEgcnVudGVzdCBl
bnRyeSAoZS5nLiBpbiBydW50ZXN0L2RyaXZlcnMpIGFuZAphIC5naXRpZ25vcmUgZW50cnkgZm9y
IHRoZSBudm1lMDEgYmluYXJ5LgoKLS0tCk5vdGU6CgpPdXIgYWdlbnQgY29tcGxldGVkIHRoZSBy
ZXZpZXcgb2YgdGhlIHBhdGNoLgoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxz
ZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5
b3UgZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWls
IG9yIGlnbm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
