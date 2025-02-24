Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C692C021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 10:11:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 230603C98BA
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 11:11:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 191803C090A
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 11:11:29 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 54CE01034D7E
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 11:11:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740391885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O3Y4mFvkvb4wIbzC60Q55gsuNAmKLUfB11vCOwJUmEA=;
 b=iqUw4Am+QRPca8vBUphozhBpKkVXQoKP4veOxwsM+N5pRKf+3bGQPRs9iWwTHYuVvQlYbs
 m8fEurVWlHD05vVAsoCGtWXUOYoi7Txem0h+NBFQxeidzCEYNF9GRxus85qpLvoS7DYCSo
 CrYFQFsI8ltG5iUD+WjId82pWtIvLHo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-q9msbNIcOyKZjNq2gnkEww-1; Mon, 24 Feb 2025 05:11:20 -0500
X-MC-Unique: q9msbNIcOyKZjNq2gnkEww-1
X-Mimecast-MFC-AGG-ID: q9msbNIcOyKZjNq2gnkEww_1740391880
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-220cd43c75aso136049775ad.3
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 02:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740391880; x=1740996680;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O3Y4mFvkvb4wIbzC60Q55gsuNAmKLUfB11vCOwJUmEA=;
 b=dIlGf5JPHKRN2jIhi0tkIBzxNCErnvLM0KGWUTtxHbKeCoaHoU8rBtYQEeZD4StBvQ
 AzfJD63E0y9TO/AiEsGZOvlgcZu2HJ/kEqqBR1PCQqvzSQPS46rxGNQXBzlO4hxSWQeD
 Kjp/dGFcem3MY5jHk2WtjzkmVbnsOGckAwiIyCJeKo+92F+KHBqXKrpIIKYtK0KVjkIA
 A04iOmIRTkYrUefiArs0TOOOkaRvq7QEMRe818tIOAf8yWS5SCvJS5C8WlWgYwpmYX2n
 6w5JHfc2T7lPIvWFKVrmUia9xa4/f2HjKXnp+s09Yt9g8XI9G/qBNBJF6S0H4lLlXYtX
 cV6w==
X-Gm-Message-State: AOJu0YzTeAH2XjkMAIZ78PvUaqeoRG4KQrlgu2GVgg1uhNIBXXLrtM2f
 +PffOV3lqJbqBZQVx8Kj6hHfAUNXL2fSg17o5+VuSeD1S5DUs/6W8i408PwCUkkKtBrbtfMCyZe
 MS/xcAFr74UV67+1GifpvUSNqOOF/1hr1xj/6XXMYcCFHFEXDu63Kne29FI0oE1al5McRofMbR+
 kU5mgYaIpxHYxRwF1w13lhc+I=
X-Gm-Gg: ASbGncuuhMci1j48HrR1qXNeXJn7/c7twZsx5Hmr13HkHxcFP5qGSKw77/iwLKiUWKx
 g1J8IZ+Z08yZDbNWzeT7AFF6YFV3JrxckH/cklZYNykaD1RnqgjSorT3aNmEU3WC79k4xBV4RzQ
 ==
X-Received: by 2002:a17:903:191:b0:216:4853:4c0b with SMTP id
 d9443c01a7336-2219ffc491dmr212718185ad.33.1740391879981; 
 Mon, 24 Feb 2025 02:11:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7DTsTuLQnlLB8+Tk2PQR7drIEj/OzSMCCPOZeuMKZXwb0FrmTyoMHkEUWBI3ymajuJ5BH8Mvcfhp0fwEkNnM=
X-Received: by 2002:a17:903:191:b0:216:4853:4c0b with SMTP id
 d9443c01a7336-2219ffc491dmr212717925ad.33.1740391879680; Mon, 24 Feb 2025
 02:11:19 -0800 (PST)
