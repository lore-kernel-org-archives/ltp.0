Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02447C46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 04:09:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CC223CD0A8
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 05:09:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7C463C73BF
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 05:08:52 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C42EE606724
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 05:08:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706069329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=90ntLEJh0weISKEef1MsxCV/2vvMvb6aSeozGuq3pPM=;
 b=HEwaVwLZ+d3aRx30GpLV1N4KM2jORzwXpgniIU1Y7ERVkhKFEjh8P3v72dzgu1esy9aija
 rKAvn1B1UpFc/MO/ZlFFVg6cimc+3DBYz3C3RvAa4GLXIzlLvAslLkMLkcP2IeoxfAGZ/Q
 ONyE+e5n09MyB8rPt0czUxq1WOk/GNw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-2mqxnMyuMxu7-UD0AhhVHw-1; Tue, 23 Jan 2024 23:08:47 -0500
X-MC-Unique: 2mqxnMyuMxu7-UD0AhhVHw-1
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-598a658276cso6812969eaf.2
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 20:08:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706069327; x=1706674127;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=90ntLEJh0weISKEef1MsxCV/2vvMvb6aSeozGuq3pPM=;
 b=LEPdCWpMPMhF+YWr3J8iTVqNmuifOQb/6DNmhpY5GoU8fx2vGQW5/uTomPafBTupsw
 BXwMnyhYe7er4NTAfkiRI6tCbgPDOUGTVuBZijJBCgDiBAXsXExYcprAKQaWpjd8VIid
 8rnj3fYhSOFgAz909bgcy4IRxeN7Ng3cT0UqoF16KhlohfhX6+M7RCtK2EzoMX8PcDJF
 BBcoAPj5pRv2l44PemhJRhabfOmLgo9s1AGAe70fmicOAqr+ghc1VoqnBWB6gQ43+fAC
 8XEGTOwTNpJBpgK2TZZjWJ60XfB40R5vYR8j8dRIhlGwho6GXAO5pC7Sk9f9fPJJuTpq
 rHlg==
X-Gm-Message-State: AOJu0YxEnOhvtQolYUJpIdBe+aHK1oan0+bEfZXfaMIKPQCBiD9BS61/
 EtgGV80Ii2gFnuPlJsT+Hu4fu7zIAkCcimpCcbuEJkjv+5JjZf0cLk2IzWz9DovQDQ3OUTcWPlI
 GN56X+xv3Bm8VeM12P/G9C8CBpjw6z8shQYKKARmNKJU/FRqG78x+I9IrSaOe/drNLu2OBhKODu
 9MQoVGJ/MHrnUHNXo5wv3QO3g=
X-Received: by 2002:a05:6358:e9ce:b0:176:784:5f9e with SMTP id
 hc14-20020a056358e9ce00b0017607845f9emr5403220rwb.34.1706069327172; 
 Tue, 23 Jan 2024 20:08:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE9emC6n8dQqNdagAnubir7g224abQ/5hySGf5Qb0ioDm1MlF2tnrxcYrpxMITcr3hcoKcxjMs09+u6IPD8VN0=
X-Received: by 2002:a05:6358:e9ce:b0:176:784:5f9e with SMTP id
 hc14-20020a056358e9ce00b0017607845f9emr5403208rwb.34.1706069326826; Tue, 23
 Jan 2024 20:08:46 -0800 (PST)
MIME-Version: 1.0
References: <20240123114840.2610533-1-liwang@redhat.com>
 <20240123114840.2610533-5-liwang@redhat.com>
 <20240123121156.GA175806@pevik> <20240123123740.GC175806@pevik>
 <CAEemH2dAG89-4CcX1GsfCwXuD+J5i5FETBU0bf8nK+q+uXgxsw@mail.gmail.com>
 <20240123154735.GC201093@pevik>
In-Reply-To: <20240123154735.GC201093@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Jan 2024 12:08:34 +0800
Message-ID: <CAEemH2esyVuT6ptkT3nNp+YAZMgvBg7andV0i8eMo6OCD9Za9g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V3 4/5] libswap: add function to prealloc
 contiguous file
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

