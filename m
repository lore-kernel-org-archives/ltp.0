Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12B5C6FD18
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 11:18:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D9E43CC01D
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 13:18:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B2763C7E58
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 13:18:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0B49C10009F9
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 13:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681903112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AEq0425e7C2IseyMvX1MGc3WjzdyoTuIRMosNTaon90=;
 b=dNvKSGre72+DB53xuJzizv2HpYXuO587H8tt46YnGiQi6NhyUoVvhK4jkEOEgKHUzMa0fh
 urB2Yi8fyxgMS1knZhXDAbR2R+8CPlX2nFjSHdn+ETeXbTmNmWS4oZo2InEEF0xRsKX/m+
 ucYkDixY9rxKAluos9GCBWwROweq/GU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-D2L23iR3PqiyN3FhLceB-A-1; Wed, 19 Apr 2023 07:18:30 -0400
X-MC-Unique: D2L23iR3PqiyN3FhLceB-A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f170a1fbe7so15594055e9.2
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 04:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681903109; x=1684495109;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AEq0425e7C2IseyMvX1MGc3WjzdyoTuIRMosNTaon90=;
 b=YxU94SgTsi5Y+0beE3M6zazDdkOUU9jEH6SN0MCVIunV/BWwziaqthd1jWPYaPYfej
 9xYzS2RaRmo0DSZMCKZ6OqbAuKQ3Dq5GOq2AWIj+Fhexhk9ah+bvnbyZdtDpzhL3Zbzs
 mmygDroayNsdrd9hT+gflJ4Pm5PD/KF1QRKSPfbAuGWlDBuW+Nfx5jRiwEEpjfJcQ42e
 vdZUxzuJereRQQUog5ibGiy786BGpo/T8wrs9FZnkA5Q8Z05c7Pr4vbkI2ehDPq/CCNt
 rpss7/PgwirBkSGNmoN0vq3OT6idHMPNwgIDOMZ7OhYLlnSZMfRaNcyF8qxzogmlw1Bg
 7BRQ==
X-Gm-Message-State: AAQBX9cBa92BQKBYg+gM45dDxHy0bGT1yAu+4q2QivmCHtEXaCJJLdiv
 aB6kKAYEfl0gHnU+lijxGl5OtOse0Vfwdi1ujWxKnAYXCShra2ewheMpypsXx/HrAkf92pbFEDy
 Y/K59PgTYqVjfhlD+XB84h728XHw=
X-Received: by 2002:a5d:500d:0:b0:2f6:9bc4:76f1 with SMTP id
 e13-20020a5d500d000000b002f69bc476f1mr4602047wrt.1.1681903109476; 
 Wed, 19 Apr 2023 04:18:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350apXMtGvZMyAAbxYASacyTeh48X00Bypub1AqchFV4htJ8YvVX01mp9u1AVG8hdmwFU9yjF3UyTGhqbPRsC2vw=
X-Received: by 2002:a5d:500d:0:b0:2f6:9bc4:76f1 with SMTP id
 e13-20020a5d500d000000b002f69bc476f1mr4602027wrt.1.1681903109192; Wed, 19 Apr
 2023 04:18:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230413111434.2103422-1-pvorel@suse.cz>
 <CAEemH2fZU=b60mSD8PoZoQiJ7WQ+rhWiOqPO4XGyhS9aB2QDcA@mail.gmail.com>
 <CAEemH2eu2LCyM3g+2BcD2ZFaGSZ2R+V7-zbYc3Kg4kb=vqtiDA@mail.gmail.com>
 <20230419095939.GA2577418@pevik>
In-Reply-To: <20230419095939.GA2577418@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Apr 2023 19:18:17 +0800
Message-ID: <CAEemH2fAojMkcK2xEw+aM5oh9Csed-eOtHAs98OCydVRfyCzGQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] tst_tmpdir: Remove possible double/trailing
 slashes from TMPDIR
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

