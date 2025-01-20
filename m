Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D840DC02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 10:22:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 695CD3C1886
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 11:22:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60AD13C01FB
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 11:21:53 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=acarmina@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 49E9822FCA2
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 11:21:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737368511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IHoBhFk3KbweYvuaPOwZXmhiMJCMXLioRNuuAgn4Llk=;
 b=EoZ0zWE+hCI0/nvYwWq5O7V52ZTRwUlu8D5ZF5HCv9kydfvL+1e4MR1MnEdUD9i1jQ4OM5
 iW/lAM6IUS6yyjKdzya4h7hwsgLrI7xXC20F4VXlYZ9Y4pszfwQIk5CroKkludpB43HWbA
 +nHt1hXBRzO0j9UQd5PmkfBy3qNC6SY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-SFrDLXh9N5OM4eAfVLSuXA-1; Mon, 20 Jan 2025 05:21:49 -0500
X-MC-Unique: SFrDLXh9N5OM4eAfVLSuXA-1
X-Mimecast-MFC-AGG-ID: SFrDLXh9N5OM4eAfVLSuXA
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2efc3292021so12340853a91.1
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 02:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737368508; x=1737973308;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IHoBhFk3KbweYvuaPOwZXmhiMJCMXLioRNuuAgn4Llk=;
 b=eooHuVy/6xD3wTsXPN8+tMDS+SMVkU/oCFJdqQTDBkrCofvv9FtgFvGtTk51cb9l3s
 LC85KOeMUsr2qqCdIe21ih6csuqXsVfkpK9HJEKF4MNNwKYxk+zx1tcx3t58nn4d+oEb
 vUVfrFldUR3u7Z/j2vyIJ15FiE/3KuK+TMiuscYcE6BTxlF8FQJwCt/uAmiK1RcZsjMW
 fXrpI60NYCy4i/yNifC0fa+7K+Mcz8d6bwMzFndTuS//8HQV31NrLxmS6EIFBOQI2JU2
 /UtRRPWzLSCkFnc3s1TaWQ8hSh+4/OJE+FdQFdQ1Lt9EZ+NxHSyWLSxhHc4Uxk2yN+G2
 hT6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCW4RjIZr19YoiLNnSeNuRSvcWAPaV71ndXR41kxBG5CN05wddVzmo203nbolLLVIINJU=@lists.linux.it
X-Gm-Message-State: AOJu0Yz/Y3+FwOP/GJoE1NsVVLaTPgxyUC8u3Aqzbd2XFLfrzvDHIJ20
 rUhM37ixPKoO9ItgTIUveU48n04WbuWtotTOGPTFoEeGcWd3u0cmjUPXoDFnU86yxiNnxWhPTMV
 9Kf7po5UtUznSTJ8wlod7iZ3nqnZHL3ljszLHufAbiKqkVm/4oimwI3q8jn4RpwQJcYyARkjGPc
 4BDSwk5Kho1pifskcSj/0D7M0=
X-Gm-Gg: ASbGncvGP9rXpVx3wuWUyFvBS3OnQ1KmiJlSx+R9BkQArFyl6Bf9xsbMUZLsPNjzHee
 GdBssjy6Y5PfPF/ZHWKfagFGgx6pw+xX0Hg1uQcf79+JYRMSmjQ==
X-Received: by 2002:a17:90b:2709:b0:2f4:434d:c7ed with SMTP id
 98e67ed59e1d1-2f782cbdfe2mr19935570a91.16.1737368508435; 
 Mon, 20 Jan 2025 02:21:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGT9MVlragAVSFjGtqBiw4+4hCVXJxerFgtZaoa8TLLSsnwx1+bvLryqZXzt6Qf85tFkmdvaTNT962ojU8zOek=
X-Received: by 2002:a17:90b:2709:b0:2f4:434d:c7ed with SMTP id
 98e67ed59e1d1-2f782cbdfe2mr19935544a91.16.1737368508116; Mon, 20 Jan 2025
 02:21:48 -0800 (PST)
MIME-Version: 1.0
References: <20250120085017.63442-1-acarmina@redhat.com>
 <20250120094634.GB798022@pevik>
