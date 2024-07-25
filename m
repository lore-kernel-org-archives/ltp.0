Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B6EFC3DA5D
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 07:12:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 728A23D1C99
	for <ltp@archiver.kernel.org>; Thu, 25 Jul 2024 09:12:07 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A8C33D199A
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 09:11:50 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0A06F140F5CA
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 09:11:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721891508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fODiBZw+1fM9afFU72i6LygVKpHAV5SbC9K80lWlhYY=;
 b=VHbQSGdg09Fpoya7w29SL/FDgSJctFeY+nmsPkfeyW9GdJIkg6lU0JVdg1EmiXYAw4dO8T
 NVm3IUCKJX5lsEZPPbtnyJtzlu04xd+Fs9Ru8YOl39Djs62c0sozuZ8EJRsTFDQI0gjSFF
 sg/IldiSh7XmOtU2bvz65Yqg6S92jHg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-MsbroizaN_aZIOP90-sATA-1; Thu, 25 Jul 2024 03:11:44 -0400
X-MC-Unique: MsbroizaN_aZIOP90-sATA-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2cb63abe6f7so826978a91.0
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 00:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721891504; x=1722496304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fODiBZw+1fM9afFU72i6LygVKpHAV5SbC9K80lWlhYY=;
 b=URAUAJjnchHir9ZPiyuTnYqVUSeyxwaCODQ7QoIgEgoTFbuF1IuVnFHNiC5oDbpPNz
 1FvEAMSNwnD66qbHFuvuTxGHS87uhSClQzXodbSWqkejVkxbjUV4LNsuUAjKcb+umdQS
 vNZDke64vVOlL2PGKSi0TlRvhP+SXttQJ8tHJSLzlqyhAyoO/Yi+0/3Fw/xhKIk6sPIG
 d8mw8kvS62vpJxojDggBJsExhJr1pasg2vfCQUlNW48v+jo2eMWNJyb5fNzEfDsv9la+
 6RFrkH9zpVPun5poVbAf/IRf9Q5PWB48RNkLumFExxjIZG3bzp0EPYUg+XZCsLK/GMNu
 1Z7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC18qD0RmJOU6QulvG/+Pzb8ze4EKp/zQ51h5c8ckHT6XYCni0vwBi1yMgKSYqz8BUSCDwzeQ8RoT/T0415VV4nYg=
X-Gm-Message-State: AOJu0Yz/CRULxwCrVhmMOBnIJO1tjWd0Pfsl71rYYIhO/9GMJpDtAnRQ
 PjcEk05rpTV06TL5ZrzjDJyiMPhXPpepbhA5FdPr3/YGtA5K9C0CVrm5ohV2JXD4jW6qnsBjHEX
 ARQXrIm9luaobSD78bsaOwkzzk2o87lkUIgC+uISkDtHFpjJ69fnFJ9ZPq3QL/Akz6f1j5HPHtO
 eoUn+KqbGW2dZ+kVVWMdml5i0=
X-Received: by 2002:a17:90a:6884:b0:2ca:a625:f9e9 with SMTP id
 98e67ed59e1d1-2cf2ec148c3mr987462a91.42.1721891503798; 
 Thu, 25 Jul 2024 00:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgNbzzd+1hKPFd0DKHqOc1OcH6RBuRuUoBdXeELVaA3CDk9VIuC4Kx5jTz6UuOBHydQorRa6uSr6I4Xo9fhS4=
X-Received: by 2002:a17:90a:6884:b0:2ca:a625:f9e9 with SMTP id
 98e67ed59e1d1-2cf2ec148c3mr987448a91.42.1721891503421; Thu, 25 Jul 2024
 00:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-ioctl_ficlone-v2-0-33075bbc117f@suse.com>
 <20240723-ioctl_ficlone-v2-1-33075bbc117f@suse.com> <ZqErzC4PMRrrk929@yuki>
