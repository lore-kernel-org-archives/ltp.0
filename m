Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A10FC83F09
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 13:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752066989; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=WfXH0uncmaWNSNH7nMdgrE4JerzcMY5Hfn5GlrzK9Lo=;
 b=b4DqEQF9LAvBAWhOjYq3iyTvBRJVE+B2PP3c16pBQ/yO5ZE1DgpcrkKel0ouBWSIxULa9
 NnA4yTHRIwpspFCQG2bs29xDxzxmeeBL0J+hcdxO5z1lgJh7FefJgMVbP2BpXLLS3/WNxP2
 lugzFYX9lWc4IPCmKMOYloMiJ4eKmTg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE7103CAC66
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 15:16:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A4943C8C3D
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 15:16:10 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C13C860924F
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 15:16:09 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a582e09144so3563619f8f.1
 for <ltp@lists.linux.it>; Wed, 09 Jul 2025 06:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752066969; x=1752671769; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0d5A0yuuXM7EMADrR58qIARRgInFDMsRvwpbs+yKo7A=;
 b=BLKRR+A27y/mcl+6UB5iazQkswknJIUSkkJIYbC+Uz82AWhoY4Qu/s0CLhF8C2WOB6
 zu5avncWlEFdVoh/m3LQ9v3attouDW/OfY0/oZgrB3Y7tz47Lyg1cdk07vcZmqZKeITc
 EtSO/NwPnmra6PsDGVd9N0+hQcvk9ycpU+31XyczFVs58A6pfYNAyLrx+MVdWsYV6zl+
 2AE6qYgSf8RDpWDrZpHRmeH4krikCxfW+/87BQSAoAG43l0t+78yd2p7Zs33drdKFCoO
 dOcDpJsG3i387edsLPxUa0by/+nT0zWnbEYVXUY/IAsYnDezGWiyWjCxn7al9SqdsbWe
 k5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752066969; x=1752671769;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0d5A0yuuXM7EMADrR58qIARRgInFDMsRvwpbs+yKo7A=;
 b=QEMRRCOzGoJTImQugw59HwSCQxmUcwRR4TCQ10ZjWAB78QXFmPKaIMbUA89GhtEv0K
 pE5seDh73B+8CXETLNZLfxeOUSYK4OprimLEVWGzzx8NXgb/sdlyftNijbwQvPElvLeb
 X0eu7S9G5KjRFehLGpO1/D/J3qjt7/NLgdeHHTUu0Q5ywYfe7GTPjJ/G27YFlQPwrmmQ
 vvZnZkaocfB9L6zvAIzqAnkD/8RcsPHD1F9FHMo3msuHhseSZdoxR4EQc8aWDyTkWUne
 LL7POyOROB8gPumyirF/QtvR2OFD7Q4OclfbyFJG//W1x2080t71pPN5+hulrENppO5k
 IBXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsTzqCbUHGiStvx5zFYm9YlkZcyv5yfy+gmj4Y/d5i0JqmfK1NIDbYCMzebYa3o4whN6Q=@lists.linux.it
X-Gm-Message-State: AOJu0YzodRRfmQsx4sismryp/06CTGImrBDPi9yDZGSnwXr9AmO9HZ/u
 Y4mZK14Jh9k35pWviRNfqrooxijaaAQvoLfNatvL/z62l6T0k6A9fkoYida3DCVAFimyxH8tAAw
 XeT9eZ8OEQA==
X-Gm-Gg: ASbGnctpzAmpCVvMm1H/HVEjXY9XdILX1H4hd0frfNESSJn11ts2YUWei3QaUXDjFkn
 ix8/MSQxh60MjLaTt+H25F/N0OdlCsdyebOb4ocjZSM4BnnH9EKOLk9Y/f7I4AdaPSgSDs9xrcp
 f8FWsu8EzJdHIdNvVYp8BEIBC052OyQoBuuB1FwY3Ix5c9/V7cRO1WzYQgV7bReoTujqx3vtGjN
 8iPehdXOTAAC8dWqv20MZ6A0U51p9n/F7PWAjQRKa4jaIDI5yuFihdqG5+4y3eNZY0Ong4RRlUE
 QTEXyqsT1x14KMX9P0tKpni5ZREE/DLd8vc27YA+ENUfZNuNZFf2LyYokH0/J1RJkANIWeHo19+
 kd64O/w2Uq49BYOvnjteI6Ta7ed4iu1EPnDcM0dUQHriBi3tOdsKcoQgP88d2gjyfKbC3/lbchE
 n2eIOQWeOp9mirkHqIE0JwZfOzBA==
