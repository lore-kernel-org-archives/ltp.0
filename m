Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A74FE7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 10:50:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A9353E7D5E
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 11:50:18 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 526493E5ACA
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 11:50:02 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A64AD1002862
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 11:50:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733914199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0K6TV6Yyvx91bMLK5/91ai+90jfn1oKcE+Xa6tlLh5M=;
 b=EMnUt3Gle4PzeBucdiqAA8PboSGeSlA/QytxTCh7BazGfwzjEUXalr9YB+UCFh2+ey9+oM
 zI4pcCY48V2WPng5cTev1OYLNbYeYP4TsUhkOGyM5cvh2B93ME9h/7rmEEcEjQ1KpyfNv+
 jNkcJhhbEA7ZCOCNw+MdZAsO5mh2mNs=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-YohAU3sJMSmBszEMOjc3yQ-1; Wed, 11 Dec 2024 05:49:58 -0500
X-MC-Unique: YohAU3sJMSmBszEMOjc3yQ-1
X-Mimecast-MFC-AGG-ID: YohAU3sJMSmBszEMOjc3yQ
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3eb370d6134so3093283b6e.1
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 02:49:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733914198; x=1734518998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0K6TV6Yyvx91bMLK5/91ai+90jfn1oKcE+Xa6tlLh5M=;
 b=PJPmyQAu0a4kh3aoYgz1Vmgb9mkumYdQKjqJbNQxiA039KVilTEPPPSN00eoqUcCqW
 bGFKg7Cv15QquEoPJrIk9kjGbC8ySU1pSEgYWBc0Aqc9p0ipJVf1f0E2KJohGFQ/6fNL
 GahZU1lx7hlgswcm6BS1LzawiX4CQQ/AOmlVim732Abb/qxhzAOtOdJlXB4OGuogNCuo
 CoSPnORBSigOOzuCeXkMUXDrE1Xk7YSL4v0pYOIgpG/RFpxTA5iLBCTKMZt50/v/n5BE
 szpBaaAUSE9K0vcglZ6dWcV9ELbIAU+OTFaZxecxVxnSiGHUYkNi8zg8s3Rc1IEWYFuh
 UQ2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf7HpO6vnKyggibqnzu8fXtqPwJA7gYhUiEfhnZlNMhN1UWCNqAytJEkdQHign6ySgfbo=@lists.linux.it
X-Gm-Message-State: AOJu0YwO+F9oyOimJpr1a/+evhdI+TwexB/IdTmXZg2ga2/B3MxfTeet
 FXi7ZCY52XFLXksLt48eNlX2IyFBaSZo5m5ttTx+Uz5R+lTTpX+Bj8a9jFp8aCtdL2+2bZoCMDt
 lcA3IFhkmzIWu6m7TNT+RImksv3TJVotu4yk5llb+kcKhh5hinlZO4ojhjLWSG1apsDyQS8EAXc
 KXAqal4XpSwxYCReronpe6G4w=
X-Gm-Gg: ASbGncv7TA1AIzRTbaDj3Nvbn6SAPLKMmyusNwbGlcTUwZiYpyYPn5CUb1hUZwYpw8r
 CCbPbB9wYaQXX0V/vsAcZ/gXaAQmWaU/h2Ho=
X-Received: by 2002:a05:6808:221a:b0:3ea:6708:51c4 with SMTP id
 5614622812f47-3eb85c882cbmr889486b6e.15.1733914197778; 
 Wed, 11 Dec 2024 02:49:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF37tmB+ohr6j4M18X6bvQ+IjvyO395QYkqZXXJyCOwRttGZCR3yR7E4G/R1GAGYnoSfmzIedsMKjg/txNyZz4=
X-Received: by 2002:a05:6808:221a:b0:3ea:6708:51c4 with SMTP id
 5614622812f47-3eb85c882cbmr889477b6e.15.1733914197504; Wed, 11 Dec 2024
 02:49:57 -0800 (PST)
