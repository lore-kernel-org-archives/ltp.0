Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14355C3ABC3
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 09:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747128829; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kQzUu1io/0LpzwxyYOfo3ALQepQ+9ySYBS7ZaHLizBY=;
 b=f4D1DAYheOfEseeDxB4B3wA8PbyD4ogzmlycSWBs/TTifHoukrBO/GG/b3wbK7Jsqo9iL
 fo5hxJxok9icXVgQjRIXGosCzEn0gwNh1UB+w92sBQonWum3zxnxVg+1DloPRl91udhtYiw
 yaOGhjMn6mgDvOaSGq3tfPYCtV5J0R0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5A88C3CC320
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 11:33:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FF013C99DD
 for <ltp@lists.linux.it>; Tue, 13 May 2025 11:33:27 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8C2241000A46
 for <ltp@lists.linux.it>; Tue, 13 May 2025 11:33:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747128804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CE4Vg7Jh4oT0gEBB3clYTo/dIuUGXeU4Qdil6nqfYeg=;
 b=NSxcrLJBfohBnPVMdMWuWK7I1WIvEZMn63K3swtL0iCPKttEUJpoRCWuPupfudLAlAaPi6
 ASGGlSKtaJLrDoI1mCA9+cDkGWnb0MeJBK9oBUXtSveYJ1pxZmgPdA5a68jlaM86YL1Ilo
 MELc8gNiEOY41dpsNnNKHxsIuu/UedA=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-tLBiD_M9ME2ps57a8QZVwA-1; Tue, 13 May 2025 05:33:23 -0400
X-MC-Unique: tLBiD_M9ME2ps57a8QZVwA-1
X-Mimecast-MFC-AGG-ID: tLBiD_M9ME2ps57a8QZVwA_1747128802
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22c31b55ac6so71929845ad.0
 for <ltp@lists.linux.it>; Tue, 13 May 2025 02:33:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747128802; x=1747733602;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CE4Vg7Jh4oT0gEBB3clYTo/dIuUGXeU4Qdil6nqfYeg=;
 b=n07pK+uZQhoQuYnbbYbtLeFO2+XE3rdTpHC6o/tG/feSKb4MLjkIgGShSjL0F1LJQf
 BttZnTiSv431yOa+R2RAAPNieeVn1xWNoUrvNxktBaYbIh3BxNPjL/PTHdmxut3hT2bD
 cGw67yQmmL1riljqlVt88+QMDpOZYg6B80lhwF8oDl9CARPsJHm+wXgC8EfH0A5m4gOW
 WmYeoC+Tt422ASGamLSOU8NjHDAxn7jR6Z73sBRiXvXBL6m1Cae9j+HvpMqSLsGuGyuu
 D0NS8jEooWwLvaEDsSnKdXuLVgU/OwTP0G8wgrkbJ/sgvznCb0/CJsObozh+zC52VDXe
 acmQ==
X-Gm-Message-State: AOJu0YwbYt0l2uK8YMrS/ZWB7g5Yex7OAsfRCDbA5bKD5izG+tE1fp/x
 9fg4dbBeU6QiqvWKM3lWYF7oYy2WN53A8sfPxemCqjVzL29C8OX8Yw6bAki/HE1f9oTlNSAxXGv
 OBb+k+XCw96jpdJz7A4B7dVmfc3HFf9StHCmj1ILCBbfxyw3Y95W7Zs0SJookpw9M9wW5vsR7TA
 6B6TcIXzcEdugmyry+ea5PjTA=
X-Gm-Gg: ASbGncvI3CKmSGrROkfdrd9dmuXbDT9y8u4fXt3dGKzwGlSk83HTmjpY1K/bD2FLQri
 RoVx7cjxEsEdPfrU7y/SNs2D9h+rn869Yq068Utk7ZTwc9epxvz6dxKxjlQNci05xzffKjA==
