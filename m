Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149D8C3ABD8
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 02:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747277409; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=J+SkQnhE6UJ4OR0Euwo2aOjHzbuU1F5SReUukL3GwDI=;
 b=iTo4pMwG3WxnrLrQwsDW0ntFX0jAntFxiWYSoCrd5vaTGE6fXLSDSnG2L/O6xYWZYtqxC
 vZlOhZGVU8F21kGdnLd0sGFHDkjOrF/OM9Dbvspp/5pNcUW3m5SEgeyzd9J7lgLj4CoAa45
 xsYhhTPMLLr8806qkkq+RZxKTQzQgyk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 936F33CC2F1
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 04:50:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCA853CA312
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:49:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3B60F600CE5
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:49:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747277385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VYQMAUC8zrm/5oCN+o83gDW9twBkTFUJvqSa8MFEEQo=;
 b=b2YOLtFuZmb6kxmPKRBPD5ie/+czZSX4k4P27Wjj192o29f1/E8gQXelmOWk5BIdHHDNkN
 01EhrAeCb6onpFw4T2ebKVwzap42mRt3YvCKkIuGUio4WAh5pTOI1/LEXsWNN/6iNSbJ4h
 siu74rERzCOI0o59SldRyF5Uw6Gg4ws=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-c8HbctcLNS6ta7mGKyn4tA-1; Wed, 14 May 2025 22:49:43 -0400
X-MC-Unique: c8HbctcLNS6ta7mGKyn4tA-1
X-Mimecast-MFC-AGG-ID: c8HbctcLNS6ta7mGKyn4tA_1747277383
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-30a7cc8c52eso583835a91.1
 for <ltp@lists.linux.it>; Wed, 14 May 2025 19:49:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747277383; x=1747882183;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VYQMAUC8zrm/5oCN+o83gDW9twBkTFUJvqSa8MFEEQo=;
 b=aiTpovHtUneVvAE9a3nQgxGQcs7Or1vFaZQrgx1ddWTWmDgc0uJZx1xIoqIY4CCKZb
 vskvc58hKp0ojDQUhqFlGYrbRJ6/9r5h+mQa9UDT3XSI8xDobCWXkvBf9NUUQtuZ2amp
 JbrOCeFl7+drIwUPvdqPGXHKZZt4MZawuekkqC2H4ehAkZCl45B2sIUChvU2AdlvUAAK
 fconydBZJCP+pYwPkRZHQwThxRthoiY9L0J7UCsrGaWe2dh+/TsJU/bldKoijeq3c0SS
 Vby7MUCyYgBUl74c8niUa4LtShSQLSUD5Q3wSbFSpEz1byf8b8IC7MA+IXeVAdcvh+L0
 KyNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7Vslh/SOxTmXKIdDpoAdifQ6+tJpbFXdZnTNWeUU2O3W8mENvZt5H/V4axBAzNuF6KyA=@lists.linux.it
X-Gm-Message-State: AOJu0YwG8nGTuBCEXNDVRsbfrg60xklMx15WwYNqPlK0xb2pscGEBZUh
 C22V0XYQcxDZy4AM9X4m6mEaMLS0OlY6XM0LMeV6a03KeZoYfVQuoBjqFjz08UY+worGC3eQDuB
 vckaAl9Zz7LZEnzGmC9LmFgKLxcqGyhIaC3xRjqa0/1URayx5Drbq/KMEvKX4WIfMMcO3XkmyzK
 PxKgpdg3Rk1irkWiz15qJ0zGM=
X-Gm-Gg: ASbGncufg23n0UCNiw9Ypq4Z3iVaGj4cOU76QVz6c2to0L2nz5Adfez4ChQwRFvHrss
 W0ehm8ljay2xArkvbgSRafcJKyOe28sfRUakfl5+CvuwgZmjnLaLsGLShcC/3JuXgE6hEog==
X-Received: by 2002:a17:90b:350c:b0:2ff:64a0:4a58 with SMTP id
 98e67ed59e1d1-30e2e6237d8mr6839884a91.22.1747277382590; 
 Wed, 14 May 2025 19:49:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPRheVuoeyCwiqYo7pA3WacQTGyLPTqRp0OZgFiZdJ0p+1/VBK9/MkTvlfJvc8uUNwA//37pe3um607yAWKg0=
X-Received: by 2002:a17:90b:350c:b0:2ff:64a0:4a58 with SMTP id
 98e67ed59e1d1-30e2e6237d8mr6839875a91.22.1747277382243; Wed, 14 May 2025
 19:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250414-conversions-mknod-v3-0-e08e7463bfaa@suse.com>
 <20250414-conversions-mknod-v3-2-e08e7463bfaa@suse.com>
 <20250422130645.GA934527@pevik>
