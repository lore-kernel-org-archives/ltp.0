Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DC0C54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748344780; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=15vHP/270rdwsLnl/c2pNG7Gumblmp/x9jBhQvhekng=;
 b=HpkTEnTbq3Xb8L5z2qdN/plFZunS73I28K8m5ARn6V+tKUQEOQOp42dWz20fbyxILp06s
 92AhZvMt7xw+Vvd61bAD+rmuUJbJuaGhLUE70V0daiC03hRFqRS06NtteBMpAT701eIDjrQ
 POhBUb2dzOXOu6+k52LPeXAuBKCG/PI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 47A643C5A26
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 13:19:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F3C53C01E9
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:19:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 691A514001E1
 for <ltp@lists.linux.it>; Tue, 27 May 2025 13:19:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748344756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m7kF4gXSIq/8Dqxcr2lZdkYAfUv4osMoKjWAT4AoVww=;
 b=e3pmPWPEKOKeURONj+aX1E8n7LMAtwiz6sc8lSP3NTIaLLPylUW8ND6qHZihr0bZdBhvOj
 sLbsJG4hW75inoJO9dutFZdRORJkIixolGGMKYuFUJydwxcecPVkhmK3szTsB6uNRZDPya
 Z9UXJVf8SDXzxqxnBwFxC103MKVf0HI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-rGf7lnSZMQOkHPt_Sqqu1Q-1; Tue, 27 May 2025 07:19:15 -0400
X-MC-Unique: rGf7lnSZMQOkHPt_Sqqu1Q-1
X-Mimecast-MFC-AGG-ID: rGf7lnSZMQOkHPt_Sqqu1Q_1748344754
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b0e5f28841dso1858939a12.2
 for <ltp@lists.linux.it>; Tue, 27 May 2025 04:19:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748344752; x=1748949552;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7kF4gXSIq/8Dqxcr2lZdkYAfUv4osMoKjWAT4AoVww=;
 b=rxk7qVRrSeAZLp1JQN7A/PdM/NfyvdUyutQ3Vf/5ZYo0TkQie7jFOjZPePLcpcTdzv
 pv7Kq24b/az9JfUO1p524kIrOv45KNO/jbMVETd1G38l0sewUjbFNbWHywW3QwU6ENLw
 e0ObPXEA8GA3+RULXABVtoZ7MNM6ZYe+jjy8+3MXKCK+9VJzq+H9/WhmDqt9GdPXJuHw
 Dx5IeOtYpkb68eKBfO9ZPjYt4RiSbn4/lSpftwUC/xlbnJ4LZMxwdYYJj2yJn22K4Mqn
 nDeUW8X7C3a1T4OkmwDD8knLyIaiAu6EAQdSBxLFF5x9LIjnt9cZYYEJXpyElJlybBQO
 23wA==
X-Gm-Message-State: AOJu0YzPhz7jrR4N7tRKkLe68d5FI1rCkWEEx3VmoD/4cSa9kDkv7a/Z
 kHVVYhKnW426GG3pxrPOHl9L+fOfEIm+KEgtIQkJ3XONg1SDl2bmEnNRfYDasVWx2EdqCYcCoBX
 5wtGpNQZqoe6rjlMN8jDVZxQabOrtc/EYsdqzsOZ3twkcpuFm9mKi0/lXrj7YFWmv78iR3oGytJ
 JL3v/VF3e6+WoXioPXPwiD74zbbF0gmT3wu5De0Q==
X-Gm-Gg: ASbGncuKCJa8lhpxw3VN1Xo0ae2/Lhy8YOznHFL5AoZyFJYChZYaeL1fZ4xVMvuS5o6
 aoM3tb5Wk0g+A8qc3w4apTqhSOdgkeqS2Kt8Cs572b2FhK75LkUyVGThY8t7plKdTFnax4g==
X-Received: by 2002:a17:90b:278a:b0:311:c1ec:7d0a with SMTP id
 98e67ed59e1d1-311c1ec8005mr928664a91.25.1748344752094; 
 Tue, 27 May 2025 04:19:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIsr69YbQuBdUhU81n8faMmnmSGAR4fDSeeWMcggdcSqLkFir4I3aT8cf7PmkuRb0dyOS6FS+TqExnyr5mJQc=