X-Received: by 2002:a17:902:da2d:b0:215:a179:14ca with SMTP id
 d9443c01a7336-22fc8b0023cmr195379535ad.2.1747128801966; 
 Tue, 13 May 2025 02:33:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIIi0u/6tXRwzAeaiK41/XrJBkcEfIrcf6xu5xRmAUU9aC63inM5ai/YB/056wQ5IoSg66Db/s38FsPf2baJI=
X-Received: by 2002:a17:902:da2d:b0:215:a179:14ca with SMTP id
 d9443c01a7336-22fc8b0023cmr195379335ad.2.1747128801707; Tue, 13 May 2025
 02:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250513050530.47541-1-liwang@redhat.com>
 <20250513050530.47541-2-liwang@redhat.com>
 <aCOsNW2hFJZOn3zH@MiWiFi-CR6608-srv>
In-Reply-To: <aCOsNW2hFJZOn3zH@MiWiFi-CR6608-srv>
Date: Tue, 13 May 2025 17:33:09 +0800
X-Gm-Features: AX0GCFu6q5Mo5HA2OD79MFWc6IF4jLS8l15SGRBmVtKriqPoQfvsmgmg_i8-VYE
Message-ID: <CAEemH2cuKr4NLi8193GskSgJ+UuswvT6dP2U0nCYqfVndTjH9A@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t1HNsyiuADVqo2oJTGSFpKZEfUjvoFrvhcZEhAey1Yw_1747128802
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] dirtyc0w_shmem: set child_needs_reinit
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXkgMTMsIDIwMjUgYXQgNDozMuKAr1BNIFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29t
PiB3cm90ZToKCj4gT24gVHVlLCBNYXkgMTMsIDIwMjUgYXQgMDE6MDU6MzBQTSArMDgwMCwgTGkg
V2FuZyB3cm90ZToKPiA+IFNpZ25lZC1vZmYtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29t
Pgo+ID4gLS0tCj4gPiAgdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9kaXJ0eWMwd19zaG1lbS9k
aXJ0eWMwd19zaG1lbS5jIHwgMSArCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
Cj4gPgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvZGlydHljMHdf
c2htZW0vZGlydHljMHdfc2htZW0uYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9kaXJ0
eWMwd19zaG1lbS9kaXJ0eWMwd19zaG1lbS5jCj4gPiBpbmRleCA2NGIxODdiMzUuLjRiMzFkYTgz
MSAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvZGlydHljMHdfc2ht
ZW0vZGlydHljMHdfc2htZW0uYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zZWN1cml0eS9k
aXJ0eWMwd19zaG1lbS9kaXJ0eWMwd19zaG1lbS5jCj4gPiBAQCAtMTA0LDYgKzEwNCw3IEBAIHN0
YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKPiA+Cj4gPiAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0
ZXN0ID0gewo+ID4gICAgICAgLm5lZWRzX2NoZWNrcG9pbnRzID0gMSwKPiA+ICsgICAgIC5jaGls
ZF9uZWVkc19yZWluaXQgPTEgLAo+IHMvLmNoaWxkX25lZWRzX3JlaW5pdCA9MSAsLy5jaGlsZF9u
ZWVkc19yZWluaXQgPSAxLC8KPgoKR29vZCBjYXRjaC4gVGhhdCBibGFuayBiZWZvcmUgdGhlIGNv
bW1hIHNob3VsZCBiZSByZW1vdmVkLgoKCj4gRG8gd2Ugc3RpbGwgbmVlZCB0aGlzPyBTaW5jZSAu
bmVlZHNfY2hlY2twb2ludHMgaXMgYWxyZWFkeSBzZXR0ZWQuCj4KCkkgdGhpbmsgeWVzIQoKV2hp
bGUgc29tZSBmaWVsZHMgbWF5IGhhdmUgb3ZlcmxhcHBpbmcgZWZmZWN0cywgZXhwbGljaXRseSBz
ZXR0aW5nIHRoaXMKZmllbGQKaGlnaGxpZ2h0cyBpdHMgaW50ZW5kZWQgZnVuY3Rpb24gYW5kIGVu
aGFuY2VzIHRoZSBjbGFyaXR5IG9mIHRoZSBjb2RlLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
