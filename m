Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBE2C54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 03:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748316838; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ZAhUaXdsFe+Lgt6rEbYDhsN2b9620LQEcjUP+iIlQFY=;
 b=nib3eDLJ4aToOKwzgnrBLBWY0NWXfI3pjrVGxTB8yV64NYvFOredFSJOse2tRaypxudtM
 S87m3mb9l7hgjQWi4bCmzIKMiNJI5znK7FuEuUbTQt8YaLuQR1SnRf6fYpoTdccO+mAbHRE
 tgWYPQQ/L5yz+HoOw96jW2Luc1lzyfc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1492E3C4E9F
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 05:33:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEA5F3C2C08
 for <ltp@lists.linux.it>; Tue, 27 May 2025 05:33:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1A2CA200C6E
 for <ltp@lists.linux.it>; Tue, 27 May 2025 05:33:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748316813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cqes5kWhoJ04tWbNhdd/cfeinlVlhlNwafc94/J8ATc=;
 b=McUW2n286RFVOaXgIK3A3YCFwMGpNcTvrW82SopWRcYVSp8Pbuhebd+n0b3TtlMJZHPLZS
 iygnJTNtxhqFBLEqd1N0W2/ck96z0grHhorSyvcYyfCEaYBDJvROShXfqkx9JM2gAzoBLT
 4QzYWoL7mEhdmaM+7oCJ1UriG/N6T78=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-0Nue-kqQPIqHVsGkzOeYKg-1; Mon, 26 May 2025 23:33:31 -0400
X-MC-Unique: 0Nue-kqQPIqHVsGkzOeYKg-1
X-Mimecast-MFC-AGG-ID: 0Nue-kqQPIqHVsGkzOeYKg_1748316810
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3111a07f102so2176051a91.0
 for <ltp@lists.linux.it>; Mon, 26 May 2025 20:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748316810; x=1748921610;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cqes5kWhoJ04tWbNhdd/cfeinlVlhlNwafc94/J8ATc=;
 b=eRgVVP/V39kvxY4g2DCfSC++t+YRPi5+LSe+Di2+8Vko0Y1kCuO/HM+NxbnB3rC+YK
 V+MSrTBwQQ7Dp/5JrhzrejB72ciXiXrh0nnWPZvCOLkZc3MeFfhFJ4Lgy6U1lJUd6uao
 rgPJMpQeLbIlqRQdDrgvpIfjjZHMLxPiQhsbVLdg/kY1yzLKdBCvu68IIIM2tiOjkdIA
 tXskDMC/NSFkTBQ1yFCiR5snQACcAOh1tRhRKcAEmsODrOK+16ooJGfpH+7+WEr6TPFT
 pda2uYKyF+/lLJaq+4+2NeVneZm5cWXjrTlJjvUnWZm/lJkLVQWTj21LNBCurdsy9emA
 H3vQ==
X-Gm-Message-State: AOJu0YwQenm4ophszFOQuzjx0EioV2u9ScLBkOhZhQFSGlruiqlJ63WJ
 RYkbuPBSVHucoC8bthU97eoFpvz1JjhOO4WoOMIqvABTmFTjhoCCKPG2rpx/SREbWFbDjSHL1Ia
 8iP6cYiTkN2MuOOgqbUgTdDGzAYAt+PbfFOyfz0u0j63G6yuchAUpcjcb2twS2CUbO/QB/SUB7k
 Ej2IKx3lvdTNO0K58qpcSmknEqFik=
X-Gm-Gg: ASbGncsbWtI5e8iB/UB/FkW2WVclLq/x/kYtl5yCB9XbvTUSlxuOnb7Nki1DrNdnqLg
 H5fZhix133XDx3A/75CnvN82vrxnW1+KMVu4pnbK5fB5pX9hoeblT/VtiksHkvLXqjXQ/4g==
X-Received: by 2002:a17:90b:4fcd:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-3110aab1d02mr19399488a91.2.1748316810460; 
 Mon, 26 May 2025 20:33:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDk8sNp/5dNRZndAFD7JtyWx1HjH1rSMYy3e0pn65efa9GSIa6eGhSRfdRRCiaLBj3kRRN3taMuWO1iNUOnvc=
