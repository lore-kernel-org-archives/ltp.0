Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BB3C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 08:05:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C47523CFBEC
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 09:05:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05D1D3CB37F
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 09:04:50 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 453991A027AF
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 09:04:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710921888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RKoqzJ/Fg85FkVK2eTlhIeDLSJJABgBxelv681OFHvI=;
 b=P+SmWjSck7NuJhnTU8qif56ObaMJt/o4anlgsEfjlaGXtYqYZVfb9nnYh/gq376KR2u9DY
 OfXfD9jXJLj9g0SlXBsw0UkWnS86U0Oki9pSAU0DC1QL3Z6FoU7rKX0Cz74zmqvMtwVlmZ
 a/fNwIa0pvfeTEkor6nDVyKC/wNkMmM=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-dEzINqSfOdOz40Mq4SBhbg-1; Wed, 20 Mar 2024 04:04:46 -0400
X-MC-Unique: dEzINqSfOdOz40Mq4SBhbg-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5c5c8ef7d0dso4427701a12.2
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 01:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710921884; x=1711526684;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RKoqzJ/Fg85FkVK2eTlhIeDLSJJABgBxelv681OFHvI=;
 b=fS5DckrjlDFgrVaY6v+NHJ8jKnEiDU0uMT2gwya3p07Eay8t4ZHfn/NyN1IndKlXsj
 23sAxJWnnXV+ZTCA07rnSWAO+U6c2JgIE0YUABlbO0Ley9YvNyAy9zEZJXld9texzpCn
 g2jiq9T8ASLzCfSOwf4TY6XYcm7Qdy3D0QrxT4IFomCuRtg4S8VipOnTjUSs3Wx6SHQI
 FccaJhM02KRB6G4obQRnjXt+NQA8TOroK/6A/CtBileAGDBXkuDN0UtU2CwC+XD0xZmu
 1SDvAyyflGcLJG/Mv7G9yTKsRG4yPnJIVZe/K38atSYpEEaHtA5ux4BTm+Gri+lVFO3f
 LZFg==
X-Gm-Message-State: AOJu0YzHCpi5+18W95kMSgpzQgx1cfIqlMkQyFD0LXeZtTYAsTPSpQLh
 WXDbo2x7sGi9eaUynbcyo0QnE85BtSeXHFCB7e7/gp9oL5WfCZ3hBuHQfjPvsISFOObRJcyhAnU
 VpGYgdjHJSfZyacjYMPXBBiYFiV/QFGjA7DEX3RgTZRwgJpQ+wLvi+XTthC9bClzSKScpQbGlNB
 ZCYSAjiAp906uDlYkiJ41V5qMyq7oweo0mRJQh
X-Received: by 2002:a05:6a20:8f08:b0:1a1:6a75:1442 with SMTP id
 b8-20020a056a208f0800b001a16a751442mr17251511pzk.11.1710921884479; 
 Wed, 20 Mar 2024 01:04:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4blshymm6Zj526ETsNS/FK19QhObgMWlPYJKjbKcZg2owHQ1CarLM7O8t4sXeIj+QX5VpxLnTD38eFHWNOBM=
X-Received: by 2002:a05:6a20:8f08:b0:1a1:6a75:1442 with SMTP id
 b8-20020a056a208f0800b001a16a751442mr17251494pzk.11.1710921884213; Wed, 20
 Mar 2024 01:04:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240320063218.449072-1-pvorel@suse.cz>
 <CAEemH2eRspxMmD4LEQ-ospJES2BWAHLqhviX_1uSM=-eefnQug@mail.gmail.com>
 <20240320075605.GA457754@pevik>
