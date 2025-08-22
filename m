Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5652CA0EEB
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 05:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755841124; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Dk3dnRGuqh3p+T1NkHMzjNRj2DUnTZ1ft4otEzohqTM=;
 b=Fgb7wh+En31OErr0oJ/rChZ8wHYKX1Qc/mdXrMAuGAR9PoprOxQYfZwvhOWN5J/E7ACZ0
 XpMi4ETbBgSHMjfVryV9ymEKPlIWt/exI1PxP7ybF9yGpPgsj1fei4xrgwxq8Bd90+tZwG8
 jTy55hJE0l0dFnR8C/oNOIglRE+Bo68=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49C053CCC74
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 07:38:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD33F3C246E
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 07:38:21 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4BD0C2000D2
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 07:38:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755841099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cS4iaMjEt9ZJv0CpQmv8iWQhjIsJtUtICZ5s6oixIsY=;
 b=FW8YiTXKLTnfiTqJOT/5q7lAtz+0lP258jtYTjNr3+SH9HE7nfjhXnJvSUbZNiX/lS2KEt
 yjuPXP6yC8ddUJ4p2lt9WcMxDZoRMoUh8WERX4puJGXuqBAUKtMRbAbnPUMqAe0NbAkM5i
 4aPqrVfhgrUHFiPvxE4VRofsvM4Ouos=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-mSN5e0gzMgmIpkD7E7co4g-1; Fri, 22 Aug 2025 01:38:16 -0400
X-MC-Unique: mSN5e0gzMgmIpkD7E7co4g-1
X-Mimecast-MFC-AGG-ID: mSN5e0gzMgmIpkD7E7co4g_1755841095
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-244581187c6so24081095ad.1
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 22:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755841094; x=1756445894;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cS4iaMjEt9ZJv0CpQmv8iWQhjIsJtUtICZ5s6oixIsY=;
 b=IPsoXLvGBMhLJY8he3dHmU2D9mIFgiS8vi3KbgAEr/Mn1FoitFTHdCsHm6kG6etXfG
 qXwIJ6St8CeL/D2/u+xUzxrT3jAWBEM8T74afEOEwbUCOTu4p0a2imOUoiJReXGavwJd
 +exhMVDCrZ5lQiWbR4JDyfZsxEy6egyWC0QCqZomxLT4ZlY1u98sG5MUsu7zVvvezI/N
 RvuJwvfRevhi9J4prSQEN3R7Ub+XbrcuK36Mx/svlfilt5/lVIRaspFke0P563/h82+m
 hKuRaEFLnOwzpg9h+Wzu5pz/WjF5iZJOpuH2aJbTsI8i5EU+5vNsA1qALpT/7go0xuHh
 LinA==
X-Gm-Message-State: AOJu0YxwaBtLAY0ELoOOVmTFQqaymB3FECFBwgkBFxfXfJLwOKOH1Sl7
 hFIbHDouWnTB5BcbJ6XDbriZnK22+1i/uTdmUBX/XQpztlXerfF7tnESbcAMLYKVuvCtF+1E8zW
 K0smrmcnHKCDqXb3WwLDD2Xnlw6A79nq0k/h3bI3vcNisqL3XFQwb/2W1FAVm79vRMW6uWjUNIz
 jF/Bv1y8ZRtuZsRLGp2Q7XUjkYekFjZKK5RjzXG8eB
X-Gm-Gg: ASbGncsTlTlVtsFfAkQbgKY5hVZDRubxlM21Oe3uTwOCAIVhfOaSo6rcJ6peh92mWt3
 bbWMxMzXoK/yNC4j0drMHHQOjEAORzcDsZNKUM9c1IbF9kkGrH2zFXpya9XkG5nRhJchz+aLdU6
 1mmkeFVUYmjDkIGXB0h0VX+Q==
X-Received: by 2002:a17:902:ce02:b0:23f:f68b:fa1d with SMTP id
 d9443c01a7336-2462ef4fd9dmr23985615ad.39.1755841094510; 
 Thu, 21 Aug 2025 22:38:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYSkc4Yh6NV7MKflvXcJAnXDnCuoEauFMzREAJWm94kukBANEL+8Xp7FQq8IHETfL9TnbsGt/H7TCE3SJZWy0=
X-Received: by 2002:a17:902:ce02:b0:23f:f68b:fa1d with SMTP id
 d9443c01a7336-2462ef4fd9dmr23985475ad.39.1755841094124; Thu, 21 Aug 2025
 22:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250822034215.28533-1-wegao@suse.com>
 <20250822040501.28640-1-wegao@suse.com>
 <20250822040501.28640-3-wegao@suse.com>
