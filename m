Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E46C64EC4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 13:10:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCCA53CD8BE
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 14:10:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E72983CB7F8
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 14:10:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 87D17600D26
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 14:10:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678367412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pHduoKpdbf/d+kijhqrZbaL6RRTgmnoZ9GPrNAAhX/E=;
 b=IWBe8jQ9tbk8yUYEyxTGYigjDcqWBtDXzRkgW00rWUvsmTuTu9fqUZz2YnqQ7ITWSBuTgj
 suUdKrvvp4fqoGkd4bjXbS0L9c52MRO8JY3Rfzch5TvTJxuVaAaUrtoyurr7mySmfQOGCK
 EzI52iihX+oLcPLuFxIRlGsMUbVWgr8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-4U4pcgsFMjSmUuJ_0WmItw-1; Thu, 09 Mar 2023 08:10:10 -0500
X-MC-Unique: 4U4pcgsFMjSmUuJ_0WmItw-1
Received: by mail-wr1-f72.google.com with SMTP id
 y11-20020a056000168b00b002ce179d1b90so418243wrd.23
 for <ltp@lists.linux.it>; Thu, 09 Mar 2023 05:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678367409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pHduoKpdbf/d+kijhqrZbaL6RRTgmnoZ9GPrNAAhX/E=;
 b=P8L0fO1CnS22LrLrrhRzWipXp33D6SakWHFaNyJJY+DhMkkQ5McWIxjbqDDKUKYsaP
 z6TAqIwE4F4/Oy7nKuJGG09X6e5JIpiOuwW615hKFdYtowjofivRvTNV2wR4b5Ai+FAm
 aQWcTHVNeVfA2PC2w8OYz4+n/ZYqBtao7ahLE5dUxa1aQX83p1VEOSOArn0hDrwwa3yV
 HZmUF7nLUy5xHkRCRhX+9SJE7xl0HsbOSe01noLMt9utu04siPc1aHdSmwqR77loy1dX
 7SE8yqpil7dQvD1QozArJjS8GEI/ZKIz5kZIdlJ+2upMxaGl1K5zihVyrdD1u1XYXWwt
 VGGA==
X-Gm-Message-State: AO0yUKVFw5AgDuzJ0r42efB5QDqHVbQ/ux6mKVfAMM2E0i/IE+fTAAPD
 NtVc0Dl+6IlmCWD/Z3MR8u9gfeB6Wn9s10Qw0lkvo4rNmoSncaaSDk+rt5m/QoltEKi7MNr7yKJ
 SOdsgrsX9rrZYlw4ORaxWf0m+0K8=
X-Received: by 2002:a05:600c:a383:b0:3df:fc67:cfe5 with SMTP id
 hn3-20020a05600ca38300b003dffc67cfe5mr5114915wmb.8.1678367409557; 
 Thu, 09 Mar 2023 05:10:09 -0800 (PST)
X-Google-Smtp-Source: AK7set9A0iXhGA0elvNTun2+M50IvVNxmLzaZ9EA65nDXTEsl4+ykNj2VMg9RWg8G0efVBRorUKVQB1L5IJXMrtwE/E=
X-Received: by 2002:a05:600c:a383:b0:3df:fc67:cfe5 with SMTP id
 hn3-20020a05600ca38300b003dffc67cfe5mr5114907wmb.8.1678367409249; Thu, 09 Mar
 2023 05:10:09 -0800 (PST)
MIME-Version: 1.0
References: <20230226192554.669332-1-fontaine.fabrice@gmail.com>
 <Y/yTyk9rYYsPJyVA@yuki> <20230309105627.GA10008@pevik>
