Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4131D3B9BD
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 04:15:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C35A33DB483
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 05:15:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97F973DB439
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 05:15:40 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2A72D10338F4
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 05:15:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732680937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZQhnxk2sSyaxm24ebxjjYXHAHOpnwMa0opB2vqo66LY=;
 b=UBavR7c4VP/QjIJyxmWHlkQ+w1ikIMbu45XuhaiA1k/RVniki3yIfcSCFvRZK8DfVhJA7u
 i5/ssJbhqK69KiubJkkKDQRqtfP1tvogs8s2dEYxtI2yHaLHoCjKmS1/rv+ZRurZBZlBDh
 XG+49oGj8aD1e73ItpvhslNBg0lqgMk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-1vd9xihkNciMfX-2wNen3g-1; Tue, 26 Nov 2024 23:15:34 -0500
X-MC-Unique: 1vd9xihkNciMfX-2wNen3g-1
X-Mimecast-MFC-AGG-ID: 1vd9xihkNciMfX-2wNen3g
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ea396ba511so7588390a91.3
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 20:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732680934; x=1733285734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZQhnxk2sSyaxm24ebxjjYXHAHOpnwMa0opB2vqo66LY=;
 b=G4w3MtqW53ICxe76nGHPuF3sErVlvO0Q/RkmkSqkPr11fKF6KvjmkO4UmF1Kgaie4F
 fz7l8M5b3ZSXBCp3/IICfU2FEuoeJcaf+T8kP74atkaJg/eV445vghBjwuUl5NdpLp9d
 jJmffLFAmlX/l4LkxEmyh727kI85P4OXcBCt8Szf+UZQqAHN4DGoQE8+70dEQGf9ICkw
 S5EpFf9odIvdXWJKL/ifxPM96YgjeE9QVnnFtRiUX+OvJmFflPl6a5QUeedsd3jhTb8r
 4o4i3PNYfHdBllgn5IOKCmPtf9DjTZVBa0Qssqx6HoYGhPekulf5HkvRaUeLNyJl+6r0
 kDAQ==
X-Gm-Message-State: AOJu0Yx2Dj2NaA415lTONO+dRF7UFx2aAxjTidxs0P2pZUPVp+YZEqUl
 TzXAcJKKa3xX/hNd8B/wKPM892kgXnZoRHLOciltfWRONgAkbwB7ubSdeVJNpM1jTbhtBMuYa1I
 zacc0oflhewcTeGLGWyqt0r8o7gEtKNN2dEvj15oGZxGX+zx2whlUxbqRbSU5nwWXoaqnXwNK04
 tkTyD2V4viB2LEX9OYuj9gXOg=
X-Gm-Gg: ASbGncvj0nHKvwTldaHKDzbHihBDHzzpmB5291NZP7GiOJBYikgi5L5awjZALSny08k
 qYxSfqTisrh6gMBgSwVqICtDmCQst8OMK
X-Received: by 2002:a17:90b:3851:b0:2ea:5ff8:f325 with SMTP id
 98e67ed59e1d1-2ee08e5e394mr2355105a91.8.1732680933834; 
 Tue, 26 Nov 2024 20:15:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGs9KRzMgTKzMNxxWAJNPbViaA5Losm6OnLFqvm1MsRWlIiUoXsU1o+LdkWZeMA4AUetua6FHp69J9gtqYFotM=
X-Received: by 2002:a17:90b:3851:b0:2ea:5ff8:f325 with SMTP id
 98e67ed59e1d1-2ee08e5e394mr2355079a91.8.1732680933315; Tue, 26 Nov 2024
 20:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20241126100445.17133-1-liwang@redhat.com>
 <Z0WitZsMZat6wdA2@yuki.lan>
 <CAEemH2cpYA28nknKOhNV0D4q8G+xPw6EuvScMHbgOO3jpRPv7w@mail.gmail.com>
 <Z0Wvsq571rTt46Ie@yuki.lan>
