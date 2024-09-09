Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542F0ECE57B
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 08:16:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A21F83C1014
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 10:16:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F10B33C0FA4
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:16:04 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3BB5E200AD1
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 10:16:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725869762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eaQgEW9kY4UTF4MqiPxJFuSu+kfBxWADYqwDfDWjG68=;
 b=Wb6sSxYr3Q9iQepvAZZ7ibZoL3Vv+RJGRTvvXxz146m3ux8qaNpPaF0xUvwyRsCk7mGmqS
 4Coh7oMzJ7cTrNVzkrRFVjZ/ay1yQTFOs4wBc1DsQgIGFIqJGrhiBbJb1qzYd1Sz2MoiRq
 57nYdm87iTnWywuBSsh4IaeEe/S4g18=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-rN2oK2-2NVaScTr__tdvMQ-1; Mon, 09 Sep 2024 04:16:00 -0400
X-MC-Unique: rN2oK2-2NVaScTr__tdvMQ-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-7b696999c65so2991732a12.3
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 01:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725869760; x=1726474560;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eaQgEW9kY4UTF4MqiPxJFuSu+kfBxWADYqwDfDWjG68=;
 b=UlLz4TC/FK9lXd9y4/+gU/xqYRWWIYfQo6lLqVCZbuSxaWsr454e/XdWrkH6YvxbZ8
 vz6TqY8CARWQXA7XvAoO9NafAQKinzH5JKYHvUDP5Abu97KuAMmMMzpsbo4vkQIUquvu
 koriU9EP2o2u4iGQdZLacbA/njdiNG0ZnmfTLF74DubUf1VY/WS+l+X4DEvPeXXr9xlg
 IWtyDQBTmC5thqPUAx+mqfhVlwrHbHj8rjyTjhhlmMaX1eG+O9CaCVRlCd0XEORZe1b/
 M5M4rCS93xlEdJeuC9An4ikSziX4Nemm5EkbIWNVpujw2vs589nMjUpvaczn0FEWeeUZ
 CObg==
X-Gm-Message-State: AOJu0YwOtFfJ1MLGecHSaiLX6NoUAigFNaB8Nub5OXFaeUeyYN/90Xly
 docAjn5gaAnXsCHA82ZgV1grTI+ZPgsWTNHgX9Vyy7a0l5srp1yVEmmgfLHbvXwEtMkTOANkFok
 bspefZCF6soHBrmsuTQmEbPRIj2Qec5J0JSaKHCLbSoqPcupNC/KBw25L95jjYNDgu79D4W8/sU
 E41vwiuNevabt/qzeKaz7v1W4=
X-Received: by 2002:a05:6a20:d50f:b0:1cf:334d:ffae with SMTP id
 adf61e73a8af0-1cf334e0977mr3785843637.32.1725869759732; 
 Mon, 09 Sep 2024 01:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUuQkhug+2JNbejLOJg/mYSZhiG9yL+HeXgxlmQb4l82/vCud5zcg61Tt4pEn0LFOQ2MXzkcgtEBoO1dBC81Y=
X-Received: by 2002:a05:6a20:d50f:b0:1cf:334d:ffae with SMTP id
 adf61e73a8af0-1cf334e0977mr3785826637.32.1725869759343; Mon, 09 Sep 2024
 01:15:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725601646.git.nirjhar@linux.ibm.com>
 <5488fdbd9f26f1826fb083cfdbc357ac9ca954a4.1725601646.git.nirjhar@linux.ibm.com>
In-Reply-To: <5488fdbd9f26f1826fb083cfdbc357ac9ca954a4.1725601646.git.nirjhar@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 9 Sep 2024 16:15:47 +0800
Message-ID: <CAEemH2fA45AyuvP=w=YG3A3yB5cdWxzE6J1NbJvBbaVXH9SRPA@mail.gmail.com>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1 1/1] syscalls/<delete, init,
 finit>_module: Rename /proc/dummy to module specific path name
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBTZXAgOSwgMjAyNCBhdCAzOjUx4oCvUE0gTmlyamhhciBSb3kgPG5pcmpoYXJAbGlu
dXguaWJtLmNvbT4gd3JvdGU6Cgo+IFRlc3RzIGluIHN5c2NhbGxzL2RlbGV0ZV9tb2R1bGUvLCBz
eXNjYWxscy9pbml0X21vZHVsZSBhbmQKPiBzeXNjYWxscy9maW5pdF9tb2R1bGUgdXNlIGtlcm5l
bAo+IG1vZHVsZXMgYWxsIG9mIHdoaWNoIGNyZWF0ZSBhIC9wcm9jL2R1bW15IG5vZGUuIFdoZW4g
dGhlc2UgdGVzdHMgcnVuIGluCj4gcGFycmFsZWwsIHRoZXJlIGFwcGVhcnMKPiB0byBiZSBhIHNp
dHVhdGlvbiB3aGVyZSB0aGVzZSB0ZXN0cyBzaW11bGF0ZW5vdXNseSB0cmllcyB0byBjcmVhdGUK
PiAvcHJvYy9kdW1teSBub2RlLiBUaGlzIGdlbmVyYXRlcwo+IGEga2VybmVsIHdhcm5pbmcgInBy
b2NfZGlyX2VudHJ5ICcvcHJvYy9kdW1teScgYWxyZWFkeSByZWdpc3RlcmVkIi4KPiBUaGlzIHBh
dGNoIHJlbmFtZXMgdGhlIC9wcm9jL2R1bW15IG5vZGUgdG8gbW9kdWxlIHNwZWNpZmljIG5hbWUg
aW4gb3JkZXIKPiB0byBhdm9pZCB0aGUgY29uZmxpY3QuCj4KPiBTaWduZWQtb2ZmLWJ5OiBOaXJq
aGFyIFJveSA8bmlyamhhckBsaW51eC5pYm0uY29tPgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8
bGl3YW5nQHJlZGhhdC5jb20+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
