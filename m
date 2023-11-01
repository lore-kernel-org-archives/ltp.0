Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE081C4167B
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 12:28:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3B293CE9D4
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 13:28:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 533163CC8DB
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 13:28:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1F32A10000C7
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 13:28:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698841718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BzcwIjwGA3MF6ry2P+gcc8A80Y14pPVJbemfsK5KJEA=;
 b=VWsW8qQNWfGHvgbtvqYlKNKCz85qoQiw15SfsxQShC2w2VM8nRV/ImfAiuNxlQvkX9gXGu
 AQy1mtNl9LMrLNB+cl8rU4EAkz4WhEWNMBBLHmJNcKS8pZTlXwGWcTSaseFQx/UaLWb4LL
 2s35agZmrTIFg0fx6wR2W9Of512RTaw=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-Gpx_zntiNsexIUrCljzpXw-1; Wed, 01 Nov 2023 08:28:36 -0400
X-MC-Unique: Gpx_zntiNsexIUrCljzpXw-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7ba672cc8b3so932375241.1
 for <ltp@lists.linux.it>; Wed, 01 Nov 2023 05:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698841716; x=1699446516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzcwIjwGA3MF6ry2P+gcc8A80Y14pPVJbemfsK5KJEA=;
 b=T7jYSiYKlNRXCyJZy8NlLNzV1Gv2cXjoj+F/+sMn6u5RpgKnZdIa2cobmFNxKIPGDJ
 BXTll83BMUD56reOPwCaBDbNCKwC5HCVUOQFDL2SiCO2TYjGaA8i9mzoYXgZQtsZjWqr
 Ue7vE4KuVnFjXOV5/Q1AVqg1WRKCpEmTQeNeN1/7QyupawRTnjY/TB65jY52V1TXLmke
 HX+1jBckL/Pfes3tRlQPzQNp2D24sGy602lAFynC/mnmuSXdN2yoBrhAodSYogcA4tV9
 Wl3kJCExfCYUhajw0lcDj1vHn1NoWjG6hGHeYd2olZ0MEVy1Fw3P9R1OZwALAyn79ga3
 iz+g==
X-Gm-Message-State: AOJu0YzvVOFHQZT0X8gu26tVYviAH7xcvGJGQzdxHNr5iwlqCPpL0+Ym
 ZPPHPgkOvX0Rmf6Mu/HwF33jIQhpxExnCS9jrxS+Qy/C1CpCZWGPeNurR1EABX57gz4niZbDKgG
 mRzBAeowYxUe7FHA2GFNkETEFs7c=
X-Received: by 2002:a67:e18e:0:b0:457:e881:32c6 with SMTP id
 e14-20020a67e18e000000b00457e88132c6mr13798621vsl.11.1698841715794; 
 Wed, 01 Nov 2023 05:28:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5xZRhFJkZUuMz9MHYvdDDm8U4nZWnxSp2EBYIqszKENc0ZCWoqZbhP+IOq1+QeVOhGQHvinkQUi3iEfyF2zc=
X-Received: by 2002:a67:e18e:0:b0:457:e881:32c6 with SMTP id
 e14-20020a67e18e000000b00457e88132c6mr13798598vsl.11.1698841715506; Wed, 01
 Nov 2023 05:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231025140109.340441-1-pvorel@suse.cz>
 <CAASaF6yVnrBK0UCxj4HRbi_scm84KS5Jm_xi8rUEuXcZXo=rZQ@mail.gmail.com>
 <20231101111722.GB896131@pevik>
