Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22520C5B549
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749047340; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=CYB7PyUecQPD8uOXkpL0jYPbAFhMFhIqEpPvARMfjp4=;
 b=GF1udWl6n7JTuJj33OMcMR/BKbI4Wf8AFO2yyDjY5xs0Yx30YxXk50rkkkH6a9J0zOMW5
 aWiwCpgBfsEKYZuzYHqdtRMvfgXnL/cY84rC5kXzT3MbFtOWtTjJI3TcAKvdXM5spIq/uNY
 F2N22eNa7SlQLFqby0HqrAZiXyuoKzw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78B073CA167
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 16:29:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2344B3CA10E
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 16:28:38 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F3F0814002D5
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 16:28:37 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a4fdc27c4aso2700430f8f.3
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 07:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749047317; x=1749652117; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HN79ALm6PDPClW5wuaq9yavwfGE6V7VFkz9zzj0YbGE=;
 b=Lzq81EPM9Wrm8BPYucpTyH5XpDS4her+LI6Fl/mWZeCpUIRBaO1ZfFD93dvhToNOJZ
 m09Cs6xeSh5AKhRSDGcXTmc/afQJ1x8bch1+domGKpGNtiVTkQVtOAo7O3TyregKIUIO
 botcVDLmwLz8soM43LlBFWln6SMLUBBrcr3vDXTCOwXaZ3g39dHxE3kJNJVX12SsnXdW
 PTl7CL0gIASFsfq+KgnwtgAvznNngX2/j6+pizxkZiUq1Am9H1l3WeI8oPnvuv3G4861
 m8ISc8SmcGWRf6TTuW08B5QCM27NW/ePdY/6d4zgxhe/LQ9eS0boYEGcV7R+cN6PGXcr
 qpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749047317; x=1749652117;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HN79ALm6PDPClW5wuaq9yavwfGE6V7VFkz9zzj0YbGE=;
 b=SdmZOWvexcGpa7J/04V/NUGFwFgG64bB+wq+1kVm+SGycxSi3Ica41B29XOz4wq335
 TFV/vF/r2jeLHjuiUfJhu1nTSwkh3Yt1Dz86T1QDfHiyMvGBEEQbPbWw/ZdZwjdByVWG
 V3VnC84SdfJi8BzryjtvBPqT68DtWqCosA2sqBBg621pNjrWHGScXGRuT6BOpNK8S38b
 w3U+SqepEu/5aGpq5kHe6WqG2aQk5LOxVydpYZ9/0f62Ee9VpiGG2y0hvt/FyN5zsBH/
 ijH/pHAkMCDlYfjOScVPa7pTTbauNXl0g6yWBfKV90jtCuqapQmkbkwnOnDvPqUjLTkj
 go3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW92QwpTSnEd7c8TDbALQMnoHqzsp1MFVngwDtt7F4nQjydpbre8a7QIqb+MGm4NR+ocvM=@lists.linux.it
X-Gm-Message-State: AOJu0YwbMLZmt+SWVBakG5viEAr5D8+YVD2KkwicBCrcVYBgbH2eUSql
 /z7iuoj0cl3A6uxr11/oSz1k6uzCItHfaPJ0foNMnzIK1+oovBn+r0nLgarWDyvrrqU=
X-Gm-Gg: ASbGncuUUjCT+sWAME+Kt/nmmaTUkJKS4MSZGEc8BG2SyQZS7jUL+bUbGEVhTlJDunP
 DX+yKu/HNfF1fxxnSEXNBvWvAJSuby27newirIrYgJTXKcrS4oDW4jyyRctmzUUF8RXk/NBtx6G
 mOehuCc24myXabCx2q+ty7KjcRwxC3hTrGl2RAxe4duo3M87bJFQuCpZLjjneRq8+tSHnyRIGwv
 FWyzABn46NoCfyOvoGugb1qYvX6sHEo44oCqXjzz+Pi6ztmRFCRHJoi8Y3Biw2tTa8Um6pFqW6a
 iIyK5OOVGJAs8IBERye/UwnesYsXyskGL6iig9rfRR13EvChew==
