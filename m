Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D13C3ABD5
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747053280; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+fhJOoXaYKpNTjDv4XPB+RAP5CCN6l1GqFcFFwGoQh8=;
 b=LAuNiYg6sh+F8qmWxuYQmRp2kZFandfnoNPIVXSwqzIhoedcp5e92e7r/1E9QVUWfMVbG
 EArH7GWvF9HI4cWQRnR85rfLj45iezFvWV/+4KPbn7rocOAU0WbwAJSCQL1XYV6+8U8k2p5
 t+2bVZTxJtVH7vXaLRM+cscVCndJSD4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EBA83CC2AD
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 14:34:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E412C3C98D9
 for <ltp@lists.linux.it>; Mon, 12 May 2025 14:34:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E7B8B6006D9
 for <ltp@lists.linux.it>; Mon, 12 May 2025 14:34:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747053256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BfNoNR9LYfiU9IcYg/RDCYttTsVgGaiFD7GkLev+kOI=;
 b=C0rHYrZlhFMIVz8Un9aazn468GiG5cya1J9pGA9G9mnFUgZTHt/3SnqlDfiSyJ4NIsuTJu
 fbJ609EvYGlPv0E3L/6ojcQBTGC1V3Op4fetcc87y9v5/gJECrhFiHKtfrlWx2wapUWoOc
 /yYMlzvRAhKEdWl+kh9fx4HFEnAOn5Q=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-1dSCOkI5M4um4lbBcuqWvQ-1; Mon, 12 May 2025 08:34:14 -0400
X-MC-Unique: 1dSCOkI5M4um4lbBcuqWvQ-1
X-Mimecast-MFC-AGG-ID: 1dSCOkI5M4um4lbBcuqWvQ_1747053254
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22fd4e7ea48so25639295ad.3
 for <ltp@lists.linux.it>; Mon, 12 May 2025 05:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747053253; x=1747658053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BfNoNR9LYfiU9IcYg/RDCYttTsVgGaiFD7GkLev+kOI=;
 b=FSccESe30wqlfGNnZIwQUfu9ZLUDipQGWmrxXhe9COObzM/ZGVbmsMjAFEvTI2jHiL
 Gv/GroJKWhc0f25f8Fts/Ecn9M0lXNB5bkregerTg+U4fYQuwmXPJ8k689Hztxkv/DZQ
 hCSF4fxiq9M2kT0lCs+TwK30A0/Cl7de0ys4sUPlOHOyOHpQO/+Nj1tMRexTuSfxFa8z
 jqMdum81W2WoiPBvOYALscedwj3V+/ju8BYHJ+XwRkOGBG9WBirnHotnyFhlPd662NIr
 VSNfCZ3TK7SkJoKNWtKQ5CyfwYMelAiQ0idslE9ktWZJPWV6BhqlQNB1ZFIvTQcN4+9I
 a4+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUmqiZcc2Vd/WwhEiny0QQxsdQWXJJ6nzLjmvPZohXI6iMM7RargVd87CB913NljY9Rlg=@lists.linux.it
X-Gm-Message-State: AOJu0YxZedKTKLE11LM0GPwUpWbwXlfurWcPI+TbXGxR20S2UZ6iS0W2
 CLn+SVsiC8xCTFb1g+1bvVmmneODG495GxgOBlAvzWJbDc/CK2aor1zQzrzsubP2LU9qUHlZYQB
 j3JmdmUhXFe9qgTC99CK03Nm/uwgtfxQzKlA/DwCfTgZaHmv8m/KcxKjkf+itqtwIWMY7z/jZOl
 t8OXU3+zHPhPW8PzfQj7yKYgc=
X-Gm-Gg: ASbGncvw1SU7oQ9v969uGG12UrIqAIIjV/x2i2ZgtGQC0djwIZqmf5daE99fCt79XfQ
 TZbZvPbDBS6ZMiYuZkzPao2LbbbkVm5+GWWRuYdPu6kVkVlyJy5n7ubXMsXYrNJPcTWQm8g==
