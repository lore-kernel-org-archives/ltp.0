Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C11EFB7ED
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 02:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771901925; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pZWmR3g2PJZzqqNM/J2hCIHGqzI4Eefo9pGrvgwYbQI=;
 b=c9DZFeayHGjADiTkKTr1Du82RMk8jhJTWiQoOb4Aywoy8ZECmAvq08srsQmBE03s/SYrL
 LL3rkCfDlBl9wWJ6Kg3tNFw985M7ANv0tQvZCm1Ces4nifYXAcVPxmXlWfYU58v8X2ycs3J
 ebaGp+EsUZDYSVpUXjwUZS+us/aoC2s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30EA13D0F73
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 03:58:45 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5BF93CB3D7
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 03:58:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 977351A0078A
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 03:58:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771901898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G78vHfvPVOa0uiFIW1WQjlxS95O9rHk9RuVcZosnOy4=;
 b=FGXp5KjLq5bnM5JXxVN35rD5e+9DTZNhDYpUgWeKe9YkGJIW3pMVkDYhvZrU/oqcGxVHkn
 HxtPY57ORbd5WoHqoYc08QH1mdyC2nNIR0qGXFAplF7nL25OyL/Yad5MgswzKSM9W9xkfb
 JhdD/imIL4sQuq3DdwjbTFbsT8wfjNk=
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com
 [74.125.82.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Bp_0k3tAO9ur70XMPIJUog-1; Mon, 23 Feb 2026 21:58:14 -0500
X-MC-Unique: Bp_0k3tAO9ur70XMPIJUog-1
X-Mimecast-MFC-AGG-ID: Bp_0k3tAO9ur70XMPIJUog_1771901893
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-127337c8e52so7003300c88.1
 for <ltp@lists.linux.it>; Mon, 23 Feb 2026 18:58:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771901893; x=1772506693;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G78vHfvPVOa0uiFIW1WQjlxS95O9rHk9RuVcZosnOy4=;
 b=JY9x3NHo3CjSCg3e3SGLB3sg/LejuHVaa+jt8jYhGvIU7laPHETUDIMgePKMT31WXs
 rdkxJbZIelxSJDVMK2yHTlmrnEzkebuOcuaM4AOKJCcrPv56oFzQMoY/hNRic2IPReIY
 WjlIDExTE+nmWvjP5ELw7oTTtwefaSWxzisOl4tNzm28Fvslem9I+i0e/wZcouv9XPFR
 F3hN5KmQyO5m8dcTZFoNuycyrf8xLOQJW+6mbdtT263zBbJWkj7Y9Xg+wPgc1cJ0W6Oo
 aQKph4rZCdSEX/Hofe0Nk2/7Mp8LnN++4KQEbVolrIPWSNM+haf5jQOc6pAtTKl5s4A7
 dHhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlQhpq1cOMiL06O2JkIm5X0HJTm/GYv6yfN86qgw5EfzEI5EWQcEjiHPsdf9XokEFTimM=@lists.linux.it
X-Gm-Message-State: AOJu0YwC2SBbhEfC8zn7/ecI3dn6ZapIVGz+fOBXMA2kK7uJgVSdtGBE
 bqMj4b9Ise6ggCQVbRSYuxmAK67mZ6lfvXaMn6v4MizSXSParRd2b9aqp32QQtFkY7jSKsmWyDV
 02eNpV5FkthBZ23M9nuhaYUCPE4pJPxUAuJNN891aFvrFoIo4qv77yZrTNH9S+s9OHC/BYeYm+l
 w8OeL7uxKetFBd8U0Uc6j52zs0TeA=
X-Gm-Gg: AZuq6aKNH52ppzb00DwdCyjXGoF+1f2F+0OLb0YiifyMzdFdv6+Z1AbIo6g7I5QNOf7
 y8wgl9AVBzPgYjmPll/fopDM8DbmHjXDW24gnD74pD/7wVykE7soXH9VYm4mhrzhH+mez3itcIK
 2WC4p/XaJ/HmH0W24aRuK+5ih0QDylnA6N/8TwrB7XphiIvwl6/eouVpkYXykx6tcKRtogAtIUu
 uNUN2U=
X-Received: by 2002:a05:7022:2214:b0:11b:f056:a1b3 with SMTP id
 a92af1059eb24-1276acb89d0mr5227133c88.11.1771901893315; 
 Mon, 23 Feb 2026 18:58:13 -0800 (PST)
X-Received: by 2002:a05:7022:2214:b0:11b:f056:a1b3 with SMTP id
 a92af1059eb24-1276acb89d0mr5227122c88.11.1771901892707; Mon, 23 Feb 2026
 18:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20260202091801.68673-1-liwang@redhat.com>
 <20260202101430.GA24157@pevik>
 <DGI4Q3T70R5J.27XFN77L0MND8@suse.com>
In-Reply-To: <DGI4Q3T70R5J.27XFN77L0MND8@suse.com>
Date: Tue, 24 Feb 2026 10:58:00 +0800
X-Gm-Features: AaiRm52L4QN6CN2LiA6ABSBDmGWWdCh8bkY2Umnjh0ONs2B8cDPTHRxFtQMpeEg
Message-ID: <CAEemH2eQrjqma6YoQ9yLoaRLDqH7LVQ8ppuGVeaA4kJr0g9ihQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gzOCgA3XiJofGPA58PtSgyMl2Zn1qunNmOemMXPhhAk_1771901893
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] doc/developers: document tst_/tse_/tso_ library
 namespaces
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