X-Google-Smtp-Source: AGHT+IH9xJsK4g87Dk6kRaLb4LDynqK5rILkgoS32P2ytneMrNUvHwjYOWTi029va5rSD8xG/WCwgw==
X-Received: by 2002:a05:6000:2dc7:b0:3a4:eecd:f4d2 with SMTP id
 ffacd0b85a97d-3a51d9617b4mr2748662f8f.38.1749047317290; 
 Wed, 04 Jun 2025 07:28:37 -0700 (PDT)
Received: from localhost ([189.99.237.136])
 by smtp.gmail.com with UTF8SMTPSA id
 ada2fe7eead31-4e6444644aesm10618525137.7.2025.06.04.07.28.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 07:28:36 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 04 Jun 2025 11:28:31 -0300
Message-Id: <DADTIYJ0FQ6F.3F6GE53G04H5M@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>, <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250604-lsm_fix_attr_is_overset-v1-1-46ff86423a14@suse.com>
In-Reply-To: <20250604-lsm_fix_attr_is_overset-v1-1-46ff86423a14@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lsm: fix overset attr test
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkIEp1biA0LCAyMDI1IGF0IDEwOjQwIEFNIC0wMywgQW5kcmVhIENlcnZlc2F0byB3cm90
ZToKPiBGcm9tOiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+
Cj4gTFNNKHMpIHVzdWFsbHkgaGFuZGxlIHRoZWlyIG93biBpbnRlcm5hbCBlcnJvcnMgaW4gYSBk
aWZmZXJlbnQgd2F5LAo+IHNvIHRoZSByaWdodCB3YXkgdG8gY2hlY2sgaWYgdGhleSByZXR1cm4g
ZXJyb3IsIGlzIHRvIHZlcmlmeSB0aGF0IHRoZQo+IGNvbW1vbiByZXR1cm4gdmFsdWUgaXMgLTEu
IFRoaXMgaXMgdGhlIG1heCB3ZSBjYW4gZG8sIHNpbmNlIGVycm5vIG1pZ2h0Cj4gdmFyeSBhY2Nv
cmRpbmcgdG8gdGhlIExTTSBpbXBsZW1lbnRhdGlvbi4KPgo+IFNpZ25lZC1vZmYtYnk6IEFuZHJl
YSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4gLS0tCj4gVGhpcyBwYXRj
aCB3aWxsIGZpeCBhbGwgZmFsc2UgcG9zaXRpdmUgZXJyb3JzLCB3aGVyZSBMU00ocykgbWlnaHQK
PiBiZSBpbXBsZW1lbnRlZCBpbiBhIGRpZmZlcmVudCB3YXkuIFdlIGp1c3Qgc2tpcCBlcnJubyBj
aGVjay4KPgo+IFRoaXMgd2lsbCBhbHNvIGZpeDoKPiBodHRwczovL29wZW5xYS5vcGVuc3VzZS5v
cmcvdGVzdHMvNTA4Nzg5MyNzdGVwL2xzbV9zZXRfc2VsZl9hdHRyMDEvOAoKUmV2aWV3ZWQtYnk6
IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cgo+IC0tLQo+ICB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2xzbS9sc21fc2V0X3NlbGZfYXR0cjAxLmMgfCAxMyArKysrLS0tLS0t
LS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sc20vbHNtX3NldF9zZWxm
X2F0dHIwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sc20vbHNtX3NldF9zZWxmX2F0
dHIwMS5jCj4gaW5kZXggY2FjY2RkYTdlY2YyZWRhYWMxZmE4ZTJkYzJjY2RkMGFmZjAyMDgwNC4u
ZjUzNzY4ZTIzNzM2NDQxNWQxYmQxNWNkMzY1M2MyNGFhYzY1MzQ0MSAxMDA2NDQKPiAtLS0gYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xzbS9sc21fc2V0X3NlbGZfYXR0cjAxLmMKPiArKysg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xzbS9sc21fc2V0X3NlbGZfYXR0cjAxLmMKPiBA
QCAtMzAsMjEgKzMwLDE4IEBAIHN0YXRpYyBzdHJ1Y3QgdGNhc2Ugewo+ICAJCS5hdHRyID0gTFNN
X0FUVFJfQ1VSUkVOVCwKPiAgCQkuY3R4ID0gJmN0eF9udWxsLAo+ICAJCS5zaXplID0gJmN0eF9z
aXplLAo+IC0JCS5leHBfZXJybm8gPSBFRkFVTFQsCj4gIAkJLm1zZyA9ICJjdHggaXMgTlVMTCIs
Cj4gIAl9LAo+ICAJewo+ICAJCS5hdHRyID0gTFNNX0FUVFJfQ1VSUkVOVCwKPiAgCQkuY3R4ID0g
JmN0eCwKPiAgCQkuc2l6ZSA9ICZjdHhfc2l6ZV9zbWFsbCwKPiAtCQkuZXhwX2Vycm5vID0gRUlO
VkFMLAo+ICAJCS5tc2cgPSAic2l6ZSBpcyB0b28gc21hbGwiLAo+ICAJfSwKPiAgCXsKPiAgCQku
YXR0ciA9IExTTV9BVFRSX0NVUlJFTlQsCj4gIAkJLmN0eCA9ICZjdHgsCj4gIAkJLnNpemUgPSAm
Y3R4X3NpemVfYmlnLAo+IC0JCS5leHBfZXJybm8gPSBFMkJJRywKPiAgCQkubXNnID0gInNpemUg
aXMgdG9vIGJpZyIsCj4gIAl9LAo+ICAJewo+IEBAIC01MiwxNCArNDksMTIgQEAgc3RhdGljIHN0
cnVjdCB0Y2FzZSB7Cj4gIAkJLmN0eCA9ICZjdHgsCj4gIAkJLnNpemUgPSAmY3R4X3NpemUsCj4g
IAkJLmZsYWdzID0gMSwKPiAtCQkuZXhwX2Vycm5vID0gRUlOVkFMLAo+ICAJCS5tc2cgPSAiZmxh
Z3MgbXVzdCBiZSB6ZXJvIiwKPiAgCX0sCj4gIAl7Cj4gLQkJLmF0dHIgPSBMU01fQVRUUl9DVVJS
RU5UIHwgTFNNX0FUVFJfRVhFQywKPiArCQkuYXR0ciA9IExTTV9BVFRSX0NVUlJFTlQgfCBMU01f
QVRUUl9QUkVWLAo+ICAJCS5jdHggPSAmY3R4LAo+ICAJCS5zaXplID0gJmN0eF9zaXplLAo+IC0J
CS5leHBfZXJybm8gPSBFSU5WQUwsCj4gIAkJLm1zZyA9ICJhdHRyIGlzIG92ZXJzZXQiLAo+ICAJ
fQo+ICB9Owo+IEBAIC03Nyw5ICs3Miw5IEBAIHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQg
bikKPiAgCWN0eF9zaXplX3NtYWxsID0gMTsKPiAgCWN0eF9zaXplX2JpZyA9IGN0eF9zaXplICsg
MTsKPiAgCj4gLQlUU1RfRVhQX0ZBSUwobHNtX3NldF9zZWxmX2F0dHIodGMtPmF0dHIsICp0Yy0+
Y3R4LCAqdGMtPnNpemUsIHRjLT5mbGFncyksCj4gLQkgICAgICB0Yy0+ZXhwX2Vycm5vLAo+IC0J
ICAgICAgIiVzIiwgdGMtPm1zZyk7Cj4gKwlUU1RfRVhQX0VYUFIobHNtX3NldF9zZWxmX2F0dHIo
Cj4gKwkJdGMtPmF0dHIsICp0Yy0+Y3R4LCAqdGMtPnNpemUsIHRjLT5mbGFncykgPT0gLTEsCj4g
KwkJIiVzIiwgdGMtPm1zZyk7Cj4gIH0KPiAgCj4gIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4K
PiAtLS0KPiBiYXNlLWNvbW1pdDogM2VmNGJhYzFkZDI1MzYyOGRmZGI4YTgyM2I1MWFlMGQyNGZh
MDYxNgo+IGNoYW5nZS1pZDogMjAyNTA2MDQtbHNtX2ZpeF9hdHRyX2lzX292ZXJzZXQtMTMyYzQ0
ZjEwNzY3Cj4KPiBCZXN0IHJlZ2FyZHMsCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
