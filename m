Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B901C3DA41
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 11:14:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 132D43CDE67
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 13:14:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 719333CBD32
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:14:40 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7336710009C8
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:14:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720696477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kL61Mumyoj4iBnyRsjPz82sjmfHzQobLE6StjLi2MQE=;
 b=RDrzoHQ5+V+YX2aq70efrydiOdimFTLrqmJ/+x2OAnDNlJa5Jj9vNWscoIzHzaHlT12E7p
 Me/lT7KuNihkuH48fCQ640AB3Hph5bBQsBMjP5ubofWPhqrb+kWPcU3OSqOqFyIdZHE8n4
 hZtS36SxqIzch7ZmmCzWGIrgvklnF/U=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-3hhg7CwUPXWRbd7_egfCmQ-1; Thu, 11 Jul 2024 07:14:35 -0400
X-MC-Unique: 3hhg7CwUPXWRbd7_egfCmQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c96f6bed83so693352a91.3
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 04:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720696473; x=1721301273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kL61Mumyoj4iBnyRsjPz82sjmfHzQobLE6StjLi2MQE=;
 b=BSQW7FkxKkD3dfTBRQZ4wyEDW0R58L6xI0NiZIKHK4SM3NkOftGV5zGNty4Lt8iC9f
 /AE2zaldjOivtlDJGR1NXStbanqwWyCLDpsWbM6z0FFKT53JsnDpOcudAL5CefaWvzkg
 f+Of0U0lqRNNbXJWsSan/pfEq7Ix8/BuNB0sndrSlpYqrLIk/m4skzfirYNnfKWSJ/+1
 TBqVFQ9yEyt1tJqCxS78r36y++vldYmmgziMcKWPtrWp0ChSMqbE9fyIlhu2hCrWM61O
 TmtPuyDBhe7kzx7PpgGGKMRtHvJSK3TvYfGgUpuAyR7OTF3lsMpPx++YWStGsQUju3IE
 WjZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDlThk26dIirJ2fYYggONeiQARsQOg2Fis2i61nEEM9N1DcZCCS4BtjIBmvuFKI6fT8V5mCIZPz1p5QGnL6AE/tag=
X-Gm-Message-State: AOJu0YxLswjdQcQmsOwnT5e8Zh+DhimUP3N9R3qlKKR2iqYWCC8GXmpR
 dTAeqM63Mu8kAQsIDKydsxJ/kveWyIhKkb3aPT+vLrZw0yFy0vCyF7eCmVYy4OQBOwsk1anErGf
 BhJmE/y+smeg59GlyHg1yxdNRE5kVuNgSTCcWQqiyA4oy81r+VeSxt0Kw5UzKDHNuQMV61pz5U5
 H3JEjLPsOAGByM/UCQLZpl/g6MdEc6asUAXg==
X-Received: by 2002:a17:90a:c08f:b0:2c9:860c:7802 with SMTP id
 98e67ed59e1d1-2ca35c794b2mr6122712a91.28.1720696473460; 
 Thu, 11 Jul 2024 04:14:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFaaxS3rDKsclqT3v1fz68VxkOWaEvFa8OcNRrQMnKS/r91PCycKA61ITSYqntnOlAteMUMFP+SzuV5ARu04Qo=
X-Received: by 2002:a17:90a:c08f:b0:2c9:860c:7802 with SMTP id
 98e67ed59e1d1-2ca35c794b2mr6122700a91.28.1720696473125; Thu, 11 Jul 2024
 04:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
 <20240710-landlock-v2-9-ff79db017d57@suse.com>
 <CAEemH2crUwPREXw=QTWSNEUk-_cs0vLeg_VYAgyBuUe5Cet3ow@mail.gmail.com>
 <bddb07dc-d8a2-4946-bfba-8f476bc24613@suse.com> <Zo-7oBzMMyrrVA-Z@yuki>
In-Reply-To: <Zo-7oBzMMyrrVA-Z@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 11 Jul 2024 19:14:20 +0800
Message-ID: <CAEemH2ey8RbFbNPYfOM+KkqAe3sFNJAtN+wU1f+361h87H=A6Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 09/11] Add landlock04 test
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

T24gVGh1LCBKdWwgMTEsIDIwMjQgYXQgNzowMuKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBUaGUgb25seSBsaWJyYXJ5IHdlIG5lZWQgaXMgbGli
Yy5zbywgd2hpY2ggaXMgdXN1YWxseSBpbnN0YWxsZWQgaW4gL2xpYgo+ID4gb3IgL2xpYjY0LiBJ
IGRvbid0IHJlYWxseSBrbm93IGlmIExUUCBzdXBwb3J0ZWQgZGlzdHJvcyB3aGljaCBwbGFjZSBs
aWJjCj4gPiBzb21ld2hlcmUgZWxzZS4KPiA+IERvIHlvdSBoYXZlIHN1Z2dlc3Rpb25zIG9uIGhv
dyB0byBnZXQgc2hhcmVkLWxpYnMgZXZlbnR1YWxseT8gQmVjYXVzZQo+ID4gdGhlIG9ubHkgd2F5
IEkga25vdyBpcyB0byBjYWxsIGRsYWRkcigpIGJ1dCBpdCBkb2Vzbid0IHNlZW0gdGhlIHdheSB0
bwo+ID4gZ28gKEkgb2J0YWluIHRoZSBjdXJyZW50IGJpbmFyeSBmaWxlKQo+Cj4gSSBndWVzcyB0
aGF0IHlvdSBjYW4gcGFyc2UgL3Byb2Mvc2VsZi9tYXBzIHRvIGdldCBwYXRocyB0byBjdXJyZW5s
dHkKPiBsb2FkZWQgc28gZmlsZXMuCj4KClllcywgdGhhdCB3aWxsIHByZWNpc2VseSBzaG93IHRo
ZSBjdXJyZW50IHByb2Nlc3MgbG9hZCBzbyBmaWxlcy4KCkFsc28sIHdlIGNvdWxkIGZpbmQgdGhh
dCB2aWEgJ2xkY29uZmlnIC1wJyBidXQgdGhhdCBkb2VzIG5vdCBzZWVtCm1vcmUgZWFzaWVyIHRo
YW4gcGFyc2luZyB0aGUgbWFwcy4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
