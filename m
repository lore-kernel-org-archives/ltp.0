Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF4BE7D0BB
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 01:48:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C3923CE3BE
	for <ltp@archiver.kernel.org>; Fri, 22 Sep 2023 03:48:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 993BE3CB5CE
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 03:48:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 73C0E1400075
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 03:48:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695347308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VI7GAGGVIs0M4tP0oPw7tnA/M6hZ/R6MWnEityXYD60=;
 b=GoMYNEkwousiIJfqdWGbyKB1cVbqZUGkg5D/ih82LPtRXDD0Ej5LdxlOy3mc1/elytusO5
 V6JW09cpHDsnmUM6tHmrowaGN5fepgTrf4gKFEAr6r4D7uDw1jRFUKmnLCo+Rn/L8H/Tf0
 k+R0MTZHn9vsGwVYpMLKsCUBC/KGwUs=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-zaqKBsl7OO-eQcz4ddOLhQ-1; Thu, 21 Sep 2023 21:48:27 -0400
X-MC-Unique: zaqKBsl7OO-eQcz4ddOLhQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50433961a36so929618e87.3
 for <ltp@lists.linux.it>; Thu, 21 Sep 2023 18:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695347305; x=1695952105;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VI7GAGGVIs0M4tP0oPw7tnA/M6hZ/R6MWnEityXYD60=;
 b=KovbvvpR25uq/6onFsQ3dJn3NX+t3o6s9PycAgz8LRRXVSzBZr7Ey+rWqYykz8KLf/
 zMxQoNbY2Ai27vo4904O7HIybPLJhZ7cWxvl/xrepOrCzUBWxFJj7FXpyFIi4nayRC3V
 jAh2j419beUk79Yj2eSvXYN5MESo9XT9NQu7L7DtmxHQUJOa7QLBa2FndfEeIFmgRxwA
 VWeUg+75Zxm5mORiUStLfomDL05VxYLRY4EGimojAme0DwX4ExVvA4C31L/XkFxOb5Qk
 LKCWqK+6Ho+h783YgqssWY+scDJ1bA2pKvTQYcBIrJoQyNmwOoosh8eybvzez0+eDca3
 JYYg==
X-Gm-Message-State: AOJu0Yxym3SYfROy8VeJPu0Z2xnLedrxTQ3Upp1ISaLXHffgnQRQN/sm
 MrQw+dXiwCnF93rzsiDJ2FcJiY+wHFzfGJAbk9nRLYXTXrOL7e7uNvwJ6yWYXmOx+7b/C8V0EdZ
 ZaOsjMPTSfodXD0yv6ov8/hAwWiVc+MnpmNB3CxhL
X-Received: by 2002:a19:5058:0:b0:503:38bc:e68c with SMTP id
 z24-20020a195058000000b0050338bce68cmr6263889lfj.47.1695347304797; 
 Thu, 21 Sep 2023 18:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBMm8ZfK1gO/zI/FCA6hP/waGW8g/LZY2EOTSk8CClu2IIUYEWHdP7+qtHOk/Q/JiSI0p4kxRwj8aalc6LrLI=
X-Received: by 2002:a19:5058:0:b0:503:38bc:e68c with SMTP id
 z24-20020a195058000000b0050338bce68cmr6263880lfj.47.1695347304395; Thu, 21
 Sep 2023 18:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230921140721.11382-1-chrubis@suse.cz>
In-Reply-To: <20230921140721.11382-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 22 Sep 2023 09:48:12 +0800
Message-ID: <CAEemH2fir0Ta6=BnpXGhJD8o4CrPUTMnjNG0JKW1C2S-M4SVZw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] lib: tst_test: Fix lockdown detection on
 missing sysfs
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