In-Reply-To: <20231101111722.GB896131@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 1 Nov 2023 13:28:19 +0100
Message-ID: <CAASaF6zVpEvG8NXLOyKo5Lp9rKcbg_=5_=xRRpVFKjRaqGzL6w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 1
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Remove CentOS 7 support
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
Cc: Ulrich Hecht <uli@kernel.org>, Martin Doucha <martin.doucha@suse.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBOb3YgMSwgMjAyMyBhdCAxMjoxN+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIGFsbCwKPgo+IE5vdGUgZm9yIG15c2VsZjogdHlwbyBpbiBzdWJq
ZWN0IHMvUmVBcGxhY2UvUmVwbGFjZS8KPgo+ID4gPiB3ZSByZWNlbnRseSBoYWQgeWV0IGFub3Ro
ZXIgcmVncmVzc2lvbiBvbiBvbGQgQ2VudE9TIDcgKGtlcm5lbCAzLjEwLAo+ID4gPiBnbGliYyAy
LjE3LCBnY2MgNC44LjUgWzFdLiBUaGF0IGJyb3VnaHQgbWUgdG8gdGhlIHF1ZXN0aW9uIGlmIHdl
IHN0aWxsCj4gPiA+IHdhbnQgdG8gc3VwcG9ydCBpdC4KPgo+ID4gPiBBbHRob3VnaCB3ZSB0ZXN0
IGluIFNVU0UgYWxzbyB2ZXJ5IG9sZCBTTEVTIHJlbGVhc2VzLCB0aGVzZSBhcmUgdGVzdGVkCj4g
PiA+IHdpdGggb2xkZXIgTFRQIHJlbGVhc2VzLiBJIHN1cHBvc2UgUmVkIEhhdCBkb2VzIHRoZSBz
YW1lIHdpdGggUkhFTAo+ID4gPiAoTGksIEphbiwgcGxlYXNlIGNvcnJlY3QgbWUgaWYgbm90LCBv
ciBmZWVsIGZyZWUgdG8gaW50cm9kdWNlIGFub3RoZXIKPiA+ID4gQ2VudE9TIHZlcnNpb24sIGFz
IHRoZXJlIHdpbGwgbm9uZSB3aXRoIHRoaXMgcGF0Y2hzZXQpLCB0aHVzIHdoeQo+ID4gPiBwcmV0
ZW5kIGN1cnJlbnQgTFRQIGlzIHVzZWZ1bCBvbiB0aGVzZSBvbGQgcmVsZWFzZXMuCj4KPiA+IExv
b2tpbmcgYXQgaW50ZXJuYWwgTFRQIHRlc3Qgd3JhcHBlciwgaXQncyB1c2luZyBvbGRlciBMVFAg
cmVsZWFzZSBmb3IgUkhFTDcsCj4gPiBzbyB5b3VyIGFzc3VtcHRpb24gYXBwZWFycyB0byBiZSBj
b3JyZWN0Lgo+Cj4KPiA+ID4gSSB3b25kZXIgd2hvIGlzIGFjdHVhbGx5IGludGVyZXN0ZWQgaW4g
a2VlcGluZyBMVFAgY29tcGlsYWJsZSBmb3IgQ2VudE9TIDcuCj4gPiA+IEFjY29yZGluZyB0byBk
aXN0cm93YXRjaCBpdCBFT0wgaW4gMjAyNC0wNiBbMl0sIGJ1dCBkb2VzIGFueWJvZHkgZXZlbiBy
dW4gbmV3Cj4gPiA+IExUUCBvbiBpdC4gSWYgeWVzLCBwbGVhc2Ugc3BlYWsgdXAsIGJ1dCBJJ2Qg
ZXhwZWN0IHRoYXQgcGVyc29uIHRvCj4gPiA+IGFjdHVhbGx5IG1haW50YWluIENJIGZhaWx1cmVz
Lgo+Cj4gPiBUaGVyZSdzIHBsYW5uZWQgRUxTIHVudGlsIDIwMjYsIGJ1dCBJJ2QgZXhwZWN0IHRo
YXQgY29udGludWVzIHVzaW5nCj4gPiBvbGRlciBMVFAgZm9yIHRlc3RzLgo+Cj4gQExpLCBKYW4g
Q291bGQgeW91IHBsZWFzZSBhZGQgeW91ciBBQlQgb3IgUkJUPwoKQWNrZWQtYnk6IEphbiBTdGFu
Y2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoKPiBBbHNvLCBmZWVsIGZyZWUgdG8gYWRkIHF1YXku
aW8vY2VudG9zL2NlbnRvczpzdHJlYW05IG9yIHJvY2t5bGludXg6OSBvcgo+IHJvY2t5bGludXg6
OCBvciB3aGF0ZXZlciBtYWtlcyBzZW5zZSB0byB5b3UuIFRoZXNlIGFyZSB0ZXN0ZWQgaW4KPiBo
dHRwczovL2dpdGh1Yi5jb20vaXB1dGlscy9pcHV0aWxzL2Jsb2IvbWFzdGVyLy5naXRodWIvd29y
a2Zsb3dzL2NpLnltbAo+IChpdCB3b3VsZCBoYXZlIHRvIGJlIGNoZWNrZWQgaWYgY2kvY2VudG9z
LnNoIG5lZWRzIGJlIG1vZGlmaWVkIHRvIHN1cHBvcnQpLgoKQExpOiBEbyB5b3Uga25vdyB3aG8v
aG93IGZyZXF1ZW50bHkgdXBkYXRlcyBjOXMgaW1hZ2U/CgoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
