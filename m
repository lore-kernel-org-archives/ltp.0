Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D276C5AC7A
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771602475; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ApejbGWBGkemo6ENgOt3GTxiB7duCQrE1AhPo7Nd8sU=;
 b=YjXiXI8uRHtgPcyBuTQ6/JBzEx0dwL2qDhnu+QRKPnF8tve1oFpMgoGIm6Q3GyJK+8Jyq
 vtGdHhJ2iWmYsuxQG+dfzKJRzjKMLyrahAqTffOCAll0duoNHRDIcXWfzk25hWCRFhvszBr
 ItdXmiUAYt0Kg7rBgfhQ6+sO2D7pNaU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E1023D07AC
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 16:47:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C0A93D03DC
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:47:31 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A23C600A7C
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:47:31 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so22746445e9.1
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 07:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771602451; x=1772207251; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Te1IpxwHUqNZZx4bdl9h7NPjij63aglXPhmyVg9+vWg=;
 b=dG8nvcB1MLsZHmjsdGSIcQXe/SddCyPFA/adbfQ/HJM/6xE0VxkVeqvA5GgaEc3B6a
 WD2qhyg1zZg1vD8faNyJvGbIneAUOBIzB/nUeTBoPx6256q1oYg/IeoFvXu5mE5OSPFM
 mh/luWjOG6ReVhH9cw8g6RY/HOnAj0CW2JNrdZb3uB/S6FyZhXtO5jcg/L5XycDieLee
 E5FMkySFqu27pY/M2ar8pmA3rE8KyRMFAZ6SThFGUJqugkr9WxuY9bgB1N6KJMXi8loD
 Znobmn7tCB/tkiIHP86yP44kSkw/N4fSmbR3xMibpZrMyX5jKIctwcjBqSrlC8gCo7gd
 hNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771602451; x=1772207251;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Te1IpxwHUqNZZx4bdl9h7NPjij63aglXPhmyVg9+vWg=;
 b=qSiqXNEucDEtrpXpXU+IdvF1AkgU2zodKm6jhTsaOKv/4uFxaw+bpMEf0CDJ2tDXph
 990q1KHlzx7UGg13g3jfsIBdZDxAZq6cg2dS8bxtkf2Fv4TZaAQHa5hLxkorSuVH+Aev
 yNAkkRK93/Su6/OsGQB3eqJpV5nrQca3H1G2JRj02i9vbkEDQXso0Sb55W9XPGbxp/kG
 5Y4/B9jqSMVl8mQjU2mbAw5+GeZDsMfPYpSfP2UIdhbaohHAbR+/G1w7ouQQVBmKYR68
 malFZeAF1WRRE1sm2BfZoaqg6EpQBzp7LkAH8VdPd/vhFFD7KwoZybH2OhiDZsXMaUA5
 2chw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxU0y29IfMoFruYSVyw7CCSqokMq5RdrbgR9+sZuaUtWuXC7I70tDsF5bHislAh68Zf94=@lists.linux.it
X-Gm-Message-State: AOJu0Yx+FitWloCX5JFM7O4otFMDSOeOL+NB5ma7qXD390sFSahy3+in
 CF9KZskNfBi71HRAKI0pRke7jOIctxSScGkXFCKnb1oiOchtqQ8+iPHrmkmpPjGwzvc=
X-Gm-Gg: AZuq6aLsC0YHVEygf7+adZL9HRcBmzzRXkIGu7VJkUP64ZoHxnLMZcG5lQFClN6KB3y
 ZaNXKe3I7T2JB8TDrflmNjT0V6Iudcq9zCO6wjioXKFY39RXVMTPtRl2YMuz6r8NVOX/ow1mS0E
 qZF+ynG8814wkYg10GjL8/0GHkEar3pWazopHyZOo/2b5sm0NckcV0ImBEgvsb5joB+cDmpzgqn
 Zp3hGw1+nYu/246+EPOrPwkcvYwzgo8NG5mcVkkNcDHAzxwSS6+kngDZsyjJ/82+BE++yN/GC1J
 cNQC+IY+Rc9yAScXuQknhnVylq2i71RbvsQ7XNdpZ6xdPzVS8mIt7uuAzm/MK1A15CGjwYIDQgg
 FJ2kwd2eZcSB7Id/ko5vQ1/XF7IawR19KDAYWE1Pb9+DCRySuxhAs6PsPY2Km5tr2ix2JhQeN1C
 t+0suamCBu7tAysaOj9jKBCTTS
X-Received: by 2002:a05:600c:8115:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-483a5550077mr32401245e9.32.1771602450527; 
 Fri, 20 Feb 2026 07:47:30 -0800 (PST)