In-Reply-To: <20250422130645.GA934527@pevik>
Date: Thu, 15 May 2025 10:49:29 +0800
X-Gm-Features: AX0GCFs_Zw82sg6WXGRffcLv-25_BsoaWnD1gqbh2bcTJfsqH4-C36gaIWirI4U
Message-ID: <CAEemH2eMw7XryzfETjxcop1ZwEhP5TDhSmrMET8ncrv0nPy7NQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9srmkvzMrYNDrMHOl_QQwpfcF5h3j_bQbYvuPfNOK6c_1747277383
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/8] syscalls/mknod02: Use relative path to
 avoid use of SAFE_CHDIR
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
Cc: Linux Test Project <ltp@lists.linux.it>,
 =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBcHIgMjIsIDIwMjUgYXQgOTowNuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIFJpY2FyZG8sIGFsbCwKPgo+IC4uLgo+ID4gKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9ta25vZC9ta25vZDAyLmMKPiA+IEBAIC0yMCw3ICsyMCw3IEBA
Cj4gPiAgI2RlZmluZSBNT0RFX1NHSUQgICAgMDIwMDAKPgo+ID4gICNkZWZpbmUgVEVNUF9ESVIg
InRlc3RkaXIiCj4gPiAtI2RlZmluZSBURU1QX05PREUgInRlc3Rub2RlIgo+ID4gKyNkZWZpbmUg
VEVNUF9OT0RFIFRFTVBfRElSICIvdGVzdG5vZGUiCj4KPiA+ICBzdGF0aWMgc3RydWN0IHN0YXQg
YnVmOwo+ID4gIHN0YXRpYyBzdHJ1Y3QgcGFzc3dkICp1c2VyX25vYm9keTsKPiA+IEBAIC0zNywx
NCArMzcsMTIgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPgo+ID4gIHN0YXRpYyB2b2lkIHJ1
bih2b2lkKQo+ID4gIHsKPiA+IC0gICAgIFNBRkVfQ0hESVIoVEVNUF9ESVIpOwo+ID4gICAgICAg
VFNUX0VYUF9QQVNTKG1rbm9kKFRFTVBfTk9ERSwgTU9ERTEsIDApLCAibWtub2QoJXMsICVvLCAw
KSIsIFRFTVBfTk9ERSwgTU9ERTEpOwo+Cj4gPiAgICAgICBTQUZFX1NUQVQoVEVNUF9OT0RFLCAm
YnVmKTsKPiA+ICAgICAgIFRTVF9FWFBfRVFfTEkoYnVmLnN0X2dpZCwgMCk7Cj4KPiA+ICAgICAg
IFNBRkVfVU5MSU5LKFRFTVBfTk9ERSk7Cj4gPiAtICAgICBTQUZFX0NIRElSKCIuLiIpOwo+Cj4g
SSdtIHRyeWluZyB0byBmaWd1cmUgb3V0IHdoeSB0aGUgb3JpZ2luYWwgdGVzdCB1c2VkIFNBRkVf
Q0hESVIoKS4KCkkgZ3Vlc3MgdGhhdCB3YXMgc2ltcGx5IGFkZGVkIGp1c3QgYnkgdGhlIG5ldyBB
UEkgY29udmVyc2lvbi4gSXQncwpzYWZlIHRvIHJlbW92ZSBpdAoKPiBJTUhPIG1rbm9kKCkgc2hv
dWxkIG5vdCBiZSBhZmZlY3RlZCB3aGVuIGNhbGxlZCBmcm9tIGFuIHVwcGVyIGRpcmVjdG9yeS4K
PiBAQXZpbmVzaCBATGkgZGlkIEkgb3Zlcmxvb2sgc29tZXRoaW5nIG9idmlvdXM/CgpObywgeW91
J3JlIG5vdCBvdmVybG9va2luZyBhbnl0aGluZyBvYnZpb3VzLiBta25vZCgpIGRvZXNuJ3QgY2Fy
ZQphYm91dCB0aGUgZGlyZWN0b3J5IHlvdSdyZSBpbiwgYXMgbG9uZyBhcyB0aGUgcGF0aG5hbWUg
aXMgY29ycmVjdC4KCkFuZCBzb3JyeSBmb3IgdGhlIGxhdGUsIEkgZGVmaW5pdGVseSBtaXNzZWQg
dGhpcyBlbWFpbCA6KS4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBp
bmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
