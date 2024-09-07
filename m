Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97C3CE7B04
	for <ltp@archiver.kernel.org>; Sat,  7 Sep 2024 02:12:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E10163C04BA
	for <ltp@archiver.kernel.org>; Sat,  7 Sep 2024 04:12:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97B973C03EA
 for <ltp@lists.linux.it>; Sat,  7 Sep 2024 04:11:48 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ADFE92009BD
 for <ltp@lists.linux.it>; Sat,  7 Sep 2024 04:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725675105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D2c/AsbPuFxkb1IOWCf4x5kEVVEf+fyTnQfjRoYFHyk=;
 b=boQmBm9OgJcNAaDLMZCcoDeeNMDYytfNJQU37MEdC22cJGXvEk3N/1CrVKBV+eS70A4irQ
 +q68G8VFq+m6KOSY3r7BiYiiqY1UhPsuviNbM+23jgPP0R3m4CA/ZxV5DVF7YrrdXp2w7J
 EMiImkxADxMibfIud5NUI7xZr8XAXpo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-5OBfxNkoOX-kZ2s0It278g-1; Fri, 06 Sep 2024 22:11:43 -0400
X-MC-Unique: 5OBfxNkoOX-kZ2s0It278g-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2d626e36d2eso2958734a91.2
 for <ltp@lists.linux.it>; Fri, 06 Sep 2024 19:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725675103; x=1726279903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D2c/AsbPuFxkb1IOWCf4x5kEVVEf+fyTnQfjRoYFHyk=;
 b=krntRPsqpQSSRDGZjJ3sFJSdai736mHKdaIKUWcnSIo7XdDyBq4XaX3t48c4ZfHIOj
 GWxubmqNrqZS0OcpgrPN/TgezzU2Ed37gY6BEgzCV6qq4PvSR5uvwl5ASz6gR8i3Mqnd
 3NKCV1w+CtFHWO2q3Pgu+YIQP6cLdV5ZN6btX8+fKOJ1EjRxYpg0HqTrr3IVVjFPZVGL
 bC9gXM2728WxEzMW4d/A3EbTrTs87z3dnXCLk8+MnwJktDS48YiRyGeLVNMgaQm5bdg/
 f0qkPx93ZRyh7uR3mtSdLkK5CpUA3y3qTJBtHH7LwxZV2F2dSicbbD9zYZqF/MRYTt34
 xO/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM/xJR+5ML8cSjp9hEP41vrJEcuQTao7VkbADzK6vsSwWDrnT8wQX6g4SULDssl5NACBE=@lists.linux.it
X-Gm-Message-State: AOJu0Yw0isWYCe5PGV1QZwOa6cg0zwSrtSIA0/UU8Vf6T304DyRLNehR
 tgvU5Kn5OTHH6NnIktDb1A57dgt0qIGggqgngxDoeKB1GlAEcNpeow+WdglvCV5JhqA1q2hKw2S
 HyP0hfbzkpF8zP1kipc/AazlDYXe8Vg5H7iL+43681+Tu/RscDUHQ+IATZVRe23k+oampTiY8Wu
 FpwA5/Gr1c9s24Q1wcTx9gNzE=
X-Received: by 2002:a17:90a:8ca:b0:2c9:649c:5e08 with SMTP id
 98e67ed59e1d1-2dad4efe3e6mr4960073a91.15.1725675102865; 
 Fri, 06 Sep 2024 19:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGz52rwDZv2K45h/Sv9AUKGr9lJUxBfEKQhP6SAF7i/Gk3quuegBMy/SQwXdS8iIFo5gZmg+SwVI1h3wxuYO5E=
X-Received: by 2002:a17:90a:8ca:b0:2c9:649c:5e08 with SMTP id
 98e67ed59e1d1-2dad4efe3e6mr4960063a91.15.1725675102526; Fri, 06 Sep 2024
 19:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240827081757.37646-1-liwang@redhat.com>
 <b9f2ae40-7c13-4d43-b97e-fe011688a14a@oracle.com>
 <CAEemH2co6g0TCcj7vtG49yq8qhUfjJ83iCRBD6qiwVqGEG9=SA@mail.gmail.com>
