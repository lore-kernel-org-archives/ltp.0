Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52EDC30653
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 06:57:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 011FC3D3CDC
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 08:57:27 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDC323D3CB7
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 08:57:12 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E9E76140165B
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 08:57:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720076229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7/O56XxS/ylXegvUk8oiMcYz1C1YPpRrxLfg/zDJZOU=;
 b=CQlj4m4lym8Yltgp8n0TXiGOkuCmXyplc+LdgLU2levE0sftxE+/vPUZWJN+xd1S8+UJH/
 TIeS3zzS37JRKbe4zSTP08mO4Y2RMqi8NrSqOT/jEe/9H7DTuxp0H2DY0RIpeBCKI9f59E
 q/3IlO7NBXWn51wc258mOgl9broTzFU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-vYgVclGsOcKUvKEaOyi1RA-1; Thu, 04 Jul 2024 02:57:07 -0400
X-MC-Unique: vYgVclGsOcKUvKEaOyi1RA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c96e73c888so388838a91.3
 for <ltp@lists.linux.it>; Wed, 03 Jul 2024 23:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720076225; x=1720681025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7/O56XxS/ylXegvUk8oiMcYz1C1YPpRrxLfg/zDJZOU=;
 b=sCdsnFcdzLkVWmAlLy9QEBptQxuQogQt8lFoQdinjibTPuVUNsBWdn1mhhBFSomyfy
 Y3e/Ebc/1eIJ5QeiVBylwt/ecDD7CYcmzehmssXGr03T7mtitfgYwJKo/vts2vT7X4p8
 Dml4eVB4tujqpcZB9tmkdEqiWHUZMsMtoHBYUJ88UJm2pVQH6cNd9OWW87l0JxQZWBcw
 yWDQRQ4e9vc81w5yL18E4IPXpd+vlZ4OyowQ6x7ja5cMcij+tJrmtW5V+DiUh3u5LDyz
 6yGoIWf6s83bEO4P7su6kjxoozFLgZxZFgoNlUuLkTvV2D1fCFX5ShvkIN0qRFwFgNvf
 ADKQ==
X-Gm-Message-State: AOJu0Yxg1ncVbQakkNrfUX+lScP6Kh2Whd8OJ3K0j1Tyvswucuj8hRD/
 yMSbqV08EufkWKD1qJPUAMubBoN70pI0yh9rOKjXDptkFsaENWqy63zxJGTjha1LY2tMLKbcFhD
 0/ZLQfyvZ54nv+dW86pmVzwWpFC+8lJvhrRr+IEq7SXOQ+wubyyriUAPFE0vO7wJ29VABnfKs14
 sNK9UmepdYnkQt9ErxKj8/yR45p1aLPDBXwKgy
X-Received: by 2002:a17:90a:5608:b0:2c9:8d45:7bdd with SMTP id
 98e67ed59e1d1-2c99c50faa7mr605737a91.10.1720076224970; 
 Wed, 03 Jul 2024 23:57:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/jl9KGE3PDzSVfGiiPlk17FcxGJ7/LpW9qswPkf7dfLvQIVD/pkHkQvNj18Ny/kwnz0a+nc4xE2xo2sCHksY=
X-Received: by 2002:a17:90a:5608:b0:2c9:8d45:7bdd with SMTP id
 98e67ed59e1d1-2c99c50faa7mr605725a91.10.1720076224409; Wed, 03 Jul 2024
 23:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240702-stat04-v1-0-e27d9953210d@suse.com>
 <20240702-stat04-v1-3-e27d9953210d@suse.com>
 <CAEemH2fM_X=VYUpkv3vrrjsWTW5KQvEerjBGggwESy=9xqHC4A@mail.gmail.com>
In-Reply-To: <CAEemH2fM_X=VYUpkv3vrrjsWTW5KQvEerjBGggwESy=9xqHC4A@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jul 2024 14:56:52 +0800
Message-ID: <CAEemH2f9NqGEwh98tm8T7cek9Y24vcpbzkDDKEKrtLuPQFyfVg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 3/5] Add lstat03 test
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

