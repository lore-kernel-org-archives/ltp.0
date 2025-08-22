Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FDCCA0EED
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 05:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755841409; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rShzz6rlLLzCW6A4WJSRjZiwpHOf3GLh95jVr0uKTVY=;
 b=LQrz0UZxEXZcMG1/cl93tL3S/iM3q+yhtDKrMNB7HxWG2PSnX9nWPl+Tm5yu7ZmHJN4s6
 8hEDBFpdxzPqZQjqBfZl8jlTx85ivaa82xr2BmvQ8UGcXGce8WoDYk9NzWXl+waN5ThIDI8
 KbcbXHCIbI/oGQSuGobXnUrVEe5vXLs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B85793C246E
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 07:43:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 305FF3C246E
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 07:43:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 691DE600198
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 07:43:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755841386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oeAYyWE20WNgV5UPBahbGG8wo1k8DI/OavicFuE6EF4=;
 b=TYbcriRa/aBGDehvxZeHloWISKawpR8xHnw+SnR8MnSpR4TjU9FMs63/0Cs4/Ife7Q2Rt7
 /tM6Q/SD0whlD2/HpPvPiBDqfv+K8grAaRJ594ZSsrBiPx/cWroSNgxgX85N+0pSLEu+/8
 h3tKr1BuETSkumro/EnyKs/ztOgQ8s8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-ukb-i-5lNryq7Wt6jSKbCQ-1; Fri, 22 Aug 2025 01:43:04 -0400
X-MC-Unique: ukb-i-5lNryq7Wt6jSKbCQ-1
X-Mimecast-MFC-AGG-ID: ukb-i-5lNryq7Wt6jSKbCQ_1755841383
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-246072fe091so21958235ad.2
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 22:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755841381; x=1756446181;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oeAYyWE20WNgV5UPBahbGG8wo1k8DI/OavicFuE6EF4=;
 b=u0YqelewdHUezmMaqe7qXOr3u4GpTWhorFPeZ0XgR7ErPc8bDNqtC1QXuNUIv2wVSv
 U+WEFttwTGXnfkNm2Y6Q8Tk1pKR58X0cT+i8wwuMUbZNTCSci6jqiztnmyvRVodoiEp/
 IwB75vUOFE55DlkhPXV79Fn8sMiUxSfWX9Lf8JrW0FaV2ABJ9tU4u5c0tCwMh8gsIG7U
 olB71VDrRHHY1QYPOwoFCyj2bUyP9DIUULytvXT7Os7wzJAOjQp3ksQEPAQohej/slQ2
 3ZQWE/ONpoU5iU+Woe3TJUrXMvznE6tNDLblZqXuM0IJfTymKN845Jr3CMqvT1c57TWS
 2Ujw==
X-Gm-Message-State: AOJu0Yx3tmeoRLbLmcBRkysfDjJlbT3yJfYQJJ5h3BiS1R6f0wKN4Dad
 4T3Agnd+vND92lrnLX8doDoKAVGW/O1KoAU2WFK+fZFFUd+dydRaP1KB6XojeDruR4rIaDWh7Aw
 k8E6cyAvoZEq3uFhIIS71YlgzKiFyd/aiqutBIPx4ExaEmF+Em4HoZjvuayd2apUY9VbOstlthy
 KQLBl2EalJ71xcsH1iuejLvE9v/qu73GuCY7pXXM3m
X-Gm-Gg: ASbGncvJmJc+CpPiettysBP9Rs6TBbpUWE4OVCrpGZJBvWyaiMJ9SXo/9LqtIp+SQm5
 pfjHaU2LtspD2L4FDUJ/x/TSow8qHduGyRPi1sqgUQ7IBMFwN5TSDVAIVqyTYS7fhSlbp8mhHmK
 vhgo2J8FhhzarEE72DFSTJxg==
X-Received: by 2002:a17:902:dad1:b0:240:8262:1a46 with SMTP id
 d9443c01a7336-2462ee54512mr26588275ad.25.1755841381383; 
 Thu, 21 Aug 2025 22:43:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKMCgTP+StErEIeaccNmHC1MNJqYR7oxb/I3fRaTHpItnyxzGfl7/uyL59CtDaTBjMrog8uE+ekm97pYfxKy4=
