Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 394B4C3601E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 15:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744299344; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Kx4N79f0/oLUDYkUrm/D44EcjvbHMfdBLYzsj4aJyzM=;
 b=Yzpv8ORiUGOLTzSZD0++a+zQmu1mcbPd6CwXzmRbU+HYAfgEg61IAbwWH44MXMhfSjQ5W
 a1QlQF4fijHLTm0lWox5y4o4EKuBFizbUcdU+aezBuvmSFBSP1DFCMGisp5vQIrgnUmY2b1
 RoBRZyfVw9qq3rbKPf/8XtWwYk9HKzM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C18CF3CB50F
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 17:35:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BA503C02B3
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 17:35:22 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 78AC91000A57
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 17:35:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744299318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfCnLU9TtTPmonHUEECJlKq65o1LrM1h0vG6mmBZSyw=;
 b=X3xOAynqOevbra8XsE+ETbQTmZhiuPYNiEldu9MZJkLkgZuqPpegFuTDWoIqDlrHtUoqTj
 fc8Z1a7uIxuX5gGU0Or4zrjbhQBY2pTPvaUyE4Vuk++jBqr+1resa44dipATAylSF9esez
 yZZ2YzXyIhlToKXYlGn8bIIB077HdbY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-DZNZceoIOz-sM-xcKw15QQ-1; Thu, 10 Apr 2025 11:35:17 -0400
X-MC-Unique: DZNZceoIOz-sM-xcKw15QQ-1
X-Mimecast-MFC-AGG-ID: DZNZceoIOz-sM-xcKw15QQ_1744299316
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c793d573b2so180779085a.1
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 08:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744299316; x=1744904116;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OfCnLU9TtTPmonHUEECJlKq65o1LrM1h0vG6mmBZSyw=;
 b=Tk3T/cJtr2CRAW3yi3HqGGhzQh8Y4snfZveP9bQE6K2jUeLvAty7Ds6TuIUnbylmi/
 YVUr9FGYeAiSBuUI76NogC8xiydYBti4PbHQ40GLXRFJEMrXBvkKjHHU+7moYJ0BthMF
 PnGPjPRjG2aObRYIMsFRndZKNofNddprJHEnsSkSK5fx89T3gxzrBlZGAOpEKKr5j0wX
 /5Uqggcg3zNCUJ9DCePgO9ByjG+nK5Isr7R/ut3HWX1x2WVHtDytVTJaYlEYq3ehBYpU
 ng+wTF4uv5yl9mNs8MmlqakJCMcpmxdkcqY+nCNZfr4ps56AeT6wPwZ4DRik44Keh0iW
 ZZ4A==
X-Gm-Message-State: AOJu0YzieF3tGDGfZOYW7mCzF0IbFfj+Z0ihkC6ihgDvmYDUSdsDBgRp
 fkq5tuHPYR9hGGpYe9om4i+wV5krPrVnJs4mMl33/2KL5g3Zvy1zvZCKuF7Sn9IiNQnH0WW9z/y
 NxKfnqiAwZQ2Pzv/8ocQ9A9yRiaTei1By/Ir9KbKat+G2FSccwcKWVOo+d/+eIx49nCcV8dz+BJ
 uqFL4wkfvapW4OSvZ42CZTogUcAa+kbt+uN3v3
X-Gm-Gg: ASbGnctBoGguOhnjwFAAO8PVsxVh/Q3ZGYVTpQRuwZqbyPs0naBwa2gu4vUb/qS/r+g
 RIsKDJxuFaGZ/pTEskw7vqpTgetYLRjMrjYrJFWXZ3scY0b3aFyOMJlIn0zH5YHHpm2zT
X-Received: by 2002:a05:620a:248b:b0:7c5:6cf5:9439 with SMTP id
 af79cd13be357-7c7a76bf80dmr495565785a.37.1744299316513; 
 Thu, 10 Apr 2025 08:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ3yDVa3idquh9u/YNNt7RLjxXA+wM0/iuRbYPEYUZ1mh6r/UZCsSW5Th8To8ecx4uf/lJ2jb8Lio2IzHRr9A=
X-Received: by 2002:a05:620a:248b:b0:7c5:6cf5:9439 with SMTP id
 af79cd13be357-7c7a76bf80dmr495560485a.37.1744299316081; Thu, 10 Apr 2025
 08:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250314044257.1673303-1-lufei@uniontech.com>
 <20250409074906.128290-1-lufei@uniontech.com>
