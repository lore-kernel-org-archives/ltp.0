Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4C3C02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 12:11:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D2183C7BDE
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 13:11:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7FF53C7BCF
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 13:11:03 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 13F96618E6A
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 13:11:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737029461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ra+MMyEl3atspt2bzvv5iDDS+CKfjn2oHfK37gfTqgo=;
 b=cSOAeVWZEU5BYBrmJgGqFW4k5rrcKM9PsW+FY9It4kOHk2oXDGrd4jzo59S2qWFK3/pcHL
 5Ppaohide3K0lL2EKyZ1UuhBAxiUlGDKT8IBtQYVCA8F3tX++KMBSoLPMl+lDtgt4HKhHC
 XY7LzqcUSWH6qeK8qp/Zqxl6q8MdDJk=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-CgF15UH2MgycJ_TM5X960g-1; Thu, 16 Jan 2025 07:10:57 -0500
X-MC-Unique: CgF15UH2MgycJ_TM5X960g-1
X-Mimecast-MFC-AGG-ID: CgF15UH2MgycJ_TM5X960g
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2f5538a2356so1853774a91.2
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 04:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737029456; x=1737634256;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ra+MMyEl3atspt2bzvv5iDDS+CKfjn2oHfK37gfTqgo=;
 b=dMgMZy1lxlIzZiFT6zUBCw47oveAGL92mCRCSKD02+h4+nC+n/793tT4mS42AyPnpv
 ikDRFWKuFd2BwdC2Q1Klbe7MB6qB8LAMb9RGqF12UGqoB+9g+89/awJaV7OAM2Mpz9hD
 1rLByBgmv/CsSifNxWBKEWIO2ijljm3wHOHJEr2CcQKimubrEAFv7Hlj8nw7uPz3pe+T
 DBD4LfBsTM3UbOy2TtDhqcCnDo40YlvHwVrdWcg2rvqquy08aqoFiLhQLCuxSjgyk6Za
 9hT40F5KWHoE8OIjoLCd7kIWPOJcdYDQlfcBVxZ5OICSWhe1CmrHvyVjqyc/aNpIVGv6
 Qgdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ7CvD5AklRGaORSmTaXb9UrqpCd6U42JQYPtX+dmO907Tha8a0YS8R/sn1yQDOWTxNY4=@lists.linux.it
X-Gm-Message-State: AOJu0YzrkMeu9X/UTbg8VSF10OHeAd2THyP3rqRrtdiCzg3crhstRKO+
 CnxrK3zum2Rdh4LxjwyvKYu7o2/fbYOFziBfGGxzCan8IYYXq3LfKqtmpa4ZwLqcxDJhJii8lqo
 tcGXP+QxjvwpGous4v3+az/WaEBEzesUkAxVVnnSHcLhku4imElj2iiNH5llxLb9eJBe8Z4Ju5F
 rqcJ6uvcgp2AOch4htpP+9DX4=
X-Gm-Gg: ASbGnctpTLncvpK8RlAUc4d8xRTXjmSrgEB0FxYTaaHpLwswAd+iuYv2npWl9t1gAxA
 Cbdfa2lAjphDuXwwfvVhpOss3oOjeOd8+3Kkxl+o=
X-Received: by 2002:a17:90b:4d05:b0:2ee:599e:f411 with SMTP id
 98e67ed59e1d1-2f548f7d21dmr40757572a91.34.1737029456023; 
 Thu, 16 Jan 2025 04:10:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGASKxYVCISQkXuYhFXhIG8+2o0ajBOXrAxq2HJTFx6uybP3hhDPkZeNkG125XeKVEOPDXBJdj6vsqAvwJot5g=
X-Received: by 2002:a17:90b:4d05:b0:2ee:599e:f411 with SMTP id
 98e67ed59e1d1-2f548f7d21dmr40757440a91.34.1737029454191; Thu, 16 Jan 2025
 04:10:54 -0800 (PST)
MIME-Version: 1.0
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250115224154.GA664782@pevik>
 <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
 <20250116083812.GB670376@pevik>
