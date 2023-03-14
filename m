Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BFCC61DA4
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 01:44:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D23F83CD586
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 02:44:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 542923CA013
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 02:43:51 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 771E2100061A
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 02:43:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678758228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=po/mMymFdW1UhbqBvXJVeiyHofaEW86tKu308PutPAk=;
 b=CuZiwnEmlSFnn9YFx2eAo47O0XJ+6Dn5+PIzeaJGR0XYzX8tV/ZDzEeIe9PVehcSpSdyQz
 Ky9DdZ9jlj7JqoucHK+ohFu7ezusfRvIBGOvmbvwyLmm1V3QiTqza9lFqTE1uLAGYCnL8V
 eOH5G9voLOB39QTlKOi5ipHTBrTcJRE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-TF2LK2e1PzmQpYpxUgJm9A-1; Mon, 13 Mar 2023 21:43:44 -0400
X-MC-Unique: TF2LK2e1PzmQpYpxUgJm9A-1
Received: by mail-io1-f71.google.com with SMTP id
 r25-20020a056602235900b0074d472df653so7071593iot.2
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 18:43:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678758224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=po/mMymFdW1UhbqBvXJVeiyHofaEW86tKu308PutPAk=;
 b=m+B5FdeSCgj9idjzIFlJa4URCzTPnQXowJp3S8kULlSSlXxLyqFJAqQV3HgTWFJn72
 1jMQTXYQgSJODnSuQY1c0vQNVB+ZAn030o+pToIyyUC+N5WDAmMvanDdccZjnb55+sZo
 5SXo7hynRifkhQPfA0w68QS36Ps1NiQfFY912yXAcVrTWOTzW/mnuEpT6xgDoei9sRXc
 R+ojKKEThAnm8LUTNeeFg01MYlCDT6AN7237EFMXfj08kGAFb53/0rfSHC5PCfZVnRoy
 0YhauU8x/sBUnt0YEwT5zKiYx9Vsenx6eVGJKL9HXiHLU2ESnt3bCCp0KN5iMt/cbWuV
 rhiQ==
X-Gm-Message-State: AO0yUKVoRDe3U+UxvYOb59ym7NSNJF+kpfm/30i9Uu170mtb9+w9r8yW
 Rg9woOGGhkHCSz+s/C7R50WjK5+eNo3/CuI3LzZys+1N8l3xrQPyaCNVm9W0uycfe4YmnJVpSe3
 g51L+2cD3rl30G6Bul2q3Yi9Ijw==
X-Received: by 2002:a05:6e02:5cd:b0:322:eaaf:7c6c with SMTP id
 l13-20020a056e0205cd00b00322eaaf7c6cmr772776ils.4.1678758223981; 
 Mon, 13 Mar 2023 18:43:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set+gvTfWadCdGA2/YfVGg5L2mjtBpNJwVszuigEUZEiFNKPzuxC09pd2JdFZ7ZCa5f0gLKO6QWPh9YxUb6+6Fvk=
X-Received: by 2002:a05:6e02:5cd:b0:322:eaaf:7c6c with SMTP id
 l13-20020a056e0205cd00b00322eaaf7c6cmr772765ils.4.1678758223340; Mon, 13 Mar
 2023 18:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230309085454.735531-1-pifang@redhat.com>
 <20230313222437.GA27892@pevik>
In-Reply-To: <20230313222437.GA27892@pevik>
From: Ping Fang <pifang@redhat.com>
Date: Tue, 14 Mar 2023 09:43:07 +0800
Message-ID: <CANKfEn6YtZRnFJYAePRg3e7W2yESMuVd=Lh4r4b9TpgUtGdYBQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] setfsuid02_16: Fix uid -1 too large for
 testing 16-bit version
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

SGkgUGV0ciwKCk9uIFR1ZSwgTWFyIDE0LCAyMDIzIGF0IDY6MzLigK9BTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIFBpbmcsCj4KPiA+IF9fa2VybmVsX29sZF91aWRf
dCBpcyBub3QgZGVmaW5lZCBhcyAxNmJpdCBvbiBzMzkwLCBwcGM2NGxlCj4KPiBJIHN1cHBvc2Ug
bGltaXRhdGlvbiBvbiBzMzkwIGlzIGJlY2F1c2UgX19rZXJuZWxfb2xkX3VpZF90IGlzIGd1YXJk
ZWQgb25seQo+IGZvcgo+IGtlcm5lbCwgcmlnaHQ/Cj4KClllcywgdXNlcnNwYWNlIGhlYWRlciB3
aWxsIHVzZSBkZWZpbml0aW9uIGluCi91c3IvaW5jbHVkZS9hc20tZ2VuZXJpYy9wb3NpeF90eXBl
cy5oCnVuc2lnbmVkIGludCBicmVhayB0aGUgc2l6ZSBjaGVjay4KCj4KPiBhcmNoL3MzOTAvaW5j
bHVkZS91YXBpL2FzbS9wb3NpeF90eXBlcy5oCj4gI2lmZGVmIF9fS0VSTkVMX18KPiB0eXBlZGVm
IHVuc2lnbmVkIHNob3J0IF9fa2VybmVsX29sZF91aWRfdDsKPiB0eXBlZGVmIHVuc2lnbmVkIHNo
b3J0IF9fa2VybmVsX29sZF9naWRfdDsKPiAjZGVmaW5lIF9fa2VybmVsX29sZF91aWRfdCBfX2tl
cm5lbF9vbGRfdWlkX3QKPiAjZW5kaWYKPgo+ID4gVGhlbiAtMSB3aWxsIGJlIHRyYW5zbGF0ZWQg
aW50byBVSU5UX01BWCBmYWlscyB0aGUgc2l6ZSBjaGVjay4KPiA+IHMzOTAsIHBwYzY0bGUgdXNl
IGRlZmluaXRpb24gaW4gL3Vzci9pbmNsdWRlL2FzbS1nZW5lcmljL3Bvc2l4X3R5cGVzLmgKPiBC
VFcgZG8geW91IHRlc3QgTFRQIHN5c2NhbGxzIG9uIHM5MzAgYW5kIHBwYyAoMzJiaXQpPwo+CgpJ
IGRvbid0IGhhdmUgdGhlc2UgbWFjaGluZXMgYXQgaGFuZC4KCj4KPiBLaW5kIHJlZ2FyZHMsCj4g
UGV0cgo+Cj4KCi0tIAoqLS0qClRoYW5rcyAmIFJlZ2FyZHMsCipQaW5nIEZhbmcqCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
