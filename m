Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DE9C54734
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 11:59:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DF203D274A
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 13:59:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 301803C1B92
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 13:59:34 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8831A600D33
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 13:59:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724759971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bqJr4BiooH9esIgWULrcJP95PM7XI8L6ZzTNLa0Ai+I=;
 b=hW08VMYW60VgFlMXkbo62UP6GcKu9m8dnULpvOggOlZu9JdAHVUO6f45x5eidFYGLbJsYa
 wxIe7t34VefNC7AOnIVAtOWaFEPp4dX975WVD06C7kV09lkXg2sBkvKhMNstCtXWRcNdkX
 9sPrKPQS/yzUwZ6n8KjlhhCZ4yynoJc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-L6BGA2LbNl641tgwcuCiYA-1; Tue, 27 Aug 2024 07:59:30 -0400
X-MC-Unique: L6BGA2LbNl641tgwcuCiYA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2d406dc42f4so5535061a91.3
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 04:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724759969; x=1725364769;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqJr4BiooH9esIgWULrcJP95PM7XI8L6ZzTNLa0Ai+I=;
 b=VW3oDuDsky5B28PsKynrccwyB39JROUaOsLuoZdLOBRNYqO7kOIAjQTUkLOhV8kQ6b
 X83WWzv7vDA+6Xb+KfsBVT9RXw3gyL9uiKmV5MLlUyZA3dDH9Xftkzu9Tc9l+S+MKaGQ
 4AMrFvelBj9U+AVTiIJPGXBlqdQ69JazAnkJPvjo8h1XkHyJSu1EqicFGp4crJAjnv0e
 U1zzDII7NAfHGFaCxcwMt3MCGaUwjnMS7Plv+RUvjab98B5UsaGwFd6VLoEHdECZyWQX
 rQwqxsV/Pm2VlqfIgGQWLX7Yavhwhp2PgmvYIg4t4TdHWcdaS/h9AL2n1ZFhU3luaCkc
 cU2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDpzig3NdfGFxbPQXkJfNrQCpgoPqvXAKRC9c8wmpeLwbn6iYrmXV3uNXVjqzScg9MQ7s=@lists.linux.it
X-Gm-Message-State: AOJu0YwQSY/pQdKtYjxz8TfZIuzO5aT04sDx9V3cOkoURoGOtM15SGCR
 sxhWVxTSwfSsc4+f4U1kGbbDWp2AK2TNDJ+Cbnw55s9W0cwFg8l9MShz453fske9oUiI9IDhAmi
 +fLMFZSpSOItKPdvth+5+PdXY9/D1XMx6iRr9XQJsKazla3GIG8gymB+ymIOwgXx4WywJBvBdaq
 kcq2ORuofpkH6vyinyIGwB83A=
X-Received: by 2002:a17:90a:17ca:b0:2d3:da82:28e0 with SMTP id
 98e67ed59e1d1-2d8257d3100mr2564970a91.9.1724759969383; 
 Tue, 27 Aug 2024 04:59:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHUCpxa7e8vAOyba9Zz0k7+axvmhRH/pC1MEvIfdcmABGA2+ctn2KhtQn3O0xDpz6HgOaLAhDsxdqxSL5+cxA=
X-Received: by 2002:a17:90a:17ca:b0:2d3:da82:28e0 with SMTP id
 98e67ed59e1d1-2d8257d3100mr2564945a91.9.1724759968831; Tue, 27 Aug 2024
 04:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240827081757.37646-1-liwang@redhat.com>
 <b9f2ae40-7c13-4d43-b97e-fe011688a14a@oracle.com>
