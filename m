Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C286EC001E0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 10:43:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01CA43CCEF9
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 12:43:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 062823C848A
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 12:43:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 49BAF60029F
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 12:42:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698057764;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PppOmhEscmnm0pVCNUXfeEd240iexjXLwy0ie85Tdzo=;
 b=bScvfNbjf1cypV0evbur4kZF6zwOSo8vmjcJxrkkXSkjkpzbHRpTIwJ5ybtSy7L7n7wNzv
 uYZxWf3belg6M946DrkhwveYNvoqSXBfYX9M4Op5Z4KngQV4XbqbTM2KWezfJ3ZYYZ0fdH
 rEcT2YGjWvtI5+ZheIuz4VS6EnDsrbM=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-Und7Ph1FOaeMchrpTUZ3-w-1; Mon, 23 Oct 2023 06:42:42 -0400
X-MC-Unique: Und7Ph1FOaeMchrpTUZ3-w-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-4585c139eb0so5084802137.0
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 03:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698057762; x=1698662562;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PppOmhEscmnm0pVCNUXfeEd240iexjXLwy0ie85Tdzo=;
 b=KPSfpRdaXLNnLTtiDzHkTO9kMSLdStMmOaodvB2Q+5E46qA655IdVNf/kumZh1ShNh
 DRaft8Qq+5mh/k9fPSfX84D87KAqTAYQ8/UPnbKefTbXhyvGoZqQwu7QDoBVGQ+6PFn4
 hjnZ9OePTSPGF/S0wEyeZEU+FuK8Qr9WLWzhb9S5rqix2JjXnP40r2tX+4TPRi3GCKAD
 Unxynbvy8UrHBfun7uKMfuM/b9hnAaX0AS6SuCdj+UbbtO/PkPi3peTo7EfTqjeJh1vz
 m/Kjt7R2iX5+kroXvTanZJtr+VUZrdIbVSjraIBNW7a7TV7RtGjL2p+hIT47jY2m78pe
 XAUQ==
X-Gm-Message-State: AOJu0YytpWJUCIzKPjK6ihb0XduY5hgcSEwBjsIuVvtjkxYPPxcGcS7v
 wi1LI22WJdBkJl9K/31Ce+yrN8s10YlxOUsjmU9/e9NJXOSYAxBjLch/LVckdXH5fwTN4J+glsg
 aN+acOPJCD7stvrvJSNgSC1aeoPi4ar5+BFw=
X-Received: by 2002:a05:6102:3ca3:b0:457:cd1d:b877 with SMTP id
 c35-20020a0561023ca300b00457cd1db877mr7385922vsv.4.1698057761987; 
 Mon, 23 Oct 2023 03:42:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5CPe9TSa5l4IF3CdTGrMVbWWV1hGRuteeQi9yX88ci65nTfy0nylYij0iiShpJUDq/cr8OORXDemGTBd9Ci0=
X-Received: by 2002:a05:6102:3ca3:b0:457:cd1d:b877 with SMTP id
 c35-20020a0561023ca300b00457cd1db877mr7385917vsv.4.1698057761787; Mon, 23 Oct
 2023 03:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <2800f26d04df5fdffcff170224154c44b6ebc23f.1698041671.git.jstancek@redhat.com>
 <ZTYuoDRsgzdVRHfT@yuki> <20231023102030.GA18920@pevik>
In-Reply-To: <20231023102030.GA18920@pevik>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 23 Oct 2023 12:43:14 +0200
Message-ID: <CAASaF6z4tkzKyhRTsGMbf1TwbezKJmTP6-D481s4gasuNJDz2g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH COMMITTED] syscalls/writev07: add note with known
 kernel fixes for this test
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

T24gTW9uLCBPY3QgMjMsIDIwMjMgYXQgMTI6MjDigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cj4KPiBIaSBKYW4sIEN5cmlsLAo+Cj4gPiBIaSEKPiA+ID4gKyAqIFRoaXMg
aXMgYWxzbyByZWdyZXNzaW9uIHRlc3QgZm9yIGtlcm5lbCBjb21taXRzOgo+ID4gPiArICogICAy
MGM2NGVjODNhOWYgKCJpb21hcDogZml4IGEgcmVncmVzc2lvbiBmb3IgcGFydGlhbCB3cml0ZSBl
cnJvcnMiKQo+ID4gPiArICogICAzYWM5NzQ3OTZlNWQgKCJpb21hcDogZml4IHNob3J0IGNvcHkg
aW4gaW9tYXBfd3JpdGVfaXRlcigpIikKPgo+ID4gQ2FuIHlvdSBwbGVhc2UgYWRkIHRhZ3MgdG8g
dGhlIHRzdF90ZXN0IHN0cnVjdCBhcyB3ZWxsPwo+Cj4gRG9uZS4KClRoYW5rcyBQZXRyLCB5b3Ug
d2VyZSBmYXN0ZXIgOi0pCgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
