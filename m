Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421C6C369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 08:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744793596; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=MDZtgJei/eBZeeV2MidwagxKaN4K488XEAnX8y+Gd0Y=;
 b=SMqUPHLlGrRbIUlveNKRiDsR1zVEU3TooZvx59aE6EiEus40g4748bd18BH0zLOlzYm22
 4mELFxza1oiB9Kzc0c/48hHjFp9CXBtieaVBtsJfnTa5MmToMUf71AOc6dM27PDcOWnTg3H
 On4UEH0YIq+40LT1s/KDqirVeW8zneU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5E013CB957
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 10:53:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF5D93C0EF7
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 10:52:55 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 455531A0090D
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 10:52:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744793572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7XQk7w3VEfsfO9RfqirgTSUQi6Q5m55a+cpB45IwLPw=;
 b=DwSinkvOOkvNfzh6kDn5eaMJhI6oIf1nm0Gsdit/+XtUGXteeqtb5rU4lW8i++JxlzDwvY
 anrM1iNTywFmmptlX/KwEo30Sj5Um9DA8WW0P8VzVXUytK8QDIkh7HcS8LrMg0Vc5mdlKn
 yS5rRMRzjLg8LOkAma1zmBkKeqv1Pho=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-bp886yXjNzu0OnKtxcinOg-1; Wed, 16 Apr 2025 04:52:50 -0400
X-MC-Unique: bp886yXjNzu0OnKtxcinOg-1
X-Mimecast-MFC-AGG-ID: bp886yXjNzu0OnKtxcinOg_1744793569
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3011bee1751so5541896a91.1
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 01:52:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744793569; x=1745398369;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7XQk7w3VEfsfO9RfqirgTSUQi6Q5m55a+cpB45IwLPw=;
 b=mJ1iu+9YOY/aUoq8E6r6opOdh7crT53H/GSDcAGemIVKk/8bwyU8mn40PJnQNxwRts
 ni54h3l/KPvSYvKcMkkIiXXtmTC4PA44crjxadbxCDfxZHbeef6/w2QoKW97GRugPj6v
 unf0RMheFhsKU/gzldLv1yFiYppF+CN/8cOoBnqt1o6vFwsoyEbPIeF4zUcMnuCTs2n/
 16IliDZrjqdD1Dl/992Q0SEDgs8n9vLKD/6CAi98HW0vsFAWyM3MnzhHsHxWtgU4jxS+
 rwvYhluXghh2Ru3Y17etdnTjfig88ysBCskT4Oaiin5TrcwQfeEFFaroS9ww7tn494a9
 raeg==
X-Gm-Message-State: AOJu0YydATl+UVA8shFWwTMiGeDzd8SAdS6V1X17xpJ1BpH2l/SnixqG
 Hz0ARrlAgKBAK4O2l8Ai7z68it41H6h0CzNRhDSuCVnWc0z0xP2mLVkai5/OyRDQ7x4mvlkj+7y
 eaqihtBtGBrNaS9z5MVGoL5ZOtzxlwNUYkCns+OH6zu5PQDtNPYDRa9g7ZEm/rBH/FDrf08FU2T
 SAQyfqrHIiEYA6oR9GIUiHJ9I=
X-Gm-Gg: ASbGncuDZ2jW60u7xT4eC2nm7Bu8fehMCPYdZL+W4/2Vuj4FExpMtOm0YxzhXFQaAf1
 7QbpRSpjXAAKnhh5bnUDh39YGC1Mpc2FUeyl9amynJvv2kvOH3AqnZYo3nWETmhO/WKyJAw==
X-Received: by 2002:a17:90b:3909:b0:2fa:1f1b:3db2 with SMTP id
 98e67ed59e1d1-30864167fa3mr1472774a91.25.1744793568989; 
 Wed, 16 Apr 2025 01:52:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz0OUPrB/FkkN/MAwwn9dGSZ39x9MRoSbsrNr25cdTHLdNCl6iGojBD2hjBJ7r5115VjOvdWXID6tIFuL9LDA=
