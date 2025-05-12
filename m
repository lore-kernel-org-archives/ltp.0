Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58440C3ABC3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 08:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747040327; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dHi0Sk4oFgs16aQsk+vlLzQFDWBGc6PbIrNY6tvwurA=;
 b=NqvOPKhHw2ipsd7UoAvh0vzmzQo4nDCQ0/ggTW+gmRSe0gCxwA54v9MQJVVWGDNjJykZb
 a/YHTGs+QhRYuSo2A6tEUSHSHur61zriP39JFMKtAFdhuig/79rydj+noc6dmDvt5sHPmZh
 VqxGVlKwW5BUF3FJ7cjFM+fSvmIZV4Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3EB03CC29B
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 10:58:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D17C3CC28A
 for <ltp@lists.linux.it>; Mon, 12 May 2025 10:58:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DAB0B600217
 for <ltp@lists.linux.it>; Mon, 12 May 2025 10:58:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747040301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s0gcTpuwYBf0cGIs0xnG0fks8wDAJIB01bvWYltfESE=;
 b=VgYa6vqFfIvtwHYuhWOJmM3GQGzvNQme7R+SOpOczEqcRSvfE0b3V6TM0rqVF5Y8HTE5BB
 8L45qJtC4XJPr2QoLzHc3iy/Ku2s2ycY5azZF2ZAp5Tc8BagZSs3a1SA7eHhX5CDK5o+BR
 6zfgLwbQBSBTM1U5g3TdNn29/YFBnAU=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-6mTrHBiCMDenB2GmxW7HJA-1; Mon, 12 May 2025 04:58:19 -0400
X-MC-Unique: 6mTrHBiCMDenB2GmxW7HJA-1
X-Mimecast-MFC-AGG-ID: 6mTrHBiCMDenB2GmxW7HJA_1747040298
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-30a4627dd0dso4471110a91.2
 for <ltp@lists.linux.it>; Mon, 12 May 2025 01:58:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747040298; x=1747645098;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s0gcTpuwYBf0cGIs0xnG0fks8wDAJIB01bvWYltfESE=;
 b=EJh5DWB603C9DoqBm5M1nGSCHdOmtYQLskg4bqshxv/1Xe1d/vEN6u1th7ufNE+mrE
 Y1MncECXju3dXFImosQ5hKTL5IBSe+J/oFiRdnDmpxVXHoTUaMDT9yu0VXjjB2OgQgif
 AKXrND9ml+GUnTK6j4lEOW1QWbMPVb+Ltj2LORVB10Av2KfD6F280QmZFI/Fxky5ZoVJ
 a8q8E4ebPF3KZMJVzLCOvyjKq8TuQx0/ejnZTffmwFajhKmioQCEZ88ZOtgnXnm2kv/i
 xjlDsEKul6ULWryqN/IK4kxHz7XxSl4JqrC15TJ25jGm5V2YSl7aPzeuQ/0Iju2a9hX4
 XuwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1ydy4FNeyTXokPVIhSxJAzmdu2Oy5C2w/kdi/T9p9JVhJbtTA9M4DIEzf4g1lZPQDuQs=@lists.linux.it
X-Gm-Message-State: AOJu0Yzdnvo5pUn/HHtpaMK5eatpFxr1lyNcM4OSkIbRtlBHmV5wUX1E
 FGDqpLu6SjroCVXy/v83fg0H/WW9uG75aZ1r/+zt9EAUH6Sd8CiBEU4KE7rhJNbk+GS8u+na5fg
 xjEugoDB8iuC1OenceBttSIsROZfC88Po7jFqBWI9qJ0f89PROr2SO0YsBGKKMcMlDG0tyeFHaP
 sZ/5EZTnFgYttd6asVXzTd2Rw=
X-Gm-Gg: ASbGncurGtG6X058/bqcsb2Yy0O24DdHh0qcxKSKaC63eiLYTixV10C9sikEKgJW4sf
 HMMVeXGxbx/VA8euX5jrswoaGVrHKIe7t6A7lcAitTFoDxm/PHrpOe8vty2HYql84Nk2Ymg==
X-Received: by 2002:a17:903:1948:b0:227:eb61:34b8 with SMTP id
 d9443c01a7336-22fc8b60b7emr165950835ad.25.1747040298292; 
 Mon, 12 May 2025 01:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnnAtJ7v2uOjSvRWSpHq5keq2u79w8CpS/rDo8Ddh6uCJ1usbpTBZ2nWAnaBEzcPmd1D29YU8ulWpoSmxBsZs=