In-Reply-To: <20230309105627.GA10008@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Mar 2023 21:09:57 +0800
Message-ID: <CAEemH2egmH5Obpd8LZ1CNJYdpC-Y7MCRT6m98HOBS4G9rawJ1g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] configure.ac: fix mount_attr detection
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
Cc: ltp@lists.linux.it, Fabrice Fontaine <fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBNYXIgOSwgMjAyMyBhdCA2OjU24oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBhbGwsCj4KPiBbIENjIExpIC0gcXVlc3Rpb24gZnJvbSBDeXJpbCBh
dCB0aGUgZW5kIF0KPgo+IEZhYnJpY2UsIHRoYW5rcyBmb3IgZml4aW5nIHRoaXMgbG9uZyBzdGFu
ZGluZyBpc3N1ZS4KPgo+ID4gSGkhCj4gPiA+IENvbW1pdCBiODU3Zjg3MjNmMzBhNGI5NTU0YmY2
YjBmZjhmYTUyZmQwN2U4YjYwIHRyaWVkIHRvIGZpeCBidWlsZCB3aXRoCj4gPiA+IGxhdGVzdCBn
bGliYyB3aGljaCBwcm92aWRlcyBtb3VudF9hdHRyIGluIHN5cy9tb3VudC5oLiBVbmZvcnR1bmF0
ZWx5LAo+ID4gPiB0aGUgZm9sbG93aW5nIGJ1aWxkIGZhaWx1cmUgaXMgc3RpbGwgcmFpc2VkIGJl
Y2F1c2Ugc3lzL21vdW50IGlzIG5vdwo+ID4gPiB1bmNvbmRpdGlvbmFsbHkgaW5jbHVkZWQgaW4g
aW5jbHVkZS9sYXBpL2ZzbW91bnQuaDoKPgo+ID4gPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gZnNj
b25maWcwMS5jOjk6Cj4gPiA+IC4uLy4uLy4uLy4uL2luY2x1ZGUvbGFwaS9mc21vdW50Lmg6NTU6
ODogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZgo+ICdzdHJ1Y3QgbW91bnRfYXR0cicKPiA+ID4gICAg
NTUgfCBzdHJ1Y3QgbW91bnRfYXR0ciB7Cj4gPiA+ICAgICAgIHwgICAgICAgIF5+fn5+fn5+fn4K
PiA+ID4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4uLy4uLy4uLy4uL2luY2x1ZGUvbGFwaS9mc21v
dW50Lmg6MTQ6Cj4gPiA+Cj4gL2hvbWUvYXV0b2J1aWxkL2F1dG9idWlsZC9pbnN0YW5jZS00L291
dHB1dC0xL2hvc3QvYXJtZWItYnVpbGRyb290LWxpbnV4LWdudWVhYmkvc3lzcm9vdC91c3IvaW5j
bHVkZS9zeXMvbW91bnQuaDoyMTA6ODoKPiBub3RlOiBvcmlnaW5hbGx5IGRlZmluZWQgaGVyZQo+
ID4gPiAgIDIxMCB8IHN0cnVjdCBtb3VudF9hdHRyCj4gPiA+ICAgICAgIHwgICAgICAgIF5+fn5+
fn5+fn4KPgo+ID4gPiBGaXhlczoKPiA+ID4gIC0KPiBodHRwOi8vYXV0b2J1aWxkLmJ1aWxkcm9v
dC5vcmcvcmVzdWx0cy80ZGJiNzJlMWJmMDgxYWZkM2NkOTQ0NTcxYjliZWVlZmM3NjA4ODY1Cj4K
PiA+ID4gU2lnbmVkLW9mZi1ieTogRmFicmljZSBGb250YWluZSA8Zm9udGFpbmUuZmFicmljZUBn
bWFpbC5jb20+Cj4gPiA+IC0tLQo+ID4gPiAgY29uZmlndXJlLmFjIHwgNiArKystLS0KPiA+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiA+ID4g
ZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2NvbmZpZ3VyZS5hYwo+ID4gPiBpbmRleCBjMmIw
ZjQ4ZTcuLmE2ZDhhYzgyNiAxMDA2NDQKPiA+ID4gLS0tIGEvY29uZmlndXJlLmFjCj4gPiA+ICsr
KyBiL2NvbmZpZ3VyZS5hYwo+ID4gPiBAQCAtMjI1LDEwICsyMjUsMTAgQEAgQUNfQ0hFQ0tfVFlQ
RVMoW3N0cnVjdCBfX2tlcm5lbF9vbGRfdGltZXZhbCwKPiBzdHJ1Y3QgX19rZXJuZWxfb2xkX3Rp
bWVzcGVjLCBzdHJ1Ywo+Cj4gPiA+ICBBQ19DSEVDS19UWVBFUyhbc3RydWN0IGZ1dGV4X3dhaXR2
XSwsLFsjaW5jbHVkZSA8bGludXgvZnV0ZXguaD5dKQo+ID4gPiAgQUNfQ0hFQ0tfVFlQRVMoW3N0
cnVjdCBtb3VudF9hdHRyXSwsLFsKPiA+ID4gLSNpZmRlZiBIQVZFX0xJTlVYX01PVU5UX0gKPiA+
ID4gLSMgaW5jbHVkZSA8bGludXgvbW91bnQuaD4KPiA+ID4gLSNlbHNlCj4gPiA+ICsjaWZkZWYg
SEFWRV9NT1VOVF9TRVRBVFRSCj4gPiA+ICAjIGluY2x1ZGUgPHN5cy9tb3VudC5oPgo+ID4gPiAr
I2VsaWYgSEFWRV9MSU5VWF9NT1VOVF9ICj4gPiA+ICsjIGluY2x1ZGUgPGxpbnV4L21vdW50Lmg+
Cj4gPiA+ICAjZW5kaWYKPiA+ID4gIF0pCj4KPiA+IEkgd29uZGVyIGlmIHdlIGNhbiBnZXQgdGhp
cyB3aG9sZSBtZXNzIG9mIHR3byBkaWZmZXJlbnQgZmFsbGJhY2sgaGVhZGVycwo+ID4gc2ltcGxp
ZmllZC4gTG9va2luZyBhdCB0aGUgZ2xpYmMgaW1wbGVtZW50YXRpb24gaXQgc2VlbXMgdG8gaW5j
bHVkZQo+ID4gImxpbnV4L21vdW50LmgiIGlmIGl0IGRvZXMgZXhpc3QuIFNvIG1vc3QgcmVhc29u
YWJsZSBzb2x1dGlvbiB3b3VsZCBkbwo+ID4gdGhlIHNhbWUgSSBndWVzcyB3aGljaCB3ZSBkaWQg
YmVmb3JlIHRoZSBjb21taXQgeW91IHJlZmVyZW5jZS4KPgo+ID4gQExpIFdhbmcgd2hlcmUgZG9l
cyB0aGUgdGhlIHN5cy9tb3VudC5oIGFuZCBsaW51eC9tb3VudC5oIGNvbmZsaWN0PyBBcwo+ID4g
ZmFyIGFzIEkgY2FuIHRlbGwgdGhlIFVBUEkgbGludXgvbW91bnQuaCBuZXZlciBkZWZpbmVkIGFu
eSBmdW5jdGlvbnMsCj4gPiBqdXN0IGNvbnN0YW50cywgd2hpY2ggc2hvdWxkIGJlIHNvbHZhYmxl
IHdpdGhvdXQgdGhlIGNvbXBsZXggaWZkZWZzLCB3ZQo+ID4ganVzdCBuZWVkIHRvIGNoZWNrIGZv
ciBleGlzdGVuY2Ugb2YgdGhlIHR5cGVzIGFuZCBkZWZpbmUgdGhlbSBvbmx5IGlmCj4gPiBtaXNz
aW5nLgo+Cj4gUXVvdGluZyBbMV06Cj4KPiBUaGUgbmV3ZXIgR2xpYmMgYWxyZWFkeSBwcm92aWRl
ZCB3cmFwcGVyIGZvciB0aGUgc2VyaWVzIHBpZGZkIHN5c2NhbGwsCj4gc28gbGV0J3MgaW5jbHVk
ZSB0aGUgaGVhZGVyIGZpbGUgY29uZGl0aW9uYWxseS4KPgo+ICAgIyBycG0gLXEgZ2xpYmMtZGV2
ZWwKPiAgIGdsaWJjLWRldmVsLTIuMzUuOTAwMC0zMS5mYzM3LnBwYzY0bGUKPgo+ICAgIyBycG0g
LXFsIGdsaWJjLWRldmVsIHwgZ3JlcCBwaWRmZAo+ICAgL3Vzci9pbmNsdWRlL3N5cy9waWRmZC5o
Cj4KPiBUbyBnZXQgcmlkIG9mIGNvbXBpbGluZyBlcnJvciBmcm9tIGZlZG9yYS1yYXdoaWRlOgo+
Cj4gICB0c3Rfc2FmZV9tYWNyb3MuYzogSW4gZnVuY3Rpb24g4oCYc2FmZV9waWRmZF9vcGVu4oCZ
Ogo+ICAgdHN0X3NhZmVfbWFjcm9zLmM6MTM1OjE2OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRp
b24gb2YgZnVuY3Rpb24KPiDigJhwaWRmZF9vcGVu4oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0
aW9uLWRlY2xhcmF0aW9uXQo+ICAgMTM1IHwgICAgICAgICBydmFsID0gcGlkZmRfb3BlbihwaWQs
IGZsYWdzKTsKPiAgICAgICB8Cj4KPiA9PiBMaSwgZG9lcyB0aGUgcHJvYmxlbSBzdGlsbCBwZXJz
aXN0cz8gSWYgeWVzLCBJJ2QgYmUgZm9yIG1lcmdpbmcgdGhpcwo+IHBhdGNoLgo+IENvdWxkIHlv
dSBhbHNvIHRlc3QgaXQgb24gbmV3ZXN0IGdsaWJjIGluIEZlZG9yYT8KPgoKT2YgY291cnNlIHll
cywgSSBoYXZlIHJlcXVlc3RlZCBhIGZlZG9yYS1yYXdoaWRlIGZvciB0aGUgTFRQIGJ1aWxkaW5n
LApidXQgdG9tb3Jyb3cgaXMgdGhlIHNvb25lc3QgSSBjYW4gcHJvdmlkZSB0aGUgcmVzdWx0IDop
LgoKCgo+Cj4gQ3lyaWwsIEZZSSBtdXNsIG5ldmVyIGluY2x1ZGVzIGxpbnV4IGhlYWRlcnMgKFJp
Y2ggRmVsa2VyIGhhcyBhbHdheXMgYmVlbgo+IGFnYWluc3QgdGhpcyBwcmFjdGlzZSkuCj4KPiBL
aW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gWzFdCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRw
LzIwMjIwODA1MDYzNDAxLjE2NDc0NzktMi1saXdhbmdAcmVkaGF0LmNvbS8KPgo+CgotLSAKUmVn
YXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
