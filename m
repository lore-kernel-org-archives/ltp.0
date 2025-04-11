Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C42BC3601E
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 03:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744341724; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=yBGnjH67mffkSsIEtROq5SKi4pAGU/OOTv9Lqgc/O/E=;
 b=myc6V+u98mVzUbENTj8L1Pivm6LjD3Axvs1MVkEZLiuUPxQkgaURcgqXbrKanNXPFBYUU
 f1iZ/tgrBWlDou74kjgynS0Eawiw70qVph6CjUNDDRDCEHNuI+B1quU0Rj832bpY7uzMUPK
 E5QF9kNQdsHmzCz9g9fYliya+evLdT4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA9E13CB532
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 05:22:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15BE93CA355
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 05:21:42 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 06B7F1000606
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 05:21:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744341699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0tGuc9JeO8ifQraHG8YtA1tRNDWOmR7OmodfZymAaF0=;
 b=UKDsscdGzguKiQyJvphGqRPmUE3K0JRjDTSUyc/k617Ls88T9bq8louItjtEC7hXis9Q71
 uSwwdQ0o/WxNgZmQzw4StocGSfiuLjNwTiWXO7fPLxRbcvo2n2jRNORldWVhESeWiGgaWD
 rsub9gaDjRaVZLLGm4/lRm/45eX2+Kc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-XyAq7k4FMHmwaavH68jcMQ-1; Thu, 10 Apr 2025 23:21:36 -0400
X-MC-Unique: XyAq7k4FMHmwaavH68jcMQ-1
X-Mimecast-MFC-AGG-ID: XyAq7k4FMHmwaavH68jcMQ_1744341696
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff798e8c3bso1506799a91.2
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:21:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744341695; x=1744946495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0tGuc9JeO8ifQraHG8YtA1tRNDWOmR7OmodfZymAaF0=;
 b=rO7DFdZGjCOoJXaNv96P2V+hwGqktT27aammfcr7524spiW2bE/dvv3NXIr/MhpC6Y
 VMyykXgzlc+UgMruMxxTgPrEk9UjZ7Un3fvK+KH2aH+zEDI6VT3h8r4VMxS5THm+efYx
 kUq3QIEi3KxGZkXiuCYR2GmeoR/XjyF4DmShOB0RpOqsuAxMF6L7vhwTesHuBuaGZrJC
 k4rYZX0I/UhjwgAnU8FSA19u8vHVOt2m371PA1WwDvkk6o+5LACputqCQyZ9Skd1wZNu
 b95HYi/YPY7qf5BmsjY4H7Z2rBZMNKToikzy45r3BeYZ0GG96lAmVhlaXjpLoc6c7ik7
 T9BQ==
X-Gm-Message-State: AOJu0YysrBv82qVCY0/WPsXJNu1+qJGKbPtLgQ3Jmpy7i5Od9QxRIq2P
 PYFUWHVBz35LfURPqbbmoz8lAPYhyrpRxsqKOxdGcdxBnz0X2bY6JLaL5MDXe1nCBRcXX1H/Zuu
 xSrEk9e3cEm9oCToZfBe3PWLy+8x1O2Fr2NinPb0NOEUY4ultPE5Z1+l6AKA7tRmt5DN3tkCYZK
 SXCsCnoq3nArsJnvSECk+hzH4=
X-Gm-Gg: ASbGncue66OmTYKRQgIBgTfAs27o++0BZ+8QofZ5DWgww6BWT9JUa3br+2wnYWtt+0q
 MCYrgdXYwtM0eFnyY2OygYC9VH5fLAmeCBxsPPeEmRqis7hTmg2Fcs2NxpaMbJzAQdQoLPQ==
X-Received: by 2002:a17:90b:4d06:b0:2fe:dd2c:f8e7 with SMTP id
 98e67ed59e1d1-308236343c4mr1779994a91.10.1744341695572; 
 Thu, 10 Apr 2025 20:21:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzehDg45HJpSnNGrC9pH9g6CLwZPVUzcK1d8bmpYVIlCBv/UNpEzNy/0xbYtJer+tEH+dRTniyRTMkzx8s1As=
