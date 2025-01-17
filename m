Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA83C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 12:21:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3C3A3C7C36
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:21:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 437FE3C7B03
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:21:26 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 430C01007CB8
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:21:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737116483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YO4nh9Uce5BU7FQfSpbXwZzTMqR67DEyZO6lalrzUa0=;
 b=VwfDoxq1o0ccRM06PQJKTqTQtmPVzZAoNqx7D4QKayQ2MuGgIHkbrfMDCUEJb0u1c4xjpu
 c+Uomohj0WVkFkweyXQDLWSjNlHVeviKkxduyWyDW1T4obfDlYbBxaZqctzOhHEWRru9oV
 NHDGa2WaXUMg5oDDVrj4XKpYBX91fbM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-8kniQkcFMFGNE0bUDplkjg-1; Fri, 17 Jan 2025 07:21:22 -0500
X-MC-Unique: 8kniQkcFMFGNE0bUDplkjg-1
X-Mimecast-MFC-AGG-ID: 8kniQkcFMFGNE0bUDplkjg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2f5538a2356so3974542a91.2
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 04:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737116481; x=1737721281;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YO4nh9Uce5BU7FQfSpbXwZzTMqR67DEyZO6lalrzUa0=;
 b=VoTHwPkcHhPFMMeb9Twlkwzyr5w444bwt3Olp6DZblTCZuiOCOf35yifCHcotkTgoW
 ZHjKAGFZK1z8NqVTobOijkwe51RRb+PJRbOsMJflFI2Qqt1QUTpQh9NLwkr2jA93irwC
 YxIDhzj4COBO2wabDvObSMHbM7jN4uzphM1w+UlMNO+IhZwTD+R14EHCn/I1rewWJLNr
 3qYZkCqXuhQbmq11BSB0WHTpwNAetwuqcDA5XHbq6U21LqkE1eDqclGp7cZficKzAZOM
 SlJUvlw+xtAjQ5UZZ5PYOwZU0d6WRBVxi9LSQdTsKZ104fAMJX1QBf8dkXQ75/7saIBj
 wDbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVczWlKNyn76LhgBfqBtCYy52bFb1nuGzHC14IOjGJfVccN8T5D4PiPeHEFEMNNWz2x1jY=@lists.linux.it
X-Gm-Message-State: AOJu0YzBqfuOMuWL31yg4WmaFyhT4owMBo3pkRwocKu2Arilgiv6C2P1
 QHAfTG58FqbbWtnKQGw0YIfHgISAQUwtjPfBiJQdfmqRAMwXFNhZOFbWn2EQWfAeEceIGDK2Bos
 nr2LLdXSWx7IADnooV9lZi8BgcAVz7oNLdtKViPk0q0P9HgFlUv5q2i6MddrDDKKlRQ/wvsrAfk
 /g6g+lvnBz3uARm3K0O9qXa/0=
X-Gm-Gg: ASbGncuvuOuSEGaQiG1z490ENHTz32rnTsF/qDJ1RVIEOplhvhQsRnd0u3H43ezJWKI
 KfnkeS9kbbD2Fqp2uEDYy2/wjBMiMS37VHxI9SuQ=
X-Received: by 2002:a17:90a:c2d0:b0:2ee:cb5c:6c with SMTP id
 98e67ed59e1d1-2f782d383a1mr2955440a91.22.1737116481194; 
 Fri, 17 Jan 2025 04:21:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhyRiwcjuZ/FYOOaRpTwaN8l9zTPg8Rd6VDALY90oATAI9OMpxKXX68nwarPv6UNZNabjbbvRpEoLkXBr4edg=
X-Received: by 2002:a17:90a:c2d0:b0:2ee:cb5c:6c with SMTP id
 98e67ed59e1d1-2f782d383a1mr2955411a91.22.1737116480909; Fri, 17 Jan 2025
 04:21:20 -0800 (PST)
MIME-Version: 1.0
References: <20250117084118.740225-1-pvorel@suse.cz>
 <Z4oln8S422XIUExH@yuki.lan>
 <20250117095742.GA749338@pevik> <20250117101804.GA750287@pevik>
 <Z4oxVM7f9jppXtpZ@yuki.lan> <20250117114740.GA760167@pevik>
 <Z4pICYZVfxQYdZqQ@yuki.lan>
In-Reply-To: <Z4pICYZVfxQYdZqQ@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Fri, 17 Jan 2025 20:21:09 +0800
X-Gm-Features: AbW1kvb_oTy9gkGbndaktb3gvSUTjGAjYGPAlFd8P_YpV8duMvU7C5HZo8HCJK8
Message-ID: <CAEemH2ciDkhFA7US3S=ka1s+DUnS2sMmKNYHq0okMhey6kTbDA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vPuko6SDOPh3YOGZeGA8BypZL2dywMmwzNkzycN6bpY_1737116481
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/1] lib: Multiply slow config only for a real
 tests
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

T24gRnJpLCBKYW4gMTcsIDIwMjUgYXQgODowOOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBJIGd1ZXNzIHlvdSdyZSByaWdodC4gQWxzbyB0aGUg
Zml4IHdhcyBmb3IgdXNlcm5zMDguYy4gRm9yIG5vdyBpdCB3b3VsZAo+IGJlIG9rCj4gPiBmb3Ig
bWUgdG8gY2hhbmdlIFNBRkVfQ0xPTkUoKSA9PiB0c3RfY2xvbmUoKS4gT3IgZG8geW91IHdhbnQg
cHJvcGVybHkgZml4Cj4gPiBzYWZlX2Nsb25lKCk/Cj4KPiBJIHRoaW5rIHRoYXQgaXQncyBzYWZl
IHRvIGZpeCB0aGUgdHN0X25zX2V4ZWMuYyBhbmQgdHN0X25zX2NyZWF0ZS5jIHdpdGgKPiB0aGUg
cHJvcG9zZWQgY2hhbmdlIHRvIHRzdF9jbG9uZSgpLiBJIHdpbGwgcHVzaCB0aGF0IGZpeC4gVGhl
IGNoYW5nZSBpcwo+IHRoZSBzYW1lIGZvciB0c3RfbnNfY3JlYXRlLmMuCj4KCkFDSy4KClRoYW5r
cyBmb3IgdGhlIGRlYnVnIGFuZCBmaXgsIHZlcnkgaGVscGZ1bC4KCgotLSAKUmVnYXJkcywKTGkg
V2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