In-Reply-To: <20250822040501.28640-3-wegao@suse.com>
Date: Fri, 22 Aug 2025 13:38:01 +0800
X-Gm-Features: Ac12FXxXKjHLzlElAD9PvIV0rTn9bohqNngsAHT8jdD3rEw3XrEcuVUdKoSOOtQ
Message-ID: <CAEemH2dWuJzcWC68N7AWBD6D3ir-b1WVVfZvCGUg_Rgx+6f1CQ@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0R68vnvHZgaHnVoo0OjIh1Mod8qdC_6MzekYFLpwDaM_1755841095
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 2/2] fspick01.c: Check mount point was really
 remounted read only
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

T24gRnJpLCBBdWcgMjIsIDIwMjUgYXQgMTI6MDXigK9QTSBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNv
bT4gd3JvdGU6Cgo+IEZpeGVzOiAjMTE3MQo+IFRoZSBmc3BpY2swMSB0ZXN0IGRvZXMgbm90IHRl
c3QgaWYgRlNDT05GSUdfQ01EX1JFQ09ORklHVVJFIHJlYWxseQo+IHJlY29uZmlndXJlcyB0aGUg
bW91bnQgcG9pbnQsIGUuZy4gaWYgdGhlIG1vdW50IHBvaW50IHdhcyByZWFsbHkKPiByZW1vdW50
ZWQgcmVhZCBvbmx5Lgo+Cj4gU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+
Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnNwaWNrL2ZzcGljazAxLmMgfCAy
MyArKysrKysrKysrKysrKysrKysrKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2ZzcGljay9mc3BpY2swMS5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZzcGlj
ay9mc3BpY2swMS5jCj4gaW5kZXggZDAzY2FjZDNkLi44Y2IyZDM2NjkgMTAwNjQ0Cj4gLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mc3BpY2svZnNwaWNrMDEuYwo+ICsrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZnNwaWNrL2ZzcGljazAxLmMKPiBAQCAtNiw2ICs2LDcgQEAK
PiAgICovCj4gICNpbmNsdWRlICJ0c3RfdGVzdC5oIgo+ICAjaW5jbHVkZSAibGFwaS9mc21vdW50
LmgiCj4gKyNpbmNsdWRlICJ0c3Rfc2FmZV9zdGRpby5oIgo+Cj4gICNkZWZpbmUgTU5UUE9JTlQg
ICAgICAgICAgICAgICAibW50cG9pbnQiCj4gICNkZWZpbmUgVENBU0VfRU5UUlkoX2ZsYWdzKSAg
ICB7Lm5hbWUgPSAiRmxhZyAiICNfZmxhZ3MsIC5mbGFncyA9IF9mbGFnc30KPiBAQCAtMjQsNiAr
MjUsMTIgQEAgc3RhdGljIHZvaWQgcnVuKHVuc2lnbmVkIGludCBuKQo+ICB7Cj4gICAgICAgICBz
dHJ1Y3QgdGNhc2UgKnRjID0gJnRjYXNlc1tuXTsKPiAgICAgICAgIGludCBmc3BpY2tfZmQ7Cj4g
KyAgICAgICBjaGFyIGFic3BhdGhbUEFUSF9NQVhdOwo+ICsgICAgICAgY2hhciAqdG1wZGlyID0g
dHN0X3RtcGRpcl9wYXRoKCk7Cj4gKwo+CgoKCj4gKyAgICAgICBzbnByaW50ZihhYnNwYXRoLCBz
aXplb2YoYWJzcGF0aCksICIlcy8lcyIsIHRtcGRpciwgTU5UUE9JTlQpOwo+CgpJIGp1c3QgZm91
bmQgaGVyZSB0aGF0IHlvdSByZXNvbHZlIHRoZSByZWFscGF0aCB0byBhYnNwYXRoIG1hbnVhbGx5
LAp0aGF0J3Mgbm90IG91ciBleHBlY3RhdGlvbiwgc2luY2UgdGhlIHRzdF9pc19tb3VudGVkX3Jv
L3coKSBzaG91bGQKYmUgYWJsZSB0byBoYW5kbGUgdGhhdCBhdXRvbWF0aWNhbGx5LgoKU28sIEkg
c3VwcG9zZSB3ZSBjb3VsZCBkbyB0aGlzIGluIHRoZSBsaWIgZnVuY3Rpb24sIGNhbiB5b3UgdHJ5
OgoKLS0tIGEvbGliL3RzdF9kZXZpY2UuYworKysgYi9saWIvdHN0X2RldmljZS5jCkBAIC00MzQs
NiArNDM0LDEyIEBAIHN0YXRpYyBpbnQgdHN0X21vdW50X2hhc19vcHQoY29uc3QgY2hhciAqcGF0
aCwgY29uc3QKY2hhciAqb3B0KQogICAgICAgIGNoYXIgbGluZVtQQVRIX01BWF07CiAgICAgICAg
RklMRSAqZmlsZTsKICAgICAgICBpbnQgcmV0ID0gMDsKKyAgICAgICBjaGFyIGFic3BhdGhbUEFU
SF9NQVhdOworCisgICAgICAgaWYgKCFyZWFscGF0aChwYXRoLCBhYnNwYXRoKSkgeworICAgICAg
ICAgICAgICAgdHN0X3Jlc20oVFdBUk4gfCBURVJSTk8sICJyZWFscGF0aCglcykgZmFpbGVkIiwg
cGF0aCk7CisgICAgICAgICAgICAgICByZXR1cm4gMDsKKyAgICAgICB9CgogICAgICAgIGZpbGUg
PSBTQUZFX0ZPUEVOKE5VTEwsICIvcHJvYy9tb3VudHMiLCAiciIpOwoKQEAgLTQ0Myw3ICs0NDks
NyBAQCBzdGF0aWMgaW50IHRzdF9tb3VudF9oYXNfb3B0KGNvbnN0IGNoYXIgKnBhdGgsIGNvbnN0
CmNoYXIgKm9wdCkKICAgICAgICAgICAgICAgIGlmIChzc2NhbmYobGluZSwgIiUqcyAlcyAlKnMg
JXMiLCBtb3VudF9wb2ludCwgb3B0aW9ucykgPCAyKQogICAgICAgICAgICAgICAgICAgICAgICBj
b250aW51ZTsKCi0gICAgICAgICAgICAgICBpZiAoc3RyY21wKG1vdW50X3BvaW50LCBwYXRoKSAh
PSAwKQorICAgICAgICAgICAgICAgaWYgKHN0cmNtcChtb3VudF9wb2ludCwgYWJzcGF0aCkgIT0g
MCkKICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7CgogICAgICAgICAgICAgICAgaWYg
KCFvcHQpIHsKCgoKPiArCj4gKyAgICAgICBUU1RfRVhQX1ZBTCh0c3RfaXNfbW91bnRlZF9ydyhh
YnNwYXRoKSwgMSk7Cj4KPiAgICAgICAgIFRFU1QoZnNwaWNrX2ZkID0gZnNwaWNrKEFUX0ZEQ1dE
LCBNTlRQT0lOVCwgdGMtPmZsYWdzKSk7Cj4gICAgICAgICBpZiAoZnNwaWNrX2ZkID09IC0xKSB7
Cj4gQEAgLTQ5LDggKzU2LDIyIEBAIHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgbikKPiAg
ICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4gICAgICAgICB9Cj4KPiAtICAgICAgIHRzdF9yZXMo
VFBBU1MsICIlczogZnNwaWNrKCkgcGFzc2VkIiwgdGMtPm5hbWUpOwo+ICsgICAgICAgVFNUX0VY
UF9WQUwodHN0X2lzX21vdW50ZWRfcm8oYWJzcGF0aCksIDEpOwo+ICsKPiArICAgICAgIFRFU1Qo
ZnNjb25maWcoZnNwaWNrX2ZkLCBGU0NPTkZJR19TRVRfRkxBRywgInJ3IiwgTlVMTCwgMCkpOwo+
ICsgICAgICAgaWYgKFRTVF9SRVQgPT0gLTEpIHsKPiArICAgICAgICAgICAgICAgdHN0X3JlcyhU
RkFJTCB8IFRURVJSTk8sICJmc2NvbmZpZyhGU0NPTkZJR19TRVRfRkxBRykKPiBmYWlsZWQiKTsK
PiArICAgICAgICAgICAgICAgZ290byBvdXQ7Cj4gKyAgICAgICB9Cj4KPiArICAgICAgIFRFU1Qo
ZnNjb25maWcoZnNwaWNrX2ZkLCBGU0NPTkZJR19DTURfUkVDT05GSUdVUkUsIE5VTEwsIE5VTEws
IDApKTsKPiArICAgICAgIGlmIChUU1RfUkVUID09IC0xKSB7Cj4gKyAgICAgICAgICAgICAgIHRz
dF9yZXMoVEZBSUwgfCBUVEVSUk5PLAo+ICJmc2NvbmZpZyhGU0NPTkZJR19DTURfUkVDT05GSUdV
UkUpIGZhaWxlZCIpOwo+ICsgICAgICAgICAgICAgICBnb3RvIG91dDsKPiArICAgICAgIH0KPiAr
Cj4gKyAgICAgICBUU1RfRVhQX1ZBTCh0c3RfaXNfbW91bnRlZF9ydyhhYnNwYXRoKSwgMSk7Cj4g
KyAgICAgICB0c3RfcmVzKFRQQVNTLCAiJXM6IGZzcGljaygpIHBhc3NlZCIsIHRjLT5uYW1lKTsK
PiAgb3V0Ogo+ICAgICAgICAgU0FGRV9DTE9TRShmc3BpY2tfZmQpOwo+ICB9Cj4gLS0KPiAyLjQz
LjAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
