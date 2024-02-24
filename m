Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F78C48BF6
	for <ltp@archiver.kernel.org>; Sat, 24 Feb 2024 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1708767165; h=mime-version :
 date : message-id : references : in-reply-to : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=F1EhAZF1QenoRZXEocBd4W2QNhzwtJBGlgCZbsHKXEQ=;
 b=gpPs7llnkw52WlU6u0hoWWHQmM6oopKIp96gto4TDeA6x4uy6a7McelAmmX+/uR6cOOD3
 kZbyZMJPF9Uoe8heUYU5QfEpyJmBwXEsKkEfd9INl4YTsPW9mtG5mH9f7BDqxgk8mTzf4h3
 ezrDTnsFJzuehRjIuYjM+mo+gnEVXXY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EA473CF0C8
	for <ltp@archiver.kernel.org>; Sat, 24 Feb 2024 10:32:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 797603CC92D
 for <ltp@lists.linux.it>; Sat, 24 Feb 2024 10:32:22 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 173EB602AC7
 for <ltp@lists.linux.it>; Sat, 24 Feb 2024 10:32:21 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4129ed3d15aso896775e9.0
 for <ltp@lists.linux.it>; Sat, 24 Feb 2024 01:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1708767140; x=1709371940; darn=lists.linux.it;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:from:to:cc:subject:date:message-id
 :reply-to; bh=JsUgdNEq9P5o7TeSkoLc0xLvLpR6wIZewnTevwQPjgs=;
 b=Ww0sTcOJqfwhj1OTi6eWI/j2YXVRZzhfEjQ5EPeVH5wGKi2o7U4wJPsn77nI9ncaY2
 7ZJ8q6BFPsH7nXYmKc94cDJk72DvjkIhyZ2NyvDf/t7ySgPjHIrJ+CIoPQJiUltbPeHr
 L+hrbNPzuhImS38/iq9oQnyJj+JcaKP2GN5iJBEd84pnHMsN464ranKYZfvFFz4LrulW
 ba0D19MBVQNjPwaMfLCRTRKD8CylAxrYFNPA1iHcPAlFTJpn1s1ovqnBIYN1LcuGqWZB
 LW5qmJQb1HOpxo5Cn/nsHqSQq+10C0s3H7no3pWo/ILsSa8y6PvekzOMbz99mzdPq94b
 3GAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708767140; x=1709371940;
 h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
 :from:content-transfer-encoding:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JsUgdNEq9P5o7TeSkoLc0xLvLpR6wIZewnTevwQPjgs=;
 b=eL71jWrNAXd3YPsCHgkc+k6pbc6Fird9zEXyeOLm6czj6XUehbVNjiGIXTyM8QPeVz
 UF30oyo7JYe/4wB3l4LCSEImLbJRb0cwcAlW5qTCz5NwdR4nsfzDYRKMfHTfma1hYLbf
 Nhv5zSGxNBhx94YzjjgjgD3Yl2aITZqUrCuHlnJXAd4LSTXwqSlvb/W+jPEXcNEp+arM
 n0rtgMQZ+obyYiDtZUFYkBTUQ3JhWBpPTI5CSL06bj9gRywwnaPXMC+YKAPQ5b2QZcWi
 Eks9EnIPFT5Gweum8/SB9m3jCJpsy2Jaadbu9W9EfiTKQs2KJNFJIf7weXiTcSM0oqGb
 PDwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgv3I5Df7I2whnMyOf5/MU76jVFbzWqo2W16A/tsbNkdC8XN7m8OUZQQrpVRXRLt7Azm5X+lBqx1DkKdJ1Row3Nf0=
X-Gm-Message-State: AOJu0Yz/29vdIOo1hTPiY0fxXFdC1/x1qIXKI+Z5eeO8ZUVndmQEqbuh
 uvm2owYWuUZ1c860/t9muFJ1cLUVta7pZrk01WnMuerpab+tgpphzh20arpniI4=
X-Google-Smtp-Source: AGHT+IGiKuJJiUm1uCYVWoo0iYORY8kavqnJPIdOuLSvdbBBY9PzOvbCJwUEMPd7T2ZjvoOHhCkPLQ==
X-Received: by 2002:a05:600c:1989:b0:412:9dfc:f67a with SMTP id
 t9-20020a05600c198900b004129dfcf67amr574002wmq.12.1708767140497; 
 Sat, 24 Feb 2024 01:32:20 -0800 (PST)