In-Reply-To: <20250409074906.128290-1-lufei@uniontech.com>
Date: Thu, 10 Apr 2025 17:35:00 +0200
X-Gm-Features: ATxdqUHkVqmj1qp8JzUy_Kf14Yo4YZ7qDm9ycpJe5u2ZlQXxVXXJMWOfa_gmjnE
Message-ID: <CAASaF6xF787F+JM9QwXY-n+VQnTXX8x=L0cE2-qtE6bdSUdJVQ@mail.gmail.com>
To: lufei <lufei@uniontech.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wRWyMqUqz-MlEX6YVUkNVOVI8qxfDJD2rmq6UbMp1pM_1744299316
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: viro@zeniv.linux.org.uk, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBBcHIgOSwgMjAyNSBhdCA5OjQ54oCvQU0gbHVmZWkgPGx1ZmVpQHVuaW9udGVjaC5j
b20+IHdyb3RlOgo+Cj4gU2V0IG5yX29wZW4gd2l0aCBzaXplb2YobG9uZykqOCB0byB0cmlnZ2Vy
IEVNRklMRSwgaW5zdGVhZCBvZiByZWFkaW5nCj4gbnVtYmVyIG9mIGZpbGVkZXNjcmlwdG9ycyBs
aW1pdC4KCkFuIGV4cGxhbmF0aW9uIGZvciB0aGlzIG51bWJlciB3b3VsZCBiZSBuaWNlLgoKPgo+
IFNpZ25lZC1vZmYtYnk6IGx1ZmVpIDxsdWZlaUB1bmlvbnRlY2guY29tPgoKQWNrZWQtYnk6IEph
biBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoKVGhpcyBmaXhlcyB0ZXN0IGZvciBtZSBv
biA2LjE1LjAtMC5yYzEKCj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFy
ZS91bnNoYXJlMDMuYyB8IDIzICsrLS0tLS0tLS0tLS0tLS0tLS0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMjEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy91bnNoYXJlL3Vuc2hhcmUwMy5jIGIvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy91bnNoYXJlL3Vuc2hhcmUwMy5jCj4gaW5kZXggN2M1ZTcxYzRlLi5jM2I5ODkz
MGQgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bnNoYXJlL3Vuc2hh
cmUwMy5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bnNoYXJlL3Vuc2hhcmUw
My5jCj4gQEAgLTE3LDQ0ICsxNywyNSBAQAo+ICAjaW5jbHVkZSAibGFwaS9zY2hlZC5oIgo+Cj4g
ICNkZWZpbmUgRlNfTlJfT1BFTiAiL3Byb2Mvc3lzL2ZzL25yX29wZW4iCj4gLSNkZWZpbmUgTlJf
T1BFTl9MSU1JVCAxMDI0Cj4gLSNkZWZpbmUgTlJfT1BFTl9EVVAgNjQKPgo+ICAjaWZkZWYgSEFW
RV9VTlNIQVJFCj4KPiAgc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4gIHsKPiAtICAgICAgIGludCBu
cl9vcGVuOwo+IC0gICAgICAgaW50IG5yX2xpbWl0Owo+IC0gICAgICAgc3RydWN0IHJsaW1pdCBy
bGltaXQ7Cj4gICAgICAgICBzdHJ1Y3QgdHN0X2Nsb25lX2FyZ3MgYXJncyA9IHsKPiAgICAgICAg
ICAgICAgICAgLmZsYWdzID0gQ0xPTkVfRklMRVMsCj4gICAgICAgICAgICAgICAgIC5leGl0X3Np
Z25hbCA9IFNJR0NITEQsCj4gICAgICAgICB9Owo+Cj4gLSAgICAgICBTQUZFX0ZJTEVfU0NBTkYo
RlNfTlJfT1BFTiwgIiVkIiwgJm5yX29wZW4pOwo+IC0gICAgICAgdHN0X3JlcyhUREVCVUcsICJN
YXhpbXVtIG51bWJlciBvZiBmaWxlIGRlc2NyaXB0b3JzOiAlZCIsIG5yX29wZW4pOwo+ICsgICAg
ICAgaW50IG5yX29wZW4gPSBzaXplb2YobG9uZykgKiA4Owo+Cj4gLSAgICAgICBucl9saW1pdCA9
IG5yX29wZW4gKyBOUl9PUEVOX0xJTUlUOwo+IC0gICAgICAgU0FGRV9GSUxFX1BSSU5URihGU19O
Ul9PUEVOLCAiJWQiLCBucl9saW1pdCk7Cj4gLQo+IC0gICAgICAgU0FGRV9HRVRSTElNSVQoUkxJ
TUlUX05PRklMRSwgJnJsaW1pdCk7Cj4gLQo+IC0gICAgICAgcmxpbWl0LnJsaW1fY3VyID0gbnJf
bGltaXQ7Cj4gLSAgICAgICBybGltaXQucmxpbV9tYXggPSBucl9saW1pdDsKPiAtCj4gLSAgICAg
ICBTQUZFX1NFVFJMSU1JVChSTElNSVRfTk9GSUxFLCAmcmxpbWl0KTsKPiAtICAgICAgIHRzdF9y
ZXMoVERFQlVHLCAiU2V0IG5ldyBtYXhpbXVtIG51bWJlciBvZiBmaWxlIGRlc2NyaXB0b3JzIHRv
IDogJWQiLAo+IC0gICAgICAgICAgICAgICBucl9saW1pdCk7Cj4gLQo+IC0gICAgICAgU0FGRV9E
VVAyKDIsIG5yX29wZW4gKyBOUl9PUEVOX0RVUCk7Cj4gKyAgICAgICBTQUZFX0RVUDIoMiwgbnJf
b3BlbiArIDEpOwo+Cj4gICAgICAgICBpZiAoIVNBRkVfQ0xPTkUoJmFyZ3MpKSB7Cj4gICAgICAg
ICAgICAgICAgIFNBRkVfRklMRV9QUklOVEYoRlNfTlJfT1BFTiwgIiVkIiwgbnJfb3Blbik7Cj4g
ICAgICAgICAgICAgICAgIFRTVF9FWFBfRkFJTCh1bnNoYXJlKENMT05FX0ZJTEVTKSwgRU1GSUxF
KTsKPiAgICAgICAgICAgICAgICAgZXhpdCgwKTsKPiAgICAgICAgIH0KPiAtCj4gIH0KPgo+ICBz
dGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+IC0tCj4gMi4zOS4zCj4KPgo+IC0tCj4gTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