In-Reply-To: <CAEemH2co6g0TCcj7vtG49yq8qhUfjJ83iCRBD6qiwVqGEG9=SA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Sat, 7 Sep 2024 10:11:30 +0800
Message-ID: <CAEemH2fvN-+5Rwg7D2rr0ixhNxbT_Y8gg0gW+SZRsRqFVet4vg@mail.gmail.com>
To: John Garry <john.g.garry@oracle.com>, Jens Axboe <axboe@kernel.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCh v2] loop: Increase bsize variable from unsigned
 short to unsigned int
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
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgSm9obiwgSmVucywKCkNhbiBhbnkgb2YgeW91IGhlbHAgbWVyZ2UgdGhpcyBwYXRjaD8gT3Ig
c2hvdWxkIEkgc2VuZCBhIG5ldyBwYXRjaCB2ZXJzaW9uPwooT3VyIENJIGpvYnMgY29udGludW91
c2x5IGNvbXBsYWluIHRoZSB0ZXN0IGZhaWx1cmVzKQoKCk9uIFR1ZSwgQXVnIDI3LCAyMDI0IGF0
IDc6NTnigK9QTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cgo+IE9uIFR1ZSwg
QXVnIDI3LCAyMDI0IGF0IDQ6NDHigK9QTSBKb2huIEdhcnJ5IDxqb2huLmcuZ2FycnlAb3JhY2xl
LmNvbT4KPiB3cm90ZToKPiA+Cj4gPiBPbiAyNy8wOC8yMDI0IDA5OjE3LCBMaSBXYW5nIHdyb3Rl
Ogo+ID4gPiBUaGlzIGNoYW5nZSBhbGxvd3MgdGhlIGxvb3BiYWNrIGRyaXZlciB0byBoYW5kbGUg
YmxvY2sgc2l6ZSBsYXJnZXIgdGhhbgo+ID4gPiBQQUdFX1NJWkUgYW5kIGluY3JlYXNlcyB0aGUg
Y29uc2lzdGVuY3kgb2YgZGF0YSB0eXBlcyB1c2VkIHdpdGhpbiB0aGUKPiBkcml2ZXIuCj4gPiA+
IEVzcGVjaWFsbHkgdG8gbWF0Y2ggdGhlIHN0cnVjdCBxdWV1ZV9saW1pdHMubG9naWNhbF9ibG9j
a19zaXplIHR5cGUuCj4gPiA+Cj4gPiA+IEFsc28sIHRoaXMgaXMgdG8gZ2V0IHJpZCBvZiB0aGUg
TFRQL2lvY3RsX2xvb3AwNiB0ZXN0IGZhaWx1cmU6Cj4gPiA+Cj4gPiA+ICAgIDEyIGlvY3RsX2xv
b3AwNi5jOjc2OiBUSU5GTzogVXNpbmcgTE9PUF9TRVRfQkxPQ0tfU0laRSB3aXRoIGFyZyA+Cj4g
UEFHRV9TSVpFCj4gPiA+ICAgIDEzIGlvY3RsX2xvb3AwNi5jOjU5OiBURkFJTDogU2V0IGJsb2Nr
IHNpemUgc3VjY2VlZCB1bmV4cGVjdGVkbHkKPiA+ID4gICAgLi4uCj4gPiA+ICAgIDE4IGlvY3Rs
X2xvb3AwNi5jOjc2OiBUSU5GTzogVXNpbmcgTE9PUF9DT05GSUdVUkUgd2l0aCBibG9ja19zaXpl
ID4KPiBQQUdFX1NJWkUKPiA+ID4gICAgMTkgaW9jdGxfbG9vcDA2LmM6NTk6IFRGQUlMOiBTZXQg
YmxvY2sgc2l6ZSBzdWNjZWVkIHVuZXhwZWN0ZWRseQo+ID4gPgo+ID4gPiBUaG9lc2UgZmFpbCBk
dWUgdG8gdGhlIGxvb3BfcmVjb25maWd1cmVfbGltaXRzKCkgY2FzdCBic2l6ZSB0bwo+ICd1bnNp
bmVkIHNob3J0Jwo+ID4KPiA+IHRoZXNlCj4gPgo+ID4gPiB0aGF0IG5ldmVyIGdldHMgYW4gZXhw
ZWN0ZWQgZXJyb3Igd2hlbiB0ZXN0aW5nIGludmFsaWQgbG9naWNhbCBibG9jawo+IHNpemUsCj4g
PiA+IHdoaWNoIHdhcyBqdXN0IGV4cG9zZWQgc2luY2UgNi4xMS1yYzEgaW50cm9kdWNlZCBwYXRj
aGVzOgo+ID4gPgo+ID4gPiAgICBjb21taXQgOTQyM2M2NTNmZTYxICgibG9vcDogRG9uJ3QgYm90
aGVyIHZhbGlkYXRpbmcgYmxvY2tzaXplIikKPiA+ID4gICAgY29tbWl0IGZlM2Q1MDhiYTk1YiAo
ImJsb2NrOiBWYWxpZGF0ZSBsb2dpY2FsIGJsb2NrIHNpemUgaW4KPiBibGtfdmFsaWRhdGVfbGlt
aXRzKCkiKQo+ID4KPiA+IE1heWJlIGl0J3MgYmV0dGVyIHRvIGFkZCBhIGZpeGVzIHRhZyBmb3Ig
b3JpZ2luYWwgY29tbWl0IHdoaWNoCj4gPiBpbnRyb2R1Y2VkIHVuc2lnbmVkIHNob3J0IHVzYWdl
Lgo+Cj4gSSdtIG5vdCBzdXJlIHRoYXQgbWFrZXMgc2Vuc2UgYmVjYXVzZSBhdCB0aGF0IG1vbWVu
dCBsb29wX3NldF9ibG9ja19zaXplCj4gaGFzIGEgZGVkaWNhdGVkIGZ1bmN0aW9uIGJsa192YWxp
ZGF0ZV9ibG9ja19zaXplIHRvIHZhbGlkYXRlIGJzaXplLCBhZnRlcgo+IHlvdXIKPiBjb21taXQg
OTQyM2M2NTNmZTYxIG9wdGltaXplIHRoYXQgdGhlbiB0aGUgcHJvYmxlbSBhcHBlYXJzLgo+Cj4g
ICA0NzM1MTZiMzYxOTMgKCJsb29wOiB1c2UgdGhlIGF0b21pYyBxdWV1ZSBsaW1pdHMgdXBkYXRl
IEFQSSIpCj4KPgo+ID4gUmV2aWV3ZWQtYnk6IEpvaG4gR2FycnkgPGpvaG4uZy5nYXJyeUBvcmFj
bGUuY29tPgo+Cj4gVGhhbmtzIGZvciByZXZpZXdpbmcuCj4KPgo+IC0tCj4gUmVnYXJkcywKPiBM
aSBXYW5nCj4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
