Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6373FC4332F
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 14:15:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 33CCE3CE9C6
	for <ltp@archiver.kernel.org>; Wed,  1 Nov 2023 15:15:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1AB753CC870
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 15:14:56 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1C140200104
 for <ltp@lists.linux.it>; Wed,  1 Nov 2023 15:14:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698848093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8fTRsr6tRg9Ug1cB85UsWkIjjZHjBBuWT+aBFd23W4Q=;
 b=FdVbFBkSKehcqAnXZRSaKsOOu9MAD33G9H7baBKK/ZmtkUCvBTF12+hKqnFLhShrwPg21z
 O2mX4rivGMRdM31rDAk+PCM7Bl8ZswEDidN8aBDtWdcla7F+NgAbKPF6+7x12395N8H23E
 xc7XRLsUSQLicBtTnHNu3s5qE5MVyh8=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-77oRltXqPAiyJ8Z6GyaaIw-1; Wed, 01 Nov 2023 10:14:52 -0400
X-MC-Unique: 77oRltXqPAiyJ8Z6GyaaIw-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7b6e3ddb27fso2445090241.3
 for <ltp@lists.linux.it>; Wed, 01 Nov 2023 07:14:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698848091; x=1699452891;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8fTRsr6tRg9Ug1cB85UsWkIjjZHjBBuWT+aBFd23W4Q=;
 b=FBufc/B/R0CR4CjYBR8JVBrGq26Xxs5rLTswQg793WEw/W45u+LgjpuFyBUiXdii5U
 fMXgMgcnjObRja9qKC+wcN1BBy1fi9CXlDSvhWMP/neQJ2nklXBLuMNcoqSy6c7rNKM8
 O6E+C1+NK7LrNuTaOtSpwN6lph3vyuvQ1jEUjR1VR5AMwz2IkcCQswFxcy2iJS9u9oOd
 za2ef6JI0+DM9Ad9W1br0nbHZ1+nsoUxTUyBt0M6bysDXHUEsNcdtV0pRr3MKQOLvHmx
 Vxxy13gWxhyCznA2QFUigb+bnTlUnvH5t35DLaBat5EO5R0jEr5SrgxWD8U09vLHnqbn
 Br9g==
X-Gm-Message-State: AOJu0YzlfdVikv1gCf8k+0TfP61+MlvIUB2DDWbHnQHj8eIg2+fc6Wgw
 pTvTjpYLgPeArnb9v437eqRWjXwz0dHoRiVp4cd9U32Sv9D1vylOuIEbiV9PvaWkX/zZXMqpPGw
 IR+w4s4MVeVF3kgna1+REmjl7nEU=
X-Received: by 2002:a67:c30c:0:b0:457:c49c:bc63 with SMTP id
 r12-20020a67c30c000000b00457c49cbc63mr15096490vsj.6.1698848091414; 
 Wed, 01 Nov 2023 07:14:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQe9wApc90LwW4DRJGuB0MScyPouAtpo3TNX+uefSYjLKG7WJ7YY/ngcVBegX1j9GeDo2Ibj6YbtgeYSeRkZ8=
X-Received: by 2002:a67:c30c:0:b0:457:c49c:bc63 with SMTP id
 r12-20020a67c30c000000b00457c49cbc63mr15096394vsj.6.1698848089715; Wed, 01
 Nov 2023 07:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <875y33vsks.fsf@suse.de> <87lebpu02a.fsf@suse.de>
 <87msvxst71.fsf@suse.de> <20231101101200.GB884786@pevik>
