Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07480C4345F
	for <ltp@archiver.kernel.org>; Sat, 27 Apr 2024 04:15:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2001D3D039F
	for <ltp@archiver.kernel.org>; Sat, 27 Apr 2024 06:15:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B85E3CC614
 for <ltp@lists.linux.it>; Sat, 27 Apr 2024 06:15:33 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1135E1A00CA1
 for <ltp@lists.linux.it>; Sat, 27 Apr 2024 06:15:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714191331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pvaa/2iWrIIivSF5E5QRNgoWkY5BtTlibq6xLDoDKGI=;
 b=N1vdjE0yoXFneklm+ZJqdiF60iCinPOwgwA0WxdS4nwS5ca735xbb7IR2Eb/oTsnXNAB3c
 zmm5Fdyo7EmVsKEqhOP2YypKMr3lOi6XOTe+ckrLSsVilrYe56u7w2vgRsTJ77dWSxl/eF
 xatrd4ySFY6ym8akHVdYRpSugYfjAbM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-mDfVcYFFPfGkQgA_4GigXQ-1; Sat, 27 Apr 2024 00:15:27 -0400
X-MC-Unique: mDfVcYFFPfGkQgA_4GigXQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ae9176fa73so2863864a91.2
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 21:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714191326; x=1714796126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pvaa/2iWrIIivSF5E5QRNgoWkY5BtTlibq6xLDoDKGI=;
 b=Z25mkARusWEMm5X/Fj8W0txnRysoCPZ8nIU+Ni5NmWHCdV+sVk554CryZGYJjX4oRp
 /8+7xKzo75QKonhiY+A2ChtEtg4ePQNrD8xqyYAwJHu/CNyf967Ec1OahfishpvxCdwS
 wHPI8ehuA8wGrw/jP09Hdv7oJECQPkO5ch+rAtca5vY2UAK1iqRGGxha+J8Z47fIt3VQ
 5yxTxNDUxGv0mxITwboVQEalUilbWS2YGVebI4sJc4OFjkvU08sGAJkko6zgpg2W9Bhl
 y26kig+WQ/9wgvHNlaNzsBtaK4EHAT81BdtZWY/ek6mZRoHcZpNmdho2OQ0470jz7ybi
 Biwg==
X-Gm-Message-State: AOJu0Yyvls13xSNfx1yQhvGdTD9Schwq2nDYs1RInoLkQ+RmxT4UFaMt
 JvEjkgjx/q1HZHXiwA3aKoRs06VV7XAMjRdE0r/kc521F/8Uhlx/bDU4UYA+lqJxzIPXaqmsqc0
 0FMw5BkcyU1ZllwnqkShX1vebh0Dz4nhSgAqcrv2eMU0y/pYKR+QUg/QAY/fCqoqCJ6waPLBoH2
 YRHnt1sdMHphstxo88Utn0ElA=
X-Received: by 2002:a17:90b:8ce:b0:2af:5b90:c7f5 with SMTP id
 ds14-20020a17090b08ce00b002af5b90c7f5mr4079723pjb.3.1714191326542; 
 Fri, 26 Apr 2024 21:15:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEVGBQE6SQ8yR3TqWsAmUuY9H7uUinWbEMPwZbi557ucNlvv2d79MYUYy4x/04wVEF4/hvHe1HF8aU1cIRv+Q=
X-Received: by 2002:a17:90b:8ce:b0:2af:5b90:c7f5 with SMTP id
 ds14-20020a17090b08ce00b002af5b90c7f5mr4079717pjb.3.1714191326113; Fri, 26
 Apr 2024 21:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <Zitm2aUAcydofMlF@yuki>
In-Reply-To: <Zitm2aUAcydofMlF@yuki>
From: Li Wang <liwang@redhat.com>
Date: Sat, 27 Apr 2024 12:15:14 +0800
Message-ID: <CAEemH2ehzsYrnQKhfZXWCAx6MyrjFMSgPJDnNqie7GTYrYq9wA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP Release planning
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

T24gRnJpLCBBcHIgMjYsIDIwMjQgYXQgNDozNOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gQXMgdXN1YWxsIHdlIGFyZSBzdXBwb3NlZCB0byBwcm9k
dWNlIGEgcmVsZWFzZSBhdCB0aGUgZW5kIG9mIHRoZSBuZXh0Cj4gbW9udGgsIHNvIGxldCBtZSBz
dGFydCB3aXRoIHRoZSBjYWxsIGZvciBwYXRjaGVzIHRoYXQgc2hvdWxkIGJlCj4gaW5jbHVkZWQu
IEkgZG8gcGxhbiB0byBsb29rIGF0IHRoZSBwYXRjaHdvcmsgbmV4dCB3ZWVrIGFuZCB0cnkgdG8g
cmV2aWV3Cj4gYW5kIG1lcmdlIGFzIG11Y2ggYXMgcG9zc2libGUsIGhvd2V2ZXIgaWYgdGhlcmUg
aXMgYW55dGhpbmcgdGhhdCBJCj4gc2hvdWxkbid0IHJlYWxseSBtaXNzLCBwbGVhc2UgbGV0IG1l
IGtub3cuCj4KCkkgd291bGQgbGlrZSB0byBnZXQgdGhpcyB0ZXN0IG1lcmdlZDoKCiAga2FsbHN5
bXMwMTogVXRpbGl6ZSBrc3ltYm9sIHRhYmxlIGZvciB1bmF1dGhvcml6ZWQgYWRkcmVzcyBhY2Nl
c3MKICBodHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAyNC1BcHJpbC8wMzgw
OTYuaHRtbAoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
