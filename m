Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC139C0218A
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 11:08:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DA5D3C2BFA
	for <ltp@archiver.kernel.org>; Mon, 27 Jan 2025 12:08:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79D283C06B4
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 12:08:09 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=acarmina@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8149F1BBBB90
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 12:08:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737976086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E/uopi/xQAXFoaNj2tqM6pO4w1S/Ate2hoptwPRQqY0=;
 b=WXuGFlhtxFrSn6ruxj3tpsAK+4GE59LX/0dFoHzh7rwe1u3q1EO2RYI7VWaeZMSYXTJ8Y0
 5tbZdeZy3xpD0Xm/mNYbmCdUcTFVLvKE2wuN3So9ZZl6QvkhSgIEPrMK09VDlZ2pEGb5E2
 cPem9uDaSGnfn4mWv2/pQQi4fbk6hhE=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-0eYhDvnpPq6j2pxCLHC1uw-1; Mon, 27 Jan 2025 06:08:05 -0500
X-MC-Unique: 0eYhDvnpPq6j2pxCLHC1uw-1
X-Mimecast-MFC-AGG-ID: 0eYhDvnpPq6j2pxCLHC1uw
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2eebfd6d065so12366466a91.3
 for <ltp@lists.linux.it>; Mon, 27 Jan 2025 03:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737976084; x=1738580884;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/uopi/xQAXFoaNj2tqM6pO4w1S/Ate2hoptwPRQqY0=;
 b=Ju3DeRoyrOvRi55lZDQ6HEOh8YfCF1EL8pu51ln5qYn4Kshfo9eKv4SUIRlilrMuQi
 XCby2gSLXBwXQ0JGD2VE4t8KZnyTFqR00M3D2xHna+M123qCn7mdRbR14CBqA5WV9XbD
 YuH6HCV3vOESjtL4b1HHWHCZ275ha+DBBr/MkmNe9J1SrndvjnJ+dQcTX5RbwWjADF7P
 NrM/b9/uSTQ2QZvDO9kcFLxLS7kHqw+0/IL1iobUHe/86Z33gJHSLL8kRaLdl0hcVlAj
 t6Cg7r9RNpA4gI/GKwJm/dUBoN/Vm5gIZOIq1+mv+0YvPct3E57ipm8C3WZrCILnhM3l
 1ksg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMuJfMvDf+gWzNk+YPpyLjblEZ0nNypIDkjNAvmilbe5LBeFPJtfa33TdD0Hmn+LOglVY=@lists.linux.it
X-Gm-Message-State: AOJu0YygKrntM722HSv6SsnBwZjJpqq1XestQF/0bODH6TzT0PnzLDKB
 fJS+P/3YM0c6LYEbLLmuY/F0YfX9NHqLedKUabcliPTEXJ16zGVDTzpA19KYplxS6VdQ5ShYuUJ
 TqrHqMKGaBS+3iWNO0O2wimcZRD2Aj5IUZbjHzJl5cxa4WQQnJyYSiWBSwjjauqEDzF+f8LQEJF
 vKTHIJJcFrso36LgIzJVem1eM=
X-Gm-Gg: ASbGncvQAD6Thfmz2g1iNg1Fq/J1SwF6HS2/lpJQ7ad6/feIr0LX2pQhcintBQ+HOTV
 /lrx0RDpcyf9Naai3L9Hlugkt1gJL2UQ68ozSen/Je64PnSgBbqV83HGlDOzD
X-Received: by 2002:a17:90b:1f91:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-2f782c62983mr54341171a91.6.1737976084291; 
 Mon, 27 Jan 2025 03:08:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlihjvteVlnAN9KL8Q0mBKAA/o9T+rVLNZREnlH2thWtlTkilSaDsjXR0FIcnQ1HOCkhrPb0o1Q2/ipOGbFKA=
X-Received: by 2002:a17:90b:1f91:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-2f782c62983mr54341156a91.6.1737976084063; Mon, 27 Jan 2025
 03:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20250127083227.77560-1-acarmina@redhat.com>
 <20250127093929.GA268709@pevik>
