Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB33C0218C
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 08:25:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EFBE3C29E7
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 09:25:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 042663C06F5
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 09:25:24 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=acarmina@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 390911031A28
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 09:25:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737966321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sTJWMoJBjxvrNM7PS+WzYAYX9VWlXifsFD3hDnkAxJ4=;
 b=AHSpwCSTEokZRcPI3QCkcMl6Zbxjf9/r09J3RCZwqcuyZatgo/zfEs1yVICge0jgtMqXXN
 wmBnu3FkH18DjCVREm6niUFuyGgj/1q3FAN5l4xQDP10tNiA4nsxVTuNoki8jt0GcbHqYn
 PhZNRgEUkbB7g949n0SMJBzHTrd6DMM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-usgvKolbOhuOYKt74Hn4GA-1; Mon, 27 Jan 2025 03:25:19 -0500
X-MC-Unique: usgvKolbOhuOYKt74Hn4GA-1
X-Mimecast-MFC-AGG-ID: usgvKolbOhuOYKt74Hn4GA
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef7fbd99a6so8055862a91.1
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 00:25:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737966318; x=1738571118;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sTJWMoJBjxvrNM7PS+WzYAYX9VWlXifsFD3hDnkAxJ4=;
 b=A7EOfjppXUfsYXX367l0ML+BmkTiRFO7lP8dNhit1x4S0J8/jL6fzafwfPdpQWa48y
 +eit0001dJ1dqiafAubr09aNrHZ49jvdZTgGDOR+S6ue3gF3azuKB5iVdGgx4eYOWBgA
 po/2nvOoZWz/8lnfmqLMVbV1MNu0bdBUJH6z+TiDqWdTMTHm5QTVNQlimt73bYIZB+op
 d7r4KDdYDMBY3Y6pj7qVMuWGZkJTvfVFCWEzrspAmxWaWhpqB+aXEZuD0OBSb9dDCJ1s
 KAlkrR2yRfh3sFEnPYYhmY8hjSnVijUldP9cRH5bRsEyPDUfXMW/r1A6W8/S7tpzoYT7
 V9yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSw5pz0HBRkFX3LdUU9HnLagDLsdi46kJvObjnp1ZPUYmxD1DTz7qaBvHRRl+7P6Hm6xQ=@lists.linux.it
X-Gm-Message-State: AOJu0YztKhBtr8YOWCn+MctmA2SFEQJ/dZRvbM8OaLBacJhecNz6PPIM
 kZMzHH7JCNo1Rf3RSaj/9s5qzo4kySaFMZ/bhTatpclqWjkYvflairQXqI11JuohcBDiUqEjAr6
 9htGQ0wdkz2nDPMbVPyB9+f+xelIn2h8R1YzTmYt3MYZ2Umc04zM6c/w7IrgxXSdoiCLsCKcqRU
 BvDiuvlh8ZK3XoK5b0jZkC430=
X-Gm-Gg: ASbGncuVeDTqNvwaZ4MxuUhQslSqDms+Bsc1UN0kHtuCox1YGVAOe9q3qWTKxfRdWGG
 Lf2kJP73jdoEc/J12rREOiT0ToY+TRclmDypBSjA8059uTHF9cjXIv8HV84LM
X-Received: by 2002:a17:90a:d2d0:b0:2ea:7fd8:9dc1 with SMTP id
 98e67ed59e1d1-2f782c9cb34mr65175860a91.18.1737966318515; 
 Mon, 27 Jan 2025 00:25:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8eeF2zWTig2FjRRsABrH3IftdxeoJLmbPJAfuushNVh8OZ4eDUKRtYS/0UHhCKGjLNpnUVX+Ofxv/jX3uoqg=
X-Received: by 2002:a17:90a:d2d0:b0:2ea:7fd8:9dc1 with SMTP id
 98e67ed59e1d1-2f782c9cb34mr65175835a91.18.1737966318148; Mon, 27 Jan 2025
 00:25:18 -0800 (PST)
MIME-Version: 1.0
References: <20250121111909.66487-1-acarmina@redhat.com>
 <Z5OAagIzmhi3JVlQ@yuki.lan>
In-Reply-To: <Z5OAagIzmhi3JVlQ@yuki.lan>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Mon, 27 Jan 2025 09:25:07 +0100
X-Gm-Features: AWEUYZmVH9AeBNvJU6ln1ea6V5AJCS0jiJdF4MdfLln2UZKSyRhQzv9nh955K5k
Message-ID: <CAGegRW4vD6PbH=denC4cS929XMRPgbSiYh-wEC_YBN1Lp+8K5A@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: daZwF9bi7D29oJRbe27iR_pZm48Ya6yFUB_I5DdnLTY_1737966318
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cfs-scheduler/starvation.c: Skip test on
 realtime kernels
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gQ3lyaWwsClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLgoKT24gRnJpLCBKYW4gMjQsIDIw
MjUgYXQgMTI6NTjigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4gd3JvdGU6Cj4K
PiBIaSEKPiA+ICtpbnQgdHN0X2NoZWNrX3ByZWVtcHRfcnQodm9pZCkKPiA+ICt7Cj4gPiArICAg
ICBzdHJ1Y3QgdXRzbmFtZSB1dmFsOwo+ID4gKwo+ID4gKyAgICAgdW5hbWUoJnV2YWwpOwo+ID4g
KyAgICAgaWYgKHN0cnN0cih1dmFsLnZlcnNpb24sICJQUkVFTVBUX1JUIikpCj4gPiArICAgICAg
ICAgICAgIHJldHVybiAtMTsKPgo+IE1heWJlIGp1c3QgcmV0dXJuIDE7IGhlcmUgaW5zdGVhZC4K
CkZpeGluZyBpbiB2MyB0aGF0IHdpbGwgZm9sbG93IGluIGEgZmV3IG1pbnV0ZXMuCgo+Cj4gT3Ro
ZXJ3aXNlOgo+Cj4gUmV2aWV3ZWQtYnk6IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+
Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgoKLS0gCi0tLQpUaGFua3MK
QWxlc3NhbmRybwoxNzIKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