In-Reply-To: <ZqErzC4PMRrrk929@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 25 Jul 2024 15:11:31 +0800
Message-ID: <CAEemH2eaTSuyD3GT5QGwq7wDUe0eX79+-XpfnzhQqN8ztJ2Vog@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/7] Add fallback definitions for lapi/fs.h
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

T24gVGh1LCBKdWwgMjUsIDIwMjQgYXQgMTI6MjnigK9BTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpIQo+ID4gZGlmZiAtLWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2Nv
bmZpZ3VyZS5hYwo+ID4gaW5kZXggMWY4Nzk2Yzg3Li40ZDQ2NmYwNTIgMTAwNjQ0Cj4gPiAtLS0g
YS9jb25maWd1cmUuYWMKPiA+ICsrKyBiL2NvbmZpZ3VyZS5hYwo+ID4gQEAgLTE3Nyw2ICsxNzcs
NyBAQCBBQ19DSEVDS19UWVBFUyhbc3RydWN0IGFjY3RfdjNdLCwsWyNpbmNsdWRlCj4gPHN5cy9h
Y2N0Lmg+XSkKPiA+ICBBQ19DSEVDS19UWVBFUyhbc3RydWN0IGFmX2FsZ19pdiwgc3RydWN0IHNv
Y2thZGRyX2FsZ10sLCxbIyBpbmNsdWRlCj4gPGxpbnV4L2lmX2FsZy5oPl0pCj4gPiAgQUNfQ0hF
Q0tfVFlQRVMoW3N0cnVjdCBmYW5vdGlmeV9ldmVudF9pbmZvX2ZpZCwgc3RydWN0Cj4gZmFub3Rp
ZnlfZXZlbnRfaW5mb19lcnJvciwKPiA+ICAgICAgICAgICAgICAgc3RydWN0IGZhbm90aWZ5X2V2
ZW50X2luZm9faGVhZGVyLCBzdHJ1Y3QKPiBmYW5vdGlmeV9ldmVudF9pbmZvX3BpZGZkXSwsLFsj
aW5jbHVkZSA8c3lzL2Zhbm90aWZ5Lmg+XSkKPiA+ICtBQ19DSEVDS19UWVBFUyhbc3RydWN0IGZp
bGVfY2xvbmVfcmFuZ2VdLCwsWyNpbmNsdWRlIDxsaW51eC9mcy5oPl0pCj4gPiAgQUNfQ0hFQ0tf
VFlQRVMoW3N0cnVjdCBmaWxlX2RlZHVwZV9yYW5nZV0sLCxbI2luY2x1ZGUgPGxpbnV4L2ZzLmg+
XSkKPiA+Cj4gPiAgQUNfQ0hFQ0tfVFlQRVMoW3N0cnVjdCBmaWxlX2hhbmRsZV0sLCxbCj4gPiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9sYXBpL2ZzLmggYi9pbmNsdWRlL2xhcGkvZnMuaAo+ID4gaW5k
ZXggNjM1OTc5YjAyLi4wZThkNjQ2ZDggMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xhcGkvZnMu
aAo+ID4gKysrIGIvaW5jbHVkZS9sYXBpL2ZzLmgKPiA+IEBAIC0yMCw2ICsyMCwxNSBAQAo+ID4g
ICNpbmNsdWRlIDxsaW1pdHMuaD4KPiA+ICAjaW5jbHVkZSAibGFwaS9hYmlzaXplLmgiCj4gPgo+
ID4gKyNpZm5kZWYgSEFWRV9GSUxFX0NMT05FX1JBTkdFCj4gPiArc3RydWN0IGZpbGVfY2xvbmVf
cmFuZ2Ugewo+ID4gKyAgICAgaW50NjRfdCBzcmNfZmQ7Cj4gPiArICAgICB1aW50NjRfdCBzcmNf
b2Zmc2V0Owo+ID4gKyAgICAgdWludDY0X3Qgc3JjX2xlbmd0aDsKPiA+ICsgICAgIHVpbnQ2NF90
IGRlc3Rfb2Zmc2V0Owo+ID4gK307Cj4gPiArI2VuZGlmCj4KPiBTaWdoLCB0aGlzIGlzIHN0aWxs
IGhvcnJpYmx5IGJyb2tlbiBldmVuIHdoZW4gSSBmaXhlZCB0aGUgbWFjcm8gdG8KPiBIQVZFX1NU
UlVDVF9GSUxFX0NMT05FX1JBTkdFIHRoYXQgaXMgYmVjYXVzZToKPgo+IGNvbW1pdCBiODU3Zjg3
MjNmMzBhNGI5NTU0YmY2YjBmZjhmYTUyZmQwN2U4YjYwCj4gQXV0aG9yOiBMaSBXYW5nIDxsaXdh
bmdAcmVkaGF0LmNvbT4KPiBEYXRlOiAgIEZyaSBBdWcgNSAxNDozNDowMSAyMDIyICswODAwCj4K
PiAgICAgbGFwaS9mc21vdW50OiByZXNvbHZlIGNvbmZsaWN0IGluIGRpZmZlcmVudCBoZWFkZXIg
ZmlsZXMKPgo+Cj4gSG93ZXZlciB0aGUgQ0kgc2VlbXMgdG8gd29yayBmaW5lIGlmIEkgcmVtb3Zl
IHRoZSBIQVZFX01PVU5UX1NFVEFUVFIKPiBjaGVjayB3aXRoOgo+Cj4gICNkZWZpbmUgTEFQSV9G
U19IX18KPgo+ICAjaW5jbHVkZSAiY29uZmlnLmgiCj4gLSNpZm5kZWYgSEFWRV9NT1VOVF9TRVRB
VFRSCj4gLSMgaWZkZWYgSEFWRV9MSU5VWF9GU19ICj4gLSMgIGluY2x1ZGUgPGxpbnV4L2ZzLmg+
Cj4gLSMgZW5kaWYKPiArCj4gKyNpZmRlZiBIQVZFX0xJTlVYX0ZTX0gKPiArIyBpbmNsdWRlIDxs
aW51eC9mcy5oPgo+ICAjZW5kaWYKPgo+ICAjaW5jbHVkZSA8c3lzL3VzZXIuaD4KPgo+Cj4gQExp
IGRvIHdlIHN0aWxsIG5lZWQgdGhhdCBpZmRlZiBvciBjYW4gd2UgZ2V0IHJpZCBvZiBpdD8KPgoK
VGhlb3JldGljYWxseSwgd2UgY2FuIHJlbW92ZSBpdCBiZWNhdXNlIHRoYXQgcHJvYmxlbSBpcyBh
ZGRyZXNzZWQgaW4KR2xpYmMtMi4zNyBieToKCgpodHRwczovL2dpdGh1Yi5jb20va3Jhai9nbGli
Yy9jb21taXQvNzc0MDU4ZDcyOTQyMjQ5ZjcxZDc0ZTdmMmI2MzlmNzcxODQxNjBhNgoKSXQgaXMg
ZXNzZW50aWFsbHkgYSBnbGliYyBidWcgd2UgZG9uJ3QgbmVlZCB0byBmaXggdGhhdCBpbiBMVFAu
CgpXZSBldmVyIGRpc2N1c3NlZCBpbgpodHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9s
dHAvMjAyMy1NYXJjaC8wMzMxMzguaHRtbAoKSG93ZXZlciwgaWYgd2Ugd2FudCBMVFAgY291bGQg
YmUgYnVpbHQgd2l0aCBhbGwgdGhlIG1pZGRsZSBnbGliYyB2ZXJzaW9ucwooMi4yMiA8IGdsaWJj
IDwgMi4zNikKdGhpcyBtaWdodCBiZSB0aGlua2luZyBvdmVyLiBCZWNhdXNlIHdlIGFubm91bmNl
IHN1cHBvcnQgdGhlIG1pbmltYWwKZ2xpYmMtdmVyc2lvbiBpcyAyLjIyLgoKCi0tIApSZWdhcmRz
LApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
