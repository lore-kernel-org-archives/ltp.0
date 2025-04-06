Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E343C36010
	for <ltp@archiver.kernel.org>; Sun,  6 Apr 2025 03:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743908511; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=wm+EppwnBsfSTjYTezBQxKOb435YlqBijd1Ejsl1GZQ=;
 b=Q326Ezjn8oavm2GnAZfOKj+FEPE6jCpLhUoU6L1oPXXsxrT7Dw32YXeAeThWEQWwnAqix
 02pni1iVsNJE3SPBYgtC9M6LRrtGZ2hBVW2E9x2NdoREV68bO24uIpGqUJPd4lk2UX9Db8z
 J6csPTvVF8x8cGcgSIeYTavsMflIlno=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E10CE3CB04B
	for <ltp@archiver.kernel.org>; Sun,  6 Apr 2025 05:01:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 208823C9A52
 for <ltp@lists.linux.it>; Sun,  6 Apr 2025 05:01:30 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 08CAF100044E
 for <ltp@lists.linux.it>; Sun,  6 Apr 2025 05:01:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743908486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fzshd5N7kaWObeWtxatjcOdz2w9zR+3GJR6979gdSN0=;
 b=HWdcIp5OZMFQhTYzbMinnq7Jv0AxzrsmCS+sXTu4cWbaHrPxeImKL9B8EmaLms7rFoGt9I
 1fnK3Ir3UL/jGW/rbS7qqJcAyKWRAzH+HR6CewGw9fHkzgUTyjRYxf/AnELKX4drcJDOpo
 1/r0xFB/G5LERHUFNk/NAkjX9+6Hnb4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-ZmDLRwiFMRGp0c_8u46dwg-1; Sat, 05 Apr 2025 23:01:24 -0400
X-MC-Unique: ZmDLRwiFMRGp0c_8u46dwg-1
X-Mimecast-MFC-AGG-ID: ZmDLRwiFMRGp0c_8u46dwg_1743908483
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff6aaa18e8so3035319a91.1
 for <ltp@lists.linux.it>; Sat, 05 Apr 2025 20:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743908483; x=1744513283;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fzshd5N7kaWObeWtxatjcOdz2w9zR+3GJR6979gdSN0=;
 b=rsdwZS5Sjld+utYIjGvxc8Iw43wJJzaGRyUxr3nDD1f5kP3V4GfhCRUOZ+6LOHPeVg
 ++9M7zzY+b5IvUNg13CyHIKIU/4fsTr0PSvcza1l9Z/v/Gs2s0M6698D6li3qBU4lG29
 i98J9/TybZsuj+Re4SaNtOuZGJ2386dngctm65varC8g5Na0mYzZP1pBisDKu3/PDWNc
 6Bz3y6EzXdtV9baXtKilp2uEEw3h+Vc8/puLjmwUf+b3iNqZ2nT5oYHl5hWwzBkeW4fp
 AeDT82x5LnIY4ZISeenpkUiJo/Id6C5t4YflVRBvETVv8Zyo9gJULigYlVQu5QjxydoY
 Y+UA==
X-Gm-Message-State: AOJu0YwLxDgwArWegsrExDxrKbdf8ykUcn98N3L2jAfkQkwwUYOexokk
 HZKSgg1BmuJKBMVI6AQMO3bThOKys06mVGrFo2G73OtmBdf8Xj/CgGQ3t14nxacmURehtG1xpp9
 D5hn8R3JJ4o68ds9B3ggdjrVU71JTIOkkQhb2j7Vtc2gsAW+NDMZnrvwMwLoIVUTXR9yx6OLYK9
 YUTg0t0z0z++3YHdYXrAkvETk=
X-Gm-Gg: ASbGncusjgHhg2lBCWSwTGlh6qui1c8xUm/VNu1DR8VtKmg5LcK9uetzrAUJx6eYrAI
 LTMGv2cWzu3JGdCC83DuAJVxJsGlodbCHyAAqR//nd1IeEuHwlzmajtZPnDxI4vS+YeqW8hbPVA
 ==
