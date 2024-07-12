Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87318C2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 07:31:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCB723D198D
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 09:31:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 098F83CB579
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 09:31:20 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 55A671002034
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 09:31:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720769478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b3+heFOCvpMVL0mr1eVMnMqiJ9f33nC1UylPhUPvlHk=;
 b=RnOEFnde7IOKYscwwrRrAf9IM9fYEW1gc0FZQ1CumwGlyYn12G5krgLGUgFjW1Ujr571/U
 u9qHGzMlia/vLdLGmNLJR9HBNOV1XazZpB+RH2MUMsvVUjWVDIKmL71J4vH51adsUr/IcJ
 swGJkWJBmtTe32s+k0dYwbFuiMvCEjs=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-A3c7v_LiPjqGuFMGN7cDsQ-1; Fri, 12 Jul 2024 03:31:15 -0400
X-MC-Unique: A3c7v_LiPjqGuFMGN7cDsQ-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5c69368a760so1350413eaf.1
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 00:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720769475; x=1721374275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3+heFOCvpMVL0mr1eVMnMqiJ9f33nC1UylPhUPvlHk=;
 b=pehG/WWCBPZrQi02jFX9V0I+/C/o3v1tKMTpFbXncnYLhts2OQgq6Pac01koBAtlEu
 cY2OT+DsOHYgdJ6PGsN+msBHOup5XkYDthPHU1av+lHs8F9hjuu6rJAfLGKFfphtrXZP
 WjHZrrs9V8lv72eM0/betFwNtnfuAQYN158hSCRjPzI30W6CV9/YgwvVvODBFEZWHpTk
 1h8lrPZOHCYEBzZuuRU6/YOxbUiQMhyGlQV6SykiI7UuvwZIZoGnWvivx9qaWXByGd81
 tb5w1dZ3seNGyCUv1eL0KqEY4AuTirSmkIqgfQjOPjCC+2y/GsqpOXGOYd+UH6+Ojqj+
 2/TQ==
X-Gm-Message-State: AOJu0Yw33Q5Phb3dMlvP7hyX6FKn18ss/cZfrv/BCXMVHiZTz0iS3m23
 SLU0Y/+0788GkKLRDiTSS2kGWoQFch4FZENnEn+joOPVT1tpHM3fXdNMLBWLnPk/K6aAks7nP1u
 gwxC2mX6hk7rexwb4adM26PfIvDRxMIrLnZmUca5qqdku0tQlOb/nnOudrXLJoeOPxL7V3F9S+3
 Ld8u+h1R8auYd7qREFQLGiXxE=
X-Received: by 2002:a05:6870:7185:b0:25e:1e11:aa4a with SMTP id
 586e51a60fabf-25eaebfa1a0mr8306263fac.45.1720769475201; 
 Fri, 12 Jul 2024 00:31:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqXbXNPZi3Vdl/v1P64XLkZYFGQg97nFm3zDJdSPIIUHcvzk88uo9WqZXursWsBezGxTMW9BsJVxwEXUHjy+M=
X-Received: by 2002:a05:6870:7185:b0:25e:1e11:aa4a with SMTP id
 586e51a60fabf-25eaebfa1a0mr8306252fac.45.1720769474794; Fri, 12 Jul 2024
 00:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <09c8813ad86c4a8034e3e35a183355c4f887f1b4.1720527432.git.jstancek@redhat.com>
 <Zo6oO7qukDzxqDXO@yuki>
In-Reply-To: <Zo6oO7qukDzxqDXO@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 12 Jul 2024 09:30:57 +0200
Message-ID: <CAASaF6y7Rc=Yt8QQ-V5vax4NntbBAz+B6av_G_YpfS4OjWaJwA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kallsyms: skip user-space mapped addresses
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
Cc: liwan@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKdWwgMTAsIDIwMjQgYXQgNToyN+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gK3N0YXRpYyBpbnQgaXNfYWRkcmVzc19tYXBwZWQo
dW5zaWduZWQgbG9uZyBhZGRyKQo+ID4gK3sKPiA+ICsgICAgIGludCBpOwo+ID4gKwo+ID4gKyAg
ICAgZm9yIChpID0gMDsgaSA8IHJhbmdlc19sZW47IGkrKykgewo+ID4gKyAgICAgICAgICAgICBp
ZiAocmFuZ2VzW2kqMl0gPD0gYWRkciAmJiBhZGRyIDwgcmFuZ2VzW2kqMiArIDFdKQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiAxOwo+ID4gKyAgICAgfQo+ID4gKyAgICAgcmV0dXJu
IDA7Cj4gPiArfQo+Cj4gSSB3b3VsZCBwdXQgdGhlIHJhbmdlcyBpbnRvIGFuIGFycmF5IG9mIHN0
cnVjdHVyZXMgc28gdGhhdCB3ZSBoYXZlIGEKPiBzbGlnaHRseSBtb3JlIHJlYWRhYmxlIGNvZGUs
IGUuZy4KPgo+ICAgICAgICAgaWYgKHJhbmdlc1tpXS5zdGFydCA8PSBhZGRyICYmIGFkZHIgPCBy
YW5nZXNbaV0uZW5kKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gMTsKPgo+IEFuZCB0aGUgMiAq
IHdvdWxkIHZhbmlzaCBmcm9tIG1vc3Qgb2YgdGhlIHBsYWNlcyBpbiB0aGUgY29kZSB0aGF0IHJl
YWRzCj4gdGhlIG1hcHMgYXMgd2VsbC4uLgo+Cj4gQnV0IG90aGVyd2lzZSB0aGUgY29kZSBsb29r
cyBnb29kLgo+Cj4gUmV2aWV3ZWQtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PgoK
UHVzaGVkIHdpdGggU0FGRV9SRUFMTE9DIGFuZCBzdHJ1Y3QgdG8gaG9sZCBtYXBwZWQgYWRkcmVz
c2VzLgoKVGhhbmtzLApKYW4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