X-Received: by 2002:a17:90b:3909:b0:2fa:1f1b:3db2 with SMTP id
 98e67ed59e1d1-30864167fa3mr1472744a91.25.1744793568539; Wed, 16 Apr 2025
 01:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250416072113.573818-1-pvorel@suse.cz>
 <CAEemH2e3XLZmS0aO4rRZPQ+qV+QOCvbtLWxngMY2so5gSnZpag@mail.gmail.com>
 <20250416084057.GB577362@pevik>
In-Reply-To: <20250416084057.GB577362@pevik>
Date: Wed, 16 Apr 2025 16:52:36 +0800
X-Gm-Features: ATxdqUFnrT9v_Y258lzRCRuFUGSAQaElpEf05b1G1dnBt9uqzo1HjtHxNY4u6uM
Message-ID: <CAEemH2ea7+wA4Tbs1eiGw8hwnbqC2-tPeOi+FKNrHFOQ27ZT_A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JpsbwyZ5201p8UKqH_5pAbH2PsDGvvpyR2TA-LEYnVA_1744793569
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] cgroup_lib.sh: Improve error messages
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBBcHIgMTYsIDIwMjUgYXQgNDo0MeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250
cm9sbGVycy9jZ3JvdXBfbGliLnNoCj4gPiA+IEBAIC0xMTksMTIgKzExOSwxMiBAQCBjZ3JvdXBf
cmVxdWlyZSgpCj4gPiA+ICAgICAgICAgcmV0PSQ/Cj4KPiA+ID4gICAgICAgICBpZiBbICRyZXQg
LWVxIDMyIF07IHRoZW4KPiA+ID4gLSAgICAgICAgICAgICAgIHRzdF9icmsgVENPTkYgIid0c3Rf
Y2djdGwgcmVxdWlyZScgZXhpdGVkLiBDb250cm9sbGVyCj4gaXMKPiA+ID4gcHJvYmFibHkgbm90
IGF2YWlsYWJsZT8iCj4gPiA+ICsgICAgICAgICAgICAgICB0c3RfYnJrIFRDT05GICIndHN0X2Nn
Y3RsIHJlcXVpcmUgJGN0cmwnIGV4aXRlZC4gJGN0cmwKPiA+ID4gY29udHJvbGxlciBub3QgYXZh
aWxhYmxlPyIKPgo+Cj4gPiBzL2V4aXRlZC9leGlzdGVkCj4KPiBJIHVuZGVyc3Rvb2QgdGhhdCAi
ZXhpdGVkIiB3aGljaCB3YXMgdXNlZCBwcmV2aW91c2x5IHdhcyBtZWFudCB0byBiZQo+ICJleGl0
ZWQKPiB3aXRoIG5vbi16ZXJvIiAoSSBjYW4gaW1wcm92ZSBpdCB0aGlzIHdheSB0byBiZSBtb3Jl
IHByZWNpc2UpLiBEbyB5b3UKPiByZWFsbHkKPiB0aGluayBpdCdzIGluIFRDT05GIHJlbGF0ZWQg
dG8gY29udHJvbGxlciBleGlzdGVkPyAgSSBhY3R1YWxseSBtZWFuIHRoZQo+IG9wcG9zaXRlCj4g
LSBvbmUgd2FudHMgY29udHJvbGxlciB3aGljaCBkb2VzIG5vdCBleGlzdCBkdWUgbm90IGNvbmZp
Z3VyZWQgaW4gdGhlCj4ga2VybmVsLgo+CgpBaCwgeW91J3JlIHJpZ2h0LCBJIHdhcyBibGluZCB0
byByZWFkIHRoYXQuCk1heWJlIEkgc3BlbnQgdG9vIG11Y2ggdGltZSBsb29raW5nIGF0IHNjcmVl
bnMgdG9kYXk6KS4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
