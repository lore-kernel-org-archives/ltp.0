Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE6CC47258
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 05:55:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C3F43CC783
	for <ltp@archiver.kernel.org>; Tue, 23 Jan 2024 06:55:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D49A3C0349
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 06:55:28 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4445B600A2E
 for <ltp@lists.linux.it>; Tue, 23 Jan 2024 06:55:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705989325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C+5fH9NRY1+KXNCQPsyRCq8eArOsLT2bPWeleqvdv1o=;
 b=cbchUARmQHJd4Vod1m3Ljf+KsOPOZ9b+iOTjpEVXqsiiW3e2gynqldUxK/ell6x9OpBuOq
 Q0uirl7jRUxShBoKIwnm6DyFt8TafDH2ehe8uSIJ0NsSVNhl3egutWX4ojMcYR8L2dlsJ5
 6pEV5mFhMbouYpj0YliWVI/mahmJG1M=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-fJ3RQzzAOtK3D3XWf0pFEA-1; Tue, 23 Jan 2024 00:55:23 -0500
X-MC-Unique: fJ3RQzzAOtK3D3XWf0pFEA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5cec8bc5c66so2119651a12.1
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 21:55:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705989322; x=1706594122;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C+5fH9NRY1+KXNCQPsyRCq8eArOsLT2bPWeleqvdv1o=;
 b=n6H7uCVRgPrwbhqbt2VHEZluHgY4BBkYBcauNGM5wsHmtipAjRg2HMYFj08s1EXpeH
 EDyp1+jjJ8Q6/Rzfli6Y1n45nclo2zKmmbuJr7AlcMGCRrhZnNxTytArFMEjmCFUY0rT
 oUzH/OBcDMom/+ybHvWMP2MRHRsH6z5UWr8kYBVD6nqis9YcwNR8oTgU4/4Fub1s9O+D
 bfKq1JmyoEX6Z3ELhvvX836PTREgovdqrFV0JL4jCabzKDBjZg7xzxcAsQmXPNMeuMVb
 Kum47Ot6NFZvqhtkf57mn+dZqrcu1P6FmyuGQ+yhZUkBlLns48TGlevfJq2nRN/LLvMN
 gUYw==
X-Gm-Message-State: AOJu0YwM+dC67fD0h6UVpwyT6o+Mc5cDPA/0iiC53MjX/gDGZVqN6BYT
 rB+uNsMrSvb0onCS5pCDlydyW7BE5UiVXpn/sjVqwXl2fIxv3dKgvLcgCh755Ov4mH2RjK7EQZH
 gCPIEEpP4f6Ae9BO5SnYjkh7RK6KMmgeuLmRCuIFXTg5CeKKpP4MOokfmkyShL0NuW399lhw9Et
 E1L3fEizWNfiJQloEJqoHgl7o=
X-Received: by 2002:a05:6a20:4d1d:b0:19b:6a1:a69f with SMTP id
 gb29-20020a056a204d1d00b0019b06a1a69fmr2085947pzb.109.1705989322080; 
 Mon, 22 Jan 2024 21:55:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEeCJHBguO+oPzwzJd6E+fhI1pM5PKzoWotQvgr2ESie1pLA8/fyUfEyn1CNQHYdQyUYjhaCP6FJE4d1VYesE=
X-Received: by 2002:a05:6a20:4d1d:b0:19b:6a1:a69f with SMTP id
 gb29-20020a056a204d1d00b0019b06a1a69fmr2085938pzb.109.1705989321693; Mon, 22
 Jan 2024 21:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122091356.GF76754@pevik>
 <CAEemH2dA6sjKz4LGUwYT3wr-4WRZ5H_usSptEG30HxVDVbWSWA@mail.gmail.com>
 <20240122110344.GB95077@pevik>
 <CAEemH2cNn1kyWrnqXHHeOteGT_FQ=PBVc55NFhkZbmkbMOoD=A@mail.gmail.com>
 <20240122202325.GA119341@pevik>
In-Reply-To: <20240122202325.GA119341@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Jan 2024 13:55:09 +0800
Message-ID: <CAEemH2dTKjxuiMaHBh0Ky0VV+p2YmDQzH7nvZZjnOVop2E04jQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/4] libswap: add known swap supported fs check
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

