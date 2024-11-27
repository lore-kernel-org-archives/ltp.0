Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1EBD609D2
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 10:56:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C8D23DB618
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 11:56:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB95E3CB13C
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 11:56:25 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BCB3E1A010F8
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 11:56:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732704983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2YSk98lOFayAF0oWpMPRFWY6+jde7swmHzKpqb09ONQ=;
 b=R5n7oC8wgjyTPZNnyzHaA5U57LRRccng8X+cIbZbiv/4Pcjgh1xr7C8dIltd3QJYX9nyjZ
 M2mKXKwaqRAozhPaN7Er3J2qJeI9xjXINYJS79WpdV2uf6VNVIilh7H96Z49l+UStsEdTZ
 yb+iI7jG8wrEqZh8V4IrrNErI4P2Iy0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-satA_QWmMBWEILYY9tCPJg-1; Wed, 27 Nov 2024 05:56:21 -0500
X-MC-Unique: satA_QWmMBWEILYY9tCPJg-1
X-Mimecast-MFC-AGG-ID: satA_QWmMBWEILYY9tCPJg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ea50564395so674786a91.0
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 02:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732704980; x=1733309780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2YSk98lOFayAF0oWpMPRFWY6+jde7swmHzKpqb09ONQ=;
 b=Q4msn15DuIEL+z1YcpHxKKEW3s2dgxFPegO3KXFbpMtcRPCAPtzNxnVLYLNPdkIJKt
 DpEkpDmS29zeq/0WIkiJiou1Eabk/XfmAAmCngtuR412zd3PgFKLgaeVp9jTZvFMrXx6
 7iTNQWuDm3QOin57sqDUDhaklQPgmK/GkhoitNnTDFduUPW3HCezrr9CNgRpoOYOREOx
 8xo16nl6ljOAGVuCr/qNxpmYrSlgDvoKh7yW0jY2Sr9Km2yVMrMQUIVbVi18kr/mrDVp
 TvgF6eBg0dpkpiGtKBJcyIwQ0zUgu6vS/Z/I1nnLOimulvQ8CqGvd4kj3uDfk15ljj3w
 6eAg==
X-Gm-Message-State: AOJu0YxyPBfAGqCO4uYf20VLWbCWRcf9Ie2ZkW55tfNpK2z86V7cflvU
 4RI3XUUAViysf7UvBn3ZfQfSBQF6Ju9s74GfPw73pR5RnKqa3CNpuJ+GWiQXakXJgGpwOi1JWs1
 Kx3Q0rItNJ/AagEaP+knOPCdQ94eYGruSZTm8glBXLRqGYcYIeIAK5qjMMpW3svB4ID7jw1sCFR
 U+1WdNJOAXhwIs9V63HXOOx7A=
X-Gm-Gg: ASbGncuQ89FCxQIP7mPmP7DkwIHxcm5JVbXTGwbN7tsZfLoxO95UgYPEwBiw+mmY34V
 pxB5nR4RFYisM61FgB+jmk4l48og54Q0y
X-Received: by 2002:a17:90a:d14f:b0:2ea:a9dc:79d5 with SMTP id
 98e67ed59e1d1-2edebf3ecdcmr10061560a91.18.1732704980070; 
 Wed, 27 Nov 2024 02:56:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSguKRBu3URd4qyPVRBF5OP9TKF4Zir7Z8eO5DfA+ldRqYeBGYt2btmFEGnrZcmFyJdO7sgM1kqjFTxz23FwI=
X-Received: by 2002:a17:90a:d14f:b0:2ea:a9dc:79d5 with SMTP id
 98e67ed59e1d1-2edebf3ecdcmr10061465a91.18.1732704978341; Wed, 27 Nov 2024
 02:56:18 -0800 (PST)
