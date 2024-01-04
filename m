Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECDBC47074
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 11:56:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB5703CE716
	for <ltp@archiver.kernel.org>; Thu,  4 Jan 2024 12:56:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B1DA3CD2B8
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 12:56:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4EEB1100094B
 for <ltp@lists.linux.it>; Thu,  4 Jan 2024 12:56:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704369367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YVHCTOOrC6nx0tZdoUnpfLKqfIORs/DoRUEsp1tgtrI=;
 b=SIy+QsUyrMoSQ7NP3aRU9bXmTFyvwOV9qwoeb529DnLt/g+9K93I+jDpeT9N46mkBFjS3B
 +5OaMbPGuFp2zXh6A7SizLedAzegJEkFANoRhzpxAbChCwWYMKfpGXaaHRV/sohwV3Lfw/
 DTyaiE+/yCjD+jftG9Gy8TqkCMystf8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-10MyhMfVOLO7rrcR21HQOw-1; Thu, 04 Jan 2024 06:56:00 -0500
X-MC-Unique: 10MyhMfVOLO7rrcR21HQOw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2cce73a3b5bso3677031fa.0
 for <ltp@lists.linux.it>; Thu, 04 Jan 2024 03:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704369359; x=1704974159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YVHCTOOrC6nx0tZdoUnpfLKqfIORs/DoRUEsp1tgtrI=;
 b=QbE7SlX5QDv+239WfpNoegn7gE7ze5uK8atqK9lKO312yVdVFiouGjUjW2hH8Z1bcS
 2Qd5Ro1kpHritxuo5aAA7spuCPl8f7gbxOlMYDS/fc2CxIFq6QZrh2hDIKqYYbTiyuB5
 2mcXrk3EmuJF0ruIf+hOEpL/hf+HtSqLMbSkdq/zz7WvoQU+VK3pWCzaQYddXqSA9nG/
 pAqn5WtRFDzJ49VzsXGJ5Vde1Tq1Gb1B2UPmgIXggvY8vuX8lSc6hj4PSqBJ89mpkr7n
 DB2Bu21+87i52FMLFGYwxz5Oqf8P9zpxJ69wI+8+U6CqpcmS1rEg4EZqfBlp7LyBZ8fT
 oXiQ==
X-Gm-Message-State: AOJu0YxgnPaVTK/GZDgHaiIIuENO7Vdhfj/4wmeyB/Ks1nAxQ8j9n8GN
 MSoHrrYH2HDOstnvF4b/3laeeAdOA8ULNizg084zWi0xMaTGHoVXlGsFE82+39400McyEmqmmJA
 XnXJ/UFYnVnU4mtF7UV8QBwB63OcliOqSUAs=
X-Received: by 2002:a2e:888a:0:b0:2cc:f41d:9304 with SMTP id
 k10-20020a2e888a000000b002ccf41d9304mr313835lji.90.1704369359194; 
 Thu, 04 Jan 2024 03:55:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN9xEldut0W1ARat0HBSPPYeKMDDGXPPmYefXDDb2PNjDJCbK0fhMGAR6IZa8peGIFDPvqHLMmFJHzF9TjFGQ=
X-Received: by 2002:a2e:888a:0:b0:2cc:f41d:9304 with SMTP id
 k10-20020a2e888a000000b002ccf41d9304mr313831lji.90.1704369358906; Thu, 04 Jan
 2024 03:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20231214151954.840244-1-pvorel@suse.cz>
 <20231214151954.840244-10-pvorel@suse.cz>
 <20240104113642.GA1149671@pevik>
In-Reply-To: <20240104113642.GA1149671@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jan 2024 19:55:47 +0800
Message-ID: <CAEemH2fwu+LSBrsQh6x6C-QsOLJ5O33xMYHG7wjbiPfN4D=fMw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 09/10] lib: Add support for TDEBUG tst_res()
 flag
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