X-Google-Smtp-Source: AGHT+IEk+W1HfERIo782+5s+7cZebRRgZeCIy8V7qtIPhO6lVhtAlp+PrgTnPWj7DKvjRw+1qyhfzw==
X-Received: by 2002:a05:6000:2213:b0:3a5:3b63:58f0 with SMTP id
 ffacd0b85a97d-3b5e45150e2mr2055902f8f.18.1752066969142; 
 Wed, 09 Jul 2025 06:16:09 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c301d9e07sm2139535a91.43.2025.07.09.06.16.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 06:16:08 -0700 (PDT)
Message-ID: <456d5d63-737f-441e-bc3f-4fa012983264@suse.com>
Date: Wed, 9 Jul 2025 15:16:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250708-conversions-mremap-v1-0-aa043b0182fc@suse.com>
 <20250708-conversions-mremap-v1-2-aa043b0182fc@suse.com>
Content-Language: en-US
In-Reply-To: <20250708-conversions-mremap-v1-2-aa043b0182fc@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/7] lib: safe_macros: Add SAFE_MREMAP
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiA3LzgvMjUgMTA6MTEgUE0sIFJpY2FyZG8gQi4gTWFybGnDqHJlIHZpYSBsdHAgd3Jv
dGU6Cj4gRnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gLS0tCj4gICBp
bmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmggIHwgIDIgKysKPiAgIGluY2x1ZGUvdHN0X3NhZmVfbWFj
cm9zLmggfCAgNCArKysrCj4gICBsaWIvc2FmZV9tYWNyb3MuYyAgICAgICAgIHwgMTYgKysrKysr
KysrKysrKysrKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25zKCspCj4KPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9zYWZlX21hY3Jvc19mbi5oIGIvaW5jbHVkZS9zYWZlX21hY3Jvc19m
bi5oCj4gaW5kZXggZDI1NjA5MWI3NmFkMTBiMDZiMjllM2ZkNWZhZDg4NTNmYWExNGMwOC4uNDg5
MjcwNmZhMzExYWUyMzEzMWNkMWJhM2QzNmU4ZWIzMjU3ZDljNCAxMDA2NDQKPiAtLS0gYS9pbmNs
dWRlL3NhZmVfbWFjcm9zX2ZuLmgKPiArKysgYi9pbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmgKPiBA
QCAtNjksNiArNjksOCBAQCBpbnQgc2FmZV9ta2Rpcihjb25zdCBjaGFyICpmaWxlLCBjb25zdCBp
bnQgbGluZW5vLAo+ICAgaW50IHNhZmVfcm1kaXIoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50
IGxpbmVubywKPiAgICAgICAgICAgICAgICAgIHZvaWQgKCpjbGVhbnVwX2ZuKSh2b2lkKSwgY29u
c3QgY2hhciAqcGF0aG5hbWUpOwo+ICAgCj4gK3ZvaWQqIHNhZmVfbXJlbWFwKGNvbnN0IGNoYXIg
KmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIHZvaWQgKCpjbGVhbnVwX2ZuKSh2b2lkKSwKPiArCQl2
b2lkICpvbGRfYWRkcmVzcywgc2l6ZV90IG9sZF9zaXplLCBzaXplX3QgbmV3X3NpemUsIGludCBm
bGFncyk7Cj4gICAKPiAgIGludCBzYWZlX211bm1hcChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBp
bnQgbGluZW5vLAo+ICAgICAgICAgICAgICAgICAgIHZvaWQgKCpjbGVhbnVwX2ZuKSh2b2lkKSwg
dm9pZCAqYWRkciwgc2l6ZV90IGxlbmd0aCk7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHN0X3Nh
ZmVfbWFjcm9zLmggYi9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oCj4gaW5kZXggMTk1MDRiZWI1
N2FkMzc5YzgzNWExM2VkNWQzNWZlMDZlNDJhNmVkNi4uOWNhNzAzMTlmMDg2ZGVhNDM3NDY3Yzc3
NWRkOWNiNDhiOTU2NTgzZSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5o
Cj4gKysrIGIvaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaAo+IEBAIC05Myw2ICs5MywxMCBAQCB2
b2lkICpzYWZlX3JlYWxsb2MoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgdm9p
ZCAqcHRyLCBzaXplX3Qgc2l6ZSk7Cj4gICAjZGVmaW5lIFNBRkVfUk1ESVIocGF0aG5hbWUpIFwK
PiAgIAlzYWZlX3JtZGlyKF9fRklMRV9fLCBfX0xJTkVfXywgTlVMTCwgKHBhdGhuYW1lKSkKPiAg
IAo+ICsjZGVmaW5lIFNBRkVfTVJFTUFQKG9sZF9hZGRyZXNzLCBvbGRfc2l6ZSwgbmV3X3NpemUs
IGZsYWdzKSAgICAgICAgICAgICAgXAo+ICsJc2FmZV9tcmVtYXAoX19GSUxFX18sIF9fTElORV9f
LCBOVUxMLCAob2xkX2FkZHJlc3MpLCAob2xkX3NpemUpLCBcCj4gKwkJICAgIChuZXdfc2l6ZSks
IChmbGFncykpCj4gKwo+ICAgI2RlZmluZSBTQUZFX01VTk1BUChhZGRyLCBsZW5ndGgpIFwKPiAg
IAlzYWZlX211bm1hcChfX0ZJTEVfXywgX19MSU5FX18sIE5VTEwsIChhZGRyKSwgKGxlbmd0aCkp
Cj4gICAKPiBkaWZmIC0tZ2l0IGEvbGliL3NhZmVfbWFjcm9zLmMgYi9saWIvc2FmZV9tYWNyb3Mu
Ywo+IGluZGV4IDU3YmMwYmM3NDk3MTJmMWI4OTA1OTQxMjNiNmI5ZjNjYWJjZTgyMWEuLjRiYjRj
NzAwZjFkMjVlOTUyMGUzZDVhMmY5OTY5YmZlY2FmZDI1Y2MgMTAwNjQ0Cj4gLS0tIGEvbGliL3Nh
ZmVfbWFjcm9zLmMKPiArKysgYi9saWIvc2FmZV9tYWNyb3MuYwo+IEBAIC0yMTUsNiArMjE1LDIy
IEBAIGludCBzYWZlX3JtZGlyKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIHZv
aWQgKCpjbGVhbnVwX2ZuKSAodm9pZCksCj4gICAJcmV0dXJuIChydmFsKTsKPiAgIH0KPiAgIAo+
ICt2b2lkICpzYWZlX21yZW1hcChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBpbnQgbGluZW5vLCB2
b2lkICgqY2xlYW51cF9mbikodm9pZCksCj4gKwkJdm9pZCAqb2xkX2FkZHJlc3MsIHNpemVfdCBv
bGRfc2l6ZSwgc2l6ZV90IG5ld19zaXplLCBpbnQgZmxhZ3MpCj4gK3sKPiArCXZvaWQgKnJ2YWw7
Cj4gKwo+ICsJcnZhbCA9IG1yZW1hcChvbGRfYWRkcmVzcywgb2xkX3NpemUsIG5ld19zaXplLCBm
bGFncyk7Cj4gKwo+ICsJaWYgKHJ2YWwgPT0gTUFQX0ZBSUxFRCkgewo+ICsJCXRzdF9icmttXyhm
aWxlLCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5PLCBjbGVhbnVwX2ZuLAo+ICsJCQkgICJtcmVtYXAo
JXAsJXp1LCV6dSwlZCkgZmFpbGVkIiwgb2xkX2FkZHJlc3MsIG9sZF9zaXplLAo+ICsJCQkgIG5l
d19zaXplLCBmbGFncyk7Cj4gKwl9CkhlcmUgd2UgY2FuIGhhbmRsZSBhbHNvIHVuZXhwZWN0ZWQg
cmV0dXJuIHZhbHVlcy4gUGxlYXNlIGNoZWNrIHNhZmVfbXVubWFwKCkKPiArCj4gKwlyZXR1cm4g
cnZhbDsKPiArfQo+ICsKPiAgIGludCBzYWZlX211bm1hcChjb25zdCBjaGFyICpmaWxlLCBjb25z
dCBpbnQgbGluZW5vLCB2b2lkICgqY2xlYW51cF9mbikgKHZvaWQpLAo+ICAgICAgICAgICAgICAg
ICAgIHZvaWQgKmFkZHIsIHNpemVfdCBsZW5ndGgpCj4gICB7Cj4KLSBBbmRyZWEKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