X-Received: by 2002:a17:90b:4d06:b0:2fe:dd2c:f8e7 with SMTP id
 98e67ed59e1d1-308236343c4mr1779964a91.10.1744341695187; Thu, 10 Apr 2025
 20:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250314044257.1673303-1-lufei@uniontech.com>
 <20250409074906.128290-1-lufei@uniontech.com>
 <CAEemH2ef7SZ_U5Z-rHst3Wcg-+fuRjSSOU9NxZOSW2Hjx3kiEg@mail.gmail.com>
In-Reply-To: <CAEemH2ef7SZ_U5Z-rHst3Wcg-+fuRjSSOU9NxZOSW2Hjx3kiEg@mail.gmail.com>
Date: Fri, 11 Apr 2025 11:21:23 +0800
X-Gm-Features: ATxdqUH9-9CCwO39I7-yJUSljJCn5BCxvLnTLT-YSJjvCxtu3fNq2oHXvjq5ZBQ
Message-ID: <CAEemH2ciHq6EVe8ChfJrHCx=FXRsxUpgbCR=9d5QsgX_K_Fjpw@mail.gmail.com>
To: lufei <lufei@uniontech.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oMRED23JvgY2JEyUxSQGZDEGH6YHEFGNrqQKR9j-rhI_1744341696
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] unshare03: set nr_open with sizeof(long)*8
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
Cc: viro@zeniv.linux.org.uk, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBcHIgMTEsIDIwMjUgYXQgMTE6MDnigK9BTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cgo+Cj4KPiBPbiBXZWQsIEFwciA5LCAyMDI1IGF0IDM6NTDigK9QTSBsdWZl
aSA8bHVmZWlAdW5pb250ZWNoLmNvbT4gd3JvdGU6Cj4KPj4gU2V0IG5yX29wZW4gd2l0aCBzaXpl
b2YobG9uZykqOCB0byB0cmlnZ2VyIEVNRklMRSwgaW5zdGVhZCBvZiByZWFkaW5nCj4+IG51bWJl
ciBvZiBmaWxlZGVzY3JpcHRvcnMgbGltaXQuCj4+Cj4KPiBBbnkgbmV3IGNoYW5nZXMgaW4gTGlu
dXggdGhhdCBoYXZlIG1hZGUgdGhlIHByZXZpb3VzIHdheSBub3Qgd29yayBub3c/Cj4KCkFoLCBJ
IHNlZS4gQXMgeW91IHBvaW50ZWQgb3V0IGluIHYxLCB0aGF0IGhhcmQgbGltaXQgbWF5IGxlYWQg
dG8gZHVwMgpFTk9NRU0gZXJyb3Igd2hpY2ggYnJpbmdzIHRoZSByZXN1bHQgdG8gVEJST0sgb25h
IHNtYWxsIFJBTSBzeXN0ZW0uCgpTbywgSSBhZ3JlZSBKYW4sIHdlJ2QgYmV0dGVyIGFkZCBtb3Jl
IGRlc2NyaXB0aW9uIHRvIHRoZSBwYXRjaC4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdA
cmVkaGF0LmNvbT4KCgoKPgo+Cj4KPj4KPj4gU2lnbmVkLW9mZi1ieTogbHVmZWkgPGx1ZmVpQHVu
aW9udGVjaC5jb20+Cj4+IC0tLQo+PiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bnNoYXJl
L3Vuc2hhcmUwMy5jIHwgMjMgKystLS0tLS0tLS0tLS0tLS0tLQo+PiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vuc2hhcmUvdW5zaGFyZTAzLmMKPj4gYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL3Vuc2hhcmUvdW5zaGFyZTAzLmMKPj4gaW5kZXggN2M1ZTcxYzRlLi5j
M2I5ODkzMGQgMTAwNjQ0Cj4+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFy
ZS91bnNoYXJlMDMuYwo+PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vuc2hhcmUv
dW5zaGFyZTAzLmMKPj4gQEAgLTE3LDQ0ICsxNywyNSBAQAo+PiAgI2luY2x1ZGUgImxhcGkvc2No
ZWQuaCIKPj4KPj4gICNkZWZpbmUgRlNfTlJfT1BFTiAiL3Byb2Mvc3lzL2ZzL25yX29wZW4iCj4+
IC0jZGVmaW5lIE5SX09QRU5fTElNSVQgMTAyNAo+PiAtI2RlZmluZSBOUl9PUEVOX0RVUCA2NAo+
Pgo+PiAgI2lmZGVmIEhBVkVfVU5TSEFSRQo+Pgo+PiAgc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4+
ICB7Cj4+IC0gICAgICAgaW50IG5yX29wZW47Cj4+IC0gICAgICAgaW50IG5yX2xpbWl0Owo+PiAt
ICAgICAgIHN0cnVjdCBybGltaXQgcmxpbWl0Owo+PiAgICAgICAgIHN0cnVjdCB0c3RfY2xvbmVf
YXJncyBhcmdzID0gewo+PiAgICAgICAgICAgICAgICAgLmZsYWdzID0gQ0xPTkVfRklMRVMsCj4+
ICAgICAgICAgICAgICAgICAuZXhpdF9zaWduYWwgPSBTSUdDSExELAo+PiAgICAgICAgIH07Cj4+
Cj4+IC0gICAgICAgU0FGRV9GSUxFX1NDQU5GKEZTX05SX09QRU4sICIlZCIsICZucl9vcGVuKTsK
Pj4gLSAgICAgICB0c3RfcmVzKFRERUJVRywgIk1heGltdW0gbnVtYmVyIG9mIGZpbGUgZGVzY3Jp
cHRvcnM6ICVkIiwKPj4gbnJfb3Blbik7Cj4+ICsgICAgICAgaW50IG5yX29wZW4gPSBzaXplb2Yo
bG9uZykgKiA4Owo+Pgo+PiAtICAgICAgIG5yX2xpbWl0ID0gbnJfb3BlbiArIE5SX09QRU5fTElN
SVQ7Cj4+IC0gICAgICAgU0FGRV9GSUxFX1BSSU5URihGU19OUl9PUEVOLCAiJWQiLCBucl9saW1p
dCk7Cj4+IC0KPj4gLSAgICAgICBTQUZFX0dFVFJMSU1JVChSTElNSVRfTk9GSUxFLCAmcmxpbWl0
KTsKPj4gLQo+PiAtICAgICAgIHJsaW1pdC5ybGltX2N1ciA9IG5yX2xpbWl0Owo+PiAtICAgICAg
IHJsaW1pdC5ybGltX21heCA9IG5yX2xpbWl0Owo+PiAtCj4+IC0gICAgICAgU0FGRV9TRVRSTElN
SVQoUkxJTUlUX05PRklMRSwgJnJsaW1pdCk7Cj4+IC0gICAgICAgdHN0X3JlcyhUREVCVUcsICJT
ZXQgbmV3IG1heGltdW0gbnVtYmVyIG9mIGZpbGUgZGVzY3JpcHRvcnMgdG8gOgo+PiAlZCIsCj4+
IC0gICAgICAgICAgICAgICBucl9saW1pdCk7Cj4+IC0KPj4gLSAgICAgICBTQUZFX0RVUDIoMiwg
bnJfb3BlbiArIE5SX09QRU5fRFVQKTsKPj4gKyAgICAgICBTQUZFX0RVUDIoMiwgbnJfb3BlbiAr
IDEpOwo+Pgo+PiAgICAgICAgIGlmICghU0FGRV9DTE9ORSgmYXJncykpIHsKPj4gICAgICAgICAg
ICAgICAgIFNBRkVfRklMRV9QUklOVEYoRlNfTlJfT1BFTiwgIiVkIiwgbnJfb3Blbik7Cj4+ICAg
ICAgICAgICAgICAgICBUU1RfRVhQX0ZBSUwodW5zaGFyZShDTE9ORV9GSUxFUyksIEVNRklMRSk7
Cj4+ICAgICAgICAgICAgICAgICBleGl0KDApOwo+PiAgICAgICAgIH0KPj4gLQo+PiAgfQo+Pgo+
PiAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPj4gLS0KPj4gMi4zOS4zCj4+Cj4+Cj4+IC0tCj4+
IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+
Pgo+Pgo+Cj4gLS0KPiBSZWdhcmRzLAo+IExpIFdhbmcKPgoKCi0tIApSZWdhcmRzLApMaSBXYW5n
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
