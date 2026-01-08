Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE93BD1D478
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 15:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767887185; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=tHT6lEf55+/5Qsgk6Uzw4BOvFztEoRa64k6pYo9HNSs=;
 b=NUIfby6dprr7SnY3tEZAXyeTB3yVn/RjVFQTOUuHejHk54FKhqYj5MeQ55ARgF289lBd1
 AwEm5sA5kbzzrIjFPTG/vG8awYP/zaYRkK3as5vgbeA/tr7ULP8q09kCIMNfTVsaLd5hTPA
 7kHqKBCRKibJTkZh2X2nFR5hAkomZCM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 327C83C66CA
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 16:46:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 326C23C636C
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 16:46:01 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 735256008C6
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 16:46:00 +0100 (CET)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A490B3F7C3
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 15:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1767887159;
 bh=Ow8f7fW7QlzJoydlBjIhyXfr/IVFCw/UhCUdIjvXsGc=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=OygDom43KGu3fN4/y8IdgmZvW567bplCa5cdg00J+UdpMlrlngPqBmNf2rvFbXA8n
 lVuYq6B0CJbPQtOBX7k2xeYKeVUMzvo5yDfrejRQ37lhehh9oSB/NZ2tg+MQguavnO
 SyT7cx0JXPvAsarPJdqKeIZGi28wTWw6RbkKaRuBnJOXq1FIW/aQqyR3pjoihwiDQc
 pR2v4V5ZQ57mCiOMP2WDfO7qN1/TvuTsz+pYCqoAy6POVP+tMOCzjzBBbzu4euDjFr
 UVHboelHuGWhvZmIKINx4GicZHEVGoWam7U93v1qWZ4otD5HooLu4vNDXC3fg91yab
 n3ltn7+KRcBDVPUHz5mYaZRHvIh+efHiTghGOpobaeiSJu9Zea+rgadFkiotw1rSM8
 d0IXjGDu33ZgGfImyZL7C4jAGMtgo0N5ib4Y4TlX8BvgTRM2lPEkxBuf7DUE7R8rhL
 h3eR6eqT1sTIq7ULhcYWyoGyIyIu9UuaTr5nCwH0EItVTmSg1KUA2J/Jfs7dHRS8Sh
 TH5v5b1iH4xI2Hx0IpEU7HDQInJX9VdP0aInD6ASZ/PG/7SUNGthXL9QXJm0Tg/2oO
 JC0Y6aCA0BQGLRlssHnqoVu2NQfKUG4cQnADE+3FfwxR5asi7X86+DdnRV3o5AePCr
 gqumSYaIqr5t9fccX0hJyMS0=
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b844098869cso259935766b.2
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 07:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767887159; x=1768491959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ow8f7fW7QlzJoydlBjIhyXfr/IVFCw/UhCUdIjvXsGc=;
 b=EnQl0dAQhXPDCH1AXmfS/NcZxQnwZ3d5u3z7kyYPR2ii4CXo2Eqonehbt8CTYjmEl+
 b+nV9Y9JTOS5bjWMQO/aSglbZeb1EMVmTJ1K6aVV8KFgANVb0LSBQnQuIVNFiaSXtKO9
 Fni0ifgBqoIl0bwa0aWCaj2z7C6OwgH1lOH/Kqme2EhtOd2PIkfKDjkzUtgTjaTXlIKo
 cTSnWWSM5qzhLFwn56QF8ZsQhqsS3YczfDqp/VjqI/L3XpkXZQlhA7u70igycCT1t+u2
 VsZzBL8ES7L1DvECrZ0NZ/hYpHsDloES/VjeBgj3RWLp7GOadqo+Ao7R5RLzNHSUuwbP
 Kd7g==
X-Gm-Message-State: AOJu0Yxw/l4IVJNvy2sRDqJRVCmUF8g3Ptwg/ANLLDDn8t60FkEEyLbx
 BihI9t16RcyDpcRHuXAG338xU3cRu3UKsRmhv9b67GtJDsTWhWe8d485UkSziANb1NvQmNBV4fn
 VHDx7rnkTOgE3Lgh81apwEm7N2wurwfhETg7/JJhu+GsiqXBQj6mIhLe01FE6268JGj5DSfhpSF
 ZyRnmFEwW9w2ByBQ+hY+nzelxaUQJwFlOuDb4UvtolNw==