In-Reply-To: <20250116083812.GB670376@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 16 Jan 2025 20:10:42 +0800
X-Gm-Features: AbW1kvbYjM2YgmBCD5Ie8-lhANsDclCT388sWQAt_g5IS19hCWvpfknW-KoLqbU
Message-ID: <CAEemH2d6RJ8yd4TcLt-z49fmNKt7eAGg=VhdASkNtE=7cR7bgg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 35EOXNAaOLSda2TuPXfNQ8O-ZrwN56sTcTv7_JQbgzY_1737029456
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [REGRESSION] Broken tests using tst_net.sh by 893ca0abe7
 (was: [PATCH 1/2] lib: multiply the timeout if detect slow kconfigs)
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gMTYsIDIwMjUgYXQgNDozOOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gLi4uCj4gPiA+IGluaXRfbHRwX25ldHNwYWNlKCkKPiA+ID4gewo+ID4g
PiAgICAgICAgIC4uLgo+ID4gPiAgICAgICAgICAgICAgICAgcGlkPSIkKFJPRCB0c3RfbnNfY3Jl
YXRlIG5ldCxtbnQpIgo+ID4gPiAgICAgICAgIC4uLgo+ID4gPiAgICAgICAgIGV4cG9ydCBMVFBf
TkVUTlM9IiR7TFRQX05FVE5TOi10c3RfbnNfZXhlYyAkcGlkIG5ldCxtbnR9Igo+Cj4gPiA+IEkg
d2lsbCBwcm9iYWJseSBzb2x2ZSBpdCBieSBhZGRpbmcgeWV0IGFub3RoZXIgcGFyYW1ldGVyIHRv
Cj4gPiA+IHRzdF9yaG9zdF9ydW4oKSwKPiA+ID4gd2hpY2ggaWdub3JlcyBzdGRlcnIgYW5kIHVz
ZSBpdCBmb3IgdHN0X25zX3tjcmVhdGUsZXhlY30uIEJ1dCBtYXliZQo+IHRoZXJlCj4gPiA+IGlz
Cj4gPiA+IGFub3RoZXIgc29sdXRpb24gKG9yIGFub3RoZXIgcHJvYmxlbSkuCj4KPgo+ID4gT3Is
IGFub3RoZXIgd2F5IGlzIGp1c3QgdG8gc2V0ICd0c3RfdGVzdC0+dGltZW91dCA9PQo+IFRTVF9V
TkxJTUlURURfVElNRU9VVCcKPiA+IGluIHRob3NlIHRlc3RjYXNlL2xpYiB0b29scy4KPgo+IE9y
LCB3ZSBjb3VsZCBoYXZlIHlldCBhbm90aGVyIGZsYWcgVFNUX1NLSVBfU0xPV19ERVRFQ1RJT04g
d2hpY2ggY291bGQgYmUKPiB1c2VkCj4gZm9yIHRoZXNlIHRvb2xzLgo+CgpTb3VuZHMgYmV0dGVy
LiBCdXQgbWF5YmUgbmFtZSBpdCBUU1RfTk9fU0xPV19DT05GSUdfQ0hFQ0sgPwoKZGlmZiAtLWdp
dCBhL2xpYi90c3RfdGVzdC5jIGIvbGliL3RzdF90ZXN0LmMKaW5kZXggYjIwNGFkOTc1Li4xZTk1
MDRmMjkgMTAwNjQ0Ci0tLSBhL2xpYi90c3RfdGVzdC5jCisrKyBiL2xpYi90c3RfdGVzdC5jCkBA
IC0xNzAyLDggKzE3MDIsMTAgQEAgdW5zaWduZWQgaW50IHRzdF9tdWx0aXBseV90aW1lb3V0KHVu
c2lnbmVkIGludAp0aW1lb3V0KQogICAgICAgIGlmICh0aW1lb3V0IDwgMSkKICAgICAgICAgICAg
ICAgIHRzdF9icmsoVEJST0ssICJ0aW1lb3V0IG11c3QgdG8gYmUgPj0gMSEgKCVkKSIsIHRpbWVv
dXQpOwoKKyNpZm5kZWYgVFNUX05PX1NMT1dfQ09ORklHX0NIRUNLCiAgICAgICAgaWYgKHRzdF9o
YXNfc2xvd19rY29uZmlnKCkpCiAgICAgICAgICAgICAgICB0aW1lb3V0ICo9IDQ7CisjZW5kaWYK
CiAgICAgICAgcmV0dXJuIHRpbWVvdXQgKiB0aW1lb3V0X211bDsKIH0KZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9saWIvdHN0X25zX2V4ZWMuYyBiL3Rlc3RjYXNlcy9saWIvdHN0X25zX2V4ZWMuYwpp
bmRleCA2YThlMzkzMzkuLmExYjc4MGFiNyAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2xpYi90c3Rf
bnNfZXhlYy5jCisrKyBiL3Rlc3RjYXNlcy9saWIvdHN0X25zX2V4ZWMuYwpAQCAtMTQsNiArMTQs
NyBAQAogICovCgogI2RlZmluZSBUU1RfTk9fREVGQVVMVF9NQUlOCisjZGVmaW5lIFRTVF9OT19T
TE9XX0NPTkZJR19DSEVDSwoKICNpbmNsdWRlIDxzdGRpby5oPgogI2luY2x1ZGUgPHN5cy93YWl0
Lmg+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