SGkgUGV0ciwKCk9uIFR1ZSwgSmFuIDIzLCAyMDI0IGF0IDQ6MjPigK9BTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIExpLAo+Cj4gPiBHcmVhdCwgYW5kIEZZSS4KPgo+
ID4gSSBqdXN0IHB1c2hlZCBhIG5ldyBjb21taXQgdG8gcmVzb2x2ZSB0aGUgRklCTUFQICh1bnN1
cHBvcnRlZCBvbiBCVFJGUykKPiA+IHByb2JsZW0gb24gbXkgbHRwOmxpYnN3YXAgYnJhbmNoLgo+
Cj4gPgo+IGh0dHBzOi8vZ2l0aHViLmNvbS93YW5nbGk1NjY1L2x0cC9jb21taXQvNjk5NzExYmZl
OGM4ZGJjMzU5N2M0NjU4NzM0NWZhMTE5N2MwNTRjOQo+Cj4gPiBIb3BlIHlvdSBjYW4gdHJ5IG9u
IHlvdXIgc2lkZSBhbmQgZ2l2ZSBzb21lIGZlZWRiYWNrIDopLgo+Cj4gVW5mb3J0dW5hdGVseSBy
ZWdhcmRsZXNzIG9mIGtlcm5lbCB2ZXJzaW9uIGl0IGZhaWxzOgo+Cj4gIyBMVFBfU0lOR0xFX0ZT
X1RZUEU9YnRyZnMgLi9zd2Fwb24wMQo+IC4uLgo+IHRzdF90ZXN0LmM6MTY2OTogVElORk86ID09
PSBUZXN0aW5nIG9uIGJ0cmZzID09PQo+IHRzdF90ZXN0LmM6MTExNzogVElORk86IEZvcm1hdHRp
bmcgL2Rldi9sb29wMCB3aXRoIGJ0cmZzIG9wdHM9JycgZXh0cmEKPiBvcHRzPScnCj4gdHN0X3Rl
c3QuYzoxMTMxOiBUSU5GTzogTW91bnRpbmcgL2Rldi9sb29wMCB0byAvdG1wL0xUUF9zd2E0OTdB
S3AvbW50cG9pbnQKPiBmc3R5cD1idHJmcyBmbGFncz0wCj4gdHN0X2lvY3RsLmM6MjE6IFRJTkZP
OiBGSUJNQVAgaW9jdGwgaXMgTk9UIHN1cHBvcnRlZDogRUlOVkFMICgyMikKPiBsaWJzd2FwLmM6
OTM6IFRJTkZPOiBGaWxlICdtbnRwb2ludC9zd2FwZmlsZTAxJyBpcyBub3QgY29udGlndW91cwo+
IGxpYnN3YXAuYzozNDogVElORk86IEZTX05PQ09XX0ZMIGF0dHJpYnV0ZSBzZXQgb24gbW50cG9p
bnQvc3dhcGZpbGUwMQo+IGxpYnN3YXAuYzoxNjk6IFRGQUlMOiBzd2Fwb24oKSBvbiBidHJmcyBm
YWlsZWQ6IEVJTlZBTCAoMjIpCj4KCgpUaGFua3MgZm9yIHRoZSBxdWljayBmZWVkYmFjaywgdmVy
eSB1c2VmdWwuCgpBZnRlciBsb29raW5nIG92ZXIgdGhlIGNvZGUsIEkgdGhpbmsgaXQncyBiZWNh
dXNlIHRoZSB0c3RfZmlsbF9maWxlIGRpZG4ndApjcmVhdGUgYSBjb250aWd1b3VzIGZpbGUgYXQg
dGhlIGJlZ2lubmluZywgc28gdGhlIHNvbHV0aW9uIGlzIHByb2JhYmx5CnRvIGRlZmluZSBhIG5l
dyBmdW5jdGlvbiBqdXN0IHVzZWQgYnkgY3JlYXRpbmcgYSBjb250aWd1b3VzIGZpbGUgZm9yIGJ0
cmZzCmluIHRoZSBsaWJzd2FwLmMuCgpBZnRlciBhIHRpbnkgYW1lbmQsIGl0IHdvcmtzIG9uIGEg
ZmVkb3JhMzguCgokIGRmIC1UaCB8Z3JlcCBidHJmcwovZGV2L252bWUwbjFwMyBidHJmcyAgICAg
NDc2RyAgMTEyRyAgMzYyRyAgMjQlIC8KL2Rldi9udm1lMG4xcDMgYnRyZnMgICAgIDQ3NkcgIDEx
MkcgIDM2MkcgIDI0JSAvaG9tZQoKJCBzdWRvIExUUF9TSU5HTEVfRlNfVFlQRT1idHJmcyAuL3N3
YXBvbjAxCnRzdF9kZXZpY2UuYzo5NjogVElORk86IEZvdW5kIGZyZWUgZGV2aWNlIDAgJy9kZXYv
bG9vcDAnCnRzdF90ZXN0LmM6MTcwOTogVElORk86IExUUCB2ZXJzaW9uOiAyMDIzMDkyOS0yOTIt
ZzY5OTcxMWJmZQp0c3RfdGVzdC5jOjE1OTM6IFRJTkZPOiBUaW1lb3V0IHBlciBydW4gaXMgMGgg
MDBtIDMwcwp0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6MTYxOiBUSU5GTzogV0FSTklORzogdGVz
dGluZyBvbmx5IGJ0cmZzCnRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzo5NzogVElORk86IEtlcm5l
bCBzdXBwb3J0cyBidHJmcwp0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6NjI6IFRJTkZPOiBta2Zz
LmJ0cmZzIGRvZXMgZXhpc3QKCnRzdF90ZXN0LmM6MTY2OTogVElORk86ID09PSBUZXN0aW5nIG9u
IGJ0cmZzID09PQp0c3RfdGVzdC5jOjExMTc6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9vcDAg
d2l0aCBidHJmcyBvcHRzPScnIGV4dHJhCm9wdHM9JycKdHN0X3Rlc3QuYzoxMTMxOiBUSU5GTzog
TW91bnRpbmcgL2Rldi9sb29wMCB0byAvdG1wL0xUUF9zd2FNcVZYajIvbW50cG9pbnQKZnN0eXA9
YnRyZnMgZmxhZ3M9MApsaWJzd2FwLmM6MzQ6IFRJTkZPOiBGU19OT0NPV19GTCBhdHRyaWJ1dGUg
c2V0IG9uIG1udHBvaW50L3N3YXBmaWxlMDEKdHN0X2lvY3RsLmM6MjE6IFRJTkZPOiBGSUJNQVAg
aW9jdGwgaXMgTk9UIHN1cHBvcnRlZDogRUlOVkFMICgyMikKbGlic3dhcC5jOjM0OiBUSU5GTzog
RlNfTk9DT1dfRkwgYXR0cmlidXRlIHNldCBvbiBtbnRwb2ludC9zd2FwZmlsZTAxCnN3YXBvbjAx
LmM6Mjc6IFRQQVNTOiB0c3Rfc3lzY2FsbChfX05SX3N3YXBvbiwgU1dBUF9GSUxFLCAwKSBwYXNz
ZWQKc3dhcG9uMDEuYzozMDogVElORk86IFN3YXBDYWNoZWQ6IDAgS2IKClN1bW1hcnk6CnBhc3Nl
ZCAgIDEKZmFpbGVkICAgMApicm9rZW4gICAwCnNraXBwZWQgIDAKd2FybmluZ3MgMAoKCgoKCj4K
PiBBbHNvLCB0c3RfYnJrKCkgaW4gaXNfc3dhcF9zdXBwb3J0ZWQoKSBjYXVzZXMgdGVzdCB0byBm
YWlsIHF1aWNrbHkuCj4gR2l2ZW4gc2ltaWxhciBNYXJ0aW4ncyBmaXggdG8gc2hlbGwgQVBJIEkg
bWVyZ2VkIHRvZGF5LCB3aGljaCB1c2UgdHN0X3JlcyArCj4gcmV0dXJuIGluc3RlYWQgb2YgdHN0
X2JyayBbMV0gSSBzdWdnZXN0IHRvIHVzZSB0c3RfcmVzICsgY2hhbmdlIHJldHVybgo+IGZ1bmN0
aW9uCj4gZnJvbSB2b2lkIHRvIGludCBhbmQgaGFuZGxlIGFub3RoZXIgcmV0dXJuIGluIHRoZSB0
ZXN0LiBUaGF0IHdpbGwgYWxsb3cgdG8KPiB0ZXN0Cj4gb3RoZXIgZmlsZXN5c3RlbXMgKHdoaWNo
IGlzIHVzZWZ1bCB0byBzZWUsIGlmIHBhcnRpY3VsYXIgZmlsZXN5c3RlbSBjb2RlIGlzCj4gYnJv
a2VuIG9yIG9yIFZGUyBvciBzb21lIGNvbW1vbiBjb2RlIHJldXNlZCBieSBhbGwgZmlsZXN5c3Rl
bXMpLiBUaGlzIGlzCj4gdGhlCj4gcmVhc29uIHdoeSBJIGRvbid0IHRoaW5rICJxdWl0IGFzIGVh
cmx5IGFzIHBvc3NpYmxlIiBpcyBhIGdvb2QgYXBwcm9hY2gKPiB3aGVuCj4gdGVzdGluZyBvbiBh
bGwgZmlsZXN5c3RlbXMuCj4KClllcywgZ29vZCBhZHZpY2UuCgoKPiBLaW5kIHJlZ2FyZHMsCj4g
UGV0cgo+Cj4gWzFdCj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAv
Y29tbWl0LzVjNzNhZDg0ZjNlNmRiOWE5NjVkZjNlZDRhODQ2MzUyMTM2ZWQ5OTAKPgo+ID4gPiA+
IGh0dHBzOi8vZ2l0aHViLmNvbS93YW5nbGk1NjY1L2x0cC90cmVlL2xpYnN3YXAKPgo+ID4gPiA+
IEFuZCwgSSBwcmVmZXIgdG8gd2FpdCBmb3IgQ3J5aWwncyBmZWVkYmFjayBiZWZvcmUgcG9zdGlu
ZyB0aGVtIGluCj4gTUw6KQo+Cj4gPiA+ICsxCj4KPiA+ID4gS2luZCByZWdhcmRzLAo+ID4gPiBQ
ZXRyCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