X-Received: by 2002:a17:90a:f945:b0:2f6:dcc9:38e0 with SMTP id
 98e67ed59e1d1-306a4758cf3mr14358874a91.0.1743908483394; 
 Sat, 05 Apr 2025 20:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeG0P71Z9Jwig2r9C9caLNw400Z9XV2hS+rjlGi2eHklDu4Ktw3a8PpFsK5y+fYDuZoPKVEFnliohCCVPR/Hs=
X-Received: by 2002:a17:90a:f945:b0:2f6:dcc9:38e0 with SMTP id
 98e67ed59e1d1-306a4758cf3mr14358847a91.0.1743908483022; Sat, 05 Apr 2025
 20:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250403101912.459507-1-pvorel@suse.cz>
 <20250403101912.459507-3-pvorel@suse.cz>
In-Reply-To: <20250403101912.459507-3-pvorel@suse.cz>
Date: Sun, 6 Apr 2025 11:01:10 +0800
X-Gm-Features: ATxdqUHyvSDiX9ZTiu5om_42qCWWV9eY0UXUdQGjOKJLntpqnt4gDVv1DIQ1eTY
Message-ID: <CAEemH2dsdhgKNHTJY8apYEoe1a2RWrZFvMefd8rML1GwP8Lxkw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2ageIDfvDIVTWST4SV6c_t5dhv_6qZfAyP6jMgGp69k_1743908483
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC][PATCH 2/2] runtest: Move ipc into syscalls
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