T24gVGh1LCBKYW4gNCwgMjAyNCBhdCA3OjM34oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBhbGwsCj4KPiA+IFRvIHByaW50IG1vcmUgdmVyYm9zZSBpbmZvLiBC
eSBkZWZhdWx0IGl0J3Mgb2ZmLCBwcmludGluZyBlbmFibGVkIHdpdGgKPiA+IC1EIG9wdGlvbiBv
ciBUU1RfRU5BQkxFX0RFQlVHPTEuCj4KPiAuLi4KPiA+IGRpZmYgLS1naXQgYS9kb2MvQy1UZXN0
LUFQSS5hc2NpaWRvYyBiL2RvYy9DLVRlc3QtQVBJLmFzY2lpZG9jCj4gLi4uCj4gPiArfCAnVElO
Rk8nICB8IEdlbmVyYWwgbWVzc2FnZS4KPiA+ICt8ICdUREVCVUcnIHwgRGVidWcgbWVzc2FnZSAo
bmV3IEMgQVBJIG9ubHksIHByaW50ZWQgd2l0aCAnLUQnIG9yIHZpYQo+ICdUU1RfRU5BQkxFX0RF
QlVHPTEnIG9yICd5Jwo+ID4gKyAgICAgICAgICAgICBlbnZpcm9ubWVudCB2YXJpYWJsZSksIG9u
bHkgZm9yIG1lc3NhZ2VzIHdoaWNoIHdvdWxkIGJlCj4gdG9vIHZlcmJvc2UgZm9yIG5vcm1hbCBy
dW4uCj4gLi4uCj4gPiArKysgYi9kb2MvVXNlci1HdWlkZWxpbmVzLmFzY2lpZG9jCj4gPiBAQCAt
NDEsNiArNDEsNyBAQCBGb3IgcnVubmluZyBMVFAgbmV0d29yayB0ZXN0cyBzZWUKPiBgdGVzdGNh
c2VzL25ldHdvcmsvUkVBRE1FLm1kYC4KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFu
ZCBvdGhlcnMsIHdoaWNoIGltcGx5IGl0LCBzaGVsbDoKPiAnVFNUX05FRURTX1RNUERJUj0xJyku
Cj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBNdXN0IGJlIGFuIGFic29sdXRlIHBhdGgg
KGRlZmF1bHQ6ICcvdG1wJykuCj4gPiAgfCAnVFNUX05PX0NMRUFOVVAnICAgICAgfCBEaXNhYmxl
IHJ1bm5pbmcgdGVzdCBjbGVhbnVwIChkZWZpbmVkIGluCj4gJ1RTVF9DTEVBTlVQJykuCj4gPiAr
fCAnVFNUX0VOQUJMRV9ERUJVRycgICAgfCBFbmFibGUgZGVidWcgaW5mbyAodmFsdWUgJ3knIG9y
ICcxJykuCj4KPiBUaGlzIGhhcyBiZWVuIG1lcmdlZC4gQnV0IEkgbm93IHdvbmRlciwgaWYgdGhp
cyB3b3VsZCBiZSBiZXR0ZXIgd2l0aCBMVFBfCj4gcHJlZml4LCBlLmcuIExUUF9FTkFCTEVfREVC
VUcsIGJlY2F1c2UgaXQncyBhIHZhcmlhYmxlIHdoaWNoIGlzIGRlZmluZWQgYnkKPiBMVFAKPiB1
c2VyLiBXRFlUPwo+CgorMSBmb3IgTFRQX0VOQUJMRV9ERUJVRwoKR29vZCBwb2ludCwgYXMgaXQg
aXMgZGVzaWduZWQgZm9yIHRoZSB3aG9sZSBMVFAgdGVzdCwgc28gdGhlIGZpcnN0CmxldmVsIHNo
b3VsZCBiZSBtb3JlIHByb3Blci4gU2ltaWxhcnkgd2l0aCBMVFBfUlVOVElNRV9NVUwuCgoKPiBU
aGlzIG1pZ2h0IGJlIGFsc28gY2FzZSBmb3IgVFNUX05PX0NMRUFOVVAsIGJ1dCBpdCdzIHJhcmVs
eSB1c2VkLCB0aHVzIG15Cj4gY29uY2VybiBpcyBtb3JlIGFib3V0IExUUF9FTkFCTEVfREVCVUcu
Cj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
