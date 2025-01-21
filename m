Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6143C02182
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 10:34:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A78B3C2693
	for <ltp@archiver.kernel.org>; Tue, 21 Jan 2025 11:34:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E8113C2618
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 11:34:08 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 31A4965E7E4
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 11:34:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737455646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RF6EiVTMmcRdwKegFlk3G4+0AaIqiq79cr0MlruKkzQ=;
 b=OuTsH4UtlriT7rdGKF3drkolb/82xgr3FKL0c1j8JZw7Q9pbeuVStQZ1fjVuxFIL2ECSnh
 v8oslC2gFmmwFjKkk9uvQGTmkhL+IfFOmiC8wleJwHRjq5wCZVmylskZz9NDZG++1GNn3q
 EP9qzap4q5YzuWstg/Opn0JdNCmWLpg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-NDpDYdf4OaGZz-djMN8Uig-1; Tue, 21 Jan 2025 05:34:03 -0500
X-MC-Unique: NDpDYdf4OaGZz-djMN8Uig-1
X-Mimecast-MFC-AGG-ID: NDpDYdf4OaGZz-djMN8Uig
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2f5538a2356so10152813a91.2
 for <ltp@lists.linux.it>; Tue, 21 Jan 2025 02:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737455642; x=1738060442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RF6EiVTMmcRdwKegFlk3G4+0AaIqiq79cr0MlruKkzQ=;
 b=ZG65noKuC2RJVQ7sFUeimGOOISGMQkEaueolMm/WPCBeRGujzfVTR6tS5JHN75R/iQ
 G6lFc9ByCNaN9hCqaT0QvfvU2PZ7MgsRZOfLl0WgG2tA2Hn7lKbsykVH6klLP9UaKhqY
 76a4C02wSeKasYaWJaPNJsbPTauRqd8zw533znZREjdOhS13I6p3MYvELwaDHXxjHVxc
 cpgSlVQKciVct1zpVR0UB4++Mel33t5cQ8GDgZGl7GjTWld77m70Kj+vKtzZR+0+RSOC
 r+fXS9Y26E0fyqDy0ciN39817+g5rLFDhq5O04pO9RakREblp6VBwt2reVUvO7Wl1/2d
 zf3Q==
X-Gm-Message-State: AOJu0YxycI9n4WxKHH7iQvWBWwNnC0wCGuL4u1S2IeWZ5iXYpFBF2UMV
 mnBXzv0F272DUHL2YjwAPACIMJxB7lI9wOw5WtrJ+SBSDYSybS6lcPiBhHEcuAAA8X8lfnQB1jD
 Mg1RB1nRn0/GlB1FucigtLOeJysCby4y0zKH3CEGoK8OW/bTWL30KOdSwCbpXrumICP9FOAs7VE
 qzs15Wa+skBkphtxYP+0aZXBc=
X-Gm-Gg: ASbGncu1QGx2TdYt3l6STRruoRkrzltbQiuywRLUvZry33R9vWsKuorU+VCj+FSZD1a
 SpPh2gaQ7xXepKJtqmTlg9qCnG3ofVYspDjamgBTiMKvOmQ07yB0S
X-Received: by 2002:a17:90b:2c84:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-2f782c7de14mr27225291a91.14.1737455642665; 
 Tue, 21 Jan 2025 02:34:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFku+FZkfeOiFOk3PXA5ckHzvSOxbDajyfswZaGDTWFXxSHp+BkL3sndEHAehMgMgg+EK2Tqh8Gv4j0e9Dckvs=
X-Received: by 2002:a17:90b:2c84:b0:2ef:31a9:95c6 with SMTP id
 98e67ed59e1d1-2f782c7de14mr27225268a91.14.1737455642389; Tue, 21 Jan 2025
 02:34:02 -0800 (PST)
MIME-Version: 1.0
References: <20250121082236.5247-1-liwang@redhat.com>
 <20250121092611.GB894129@pevik>
In-Reply-To: <20250121092611.GB894129@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 21 Jan 2025 18:33:50 +0800
X-Gm-Features: AbW1kvYEy0cslN5h6Mc2p4aLqtYGhJArrXi0PMVTZXRB53oU-TZOq25s1KsHvHs
Message-ID: <CAEemH2fBVPKAJCGHvpGw9-SMW0K6JAY5E2BThwizH_oksX2MGA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e2CzJZ99OGpMsUhMRRJNH84RTt7WpbHccR22IaknkQ0_1737455643
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] eventfd06: add AIO support check
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

