Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ABECC77B7F
	for <ltp@archiver.kernel.org>; Thu, 11 May 2023 05:48:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4ED03CD5F9
	for <ltp@archiver.kernel.org>; Thu, 11 May 2023 07:48:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DCF13CA0CC
 for <ltp@lists.linux.it>; Thu, 11 May 2023 07:48:34 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 08DCD1A004ED
 for <ltp@lists.linux.it>; Thu, 11 May 2023 07:48:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683784111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7uBRNX8sIZqtp2tqRICVU/uwQXfvEd4k7MJSY8uDzOs=;
 b=CsKvDHvvPV57cBj+2sNJDTKq56zQVAhhiVUW6Gk4HZ374TAW13/wC8+KZ/QahfQhvMtttp
 pWNhR1O2z5BWVovhjbPwcoBclRydmjeiczY67EhiwnP2iSewLLET/foJJeHryp2JLuBkJk
 rxJGW1SFTluTCXqgGzyHb5/jFUP0clY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-ToiXMwE-NsGRfBN8_5_Ekg-1; Thu, 11 May 2023 01:48:29 -0400
X-MC-Unique: ToiXMwE-NsGRfBN8_5_Ekg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f14f266ac3so422283e87.1
 for <ltp@lists.linux.it>; Wed, 10 May 2023 22:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683784107; x=1686376107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7uBRNX8sIZqtp2tqRICVU/uwQXfvEd4k7MJSY8uDzOs=;
 b=gjK2TlQgaID2oYbkUa1WLAkJ6CnLC1sH1q9H0YZnFkRLkY4qBf7obkQlfl42ATB6u2
 R8N/MfBhJn+vl2EYJAgkBz5bkb2MGVo4SkzgIwa1EZhbmgE4yBZT1J7zfvmCvzjuasJx
 hmn8hzDuImQfLipY5B2xVlEt4hueO3WiYzYXUh0khwak75sel+2HsU22PW6B9AOmN1EF
 RFU0DgSuGSJpqSYoNqL7Xqqx/VJftcQ1YWanyeD+6rPT9zOIlA69txDQ1gLy8YVHCOl3
 pSJIQ49SxDEJ4V2qGEmP3qUHvkFKmI8bwHdYzRZwmcZ6LYb9E/SfO89c2v2TpBflompz
 AzIQ==
X-Gm-Message-State: AC+VfDyIejh9guLFO954kTV42MJX5Jo3xCrNSx4m5Lpr4OchIp0cAAlc
 yeKG2FaFOkzfMqnvxP2CAK29mPwy1uqo4fx07vvOW1/PfLmxBMXFhGc5ulNjm7eSIN0RjFu2AtD
 mtS+ofiw1qHRv3NMUuh3ppKKOTtQ=
X-Received: by 2002:ac2:4557:0:b0:4ec:9310:ad4e with SMTP id
 j23-20020ac24557000000b004ec9310ad4emr2675838lfm.33.1683784107769; 
 Wed, 10 May 2023 22:48:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7tp6Gb9VXI3g0+7WDWqlB6lCQt4aTeB5UTMt3h1EbXFJxG0+dfvrzi03qF/u7c3mtEBlEfh19ddc6JiWjdF9M=
X-Received: by 2002:ac2:4557:0:b0:4ec:9310:ad4e with SMTP id
 j23-20020ac24557000000b004ec9310ad4emr2675827lfm.33.1683784107359; Wed, 10
 May 2023 22:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <ZEjsKC6ESB1+mM0H@rei>
 <CAEemH2dESMRqQwLPvf7t20et6i9bG_uzS7OUVEy53TpWkqsFWQ@mail.gmail.com>
 <CAEemH2dUGD_0R-RH7bS4U_qPD+G_na51TaYyNtw3Yt=uQx9nTQ@mail.gmail.com>
 <ZFoSZkkjVXQhdEpe@yuki>
 <CAEemH2fycnWnsMe7sKZn357zj5QZr_Y7+ML0GAAWeQGkASu47g@mail.gmail.com>
 <20230510130347.GA225439@pevik>