X-Received: by 2002:a17:90b:278a:b0:311:c1ec:7d0a with SMTP id
 98e67ed59e1d1-311c1ec8005mr928641a91.25.1748344751731; Tue, 27 May 2025
 04:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAEemH2czcnak7S50--_nh5Z2Ou+rF0=5kvY7Kx_87k_X5eEj4g@mail.gmail.com>
 <20250527111041.GB181666@pevik>
In-Reply-To: <20250527111041.GB181666@pevik>
Date: Tue, 27 May 2025 19:18:59 +0800
X-Gm-Features: AX0GCFvhHmBAHlj2N2VcalihtAUBquGTQOxvK4ggU-TlgsywwU4lC3se7nm9hUk
Message-ID: <CAEemH2cph1d1=0bXcYPQcznYttAcN9bvLYc19yCddrGya=FK1Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qqTy9PTXtKHOst1IPn3FVSNrmiNAyxwFTLN9zsJHN9s_1748344754
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Reduce .runtime for Long-Running Tests ?
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
Cc: Martin Doucha <martin.doucha@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXkgMjcsIDIwMjUgYXQgNzoxMOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIExpLAo+Cj4gPiBIZWxsbyBBbGwsCj4KPiA+IEFmdGVyIHJldmll
d2luZyBzb21lIExUUCBIVE1MIHRlc3QgcmVwb3J0cywgSSBub3RpY2VkIHRoYXQgdGhlIHRlbiB0
ZXN0cwo+ID4gYWxvbmUgdGFrZSBuZWFybHkgMjAgbWludXRlcyB0byBjb21wbGV0ZS4gRm9yIGV4
YW1wbGU6Cj4KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gPiBiaW5kMDYgICAgICAgICAgIDMw
MC4xNXMKPgo+IFRoaXMgdXNlcyBmdXp6eSBzeW5jLCBJIHdvbmRlciBpZiBpdCBjb3VsZCBiZSBz
cGVlZHVwLiBJIGd1ZXNzIGJldHRlciBsb25nZXIgcnVuCj4gdGhhbiBicmVhayB0aGUgdGVzdC4K
Pgo+ID4gbXNnc3RyZXNzMDEgICAgICAxODAuNDRzCj4gPiBmc3gyMiAgICAgICAgICAgIDE3MC40
N3MKPiA+IHB0eTA3ICAgICAgICAgICAgMTUwLjA0cwo+ID4gcHR5MDYgICAgICAgICAgICAxNTAu
MDJzCj4gPiBnZjE4ICAgICAgICAgICAgIDEyMS4wOXMKPiA+IGdmMTcgICAgICAgICAgICAgMTIw
Ljgycwo+ID4gZ2YxNiAgICAgICAgICAgICAxMjAuMTNzCj4gPiBkaXJ0eWMwd19zaG1lbSAgIDEy
MC4xMXMKPiA+IHNldHNvY2tvcHQwNyAgICAgIDc2LjQ3cwo+Cj4gPiBJbiB0b3RhbCwgcnVubmlu
ZyB0aGUgZnVsbCBsdHAtbGl0ZSBzdWl0ZSBjdXJyZW50bHkgdGFrZXMgfjFoMjBtLCB3aGljaCBp
cyBhIGJpdAo+ID4gbG9uZyBmb3IgQ0kgb3IgcHJlLW1lcmdlIHZhbGlkYXRpb24gcGlwZWxpbmVz
Lgo+Cj4gV2hhdCBpcyBsdHAtbGl0ZT8gSXMgaXQgeW91ciBpbnRlcm5hbCBDSSBmb3IgTFRQPyBi
aW5kMDYgaXMgaW4gY3ZlIGFuZCBzeXNjYWxscwo+IHJ1bnRlc3QgZmlsZXMuCgpBaCwgdGhhdCB3
YXMgY29tYmluZWQgYnkgc29tZSBnZW5lcmFsIHJ1bnRlc3QgYW5kIGtpY2tlZCBvdXQgZmV3CnN0
cmVzc2Z1bCB0ZXN0czoKClVzdWFsbHkgY29udGFpbnM6IG1hdGggaXBjIHN5c2NhbGxzIG1tIHNj
aGVkIG5wdGwgcHR5IHRyYWNpbmcgZnMgLi4uCgo+Cj4gPiBJJ20gd29uZGVyaW5nIHdoZXRoZXIg
YWxsIHRoZXNlIC5ydW50aW1lIHZhbHVlcyBhcmUgdHJ1bHkgbmVjZXNzYXJ5IHRvIHJlcHJvZHVj
ZQo+ID4gdGhlIGludGVuZGVkIGlzc3VlcyAoZS5nLiwgcmFjZSBjb25kaXRpb25zLCBmdXp6aW5n
LCBzeW5jIHRpbWluZyBpc3N1ZXMpLgo+ID4gT3IgaWYgd2UgY291bGQ6Cj4gPiAgLSBTZXQgYSBs
b3dlciB0aHJlc2hvbGQgZm9yIC5ydW50aW1lIG9uIGdlbmVyYWwtcHVycG9zZSBzdHJlc3MvZnV6
eiB0ZXN0cwo+Cj4gSSdkIGJlIGNhcmVmdWwgZm9yIGZ1enp5IHN5bmMuCj4KPiA+ICAtIEludHJv
ZHVjZSBhIHJ1bnRpbWUgX3BvbGljeV8gZm9yIGRpZmZlcmVudCBlbnZpcm9ubWVudHMgKGUuZy4s
IGZhc3QKPiA+IENJIHZzLiBmdWxsIHdlZWtseSBydW5zKQo+Cj4gT3IgZmlsdGVyIG91dCB0aGUg
bG9uZyBydW5uaW5nIHRlc3RzIGlmIHRoZSBwdXJwb3NlIGlzIGp1c3QgdG8gdGVzdCBMVFAgaXRz
ZWxmCj4gaW5zdGVhZCBvZiB0aGUgcHJvZHVjdD8KCkZpbHRlciBvdXQgc29tZSBzdHJlc3NmdWwg
dGVzdCAod2UgaGF2ZSBkb25lKSBjYW4gYmUgYWNjZXB0YWJsZSwgYnV0IEkgc3RpbGwKdGhpbmsg
c29tZSAucnVudGltZSB0ZXN0IGlzIHZhbHVhYmxlIHRvIGJlIGV4ZWN1dGVkIGluIHByb2R1Y3Qg
dmVyaWZpY2F0aW9uLgoKVGhhdCdzIHdoeSBJIHN0YXJ0ZWQgdGhpcyBlbWFpbCB0byBnZXQgc29t
ZSBpbnNwaXJhdGlvbi4KCj4KPiA+IEl0IG1pZ2h0IGJlIGJlbmVmaWNpYWwgdG8gcmV2aXNpdCB0
aGUgLnJ1bnRpbWUgdmFsdWVzIG9mIGxvbmctcnVubmluZyB0ZXN0cyBhbmQKPiA+IHNldCBhIG1p
bmltYWwgeWV0IGVmZmVjdGl2ZSBkdXJhdGlvbiB0aGF0IGJhbGFuY2VzIHJlcHJvZHVjaWJpbGl0
eSB3aXRoIHJlc291cmNlCj4gPiBlZmZpY2llbmN5LiBUaGlzIGNvdWxkIGhlbHAgc2F2ZSB0aW1l
IGFuZCBmcmVlIHVwIHRlc3QgcmVzb3VyY2VzIGVhcmxpZXIuCj4KPiBNYXliZSBNYXJ0aW4gc3Rp
bGwgaGF2ZSBWTSdzIHdoaWNoIGNhbiB0cmlnZ2VyIHRoZSBwcm9ibGVtIHRvIGV4cGVyaW1lbnQs
IGJ1dAo+IHJ1bnRpbWUgcHJvYmFibHkgZGlmZmVycyBhY3Jvc3MgYXJjaGl0ZWN0dXJlcyBhbmQg
YXZhaWxhYmxlIHJlc291cmNlcyAobnVtYmVyIG9mCj4gQ1BVIG9yIG1lbW9yeSkuCj4KPiBLaW5k
IHJlZ2FyZHMsCj4gUGV0cgo+Cj4gPiBBbnkgdGhvdWdodHMvY29tbWVudHMgd291bGQgYmUgYXBw
cmVjaWF0ZWQuCj4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
