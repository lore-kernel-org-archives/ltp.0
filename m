Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6ADC83F1A
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 09:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752831953; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dvgv5tQWDjM1PAFLXv5ZFbpz5cneiufC9VQIniuJNk8=;
 b=pRgqAPCabXZIXg8ZzGnkMalY1VDLMJyef50bEt+EQLXVApY4w+PWdnOquYMCEIY61QrSn
 hlMDZKScJ7n0g09OH53R28LmufXK0g8ArUssO0YqK4g7SuCtsbAB4RShek6dvrvrMPQGXY7
 SmI73gjwGiEdeIW/pMTmZPc3W2l2h74=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 489583CC3AE
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 11:45:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D8763C9AFA
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 11:45:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5F05B6EEE8E
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 11:45:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752831928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FQyXpqc266xmX5V3/4m1gPTLKrLDXJazyzxjEG7kWD0=;
 b=PsvTTHcGp2lUQMBPZEKqcJPp/9nqbyU2GFv0778dE+XuBHBpvLB7JjlZljY1kOTHca7A/w
 wAKpbGnfTcetnvxJwEQROWz0l4BWoDHhngZNVN5nH49UsRMzuFLPwjLkWRe8IAxIHhbX6o
 Ajpv8yDdysX7jz2luyAdh7vApTXhvI0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-6jw7DMn6P_aYcpIyG6CE9w-1; Fri, 18 Jul 2025 05:45:25 -0400
X-MC-Unique: 6jw7DMn6P_aYcpIyG6CE9w-1
X-Mimecast-MFC-AGG-ID: 6jw7DMn6P_aYcpIyG6CE9w_1752831925
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b0e0c573531so1458371a12.3
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 02:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752831923; x=1753436723;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FQyXpqc266xmX5V3/4m1gPTLKrLDXJazyzxjEG7kWD0=;
 b=pbQzNSUO6NqOnZcoIVDlNrhkzReTSKaKwKiQ0Lw1gjQCkF5WGE0Ql0Pyr84TxWTaz2
 cX5/KHJLGqNIgeuvcF3sZlo58c7L9rKcKbbA7rXb3Ma75OrQw54HI0rQlciI25Da/wm5
 iFrrP+6WKBy/2PuJuoCL+9n5NiYQ718wIuT3SYCOjC78soeIM33Z+V/uF12FA64o9068
 1aa4ZWJ5cpXjJW0V6Ww7PthhNY18PhF29mb97zCjAoWU0qBbH6EPumd8FDBjluuUU4PO
 8qS2ntv8OAGE775RM3qtpDtgNQRYz3sM8SA1ALcoILzBfg02FixLd8HhNF9CtB1+PhU3
 KyHA==
X-Gm-Message-State: AOJu0YxV+Thp0cuXZUEgWw2ecEudQT4eEQgDZgysBcaFyYbgzs/jhmaP
 grBGyrTRTnBXGfOQsTuWU2K5YChu3L7/Z48JKxy0XLwHNmitteu3n9yaV8DxeMAsOaKCDAkYckN
 V7DxqDqk7QrohsLPF2ovvRdxW5VIEdah3hiAXo6cAHgrcOaoYwHaqPjYEosGMH3n8df3HOxRb+O
 VTEWu/sTwNy54TfiaofqXA1BjLHPc=
X-Gm-Gg: ASbGnct00U2KNGA+5JQM7U6zX6BS7Q13Xb+j/W4NazgMAZU3ONTExvOGh7GRj99L11C
 qC+c1bNs7+3Z9HpXHrd1xSeKEY7NBNCkauxEf/h2SB1brXI59C0TorbnrPAQV/0NARuP8KCt1Hp
 F+QY5t+MweQy8EnT0qgyg0AQ==
X-Received: by 2002:a17:903:3503:b0:23c:7c3b:4c61 with SMTP id
 d9443c01a7336-23e24ec73damr130404645ad.8.1752831923447; 
 Fri, 18 Jul 2025 02:45:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGu9Dw/gjUCvPmXY7UaTOgwIQuLTF8toJ3x2JO4VD5HErb3+sRb7B+p21HswBBntCqnIjSketxakbORp3ULqB4=
X-Received: by 2002:a17:903:3503:b0:23c:7c3b:4c61 with SMTP id
 d9443c01a7336-23e24ec73damr130404205ad.8.1752831922965; Fri, 18 Jul 2025
 02:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250718090523.1411073-1-pvorel@suse.cz>
In-Reply-To: <20250718090523.1411073-1-pvorel@suse.cz>
Date: Fri, 18 Jul 2025 17:45:09 +0800
X-Gm-Features: Ac12FXzgVdPkW8RCM1NmO5yMhnlbvUjcaXT10WWy553PXzoIhBwti_8r1X0t8cQ
Message-ID: <CAEemH2eeyE4Lt5HEXSoQVo9fVmgyJxQgZau29gMOTibDSXHDxw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SipxUqZbS1BOEK8Abrtyd_IT-Z99nbrUTxb4ysHiSIY_1752831925
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] getrlimit03: Simplify TCONF code
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