Received: from localhost ([88.128.90.39]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a43088fdsm18225585e9.30.2026.02.20.07.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 07:47:30 -0800 (PST)
Mime-Version: 1.0
Date: Fri, 20 Feb 2026 16:47:29 +0100
Message-Id: <DGJWNLRE9HZO.18VNRTVC0N7LM@suse.com>
To: "Ricardo Branco" <rbranco@suse.de>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260219225007.218697-1-rbranco@suse.de>
 <DGJWBYPFA8X4.O6DWVQQLRNGT@suse.com>
 <1a05954d-e6b9-4e43-85f2-90ea94e8b68a@suse.de>
In-Reply-To: <1a05954d-e6b9-4e43-85f2-90ea94e8b68a@suse.de>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] userfaultfd: Add test using UFFDIO_POISON
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpIEZlYiAyMCwgMjAyNiBhdCA0OjQzIFBNIENFVCwgUmljYXJkbyBCcmFuY28gd3JvdGU6
Cj4KPgo+IE9uIDIvMjAvMjYgNDozMiBQTSwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPiA+PiAr
Cj4gPj4gKwlzYS5zYV9oYW5kbGVyID0gc2lnYnVzX2hhbmRsZXI7Cj4gPj4gKwlzaWdlbXB0eXNl
dCgmc2Euc2FfbWFzayk7Cj4gPj4gKwlTQUZFX1NJR0FDVElPTihTSUdCVVMsICZzYSwgTlVMTCk7
Cj4gPj4gKwo+ID4+ICsJc2V0X3BhZ2VzKCk7Cj4gPiBUaGlzIGlzIGRvbmUgZXZlcnkgY3ljbGUg
b2YgLWkgPiAxLCBidXQgbWVtb3J5IGlzIG5ldmVyIHJlbGVhc2VkIGFuZAo+ID4gZG9uZSBvbmNl
IGluIGNsZWFudXAoKS4KPiBJJ20gbW92aW5nIHNpZ2FjdGlvbiB0byBzZXR1cCBidXQgc2V0X3Bh
Z2VzKCkgaXMgY2FsbGVkIGluIHJ1bigpIG9uIHRoZSAKPiByZXN0IG9mIHRoZSB0ZXN0cy4KCkJ1
dCBhbGwgb3RoZXIgdGVzdHMgYWxzbyBoYXZlIGEgcmVzZXRfcGFnZXMoKSBhdCB0aGUgZW5kIG9m
IHJ1bigpCgo+Cj4gPj4gKwo+ID4+ICsJdWZmZCA9IFNBRkVfVVNFUkZBVUxURkQoT19DTE9FWEVD
IHwgT19OT05CTE9DSywgZmFsc2UpOwo+ID4gTWF5YmUgdGhpcyBvbmUgc2hvdWxkIGJlIGNsb3Nl
ZCBpbnNpZGUgcnVuKCksIG9yIGV2ZW4gcmVtb3ZlIGl0IGZyb20KPiA+IHN0YXRpYyB2YXJpYWJs
ZXMgYW5kIHBhc3NlZCB0byB0aGUgdGhyZWFkLCBzbyB3ZSBrZWVwIGl0IGluc2lkZSBydW4oKS4K
Pgo+IEJ1dCB0aGVuIHdlJ2QgYWxzbyBoYXZlIHRvIGZpeCB0aGUgb3RoZXIgdGVzdHMuCgpObyBw
cm9ibGVtLCBmZWVsIGZyZWUgdG8gbGVhdmUgaXQgdGhlbiwgaSBkaWRuJ3Qgc2VlIHRoZSBiaWcg
cGljdHVyZS4KCj4gPj4gKwo+ID4+ICtzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4g
Pj4gKwkudGVzdF9hbGwgPSBydW4sCj4gPj4gKwkuY2xlYW51cCA9IGNsZWFudXAsCj4gPj4gK307
Cj4gPiBZb3UgYXIgbWlzc2luZyB0aGUgcnVudGVzdCBlbnRyeS4KPgo+IFRoZXJlJ3Mgbm8gcnVu
dGVzdCBmdW5jdGlvbi7CoCBGb3Igbm93IEknbSB1c2luZyB0aGUgb3RoZXIgdGVzdHMgYXMgdGVt
cGxhdGUuCj4KPiBCZXN0LAo+IFIKLS0gCkFuZHJlYSBDZXJ2ZXNhdG8KU1VTRSBRRSBBdXRvbWF0
aW9uIEVuZ2luZWVyIExpbnV4CmFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20KCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