X-Received: by 2002:a17:902:ce8b:b0:223:44c5:4eb8 with SMTP id
 d9443c01a7336-22fc8d98ab0mr200873575ad.32.1747053253499; 
 Mon, 12 May 2025 05:34:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHDSdy708vydL0JXWl8FmD3aCVjELKD+z0ZI8C8l9ijMrRV6vBYLkLID31171VHcrtDEe2wFd5Lp6Rvng2m4o=
X-Received: by 2002:a17:902:ce8b:b0:223:44c5:4eb8 with SMTP id
 d9443c01a7336-22fc8d98ab0mr200873315ad.32.1747053253149; Mon, 12 May 2025
 05:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250510205326.1353857-1-wegao@suse.com>
 <CAEemH2cJHz3aLRi0HeSvJWy=XvPMfJ_nv0F7=L7P2ubn8-zv5A@mail.gmail.com>
 <aCGyTkkA6iSQHNzg@yuki.lan>
 <CAEemH2fbbqZU0ir-9YQ6wh2v+6EXveOr3NRkjhk0MK1ipF_xkw@mail.gmail.com>
 <aCHX9rcKFhQKbxuM@yuki.lan>
In-Reply-To: <aCHX9rcKFhQKbxuM@yuki.lan>
Date: Mon, 12 May 2025 20:34:01 +0800
X-Gm-Features: AX0GCFtt8XGaKF_V4bCrwZgBo4jGAEE4rOwbCAeiZ0WnlIIW0beLAGfk8iiz5dw
Message-ID: <CAEemH2c=34SkdSmEVvJR0Yiqv=n8jFJgYgr2L1AOL3Hxk3msqw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SRb4OVnxZ-YqdAwIAvIhYjj_hVBzVsHxta2Mx44JVS0_1747053254
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