T24gVHVlLCBKYW4gMjMsIDIwMjQgYXQgMTE6NDfigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+ID4gSGkgUGV0ciwKPgo+ID4gT24gVHVlLCBKYW4gMjMsIDIwMjQgYXQg
ODozN+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+ID4gPiBIaSBM
aSwKPgo+ID4gPiA+IEhpIExpLAo+Cj4gPiA+ID4gc3dhcG9mZjAxIGZhaWxzIG9uIFRNUERJUiBv
biBidHJmcyAocmVnYXJkbGVzcyBrZXJuZWwgdmVyc2lvbik6Cj4KPiA+ID4gRllJIGl0IHdvcmtz
IG9uIFR1bWJsZXdlZWQgd2l0aCA2Ljcga2VybmVsLiBJdCdzIGJyb2tlbiBvbiBzb21lIG9sZGVy
Cj4gU0xFUwo+ID4gPiB3aXRoIDUuMTQgYW5kIGFsbCBvbGRlciBrZXJuZWxzLiBJIHN1cHBvc2Ug
d2l0aCBub2NvdyAoZml4ZXMgSQo+IHN1Z2dlc3RlZAo+ID4gPiBwcmV2aW91c2x5KSB3b3VsZCB3
b3JrIGFzIGV4cGVjdGVkIChUUEFTUywgb3IgVENPTkYgb24ga2VybmVsIDwgNS4wKS4KPgo+Cj4g
PiBZb3UncmUgcmlnaHQuCj4KPiA+IFdlIGhhdmUgdG8gZ3VhcmFudGVlIHRoZSBzd2FwZmlsZSBp
cyBhIGNvbnRpZ3VvdXMgZmlsZSB3aGF0ZXZlciB0aGUgRlMKPiB0eXBlCj4gPiBpcy4KPiA+IFNv
IGhlcmUgbWFraW5nIHVzZSBvZiBtYWtlX3N3YXBmaWxlKCkgaXMgYSBoYXJkIHJlcXVpcmVtZW50
Lgo+ID4gQW5kLCBJIGRvbid0IHRoaW5rIHRoZSBmaWxlIGZpcnN0IHdpdGggNjU1MzYgYmxvY2tz
IChpbiBzd2Fwb2ZmMDEpIGlzIG5vdAo+ID4gbmVjZXNzYXJ5Lgo+Cj4gTWF5YmUgbm90LCBidXQg
bm93IHdlIHRlc3Qgb24gc2luZ2xlIHN3YXAgc2l6ZS4gVGVzdGluZyBzbWFsbCBzd2FwIGFuZCBi
aWcKPiBzd2FwCj4gd2FzIElNSE8gbW9yZSB0ZXN0aW5nIGNvdmVyYWdlICh2YXJpb3VzIGZpbGVz
eXN0ZW1zIGJlaGF2ZSBkaWZmZXJlbnRseSBvbgo+IGRpZmZlcmVudCBzaXplKSwgYnV0IGdpdmVu
IHRoaXMgd291bGQgYmUgbW9yZSBpbXBvcnRhbnQgZm9yIHdob2xlCj4gLmFsbF9maWxlc3lzdGVt
cyA9IDEgdGVzdGluZyBJJ20gb2sgd2l0aCB0aGUgY2hhbmdlLgo+CgpPaywgdGhhdCBjb3VsZCBi
ZSBhY2hpZXZlZCBieSBjdXN0b21pemluZyB0aGUgc3dhcCBmaWxlIHNpemUgbGF0ZXIuCkl0J3Mg
bm90IHZlcnkgaGFyZC4gQnV0IG5vdyBJIGRvbid0IHdhbnQgdG8gaW5jcmVhc2UgdGhlIHBhdGNo
c2V0IG51bWJlcgpqdXN0IGZvciBtb3JlIGNvdmVyYWdlLCB0aGF0IHdpbGwgYmUgYSBidXJkZW4g
Zm9yIHJlbGVhc2UgdGVzdGluZyB3b3JrLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