MIME-Version: 1.0
References: <Z1grtnHIJz//u4kB@wegao>
 <CAASaF6yCT_B87ZN5fjC=n0WodMXjavgVTct=FM4xDi5N+WzwSQ@mail.gmail.com>
 <CAASaF6xzh3uObN3dxcLxPkyVjb-W1eZ2hLmQb6ke9a8=ezVrzw@mail.gmail.com>
 <Z1hOkq0qPs+ZCdIR@wegao>
 <CAJs-1pWnYHc67w0TdQ9pu8H32GA5yHUGpJFa0jEaFe=-MWg6Hw@mail.gmail.com>
 <CAASaF6xtjp4cTWydtqfUsqMe0q0fym+_Dhqg=KAWPgF=CM6DBw@mail.gmail.com>
In-Reply-To: <CAASaF6xtjp4cTWydtqfUsqMe0q0fym+_Dhqg=KAWPgF=CM6DBw@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 11 Dec 2024 11:49:40 +0100
Message-ID: <CAASaF6whkBEAwk8Bv5x4apf1ckoGbMT1wUGYGXx30WWFkmcozw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1mkF51gXyjHPfz3x-7EQt1t834g3NNcqyMvWejswy_c_1733914198
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Question on hugemmap34
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
Cc: samir@linux.vnet.ibm.com, =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 emunson@mgebm.net, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBEZWMgMTEsIDIwMjQgYXQgNzo0NuKAr0FNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFdlZCwgRGVjIDExLCAyMDI0IGF0IDQ6MjHigK9BTSBX
ZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4gd3JvdGU6Cj4gPgo+ID4gSGkgSmFuCj4gPgo+ID4gVGhh
bmtzIGZvciB5b3VyIHF1aWNrIHN1cHBvcnQuCj4gPiBTaW5jZSBpIHVzZSBhIGtlcm5lbCB3aXRo
IG15IGRlYnVnIGVuYWJsZWQgc28gdGhlIHRlc3QgY2FzZSB0aW1lb3V0IGZpcnN0IHRpbWUsIHdo
ZW4gaSB1c2Ugbm9ybWFsIGtlcm5lbCBydW4gdGhlIHRlc3QgY2FzZSB3aXRoIHlvdXIgcGF0Y2gs
IHRoZSB0ZXN0IHJlc3VsdCBzaG93IHBhc3MuCj4gPiBUaGVuIGkgZ3Vlc3MgeW91IHdpbGwgc2Vu
ZCBuZXcgc2VwYXJhdGUgcGF0Y2ggZm9yIGZpeCB0aGlzIGxhdGVyPwo+Cj4gSSdtIHRoaW5raW5n
IGlmIHdlIGNhbiByZXdyaXRlIGl0IHdpdGggY2xvbmUoKSwgc28gdGhhdCB3ZSBjYW4gc2V0IHVw
Cj4gc3RhY2sgYW5kIGh1Z2VwYWdlIGZvciB0aGUgY2hpbGQgcmVsaWFibHkuCj4KPiBSaWdodCBu
b3csICJ0aGUgbW1hcCBzZWFyY2giIGlzIHNsb3csIGFuZCB3ZSBlbmQgdXAgd2l0aCBhZGRyZXNz
Cj4gdGhhdCdzICJ0b28gZmFyIi4gSW4geW91ciBleGFtcGxlCj4gdGhlIGNoaWxkIGNyYXNoZXMg
bG9uZyBiZWZvcmUgaXQgY29tZXMgbmVhciB0aGUgYXJlYSB0ZXN0IG1hcHBlZC4KPgo+IEFsc28g
dGhlIG9yaWdpbmFsIHRlc3QgaXMgbWFwcGluZyBmcm9tIGxpYmh1Z2V0bGZzIGFuZCBMVFAgcG9y
dCBqdXN0Cj4gbWFwcyBhIHRlbXAgZmlsZS4KCk15IGJhZCBhYm91dCB0aGlzIGxhc3QgcGFydCAt
IHRoZXJlJ3MgYWN0dWFsbHkgbmVlZHNfaHVnZXRsYmZzID0gMSBpbiB0aGUgdGVzdAp0aGF0IEkg
bWlzc2VkLiBBbnl3YXksIEknbGwgZ2l2ZSB0aGUgY2xvbmUoKSBhcHByb2FjaCBhIHRyeS4KCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