In-Reply-To: <20231101101200.GB884786@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 1 Nov 2023 15:14:33 +0100
Message-ID: <CAASaF6zhLkdhpsbJqEZVyKxg6bHwG_iNzpYPrGumzY8PO-5saw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 1st of November 09:00 UTC
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
Cc: Andrea Cervesato <acervesato@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBOb3YgMSwgMjAyMyBhdCAxMToxMuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIGFsbCwKPgo+ID4gSGVsbG8sCj4KPiA+IFRoYW5rcyB0byBldmVy
eW9uZSB3aG8gYXR0ZW5kZWQgdGhlIG1lZXRpbmcuIFNvbWUgb3V0Y29tZXM6Cj4gQWxzbyB0aGFu
a3MgdG8gYWxsIGF0dGVuZGVycy4KPgo+ID4gMS4gVGhlcmUgd2VyZSBhdWRpbyBhbmQgY29ubmVj
dGlvbiBpc3N1ZXMgd2l0aCBKaXRzaSwgd2Ugc2hvdWxkIHRyeQo+ID4gICAgc29tZXRoaW5nIGVs
c2UgbmV4dCB0aW1lCj4KPiBDb3VsZCBhbnlib2R5IHRlc3QgaWYgbWVldCBmcm9tIGdvb2dsZSB3
b3JrcyBmb3IgaGltPwo+IGh0dHBzOi8vbWVldC5nb29nbGUuY29tL3VkYy1uY3JzLXd4eAoKSSB0
cmllZCwgaXQncyB3YWl0aW5nIGZvciBzb21lb25lIHRvIGxldCBtZSBpbi4KQnV0IEkgZG9uJ3Qg
ZXhwZWN0IGlzc3VlcyAoYXQgbGVhc3QgZm9yIG1lL0xpKSwgd2UgZG8gdXNlIGl0IGludGVybmFs
bHkuCgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+ID4gMi4gV2UnbGwgbWFrZSBiZXN0IGVm
Zm9ydHMgdG8gY2hhc2UgcmV2aWV3ZXJzIGZvciB0aGVpciB0YWdzLCBidXQgd2UKPiA+ICAgIGRv
bid0IGhhdmUgYSBiZXR0ZXIgc29sdXRpb24gZm9yIHRyYWNraW5nIGNvbnRyaWJ1dGlvbnMgdG8g
cmV2aWV3Lgo+Cj4gPiAzLiBJJ2xsIGJlIG1vcmUgYWdncmVzc2l2ZSBpbiBhZGRpbmcgY2hhbmdl
cyByZXF1ZXN0ZWQuIE1vc3Qgb2YgdGhlCj4gPiAgICByZXNwb25zaWJpbGl0eSBpcyB3aXRoIGNv
bnRyaWJ1dG9ycyB0byByZW1lbWJlciB0byByZXN1Ym1pdCB0aGVpciBvd24KPiA+ICAgIHBhdGNo
ZXMuCj4KPiA+IDQuIFBldHIgdm9yZWwgd2lsbCBtb3ZlIHBhdGNod29yayBpbnN0YW5jZXMuIFdl
IGFjY2VwdCB0aGVyZSB3aWxsIGJlCj4gPiAgICBpc3N1ZXMgY2F1c2VkIGJ5IHRoZSBjaGFuZ2Vv
dmVyLgo+Cj4gPiA1LiAzMCBtaW51dGVzIGlzIGdvb2QgbWVldGluZyB0aW1lIChJTU8gMTUtMzAg
bWludXRlcyBpcyBmaW5lKQo+Cj4gPiA2LiBXZSBzaGFsbCB3cml0ZSBkb3duIGFuIGFnZW5kYSBu
ZXh0IHRpbWUKPgo+ID4gUmljaGFyZCBQYWxldGhvcnBlIDxycGFsZXRob3JwZUBzdXNlLmRlPiB3
cml0ZXM6Cj4KPiA+ID4gSGVsbG8sCj4KPiA+ID4gQWZ0ZXIgcmV2aWV3aW5nIHRoZSByZXNwb25z
ZXMgdG8gdGhlIFJGQyBJIGhhdmUgY29tZSB1cCB3aXRoIHRoZQo+ID4gPiBmb2xsb3dpbmcgbWVl
dGluZyBkZXRhaWxzLgo+Cj4gPiA+IFRpbWUgYW5kIGRhdGU6IEZpcnN0IFdlZG5lc2RheSBlYWNo
IG1vbnRoIGF0IDA5OjAwIFVUQy4KPiA+ID4gUGxhdGZvcm06IGh0dHBzOi8vbWVldC5qaXQuc2kv
bGludXgtdGVzdC1wcm9qZWN0Cj4KPiA+ID4gVGhlIGZpcnN0IG1lZXRpbmcgd2lsbCBiZSBvbiB0
aGUgMXN0IG9mIE5vdmVtYmVyIGF0IDA5OjAwIFVUQy4KPgo+ID4gPiBJIGhhdmVuJ3QgdHJpZWQg
dG8gYWRkcmVzcyB0aGUgbGFjayBvZiBjaGF0IGJyb3VnaHQgdXAgYnkgTGkuIEkgc3VnZ2VzdAo+
ID4gPiB0cnlpbmcgSml0c2kgYW5kIGlmIHRoZXJlIGFyZSBpc3N1ZXMgdGhlbiB3ZSBnbyBmcm9t
IHRoZXJlLgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
