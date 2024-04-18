Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077A2C4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 05:30:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F2803CFB90
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 07:30:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6BB83CF673
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 07:30:30 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C86AC601E62
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 07:30:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713418228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R5DOmNW9sGGE1ROao0bkd0Sn1IDWP/g6Qcg5NIXL5Yg=;
 b=OTa/jVzs/uIf4iYKy2NvtfL8na60NSSeRU5qXD+LjiUvdEKRYVKqxq5qJj2IWZxilhyQeL
 BB0/kEvg8IjVqget4WREdD2K/RIfvX2EmQmj0Sppx33UXgVmDWrelkmsjzSeYRWDIAsqDF
 1vLnpKSiggjgaHNNRAoRB1vrjgV9vks=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-dwg93nHyOYa7EkOex_Q7yg-1; Thu, 18 Apr 2024 01:30:25 -0400
X-MC-Unique: dwg93nHyOYa7EkOex_Q7yg-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5d396a57ea5so467918a12.2
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 22:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713418225; x=1714023025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R5DOmNW9sGGE1ROao0bkd0Sn1IDWP/g6Qcg5NIXL5Yg=;
 b=aSBLd/cyG0mCSS8LNIbJZ5bSWo9ms5cr+iLAHTZpmp7hWVgv0gkPZUJPUFmPmtQq8Q
 vBsJFNnkmqVbRtMXvFBT/bhIN6yDI4RxE8qot2QVTQK7cdwlSLv9KaOLAN+wDblYZP05
 IgiX+l3F+Km9Uplm5HsmCXMCIEy2DZIjQCIz/hWNJVDGTIrgMirPZIKssb3oOAr0Sjtv
 K7GHaIwSY5p+RUZIlv79Y946ZJFk7D2KEBC67LjUXO4R4uDL7c/1BNHZttiq3eQrbNsM
 dpsVISxvbB1BDVbMN0k2juA5cO5OqY6VwTt5HEMpuCaVX6A4gTvJv9OFvUZbGS8pELvF
 yUnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHB4qAkathi6gwOTG1EY1hQA9ycSLzzIgUl06byNt+anJR4op24/JBfPTSlMakJRRUYa/MymLO7TWvAGbTkzOu91I=
X-Gm-Message-State: AOJu0Yzb62JMKElRLND1wKxfKfFl7jYa71ruyrFf4X8Mu3HGmB0l5g2f
 sNs1KsqWKT8Lcdr9Jn0aE+9Oaicgi9i6R14BNIJxYGz71D4hcTJDYvPZZWkSp4Q4PMCjW4m7x9t
 jD8ZptcABU+B/uDTmC8z/VqdYW+rf4UlADNZZRVd9qiNpqigr0WLn9sM10A0kU6qRx/OjCfiso2
 TzHfN+vKP/iYwikZPXRZ8It/o=
X-Received: by 2002:a05:6a20:2592:b0:1a3:ae12:e610 with SMTP id
 k18-20020a056a20259200b001a3ae12e610mr2414858pzd.35.1713418224921; 
 Wed, 17 Apr 2024 22:30:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuGISi6v6Rj5UHLcazI2wc5YcG2cUjFXiD0FIsiHjfH3O+7frDmDDsNl3zWtkUO7TS4S0JTgx+VliEuj1QZ1M=
X-Received: by 2002:a05:6a20:2592:b0:1a3:ae12:e610 with SMTP id
 k18-20020a056a20259200b001a3ae12e610mr2414843pzd.35.1713418224565; Wed, 17
 Apr 2024 22:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240417090222.707302-1-pvorel@suse.cz> <Zh-eIg51K9UtdQuj@yuki>
 <20240417100611.GA713385@pevik> <Zh-lGL4tU5Z2dSLi@yuki>
 <20240417122418.GB727397@pevik>
 <20240417133749.GA4484@pevik> <Zh_R31-342b-1Alm@yuki>
 <20240417183832.GD35911@pevik>
In-Reply-To: <20240417183832.GD35911@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Apr 2024 13:30:11 +0800
Message-ID: <CAEemH2c5HXra2NreO3OQPU5Szk9TAZDDVL_4kshhV4X1059Uzg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] libswap: Change TWARN message to TINFO
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

T24gVGh1LCBBcHIgMTgsIDIwMjQgYXQgMjozOOKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBIaSEKPiA+ID4gQ2hhbmdpbmcgaXQgdG8ge1NBRkVfLH1NQUtFX1NX
QVBGSUxFX1NJWkUoKSBvbiBhbGwgcGxhY2VzIHdvdWxkIG1lYW4KPiB3ZSBkb24ndCBuZWVkCj4g
PiA+IHtTQUZFXyx9TUFLRV9TV0FQRklMRV9CTEtTKCkgYXQgYWxsLiBUaGVyZWZvcmUgSSB0aGlu
ayB0aGlzIGNoZWNrCj4gc2hvdWxkIGJlCj4gPiA+IHN1cHByZXNzZWQgdG8gVElORk8uIE90aGVy
IG9wdGlvbiBpcyB0byB1c2UgaGlnaCBlbm91Z2ggdmFsdWUgKG1vcmUKPiBibG9ja3MpCj4gPiA+
IChub3Qgc3VyZSBpZiB1c2luZyByZWFsbHkgc21hbGwgc3dhcCBmaWxlIG1ha2VzIHNlbnNlIGFu
eXdheSkuCj4KPiA+IEkgZG8gbm90IHRoaW5rIHRoYXQgd2Ugc2hvdWxkIHVzZSB0b28gc21hbGwg
c3dhcCBmaWxlIGV2ZW4gZm9yIHRoZSBjYXNlCj4gPiB3aGVyZSB3ZSB0cnkgdG8gZGV0ZWN0IGlm
IHN3YXBmaWxlcyBhcmUgc3VwcG9ydGVkLiBDdXJyZW50bHkgaXQgc2VlbXMKPiA+IHRoYXQga2Vy
bmVsIGFjY2VwdHMgc3dhcGZpbGVzIHNtYWxsZXIgdGhhbiBwYWdlIHNpemUsIGJ1dCBpdCBtYXkg
YWxzbwo+ID4gc3RhcnQgcmVqZWN0aW5nIHRoZW0gd2l0aCBFSU5WQUwgaW4gdGhlIGZ1dHVyZS4K
Pgo+ID4gU28gSSB3b3VsZCBrZWVwIHRoZSB3YXJuaW5nIGFuZCByYXRoZXIgdHJpZWQgdG8gZml4
IGFsbCB0aGUgcGFydHMgd2hlcmUKPiA+IHdlIGF0dGVtcHQgdG8gY3JlYXRlIGEgc3dhcGZpbGUg
c21hbGxlciB0aGFuIHBhZ2Ugc2l6ZS4KPgo+ICsxLCBzZXR0aW5nICJjaGFuZ2VzIHJlcXVlc3Rl
ZCIsIEknbGwgc2VuZCB2MiB3aXRoIGhpZ2hlciBudW1iZXIgb2YgYmxvY2tzCj4gdG8KPiBmaXgg
dGhpcy4KPgoKQWdyZWUuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