T24gVGh1LCBTZXAgMjEsIDIwMjMgYXQgMTA6MDbigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IFRoZSBsb2NrZG93biBkZXRlY3Rpb24gZnVuY3Rpb24gcmVwb3J0
cyAtMSB3aGVuIHNlY3VyZSBib290IHN5c2ZzIGZpbGUKPiBpcyBub3QgcHJlc2VudCwgd2hpY2gg
aXMgbGF0ZXIgbWlzdGFrZW5seSBpbnRlcnByZXRlZCBhcyBzZWN1cmUgYm9vdAo+IGVuYWJsZWQg
aW4gdHN0X3Rlc3QuYy4KPgo+IFRoaXMgY2F1c2VzIHJlZ3Jlc3Npb24gaW4gKl9tb2R1bGUgc3lj
YWxsIHRlc3RzIGV4ZWN1dGVkIG9uIHN5c3RlbXMgd2hlbgo+IHNlY3VyZWJvb3QgaXMgbm90IGNv
bXBpbGVkLWluIG9yIHN1cHBvcnRlZCBhdCBhbGwuCj4KPiBDaGVjayBwcm9wZXJseSBpZiBzZWN1
cmUgYm9vdCBpcyBlbmFibGVkIGJ5IGNoZWNraW5nIHRoYXQgdGhlIHJldHVybgo+IHZhbHVlIGZy
b20gdGhlc2UgZnVuY3Rpb25zIGlzIHBvc2l0aXZlLgo+CgpTaG91bGQgd2UgZml4IHRoZSBkZXRl
Y3Rpb24gb2YgYWRkaXRpb25hbCB0aG9zZSB0b28/CiAgZmluaXRfbW9kdWxlMDIuYywgaW5pdF9t
b2R1bGUwMi5jLCBtYWR2aXNlMTEuYwoKT3RoZXJ3aXNlLCB0aGlzIG1ldGhvZCBsb29rcyBnb29k
LgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoKCj4KPiBTaWduZWQt
b2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiAtLS0KPiAgbGliL3RzdF90
ZXN0LmMgfCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9saWIvdHN0X3Rlc3QuYyBiL2xpYi90c3RfdGVzdC5j
Cj4gaW5kZXggMmU1OGNhZDMzLi5lMmMxOTU2NDUgMTAwNjQ0Cj4gLS0tIGEvbGliL3RzdF90ZXN0
LmMKPiArKysgYi9saWIvdHN0X3Rlc3QuYwo+IEBAIC0xMTYzLDEwICsxMTYzLDEwIEBAIHN0YXRp
YyB2b2lkIGRvX3NldHVwKGludCBhcmdjLCBjaGFyICphcmd2W10pCj4gICAgICAgICBpZiAodHN0
X3Rlc3QtPnN1cHBvcnRlZF9hcmNocyAmJgo+ICF0c3RfaXNfb25fYXJjaCh0c3RfdGVzdC0+c3Vw
cG9ydGVkX2FyY2hzKSkKPiAgICAgICAgICAgICAgICAgdHN0X2JyayhUQ09ORiwgIlRoaXMgYXJj
aCAnJXMnIGlzIG5vdCBzdXBwb3J0ZWQgZm9yCj4gdGVzdCEiLCB0c3RfYXJjaC5uYW1lKTsKPgo+
IC0gICAgICAgaWYgKHRzdF90ZXN0LT5za2lwX2luX2xvY2tkb3duICYmIHRzdF9sb2NrZG93bl9l
bmFibGVkKCkpCj4gKyAgICAgICBpZiAodHN0X3Rlc3QtPnNraXBfaW5fbG9ja2Rvd24gJiYgdHN0
X2xvY2tkb3duX2VuYWJsZWQoKSA+IDApCj4gICAgICAgICAgICAgICAgIHRzdF9icmsoVENPTkYs
ICJLZXJuZWwgaXMgbG9ja2VkIGRvd24sIHNraXBwaW5nIHRlc3QiKTsKPgo+IC0gICAgICAgaWYg
KHRzdF90ZXN0LT5za2lwX2luX3NlY3VyZWJvb3QgJiYgdHN0X3NlY3VyZWJvb3RfZW5hYmxlZCgp
KQo+ICsgICAgICAgaWYgKHRzdF90ZXN0LT5za2lwX2luX3NlY3VyZWJvb3QgJiYgdHN0X3NlY3Vy
ZWJvb3RfZW5hYmxlZCgpID4gMCkKPiAgICAgICAgICAgICAgICAgdHN0X2JyayhUQ09ORiwgIlNl
Y3VyZUJvb3QgZW5hYmxlZCwgc2tpcHBpbmcgdGVzdCIpOwo+Cj4gICAgICAgICBpZiAodHN0X3Rl
c3QtPnNraXBfaW5fY29tcGF0ICYmIFRTVF9BQkkgIT0gdHN0X2tlcm5lbF9iaXRzKCkpCj4gLS0K
PiAyLjQxLjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
