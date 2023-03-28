Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB86C76196
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 08:30:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EC083CCB32
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 10:30:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50A2E3CB238
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 10:30:42 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.145.221.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F21C91000A36
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 10:30:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679992239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZAzl+R66IdysBPxjT0YYPVRuXnwfuAkcvKRLCdkonk=;
 b=heXGrUbb2GVzMYDpCFTStZsmYIb8yAlEJCBl15BYL7pzgLXqtiNda7/lAiKIfheMY2awIE
 ufxn8vY1JOPRHUygi0HwUPkYfncXGSKTq0oyJPRTiyTi9YIiTlCYcmmVfNrFolI+9Njo4C
 G9QXwpNHnzz85IBnsB0mqaTsuIIpNFs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-fhd2xqs9OCy8CWQ0LiZCqw-1; Tue, 28 Mar 2023 04:30:38 -0400
X-MC-Unique: fhd2xqs9OCy8CWQ0LiZCqw-1
Received: by mail-wr1-f70.google.com with SMTP id
 e15-20020adfa44f000000b002d7ea9d6ef0so997124wra.8
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 01:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679992236;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ZAzl+R66IdysBPxjT0YYPVRuXnwfuAkcvKRLCdkonk=;
 b=NevruPriI3uJf7YaSIFUmlk2DoMsfxgqMg6/UaJ33OYfvuYGbw9BxLVuohWveSb3rh
 NPCIKqbRjNFmcnzLvCSMYzT/gAJMrZ5m7K1/4axGjIr7eam9BfiT3QUcmBkS9PBJr9s2
 Qo0R4Gf2YmynPsXAUhHhgQsDVh1RdRBx6vjXraPqLMawXIcfikbaNPvXpIFSF3AdaXRy
 K7Gllp9mD64NBhlKoNHRj6gDN/KzSB0On1R04+A/QTs7x8uPcM0hbEJjrkiP9nFmH6nq
 47rv98v115BbusFA0b4QqcxccV8LRJDCiDBTz2P0hHt8M/DqkmX5ShyXIN662VfNX9Y1
 oN1w==
X-Gm-Message-State: AO0yUKU1hHHFVVoecELBC1onPn4tA2TtQJmu0aMsOrParkxqbuiJcqdW
 f7NcDsK9y4PI23oWzGIzrN9SwWyOdpRsfmqTxEcuQ78vRKwHbcFIBfIGGH71IW0GlGXHwT5D9Cq
 A1Piu6tC1kIcPzFduV+U5L+F/6TnuscSR+6OkuQ==
X-Received: by 2002:a7b:ce8f:0:b0:3ed:c669:8a13 with SMTP id
 q15-20020a7bce8f000000b003edc6698a13mr3169212wmj.8.1679992236585; 
 Tue, 28 Mar 2023 01:30:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set+fTIKC4VYH3QrXo5lo1gRECFi38acAPD+IVrNu77jEvF1QNxmFOwfWqytAP7sc1MMPrFab3WLqNur+R7VYjSM=
X-Received: by 2002:a7b:ce8f:0:b0:3ed:c669:8a13 with SMTP id
 q15-20020a7bce8f000000b003edc6698a13mr3169209wmj.8.1679992236340; Tue, 28 Mar
 2023 01:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230323121330.92244-1-paulson@zilogic.com>
 <20230324103334.GA557284@pevik>
 <CA+O3cCRGPfMP2EVigECgJ8c0Uo-yd7JUm64wSgvvgxoRqe7-Jw@mail.gmail.com>
 <CAEemH2e69a5DOq9eqJVau8YCENZchm8miOH3upQY_Pi6SUFyng@mail.gmail.com>
 <20230328081710.GB743322@pevik>
In-Reply-To: <20230328081710.GB743322@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Mar 2023 16:30:25 +0800
Message-ID: <CAEemH2cKfGMdLHut7x5QfDkdsoX_stCzxXntei4msCRZ7PeBsA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Added test for mmap() with MAP_SHARED_VALIDATE.
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
Cc: ltp@lists.linux.it, Paulson Raja L <lpaulsonraja@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXIgMjgsIDIwMjMgYXQgNDoxN+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIExpLAo+Cj4gPiBIaSBQYXVsc29uLCBQZXRyLAo+Cj4gPiBQYXVs
c29uIFJhamEgTCA8bHBhdWxzb25yYWphQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPiA+ID4gSGkgUGV0
ciBWb3JlbCwKPiA+ID4gICBUaGFua3MgZm9yIHRoZSBjb21tZW50cywgSSBoYXZlIGp1c3Qgc3Rh
cnRlZCBjb250cmlidXRpbmcgdG8gTFRQLCBhbmQKPiA+ID4gdGhpcyBpcyBteSBmaXJzdCBwYXRj
aC4gSSBhZ3JlZSB0byBtZXJnZSBpdCBhcyBpcy4KPgo+ID4gR29vZCB0byBzZWUgYSBuZXcgY2Fz
ZSBmb3IgTUFQX1NIQVJFRF9WQUxJREFURS4KPgo+ID4gQXMgdGhpcyBpcyB0aGUgZmlyc3QgdGVz
dCB0byBjb3ZlciB0aGUgbmV3IGZsYWdzIGFyZ3VtZW50LCBzbyBJJ20KPiA+IHdvbmRlcmluZyBj
YW4gd2UgYWRkIHRoZSBmdW5jdGlvbmFsIHZlcmlmaWNhdGlvbiB0byBjaGVjayBpZgo+ID4gdGhp
cyB3b3JrcyBjb3JyZWN0bHkgZm9yIG1hcHBpbmcgYSB2YWxpZCBzaGFyZWQgbWVtb3J5IHdoaWNo
Cj4gPiBlcXVhbCB0byB0aGUgYmVoYXZpb3Igb2YgTUFQX1NIQVJFRD8KPiA+IChvciBkbyB0aGlz
IGluIGEgc2VwYXJhdGUgcGF0Y2gpCj4gKzEKPgo+ID4gQnV0IGFueXdheSwgSSdkIHN1Z2dlc3Qg
eW91IHNlbmQgYSBwYXRjaCBWMiBmb3IgYWNoaWV2aW5nIGFsbAo+ID4gcmVxdWVzdGVkIGNoYW5n
ZXMuCj4KPiBMaSwgaWYgeW91IGRvbid0IG1pbmQsIEknbGwgbWVyZ2UgInYyIiBJIHByZXBhcmVk
IFsxXSAocGFydCBvZgo+IHBhdWxzb24vbW1hcC5maXhlcyBicmFuY2ggaW4gbXkgZm9yaykuIENh
biBJIGFkZCB5b3VyIFJldmlld2VkLWJ5IHRhZz8gQXMgdGhlCj4gd29yayBpcyBhbHJlYWR5IGRv
bmUsIEknZCBwcmVmZXIgdG8gcG9zdHBvbmUgdGhlIHdvcmsgeW91IHByb3Bvc2UgdG8gc2VwYXJh
dGUKPiBwYXRjaCBhZnRlci4KCk9mIGNvdXJzZSB5ZXMhISBGZWVsIGZyZWUgdG8gZG8gdGhhdC4K
Ck15IHN1Z2dlc3Rpb24gaXMgb25seSB0byBQYXVsc29uIGZvciBmYW1pbGlhcml0eSB3aXRoIHRo
ZSBwYXRjaApjb250cmlidXRlIHdvcmtmbG93LApidXQgaGUgY2FuIGdldCB0byBrbm93IHRoaXMg
YnkgeW91ciBvcGVyYXRpb24gdG9vLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
