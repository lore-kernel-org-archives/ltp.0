Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0246ECCD184
	for <ltp@archiver.kernel.org>; Sat, 11 Oct 2025 09:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760173664; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=FgKtvcqEwoDXJBCoxFD9uYFdhKUArWgDl48Xqf1H2qk=;
 b=J6CAO2USO10JmD3cr4KeE0HH3y4UoXt/uA8d40YHiZdTErnTPNX/h8tXGN0IqZQIRbcgT
 S59/5CjxBKenAwgyhwPIoDkIE5bP2sfGtuaZ5WEVTiFXdJ3qyAIGM6lYytuXfzbTwPFh1cN
 rPPtwxg3iqL0nFE8HeJr0SzVzTyDsKs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEE693CE970
	for <ltp@archiver.kernel.org>; Sat, 11 Oct 2025 11:07:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A4513CC7A0
 for <ltp@lists.linux.it>; Sat, 11 Oct 2025 11:07:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EF4ED1400F25
 for <ltp@lists.linux.it>; Sat, 11 Oct 2025 11:07:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760173641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v90+zV1meErRczfpcLqbOH3CjEVHjN0XJzdiolxADwA=;
 b=iRW49KeeUbu6CbylS7wvYxeGFIgEcmV3q0G5UKgbgSleFq7d1koCmmb8jLsMy/F6BN69d/
 oAds9k7mntxpeoGzAhsKBEj0N4UHiCSPvw5dfq6Br1fp+QZgZR5daUfBcLFqYTNf/614Fq
 2iSgncCFkK9+5pZUlbdk1ixbLznbRiU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-TKwGdio-OCWUF9JPaTlzaQ-1; Sat, 11 Oct 2025 05:07:19 -0400
X-MC-Unique: TKwGdio-OCWUF9JPaTlzaQ-1
X-Mimecast-MFC-AGG-ID: TKwGdio-OCWUF9JPaTlzaQ_1760173638
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-269939bfccbso75082565ad.1
 for <ltp@lists.linux.it>; Sat, 11 Oct 2025 02:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760173638; x=1760778438;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v90+zV1meErRczfpcLqbOH3CjEVHjN0XJzdiolxADwA=;
 b=SxeWSgDsC29b2MIKki7ZEVMAPfhIkEGCfcvnXyMQ3s0m/eaaz3kSpb/uanzBf9Amzn
 zfX9fhQ7Y8D1zYQEBsq9+/CmBqu7pMKbWTVMxUOqOZwaGGMKSziiFWHdNnnXEIbam8Ll
 Utcd5TpJ12bCG4Qqjpvz0E8OjzMRrs+cJU6UGD4lA9pJTGiNsMZ9a+//ro6FDPLpj2Il
 amDNGPKtO8SxLF0lH4p/yQ4qlc83PA+nYZAYoyBgrmDY1Djz6nJy9wg/5ZgZz/91/6Ih
 y4rhpky2kzXpStKozJBD5MAy72mW7jsJYfm+dbyw+kAWmiZnkZLyhkGDol8S3whvue4z
 KIaw==
X-Gm-Message-State: AOJu0Yw+6BxalYyNPuMi1ZLo/CcHI1X+Ps/CRB20sexpwKg+Hs18ZQKS
 bUNV2D0ebP7i6OxzdS1QCYFE996sl9Id64SmiKiDGrxemuYGMy1zjUjnOCPtQYsvE74s8tUzOJ1
 u0ZrhBj08elt52r0gB5fzlmfdpTGUEk3XH27zpdL08ayYDoFF1bZ2xHLhVT8CfZoZ6uvKdnCob2
 sCvcMzj0YV3qhhjfZHwAnW71x7/xw=
X-Gm-Gg: ASbGncvLjuUyVuynmd8PTLNsaCf/ovwA4E0G/04g3v4NFvnLe4cElexT7LNM73ZzEmR
 +AQxSt4Fc+V8b10dc0fdewRA/d+Gr4AWAOAnVIjtJJo4a/zYfAWQOG4Wn01WqBvgWXkk6Ahbicm
 nlxD6y/Cd2YXmeKKTwlk0IUw==