T24gV2VkLCBBcHIgMTksIDIwMjMgYXQgNTo1OeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiA+IE9uIFdlZCwgQXByIDE5LCAyMDIzIGF0IDI6NDfi
gK9QTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiA+ID4gSGkgUGV0ciwK
Pgo+ID4gPiBPbiBUaHUsIEFwciAxMywgMjAyMyBhdCA3OjE04oCvUE0gUGV0ciBWb3JlbCA8cHZv
cmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4gPiA+PiBTaW1pbGFybHkgdG8gcHJldmlvdXMgY29tbWl0
LCB3aGljaCBub3JtYWxpemVkIFRNUERJUiBmb3Igc2hlbGwgQVBJLAo+ID4gPj4gZG8gdGhlIHNh
bWUgZm9yIEMgQVBJLgo+Cj4gPiA+PiBVbmxpa2UgZm9yIHNoZWxsIEFQSSwgaGVyZSB3ZSBtb2Rp
ZnkgJFRNUERJUiBkaXJlY3RseSwgYmVjYXVzZQo+ID4gPj4gdHN0X2dldF90bXBkaXJfcm9vdCgp
IGlzIHVzZWQgbyBtb3JlIHBsYWNlcy4KPgo+ID4gPj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiA+PiAtLS0KPiA+ID4+IEZvbGxvdyB1cCBvZiB0aGUgc2Ft
ZSBjaGFuZ2UgaW4gc2hlbGwgQVBJOgo+ID4gPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRw
LzIwMjMwNDEyMDczOTUzLjE5ODM4NTctMS1wdm9yZWxAc3VzZS5jei8KPgo+ID4gPj4gS2luZCBy
ZWdhcmRzLAo+ID4gPj4gUGV0cgo+Cj4gPiA+PiAgbGliL3RzdF90bXBkaXIuYyB8IDE2ICsrKysr
KysrKysrKysrLS0KPiA+ID4+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMiBk
ZWxldGlvbnMoLSkKPgo+ID4gPj4gZGlmZiAtLWdpdCBhL2xpYi90c3RfdG1wZGlyLmMgYi9saWIv
dHN0X3RtcGRpci5jCj4gPiA+PiBpbmRleCBiNzNiNWM2NmYuLjhkYjVjNDdlOCAxMDA2NDQKPiA+
ID4+IC0tLSBhL2xpYi90c3RfdG1wZGlyLmMKPiA+ID4+ICsrKyBiL2xpYi90c3RfdG1wZGlyLmMK
PiA+ID4+IEBAIC0xMjQsMTYgKzEyNCwyOCBAQCBjaGFyICp0c3RfZ2V0X3RtcGRpcih2b2lkKQo+
Cj4gPiA+PiAgY29uc3QgY2hhciAqdHN0X2dldF90bXBkaXJfcm9vdCh2b2lkKQo+ID4gPj4gIHsK
PiA+ID4+IC0gICAgICAgY29uc3QgY2hhciAqZW52X3RtcGRpciA9IGdldGVudigiVE1QRElSIik7
Cj4gPiA+PiArICAgICAgIGNoYXIgKmVudl90bXBkaXIgPSBnZXRlbnYoIlRNUERJUiIpOwo+Cj4K
PiA+ID4gSXQgc2VlbXMgdGhhdCBtb2RpZnlpbmcgdGhlIGVudmlyb25tZW50IHZhcmlhYmxlcyBp
cyBnZW5lcmFsbHkKPiA+ID4gbm90IGEgZ29vZCBwcmFjdGljZS4KPgo+ID4gPiBUaGUgZ2V0ZW52
KCkgZnVuY3Rpb24gcmV0dXJucyBhIHBvaW50ZXIgdG8gdGhlIHZhbHVlIG9mIGFuCj4gPiA+IGVu
dmlyb25tZW50IHZhcmlhYmxlLCB3aGljaCBpcyBzdG9yZWQgaW4gdGhlIG1lbW9yeSBtYW5hZ2Vk
Cj4gPiA+IGJ5IHRoZSBzeXN0ZW0uIEFueSBhdHRlbXB0IHRvIG1vZGlmeSB0aGlzIG1lbW9yeSBk
aXJlY3RseSBjYW4KPiA+ID4gY2F1c2UgdW5leHBlY3RlZCBiZWhhdmlvciBvciBldmVuIGNyYXNo
IHRoZSBwcm9ncmFtLgo+Cj4gPiA+IEluc3RlYWQgb2YgbW9kaWZ5aW5nIHRoZSByZXR1cm4gdmFs
dWUgb2YgZ2V0ZW52KCksIGl0IGlzIHJlY29tbWVuZGVkCj4gPiA+IHRvIGNyZWF0ZSBhIGNvcHkg
b2YgdGhlIHZhbHVlIGFuZCBtb2RpZnkgdGhlIGNvcHkgaW5zdGVhZC4KPgo+IERvIHlvdSBtZWFu
IHRvIHVzZSBzdHJkdXAoKT8KPgoKWWVhaCwgc29tZXRoaW5nIGxpa2UgdGhhdCwgb3Igd2UgZGVj
bGFyZSBhIGJ1ZmZlciwgYW5kIHVzZSBzdHJjcHkoKQp0byBjb3B5IHRoZSBzdHJpbmcgcG9pbnRl
ZCB0byBieSB0aGUgcmV0dXJuIHZhbHVlIG9mIGdldGVudigpIGludG8gdGhlCmJ1ZmZlciB0aGF0
IHdlIGNhbiBzYWZlbHkgbW9kaWZ5LgoKSSBwcmVmZXIgaXQgaW4gdGhpcyB3YXkuCgoKCj4KPiBB
bHNvIG1hbiBnZXRlbnYoMykgc2F5czoKPgo+ICAgICAgICBBcyB0eXBpY2FsbHkgaW1wbGVtZW50
ZWQsIGdldGVudigpIHJldHVybnMgYSBwb2ludGVyIHRvIGEgc3RyaW5nCj4gICAgICAgIHdpdGhp
biB0aGUgZW52aXJvbm1lbnQgbGlzdC4gIFRoZSBjYWxsZXIgbXVzdCB0YWtlIGNhcmUgbm90IHRv
Cj4gICAgICAgIG1vZGlmeSB0aGlzIHN0cmluZywgc2luY2UgdGhhdCB3b3VsZCBjaGFuZ2UgdGhl
IGVudmlyb25tZW50IG9mCj4gICAgICAgIHRoZSBwcm9jZXNzLgo+Cj4gPT4gSSB3b3VsZCBub3Qg
bWluZCAkVE1QRElSIGdvdCB1cGRhdGVkIGluIHRoZSBlbnZpcm9ubWVudC4KPgo+ID4gQnR3LCB0
aGUgd2lzZSBtZXRob2QgaXMgdG8gdXNlIHNldGVudigpIGZ1bmN0aW9uIHRvIHJlc2V0Cj4gPiBl
bnZpcm9ubWVudCB2YXJpYWJsZXMgaWYgcmVhbGx5IG5lZWRlZC4KPgo+IFdlbGwsIEkgZG9uJ3Qg
a25vdyBhbnkgQyB0ZXN0IHdoaWNoIG5lZWRzIGl0IChvbmx5IE5GUyB0ZXN0cyB3aGljaCBhcmUK
PiBzaGVsbAo+IHRlc3RzKS4gQnV0IEkgd2FudGVkIHRvIGhhdmUgdGhlIHNhbWUgYmVoYXZpb3Ig
aW4gYm90aCBBUElzLgo+Cj4gPiBUaGlzIGlzIGEgZGlmZmVyZW50IHBhcnQgb2Ygc2hlbGwgQVBJ
IEkgaGF2ZSB0byBzYXkuCj4KPiBZZXMsIHRoZSBiZWhhdmlvciBpcyBzbGlnaHRseSBkaWZmZXJl
bnQgZnJvbSBzaGVsbCBBUEkgWzFdLAo+IHdoZXJlIGl0IG1vZGlmaWVzICRUU1RfVE1QRElSIChr
ZWVwICRUTVBESVIgdW50b3VjaGVkKS4KPgo+Cj4gPiA+IE9yLCB0aGUgc2ltcGxlc3Qgd2F5IEkg
Z3Vlc3MgaXMganVzdCBUQlJPSyBhbmQgdGVsbCB1c2VycyB3aHkKPiA+ID4gdGhpcyBUTVBESVIg
aXMgdW51c2FibGUuCj4KPiBJZiB5b3UgcHJlZmVyIGl0J3MgYmV0dGVyIHRvIFRCUk9LIG9uOgo+
ICogZG91YmxlIHNsYXNoZXMKPiAqIHRyYWlsaW5nIHNsYXNoCj4KPiBJIGNhbiBkbyB0aGF0LiBC
dXQgYXQgbGVhc3Qgb24gdHJhaWxpbmcgc2xhc2ggbG9va3MgdG8gbWUgcXVpdGUgc3RyaWN0Lgo+
CgotMSwgdHJhaWxpbmcgYW5kIGRvdWJsZSBzbGFzaCBhbGwgYWNjZXB0ZWQgYnkgc2hlbGwgaW4g
Y29tbWFuZCBsaW5lLAptYXliZSB3ZSBzaG91bGRuJ3Qgc2V0IGEgbW9yZSBzdHJpY3QgcG9saWN5
IHRoYW4gdGhhdC4KCgoKPgo+IFdoYXRldmVyIHBhdGggd2UgY2hvb3NlLCBJJ2QgbmVlZCBhbHNv
IHRvIHVwZGF0ZSBkb2NzLiBCVFcgdGhlIG5lZWQKPiB0byBhYnNvbHV0ZSBwYXRoIGZvciBUTVBE
SVIgaXMgb25seSBpbiBDIC0gc2hlbGwgaGFwcGlseSB0YWtlcyByZWxhdGl2ZQo+IHBhdGgKPiBh
bmQgSU1ITyBpdCdzIG5vdCBkb2N1bWVudGVkLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+
IFsxXQo+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9sdHAvcGF0Y2gvMjAy
MzA0MTIwNzM5NTMuMTk4Mzg1Ny0xLXB2b3JlbEBzdXNlLmN6Lwo+Cj4gPiA+PiAtICAgICAgIGlm
ICghZW52X3RtcGRpcikKPiA+ID4+ICsgICAgICAgaWYgKGVudl90bXBkaXIpIHsKPiA+ID4+ICsg
ICAgICAgICAgICAgICAvKiByZW1vdmUgZHVwbGljYXRlIHNsYXNoZXMgKi8KPiA+ID4+ICsgICAg
ICAgICAgICAgICBmb3IgKGNoYXIgKnAgPSBlbnZfdG1wZGlyLCAqcSA9IGVudl90bXBkaXI7ICpx
Oykgewo+ID4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKCorK3EgIT0gJy8nIHx8ICpw
ICE9ICcvJykKPiA+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKisrcCA9ICpx
Owo+ID4gPj4gKyAgICAgICAgICAgICAgIH0KPiA+ID4+ICsgICAgICAgICAgICAgICAvKiBSZW1v
dmUgc2xhc2ggb24gdGhlIGxhc3QgcGxhY2UgICovCj4gPiA+PiArICAgICAgICAgICAgICAgc2l6
ZV90IGxhc3QgPSBzdHJsZW4oZW52X3RtcGRpciktMTsKPiA+ID4+ICsgICAgICAgICAgICAgICBp
ZiAoZW52X3RtcGRpcltsYXN0XSA9PSAnLycpCj4gPiA+PiArICAgICAgICAgICAgICAgICAgICAg
ICBlbnZfdG1wZGlyW2xhc3RdID0gJ1wwJzsKPiA+ID4+ICsgICAgICAgfSBlbHNlIHsKPiA+ID4+
ICAgICAgICAgICAgICAgICBlbnZfdG1wZGlyID0gVEVNUERJUjsKPiA+ID4+ICsgICAgICAgfQo+
Cj4gPiA+PiAgICAgICAgIGlmIChlbnZfdG1wZGlyWzBdICE9ICcvJykgewo+ID4gPj4gICAgICAg
ICAgICAgICAgIHRzdF9icmttKFRCUk9LLCBOVUxMLCAiWW91IG11c3Qgc3BlY2lmeSBhbiBhYnNv
bHV0ZSAiCj4gPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJwYXRobmFtZSBm
b3IgZW52aXJvbm1lbnQgdmFyaWFibGUKPiA+ID4+IFRNUERJUiIpOwo+ID4gPj4gICAgICAgICAg
ICAgICAgIHJldHVybiBOVUxMOwo+ID4gPj4gICAgICAgICB9Cj4gPiA+PiArCj4gPiA+PiAgICAg
ICAgIHJldHVybiBlbnZfdG1wZGlyOwo+ID4gPj4gIH0KPgo+ID4gPj4gLS0KPiA+ID4+IDIuNDAu
MAo+Cj4KPgo+ID4gPiAtLQo+ID4gPiBSZWdhcmRzLAo+ID4gPiBMaSBXYW5nCj4KPgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
