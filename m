Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A9CC48BEB
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 03:39:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18F983D11BC
	for <ltp@archiver.kernel.org>; Thu, 22 Feb 2024 04:39:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 692133D018A
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 04:38:49 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 751841000BC3
 for <ltp@lists.linux.it>; Thu, 22 Feb 2024 04:38:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708573126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OpQYOS+GiOq0aCdUH1We8Z+HXIBzpqwLLkeeFJWGqk4=;
 b=Ql+VOIW4poiDnkRZ/WpkGy5sjgoZ9OvEDOPlp7DcDn94Drlqpkbr2/y7/UAUvTEo92dTMG
 vor7k2CQNhYedWjUTtiBvRwzipxWQB4qBFQid3DJ24CvaL5AM5ei6CZoXHd81bK4yKAFCQ
 4pP9OCmDKl9TyijLNRFeBVRCHgDGb/0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-611-s8pBeFDGM9Scgke8gLewAQ-1; Wed, 21 Feb 2024 22:38:45 -0500
X-MC-Unique: s8pBeFDGM9Scgke8gLewAQ-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5ce67a3f275so1152254a12.0
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 19:38:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708573122; x=1709177922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OpQYOS+GiOq0aCdUH1We8Z+HXIBzpqwLLkeeFJWGqk4=;
 b=WwI07/N7trKc11lyMel2aaD9UuWts0L1ey7sdKPvAbjX2QUSeVZwXoPOqdqffclt7v
 jjKusVYcYc9ALY16F9b99RkUsemtpUOh8QCKvZkRYFGeqWTqPUL0x73+esBFKtlSjsOB
 cf687e9CRRr3N1lsBb8qB8M1N77ERdE1Xeh8XSjtYbUfpn2jE0FFGv4/PbAcdo3bogvg
 MKWsZCP9O5qXVjvG/cm6C+2U2CSDWgTw8Sqbux8daJk3MRrk4gpnuxzJToA/h5mCstRs
 GOKnagvBj7FgFgCtvYtUbZg3+RfU1rK5CvuMq9+IhmfwEGPsIw4D+IqzUOZkk2/KF2LK
 FCtg==
X-Gm-Message-State: AOJu0YyRFaEUMW+IA48EwnXgRHvAXeqrRNzliVSP+ZmO+LJdRTm0txf1
 uBqpYT0L6wiVJ2PuYCU61klgXiSCin0TGh9oLZ9Yd3PjZqm3aa5UtUlU/7D5NZkkPXUFAUAiT6d
 4Eh8jh1s/iEC5+ze3wdT28LFTw3QtlEanl5/ko3JswdjgWAK+Kisq3C9NoQfQ9asfMVsqnESp0q
 F+Ib0l5JkW2nM74yQpQmpJPPklX5PHWWZ7IHQ5
X-Received: by 2002:a05:6a21:1507:b0:19e:b15c:c8d0 with SMTP id
 nq7-20020a056a21150700b0019eb15cc8d0mr21146381pzb.18.1708573122686; 
 Wed, 21 Feb 2024 19:38:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4tQI/c/yEt2K6/Ot7jx5o+v35EESpqnyZrSx9CVvs8airU+vl8SpR/WSdk/cg1+bThTBW5OQXG+GwVEB7Yik=
X-Received: by 2002:a05:6a21:1507:b0:19e:b15c:c8d0 with SMTP id
 nq7-20020a056a21150700b0019eb15cc8d0mr21146371pzb.18.1708573122434; Wed, 21
 Feb 2024 19:38:42 -0800 (PST)
MIME-Version: 1.0
References: <20240220091328.2946023-1-liwang@redhat.com>
 <20240221162754.GA1270838@pevik>
In-Reply-To: <20240221162754.GA1270838@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 22 Feb 2024 11:38:30 +0800
Message-ID: <CAEemH2cZgLJMp6nZLC2LA4-X-jBwVThY1fKRODdmGMSieeHJrw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] move_pages12: compacting memory before each test
 loop
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