SGkgUGV0ciwKCk9uIEZyaSwgSnVsIDE4LCAyMDI1IGF0IDU6MDXigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEVOT1NZUyBjaGVja3MgYWRkZWQgaW4gZmFjNzgzYjVk
NiBhbmQgZDA3MWRlMDJlOCBhcmUgdmVyYm9zZSwgdXNlCj4gdHN0X3N5c2NhbGwoKSB0byBoYW5k
bGUgRU5PU1lTLgo+Cj4gQWxzbyBjaGVjayBmb3IgX19OUl9nZXRybGltaXQgY2F1c2VkIFRDT05G
IG1lc3NhZ2UgYmVpbmcgcHJpbnRlZCBtb3JlCj4gdGltZXMgKFJMSU1fTkxJTUlUUyA9PiAxNiBv
biB4ODZfNjQpLCB3aGljaCBpcyBhbHNvIGZpeGVkIGJ5IHVzaW5nCj4gdHN0X3N5c2NhbGwoKS4K
Pgo+IEJlY2F1c2UgaXQgc2hvdWxkIGJlIHNhZmUgdG8gbm90IHVzZSBzcGVjaWZpYyBlcnJubyB2
YXJpYWJsZXMgcmVtb3ZlCj4gZXJybm9fbCBhbmQgZXJybm9fdWwuCj4KPiBTaWduZWQtb2ZmLWJ5
OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiAtLS0KPiBIaSBhbGwsCj4KPiBAVGllemh1
IGNhbiB5b3UgcGxlYXNlIHRlc3QgdGhpcyBwYXRjaD8KPiBATGkgSG9wZSBJIGRpZCBub3Qgb3Zl
cmxvb2sgYW55dGhpbmcuCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gIC4uLi9rZXJuZWwv
c3lzY2FsbHMvZ2V0cmxpbWl0L2dldHJsaW1pdDAzLmMgICB8IDIzICsrKystLS0tLS0tLS0tLS0t
LS0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRybGltaXQvZ2V0cmxp
bWl0MDMuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRybGltaXQvZ2V0cmxpbWl0
MDMuYwo+IGluZGV4IDg0NmVmM2NlZDYuLmEyZGQwY2E3OWMgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9nZXRybGltaXQvZ2V0cmxpbWl0MDMuYwo+ICsrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0cmxpbWl0L2dldHJsaW1pdDAzLmMKPiBAQCAtNzcsNyAr
NzcsNyBAQCBzdHJ1Y3QgcmxpbWl0X3Vsb25nIHsKPgo+ICBzdGF0aWMgaW50IGdldHJsaW1pdF91
bG9uZyhpbnQgcmVzb3VyY2UsIHN0cnVjdCBybGltaXRfdWxvbmcgKnJsaW0pCj4gIHsKPiAtICAg
ICAgIHJldHVybiBzeXNjYWxsKF9fTlJfZ2V0cmxpbWl0X3Vsb25nLCByZXNvdXJjZSwgcmxpbSk7
Cj4gKyAgICAgICByZXR1cm4gdHN0X3N5c2NhbGwoX19OUl9nZXRybGltaXRfdWxvbmcsIHJlc291
cmNlLCBybGltKTsKPiAgfQo+Cj4gIGNvbnN0IGxvbmcgUkxJTV9JTkZJTklUWV9MID0gTE9OR19N
QVg7Cj4gQEAgLTkwLDcgKzkwLDcgQEAgc3RydWN0IHJsaW1pdF9sb25nIHsKPgo+ICBzdGF0aWMg
aW50IGdldHJsaW1pdF9sb25nKGludCByZXNvdXJjZSwgc3RydWN0IHJsaW1pdF9sb25nICpybGlt
KQo+ICB7Cj4gLSAgICAgICByZXR1cm4gc3lzY2FsbChfX05SX2dldHJsaW1pdCwgcmVzb3VyY2Us
IHJsaW0pOwo+ICsgICAgICAgcmV0dXJuIHRzdF9zeXNjYWxsKF9fTlJfZ2V0cmxpbWl0LCByZXNv
dXJjZSwgcmxpbSk7Cj4KCkkgZ3Vlc3MgYXQgbGVhc3Qgd2Ugc2hvdWxkIGF2b2lkIHVzaW5nIHRz
dF9zeXNjYWxsKCkgaW4gZ2VybGltaXRfbG9uZywKYmVjYXVzZSBpdCB3aWxsIG1pc3MgKGJyZWFr
IHdpdGggVENPTkYpIHRoZSBuZXh0IGdldHJsaW1pdF91bG9uZyB0ZXN0cwp3aGVuIHJ1bm5pbmcg
YW4gYWFyY2gzMiB1c2VyIGJpbmFyeSBvbiA2NGJpdCBrZXJuZWw6Cmh0dHBzOi8vZ2l0aHViLmNv
bS9saW51eC10ZXN0LXByb2plY3QvbHRwL2NvbW1pdC9mYWM3ODNiNWQ2NjMxZWZhNzBkMmVhMzI1
NzE0Mjc2M2Q5NDRiYTMyCgoKCgo+ICB9Cj4gICNlbmRpZgo+Cj4gQEAgLTE0NywxMiArMTQ3LDEw
IEBAIHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgcmVzb3VyY2UpCj4KPiAgICAgICAgIHN0
cnVjdCBybGltaXRfdWxvbmcgcmxpbV91bDsKPiAgICAgICAgIGludCByZXRfdWw7Cj4gLSAgICAg
ICBpbnQgZXJybm9fdWw7Cj4KPiAgI2lmZGVmIFNJR05FRF9HRVRSTElNSVQKPiAgICAgICAgIHN0
cnVjdCBybGltaXRfbG9uZyBybGltX2w7Cj4gICAgICAgICBpbnQgcmV0X2w7Cj4gLSAgICAgICBp
bnQgZXJybm9fbDsKPiAgI2VuZGlmCj4KPiAgICAgICAgIGVycm5vID0gMDsKPiBAQCAtMTYxLDE1
ICsxNTksOCBAQCBzdGF0aWMgdm9pZCBydW4odW5zaWduZWQgaW50IHJlc291cmNlKQo+Cj4gICAg
ICAgICBlcnJubyA9IDA7Cj4gICAgICAgICByZXRfdWwgPSBnZXRybGltaXRfdWxvbmcocmVzb3Vy
Y2UsICZybGltX3VsKTsKPiAtICAgICAgIGVycm5vX3VsID0gZXJybm87Cj4gLSAgICAgICBpZiAo
ZXJybm9fdWwgPT0gRU5PU1lTKSB7Cj4gLSAgICAgICAgICAgICAgIHRzdF9yZXMoVENPTkYgfCBU
RVJSTk8sCj4gLSAgICAgICAgICAgICAgICAgICAgICAgIiVzIG5vdCBpbXBsZW1lbnRlZCIsIF9f
TlJfZ2V0cmxpbWl0X3Vsb25nX3N0cik7Cj4gLSAgICAgICAgICAgICAgIHRlc3QudGNudCA9IDE7
Cj4gLSAgICAgICAgICAgICAgIHJldHVybjsKPiAtICAgICAgIH0KPgo+IC0gICAgICAgaWYgKGNv
bXBhcmVfcmV0dmFsKHJlc291cmNlLCByZXRfdTY0LCBlcnJub191NjQsIHJldF91bCwgZXJybm9f
dWwsCj4gKyAgICAgICBpZiAoY29tcGFyZV9yZXR2YWwocmVzb3VyY2UsIHJldF91NjQsIGVycm5v
X3U2NCwgcmV0X3VsLCBlcnJubywKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX05SX2dl
dHJsaW1pdF91bG9uZ19zdHIpIHx8Cj4gICAgICAgICAgICAgY29tcGFyZV91NjRfdWxvbmcocmVz
b3VyY2UsIHJsaW1fdTY0LnJsaW1fY3VyLAo+IHJsaW1fdWwucmxpbV9jdXIsCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgInJsaW1fY3VyIikgfHwKPiBAQCAtMTgzLDE0ICsxNzQsOCBA
QCBzdGF0aWMgdm9pZCBydW4odW5zaWduZWQgaW50IHJlc291cmNlKQo+ICAjaWZkZWYgU0lHTkVE
X0dFVFJMSU1JVAo+ICAgICAgICAgZXJybm8gPSAwOwo+ICAgICAgICAgcmV0X2wgPSBnZXRybGlt
aXRfbG9uZyhyZXNvdXJjZSwgJnJsaW1fbCk7Cj4gLSAgICAgICBlcnJub19sID0gZXJybm87Cj4g
LSAgICAgICBpZiAoZXJybm9fbCA9PSBFTk9TWVMpIHsKPiAtICAgICAgICAgICAgICAgdHN0X3Jl
cyhUQ09ORiB8IFRFUlJOTywKPiAtICAgICAgICAgICAgICAgICAgICAgICAiX19OUl9nZXRybGlt
aXQoJWQpIG5vdCBpbXBsZW1lbnRlZCIsCj4gX19OUl9nZXRybGltaXQpOwo+IC0gICAgICAgICAg
ICAgICByZXR1cm47Cj4gLSAgICAgICB9Cj4KPiAtICAgICAgIGlmIChjb21wYXJlX3JldHZhbChy
ZXNvdXJjZSwgcmV0X3U2NCwgZXJybm9fdTY0LCByZXRfbCwgZXJybm9fbCwKPiArICAgICAgIGlm
IChjb21wYXJlX3JldHZhbChyZXNvdXJjZSwgcmV0X3U2NCwgZXJybm9fdTY0LCByZXRfbCwgZXJy
bm8sCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIl9fTlJfZ2V0cmxpbWl0IikgfHwKPiAg
ICAgICAgICAgICBjb21wYXJlX3U2NF9sb25nKHJlc291cmNlLCBybGltX3U2NC5ybGltX2N1ciwg
cmxpbV9sLnJsaW1fY3VyLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgInJsaW1fY3Vy
IikgfHwKPiAtLQo+IDIuNTAuMAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