X-Received: by 2002:a17:902:d589:b0:267:cdc8:b30b with SMTP id
 d9443c01a7336-2902741cfbbmr194768975ad.53.1760173638005; 
 Sat, 11 Oct 2025 02:07:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFrrQDSlD0eUmInNTy4kI0bVUOYhep1alsH7YKK12xSeqf3MYIPdlV6XQjoGUkC/1DFZNJGPvmxjm+RHPFeNE=
X-Received: by 2002:a17:902:d589:b0:267:cdc8:b30b with SMTP id
 d9443c01a7336-2902741cfbbmr194768775ad.53.1760173637557; Sat, 11 Oct 2025
 02:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20251010113014.309433-1-pvorel@suse.cz>
In-Reply-To: <20251010113014.309433-1-pvorel@suse.cz>
Date: Sat, 11 Oct 2025 17:07:05 +0800
X-Gm-Features: AS18NWCWrESeAr_-wCafJOfoEajP_LBkT54hhgE1l5AfS23rRhhN49fA0HNdwEc
Message-ID: <CAEemH2dU6XP+Er75eERgo+p7TyMgEjMJY7tjAGA15NOKFrZM+A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JJgXo9XMRRbzFTzlRELdthAr3fpRlmwKGUKtvuKV810_1760173638
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] tst_cmd.h: Convert the rest of comments to
 kerneldoc
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