X-Gm-Gg: AY/fxX593gKZQ8bNwoWSN6dyOqG6M+vbPZvTGsoHBSgyxvAQFF1xFnV4yDq2vRlilab
 JaSkCZ2CceaaZjrrBsZb+6BpM3MV/do/46/P8sKKvuxmSzeAjt1/g49Zd/53sCS7ObpyzLb+W1Q
 /w1kdTa0TNJhCtWtF/cchl7yQdtjPwoQknZSJmpzPsx6T8Jthx702ezJmHZOKPczPFUDvdk64zV
 tN+Kcl9ihVQGuAgetaOOvoxUVw=
X-Received: by 2002:a17:907:6d1a:b0:b73:99f7:8134 with SMTP id
 a640c23a62f3a-b8444fabdc4mr593989266b.45.1767887159050; 
 Thu, 08 Jan 2026 07:45:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDvkJzSReSODLfGS+ZC+F2QaNhINZVWJRi8u8hAje/TjDE0LM8tJgt56vEkAllakEMmenIO89ocB5xGWuFZhk=
X-Received: by 2002:a17:907:6d1a:b0:b73:99f7:8134 with SMTP id
 a640c23a62f3a-b8444fabdc4mr593986566b.45.1767887158552; Thu, 08 Jan 2026
 07:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20260108103606.35227-1-po-hsu.lin@canonical.com>
 <20260108121304.GA12024@pevik>