X-Received: by 2002:a17:90b:4fcd:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-3110aab1d02mr19399464a91.2.1748316810129; Mon, 26 May 2025
 20:33:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250526150854.145995-1-pvorel@suse.cz>
In-Reply-To: <20250526150854.145995-1-pvorel@suse.cz>
Date: Tue, 27 May 2025 11:33:18 +0800
X-Gm-Features: AX0GCFvF0H39I-K1HmMwEsO5gNLntTPRLbSVRYgOMEiGUSQ6I6qEKIH6R-Lx92c
Message-ID: <CAEemH2efaYBWr-TrMKCT5Ba3_bQtrbFGTY2WW-qwiJtQ=929Wg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9-WD6RKSqYZZZ1SEHAwf8e4wwPT9qKVOIdN9wMITVeo_1748316810
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH v3 1/1] test_controllers: Skip test when
 cgroup v2 is loaded
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwgQWxsLAoKUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKLi4uCj4g
VGVzdGVkLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+IFJldmlld2Vk
LWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiBTaWduZWQtb2ZmLWJ5OiBKaW4gR3Vv
amllIDxndW9qaWUuamluQGdtYWlsLmNvbT4KPiBbIHB2b3JlbDogc2ltcGxpZnksIHJlYmFzZWQg
XQo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoKUmV2aWV3ZWQt
Ynk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKPiBJcyBpdCBldmVuIHVzZWZ1bCBub3dh
ZGF5cyB3aGVuIHdlIGhhdmUgdmFyaW91cyBDIGFuZCBzaGVsbCBiYXNlZAo+IHRlc3RzPyBTaG91
bGRuJ3Qgd2UganVzdCBkZWxldGUgdGhlIHRlc3Q/CgpJIHRoaW5rIHdlIG5lZWQgdG8gZGlzc29s
dmUgdGhlIHRlc3RfY29udHJvbGxlci5zaCBmaWxlIHN0ZXBseSwgcGFydCBvZgp0aGVtIGNhbiBi
ZSBkZWxldGVkIChlLmcuIGJsb2NraW8pLCBidXQgb3RoZXJzIG5lZWQgdG8gYmUgY2hlY2tlZApp
ZiBpdCBpcyB1c2VmdWwsIHRoZW4gZ29lczoKCiAxLiBEZWxldGUgdGhlIG92ZXJsYXBwZWQgdGVz
dCBjb250ZW50cy4KIDIuIFJld3JpdGUgdGhlIHJlc3Qgd2l0aCB0aGUgbmV3IEFQSSBhbmQgbW92
ZSBpbnRvIHJ1bnRlc3QvY29udHJvbGxlcnMuCgo+IEl0IGV2ZW4gdXNlcyAiYmxvY2tpbyIsIHNo
b3VsZG4ndCBpdCBiZSAiYmxraW8iPwoKSXQncyBvdXRkYXRlZCwgd2UgY2FuJ3QgZXZlbiBmaW5k
IHRoZSBydW5faW9fdGhyb3R0bGVfdGVzdC5zaCBmaWxlLApCZXR0ZXIgdG8gcmVtb3ZlIHRoZW06
CgotLS0gYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL3Rlc3RfY29udHJvbGxlcnMuc2gK
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy90ZXN0X2NvbnRyb2xsZXJzLnNoCkBA
IC00OCw4ICs0OCw2IEBAIHRoZW4KICAgICAgICBDUFVfQ09OVFJPTExFUl9WQUxVRT1gZ3JlcCAt
dyBjcHUgL3Byb2MvY2dyb3VwcyB8IGN1dCAtZjRgOwogICAgICAgIE1FTV9DT05UUk9MTEVSPWBn
cmVwIC13IG1lbW9yeSAvcHJvYy9jZ3JvdXBzIHwgY3V0IC1mMWA7CiAgICAgICAgTUVNX0NPTlRS
T0xMRVJfVkFMVUU9YGdyZXAgLXcgbWVtb3J5IC9wcm9jL2Nncm91cHMgfCBjdXQgLWY0YDsKLSAg
ICAgICBJT1RIUk9UVExFX0NPTlRST0xMRVI9YGdyZXAgLXcgYmxvY2tpbyAvcHJvYy9jZ3JvdXBz
IHwgY3V0IC1mMWA7Ci0gICAgICAgSU9USFJPVFRMRV9DT05UUk9MTEVSX1ZBTFVFPWBncmVwIC13
IGJsb2NraW8gL3Byb2MvY2dyb3VwcyB8IGN1dCAtZjRgOwogICAgICAgIEZSRUVaRVI9YGdyZXAg
LXcgZnJlZXplciAvcHJvYy9jZ3JvdXBzIHwgY3V0IC1mMWA7CiAgICAgICAgRlJFRVpFUl9WQUxV
RT1gZ3JlcCAtdyBmcmVlemVyIC9wcm9jL2Nncm91cHMgfCBjdXQgLWY0YDsKCkBAIC04NSwxNSAr
ODMsNiBAQCB0aGVuCiAgICAgICAgICAgICAgICBlY2hvICJTa2lwcGluZyBhbGwgbWVtb3J5IGNv
bnRyb2xsZXIgdGVzdGNhc2VzLi4uLiI7CiAgICAgICAgZmkKCi0gICAgICAgaWYgWyAiJElPVEhS
T1RUTEVfQ09OVFJPTExFUiIgPSAiYmxvY2tpbyIgXSAmJiBbCiIkSU9USFJPVFRMRV9DT05UUk9M
TEVSX1ZBTFVFIiA9ICIxIiBdCi0gICAgICAgdGhlbgotICAgICAgICAgICAgICAgJExUUFJPT1Qv
dGVzdGNhc2VzL2Jpbi9ydW5faW9fdGhyb3R0bGVfdGVzdC5zaDsKLSAgICAgICBlbHNlCi0gICAg
ICAgICAgICAgICBlY2hvICJDT05UUk9MTEVSUyBURVNUQ0FTRVM6IFdBUk5JTkciOwotICAgICAg
ICAgICAgICAgZWNobyAiRWl0aGVyIEtlcm5lbCBkb2VzIG5vdCBzdXBwb3J0IGZvciBpbyBjb250
cm9sbGVyCm9yIGZ1bmN0aW9uYWxpdHkgaXMgbm90IGVuYWJsZWQiOwotICAgICAgICAgICAgICAg
ZWNobyAiU2tpcHBpbmcgYWxsIGJsb2NrIGRldmljZSBJL08gdGhyb3R0bGluZyB0ZXN0Y2FzZXMu
Li4uIjsKLSAgICAgICBmaQotCiAgICAgICAgaWYgWyAiJEZSRUVaRVIiID0gImZyZWV6ZXIiIF0g
JiYgWyAiJEZSRUVaRVJfVkFMVUUiID0gIjEiIF0KICAgICAgICB0aGVuCiAgICAgICAgICAgICAg
ICAiJExUUFJPT1QvdGVzdGNhc2VzL2Jpbi9ydW5fZnJlZXplci5zaCIKCgo+IEdpdmVuIHRoZSB0
ZXN0IGlzIHN0aWxsIHNvbWVob3cgdXNlZnVsLCBpJ20gbm90IHN1cmUgaWYgdGhpcyBpcyB3b3J0
aCB0bwo+IHJld3JpdGUgdG8gY2dyb3VwX2xpYi5zaCAob3IgZXZlbiB0byB0aGUgQyBBUEkpLCBi
dXQgSU1ITyBub3cgYmVmb3JlIHRoZQo+IHJlbGVhc2UgSSB3b3VsZCBqdXN0IHNraXAgaXQgb24g
djIuCgpTdXJlLCBza2lwcGluZyBmcm9tIFYyIGlzIHNhZmUgZW5vdWdoIGJ5IG5vdy4KCi0tClJl
Z2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