SGkgUGV0ciwKCk9uIFRodSwgRmViIDIyLCAyMDI0IGF0IDEyOjI44oCvQU0gUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiBIaSBMaSwKPgo+ID4gVGhlc2Ugc2ltcGxlIHN0ZXBz
IGFyZSBhZGRlZCB0byBwcmVwYXJlIHRoZSBzeXN0ZW0ncyBtZW1vcnkgc3RhdGUKPiA+IGZvciB0
aGUgdGVzdCwgYWltaW5nIHRvIGluY3JlYXNlIHRoZSB0ZXN0J3MgcmVsaWFiaWxpdHkgYW5kCj4g
PiBjb25zaXN0ZW5jeSBieSBzdGFydGluZyBmcm9tIGEgY2xlYW4gYW5kIGRlZnJhZ21lbnRlZCBt
ZW1vcnkgc3RhdGUuCj4KPiA+IFRvIHJlZHVjZSBhY2NpZGVudGFsIGZhaWx1cmVzIG9uIHNtYWxs
ICgxLjVHKSBSQU0gc3lzdGVtOgo+Cj4gPiAgIDcgdHN0X3Rlc3QuYzoxNTU4OiBUSU5GTzogVGlt
ZW91dCBwZXIgcnVuIGlzIDBoIDIxbSAwMHMKPiA+ICAgOCBtb3ZlX3BhZ2VzMTIuYzoyNzM6IFRJ
TkZPOiBGcmVlIFJBTSAxNTQyNjU2IGtCCj4gPiAgIDkgbW92ZV9wYWdlczEyLmM6Mjg5OiBUSU5G
TzogSW5jcmVhc2luZyAxNjM4NGtCIGh1Z2VwYWdlcyBwb29sIG9uIG5vZGUKPiAwIHRvIDQKPiA+
ICAgMTAgbW92ZV9wYWdlczEyLmM6Mjk5OiBUSU5GTzogSW5jcmVhc2luZyAxNjM4NGtCIGh1Z2Vw
YWdlcyBwb29sIG9uCj4gbm9kZSAxIHRvIDQKPiA+ICAgMTEgbW92ZV9wYWdlczEyLmM6MjE2OiBU
SU5GTzogQWxsb2NhdGluZyBhbmQgZnJlZWluZyA0IGh1Z2VwYWdlcyBvbgo+IG5vZGUgMAo+ID4g
ICAxMiBtb3ZlX3BhZ2VzMTIuYzoyMTY6IFRJTkZPOiBBbGxvY2F0aW5nIGFuZCBmcmVlaW5nIDQg
aHVnZXBhZ2VzIG9uCj4gbm9kZSAxCj4gPiAgIDEzIG1vdmVfcGFnZXMxMi5jOjIwNzogVFBBU1M6
IEJ1ZyBub3QgcmVwcm9kdWNlZAo+ID4gICAxNCBtb3ZlX3BhZ2VzMTIuYzoxMDY6IFRGQUlMOiBt
YWR2aXNlIGZhaWxlZDogRU5PTUVNICgxMikKPiA+ICAgLi4uPHJlcGVhdHMgNzQxIHRpbWVzPi4u
Lgo+ID4gICA3NTYgbW92ZV9wYWdlczEyLmM6MjA3OiBUUEFTUzogQnVnIG5vdCByZXByb2R1Y2Vk
Cj4KPiA+IE5vdGU6Cj4gPiAgIFRoaXMgaXMgYSBzaW5nbGUgaHVnZXRsYiB0ZXN0IHdpdGhvdXQg
aW52b2tpbmcgdGhlIGh1Z2V0bGItbGliIG9mIExUUCwKPiA+ICAgc28gd2UgYWRkIHRoZSBjb21w
YWN0aW5nIG1lbW9yeS9jYWNoZSBzdGVwcyBhZGRpdGlvbmFsbHkuCj4KPiA+IFNpZ25lZC1vZmYt
Ynk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9tb3ZlX3BhZ2VzL21vdmVfcGFnZXMxMi5jIHwgMyArKysKPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4KPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL21vdmVfcGFnZXMvbW92ZV9wYWdlczEyLmMKPiBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvbW92ZV9wYWdlcy9tb3ZlX3BhZ2VzMTIuYwo+ID4gaW5kZXggZmQ3MDE3
ZDc5Li5jMzg3YTMyNmYgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L21vdmVfcGFnZXMvbW92ZV9wYWdlczEyLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbW92ZV9wYWdlcy9tb3ZlX3BhZ2VzMTIuYwo+ID4gQEAgLTE1NCw2ICsxNTQsOSBAQCBz
dGF0aWMgdm9pZCBkb190ZXN0KHVuc2lnbmVkIGludCBuKQo+ID4gICAgICAgcGlkX3QgY3BpZCA9
IC0xOwo+ID4gICAgICAgaW50IHN0YXR1czsKPgo+ID4gKyAgICAgU0FGRV9GSUxFX1BSSU5URigi
L3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzIiwgIjMiKTsKPiA+ICsgICAgIFNBRkVfRklMRV9QUklO
VEYoIi9wcm9jL3N5cy92bS9jb21wYWN0X21lbW9yeSIsICIxIik7Cj4KPiBMR1RNCj4gUmV2aWV3
ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+Cj4gQlRXIHdlIGNsZWFyIGNhY2hl
IHdpdGggL3Byb2Mvc3lzL3ZtL2Ryb3BfY2FjaGVzIGluIHF1aXRlIGEgZmV3IGZpbGVzLAo+IEkg
d29uZGVyIGlmIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gYWRkIGEgaGVscGVyIGZvciBpdC4gTGlr
ZWx5IG5vdAo+IChpdCdzIG9uZWxpbmVyKS4KPgoKSG1tIHllcywgbWF5YmUgYmV0dGVyIHB1dCB0
aGUgZHJvcCBjYWNoZXMgaW4gdGhlIHNldHVwIGZ1bmN0aW9uLAphdCBsZWFzdCByZWxlYXNlIG1v
cmUgZnJlZS1tZW0gZm9yIGNvbXBhcmlzb24uCgoKIyBmcmVlIC1oCiAgICAgICAgICAgICAgIHRv
dGFsICAgICAgICB1c2VkICAgICAgICBmcmVlICAgICAgc2hhcmVkICBidWZmL2NhY2hlCmF2YWls
YWJsZQpNZW06ICAgICAgICAgICAgMTVHaSAgICAgICA1LjFHaSAgICAgICAyLjNHaSAgICAgICAg
MTdNaSAgICAgICA4LjFHaQogMTBHaQpTd2FwOiAgICAgICAgICAgMTFHaSAgICAgICAyLjFHaSAg
ICAgICA5LjlHaQoKIyBlY2hvIDMgPi9wcm9jL3N5cy92bS9kcm9wX2NhY2hlcwoKIyBmcmVlIC1o
CiAgICAgICAgICAgICAgIHRvdGFsICAgICAgICB1c2VkICAgICAgICBmcmVlICAgICAgc2hhcmVk
ICBidWZmL2NhY2hlCmF2YWlsYWJsZQpNZW06ICAgICAgICAgICAgMTVHaSAgICAgICA0LjlHaSAg
ICAgICAgMTBHaSAgICAgICAgMTdNaSAgICAgICAzNTFNaQogMTBHaQpTd2FwOiAgICAgICAgICAg
MTFHaSAgICAgICAyLjFHaSAgICAgICA5LjlHaQoKCgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIK
Pgo+ID4gKwo+ID4gICAgICAgYWRkciA9IFNBRkVfTU1BUChOVUxMLCB0Y2FzZXNbbl0udHBhZ2Vz
ICogaHBzeiwgUFJPVF9SRUFEIHwKPiBQUk9UX1dSSVRFLAo+ID4gICAgICAgICAgICAgICBNQVBf
UFJJVkFURSB8IE1BUF9BTk9OWU1PVVMgfCBNQVBfSFVHRVRMQiwgLTEsIDApOwo+Cj4KUHVzaGVk
IHdpdGggbWlub3IgYWRqdXN0bWVudHMgaW4gdGhlIG9yZGVyLgoKCi0tIApSZWdhcmRzLApMaSBX
YW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