In-Reply-To: <Z0Wvsq571rTt46Ie@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Wed, 27 Nov 2024 12:15:20 +0800
Message-ID: <CAEemH2e3H0w52LKXs+UURdg5dq2bP5dXokWYb98DxHu5qcsOQg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ElTz6k8SHeOST6inoIFNnO6TAd9QH0AsP2xsE5q0IhY_1732680934
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH] starvation: set a baseline for maximum runtime
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
Cc: Philip Auld <pauld@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBOb3YgMjYsIDIwMjQgYXQgNzoyM+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBXZWxsLCB3ZSBoYXZlIG5vdCBhY2hpZXZlZCBhIHJl
bGlhYmxlIHdheSB0byBkZXRlY3QgZGVidWcga2VybmVscyBpbiBMVFAuCj4gPiBXaGlsZSBJIGxv
b2tpbmcgYXQgb3VyIFJIRUw5IGtlcm5lbCBjb25maWcgZmlsZS4gVGhlIGdlbmVyYWwga2VybmVs
IGFsc28KPiA+IGVuYWJsZXMgdGhpbmdzIGxpa2UgIkNPTkZJR19ERUJVR19LRVJORUw9eSIuCj4K
PiBUaGUgc2xvd2Rvd24gaXMgbGlrZWx5IHRvIGJlIHJlYWxhdGVkIHRvIGEgZmV3IHNwZWNpZmlj
IGRlYnVnIG9wdGlvbnMKPiBzdWNoIGFzIGRlYnVnZ2luZyBmb3IgbXV0ZXhlcywgc3BpbmxvY2tz
LCBsaXN0cywgZXRjLiBJIGd1ZXNzIHRoYXQgdGhlCj4gbW9zdCBpbnRlcmVzdGluZyBpbmZvcm1h
dGlvbiB3b3VsZCBiZSBhIGRpZmZlcmVuY2UgaW4gdGhlIGRlYnVnIG9wdGlvbnMKPiBiZXR3ZWVu
IHRoZSBnZW5lcmFsIGtlcm5lbCBhbmQgdGhlIGRlYnVnIGtlcm5lbC4gSG9wZWZ1bGx5IHdlIGNh
biBwdXQKPiB0b2dldGhlciBhIHNldCBvZiBkZWJ1ZyBvcHRpb25zIHRoYXQgYXJlIGNhdXNlIHRo
ZSB0ZXN0IHRvIHJ1biBvdmVyCj4gc2xvdy4KPgoKCkkgaGF2ZSBjYXJlZnVsbHkgY29tcGFyZWQg
dGhlIGRpZmZlcmVuY2VzIGJldHdlZW4gdGhlIGdlbmVyYWwKa2VybmVsIGNvbmZpZy1maWxlIGFu
ZCB0aGUgZGVidWcga2VybmVsIGNvbmZpZy1maWxlLgoKQmVsb3cgYXJlIHNvbWUgY29uZmlndXJh
dGlvbnMgdGhhdCBhcmUgb25seSBlbmFibGVkIGluIHRoZSBkZWJ1ZwprZXJuZWwgYW5kIG1heSBj
YXVzZSBrZXJuZWwgcGVyZm9ybWFuY2UgZGVncmFkYXRpb24uCgpUaGUgcm91Z2ggdGhvdWdodHMg
SSBoYXZlIGlzIHRvIGNyZWF0ZSBhIFNFVCBmb3IgdGhvc2UgY29uZmlndXJhdGlvbnMsCklmIHRo
ZSBTVVQga2VybmVsIG1hcHMgc29tZSBvZiB0aGVtLCB3ZSByZXNldCB0aGUgdGltZW91dCB1c2lu
ZyB0aGUKdmFsdWUgbXVsdGlwbGllciBvYnRhaW5lZCBmcm9tIGNhbGlicmF0aW9uLgoKZS5nLiBp
ZiBtYXBwZWQgTiBudW1iZXIgb2YgdGhlIGNvbmZpZ3Mgd2UgdXNlICh0aW1lb3V0ICogTikgYXMg
dGhlCm1heF9ydW50aW1lLgoKT3IgbmV4dCwgd2UgZXh0cmFjdCB0aGlzIG1ldGhvZCB0byB0aGUg
d2hvbGUgTFRQIHRpbWVvdXQgc2V0dGluZyBpZgpwb3NzaWJsZT8KCgojTG9jayBkZWJ1Z2dpbmc6
CkNPTkZJR19QUk9WRV9MT0NLSU5HCkNPTkZJR19MT0NLREVQCkNPTkZJR19ERUJVR19TUElOTE9D
SwoKI011dGV4IGRlYnVnZ2luZwpDT05GSUdfREVCVUdfUlRfTVVURVhFUz15CkNPTkZJR19ERUJV
R19NVVRFWEVTPXkKCiNNZW1vcnkgZGVidWdnaW5nOgpDT05GSUdfREVCVUdfUEFHRUFMTE9DCkNP
TkZJR19LQVNBTgpDT05GSUdfU0xVQl9SQ1VfREVCVUcKCiNUcmFjaW5nIGFuZCBwcm9maWxpbmc6
CkNPTkZJR19UUkFDRV9JUlFGTEFHUwpDT05GSUdfTEFURU5DWVRPUApDT05GSUdfREVCVUdfTkVU
CgojRmlsZXN5c3RlbSBkZWJ1Z2dpbmc6CkNPTkZJR19FWFQ0X0RFQlVHCkNPTkZJR19RVU9UQV9E
RUJVRwoKI01pc2NlbGxhbmVvdXMgZGVidWdnaW5nOgpDT05GSUdfRkFVTFRfSU5KRUNUSU9OCkNP
TkZJR19ERUJVR19PQkpFQ1RTCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
