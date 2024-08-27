Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2794DC52D6F
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 05:18:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D78E3D26D3
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 07:18:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A00D3C7B6D
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 07:18:35 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D609C14000F9
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 07:18:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724735913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fgll1oEFe7T1tuU4poe+D6xuDVQzzekSrXQi10lQLNg=;
 b=PmB/PnxMDh/nPmcW+iC/VRm3CtDDLS0jTk+3emlgOPCE8VhGXoqkxcFdlt4l4xWqVO1uso
 g3FzBPAfX8HycKSCVogSFNjAjRKTpxtk0VozvdCtS/q298rDq4+tJK0tmbQvqZa4lXQNa0
 TbwdMpZdw5bCWQvIRpTkm9pTHH2fkHo=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-tRskjykHOiyq6V_pESaOhw-1; Tue, 27 Aug 2024 01:18:31 -0400
X-MC-Unique: tRskjykHOiyq6V_pESaOhw-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-2701665f8e4so7631020fac.1
 for <ltp@lists.linux.it>; Mon, 26 Aug 2024 22:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724735910; x=1725340710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgll1oEFe7T1tuU4poe+D6xuDVQzzekSrXQi10lQLNg=;
 b=A+gnDgSSwpNk1Wb+DMmORW4MZE7x8+HqEwuAQgHeebGNPFh6A4rR3XX2ADGJLU0DgM
 3v+JMdZJJwvWUdGC5i5AcoLlBtevd05dmi60FnX17y9GyZ8u5MNf/BkmrWaIcfitLa9u
 D1Pefp85gCScXwEntrq0o1yXRkJEaLJKOZyUdB+o2A6pEi+ykDOayVQQKxTbDPnLrWRR
 bWrvqMNpoOagxCh2ZL32ppPRqcb3En/5uLkFezOeoqbmM4L+2sBXOR/9qOjVZCIAVH+7
 rCB/WBzsSb7HffRjrcplEiCVxTxQZ3r8+/aC5a5J5nB77cISw4H3aDX6S9hbnBw8NgUv
 ZbUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBOP9AYkrw19hgFZkHHv0Zhmo5h55XRj96cIYb4ficG6hH9tr3NrSbN59cqav1TTujHw8=@lists.linux.it
X-Gm-Message-State: AOJu0Yz3+e4Y4LtdyD1g1/UHfBzVdUFwkm0kzhX7lv/fVNFITwg3efqn
 NyLU+1UtVKP8mqQkmsBoNf2LmBBRxguTVXobvIWxbo31vToTJHwwODPAxq7Qk2sEbDOlFm76oiX
 swgc2zgJtWxQR0mogh5scEpxc2orpw+chbgV0yY8HjOzsJWF1mN4QgOyAQgtwPfuhaJJpZrex70
 0wm9i1KW/E41XAu4Xgiz9q+6M=
X-Received: by 2002:a05:6870:c14c:b0:260:e2ea:e67f with SMTP id
 586e51a60fabf-273e63e708fmr14343830fac.10.1724735910610; 
 Mon, 26 Aug 2024 22:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8h1kF+iYvqxdmiHNnOKQ8jgdKBMOLVDbjuZ+BtBMl52nGOlo6niP967qOLSUjER1YSDiSnk33kpb4OJukK2Y=
X-Received: by 2002:a05:6870:c14c:b0:260:e2ea:e67f with SMTP id
 586e51a60fabf-273e63e708fmr14343814fac.10.1724735910191; Mon, 26 Aug 2024
 22:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240827032218.34744-1-liwang@redhat.com>
In-Reply-To: <20240827032218.34744-1-liwang@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 27 Aug 2024 07:18:09 +0200
Message-ID: <CAASaF6yVb30xTrZ11SCRNvp4=t76VC+eiXWLxW+fWfOzavj-HA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] loop: Increase bsize variable from unsigned short
 to unsigned int
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it, John Garry <john.g.garry@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBdWcgMjcsIDIwMjQgYXQgNToyMuKAr0FNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKPgo+IFRoaXMgY2hhbmdlIGFsbG93cyB0aGUgbG9vcGJhY2sgZHJpdmVyIHRv
IGhhbmRsZSBsYXJnZXIgYmxvY2sgc2l6ZXMKPiBhbmQgaW5jcmVhc2VzIHRoZSBjb25zaXN0ZW5j
eSBvZiBkYXRhIHR5cGVzIHVzZWQgd2l0aGluIHRoZSBkcml2ZXIuCj4gRXNwZWNpYWxseSB0byBt
YWN0Y2ggdGhlIHN0cnVjdCBxdWV1ZV9saW1pdHMubG9naWNhbF9ibG9ja19zaXplIHR5cGUuCiAg
ICAgICAgICAgICAgICAgICAgICAgIF5eIHNtYWxsIHR5cG8gaGVyZSwgZXh0cmEgJ2MnIGluICJt
YXRjaCIKPgo+IEFsc28sIHRoaXMgaXMgdG8gZ2V0IHJpZCBvZiB0aGUgTFRQL2lvY3RsX2xvb3Aw
NiB0ZXN0IGZhaWx1cmU6Cj4KPiAgIDEyIGlvY3RsX2xvb3AwNi5jOjc2OiBUSU5GTzogVXNpbmcg
TE9PUF9TRVRfQkxPQ0tfU0laRSB3aXRoIGFyZyA+IFBBR0VfU0laRQo+ICAgMTMgaW9jdGxfbG9v
cDA2LmM6NTk6IFRGQUlMOiBTZXQgYmxvY2sgc2l6ZSBzdWNjZWVkIHVuZXhwZWN0ZWRseQo+ICAg
Li4uCj4gICAxOCBpb2N0bF9sb29wMDYuYzo3NjogVElORk86IFVzaW5nIExPT1BfQ09ORklHVVJF
IHdpdGggYmxvY2tfc2l6ZSA+IFBBR0VfU0laRQo+ICAgMTkgaW9jdGxfbG9vcDA2LmM6NTk6IFRG
QUlMOiBTZXQgYmxvY2sgc2l6ZSBzdWNjZWVkIHVuZXhwZWN0ZWRseQo+Cj4gTGluazogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9waXBlcm1haWwvbHRwLzIwMjQtQXVndXN0LzAzOTkxMi5odG1sCj4g
U2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gQ2M6IEphbiBTdGFu
Y2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgo+IENjOiBKb2huIEdhcnJ5IDxqb2huLmcuZ2FycnlA
b3JhY2xlLmNvbT4KPiBDYzogRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9yZz4KPiBD
YzogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPgoKUmV2aWV3ZWQtYnk6IEph
biBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