In-Reply-To: <20260108121304.GA12024@pevik>
Date: Thu, 8 Jan 2026 23:45:47 +0800
X-Gm-Features: AQt7F2pg3v9JI3eqjf4zixOAUmBmLvJUWVEXGUVhvjVII6nsIFOmxsSuHmP3740
Message-ID: <CAMy_GT-kyoY+XOULuGJWTuKDAdkwmrv_qmyoLmuMCR1utv=QYg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCHv2] listmount04.c: update struct mnt_id_req support
 to kernel >= 6.17.9
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
From: Po-Hsu Lin via ltp <ltp@lists.linux.it>
Reply-To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCA4IEphbiAyMDI2IGF0IDIwOjEzLCBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4g
d3JvdGU6Cgo+IEhpIFBvLUhzdSBMaW4sCj4KPiA+IFRoZSBrZXJuZWwgY2hhbmdlIDc4ZjBlMzNj
ZDZjOTMgKCJmcy9uYW1lc3BhY2U6IGNvcnJlY3RseSBoYW5kbGUgZXJyb3JzCj4gPiByZXR1cm5l
ZCBieSBncmFiX3JlcXVlc3RlZF9tbnRfbnMiKSBmcm9tIDYuMTggaGFzIGJlZW4gcG9ydGVkIHRv
IHVwc3RyZWFtCj4gPiA2LjE3LjkgWzFdWzJdLgo+Cj4gPiBUaGVyZWZvcmUgY2hhbmdlIHRoZSBl
eHBlY3RhdGlvbiBmcm9tID49IDYuMTggdG8gPj0gNi4xNy45IGFjY29kaW5nbHkuCj4KPiA+IFsx
XSBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvMTA0NzY4NC8KPiA+IFsyXQo+IGh0dHBzOi8vZ2l0
Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3N0YWJsZS9saW51eC5naXQvY29t
bWl0Lz9oPXY2LjE3LjkmaWQ9OGZmOTdhZGUKPgo+ID4gdjI6IGFkZCBjb21tZW50cyBmb3IgdGhp
cyBjaGFuZ2UgaW50byB0aGUgY29kZS4KPgo+ID4gU2lnbmVkLW9mZi1ieTogUG8tSHN1IExpbiA8
cG8taHN1LmxpbkBjYW5vbmljYWwuY29tPgo+ID4gLS0tCj4gPiAgLi4uL2tlcm5lbC9zeXNjYWxs
cy9saXN0bW91bnQvbGlzdG1vdW50MDQuYyAgICB8IDE4ICsrKysrKysrKysrLS0tLS0tLQo+ID4g
IDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4gPiBk
aWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9saXN0bW91bnQvbGlzdG1vdW50
MDQuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9saXN0bW91bnQvbGlzdG1vdW50MDQu
Ywo+ID4gaW5kZXggMmI4YjQ5MTAxLi41OWRhNDZjZmQgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2xpc3Rtb3VudC9saXN0bW91bnQwNC5jCj4gPiArKysgYi90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xpc3Rtb3VudC9saXN0bW91bnQwNC5jCj4gPiBAQCAtNyw2
ICs3LDEwIEBACj4gPiAgICogVmVyaWZ5IHRoYXQgbGlzdG1vdW50KCkgcmFpc2VzIHRoZSBjb3Jy
ZWN0IGVycm9ycyBhY2NvcmRpbmcgd2l0aAo+ID4gICAqIGludmFsaWQgZGF0YToKPiA+ICAgKgo+
ID4gKyAqIC0gRUJBREY6IGludmFsaWQgbW50X25zX2ZkCj4gPiArICogVGhpcyBjaGVjayB3YXMg
aW50cm9kdWNlZCBmb3Iga2VybmVsIGNvbW1pdCA3OGYwZTMzY2Q2YzkKPiAoImZzL25hbWVzcGFj
ZToKPiA+ICsgKiBjb3JyZWN0bHkgaGFuZGxlIGVycm9ycyByZXR1cm5lZCBieSBncmFiX3JlcXVl
c3RlZF9tbnRfbnMiKQo+IGludHJvZHVjZWQKPiA+ICsgKiBpbiB2Ni4xOC1yYzcgYW5kIGJhY2tw
b3J0ZWQgdG8gdjYuMTcuOS4KPgo+IFRMO0RSCj4gUGxlYXNlIGVpdGhlciBmaXggUlNUIHN5bnRh
eCBvciBtb3ZlIHRleHQgb3V0c2lkZSAvKlwgc2VjdGlvbi4KPgo+IElNSE8gdGhpcyBpcyBhbiBp
bXBsZW1lbnRhdGlvbiBkZXRhaWwsIEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBpdCBpbiB0aGUgdGVz
dAo+IGNhdGFsb2cgZG9jcyBbMV0uIEkgd291bGQganVzdCBwdXQgdGhpcyBjb21tZW50IGFib3Zl
IG1hY3JvIGRlZmluaXRpb246Cj4gI2RlZmluZQo+IEJFRk9SRV82XzE3XzkgMS4KPgo+IEFsc28g
dGhpcyBpcyBhIHdyb25nIFJTVCBzeW50YXguIEZZSSB3ZSBwYXJzZSB0aGlzIGludG8gc3BoaW54
IGRvY3MgWzFdIGFuZAo+IHRoaXMgYnJlYWtzIGZvcm1hdHRpbmcgb2YgdGhlIGxpc3Q6Cj4KPiAq
IEVCQURGOiBpbnZhbGlkIG1udF9uc19mZAo+Cj4gVGhpcyBjaGVjayB3YXMgaW50cm9kdWNlZCBm
b3Iga2VybmVsIGNvbW1pdCA3OGYwZTMzY2Q2YzkgKOKAnGZzL25hbWVzcGFjZToKPiBjb3JyZWN0
bHkgaGFuZGxlIGVycm9ycyByZXR1cm5lZCBieSBncmFiX3JlcXVlc3RlZF9tbnRfbnPigJ0pIGlu
dHJvZHVjZWQgaW4KPiB2Ni4xOC1yYzcgYW5kIGJhY2twb3J0ZWQgdG8gdjYuMTcuOS4gLSBFRkFV
TFQ6IHJlcSBvciBtbnRfaWQgYXJlCj4gdW5hY2Nlc3NpYmxlIG1lbW9yaWVzIC0gRUlOVkFMOiBp
bnZhbGlkIGZsYWdzIG9yIG1udF9pZCByZXF1ZXN0IC0gRU5PRU5UOgo+IG5vbi1leGlzdGVudCBt
b3VudCBwb2ludAo+Cj4gSWYgeW91IHJ1bjoKPiAkIGNkIGRvYzsgbWFrZSBzZXR1cCAmJiBtYWtl
Cj4KPiB5b3UnbGwgZ2V0IGxvY2FsIGJ1aWxkIG9mIHRoZSBkb2N1bWVudGF0aW9uLCBzZWUKPiAu
L2h0bWwvdXNlcnMvdGVzdF9jYXRhbG9nLmh0bWwjbGlzdG1vdW50MDQKPgo+IENvb2whCgp0aGFu
a3MgZm9yIHRoZSBpbmZvcm1hdGlvbiwgSSB3aWxsIGNvcnJlY3QgdGhpcyBhbmQgc2VuZCBhbm90
aGVyIHZlcnNpb24uCgoKCj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+IFsxXQo+IGZpbGU6Ly8v
aG9tZS9wZXZpay9pbnN0YWxsL3NyYy9sdHAuZ2l0L2RvYy9odG1sL3VzZXJzL3Rlc3RfY2F0YWxv
Zy5odG1sI2xpc3Rtb3VudDA0Cj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