T24gVHVlLCBKYW4gMjEsIDIwMjUgYXQgNToyNuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBKdXN0IGxpa2Ugd2hhdCB3ZSBkaWQgZm9yIGlvX3NldHVwMDEuYyB0
byBhdm9pZCBFTk9TWVMgZXJyb3I6Cj4gPiAgIGV2ZW50ZmQwNi5jOjE0MDogVEJST0s6IGlvX3Nl
dHVwKCkgZmFpbGVkOiBFTk9TWVMKPgo+ID4gU2lnbmVkLW9mZi1ieTogTGkgV2FuZyA8bGl3YW5n
QHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2V2ZW50
ZmQvZXZlbnRmZDA2LmMgfCAyICsrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KQo+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ldmVudGZkL2V2
ZW50ZmQwNi5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2V2ZW50ZmQvZXZlbnRmZDA2
LmMKPiA+IGluZGV4IDczMzlkZDQ3MS4uNDZkN2Y3M2QzIDEwMDY0NAo+ID4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9ldmVudGZkL2V2ZW50ZmQwNi5jCj4gPiArKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2V2ZW50ZmQvZXZlbnRmZDA2LmMKPiA+IEBAIC0xMzYsNiArMTM2
LDggQEAgc3RhdGljIHZvaWQgdGVzdF9wb2xsKHZvaWQpCj4gPiAgc3RhdGljIHZvaWQgc2V0dXAo
dm9pZCkKPiA+ICB7Cj4gPiAgICAgICBURVNUKGlvX3NldHVwKE1BWEVWRU5UUywgJmN0eCkpOwo+
ID4gKyAgICAgaWYgKFRTVF9SRVQgPT0gLUVOT1NZUykKPgo+IFJldmlld2VkLWJ5OiBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4KPgo+IE1heWJlIHRvIGJlIHNhZmUgdG8gY2hlY2sgYWxzbyBU
U1RfUkVUPwo+Cj4gaWYgKFRTVF9SRVQgPT0gLTEgJiYgVFRFUlJOTyA9PSBFTk9TWVMpCj4KCkkg
Z3Vlc3MgeW91IG1lYW46IGlmIChUU1RfUkVUID09IC0xICYmICBUU1RfRVJSID09IEVOT1NZUyku
CgpUeXBpY2FsbHkgdGhpcyBpcyBjb3JyZWN0IGJ1dCBoZXJlIGl0J3Mgbm90IHJpZ2h0LiBCZWNh
dXNlIGFjY29yZGluZwp0byB0aGUgaW9fc2V0dXAoMikgLSBMaW51eCBtYW4gcGFnZToKCiIuLi4g
Tm90ZSBhbHNvIHRoYXQgdGhlIGxpYmFpbyB3cmFwcGVyIGRvZXMgbm90IGZvbGxvdyB0aGUKdXN1
YWwgQyBsaWJyYXJ5IGNvbnZlbnRpb25zIGZvciBpbmRpY2F0aW5nIGVycm9yczogb24KZXJyb3Ig
aXQgcmV0dXJucyBhIG5lZ2F0ZWQgZXJyb3IgbnVtYmVyICh0aGUgbmVnYXRpdmUKb2Ygb25lIG9m
IHRoZSB2YWx1ZXMgbGlzdGVkIGluIEVSUk9SUykgLi4uICIKCgoKCj4KPiBNYXliZSAoYWZ0ZXIg
dGhlIHJlbGVhc2UpIHdlIGNvdWxkIGFkZCBuZXcgbWFjcm8gdG8gdHN0X3Rlc3RfbWFjcm9zLmgK
PiBzaW1pbGFyIHRvIFRFU1QoKSwgd2hpY2ggd291bGQgZG8gdGVzdCBsaWtlIHRoaXMgKHZhcmlh
bnQgb2YgdHN0X3N5c2NhbGwoKQo+IG1hY3JvKS4gV2UgYWxyZWFkeSBoYXZlIDEwIHRlc3RzIHdo
aWNoIGRvIHRoaXMgbWFudWFsbHkuCj4KClN1cmUuCgoKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+
Cj4gPiArICAgICAgICAgICAgIHRzdF9icmsoVENPTkYgfCBUUkVSUk5PLCAiaW9fc2V0dXAoKTog
QUlPIG5vdCBzdXBwb3J0ZWQgYnkKPiBrZXJuZWwiKTsKPiA+ICAgICAgIGlmIChUU1RfUkVUIDwg
MCkKPiA+ICAgICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgImlvX3NldHVwKCkgZmFpbGVkOiAl
cyIsCj4gdHN0X3N0cmVycm5vKC1UU1RfUkVUKSk7Cj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