T24gVGh1LCBBcHIgMywgMjAyNSBhdCA2OjE54oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBJdCdzIG5vdCB3b3J0aCB0byBrZWVwIHNlcGFyYXRlIHJ1bnRlc3QgZmls
ZSBmb3IgOCB2ZXJ5IHF1aWNrIHRlc3RzLgo+IHN5c2NhbGxzLWlwYyB3b3VsZCBiZSBvYnZpb3Vz
IHJ1bnRlc3QgdG8gbW92ZSwgYnV0IGl0IGNvbnRhaW5zIHRlc3RzIGZvcgo+IG1lc3NhZ2UgcXVl
dWVzLCBzZW1hcGhvcmVzIGV0Yy4gT3RoZXIgSVBDIHRlc3RzIGFyZSBpbiBzeXNjYWxscyBydW50
ZXN0LAo+IHRoZXJlZm9yZSBtb3ZlIHRlc3RzIHRoZXJlLgo+Cj4gUmVtb3ZlIHRlc3QgZGVzY3Jp
cHRpb24gKGNhbiBiZSB2aXNpYmxlIGZyb20gaGVscCBhbmQgdGhlIHRlc3Qgb3V0cHV0LAo+IGl0
IHdhcyBhbHNvIGJlbG93IHRoZSB0ZXN0IG5vdCBhYm92ZSkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBQ
ZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KCi0tLQo+ICBydW50ZXN0L2lwYyAgICAgIHwgMjgg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICBydW50ZXN0L3N5c2NhbGxzIHwgIDkgKysr
KysrKysrCj4gIDIgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyOCBkZWxldGlvbnMo
LSkKPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IHJ1bnRlc3QvaXBjCj4KPiBkaWZmIC0tZ2l0IGEvcnVu
dGVzdC9pcGMgYi9ydW50ZXN0L2lwYwo+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDY0NAo+IGluZGV4
IGY1Y2RlYTE5NzQuLjAwMDAwMDAwMDAKPiAtLS0gYS9ydW50ZXN0L2lwYwo+ICsrKyAvZGV2L251
bGwKPiBAQCAtMSwyOCArMCwwIEBACj4KCgo+IC0jREVTQ1JJUFRJT046SW50ZXJwcm9jZXNzIGNv
bW11bmljYXRpb24gc3RyZXNzCj4gLSMgVGhlc2UgdGVzdHMgdXNlIHRlc3RzL3BpcGVpbyB0byBw
dXQgcGlwZXMgKG5hbWVkIG9yIHVubmFtZWQpIHRocm91Z2ggYQo+IHdvcmtvdXQKPgoKCj4gLSMK
PiAtcGlwZWlvXzEgcGlwZWlvIC1UIHBpcGVpb18xIC1jIDUgLXMgNDA5MCAtaSAxMDAgLWIgLWYg
eDgwCj4gLSMgc3Bhd25zIDUgY2hpbGRyZW4gdG8gd3JpdGUgMTAwIGNodW5rcyBvZiA0MDkwIGJ5
dGVzIHRvIGEgbmFtZWQgcGlwZQo+IC0jIHVzaW5nIGJsb2NraW5nIEkvTwo+IC1waXBlaW9fMiBw
aXBlaW8gLVQgcGlwZWlvXzIgLWMgNSAtcyA0MDkwIC1pIDEwMCAtZiB4ODAKPiAtIyBzcGF3bnMg
NSBjaGlsZHJlbiB0byB3cml0ZSAxMDAgY2h1bmtzIG9mIDQwOTAgYnl0ZXMgdG8gYSBuYW1lZCBw
aXBlCj4gLSMgdXNpbmcgbm9uLWJsb2NraW5nIEkvTwo+IC1waXBlaW9fMyBwaXBlaW8gLVQgcGlw
ZWlvXzMgLWMgNSAtcyA0MDkwIC1pIDEwMCAtdSAtYiAtZiB4ODAKPiAtIyBzcGF3bnMgNSBjaGls
ZHJlbiB0byB3cml0ZSAxMDAgY2h1bmtzIG9mIDQwOTAgYnl0ZXMgdG8gYW4gdW5uYW1lZCBwaXBl
Cj4gLSMgdXNpbmcgYmxvY2tpbmcgSS9PCj4gLXBpcGVpb180IHBpcGVpbyAtVCBwaXBlaW9fNCAt
YyA1IC1zIDQwOTAgLWkgMTAwIC11IC1mIHg4MAo+IC0jIHNwYXducyA1IGNoaWxkcmVuIHRvIHdy
aXRlIDEwMCBjaHVua3Mgb2YgNDA5MCBieXRlcyB0byBhbiB1bm5hbWVkIHBpcGUKPiAtIyB1c2lu
ZyBub24tYmxvY2tpbmcgSS9PCj4gLXBpcGVpb181IHBpcGVpbyAtVCBwaXBlaW9fNSAtYyA1IC1z
IDUwMDAgLWkgMTAgLWIgLWYgeDgwCj4gLSMgc3Bhd25zIDUgY2hpbGRyZW4gdG8gd3JpdGUgMTAg
Y2h1bmtzIG9mIDUwMDAgYnl0ZXMgdG8gYSBuYW1lZCBwaXBlCj4gLSMgdXNpbmcgYmxvY2tpbmcg
SS9PCj4gLXBpcGVpb182IHBpcGVpbyAtVCBwaXBlaW9fNiAtYyA1IC1zIDUwMDAgLWkgMTAgLWIg
LXUgLWYgeDgwCj4gLSMgc3Bhd25zIDUgY2hpbGRyZW4gdG8gd3JpdGUgMTAgY2h1bmtzIG9mIDUw
MDAgYnl0ZXMgdG8gYW4gdW5uYW1lZCBwaXBlCj4gLSMgdXNpbmcgYmxvY2tpbmcgSS9PCj4gLXBp
cGVpb183IHBpcGVpbyAtVCBwaXBlaW9fNyAtYyA1IC1zIDUwMDAgLWkgMTAgLWYgeDgwCj4gLSMg
c3Bhd25zIDUgY2hpbGRyZW4gdG8gd3JpdGUgMTAgY2h1bmtzIG9mIDUwMDAgYnl0ZXMgdG8gYSBu
YW1lZCBwaXBlCj4gLSMgdXNpbmcgbm9uLWJsb2NraW5nIEkvTwo+IC1waXBlaW9fOCBwaXBlaW8g
LVQgcGlwZWlvXzggLWMgNSAtcyA1MDAwIC1pIDEwIC11IC1mIHg4MAo+IC0jIHNwYXducyA1IGNo
aWxkcmVuIHRvIHdyaXRlIDEwIGNodW5rcyBvZiA1MDAwIGJ5dGVzIHRvIGFuIHVubmFtZWQgcGlw
ZQo+IC0jIHVzaW5nIG5vbi1ibG9ja2luZyBJL08KPiAtCj4gZGlmZiAtLWdpdCBhL3J1bnRlc3Qv
c3lzY2FsbHMgYi9ydW50ZXN0L3N5c2NhbGxzCj4gaW5kZXggMDViM2UwZDM3Ni4uYjkxMWFiYTdi
NiAxMDA2NDQKPiAtLS0gYS9ydW50ZXN0L3N5c2NhbGxzCj4gKysrIGIvcnVudGVzdC9zeXNjYWxs
cwo+IEBAIC0xMDQ3LDYgKzEwNDcsMTUgQEAgcGlwZTJfMDEgcGlwZTJfMDEKPiAgcGlwZTJfMDIg
cGlwZTJfMDIKPiAgcGlwZTJfMDQgcGlwZTJfMDQKPgo+Ck1heWJlIHdlIGNhbiBhZGQgb25lLWxp
bmUgY29tbWVudHMgaGVyZSB0byBleHBsYWluIHRoYXQgdGhlc2UgYXJlCkludGVycHJvY2VzcyBj
b21tdW5pY2F0aW9uIHN0cmVzcyB0ZXN0PwoKU2luY2Ugc3lzY2FsbHMgaXMgYSBsYXJnZSBmaWxl
IChjb250YWluaW5nIHNvIG1hbnkgdGVzdHMpLCBpdCBtYWtlcyBzZW5zZQp0byBjb21tZW50IG9u
IHNvbWV0aGluZyB0aGVyZSB0byBleHBsYWluIHRoZSBzdWJ0ZXN0IGJsb2Nrcy4KCgorcGlwZWlv
XzEgcGlwZWlvIC1UIHBpcGVpb18xIC1jIDUgLXMgNDA5MCAtaSAxMDAgLWIgLWYgeDgwCj4gK3Bp
cGVpb18yIHBpcGVpbyAtVCBwaXBlaW9fMiAtYyA1IC1zIDQwOTAgLWkgMTAwIC1mIHg4MAo+ICtw
aXBlaW9fMyBwaXBlaW8gLVQgcGlwZWlvXzMgLWMgNSAtcyA0MDkwIC1pIDEwMCAtdSAtYiAtZiB4
ODAKPiArcGlwZWlvXzQgcGlwZWlvIC1UIHBpcGVpb180IC1jIDUgLXMgNDA5MCAtaSAxMDAgLXUg
LWYgeDgwCj4gK3BpcGVpb181IHBpcGVpbyAtVCBwaXBlaW9fNSAtYyA1IC1zIDUwMDAgLWkgMTAg
LWIgLWYgeDgwCj4gK3BpcGVpb182IHBpcGVpbyAtVCBwaXBlaW9fNiAtYyA1IC1zIDUwMDAgLWkg
MTAgLWIgLXUgLWYgeDgwCj4gK3BpcGVpb183IHBpcGVpbyAtVCBwaXBlaW9fNyAtYyA1IC1zIDUw
MDAgLWkgMTAgLWYgeDgwCj4gK3BpcGVpb184IHBpcGVpbyAtVCBwaXBlaW9fOCAtYyA1IC1zIDUw
MDAgLWkgMTAgLXUgLWYgeDgwCj4KCgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhh
dC5jb20+CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
