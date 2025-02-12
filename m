Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05854C0219B
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 01:45:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CB3C3C99CC
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 02:45:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87DC93C010E
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 02:45:11 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 32A4A140FBB2
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 02:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739324708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x2hNBlcILxTfvdvgTRcWzu4zjEKw5+Wmo6ndXU23nEg=;
 b=PR19M+4QX2O8TRp+kwy/PSB8Sf2sLySLp6Xb+8CSs6QsUJz/MjW7aosbz3IoOgt57Ooy7u
 kgd8rKiKJd03GHorKSbQLsir5r9LN6dgmFZLG58hnR9PI1ear1LnzezWWtgR75odouB0uW
 oKrfcjTGfeavkjpiFEerWVSLr/t9KcM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-SRVAswA-PfSg7buj6V9Wag-1; Tue, 11 Feb 2025 20:45:06 -0500
X-MC-Unique: SRVAswA-PfSg7buj6V9Wag-1
X-Mimecast-MFC-AGG-ID: SRVAswA-PfSg7buj6V9Wag
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab7bb1b91fdso231608366b.1
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 17:45:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739324705; x=1739929505;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x2hNBlcILxTfvdvgTRcWzu4zjEKw5+Wmo6ndXU23nEg=;
 b=ujDTbCkVh3ADBxcjpOhBmVCH29+HwgdpUOatjIFJp5B6luEh+0qeYLzmD2ND4NZvR1
 Mue9TPKPQzj+KyWyDguipHExO5TySKKZ5OglTuhmP6XSieJwePr9kwgeK8j6yQ4TbZSe
 taoWpbqdxXyCCVKLpd1564r7DB+vzMIrCNENANcW1/r0ycqJ5HaGuHe19AT7tz/v+TUc
 w7KVRyRjlOTdfqxfsA3tgJtrkVo27f7NNszbWvBuxIKhDcIjrwsn3lw4cIyKpnTazppD
 SBzl2wxXBwbqetgclxYrapstQYsvv4QnQeJQ2I4Qf+AsnkhwTiDJpbPIz5UFHZsduEV+
 9P9w==
X-Gm-Message-State: AOJu0Yy8fJGUqziRTbUq4sINqV0ctZACcKFk5SmremeeXlPCOSH1Spxn
 xkWooqb5ZaPI+3P4WtIjjlU5YWMY4vDCff6wQCD5+9lgK9JXncWBfatcQKteZSggDjP3wh2b4i3
 tfHexGBjoVGLf14pUzEVwPmeD+bQ4UJqjmDUokE4SssW23MlFZ0fcpQccWk9aDtQPk6An8RBq2n
 yR0oJa4YN9pi8ljocwNbQoKvU=
X-Gm-Gg: ASbGncv/EviIbaimi4vu1Fy631Y94CqLwxxWJVjh0A3B8AW+dfDKHD/uhegrf747ADq
 zr/HpNKe6d4KEJU7QSIcla4QUG0n1nhUDRHmNclBy5Tnw7PFGXjkRQ96B5k8nzqo=
X-Received: by 2002:a17:907:971c:b0:ab7:851d:4718 with SMTP id
 a640c23a62f3a-ab7f34aec59mr99484466b.36.1739324705070; 
 Tue, 11 Feb 2025 17:45:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE0j63FjPxdvs3B15k5wIdFNCVcud7IdM/KsPZDL2c+nUsCshHcH+SQItup3uizXPhMQFtAC0Pp2/e1vbNzlA=
X-Received: by 2002:a17:907:971c:b0:ab7:851d:4718 with SMTP id
 a640c23a62f3a-ab7f34aec59mr99482966b.36.1739324704578; Tue, 11 Feb 2025
 17:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20250211032457.7396-1-liwang@redhat.com>
 <20250211172019.GA1906142@pevik>
 <Z6v0Z486y3h4IvKC@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