X-Received: by 2002:a17:903:1948:b0:227:eb61:34b8 with SMTP id
 d9443c01a7336-22fc8b60b7emr165950625ad.25.1747040297960; Mon, 12 May 2025
 01:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250510205326.1353857-1-wegao@suse.com>
 <CAEemH2cJHz3aLRi0HeSvJWy=XvPMfJ_nv0F7=L7P2ubn8-zv5A@mail.gmail.com>
 <aCGyTkkA6iSQHNzg@yuki.lan>
In-Reply-To: <aCGyTkkA6iSQHNzg@yuki.lan>
Date: Mon, 12 May 2025 16:58:06 +0800
X-Gm-Features: AX0GCFvchxffsCxsrVgD94Ne7HPTZiET_V9PWvnP2xt8IZLO1azkxGBqj_8-45I
Message-ID: <CAEemH2fbbqZU0ir-9YQ6wh2v+6EXveOr3NRkjhk0MK1ipF_xkw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: P8IE5jlHNXSAAFccROSoVb0K8tZAwj9MTNfELAVyLk8_1747040298
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] Fix: dirtyc0w_shmem child process exit with
 error due to uninitialized lib_pid
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

T24gTW9uLCBNYXkgMTIsIDIwMjUgYXQgNDozOOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiA+IGRpZmYgLS1naXQgYS9saWIvdHN0X3Rlc3QuYyBi
L2xpYi90c3RfdGVzdC5jCj4gPiA+IGluZGV4IDJiYjQ1MTlkZC4uYjY2NjcxNWI5IDEwMDY0NAo+
ID4gPiAtLS0gYS9saWIvdHN0X3Rlc3QuYwo+ID4gPiArKysgYi9saWIvdHN0X3Rlc3QuYwo+ID4g
PiBAQCAtNTksNyArNTksNyBAQCBzdGF0aWMgY29uc3QgY2hhciAqdGlkOwo+ID4gPiAgc3RhdGlj
IGludCBpdGVyYXRpb25zID0gMTsKPiA+ID4gIHN0YXRpYyBmbG9hdCBkdXJhdGlvbiA9IC0xOwo+
ID4gPiAgc3RhdGljIGZsb2F0IHRpbWVvdXRfbXVsID0gLTE7Cj4gPiA+IC1zdGF0aWMgcGlkX3Qg
bWFpbl9waWQsIGxpYl9waWQ7Cj4gPiA+ICtzdGF0aWMgcGlkX3QgbGliX3BpZDsKPiA+ID4gIHN0
YXRpYyBpbnQgbW50cG9pbnRfbW91bnRlZDsKPiA+ID4gIHN0YXRpYyBpbnQgb3ZsX21vdW50ZWQ7
Cj4gPiA+ICBzdGF0aWMgc3RydWN0IHRpbWVzcGVjIHRzdF9zdGFydF90aW1lOyAvKiB2YWxpZCBv
bmx5IGZvciB0ZXN0IHBpZCAqLwo+ID4gPiBAQCAtNzgsNiArNzgsOCBAQCBzdHJ1Y3QgcmVzdWx0
cyB7Cj4gPiA+ICAgICAgICAgaW50IGFib3J0X2ZsYWc7Cj4gPiA+ICAgICAgICAgdW5zaWduZWQg
aW50IHJ1bnRpbWU7Cj4gPiA+ICAgICAgICAgdW5zaWduZWQgaW50IG92ZXJhbGxfdGltZTsKPiA+
ID4gKyAgICAgICBwaWRfdCBsaWJfcGlkOwo+ID4gPiArICAgICAgIHBpZF90IG1haW5fcGlkOwo+
ID4gPiAgfTsKPiA+Cj4gPiBDYW4gd2UgYXZvaWQgcG9sbHV0aW5nIHRoZSBzdHJ1Y3QgcmVzdWx0
cyB3aXRoIG1haW5fcGlkIGFuZCBsaWJfcGlkPwo+ID4gRnJvbSBhIGRlc2lnbiBzZXBhcmF0aW9u
IHN0YW5kcG9pbnQsIHJlc3VsdHMgc2hvdWxkIG9ubHkgc3RvcmUgdGVzdAo+ID4gb3V0Y29tZSBk
YXRhLCBub3QgdGVzdCBpbmZyYXN0cnVjdHVyZSBzdGF0ZS4KPgo+IFdlIGRvIGhhdmUgdGhlIGFi
b3J0X2ZsYWcgYW5kIHJ1bnRpbWUgdGhlcmUgYW5kIGNoZWNrcG9pbnRzIHVzZSB0aGUKPiBtZW1v
cnkgYWZ0ZXIgdGhpcyBzdHJ1Y3R1cmUgYXMgd2VsbCwgc28gSSB3b3VsZG4ndCBiZSBzbyBzdHJp
Y3QuCj4KCkkgdGhpbmsgd2UnZCBiZXR0ZXIgbW92ZSB0aGVtIGludG8gYSBuZXcgc3RydWN0dXJl
IGRlZGljYXRlZCB0byBzdG9yaW5nCmxpYnJhcnkgaW5mcmFzdHJ1Y3R1cmUuCgoKPgo+ID4gQXMg
TFRQIGxpYnJhcnkgYWxyZWFkeSBwcm92aWRlcyBhIHRzdF9yZWluaXQoKSBmdW5jdGlvbiBmb3Ig
Y2hpbGQKPiBwcm9jZXNzZXMKPiA+IHNwYXduZWQgdmlhIGV4ZWMoKS9leGVjbHAoKSB0byByZXN0
b3JlIHRoZWlyIHRlc3QgY29udGV4dC4KPiA+Cj4gPiBXZSBjb3VsZCBjb25zaWRlciB0d28gYXBw
cm9hY2hlczoKPiA+Cj4gPiAxLiBDcmVhdGUgYSBzZXBhcmF0ZSBJUEMgcmVnaW9uIHRvIHN0b3Jl
IGluZnJhc3RydWN0dXJlIHN0YXRlKGUuZy4sCj4gPiBtYWluX3BpZCwgbGliX3BpZCkKPiA+IGlu
IGEgbmV3IHN0cnVjdCB0c3RfbWV0YV9pbmZvLiBUaGUgY2hpbGQgY2FuIHRoZW4gYWNjZXNzIHRo
aXMgZGF0YSB2aWEKPiA+IHRzdF9yZWluaXQoKQo+ID4gd2l0aG91dCBtb2RpZnlpbmcgdGhlIHN0
cnVjdCByZXN1bHRzLgo+Cj4gSSB3b3VsZCBsaWtlIHRvIGtlZXAgYSBzaW5nbGUgSVBDIHJlZ2lv
biBiZWNhdXNlIHdlIGhhdmUgdG8gcGFzcyBhCj4gcGF0aCB0byBpdCB0byBhbGwgY2hpbGRyZW4g
dG9vLgo+Cj4gQWxzbyBnaXZlbiB0aGF0IHRoZSBtaW5pbWFsIGFtb3VudCBvZiBtZW1vcnkgd2Ug
Y2FuIGFsbG9jYXRlIGZvciBJUEMgaXMKPiBhIHBhZ2Ugd2UgY2FuIGFzIHdlbGwgaGF2ZSB0d28g
c3RydWN0dXJlcywgb25lIGZvciBkYXRhIGFuZCBvbmUgZm9yCj4gbGlicmFyeSBpbmZyYXN0cnVj
dHVyZSBiaXRzIGFuZCBwbGFjZSB0aGVzZSBzdHJ1Y3R1cmVzIGluIHRoZXJlCj4gbWFudWFsbHku
IEFsbCB3ZSBuZWVkIHRvIGRvIGlzIHRvIG1ha2Ugc3VyZSB0aGF0IHdlIHBsYWNlIHRoZW0gYXQK
PiBhbGlnbmVkIG9mZnNldHMuCj4KClllcywgdGhhdCB3YXMgbXkgdGhvdWdodCBhcyB3ZWxsLiBT
b21ldGhpbmcgbWF5YmUgbGlrZToKCiNkZWZpbmUgTFRQX01BR0lDIDB4NEM1NDUwNEQKCnN0cnVj
dCBjb250ZXh0IHsKICAgICAgICBwaWRfdCBtYWluX3BpZDsKICAgICAgICBwaWRfdCBsaWJfcGlk
OwogICAgICAgIHN0cnVjdCB0aW1lc3BlYyB0c3Rfc3RhcnRfdGltZTsKICAgICAgICAvKgogICAg
ICAgICAqIFRoaXMgaXMgc2V0IGJ5IGEgY2FsbCB0byB0c3RfYnJrKCkgd2l0aCBUQlJPSyBwYXJh
bWV0ZXIgYW5kIG1lYW5zCiAgICAgICAgICogdGhhdCB0aGUgdGVzdCBzaG91bGQgZXhpdCBpbW1l
ZGlhdGVseS4KICAgICAgICAgKi8KICAgICAgICB1bnNpZ25lZCBpbnQgcnVudGltZTsKICAgICAg
ICB1bnNpZ25lZCBpbnQgb3ZlcmFsbF90aW1lOwogICAgICAgIGludCBhYm9ydF9mbGFnOwogICAg
ICAgIGludCBtbnRwb2ludF9tb3VudGVkOwogICAgICAgIGludCBvdmxfbW91bnRlZDsKICAgICAg
ICBpbnQgdGRlYnVnOwp9OwoKc3RydWN0IHJlc3VsdHMgewogICAgICAgIGludCBwYXNzZWQ7CiAg
ICAgICAgaW50IHNraXBwZWQ7CiAgICAgICAgaW50IGZhaWxlZDsKICAgICAgICBpbnQgd2Fybmlu
Z3M7CiAgICAgICAgaW50IGJyb2tlbjsKfTsKCnN0YXRpYyBzdHJ1Y3QgaXBjX2Jsb2NrIHsKICAg
ICAgICB1bnNpZ25lZCBpbnQgbWFnaWM7CiAgICAgICAgc3RydWN0IGNvbnRleHQgY29udGV4dDsK
ICAgICAgICBzdHJ1Y3QgcmVzdWx0cyByZXN1bHRzOwogICAgICAgIGZ1dGV4X3QgZnV0ZXhlc1td
Owp9OwoKc3RhdGljIHN0cnVjdCBpcGNfYmxvY2sgKmlwYyA9IE5VTEw7CnN0YXRpYyBzdHJ1Y3Qg
Y29udGV4dCAqY29udGV4dCA9IE5VTEw7CnN0YXRpYyBzdHJ1Y3QgcmVzdWx0cyAqcmVzdWx0cyA9
IE5VTEw7CgojZGVmaW5lIFRTVF9DT05URVhUKGlwYykgKChzdHJ1Y3QgY29udGV4dCAqKSYoaXBj
KS0+Y29udGV4dCkKI2RlZmluZSBUU1RfUkVTVUxUUyhpcGMpICgoc3RydWN0IHJlc3VsdHMgKikm
KGlwYyktPnJlc3VsdHMpCiNkZWZpbmUgVFNUX0ZVVEVYRVMoaXBjKSAoKGZ1dGV4X3QgKikoaXBj
KS0+ZnV0ZXhlcykKCi4uLgoKCgo+Cj4gPiAyLiBTaW1wbHkgcGFzcyBtYWluX3BpZCBhbmQgbGli
X3BpZCB0aHJvdWdoIGVudmlyb25tZW50IHZhcmlhYmxlcyBpbiB0aGUKPiA+IGx0cCBsaWJyYXJ5
LCBhbmQgcmV0cmlldmUgdGhlbSBmcm9tIHRzdF9yZWluaXQoKSBpbiB0aGUgY2hpbGQuCj4KPiBU
aGF0IHdvdWxkIHdvcmsgdG9vLCBidXQgdGhpcyBhZGRzIG1vcmUgY29tcGxleGl0eS4KPgo+ID4g
T3IsIG1heWJlIG90aGVycyBoYXZlIHNpbXBsZXIgb3B0aW9ucy4gQ2MnaW5nIHRoZW0uCj4gPgo+
ID4gSW4gZWl0aGVyIGNhc2UsIHdlIHNob3VsZCBzZXQgJ3RzdF90ZXN0LT5jaGlsZF9uZWVkX3Jl
aW5pdCcgaW4gdGhlCj4gcGFyZW50Lgo+ID4KPiA+IEBDeXJpbCwgQFBldHIsIEkgc3VwcG9ydCBt
ZXJnaW5nIHRoaXMgZml4IGJlZm9yZSB0aGUgTWF5IHJlbGVhc2UsIGFzCj4gSeKAmXZlIGFsc28K
PiA+IGVuY291bnRlcmVkIHRoZSBzYW1lIGZhaWx1cmUgZHVyaW5nIG15IHByZS1yZWxlYXNlIHRl
c3RpbmcuCj4KPiBZZXMsIHBsZWFzZSwgaXQncyBnb29kIGVub3VnaCBldmVuIGlmIGl0J3MgZ29p
bmcgdG8gYmUgYSB0ZW1wb3JhcnkKPiBzb2x1dGlvbi4KPgoKU3VyZSwgd2UgY2FuIG1lcmdlIHRo
aXMgb25lLiBBbmQgbGF0ZXIsIEkgd2lsbCB3b3JrIG9uIGEgbmV3IHBhdGNoCnRvIHJlZmFjdG9y
IHRoZSBzdHJ1Y3R1cmUgbGlrZSBhYm92ZS4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdA
cmVkaGF0LmNvbT4KCgoKPgo+IFJldmlld2VkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3Vz
ZS5jej4KPgo+IC0tCj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KPgoKLS0gClJl
Z2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