T24gVGh1LCBKdWwgNCwgMjAyNCBhdCAyOjM24oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgoKPgo+Cj4gT24gVHVlLCBKdWwgMiwgMjAyNCBhdCAxMDoxNeKAr1BNIEFuZHJl
YSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5kZT4KPiB3cm90ZToKPgo+PiBGcm9t
OiBBbmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+Pgo+PiBUaGlz
IHRlc3QgaGFzIGJlZW4gZXh0cmFjdGVkIGZyb20gc3ltbGluazAxIHRlc3QgYW5kIGl0IGNoZWNr
cyB0aGF0Cj4+IGxzdGF0KCkgcHJvdmlkZXMgdGhlIHJpZ2h0IGluZm9ybWF0aW9uLCBhY2NvcmRp
bmcgd2l0aCBkZXZpY2UsIGFjY2Vzcwo+PiB0aW1lLCBibG9jayBzaXplLCBvd25lcnNoaXAsIGV0
Yy4KPj4KPj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0
b0BzdXNlLmNvbT4KPj4gLS0tCj4+ICBydW50ZXN0L3N5c2NhbGxzICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDQgKy0KPj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbHN0YXQvLmdp
dGlnbm9yZSB8ICAgMiArCj4+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xzdGF0L2xzdGF0
MDMuYyAgfCAxMDIKPj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4gIDMgZmlsZXMg
Y2hhbmdlZCwgMTA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1n
aXQgYS9ydW50ZXN0L3N5c2NhbGxzIGIvcnVudGVzdC9zeXNjYWxscwo+PiBpbmRleCAzZTdhNWNh
MWIuLmQ3OGI2ODIyYiAxMDA2NDQKPj4gLS0tIGEvcnVudGVzdC9zeXNjYWxscwo+PiArKysgYi9y
dW50ZXN0L3N5c2NhbGxzCj4+IEBAIC03MjUsMTIgKzcyNSwxMiBAQCBsc2VlazAyIGxzZWVrMDIK
Pj4gIGxzZWVrMDcgbHNlZWswNwo+PiAgbHNlZWsxMSBsc2VlazExCj4+Cj4+IC1sc3RhdDAxQSBz
eW1saW5rMDEgLVQgbHN0YXQwMQo+PiAtbHN0YXQwMUFfNjQgc3ltbGluazAxIC1UIGxzdGF0MDFf
NjQKPj4gIGxzdGF0MDEgbHN0YXQwMQo+PiAgbHN0YXQwMV82NCBsc3RhdDAxXzY0Cj4+ICBsc3Rh
dDAyIGxzdGF0MDIKPj4gIGxzdGF0MDJfNjQgbHN0YXQwMl82NAo+PiArbHN0YXQwMyBsc3RhdDAz
Cj4+ICtsc3RhdDAzXzY0IGxzdGF0MDNfNjQKPj4KPj4gIG1hbGxpbmZvMDIgbWFsbGluZm8wMgo+
Pgo+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sc3RhdC8uZ2l0aWdu
b3JlCj4+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sc3RhdC8uZ2l0aWdub3JlCj4+IGlu
ZGV4IGE0OTdhNDQ1Zi4uNzJjYmE4NzFmIDEwMDY0NAo+PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2xzdGF0Ly5naXRpZ25vcmUKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9sc3RhdC8uZ2l0aWdub3JlCj4+IEBAIC0yLDMgKzIsNSBAQAo+PiAgL2xzdGF0MDFfNjQK
Pj4gIC9sc3RhdDAyCj4+ICAvbHN0YXQwMl82NAo+PiArL2xzdGF0MDMKPj4gKy9sc3RhdDAzXzY0
Cj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xzdGF0L2xzdGF0MDMu
Ywo+PiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbHN0YXQvbHN0YXQwMy5jCj4+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4IDAwMDAwMDAwMC4uYjUyYmEwYzM1Cj4+IC0tLSAvZGV2
L251bGwKPj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sc3RhdC9sc3RhdDAzLmMK
Pj4gQEAgLTAsMCArMSwxMDIgQEAKPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwt
Mi4wLW9yLWxhdGVyCj4+ICsvKgo+PiArICogQ29weXJpZ2h0IChjKSAyMDAwIFNpbGljb24gR3Jh
cGhpY3MsIEluYy4gIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCj4+ICsgKiAgICBBdXRob3I6IERhdmlk
IEZlbm5lciwgSm9uIEhlbmRyaWNrc29uCj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgQW5kcmVh
IENlcnZlc2F0byBhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCj4+ICsgKi8KPj4gKwo+PiArLypc
Cj4+ICsgKiBbRGVzY3JpcHRpb25dCj4+ICsgKgo+PiArICogVGhpcyB0ZXN0IHZlcmlmaWVzIHRo
YXQgbHN0YXQoKSBwcm92aWRlcyBjb3JyZWN0IGluZm9ybWF0aW9uIGFjY29yZGluZwo+PiArICog
d2l0aCBkZXZpY2UsIGFjY2VzcyB0aW1lLCBibG9jayBzaXplLCBvd25lcnNoaXAsIGV0Yy4KPj4g
KyAqIFRoZSBpbXBsZW1lbnRhdGlvbiBwcm92aWRlcyBhIHNldCBvZiB0ZXN0cyB3aGljaCBhcmUg
c3BlY2lmaWMgZm9yCj4+IGVhY2ggb25lCj4+ICsgKiBvZiB0aGUgYHN0cnVjdCBzdGF0YCB1c2Vk
IHRvIHJlYWQgZmlsZSBhbmQgc3ltbGluayBpbmZvcm1hdGlvbi4KPj4gKyAqLwo+PiArCj4+ICsj
aW5jbHVkZSAidHN0X3Rlc3QuaCIKPj4gKwo+PiArI2RlZmluZSBGSUxFTkFNRSAiZmlsZS50eHQi
Cj4+ICsjZGVmaW5lIE1OVFBPSU5UICJtbnRwb2ludCIKPj4gKyNkZWZpbmUgU1lNQk5BTUUgTU5U
UE9JTlQiL2ZpbGVfc3ltbGluayIKPj4gKwo+PiArc3RhdGljIHN0cnVjdCBzdGF0ICpmaWxlX3N0
YXQ7Cj4+ICtzdGF0aWMgc3RydWN0IHN0YXQgKnN5bWJfc3RhdDsKPj4gKwo+PiArc3RhdGljIHZv
aWQgcnVuKHZvaWQpCj4+ICt7Cj4+ICsgICAgICAgVFNUX0VYUF9FWFBSKGZpbGVfc3RhdC0+c3Rf
ZGV2ICE9IHN5bWJfc3RhdC0+c3RfZGV2KTsKPj4gKyAgICAgICBUU1RfRVhQX0VYUFIoZmlsZV9z
dGF0LT5zdF9tb2RlICE9IHN5bWJfc3RhdC0+c3RfbW9kZSk7Cj4+ICsgICAgICAgVFNUX0VYUF9F
WFBSKGZpbGVfc3RhdC0+c3RfbmxpbmsgIT0gc3ltYl9zdGF0LT5zdF9ubGluayk7Cj4+ICsgICAg
ICAgVFNUX0VYUF9FWFBSKGZpbGVfc3RhdC0+c3RfaW5vICE9IHN5bWJfc3RhdC0+c3RfaW5vKTsK
Pj4gKyAgICAgICBUU1RfRVhQX0VYUFIoZmlsZV9zdGF0LT5zdF91aWQgIT0gc3ltYl9zdGF0LT5z
dF91aWQpOwo+PiArICAgICAgIFRTVF9FWFBfRVhQUihmaWxlX3N0YXQtPnN0X2dpZCAhPSBzeW1i
X3N0YXQtPnN0X2dpZCk7Cj4+ICsgICAgICAgVFNUX0VYUF9FWFBSKGZpbGVfc3RhdC0+c3Rfc2l6
ZSAhPSBzeW1iX3N0YXQtPnN0X3NpemUpOwo+PiArICAgICAgIFRTVF9FWFBfRVhQUihmaWxlX3N0
YXQtPnN0X2Jsb2NrcyAhPSBzeW1iX3N0YXQtPnN0X2Jsb2Nrcyk7Cj4+ICsgICAgICAgVFNUX0VY
UF9FWFBSKGZpbGVfc3RhdC0+c3RfYmxrc2l6ZSAhPSBzeW1iX3N0YXQtPnN0X2Jsa3NpemUpOwo+
PiArICAgICAgIFRTVF9FWFBfRVhQUihmaWxlX3N0YXQtPnN0X2F0aW1lICE9IHN5bWJfc3RhdC0+
c3RfYXRpbWUpOwo+PiArICAgICAgIFRTVF9FWFBfRVhQUihmaWxlX3N0YXQtPnN0X210aW1lICE9
IHN5bWJfc3RhdC0+c3RfbXRpbWUpOwo+PiArICAgICAgIFRTVF9FWFBfRVhQUihmaWxlX3N0YXQt
PnN0X2N0aW1lICE9IHN5bWJfc3RhdC0+c3RfY3RpbWUpOwo+PiArfQo+PiArCj4+ICtzdGF0aWMg
dm9pZCBzZXR1cCh2b2lkKQo+PiArewo+PiArICAgICAgIGNoYXIgb3B0X2JzaXplWzMyXTsKPj4g
KyAgICAgICBjb25zdCBjaGFyICpjb25zdCBmc19vcHRzW10gPSB7b3B0X2JzaXplLCBOVUxMfTsK
Pj4gKyAgICAgICBzdHJ1Y3Qgc3RhdCBzYjsKPj4gKyAgICAgICBpbnQgcGFnZXNpemU7Cj4+ICsg
ICAgICAgaW50IGZkOwo+PiArCj4+ICsgICAgICAgLyogY2hhbmdlIHN0X2Jsa3NpemUgLyBzdF9k
ZXYgKi8KPj4gKyAgICAgICBTQUZFX1NUQVQoIi4iLCAmc2IpOwo+PiArICAgICAgIHBhZ2VzaXpl
ID0gc2Iuc3RfYmxrc2l6ZSA9PSA0MDk2ID8gMTAyNCA6IDQwOTY7Cj4+ICsKPj4gKyAgICAgICBz
bnByaW50ZihvcHRfYnNpemUsIHNpemVvZihvcHRfYnNpemUpLCAiLWIgJWkiLCBwYWdlc2l6ZSk7
Cj4+ICsgICAgICAgU0FGRV9NS0ZTKHRzdF9kZXZpY2UtPmRldiwgdHN0X2RldmljZS0+ZnNfdHlw
ZSwgZnNfb3B0cywgTlVMTCk7Cj4+ICsgICAgICAgU0FGRV9NT1VOVCh0c3RfZGV2aWNlLT5kZXYs
IE1OVFBPSU5ULCB0c3RfZGV2aWNlLT5mc190eXBlLCAwLCAwKTsKPj4gKwo+PiArICAgICAgIFNB
RkVfVE9VQ0goRklMRU5BTUUsIDA3NzcsIE5VTEwpOwo+PiArCj4+ICsgICAgICAgLyogY2hhbmdl
IHN0X25saW5rICovCj4+ICsgICAgICAgU0FGRV9MSU5LKEZJTEVOQU1FLCAibGlua2VkX2ZpbGUi
KTsKPj4gKwo+PiArICAgICAgIC8qIGNoYW5nZSBzdF91aWQgYW5kIHN0X2dpZCAqLwo+PiArICAg
ICAgIFNBRkVfQ0hPV04oRklMRU5BTUUsIDEwMDAsIDEwMDApOwo+PiArCj4+ICsgICAgICAgLyog
Y2hhbmdlIHN0X3NpemUgKi8KPj4gKyAgICAgICBmZCA9IFNBRkVfT1BFTihGSUxFTkFNRSwgT19X
Uk9OTFksIDA3NzcpOwo+PiArICAgICAgIHRzdF9maWxsX2ZkKGZkLCAnYScsIFRTVF9LQiwgNTAw
KTsKPj4gKyAgICAgICBTQUZFX0NMT1NFKGZkKTsKPj4gKwo+PiArICAgICAgIC8qIGNoYW5nZSBz
dF9hdGltZSAvIHN0X210aW1lIC8gc3RfY3RpbWUgKi8KPj4gKyAgICAgICBzbGVlcCgxKTsKPj4K
PgpBbmQsIEkgd291bGQgc3VnZ2VzdCB1c2luZyB1c2xlZXAoMTAwMTAwMCkgaW5zdGVhZCBvZiAx
c2VjIGVzcGVjaWFsCmZvciBzdWNoIGF0aW1lIGNoZWNraW5nIHRlc3QuCgpUbyBhdm9pZCBwcm9i
bGVtIGxpa2U6Cmh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2NvbW1p
dC9mZjYwMTU2YmMwMmYyNTVmYTA4OTM0Yjk1MjIzZTI5YTY2MzdlYjZhCgoKCj4gKwo+PiArICAg
ICAgIFNBRkVfU1lNTElOSyhGSUxFTkFNRSwgU1lNQk5BTUUpOwo+PiArCj4+Cj4KPgo+Cj4+ICsg
ICAgICAgU0FGRV9MU1RBVChGSUxFTkFNRSwgZmlsZV9zdGF0KTsKPj4gKyAgICAgICBTQUZFX0xT
VEFUKFNZTUJOQU1FLCBzeW1iX3N0YXQpOwo+Pgo+Cj4gTWF5YmUgaXQgd291bGQgYmUgYmV0dGVy
IHRvIG1vdmUgdGhvc2UgdHdvIGxpbmVzIGludG8gcnVuKCkgZnVuY3Rpb24uCj4gSXQgbWFrZXMg
dGhlIHRlc3QgcmVhbCBwZXJmb3JtZWQgYWdhaW4gd2hlbiB1c2luZyAnLWkgMicgcGFyYW1ldGVy
Lgo+Cj4KPgo+PiArfQo+PiArCj4+ICtzdGF0aWMgdm9pZCBjbGVhbnVwKHZvaWQpCj4+ICt7Cj4+
ICsgICAgICAgU0FGRV9VTkxJTksoU1lNQk5BTUUpOwo+PiArCj4+ICsgICAgICAgaWYgKHRzdF9p
c19tb3VudGVkKE1OVFBPSU5UKSkKPj4gKyAgICAgICAgICAgICAgIFNBRkVfVU1PVU5UKE1OVFBP
SU5UKTsKPj4gK30KPj4gKwo+PiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+PiAr
ICAgICAgIC5zZXR1cCA9IHNldHVwLAo+PiArICAgICAgIC5jbGVhbnVwID0gY2xlYW51cCwKPj4g
KyAgICAgICAudGVzdF9hbGwgPSBydW4sCj4+ICsgICAgICAgLm5lZWRzX3Jvb3QgPSAxLAo+PiAr
ICAgICAgIC5uZWVkc190bXBkaXIgPSAxLAo+PiArICAgICAgIC5uZWVkc19kZXZpY2UgPSAxLAo+
PiArICAgICAgIC5tbnRwb2ludCA9IE1OVFBPSU5ULAo+PiArICAgICAgIC5kZXZfZnNfdHlwZSA9
ICJleHQyIiwKPj4gKyAgICAgICAuYnVmcyA9IChzdHJ1Y3QgdHN0X2J1ZmZlcnMgW10pIHsKPj4g
KyAgICAgICAgICAgICAgIHsmZmlsZV9zdGF0LCAuc2l6ZSA9IHNpemVvZihzdHJ1Y3Qgc3RhdCl9
LAo+PiArICAgICAgICAgICAgICAgeyZzeW1iX3N0YXQsIC5zaXplID0gc2l6ZW9mKHN0cnVjdCBz
dGF0KX0sCj4+ICsgICAgICAgICAgICAgICB7fQo+PiArICAgICAgIH0KPj4gK307Cj4+Cj4+IC0t
Cj4+IDIuNDMuMAo+Pgo+Pgo+PiAtLQo+PiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAKPj4KPj4KPgo+IC0tCj4gUmVnYXJkcywKPiBMaSBXYW5n
Cj4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