In-Reply-To: <Z6v0Z486y3h4IvKC@dell-per750-06-vm-07.rhts.eng.pek2.redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 12 Feb 2025 09:44:44 +0800
X-Gm-Features: AWEUYZm8u6Mfq3ewvgpjNNg9k-YOv0JqDz0nm8c21r87ralS6d60Vgza7uVlWrE
Message-ID: <CAEemH2c6qa8BGOoqPyXn7J9fTXnbY8CK6N8=mW+a3qEp5P_pxg@mail.gmail.com>
To: Yongcheng Yang <yoyang@redhat.com>, Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: krpHXfzQTB9D7ARI2zO2b3eb4QaZ3wn1WRtKb3XQx64_1739324705
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] statx07: Skip test if NFS server is never enabled
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
Cc: smayhew@redhat.com, Martin Doucha <martin.doucha@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBGZWIgMTIsIDIwMjUgYXQgOTowOOKAr0FNIFlvbmdjaGVuZyBZYW5nIDx5b3lhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cgo+IEhpIFBldHIsCj4KPiBPbiBUdWUsIEZlYiAxMSwgMjAyNSBh
dCAwNjoyMDoxOVBNICswMTAwLCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4gSGkgTGksIGFsbCwKPiA+
Cj4gPiA+IFRoZSBzdGF0eDA3IHRlc3QgcmVxdWlyZXMgYW4gYWN0aXZlIE5GUyBzZXJ2ZXIsIGFz
IGl0IHJlbGllcyBvbgo+ID4gPiBleHBvcnRmcywgd2hpY2ggcmVhZHMgZnJvbSAnL3Zhci9saWIv
bmZzL2V0YWInLiBCeSBkZWZhdWx0LCBldGFiCj4gPiA+IGZpbGUgZG9lcyBub3QgZXhpc3QgdW5s
ZXNzIHRoZSBORlMgc2VydmVyIGlzIHN0YXJ0ZWQgYXQgbGVhc3Qgb25jZQo+ID4gPiAoc2luY2Ug
bmV3IHZlcnNpb24gbmZzLXV0aWxzLTIuNS40LTMyLmVsOSkuCj4gPgo+ID4gPiBUaGlzIGNhdXNp
bmcgdGhlIHRlc3QgdG8gZmFpbCB3aGVuIGV0YWIgaXMgbWlzc2luZzoKPiA+Cj4gPiA+ICAgdHN0
X3Rlc3QuYzoxNzIyOiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDBtIDMw
cwo+ID4gPiAgIHRzdF9idWZmZXJzLmM6NTc6IFRJTkZPOiBUZXN0IGlzIHVzaW5nIGd1YXJkZWQg
YnVmZmVycwo+ID4gPiAgIGV4cG9ydGZzOiBjYW4ndCBvcGVuIC92YXIvbGliL25mcy9ldGFiIGZv
ciByZWFkaW5nCj4gPiA+ICAgc3RhdHgwNy5jOjEzNjogVEJST0s6IGZhaWxlZCB0byBleHBvcnRm
cwo+ID4KPiA+ID4gVGhpcyBwYXRjaCBhZGRzIGEgY2hlY2sgdXNpbmcgYWNjZXNzKCIvdmFyL2xp
Yi9uZnMvZXRhYiIsIEZfT0spCj4gPiA+IGJlZm9yZSBydW5uaW5nIHRoZSB0ZXN0LiBJZiB0aGUg
ZmlsZSBkb2VzIG5vdCBleGlzdCwgdGhlIHRlc3QKPiA+ID4gaXMgc2tpcHBlZCAoVENPTkYpIGlu
c3RlYWQgb2YgZmFpbGluZywgcHJldmVudGluZyBtaXNsZWFkaW5nCj4gPiA+IHRlc3QgZmFpbHVy
ZXMuCj4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4K
PiA+ID4gQ2M6IFlvbmdjaGVuZyBZYW5nIDx5b3lhbmdAcmVkaGF0LmNvbT4KPiA+ID4gLS0tCj4g
PiA+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0YXR4L3N0YXR4MDcuYyB8IDMgKysrCj4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gPgo+ID4gPiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zdGF0eC9zdGF0eDA3LmMKPiBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvc3RhdHgvc3RhdHgwNy5jCj4gPiA+IGluZGV4IDk2ODE3NDMzMC4u
YmM4ZTZmZDY1IDEwMDY0NAo+ID4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0
YXR4L3N0YXR4MDcuYwo+ID4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0YXR4
L3N0YXR4MDcuYwo+ID4gPiBAQCAtMTE1LDYgKzExNSw5IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZv
aWQpCj4gPiA+ICAgICBpbnQgcmV0Owo+ID4gPiAgICAgY2hhciBzZXJ2ZXJfcGF0aFtCVUZGX1NJ
WkVdOwo+ID4KPiA+ID4gKyAgIGlmIChhY2Nlc3MoIi92YXIvbGliL25mcy9ldGFiIiwgRl9PSykg
PCAwKQo+ID4gPiArICAgICAgICAgICB0c3RfYnJrKFRDT05GLCAibmZzLXNlcnZlciBtaWdodCBu
b3Qgc2V0IHVwIik7Cj4gPgo+ID4gT24gVHVtYmxld2VlZCB3aXRoIG5mcy1jbGllbnQtMi44LjEt
NDQuMi54ODZfNjQ6Cj4gPgo+ID4gIyBzeXN0ZW1jdGwgc3RvcCBuZnMtc2VydmVyLnNlcnZpY2UK
PiA+ICMgLi9zdGF0eDA3Cj4gPiAuLi4KPiA+IHRzdF90ZXN0LmM6MTkwNDogVElORk86IFRlc3Rl
ZCBrZXJuZWw6IDYuMTMuMC0yLmcwMTI3YTM3LWRlZmF1bHQgIzEgU01QCj4gUFJFRU1QVF9EWU5B
TUlDIFRodSBKYW4gMjMgMTE6MjE6NTUgVVRDIDIwMjUgKDAxMjdhMzcpIHg4Nl82NAo+ID4gLi4u
Cj4gPiBzdGF0eDA3LmM6MTQxOiBUQ09ORjogbmZzIHNlcnZlciBub3Qgc2V0IHVwPzogRU9QTk9U
U1VQUCAoOTUpCj4gPgo+ID4gJCBscyAtbGEgL3Zhci9saWIvbmZzL2V0YWIKPiA+Cj4gPiBUaGUg
c2FtZSBiZWhhdmlvciBpcyBvbiBvbGRlciBzeXN0ZW1zIChJIGNoZWNrZWQgU0xFMTUtU1A0IHdp
dGggNS4xNAo+IGJhc2VkCj4gPiBrZXJuZWwgYW5kIG5mcy1jbGllbnQtMi4xLjEpLgo+ID4KPiA+
IFRoZXJlIGlzIGEgd29ya2luZyBkZXRlY3Rpb24uIEkgd29uZGVyIHdoYXQgaXMgZGlmZmVyZW50
IG9uIHRoZSBzeXN0ZW0KPiB5b3UgdGVzdC4KPiA+IE9UT0ggZm9ydHVuYXRlbHkgdGhpcyBwYXRj
aCB3b3VsZCBub3QgYnJlYWsgU0xFUy9vcGVuU1VTRSAoaXQgd291bGQganVzdAo+IG5vdAo+ID4g
aGVscCB0byBkZXRlY3QpLCB0aGVyZWZvcmUgSSdtIG5vdCBhZ2FpbnN0IGl0Lgo+Cj4gVGhpcyBp
cyBmb3IgYW4gdXBkYXRlIG9mIHRoZSBuZnMtdXRpbHMgc3BlYyBmaWxlLCBzZWUKPgo+IGh0dHBz
Oi8vc3JjLmZlZG9yYXByb2plY3Qub3JnL3JwbXMvbmZzLXV0aWxzL2MvZWVhMzZlNTAwMjRlZmJh
Yzc4NTE0Zjk2YTI5ZjA1MzA2OTA1MTE4Yj8vL2JyYW5jaD1yYXdoaWRlCj4KPiBOb3cgL3Zhci9s
aWIvbmZzL2V0YWIgYW5kIC92YXIvbGliL25mcy9ybXRhYiBhcmUgbWFya2VkIGFzICVjb25maWcg
ZmlsZXMKPiBhbmQgdGhleSB3aWxsIG5vdCBiZSBjcmVhdGVkIHdoZW4gbmZzLXV0aWxzIGlzIGp1
c3QgaW5zdGFsbGVkLgo+CgpUdXJlLCBzbyBpZiBzdGF0eDA3IHRlc3Qgb24gYSBzeXN0ZW0gbmV2
ZXIgc3RhcnRzIG5mcyBzZXJ2aWNlLAp3aGljaCB0aGUgZXRhYiBmaWxlIGlzIG5vdCBiZWluZyBj
cmVhdGVkLCBpdCB3b3VsZCBiZSBmYWlsZWQgbGlrZSB0aGF0LgoKT25jZSB3ZSBzdGFydCBhbmQg
dGhlbiBzdG9wIHRoZSBuZnMgc2VydmljZSB0aGUgcHJvYmxlbSBkaXNhcHBlYXJzCmJlY2F1c2Ug
ZXRhYiBmaWxlIGlzIGNyZWF0ZWQgYnkgdGhlIHN0YXJ0aW5nIHByb2Nlc3MuCgpUaGF0J3Mgd2h5
IEkgc2VudCB0aGUgY29uZmlnIGZpbGUgZGV0ZWN0aW9uIGFkZGl0aW9uYWxseS4KCgoKPgo+IEJl
c3QgUmVnYXJkcywKPiBZb25nY2hlbmcKPgo+ID4KPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIK
PiA+Cj4gPiA+ICsKPiA+ID4gICAgIG1vZGVfdCBvbGRfdW1hc2sgPSB1bWFzaygwKTsKPiA+Cj4g
PiA+ICAgICBTQUZFX01LRElSKFNFUlZfUEFUSCwgREVGQVVMVF9NT0RFKTsKPiA+Cj4KPgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