Received: from smtpclient.apple ([212.86.60.148])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a05600c350c00b0041285ffec13sm1630277wmq.41.2024.02.24.01.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Feb 2024 01:32:20 -0800 (PST)
Mime-Version: 1.0 (1.0)
Date: Sat, 24 Feb 2024 10:32:09 +0100
Message-Id: <49150628-46DE-4F53-9D4C-E6631D8E61CC@suse.com>
References: <20240223154732.GD1486515@pevik>
In-Reply-To: <20240223154732.GD1486515@pevik>
To: Petr Vorel <pvorel@suse.cz>
X-Mailer: iPhone Mail (21D61)
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add stat04 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgo+IE9uIDIzIEZlYiAyMDI0LCBhdCAxNjo0NywgUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgo+IAo+IO+7v0hpIEFuZHJlYSwKPiAKPj4+PiArICAgIGNoYXIgKnN5bW5hbWUg
PSAibXlfc3ltbGluazAiOwo+Pj4+ICsgICAgY2hhciAqdG1wZGlyID0gdHN0X2dldF90bXBkaXIo
KTsKPj4+PiArCj4+Pj4gKyAgICBTQUZFX1NZTUxJTksodG1wZGlyLCBzeW1uYW1lKTsKPj4+PiAr
Cj4+Pj4gKyAgICBzdHJ1Y3Qgc3RhdCBwYXRoOwo+Pj4+ICsgICAgc3RydWN0IHN0YXQgbGluazsK
Pj4+IG5pdDogbWF5YmUgZGVmaW5lIHN0cnVjdCBhdCB0aGUgdG9wIG9mIHRoZSBmdW5jdGlvbj8K
Pj4gVGhpcyBpcyBjb21tb24gaW4gdGhlIGZpcnN0IHZlcnNpb25zIG9mIEMsIGJ1dCBhIGdvb2Qg
cHJhY3RpY2UgaXMgdG8gZGVmaW5lCj4+IHZhcmlhYmxlcyBhcyBjbG9zZSBhcyBwb3NzaWJsZSB3
aGVyZSB0aGV5IGFyZSB1c2VkIGluIG9yZGVyIHRvIGltcHJvdmUKPj4gcmVhZGFiaWxpdHkuCj4g
Cj4gRmFpciBlbm91Z2guCj4gCj4+Pj4gKwo+Pj4+ICsgICAgVFNUX0VYUF9QQVNTKHN0YXQodG1w
ZGlyLCAmcGF0aCkpOwo+Pj4+ICsgICAgZnJlZSh0bXBkaXIpOwo+Pj4gSWYgU0FGRV9TWU1MSU5L
KCkgZmFpbHMsIGZyZWUoKSB3aWxsIG5vdCBoYXBwZW4uIEkgd29uZGVyIGlmIHdlIHNob3VsZCBi
b3RoZXIKPj4+ICh3ZSdkIGhhdmUgdG8gc2V0IGl0IE5VTEwgYW5kIGFkZCBhIGNsZWFudXAgZnVu
Y3Rpb24pLgo+IAo+Pj4gUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+
IAo+Pj4gS2luZCByZWdhcmRzLAo+Pj4gUGV0cgo+IAo+IC4uLgo+IAo+PiBBY2NvcmRpbmcgdG8g
Q3lyaWwgc3VnZ2VzdGlvbnMgd2UgYXJlIHByb2JhYmx5IGRvbmUgd2l0aCB0aGlzIHBhdGNoIHNv
IGl0Cj4+IGNhbiBiZSBtZXJnZWQuIElzbid0IGl0Pwo+IAo+IFdlbGwgeW91IGZyZWUoKSBsYXRl
ciBpbiB0aGUgZnVuY3Rpb24uIEJ1dCBDeXJpbCdzICBub3RlIHNvdW5kcyByZWFzb25hYmxlIGZv
cgo+IG1lOgo+ICAgICJjYWxsIGl0IG9uY2UgaW4gdGhlIHRlc3Qgc2V0dXAoKSBvciB1c2UgIi4i
IGluc3RlYWQuIgo+IAo+IENvdWxkIHlvdSBwbGVhc2UgZG8gaXQ/Cj4gCk1ha2VzIHNlbnNlLiBJ
IHRoaW5rIHdlIHNob3VsZCBhZGFwdCBhbGwgb3RoZXIgdGVzdHMgYXMgd2VsbCBiZWNhdXNlIGl0
4oCZcyBmdWxsIG9mIG1lbW9yeSBsZWFrYWdlIHdoZW4gaXQgY29tZXMgdG8gZ2V0IHRlbXBvcmFy
eSBkaXJlY3RvcnkuCgo+IEFsc28gbW9zdCBvZiB0aGUgdGVzdHMgcmVhbGx5IHJ1biB0c3RfZ2V0
X3RtcGRpcigpIGluIHRoZSBzZXR1cCgpIChvciBjbGVhbnVwKCksCj4gdGhlcmUgYXJlIGV4Y2Vw
dGlvbnMgKG5ldyBBUEk6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF0aGNvbmYvcGF0aGNv
bmYwMS5jLAo+IG9sZCBBUEk6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3ltbGluay9zeW1s
aW5rMDEuYywKPiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Nsb25lL2Nsb25lMDIuYyksIHdo
aWNoIHNob3VsZCBiZSBmaXhlZC4KPiBJTUhPIHRlc3RzIHdoaWNoIGNhbGwgdHN0X2dldF90bXBk
aXIoKSBpbiB0aGUgcnVuKCkKPiAKPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+IAo+PiBUaGFua3Ms
Cj4+IEFuZHJlYQo+IAoKUmVnYXJkcywKQW5kcmVhCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