T24gRnJpLCBPY3QgMTAsIDIwMjUgYXQgNzozMOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gTW92ZSBkb2NzIGZyb20gdGhlIHByaXZhdGUgZnVuY3Rpb24gaW1wbGVt
ZW50YXRpb25zIChmdW5jdGlvbnMgd2l0aAo+IHRyYWlsaW5nIHVuZGVyc2NvcmUpIHRvIGZ1bmN0
aW9ucyB1c2VkIGludG8gZnVuY3Rpb25zIHVzZWQgaW4gdGhlIG5ldwo+IEFQSS4KPgo+IFRoaXMg
YXZvaWRzIHRvIGRvY3VtZW50IHByaXZhdGUgZnVuY3Rpb25zLgo+Cj4gU2lnbmVkLW9mZi1ieTog
UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KCiBSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3
YW5nQHJlZGhhdC5jb20+CgotLS0KPiBGWUkgSSBkYXJlZCB0byBtZXJnZSB0aGUgb2J2aW91cyBw
YXJ0IG9mIHRoZSBjb252ZXJzaW9uOgo+Cj4KPiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVz
dC1wcm9qZWN0L2x0cC9jb21taXQvNTg3MDgwNDliYjI0MDAwYWY5NDdlMDBmYTYxMTUwMWFhMjg0
OTk5YQo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+ICBpbmNsdWRlL3RzdF9jbWQuaCB8IDUy
ICsrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL3RzdF9jbWQuaCBiL2luY2x1ZGUvdHN0X2NtZC5oCj4gaW5kZXggY2Y2Mzgy
OTU1MC4uODM5NzUxMGVkNiAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL3RzdF9jbWQuaAo+ICsrKyBi
L2luY2x1ZGUvdHN0X2NtZC5oCj4gQEAgLTE5LDM4ICsxOSwxMiBAQCBlbnVtIHRzdF9jbWRfZmxh
Z3Mgewo+ICAgICAgICAgVFNUX0NNRF9UQ09ORl9PTl9NSVNTSU5HID0gMiwKPiAgfTsKPgo+IC0v
Kgo+IC0gKiB2Zm9yaygpICsgZXhlY3ZwKCkgc3BlY2lmaWVkIHByb2dyYW0uCj4gLSAqCj4gLSAq
IEBwYXJhbSBhcmd2IEEgbGlzdCBvZiB0d28gKGF0IGxlYXN0IHByb2dyYW0gbmFtZSArIE5VTEwp
IG9yIG1vcmUKPiBwb2ludGVycyB0aGF0Cj4gLSAqIHJlcHJlc2VudCB0aGUgYXJndW1lbnQgbGlz
dCB0byB0aGUgbmV3IHByb2dyYW0uIFRoZSBhcnJheSBvZiBwb2ludGVycwo+IC0gKiBtdXN0IGJl
IHRlcm1pbmF0ZWQgYnkgYSBOVUxMIHBvaW50ZXIuCj4gLSAqIEBwYXJhbSBzdGRvdXRfZmQgRmls
ZSBkZXNjcmlwdG9yIHdoZXJlIHRvIHJlZGlyZWN0IHN0ZG91dC4gU2V0IC0xIGlmCj4gLSAqIHJl
ZGlyZWN0aW9uIGlzIG5vdCBuZWVkZWQuCj4gLSAqIEBwYXJhbSBzdGRlcnJfZmQgRmlsZSBkZXNj
cmlwdG9yIHdoZXJlIHRvIHJlZGlyZWN0IHN0ZGVyci4gU2V0IC0xIGlmCj4gLSAqIHJlZGlyZWN0
aW9uIGlzIG5vdCBuZWVkZWQuCj4gLSAqIEBwYXJhbSBmbGFncyBlbnVtIHRzdF9jbWRfZmxhZ3Mu
Cj4gLSAqIEByZXR1cm4gVGhlIGV4aXQgc3RhdHVzIG9mIHRoZSBwcm9ncmFtLgo+IC0gKi8KPiAg
aW50IHRzdF9jbWRfZmRzXyh2b2lkIChjbGVhbnVwX2ZuKSh2b2lkKSwKPiAgICAgICAgICAgICAg
ICAgICAgICAgICBjb25zdCBjaGFyICpjb25zdCBhcmd2W10sCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgaW50IHN0ZG91dF9mZCwKPiAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgc3RkZXJy
X2ZkLAo+ICAgICAgICAgICAgICAgICAgICAgICAgIGVudW0gdHN0X2NtZF9mbGFncyBmbGFncyk7
Cj4KPiAtLyoKPiAtICogRXhlY3V0ZXMgdHN0X2NtZF9mZHMoKSBhbmQgcmVkaXJlY3RzIGl0cyBv
dXRwdXQgdG8gYSBmaWxlLgo+IC0gKgo+IC0gKiBAcGFyYW0gYXJndiBBIGxpc3Qgb2YgdHdvIChh
dCBsZWFzdCBwcm9ncmFtIG5hbWUgKyBOVUxMKSBvciBtb3JlCj4gcG9pbnRlcnMgdGhhdAo+IC0g
KiByZXByZXNlbnQgdGhlIGFyZ3VtZW50IGxpc3QgdG8gdGhlIG5ldyBwcm9ncmFtLiBUaGUgYXJy
YXkgb2YgcG9pbnRlcnMKPiAtICogbXVzdCBiZSB0ZXJtaW5hdGVkIGJ5IGEgTlVMTCBwb2ludGVy
Lgo+IC0gKiBAcGFyYW0gc3Rkb3V0X3BhdGggUGF0aCB3aGVyZSB0byByZWRpcmVjdCBzdGRvdXQu
IFNldCBOVUxMIGlmCj4gcmVkaXJlY3Rpb24gaXMKPiAtICogbm90IG5lZWRlZC4KPiAtICogQHBh
cmFtIHN0ZGVycl9wYXRoIFBhdGggd2hlcmUgdG8gcmVkaXJlY3Qgc3RkZXJyLiBTZXQgTlVMTCBp
Zgo+IHJlZGlyZWN0aW9uIGlzCj4gLSAqIG5vdCBuZWVkZWQuCj4gLSAqIEBwYXJhbSBmbGFncyBl
bnVtIHRzdF9jbWRfZmxhZ3MuCj4gLSAqIEByZXR1cm4gVGhlIGV4aXQgc3RhdHVzIG9mIHRoZSBw
cm9ncmFtLgo+IC0gKi8KPiAgaW50IHRzdF9jbWRfKHZvaWQgKGNsZWFudXBfZm4pKHZvaWQpLAo+
ICAgICAgICAgICAgICAgICBjb25zdCBjaGFyICpjb25zdCBhcmd2W10sCj4gICAgICAgICAgICAg
ICAgIGNvbnN0IGNoYXIgKnN0ZG91dF9wYXRoLAo+IEBAIC01OCw2ICszMiwyMCBAQCBpbnQgdHN0
X2NtZF8odm9pZCAoY2xlYW51cF9mbikodm9pZCksCj4gICAgICAgICAgICAgICAgIGVudW0gdHN0
X2NtZF9mbGFncyBmbGFncyk7Cj4KPiAgI2lmZGVmIFRTVF9URVNUX0hfXwo+ICsvKioKPiArICog
dHN0X2NtZF9mZHMoKSAtIDptYW4yOmB2Zm9ya2AgKyA6bWFuMjpgZXhlY3ZwYCBzcGVjaWZpZWQg
cHJvZ3JhbS4KPiArICoKPiArICogQGFyZ3Y6IEEgbGlzdCBvZiB0d28gKGF0IGxlYXN0IHByb2dy
YW0gbmFtZSArIE5VTEwpIG9yIG1vcmUgcG9pbnRlcnMKPiB0aGF0Cj4gKyAqIHJlcHJlc2VudCB0
aGUgYXJndW1lbnQgbGlzdCB0byB0aGUgbmV3IHByb2dyYW0uIFRoZSBhcnJheSBvZiBwb2ludGVy
cwo+ICsgKiBtdXN0IGJlIHRlcm1pbmF0ZWQgYnkgYSBOVUxMIHBvaW50ZXIuCj4gKyAqIEBzdGRv
dXRfZmQ6IEZpbGUgZGVzY3JpcHRvciB3aGVyZSB0byByZWRpcmVjdCBzdGRvdXQuIFNldCAtMSBp
Zgo+ICsgKiByZWRpcmVjdGlvbiBpcyBub3QgbmVlZGVkLgo+ICsgKiBAc3RkZXJyX2ZkOiBGaWxl
IGRlc2NyaXB0b3Igd2hlcmUgdG8gcmVkaXJlY3Qgc3RkZXJyLiBTZXQgLTEgaWYKPiArICogcmVk
aXJlY3Rpb24gaXMgbm90IG5lZWRlZC4KPiArICogQGZsYWdzOiBlbnVtIHRzdF9jbWRfZmxhZ3Mu
Cj4gKyAqCj4gKyAqIFJldHVybjogVGhlIGV4aXQgc3RhdHVzIG9mIHRoZSBwcm9ncmFtLgo+ICsg
Ki8KPiAgc3RhdGljIGlubGluZSBpbnQgdHN0X2NtZF9mZHMoY29uc3QgY2hhciAqY29uc3QgYXJn
dltdLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgc3Rkb3V0X2ZkLAo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgc3RkZXJyX2ZkLAo+IEBAIC02
Nyw2ICs1NSwxOCBAQCBzdGF0aWMgaW5saW5lIGludCB0c3RfY21kX2Zkcyhjb25zdCBjaGFyICpj
b25zdCBhcmd2W10sCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGRvdXRfZmQs
IHN0ZGVycl9mZCwgZmxhZ3MpOwo+ICB9Cj4KPiArLyoqCj4gKyAqIHRzdF9jbWQoKSAtIEV4ZWN1
dGVzIHRzdF9jbWRfZmRzKCkgYW5kIHJlZGlyZWN0cyBpdHMgb3V0cHV0IHRvIGEgZmlsZS4KPiAr
ICoKPiArICogQGFyZ3Y6IEEgbGlzdCBvZiB0d28gKGF0IGxlYXN0IHByb2dyYW0gbmFtZSArIE5V
TEwpIG9yIG1vcmUgcG9pbnRlcnMKPiB0aGF0Cj4gKyAqIEBzdGRvdXRfcGF0aDogUGF0aCB3aGVy
ZSB0byByZWRpcmVjdCBzdGRvdXQuIFNldCBOVUxMIGlmIHJlZGlyZWN0aW9uIGlzCj4gKyAqIG5v
dCBuZWVkZWQuCj4gKyAqIEBzdGRlcnJfcGF0aDogUGF0aCB3aGVyZSB0byByZWRpcmVjdCBzdGRl
cnIuIFNldCBOVUxMIGlmIHJlZGlyZWN0aW9uIGlzCj4gKyAqIG5vdCBuZWVkZWQuCj4gKyAqIEBm
bGFnczogZW51bSB0c3RfY21kX2ZsYWdzLgo+ICsgKgo+ICsgKiBSZXR1cm46IFRoZSBleGl0IHN0
YXR1cyBvZiB0aGUgcHJvZ3JhbS4KPiArICovCj4gIHN0YXRpYyBpbmxpbmUgaW50IHRzdF9jbWQo
Y29uc3QgY2hhciAqY29uc3QgYXJndltdLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbnN0IGNoYXIgKnN0ZG91dF9wYXRoLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbnN0IGNoYXIgKnN0ZGVycl9wYXRoLAo+IC0tCj4gMi41MS4wCj4KPgo+IC0tCj4gTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