In-Reply-To: <20250120094634.GB798022@pevik>
From: Alessandro Carminati <acarmina@redhat.com>
Date: Mon, 20 Jan 2025 11:21:37 +0100
X-Gm-Features: AbW1kvYFfpskNUJluSJeYzhnze0kcmDJQ5VKtx7THnVygEfVUNTAhyu4Sh4mTbg
Message-ID: <CAGegRW72RcV+L68y+3prAajqvSfHsZpTrN4+sb0ErcRZ6cOsnA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WsGbeOhvm10vLI2zOfWWI3pC0p-DoyeDYbctG19ahIk_1737368508
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cfs-scheduler/starvation.c: Skip test on realtime
 kernels
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
Cc: Alessandro Carminati <alessandro.carminati@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8gUGV0ciwKCk9uIE1vbiwgSmFuIDIwLCAyMDI1IGF0IDEwOjQ24oCvQU0gUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgo+Cj4gSGkgQWxlc3NhbmRybywKPgo+ID4gVGhpcyBj
b21taXQgaW50cm9kdWNlcyBhIGNoZWNrIGluIHRoZSBzdGFydmF0aW9uIHRlc3QgY2FzZSB0byBk
ZXRlY3QgYW5kCj4gPiBza2lwIGV4ZWN1dGlvbiBvbiByZWFsdGltZSBrZXJuZWxzLiBUaGUgdGVz
dCBpcyBkZXNpZ25lZCBmb3IgdXNlIHdpdGggdGhlCj4gPiBDb21wbGV0ZWx5IEZhaXIgU2NoZWR1
bGVyIGFuZCBwcm9kdWNlcyBtZWFuaW5nbGVzcyByZXN1bHRzIHdoZW4gcnVuIG9uCj4gPiByZWFs
dGltZSBrZXJuZWxzLgo+Cj4gPiBCeSBza2lwcGluZyB0aGUgdGVzdCBvbiByZWFsdGltZSBrZXJu
ZWxzLCB3ZSBhdm9pZCBjb25mdXNpb24gY2F1c2VkIGJ5Cj4gPiBtaXNsZWFkaW5nIHJlc3VsdHMu
Cj4KPiA+IENoYW5nZXMgaW5jbHVkZToKPiA+IC0gQWRkZWQgYSBkZXRlY3Rpb24gbWVjaGFuaXNt
IGZvciByZWFsdGltZSBrZXJuZWxzLgo+ID4gLSBMb2dpYyB0byBza2lwIHRoZSB0ZXN0IGV4ZWN1
dGlvbiBpZiB0aGUga2VybmVsIGlzIGlkZW50aWZpZWQgYXMKPiA+ICAgcmVhbHRpbWUuCj4KPiBM
R1RNLiBDb3VsZCB5b3UgcGxlYXNlIHRlc3QgaWYgc3RhcnZhdGlvbi5jIHdvcmtlZCBwcmV2aW91
c2x5Pwo+IE9yIHdhcyBpdCBhbHdheXMgYnJva2VuPwoKQmVmb3JlIHN1Ym1pdHRpbmcgdGhlIHBh
dGNoLCBJIHRlc3RlZCB0aGUgY2FzZSBpbiB2YXJpb3VzIGVudmlyb25tZW50cy4KT25lIHRoaW5n
IHRoYXQgcHV6emxlZCBtZSBmb3IgYSB3aGlsZSB3YXMgdGhlIHRlc3QncyBoaWdoIHNlbnNpdGl2
aXR5IHRvCmxhdGVuY2llcy4KV2hpbGUgaXQgd29ya3MgY29ycmVjdGx5IG9uIGJhcmUtbWV0YWwg
c3lzdGVtcyB1bmRlciB0aGUgaW50ZW5kZWQKY29uZGl0aW9ucyB3aXRoIHRoZSBDRlMgc2NoZWR1
bGVyLCBydW5uaW5nIGl0IG9uIGEgcmVhbC10aW1lIGtlcm5lbApvciBpbiBhIHZpcnR1YWxpemVk
L2VtdWxhdGVkIGVudmlyb25tZW50IGlzIGxpa2VseSB0byBjYXVzZSB0aGUKdGVzdCB0byBmYWls
LgoKVGhpcyBwYXRjaCBhZGRyZXNzZXMgdGhlIHJlYWwtdGltZSBrZXJuZWwgc2NlbmFyaW8sIHdo
aWNoIGlzIHJlbGF0aXZlbHkKZWFzaWVyIHRvIGhhbmRsZS4KSW4gYSBzZXBhcmF0ZSBSRkMgcGF0
Y2ggSSBwbGFuIHRvIHNlbmQsIEkgd291bGQgbGlrZSB0byBhc2sgdGhlCmNvbW11bml0eSBmb3Ig
Z3VpZGFuY2Ugb24gaG93IHRvIGhhbmRsZSB0aGUgdmlydHVhbGl6YXRpb24vZW11bGF0aW9uCmVu
dmlyb25tZW50IGlzc3VlLgoKPgo+IFJldmlld2VkLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4KPgo+ID4gK2ludCB0c3RfY2hlY2tfcHJlZW1wdF9ydCh2b2lkKQo+ID4gK3sKPiA+ICsg
ICAgIHN0cnVjdCB1dHNuYW1lIHV2YWw7Cj4gPiArCj4gPiArICAgICB1bmFtZSgmdXZhbCk7Cj4g
PiArICAgICBpZiAoc3Ryc3RyKHV2YWwudmVyc2lvbiwgIlBSRUVNUFRfUlQiKSkKPiA+ICsgICAg
ICAgICAgICAgcmV0dXJuIC0xOwo+ID4gKyAgICAgcmV0dXJuIDA7Cj4gPiArfQo+ID4gZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc2NoZWQvY2ZzLXNjaGVkdWxlci9zdGFydmF0aW9uLmMg
Yi90ZXN0Y2FzZXMva2VybmVsL3NjaGVkL2Nmcy1zY2hlZHVsZXIvc3RhcnZhdGlvbi5jCj4gPiBp
bmRleCA5MDE1NTZhN2IuLmM2MjBjOWMzZSAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc2NoZWQvY2ZzLXNjaGVkdWxlci9zdGFydmF0aW9uLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc2NoZWQvY2ZzLXNjaGVkdWxlci9zdGFydmF0aW9uLmMKPiA+IEBAIC04Miw2ICs4Miw5
IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4KPiA+ICAgICAgIENQVV9aRVJPKCZtYXNrKTsK
Pgo+ID4gKyAgICAgaWYgKHRzdF9jaGVja19wcmVlbXB0X3J0KCkpCj4gPiArICAgICAgICAgICAg
IHRzdF9icmsoVENPTkYsICJUaGlzIHRlc3QgaXMgbm90IGRlc2lnbmVkIGZvciB0aGUgUlQga2Vy
bmVsIik7Cj4gbml0OiBJIHdvdWxkIG1vdmUgaXQgYWJvdmUgQ1BVX1pFUk8oKS4KT2ssIEknbGwg
Zml4IGl0IGluIHRoZSB2MgoKPgo+IE5PVEU6IHdlIHNob3VsZCBhbHNvIG1vdmUgdHN0X2hhc19z
bG93X2tjb25maWcoKSBjaGVjayB0byBiZSBhdCB0aGUgdG9wIG9mCj4gc2V0dXAoKS4gQnV0IHRo
YXQncyB1bnJlbGF0ZWQuIEFsc28gYXQgbGVhc3Qgb24gVHVtYmxld2VlZCBhbmQgU0xFUyB3aGlj
aCBnZXQKPiBkZXRlY3RlZCBhcyBzbG93IGR1ZSBDT05GSUdfTEFURU5DWVRPUCB0ZXN0IHdhcyB3
b3JrZWQgYmVmb3JlLgpXYW50IG1lIHRvIGFkZHJlc3MgdGhpcyBpc3N1ZT8KCj4KPiBLaW5kIHJl
Z2FyZHMsCj4gUGV0cgo+CgpDaGVlcnMKQWxlc3NhbmRybwotLSAKLS0tCjE3MgoKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