In-Reply-To: <20230510130347.GA225439@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 11 May 2023 13:48:15 +0800
Message-ID: <CAEemH2eqtdEjoopsX0gsWgu5z8s6hgcTVAXM85t2n5a4ccYDVg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP release preparations
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Xiao Yang <yangx.jy@cn.fujitsu.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXkgMTAsIDIwMjMgYXQgOTowM+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgQ3lyaWwsIExpLCBvdGhlcnMsCj4KPiBJIHNlZSB3ZSdyZSBzdGls
bCBkaXNjdXNzaW5nIGh1Z2VtbWFwIHRlc3QgaXNzdWVzIHdpdGggRklMRV9QUklOVEYoKS4KPiBE
byB3ZSB3YW50IHRvIHNvbHZlIHRoZXNlIGJlZm9yZSByZWxlYXNlPwo+CgpJIGhhdmUgbWVyZ2Vk
IHRoZSBxdWljayBmaXggd2l0aCBDcnlpbCdzIGFjay4gU28gRklMRV9QUklOVEYoKSBpbXByb3Zl
bWVudAp3b3JrIGNhbiBiZSBkZWxheWVkIGFmdGVyIHJlbGVhc2UuCgoKCj4KPiBCZWNhdXNlIGlm
IHdlIHdhbnQgdG8gcmVsZWFzZSBvbiBGcmlkYXksIHdlIHNob3VsZCBzdGFydCB3cml0aW5nIHJl
bGVhc2UKPiBub3Rlcwo+IGFuZCBhbm5vdW5jZW1lbnQuIFdlJ3JlIG9uIGEgTEFCUyBjb25mZXJl
bmNlIG5leHQgd2Vlay4gQnV0IG5vdCBzdXJlIGlmCj4gaXQncyBhCj4gZ29vZCBpZGVhIHRvIHBv
c3Rwb25lIChDeXJpbCBpcyBhbmQgd2lsbCBiZSBldmVuIG1vcmUgYnVzeSwgSSdsbCBiZSBhd2F5
Cj4gZm9yIGZldwo+IHdlZWtzIGJlZm9yZSB0aGUgZW5kIG9mIHRoZSBtb250aCkuCj4KCklNTywg
aXQncyBPSyB0byByZWxlYXNlIG9uIEZyaWRheSwgbmV3IHRlc3QgYmFzZWQgb24gdGhlIGxhdGVz
dCBjb21taXQKbG9va3MgZ29vZC4KCgoKPgo+IEZyb20gdGhlIGxpc3Qgd2UgYWdyZWVkIHByZXZp
b3VzbHkgWzFdOgo+Cj4gICAgIC0gYW5ub3VuY2VtZW50IGVtYWlsLAo+ICAgICAtIGNvbGxlY3Rp
bmcgcGF0Y2ggbGlzdHMgZm9yIGEgbmV3IHJlbGVhc2UsCj4gICAgIC0gd3JpdGluZyByZWxlYXNl
IG5vdGVzLCBvciBwYXBlcndvcmssCj4gICAgICAgICAtIG5ldyByZWxlYXNlIGNvbW1pdCBhbmQg
dGFnIGFuZCBjcmVhdGUgcmVsZWFzZSBpbiBnaXRodWIgZnJvbSBpdAo+IChub3QgaW4gWzFdLCBi
dXQgb2J2aW91cykKPiAgICAgLSB1cGxvYWRpbmcgdGFyYmFsbHMKPiAgICAgLSBwcmUtdGVzdGlu
ZyBhZ2FpbnN0IGRpZmZlcmVudCBMaW51eCBkaXN0cmlidXRpb24KPgo+IEknbGwgY2FuIGRvLCB3
aGF0IEkgZGlkIHByZXZpb3VzbHk6Cj4gICAgICAgICAtIG5ldyByZWxlYXNlIGNvbW1pdCBhbmQg
dGFnIGFuZCBjcmVhdGUgcmVsZWFzZSBpbiBnaXRodWIgZnJvbSBpdAo+ICAgICAtIHVwbG9hZGlu
ZyB0YXJiYWxscwo+ICAgICAgICAgLSByZWxlYXNlIG5vdGVzIGZvciBzaGVsbCBBUEkgKG1vc3Rs
eSBuZXR3b3JrIHNoZWxsIEFQSSkKPgo+IEl0J2QgYmUgYmlnIGhlbHAgaWYgQ3lyaWwgbWFuYWdl
ZCB0byBkbyByZWxlYXNlIG5vdGVzIGFuZCB0aGUgYW5ub3VuY2VtZW50Lgo+Cj4gS2luZCByZWdh
cmRzLAo+IFBldHIKPgo+IFsxXQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC9DQUVlbUgy
ZVNKUS1fMzBfWTNBNTY3b3FCRlNPbz0xdHQ3TEpNdFBxX0JvZGpWTnNtOHdAbWFpbC5nbWFpbC5j
b20vCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