SGkgQW5kcmVhLCBQZXRyLAoKUGF0Y2ggbWVyZ2VkICh3aXRoIFBldHIncyBzdWdnZXN0aW9ucyks
IHRoYW5rcyEKCk9uIFdlZCwgRmViIDE4LCAyMDI2IGF0IDk6NDHigK9QTSBBbmRyZWEgQ2VydmVz
YXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgp3cm90ZToKCj4gSGkhCj4KPiBPbiBNb24g
RmViIDIsIDIwMjYgYXQgMTE6MTQgQU0gQ0VULCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4gSGkgTGks
Cj4gPgo+ID4gPiBUaGlzIGhlbHBzIGNvbnRyaWJ1dG9ycyBjaG9vc2UgdGhlIGNvcnJlY3QgbGF5
ZXIgd2hlbiBhZGRpbmcgbmV3Cj4gbGlicmFyeQo+ID4gPiBjb2RlIGFuZCBjbGFyaWZpZXMgZXhw
ZWN0YXRpb25zIGFyb3VuZCBsZWdhY3kgY29tcG9uZW50cy4KPiA+Cj4gPiA+IEZvbGxvdy11cDog
ZWVmNzUwZGIyOCAoImxpYnM6IGFkb3B0IHRzZV8gcHJlZml4IGZvciBleHRlbmRlZAo+IChub24t
Y29yZSkgbGlicmFyeSIpCj4gPiA+IEZvbGxvdy11cDogNzUxZGY0ZmE2NCAoImluY2x1ZGUvb2xk
OiByZW5hbWUgbGVnYWN5IGhlYWRlcnMgdG8gdHNvXyoKPiBuYW1lc3BhY2UiKQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPiA+ID4gLS0tCj4gPiA+ICBk
b2MvZGV2ZWxvcGVycy9sdHBfbGlicmFyeS5yc3QgfCAyOCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQo+ID4KPiA+ID4g
ZGlmZiAtLWdpdCBhL2RvYy9kZXZlbG9wZXJzL2x0cF9saWJyYXJ5LnJzdAo+IGIvZG9jL2RldmVs
b3BlcnMvbHRwX2xpYnJhcnkucnN0Cj4gPiA+IGluZGV4IGY3NmNiYjc1ZS4uYmIyNjc3NjIyIDEw
MDY0NAo+ID4gPiAtLS0gYS9kb2MvZGV2ZWxvcGVycy9sdHBfbGlicmFyeS5yc3QKPiA+ID4gKysr
IGIvZG9jL2RldmVsb3BlcnMvbHRwX2xpYnJhcnkucnN0Cj4gPiA+IEBAIC0xNSw2ICsxNSwzNCBA
QCBmb3IgOmRvYzpgd3JpdGluZyB0ZXN0cwo+IDwuLi9kZXZlbG9wZXJzL3dyaXRpbmdfdGVzdHM+
YAo+ID4gPiAgIy4gRG8gbm90IGFkZCBuZXcgQVBJIGZ1bmN0aW9ucyB0byB0aGUgb2xkIEFQSS4g
QWRkIG5ldyBmdW5jdGlvbnMgdG8KPiA+ID4gICAgIGBgdHN0Xy5bY2hdYGAgZmlsZXMuCj4gPgo+
ID4gPiArTGlicmFyeSBuYW1pbmcgYW5kIHNjb3BlCj4gPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KPiA+ID4gKwo+ID4gPiArVG8ga2VlcCB0aGUgbGlicmFyeSBBUEkgZWFzeSB0byBuYXZp
Z2F0ZSBhbmQgdG8gbWFrZSBsYXllcmluZwo+IGV4cGxpY2l0LCBMVFAKPiA+ID4gK2xpYnJhcnkg
Y29tcG9uZW50cyBmb2xsb3cgdGhlc2UgbmFtaW5nIHJ1bGVzOgo+ID4gPiArCj4gPiA+ICstICoq
dHN0XyoqOiBDb3JlIExUUCBsaWJyYXJ5IEFQSSAobG9jYXRlZCBpbiBgYGxpYi9gYCkuCj4gPiBu
aXQ6IG1heWJlIGFsc28gdXNlIDptYXN0ZXI6IGZvciBsaWIvIHRvIG1ha2UgaXQgY2xpY2thYmxl
Pwo+ID4gPiArCj4gPiA+ICsgIC0gU3RhYmxlLCB3aWRlbHkgdXNlZCBpbnRlcmZhY2VzIGludGVu
ZGVkIGZvciBnZW5lcmFsIGNvbnN1bXB0aW9uCj4gYnkgdGVzdHMuCj4gPiA+ICsgIC0gTmV3IHB1
YmxpYyBBUElzIHNob3VsZCBub3JtYWxseSBsaXZlIGhlcmUgKGluIGBgdHN0XyouaGBgIC8KPiBg
YHRzdF8qLmNgYCkuCj4gPiA+ICsKPiA+ID4gKy0gKip0c2VfKio6IE5vbi1jb3JlIC8gZXh0ZW5k
ZWQgbGlicmFyeSBjb2RlIChsb2NhdGVkIGluIGBgbGlicy9gYCkuCj4gPiBuaXQ6IGFuZCBoZXJl
IGFzIHdlbGw/Cj4gPgo+ID4gPiArCj4gPiA+ICsgIC0gT3B0aW9uYWwgb3Igc3BlY2lhbGl6ZWQg
aGVscGVycyB0aGF0IGFyZSBub3QgcGFydCBvZiB0aGUgY29yZSBBUEkuCj4gPiA+ICsgIC0gTWF5
IGhhdmUgbmFycm93ZXIgc2NvcGUgb3IgZmV3ZXIgc3RhYmlsaXR5IGd1YXJhbnRlZXMgdGhhbgo+
IGBgdHN0X2BgLgo+ID4gPiArICAtIENhbiBiZSBwcm9tb3RlZCB0byBgYHRzdF9gYCBsYXRlciBp
ZiBpdCBiZWNvbWVzIGJyb2FkbHkgdXNlZnVsCj4gYW5kIHN0YWJsZS4KPiA+ID4gKwo+ID4gPiAr
LSAqKnRzb18qKjogTGVnYWN5IC8gb2xkIGxpYnJhcnkgY29kZS4KPiA+ID4gKwo+ID4gPiArICAt
IEtlcHQgZm9yIGJhY2t3YXJkIGNvbXBhdGliaWxpdHkuCj4gPiA+ICsgIC0gTm8gbmV3IGZlYXR1
cmVzIHNob3VsZCBiZSBhZGRlZDsgb25seSBtaW5pbWFsIGZpeGVzIGFyZQo+IGFjY2VwdGFibGUg
KGUuZy4gYnVpbGQgZml4ZXMsIGNvcnJlY3RuZXNzIGZpeGVzLCBzZWN1cml0eSBmaXhlcykuCj4g
PiB2ZXJ5IG5pdDogbWF5YmUgc3BsaXQgbG9uZyBsaW5lPwo+ID4KPiA+ID4gKyAgLSBOZXcgY29k
ZSBzaG91bGQgbm90IGRlcGVuZCBvbiBgYHRzb19gYCB1bmxlc3Mgc3RyaWN0bHkgbmVjZXNzYXJ5
Lgo+ID4gPiArCj4gPiA+ICsqKk5vdGVzOioqCj4gPgo+ID4gbml0OiBJJ2QgcHJlZmVyIHRoZSBz
dGFuZGFyZCBub3RlIChjYW4gYmUgY2hhbmdlZCBiZWZvcmUgbWVyZ2UpOgo+ID4KPiA+IC4uIG5v
dGU6Ogo+ID4KPiA+ID4gKwo+ID4gPiArLSBQcmVmZXIgYWRkaW5nIG5ldyBjb2RlIHRvIGBgdHN0
X2BgIG9yIGBgdHNlX2BgOyBhdm9pZCBpbnRyb2R1Y2luZwo+IG5ldyBgYHRzb19gYCBjb21wb25l
bnRzLgo+ID4gPiArLSBXaGVuIGFkZGluZyBhIG5ldyBwdWJsaWMgaW50ZXJmYWNlLCBkb2N1bWVu
dCB3aGVyZSBpdCBiZWxvbmdzCj4gKGBgdHN0X2BgIHZzIGBgdHNlX2BgKSBhbmQgd2h5Lgo+ID4K
PiA+IExHVE0sIGJ1dCBJJ2QgcHJlZmVyIG1vcmUgZGV2ZWxvcGVycyBhY2tlZCBpdC4KPiA+Cj4g
PiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPgo+ID4gS2luZCBy
ZWdhcmRzLAo+ID4gUGV0cgo+Cj4gV2l0aCBQZXRyIHN1Z2dlc3Rpb25zLAo+Cj4gUmV2aWV3ZWQt
Ynk6IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPgo+IC0t
Cj4gQW5kcmVhIENlcnZlc2F0bwo+IFNVU0UgUUUgQXV0b21hdGlvbiBFbmdpbmVlciBMaW51eAo+
IGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20KPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