MIME-Version: 1.0
References: <20241126100445.17133-1-liwang@redhat.com>
 <Z0WitZsMZat6wdA2@yuki.lan>
 <CAEemH2cpYA28nknKOhNV0D4q8G+xPw6EuvScMHbgOO3jpRPv7w@mail.gmail.com>
 <Z0Wvsq571rTt46Ie@yuki.lan>
 <CAEemH2e3H0w52LKXs+UURdg5dq2bP5dXokWYb98DxHu5qcsOQg@mail.gmail.com>
 <Z0bqZAiaOo7E3E9I@yuki.lan>
 <CAEemH2cJmBra=SajChZ-KKe9GimCBtdvwcnWNiwEz2dHFP8f4Q@mail.gmail.com>
 <Z0b3F2PHzRZq8WeL@yuki.lan>
In-Reply-To: <Z0b3F2PHzRZq8WeL@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Nov 2024 18:56:06 +0800
Message-ID: <CAEemH2cO1sn0cRThZvjF0p_C47J61RzMbFVCf=MDzdUv5G5U6A@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YwwUeb42_SOGlVErYFPFluraabQ7Bgf9fquNycBElsU_1732704980
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH] starvation: set a baseline for maximum runtime
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
Cc: Philip Auld <pauld@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBOb3YgMjcsIDIwMjQgYXQgNjo0MOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBBZnRlciB0aGlua2luZyBpdCBvdmVyLCBJIGd1ZXNz
IHdlJ2QgYmV0dGVyIF9vbmx5XyBhcHBseSB0aGlzIG1ldGhvZAo+ID4gdG8gc29tZSBzcGVjaWFs
IHNsb3cgdGVzdHMgKGFrYS4gbW9yZSBlYXNpbHkgdGltZW91dCB0ZXN0cykuIElmIHdlIGRvCj4g
PiB0aGUgZXhhbWluYXRpb24gb2YgdGhvc2Uga2VybmVsIG9wdGlvbnMgaW4gdGhlIGxpYnJhcnkg
Zm9yIGFsbCwgdGhhdAo+ID4gbWF5YmUgYSBidXJkZW4gdG8gbW9zdCBxdWljayB0ZXN0cywgd2hp
Y2ggYWx3YXlzIGZpbmlzaCBpbiBhIGZldwo+ID4gc2Vjb25kcyAoZmFyIGxlc3MgdGhhbiB0aGUg
ZGVmYXVsdCAzMHMpLgo+ID4KPiA+IFRoZXJlZm9yZSwgSSBjYW1lIHVwIHdpdGggYSBuZXcgb3B0
aW9uIGZvciAubWF4X3J1bnRpbWUsIHdoaWNoIGlzCj4gPiBUU1RfRFlOQU1JQ0FMX1JVTlRJTUUu
IFNpbWlsYXIgdG8gdGhlIFRTVF9VTkxJTUlURURfUlVOVElNRQo+ID4gd2UgZXZlciB1c2UuIFRl
c3QgYnkgYWRkaW5nIHRoaXMgLm1heF9ydW50aW1lID0gVFNUX0RZTkFJTUNBTF9SVU5USU1FCj4g
PiB0aGF0IHdpbGwgdHJ5IHRvIGZpbmQgYSBwcm9wZXIgdGltZW91dCB2YWx1ZSBpbiB0aGUgcnVu
bmluZyB0aW1lIGZvciB0aGUKPiA+IHRlc3QuCj4KPiBJIHdhcyB0aGlua2luZyB0byBvbmx5IG11
bHRpcGx5IHRoZSBtYXhfcnVudGltZSBkZWZpbmVkIGJ5IHRoZSB0ZXN0IGluCj4gdGhlIGxpYnJh
cnkuIFRoYXQgd2F5IG9ubHkgc2xvdyB0ZXN0cyB0aGF0IHNldCB0aGUgbWF4X3J1bnRpbWUgd291
bGQgYmUKPiBhZmZlY3RlZC4KPgoKT2ssIHRoYXQgYWxzbyBpbmRpY2F0ZXMgdGhlIHRlc3QgaXMg
c2xvd2VyLiBJIHdpbGwgYXBwbHkgdGhhdCB0byBub24temVybwonLm1heF9ydW50aW1lJwp0ZXN0
cyBhbmQgcmVzZW5kIGEgcGF0Y2guIFRoYW5rcyEKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