In-Reply-To: <20250127093929.GA268709@pevik>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Mon, 27 Jan 2025 12:07:52 +0100
X-Gm-Features: AWEUYZmifts7cmEIdF51rMe2bvT6ZQb9Ku9cEGhoP-1zJxZS2_eVKY-fJPkg4eg
Message-ID: <CAGegRW4RNff_nukrmBW-iab4yCddaoh0wcsOF5pUkYQOBCUcyA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VCqXBZzwaVjRe71Gm60JcEZZ_CjaFtryirPVD8fxEoc_1737976084
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] cfs-scheduler/starvation.c: Skip test on
 realtime kernels
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
Cc: ltp@lists.linux.it, Alessandro Carminati <alessandro.carminati@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLgoKT24gTW9uLCBKYW4gMjcsIDIwMjUg
YXQgMTA6MznigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cj4KPiA+IFRo
aXMgY29tbWl0IGludHJvZHVjZXMgYSBjaGVjayBpbiB0aGUgc3RhcnZhdGlvbiB0ZXN0IGNhc2Ug
dG8gZGV0ZWN0IGFuZAo+ID4gc2tpcCBleGVjdXRpb24gb24gcmVhbHRpbWUga2VybmVscy4gVGhl
IHRlc3QgaXMgZGVzaWduZWQgZm9yIHVzZSB3aXRoIHRoZQo+ID4gQ29tcGxldGVseSBGYWlyIFNj
aGVkdWxlciBhbmQgcHJvZHVjZXMgbWVhbmluZ2xlc3MgcmVzdWx0cyB3aGVuIHJ1biBvbgo+ID4g
cmVhbHRpbWUga2VybmVscy4KPgo+ID4gQnkgc2tpcHBpbmcgdGhlIHRlc3Qgb24gcmVhbHRpbWUg
a2VybmVscywgd2UgYXZvaWQgY29uZnVzaW9uIGNhdXNlZCBieQo+ID4gbWlzbGVhZGluZyByZXN1
bHRzLgo+Cj4gVGhhbmtzIGEgbG90IGZvciBmaXhpbmcgLTEgaW4gdjMuIEkgd2FzIHRoaW5raW5n
IHRvIG1lcmdlIHYyIGFuZCBmaXggLTEKPiBtYW51YWxseSwgYnV0IEknbSByZWFsbHkgbm90IHN1
cmUgaWYgdGhlIHRlc3QgaXMgbWVhbmluZ2xlc3MgZm9yIHJlYWx0aW1lLgo+IFdhcyB0aGUgdGVz
dCByZWFsbHkgd3JpdHRlbiBmb3IgQ0ZTPyBJdCB3b3VsZCBiZSBuaWNlIHRvIGdldCBhY2sgZnJv
bSBhbnkKPiByZWFsdGltZSBkZXZlbG9wZXIuCj4KPiBCVFcgdGVzdCBpcyB3b3JraW5nIHdlbGwg
b24geDg2XzY0IFNMRVMgcmVhbHRpbWUga2VybmVsIG9uIFZNLCBpLmUuIGJvdGggeW91Cj4gd2Fu
dCB0byBza2lwIChSVCkgb3Igd2FybiBhYm91dCB1bnJlbGlhYmxlIHJlc3VsdHMgKFZNKS4gVGhh
dCBvZiBjb3Vyc2UKPiBkb2VzIG5vdCBtZWFuIGl0J3MgcmVsZXZhbnQgZm9yIFJUIGtlcm5lbC4K
CkhlcmUncyB3aGF0IEkgb2JzZXJ2ZWQ6CiogSW4gb3VyIENJIHBpcGVsaW5lLCB0aGUgdGVzdCBj
b25zaXN0ZW50bHkgZmFpbHMgb24gb3VyIFJUIGtlcm5lbCBydW5uaW5nCiAgb24gQUFSQ0g2NCBi
b2FyZHMuCiogVXBvbiBpbnZlc3RpZ2F0aW5nIGFuZCByZWFkaW5nIHRocm91Z2ggdGhlIGNvZGUs
IEkgbm90aWNlZCB0aGF0IHRoZSB0ZXN0CiAgc2VlbXMgdG8gcmVseSBvbiBhbiBlcXVhbCBudW1i
ZXIgb2YgdGltZXMgdGhlIGNoaWxkIGFuZCBwYXJlbnQgdGFza3MgZ2V0CiAgc2NoZWR1bGVkLiBU
aGlzIGJlaGF2aW9yIGFsaWducyB3aXRoIGhvdyBDRlMgd29ya3MuLi4gbGVzcyB3aXRoIFJULgoq
IFRoYXQgc2FpZCwgdGhlcmUgYXJlIHNjZW5hcmlvcyB3aGVyZSBDRlMgYW5kIFJUIG1pZ2h0IG1h
a2Ugc2ltaWxhcgogIHNjaGVkdWxpbmcgZGVjaXNpb25zLCBwYXJ0aWN1bGFybHkgaW4gUlQgd2hl
biBhbGwgdGFza3Mgc2hhcmUgdGhlIHNhbWUKICBwcmlvcml0eS4KKiBGaW5hbGx5LCBhcyBhIGhp
bnQsIEkgbm90aWNlZCB0aGF0IHRoZSB0ZXN0IGlzIGN1cnJlbnRseSBwbGFjZWQgaW4gdGhlCiAg
Y2ZzLXNjaGVkdWxlciBkaXJlY3RvcnkuIEkgaW50ZXJwcmV0IHRoaXMgYXMgYSBzdHJvbmcgc3Vn
Z2VzdGlvbiBmcm9tIHRoZQogIGF1dGhvciB0aGF0IHRoZSB0ZXN0IHdhcyBpbnRlbmRlZCBmb3Ig
dGhlIENGUyBzY2hlZHVsZXIuCgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgoKCi0tIAotLS0K
VGhhbmtzCkFsZXNzYW5kcm8KMTcyCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