In-Reply-To: <20240320075605.GA457754@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 20 Mar 2024 16:04:32 +0800
Message-ID: <CAEemH2dRnQUe-j1wwh2ymYRjVRjK2k9F5XvKjgAzVc28_nYExA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] lib: Add tst_selinux_enforcing()
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
Cc: Mete Durlu <meted@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXIgMjAsIDIwMjQgYXQgMzo1NuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksIGFsbCwKPgo+ID4gSGkgUGV0ciwKPgo+ID4gT24gV2VkLCBN
YXIgMjAsIDIwMjQgYXQgMjozMuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90
ZToKPgo+ID4gPiBDby1kZXZlbG9wZWQtYnk6IE1ldGUgRHVybHUgPG1ldGVkQGxpbnV4LmlibS5j
b20+Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+Cj4K
PiA+IFRoaXMgcGF0Y2ggaXMgZG9pbmcgdGhlIHNhbWUgd29yayBhcyBzZWN1cml0eV9nZXRlbmZv
cmNlKCkgd2hpY2ggcHJvdmlkZXMKPiA+IGJ5ICdzZWxpbnV4L3NlbGludXguaCcsIGJ1dCBpdCBp
cyBzdGlsbCB3b3J0aCBoYXZpbmcgaXQgYmVjYXVzZSB3ZSBkbyBub3QKPiA+IHdhbnQgbHRwCj4g
PiBoYXMgbWFueSBleHRyYSBkZXBlbmRlbmNpZXMgKGUuZy4gbGlic2VsaW51eC1kZXZlbCkuCj4K
PiArMQo+Cj4gPiBSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4KPiBU
aGFua3MhCj4KPiA+ID4gLS0tCj4gPiA+IEhpLAo+Cj4gPiA+IEBMaSwgQ3lyaWw6Cj4gPiA+IDEp
IEkgZ3Vlc3Mgd2Ugd2FudCB0byBkaXN0aW5ndWlzaCBFQUNDRVMgZm9yIFNFTGludXggZW5mb3Jj
aW5nLCByaWdodD8KPiA+ID4gSWYgbm90LCB0aGlzIGNvbW1pdCB3b3VsZCBiZSBkcm9wcGVkIGFu
ZCBzZWNvbmQgY29tbWl0IHdvdWxkIGp1c3QgdXNlCj4KPiA+ID4gICAgICAgICBjb25zdCBpbnQg
ZXhwX2VycnNbXSA9IHt0Yy0+ZXhwZWN0ZWRfZXJybm8sIEVBQ0NFU307Cj4KPiA+ID4gICAgICAg
ICBUU1RfRVhQX0ZBSUxfQVJSKGZhbm90aWZ5X21hcmsoZmFub3RpZnlfZmQsIEZBTl9NQVJLX0FE
RCB8Cj4gPiA+IHRjLT5tYXJrLmZsYWdzLAo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAg
dGMtPm1hc2suZmxhZ3MsIGRpcmZkLCBwYXRoKSwKPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgIGV4cF9lcnJzKTsKPgo+ID4gPiAyKSBTb21lIHRpbWUgYWdvIEkgcHJvcG9zZWQgdG8gbWVy
Z2Ugc29tZSBsaWIvKi5jIGZpbGVzLCBub3QKPiA+ID4ganVzdCBoYXZlIHNvIG1hbnkgZmlsZXMg
d2l0aCBzaW5nbGUgZnVuY3Rpb25zIGluIHRoZSBsaWJyYXJ5LiBFLmcuCj4gPiA+IGxpYi90c3Rf
Zmlwcy5jLCBsaWIvdHN0X3NlbGludXguYywgbGliL3RzdF9sb2NrZG93bi5jIGNvdWxkIGJlIG1l
cmdlZAo+ID4gPiBpbnRvIGxpYi90c3Rfc2VjdXJpdHkuYy4gT3IgZG8gd2Ugd2FudCB0byBoYXZl
IHRoZXNlIHNlcGFyYXRlPwo+Cj4KPiA+IEkgdGhpbmsgdGhlIGFuc3dlciBpcyBZZXMuIFRoZXJl
IGFyZSBtb3JlIGFuZCBtb3JlIGxpYi8qLmMgZmlsZXMgd2l0aAo+Cj4gSSByZWFkICJZZXMiIGFz
IHRvIGtlZXAgbGliL3RzdF9zZWxpbnV4LmMsIGxpYi90c3RfbG9ja2Rvd24uYyBhcyBzZXBhcmF0
ZS4KPgoKT2hoLCBzb3JyeSwgSSBkb24ndCBtZWFuIHRoYXQuIE1vcmUgc2VwYXJhdGUgKGJvcmlu
ZyEhISkgZmlsZXMgc2hvdWxkIGJlCmF2b2lkZWQuCgpJIHRoaW5rIEkgc2hvdWxkIHN0ZXAgYXdh
eSBmcm9tIHRoZSBrZXlib2FyZCBub3csIHdhdGNoaW5nIHRvbyBtdWNoIHNjcmVlbgp0aW1lIG1h
a2VzIG1lIGZvb2xpc2ggOikuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