X-Received: by 2002:a17:902:dad1:b0:240:8262:1a46 with SMTP id
 d9443c01a7336-2462ee54512mr26588085ad.25.1755841380966; Thu, 21 Aug 2025
 22:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250822034215.28533-1-wegao@suse.com>
 <20250822040501.28640-1-wegao@suse.com>
 <20250822040501.28640-2-wegao@suse.com>
In-Reply-To: <20250822040501.28640-2-wegao@suse.com>
Date: Fri, 22 Aug 2025 13:42:47 +0800
X-Gm-Features: Ac12FXzMq5DRAboCEGfy99KuxdPJ5iYU2N-syHoBcwUXRKbXmu4C7NQLi6QKgWc
Message-ID: <CAEemH2eqs=hSEOUacymBQDSaPn2_c_Ek=sYTguezbo6uKBa9cg@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BvHO5SSs8dg9CkNFR7L7otJpoeFKR6V5ZsqrD34DP6I_1755841383
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/2] tst_device.c: Add tst_is_mounted_ro/w
 check mount option
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

T25jZSB3ZSBjcmVhdGVkIHRoZSBtb3JlIGdlbmVyaWMgZnVuY3Rpb24gdHN0X21vdW50X2hhc19v
cHQoKSwKdGhlIHRzdF9pc19tb3VudGVkKCkgY291bGQgYmUgc2ltcGx5IHJld3JpdHRlbiBpbjoK
CihXZS9JIGNhbiBkbyB0aGlzIGluIGEgc2VwYXJhdGUgcGF0Y2gpCgppbnQgdHN0X2lzX21vdW50
ZWQoY29uc3QgY2hhciAqcGF0aCkKewogICAgICAgIGludCByZXQgPSB0c3RfbW91bnRfaGFzX29w
dChwYXRoLCBOVUxMKTsKICAgICAgICBpZiAoIXJldCkKICAgICAgICAgICAgICAgIHRzdF9yZXNt
KFRJTkZPLCAiTm8gZGV2aWNlIGlzIG1vdW50ZWQgYXQgJXMiLCBwYXRoKTsKCiAgICAgICAgcmV0
dXJuIHJldDsKIH0KCgpPbiBGcmksIEF1ZyAyMiwgMjAyNSBhdCAxMjowNeKAr1BNIFdlaSBHYW8g
PHdlZ2FvQHN1c2UuY29tPiB3cm90ZToKCj4gU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9A
c3VzZS5jb20+Cj4gLS0tCj4gIGluY2x1ZGUvdHN0X2RldmljZS5oIHwgIDIgKysKPiAgbGliL3Rz
dF9kZXZpY2UuYyAgICAgfCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKPiAgMiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS90c3RfZGV2aWNlLmggYi9pbmNsdWRlL3RzdF9kZXZpY2UuaAo+IGluZGV4IDI1
OTdmYjRlMi4uM2VhN2I1NTAwIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdHN0X2RldmljZS5oCj4g
KysrIGIvaW5jbHVkZS90c3RfZGV2aWNlLmgKPiBAQCAtMzQsNiArMzQsOCBAQCBpbnQgdHN0X3Vt
b3VudChjb25zdCBjaGFyICpwYXRoKTsKPiAgICovCj4gIGludCB0c3RfaXNfbW91bnRlZChjb25z
dCBjaGFyICpwYXRoKTsKPiAgaW50IHRzdF9pc19tb3VudGVkX2F0X3RtcGRpcihjb25zdCBjaGFy
ICpwYXRoKTsKPiAraW50IHRzdF9pc19tb3VudGVkX3JvKGNvbnN0IGNoYXIgKnBhdGgpOwo+ICtp
bnQgdHN0X2lzX21vdW50ZWRfcncoY29uc3QgY2hhciAqcGF0aCk7Cj4KPiAgLyoKPiAgICogQ2xl
YXJzIGEgZmlyc3QgZmV3IGJsb2NrcyBvZiB0aGUgZGV2aWNlLiBUaGlzIGlzIG5lZWRlZCB3aGVu
IGRldmljZSBoYXMKPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF9kZXZpY2UuYyBiL2xpYi90c3RfZGV2
aWNlLmMKPiBpbmRleCA2ZDFhYmYwNjUuLjM0ZjI0YmU3ZCAxMDA2NDQKPiAtLS0gYS9saWIvdHN0
X2RldmljZS5jCj4gKysrIGIvbGliL3RzdF9kZXZpY2UuYwo+IEBAIC00NzMsNiArNDczLDQ4IEBA
IGludCB0c3RfaXNfbW91bnRlZF9hdF90bXBkaXIoY29uc3QgY2hhciAqcGF0aCkKPiAgICAgICAg
IHJldHVybiB0c3RfaXNfbW91bnRlZChtcGF0aCk7Cj4gIH0KPgo+ICtzdGF0aWMgaW50IHRzdF9t
b3VudF9oYXNfb3B0KGNvbnN0IGNoYXIgKnBhdGgsIGNvbnN0IGNoYXIgKm9wdCkKPiArewo+ICsg
ICAgICAgY2hhciBsaW5lW1BBVEhfTUFYXTsKPiArICAgICAgIEZJTEUgKmZpbGU7Cj4gKyAgICAg
ICBpbnQgcmV0ID0gMDsKPiArCj4gKyAgICAgICBmaWxlID0gU0FGRV9GT1BFTihOVUxMLCAiL3By
b2MvbW91bnRzIiwgInIiKTsKPiArCj4gKyAgICAgICB3aGlsZSAoZmdldHMobGluZSwgc2l6ZW9m
KGxpbmUpLCBmaWxlKSkgewo+ICsgICAgICAgICAgICAgICBjaGFyIG1vdW50X3BvaW50W1BBVEhf
TUFYXSwgb3B0aW9uc1tQQVRIX01BWF07Cj4gKwo+ICsgICAgICAgICAgICAgICBpZiAoc3NjYW5m
KGxpbmUsICIlKnMgJXMgJSpzICVzIiwgbW91bnRfcG9pbnQsIG9wdGlvbnMpIDwKPiAyKQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOwo+ICsKPiArICAgICAgICAgICAgICAgaWYg
KHN0cmNtcChtb3VudF9wb2ludCwgcGF0aCkgIT0gMCkKPiArICAgICAgICAgICAgICAgICAgICAg
ICBjb250aW51ZTsKPiArCj4gKyAgICAgICAgICAgICAgIGNoYXIgKnRvayA9IHN0cnRvayhvcHRp
b25zLCAiLCIpOwo+ICsgICAgICAgICAgICAgICB3aGlsZSAodG9rKSB7Cj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgaWYgKHN0cmNtcCh0b2ssIG9wdCkgPT0gMCkgewo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmV0ID0gMTsKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0KPiArICAgICAgICAgICAgICAg
ICAgICAgICB0b2sgPSBzdHJ0b2soTlVMTCwgIiwiKTsKPiArICAgICAgICAgICAgICAgfQo+ICsg
ICAgICAgICAgICAgICBpZiAocmV0KQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+
ICsgICAgICAgfQo+ICsKPiArICAgICAgIHJldHVybiByZXQ7Cj4gK30KPiArCj4gK2ludCB0c3Rf
aXNfbW91bnRlZF9ybyhjb25zdCBjaGFyICpwYXRoKQo+ICt7Cj4gKyAgICAgICByZXR1cm4gdHN0
X21vdW50X2hhc19vcHQocGF0aCwgInJvIik7Cj4gK30KPiArCj4gK2ludCB0c3RfaXNfbW91bnRl
ZF9ydyhjb25zdCBjaGFyICpwYXRoKQo+ICt7Cj4gKyAgICAgICByZXR1cm4gdHN0X21vdW50X2hh
c19vcHQocGF0aCwgInJ3Iik7Cj4gK30KPiArCj4gIHN0YXRpYyBpbnQgZmluZF9zdGF0X2ZpbGUo
Y29uc3QgY2hhciAqZGV2LCBjaGFyICpwYXRoLCBzaXplX3QgcGF0aF9sZW4pCj4gIHsKPiAgICAg
ICAgIGNvbnN0IGNoYXIgKmRldm5hbWUgPSBzdHJyY2hyKGRldiwgJy8nKSArIDE7Cj4gLS0KPiAy
LjQzLjAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
