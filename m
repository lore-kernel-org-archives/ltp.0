Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737A4C47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 12:05:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E970C3CE213
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 13:05:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DAE333C97A2
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 13:05:01 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 23393601381
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 13:05:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706011499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=up0aFxWrHr5l1356USB6/la+4nQ4CpinMb+dY9IqOGc=;
 b=AvBMpHYx6o1HK7Uyp2YpV8r//Bl9aZGgoeLeHWmgy2s+XsFEOn066HZLPXu4v4hyQ71BCj
 KxWMCnc+IcWklDXpEDOUN73zUu1LctdnrrqK6RmTVtBMXy3//IhlaHNLpinXxBkAoF2rIK
 OIgaW8FsgYCP4noYE7DAWczagbwjxXM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-99IyXIOOP5mWdtkJNtIrPw-1; Tue, 23 Jan 2024 07:04:57 -0500
X-MC-Unique: 99IyXIOOP5mWdtkJNtIrPw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-290d09f47daso376364a91.0
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 04:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706011495; x=1706616295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=up0aFxWrHr5l1356USB6/la+4nQ4CpinMb+dY9IqOGc=;
 b=ZP996KTKhteSGtj/702MzW5AVjpcfA4EpP0BW0365CEn3IyKqNTHP5ikw/xGra6bLV
 tIw+8AmgTxIZtAYpsoj5pLdhnDiKjeRTgxLz6gllwrbyd6irnT9jrPQTyo4AodGceHVl
 I56hZ7L5GfiGfYK67Y3CbhhTldJ+LPE93+Hy1XY+b6okMpJWcvQd8Sd4Dw7MoxcD0EB+
 scT3U7vQEIpJwayte1j2nq10qgZ4FPvUOkfx+CF+ZqlpMR95fHPGdX6CpOtSy1mmYN2g
 JfbFujywoTMI4bZypiYKcAUVrS3JTD+QuEOCaY5ERSItA5Vn4CYFHvqeopArbjL3mn37
 H0zw==
X-Gm-Message-State: AOJu0Yz0my6aES9cWmQMdfuA2VGjdIUeNK3kTRM9pdxYNBpjoBvHyhjL
 QbcJ8sIPInLxTcwKWXO+AIJ/zYGYSl4HSCpdNO5jk7dgibrTKECDMDe3aJPWJ0sI/BaZSRzwisz
 RI0Uxd8yLSL1BJ9ND6ZxmajMRpTak5K+wARnEWWU1/o2uUKKlu+v2xeIuDLCio+vDrwjxZB7FX3
 vBbIir7fW0udIg+m0+PsWWiv2uf42kyRpU5qIP
X-Received: by 2002:a17:90b:289:b0:28e:8363:4e03 with SMTP id
 az9-20020a17090b028900b0028e83634e03mr2248699pjb.48.1706011495623; 
 Tue, 23 Jan 2024 04:04:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFPAyg4TPlLNjf9FzznjcD0by8cuGUAH3FXXydwpRmQsAaWMG7apQYyXujHJUEeyX2FjuxgpkShU4xtLoxoGU8=
X-Received: by 2002:a17:90b:289:b0:28e:8363:4e03 with SMTP id
 az9-20020a17090b028900b0028e83634e03mr2248688pjb.48.1706011495241; Tue, 23
 Jan 2024 04:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122091356.GF76754@pevik>
 <CAEemH2dA6sjKz4LGUwYT3wr-4WRZ5H_usSptEG30HxVDVbWSWA@mail.gmail.com>
 <20240122110344.GB95077@pevik>
 <CAEemH2cNn1kyWrnqXHHeOteGT_FQ=PBVc55NFhkZbmkbMOoD=A@mail.gmail.com>
 <20240122202325.GA119341@pevik>
 <CAEemH2dTKjxuiMaHBh0Ky0VV+p2YmDQzH7nvZZjnOVop2E04jQ@mail.gmail.com>
 <CAEemH2cEY=kiJe91Y_kZNefjbh+L-3rikcxErSqVwhQN7mQ=fA@mail.gmail.com>
 <20240123074806.GA144741@pevik>
In-Reply-To: <20240123074806.GA144741@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Jan 2024 20:04:43 +0800
Message-ID: <CAEemH2eDZ-Sn0mfH5_pKKLoMe=FXSPA2XRpbs5VmscSZrU4Eng@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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

T24gVHVlLCBKYW4gMjMsIDIwMjQgYXQgMzo0OOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+IFYzIGlzIGhlcmU6IGh0dHBzOi8vZ2l0aHViLmNv
bS93YW5nbGk1NjY1L2x0cC9jb21taXRzL2xpYnN3YXAtdjMKPgo+IEkndmUganVzdCBzY2hlZHVs
ZWQgbmV3IHJ1bnMgZm9yIGJvdGggVHVtYmxld2VlZCBhbmQgYWxsIFNMRVMgdmVyc2lvbnMKPiAo
dmFyaW91cyBrZXJuZWwgdmVyc2lvbnMpLgo+CgpUaGFua3MgUGV0ciwgYW5kIHNvcnJ5IGZvciBw
b3N0aW5nIHRvIE1MIHNvIGxhdGVyLgpJIGRpZCBzb21lIHBvbGlzaGluZyB3b3JrIGFuZCBmaXhl
ZCBhIGZldyB0aW55IGlzc3VlcyBiYXNlZCBvbiBhYm92ZSBWMy4KCkknbSBub3Qgc3VyZSBpZiB0
aGUgbGlic3dhcC12MyBicmFuY2ggd2lsbCB0ZXN0IHdlbGwgKHdpdGggdGlueSBpc3N1ZXMpLgpT
byBJIHB1c2hlZCB0aGUgbGF0ZXN0IHRvIG15IG1haW4gYnJhbmNoOgogaHR0cHM6Ly9naXRodWIu
Y29tL3dhbmdsaTU2NjUvbHRwCkFuZCwgSSBkZXBsb3llZCBpdCB3aXRoIGEgZ2VuZXJhbCB0ZXN0
IChhZ2FpbnN0IFJIRUwpIGZvciB0aGUgY29taW5nCnJlbGVhc2Ugd29yay4KV2lsbCBzaGFyZSBt
eSB0ZXN0IHJlc3VsdCB3aXRoIHlvdSBhbmQgQ3J5aWwgbGF0ZXIuCgotLSAKUmVnYXJkcywKTGkg
V2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