In-Reply-To: <b9f2ae40-7c13-4d43-b97e-fe011688a14a@oracle.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Aug 2024 19:59:16 +0800
Message-ID: <CAEemH2co6g0TCcj7vtG49yq8qhUfjJ83iCRBD6qiwVqGEG9=SA@mail.gmail.com>
To: John Garry <john.g.garry@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
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
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBdWcgMjcsIDIwMjQgYXQgNDo0MeKAr1BNIEpvaG4gR2FycnkgPGpvaG4uZy5nYXJy
eUBvcmFjbGUuY29tPiB3cm90ZToKPgo+IE9uIDI3LzA4LzIwMjQgMDk6MTcsIExpIFdhbmcgd3Jv
dGU6Cj4gPiBUaGlzIGNoYW5nZSBhbGxvd3MgdGhlIGxvb3BiYWNrIGRyaXZlciB0byBoYW5kbGUg
YmxvY2sgc2l6ZSBsYXJnZXIgdGhhbgo+ID4gUEFHRV9TSVpFIGFuZCBpbmNyZWFzZXMgdGhlIGNv
bnNpc3RlbmN5IG9mIGRhdGEgdHlwZXMgdXNlZCB3aXRoaW4gdGhlIGRyaXZlci4KPiA+IEVzcGVj
aWFsbHkgdG8gbWF0Y2ggdGhlIHN0cnVjdCBxdWV1ZV9saW1pdHMubG9naWNhbF9ibG9ja19zaXpl
IHR5cGUuCj4gPgo+ID4gQWxzbywgdGhpcyBpcyB0byBnZXQgcmlkIG9mIHRoZSBMVFAvaW9jdGxf
bG9vcDA2IHRlc3QgZmFpbHVyZToKPiA+Cj4gPiAgICAxMiBpb2N0bF9sb29wMDYuYzo3NjogVElO
Rk86IFVzaW5nIExPT1BfU0VUX0JMT0NLX1NJWkUgd2l0aCBhcmcgPiBQQUdFX1NJWkUKPiA+ICAg
IDEzIGlvY3RsX2xvb3AwNi5jOjU5OiBURkFJTDogU2V0IGJsb2NrIHNpemUgc3VjY2VlZCB1bmV4
cGVjdGVkbHkKPiA+ICAgIC4uLgo+ID4gICAgMTggaW9jdGxfbG9vcDA2LmM6NzY6IFRJTkZPOiBV
c2luZyBMT09QX0NPTkZJR1VSRSB3aXRoIGJsb2NrX3NpemUgPiBQQUdFX1NJWkUKPiA+ICAgIDE5
IGlvY3RsX2xvb3AwNi5jOjU5OiBURkFJTDogU2V0IGJsb2NrIHNpemUgc3VjY2VlZCB1bmV4cGVj
dGVkbHkKPiA+Cj4gPiBUaG9lc2UgZmFpbCBkdWUgdG8gdGhlIGxvb3BfcmVjb25maWd1cmVfbGlt
aXRzKCkgY2FzdCBic2l6ZSB0byAndW5zaW5lZCBzaG9ydCcKPgo+IHRoZXNlCj4KPiA+IHRoYXQg
bmV2ZXIgZ2V0cyBhbiBleHBlY3RlZCBlcnJvciB3aGVuIHRlc3RpbmcgaW52YWxpZCBsb2dpY2Fs
IGJsb2NrIHNpemUsCj4gPiB3aGljaCB3YXMganVzdCBleHBvc2VkIHNpbmNlIDYuMTEtcmMxIGlu
dHJvZHVjZWQgcGF0Y2hlczoKPiA+Cj4gPiAgICBjb21taXQgOTQyM2M2NTNmZTYxICgibG9vcDog
RG9uJ3QgYm90aGVyIHZhbGlkYXRpbmcgYmxvY2tzaXplIikKPiA+ICAgIGNvbW1pdCBmZTNkNTA4
YmE5NWIgKCJibG9jazogVmFsaWRhdGUgbG9naWNhbCBibG9jayBzaXplIGluIGJsa192YWxpZGF0
ZV9saW1pdHMoKSIpCj4KPiBNYXliZSBpdCdzIGJldHRlciB0byBhZGQgYSBmaXhlcyB0YWcgZm9y
IG9yaWdpbmFsIGNvbW1pdCB3aGljaAo+IGludHJvZHVjZWQgdW5zaWduZWQgc2hvcnQgdXNhZ2Uu
CgpJJ20gbm90IHN1cmUgdGhhdCBtYWtlcyBzZW5zZSBiZWNhdXNlIGF0IHRoYXQgbW9tZW50IGxv
b3Bfc2V0X2Jsb2NrX3NpemUKaGFzIGEgZGVkaWNhdGVkIGZ1bmN0aW9uIGJsa192YWxpZGF0ZV9i
bG9ja19zaXplIHRvIHZhbGlkYXRlIGJzaXplLCBhZnRlciB5b3VyCmNvbW1pdCA5NDIzYzY1M2Zl
NjEgb3B0aW1pemUgdGhhdCB0aGVuIHRoZSBwcm9ibGVtIGFwcGVhcnMuCgogIDQ3MzUxNmIzNjE5
MyAoImxvb3A6IHVzZSB0aGUgYXRvbWljIHF1ZXVlIGxpbWl0cyB1cGRhdGUgQVBJIikKCgo+IFJl
dmlld2VkLWJ5OiBKb2huIEdhcnJ5IDxqb2huLmcuZ2FycnlAb3JhY2xlLmNvbT4KClRoYW5rcyBm
b3IgcmV2aWV3aW5nLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