MIME-Version: 1.0
References: <20250224100016.2857704-1-pvorel@suse.cz>
In-Reply-To: <20250224100016.2857704-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Feb 2025 18:11:07 +0800
X-Gm-Features: AWEUYZkOMGlMNj4SWw3MZFGAIwLxLEC1Vu3Tqf5DPxd0fu47a42BsIWF4vCEtvA
Message-ID: <CAEemH2d=xOZCjNhMoavCE9hXB-9+efxWWDc6_pp_BFMkBZvZuQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3mOzqfQb1xFAGJB1h349p1EBXcqtJPV-d-ZZQ_z4mvk_1740391880
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] tst_test: Add $LTP_SINGLE_ITERATION to limit
 variant
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

SGkgUGV0ciwgQW5kcmVhLAoKT24gTW9uLCBGZWIgMjQsIDIwMjUgYXQgNjowMOKAr1BNIFBldHIg
Vm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gQWxsb3cgdG8gdGVzdCBvbmx5IHNpbmds
ZSBzdHJ1Y3QgdHN0X3Rlc3QtPnRlc3RfdmFyaWFudHMuCj4gVGhpcyBpcyBhIHNpbWlsYXIgZmVh
dHVyZSB0byAkTFRQX1NJTkdMRV9GU19UWVBFLgo+Cj4gVmFsdWUgaXMgaWdub3JlZCB3aGVuIHRl
c3QgZG9lcyBub3Qgc3BlY2lmeSB0ZXN0X3ZhcmlhbnRzLgo+IFdoZW4gdmFsdWUgaXMgaGlnaGVy
IHRoYW4gdGVzdF92YXJpYW50cyB2YWx1ZSBsYXN0ZXN0IHZhcmlhbnQgaXMgdXNlZC4KPgo+ICAg
ICAgICAgIyBMVFBfU0lOR0xFX1ZBUklBTlQ9MCBMVFBfU0lOR0xFX0ZTX1RZUEU9ZXh0NCAuL2dl
dGRlbnRzMDIKPiAgICAgICAgIC4uCj4gICAgICAgICB0c3RfdGVzdC5jOjE5MTg6IFRJTkZPOiBX
QVJOSU5HOiB0ZXN0aW5nIG9ubHkgdmFyaWFudCAwIG9mIDMKPiAgICAgICAgIHRzdF9zdXBwb3J0
ZWRfZnNfdHlwZXMuYzoxNjE6IFRJTkZPOiBXQVJOSU5HOiB0ZXN0aW5nIG9ubHkgZXh0NAo+ICAg
ICAgICAgdHN0X3N1cHBvcnRlZF9mc190eXBlcy5jOjk3OiBUSU5GTzogS2VybmVsIHN1cHBvcnRz
IGV4dDQKPiAgICAgICAgIHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzo2MjogVElORk86IG1rZnMu
ZXh0NCBkb2VzIGV4aXN0Cj4gICAgICAgICB0c3RfdGVzdC5jOjE4MzQ6IFRJTkZPOiA9PT0gVGVz
dGluZyBvbiBleHQ0ID09PQo+ICAgICAgICAgdHN0X3Rlc3QuYzoxMTcxOiBUSU5GTzogRm9ybWF0
dGluZyAvZGV2L2xvb3AwIHdpdGggZXh0NCBvcHRzPScnCj4gZXh0cmEgb3B0cz0nJwo+ICAgICAg
ICAgbWtlMmZzIDEuNDcuMiAoMS1KYW4tMjAyNSkKPiAgICAgICAgIHRzdF90ZXN0LmM6MTE4Mzog
VElORk86IE1vdW50aW5nIC9kZXYvbG9vcDAgdG8KPiAvdG1wL0xUUF9nZXR4MkhyR0gvbW50cG9p
bnQgZnN0eXA9ZXh0NCBmbGFncz0wCj4gICAgICAgICBnZXRkZW50cy5oOjE0ODogVElORk86IFRl
c3RpbmcgdGhlIFNZU19nZXRkZW50cyBzeXNjYWxsCj4gICAgICAgICB0c3RfYnVmZmVycy5jOjU3
OiBUSU5GTzogVGVzdCBpcyB1c2luZyBndWFyZGVkIGJ1ZmZlcnMKPiAgICAgICAgIGdldGRlbnRz
MDIuYzo3NzogVFBBU1M6IGZkPS01IGRpcnA9MHg3ZjA1ODc4MDNlZTkgc2l6ZT0yNzkgOiBFQkFE
Rgo+ICg5KQo+ICAgICAgICAgZ2V0ZGVudHMwMi5jOjc3OiBUUEFTUzogZmQ9MyBkaXJwPTB4NTY0
MTYxN2EzMWU4IHNpemU9MSA6IEVJTlZBTAo+ICgyMikKPiAgICAgICAgIGdldGRlbnRzMDIuYzo3
NzogVFBBU1M6IGZkPTQgZGlycD0weDdmMDU4NzgwM2VlOSBzaXplPTI3OSA6Cj4gRU5PVERJUiAo
MjApCj4gICAgICAgICBnZXRkZW50czAyLmM6Nzc6IFRQQVNTOiBmZD01IGRpcnA9MHg3ZjA1ODc4
MDNlZTkgc2l6ZT0yNzkgOiBFTk9FTlQKPiAoMikKPiAgICAgICAgIGdldGRlbnRzMDIuYzo3Nzog
VFBBU1M6IGZkPTMgZGlycD0weDdmMDU4NzgwMjAwMCBzaXplPTI3OSA6IEVGQVVMVAo+ICgxNCkK
Pgo+ICAgICAgICAgIyBMVFBfU0lOR0xFX1ZBUklBTlQ9MiBMVFBfU0lOR0xFX0ZTX1RZUEU9ZXh0
NCAuL2dldGRlbnRzMDIKPiAgICAgICAgIC4uLgo+ICAgICAgICAgdHN0X3Rlc3QuYzoxOTE4OiBU
SU5GTzogV0FSTklORzogdGVzdGluZyBvbmx5IHZhcmlhbnQgMiBvZiAzCj4gICAgICAgICB0c3Rf
c3VwcG9ydGVkX2ZzX3R5cGVzLmM6MTYxOiBUSU5GTzogV0FSTklORzogdGVzdGluZyBvbmx5IGV4
dDQKPiAgICAgICAgIHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzo5NzogVElORk86IEtlcm5lbCBz
dXBwb3J0cyBleHQ0Cj4gICAgICAgICB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6NjI6IFRJTkZP
OiBta2ZzLmV4dDQgZG9lcyBleGlzdAo+ICAgICAgICAgdHN0X3Rlc3QuYzoxODM0OiBUSU5GTzog
PT09IFRlc3Rpbmcgb24gZXh0NCA9PT0KPiAgICAgICAgIHRzdF90ZXN0LmM6MTE3MTogVElORk86
IEZvcm1hdHRpbmcgL2Rldi9sb29wMCB3aXRoIGV4dDQgb3B0cz0nJwo+IGV4dHJhIG9wdHM9JycK
PiAgICAgICAgIG1rZTJmcyAxLjQ3LjIgKDEtSmFuLTIwMjUpCj4gICAgICAgICB0c3RfdGVzdC5j
OjExODM6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AwIHRvCj4gL3RtcC9MVFBfZ2V0V3RCbkdF
L21udHBvaW50IGZzdHlwPWV4dDQgZmxhZ3M9MAo+ICAgICAgICAgZ2V0ZGVudHMuaDoxNTc6IFRD
T05GOiBsaWJjIGdldGRlbnRzKCkgaXMgbm90IGltcGxlbWVudGVkCj4KPiAgICAgICAgICMgTFRQ
X1NJTkdMRV9WQVJJQU5UPTk5IExUUF9TSU5HTEVfRlNfVFlQRT1leHQ0IC4vZ2V0ZGVudHMwMiAj
Cj4gaGlnaGVyIHZhbHVlIGlzIG1heCB2YWx1ZQo+ICAgICAgICAgdHN0X3Rlc3QuYzoxOTE4OiBU
SU5GTzogV0FSTklORzogdGVzdGluZyBvbmx5IHZhcmlhbnQgMyBvZiAzCj4gICAgICAgICB0c3Rf
c3VwcG9ydGVkX2ZzX3R5cGVzLmM6MTYxOiBUSU5GTzogV0FSTklORzogdGVzdGluZyBvbmx5IGV4
dDQKPiAgICAgICAgIHRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzo5NzogVElORk86IEtlcm5lbCBz
dXBwb3J0cyBleHQ0Cj4gICAgICAgICB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6NjI6IFRJTkZP
OiBta2ZzLmV4dDQgZG9lcyBleGlzdAo+ICAgICAgICAgdHN0X3Rlc3QuYzoxODM0OiBUSU5GTzog
PT09IFRlc3Rpbmcgb24gZXh0NCA9PT0KPiAgICAgICAgIHRzdF90ZXN0LmM6MTE3MTogVElORk86
IEZvcm1hdHRpbmcgL2Rldi9sb29wMCB3aXRoIGV4dDQgb3B0cz0nJwo+IGV4dHJhIG9wdHM9JycK
PiAgICAgICAgIG1rZTJmcyAxLjQ3LjIgKDEtSmFuLTIwMjUpCj4gICAgICAgICB0c3RfdGVzdC5j
OjExODM6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AwIHRvCj4gL3RtcC9MVFBfZ2V0MWZYNzBu
L21udHBvaW50IGZzdHlwPWV4dDQgZmxhZ3M9MAo+ICAgICAgICAgZ2V0ZGVudHMuaDoxNjI6IFRJ
TkZPOiBUZXN0aW5nIGxpYmMgZ2V0ZGVudHM2NCgpCj4gICAgICAgICB0c3RfYnVmZmVycy5jOjU3
OiBUSU5GTzogVGVzdCBpcyB1c2luZyBndWFyZGVkIGJ1ZmZlcnMKPiAgICAgICAgIGdldGRlbnRz
MDIuYzo3NzogVFBBU1M6IGZkPS01IGRpcnA9MHg3ZmNmMTQwZjNlZTggc2l6ZT0yODAgOiBFQkFE
Rgo+ICg5KQo+ICAgICAgICAgZ2V0ZGVudHMwMi5jOjc3OiBUUEFTUzogZmQ9MyBkaXJwPTB4NTVh
NzZlNDUzMWU4IHNpemU9MSA6IEVJTlZBTAo+ICgyMikKPiAgICAgICAgIGdldGRlbnRzMDIuYzo3
NzogVFBBU1M6IGZkPTQgZGlycD0weDdmY2YxNDBmM2VlOCBzaXplPTI4MCA6Cj4gRU5PVERJUiAo
MjApCj4gICAgICAgICBnZXRkZW50czAyLmM6Nzc6IFRQQVNTOiBmZD01IGRpcnA9MHg3ZmNmMTQw
ZjNlZTggc2l6ZT0yODAgOiBFTk9FTlQKPiAoMikKPiAgICAgICAgIGdldGRlbnRzMDIuYzo3Nzog
VFBBU1M6IGZkPTMgZGlycD0weDdmY2YxNDBmMjAwMCBzaXplPTI4MCA6IEVGQVVMVAo+ICgxNCkK
Pgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IC0tLQo+IEhp
IGFsbCwKPgo+IEFuZHJlYSB3YW50ZWQgdG8gcnVuIG9ubHkgc2luZ2xlIHZhcmlhbnQuCj4KCkNv
dWxkIHlvdSB0ZWxsIG1lIHdoYXQgdGhlIGJlbmVmaXQgaXM/IHdoeSBkbyB3ZSBuZWVkIHRoaXM/
CgpBbmQgYmFjayB0byB0aGUgcGF0Y2ggaXRzZWxmLCBpZiBMVFBfU0lOR0xFX0lURVJBVElPTiBp
cyB1c2VkLCB3aGljaAp2YXJpYW50IHdpbGwgYmUgY2hvc2VuIHRvIHJ1biBieSBkZWZhdWx0PyBJ
cyB0aGF0IGV4cGVjdGVkPwoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