T24gTW9uLCBNYXkgMTIsIDIwMjUgYXQgNzoxM+KAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBJIHRoaW5rIHdlJ2QgYmV0dGVyIG1vdmUgdGhlbSBp
bnRvIGEgbmV3IHN0cnVjdHVyZSBkZWRpY2F0ZWQgdG8gc3RvcmluZwo+ID4gbGlicmFyeSBpbmZy
YXN0cnVjdHVyZS4KPgo+IFNvdW5kcyBnb29kLgo+Cj4gPiA+ID4gQXMgTFRQIGxpYnJhcnkgYWxy
ZWFkeSBwcm92aWRlcyBhIHRzdF9yZWluaXQoKSBmdW5jdGlvbiBmb3IgY2hpbGQKPiA+ID4gcHJv
Y2Vzc2VzCj4gPiA+ID4gc3Bhd25lZCB2aWEgZXhlYygpL2V4ZWNscCgpIHRvIHJlc3RvcmUgdGhl
aXIgdGVzdCBjb250ZXh0Lgo+ID4gPiA+Cj4gPiA+ID4gV2UgY291bGQgY29uc2lkZXIgdHdvIGFw
cHJvYWNoZXM6Cj4gPiA+ID4KPiA+ID4gPiAxLiBDcmVhdGUgYSBzZXBhcmF0ZSBJUEMgcmVnaW9u
IHRvIHN0b3JlIGluZnJhc3RydWN0dXJlIHN0YXRlKGUuZy4sCj4gPiA+ID4gbWFpbl9waWQsIGxp
Yl9waWQpCj4gPiA+ID4gaW4gYSBuZXcgc3RydWN0IHRzdF9tZXRhX2luZm8uIFRoZSBjaGlsZCBj
YW4gdGhlbiBhY2Nlc3MgdGhpcyBkYXRhCj4gdmlhCj4gPiA+ID4gdHN0X3JlaW5pdCgpCj4gPiA+
ID4gd2l0aG91dCBtb2RpZnlpbmcgdGhlIHN0cnVjdCByZXN1bHRzLgo+ID4gPgo+ID4gPiBJIHdv
dWxkIGxpa2UgdG8ga2VlcCBhIHNpbmdsZSBJUEMgcmVnaW9uIGJlY2F1c2Ugd2UgaGF2ZSB0byBw
YXNzIGEKPiA+ID4gcGF0aCB0byBpdCB0byBhbGwgY2hpbGRyZW4gdG9vLgo+ID4gPgo+ID4gPiBB
bHNvIGdpdmVuIHRoYXQgdGhlIG1pbmltYWwgYW1vdW50IG9mIG1lbW9yeSB3ZSBjYW4gYWxsb2Nh
dGUgZm9yIElQQyBpcwo+ID4gPiBhIHBhZ2Ugd2UgY2FuIGFzIHdlbGwgaGF2ZSB0d28gc3RydWN0
dXJlcywgb25lIGZvciBkYXRhIGFuZCBvbmUgZm9yCj4gPiA+IGxpYnJhcnkgaW5mcmFzdHJ1Y3R1
cmUgYml0cyBhbmQgcGxhY2UgdGhlc2Ugc3RydWN0dXJlcyBpbiB0aGVyZQo+ID4gPiBtYW51YWxs
eS4gQWxsIHdlIG5lZWQgdG8gZG8gaXMgdG8gbWFrZSBzdXJlIHRoYXQgd2UgcGxhY2UgdGhlbSBh
dAo+ID4gPiBhbGlnbmVkIG9mZnNldHMuCj4gPiA+Cj4gPgo+ID4gWWVzLCB0aGF0IHdhcyBteSB0
aG91Z2h0IGFzIHdlbGwuIFNvbWV0aGluZyBtYXliZSBsaWtlOgo+ID4KPiA+ICNkZWZpbmUgTFRQ
X01BR0lDIDB4NEM1NDUwNEQKPgo+IEkgc3VwcG9zZSB0aGF0IHdlIHdpbGwgY2hlY2sgdGhpcyBp
biB0aGUgdHN0X3JlaW5pdCgpIHJpZ2h0PyBUaGF0IGlzCj4gbmljZSBpbXByb3ZlbWVudC4KPgoK
UmlnaHQsIHRvIHZhbGlkYXRlIHRoZSBzaGFyZWQgbWVtb3J5IHJlZ2lvbi4gQW5kIHRoZSBtYWdp
YyBudW1iZXIKMHg0QzU0NTA0RCBpcyBhY3R1YWxseSBtZWFucyAiTFRQTSIuCgoKPiA+IHN0cnVj
dCBjb250ZXh0IHsKPiA+ICAgICAgICAgcGlkX3QgbWFpbl9waWQ7Cj4gPiAgICAgICAgIHBpZF90
IGxpYl9waWQ7Cj4gPiAgICAgICAgIHN0cnVjdCB0aW1lc3BlYyB0c3Rfc3RhcnRfdGltZTsKPiA+
ICAgICAgICAgLyoKPiA+ICAgICAgICAgICogVGhpcyBpcyBzZXQgYnkgYSBjYWxsIHRvIHRzdF9i
cmsoKSB3aXRoIFRCUk9LIHBhcmFtZXRlciBhbmQKPiBtZWFucwo+ID4gICAgICAgICAgKiB0aGF0
IHRoZSB0ZXN0IHNob3VsZCBleGl0IGltbWVkaWF0ZWx5Lgo+ID4gICAgICAgICAgKi8KPiA+ICAg
ICAgICAgdW5zaWduZWQgaW50IHJ1bnRpbWU7Cj4gPiAgICAgICAgIHVuc2lnbmVkIGludCBvdmVy
YWxsX3RpbWU7Cj4gPiAgICAgICAgIGludCBhYm9ydF9mbGFnOwo+ID4gICAgICAgICBpbnQgbW50
cG9pbnRfbW91bnRlZDsKPiA+ICAgICAgICAgaW50IG92bF9tb3VudGVkOwo+ID4gICAgICAgICBp
bnQgdGRlYnVnOwo+ID4gfTsKPiA+Cj4gPiBzdHJ1Y3QgcmVzdWx0cyB7Cj4gPiAgICAgICAgIGlu
dCBwYXNzZWQ7Cj4gPiAgICAgICAgIGludCBza2lwcGVkOwo+ID4gICAgICAgICBpbnQgZmFpbGVk
Owo+ID4gICAgICAgICBpbnQgd2FybmluZ3M7Cj4gPiAgICAgICAgIGludCBicm9rZW47Cj4gPiB9
Owo+ID4KPiA+IHN0cnVjdCBpcGNfYmxvY2sgewo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgbWFn
aWM7Cj4gPiAgICAgICAgIHN0cnVjdCBjb250ZXh0IGNvbnRleHQ7Cj4gPiAgICAgICAgIHN0cnVj
dCByZXN1bHRzIHJlc3VsdHM7Cj4gPiAgICAgICAgIGZ1dGV4X3QgZnV0ZXhlc1tdOwo+ID4gfTsK
Pgo+IE1heWJlIGl0IHdvdWxkIG1ha2Ugc2Vuc2UgdG8gc3dpdGNoIHRvIHRoZSB1aW50MzJfdCBh
bmQgaW50MzJfdCBoZXJlCj4gd2hlbiB3ZSBhcmUgZG9pbmcgdGhlIGNsZWFudXAuIEN1cnJlbnRs
eSB3ZSB3ZSBjYWxsIHRzdF9yZWluaXQoKSBmcm9tIGEKPiAzMmJpdCBwcm9jZXNzIGFuZCB0aGUg
cGFyZW50IHdhcyA2NGJpdCBpdCB3b3VsZG4ndCB3b3JrIGF0IGFsbC4gV2UgZG8KPiBub3QgaGF2
ZSB0ZXN0cyBsaWtlIHRoYXQgYXQgdGhlIG1vbWVudCBidXQgd2UgbWF5IHBvc3NpYmx5IGVuZCB1
cCBpbgo+IHRoaXMgc2l0dWF0aW9uIGxhdGVyIG9uLgo+CgpHb29kIHBvaW50LgoKCj4gPiBzdGF0
aWMgc3RydWN0IGlwY19ibG9jayAqaXBjID0gTlVMTDsKPiA+IHN0YXRpYyBzdHJ1Y3QgY29udGV4
dCAqY29udGV4dCA9IE5VTEw7Cj4gPiBzdGF0aWMgc3RydWN0IHJlc3VsdHMgKnJlc3VsdHMgPSBO
VUxMOwo+ID4KPiA+ICNkZWZpbmUgVFNUX0NPTlRFWFQoaXBjKSAoKHN0cnVjdCBjb250ZXh0ICop
JihpcGMpLT5jb250ZXh0KQo+ID4gI2RlZmluZSBUU1RfUkVTVUxUUyhpcGMpICgoc3RydWN0IHJl
c3VsdHMgKikmKGlwYyktPnJlc3VsdHMpCj4gPiAjZGVmaW5lIFRTVF9GVVRFWEVTKGlwYykgKChm
dXRleF90ICopKGlwYyktPmZ1dGV4ZXMpCj4KPiBJcyB0aGVyZSBhIHJlYXNvbiBmb3IgdGhlc2Ug
bWFjcm9zPyBUaGUgdHlwZXMgc2hvdWxkIGJlIGNvcnJlY3QsIHNvCj4gdGhlcmUgc2hvdWxkIGJl
IG5vIG5lZWQgZm9yIHRoZSBjYXN0cy4KPgoKWWVzLCBqdXN0IHRvIHF1aWNrbHkgZ2V0IGNvbnRl
eHQvcmVzdWx0IGFkZHJlc3MsIGJ1dCBJIHdpbGwgcmVtb3ZlIGl0IGlmCml0J3Mgbm90IG5lY2Vz
c2FyeS4KCk5ldyByZWZhY3RvciBwYXRjaCAoYmFzZWQgb24gV2VpJ3MgZml4KSBpcyBvbiB0aGUg
d2F5LgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
