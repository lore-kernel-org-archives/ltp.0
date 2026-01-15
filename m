Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD238D44C42
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 13:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768483263; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=a9HOy4gDV5n38xbS1s2EW/BeNRz0YZXJRxg5XUcYd8U=;
 b=JvpPxZC8ig+nwye/daqjPKjdEIY6UntdAhAKcMS95hPYF57vRQRb+XY2WspCbsjNJ+09v
 Rv8sK1GxLkYEyjdMTLUp9q1UzXy8aNN6KKkWbCvKR5p0VZTJILZy5FBqzBdNcB50bYKGy9C
 kySSxpW3xRBjek84E0qJEYvfkdiH740=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5182B3C9FA8
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 14:21:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 246793C5A01
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 14:20:39 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A1D2B600BD9
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 14:20:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768483235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HnOZHY78oGID08UojRfjm0IfMWpvK9r4L+z3ZlBJLhU=;
 b=bNUiTBii/nik85fvswkZO2sF0BAevH2YxxdomGXwVw4xJw8Ij0Qu5Bc2QRUTsekWHEyHWx
 wkGMXZzaipdjGsXwBeDU1eCp9mzZMZ2HI8awGl+n9jjg++wHWqtMMoOEoWx2HmpPRNkTUD
 0LBcLkEqtCv+CCODK4sXEtF/mgvDdfM=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-Ap-mCurYO8SdqL3hp3dUDQ-1; Thu, 15 Jan 2026 08:20:34 -0500
X-MC-Unique: Ap-mCurYO8SdqL3hp3dUDQ-1
X-Mimecast-MFC-AGG-ID: Ap-mCurYO8SdqL3hp3dUDQ_1768483233
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ac39bd5501so937476eec.0
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 05:20:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768483232; x=1769088032;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HnOZHY78oGID08UojRfjm0IfMWpvK9r4L+z3ZlBJLhU=;
 b=B+Tr8wTGl0uHQIG+Q5zB3aeWAV0IqDYZmp75w828cEFittduSRVFI2mWQNZ+WhuQ1a
 8kGbAAnd5a22ECEYy8UFdrllR/n8BDgYz7lkxzYGF+uz4rIP+whpOcbsrG2OMQnxJyHD
 yVIsYWsLpboxQX9MYhv8niRhP3y+gnGjVGo/2pE/zyzj1SC4jBduqcxbMOaUwy2BpjFh
 DYXeiF8vLxvdqgHbFlcG5A2IzqNZolxXJXaw/IrSxyyN06GI2z9eqguBo7WXuC7ayYdI
 rll219rVTSe6TXZ4fU1tJEGwryDBhA6vSI+q/iLjJ+hP5IEpr8t/WNbeK3q5xhtDMyWx
 Ylsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvtmSR7g5YpV6vwzxq7ZTfo09M7K+vE/yyNevxAOpQB6ZLv4XpMwavTXSPzC7MX1URmSk=@lists.linux.it
X-Gm-Message-State: AOJu0YxGMwjaKyfNR6YsQhJx71B0MK5ZaOHZDkYbEiC4lHQRWOK4557o
 LTAfy5+CxoHsYeHhrRep9donvMdXwWJZiZNo6vNKoQH/jUHRr1Tr0FJYln5OzXnteKGGhh6Mz6I
 Do/bGBA0vbDbACByNk/5s04mv7yhocAKw9pufwX/rglmWyGpSBr1CXxTg1ADbH+T4wJ97Ktvw/Q
 GVTZg2pfwg32Vlcww9DupbRL9jCaw=
X-Gm-Gg: AY/fxX5twKI0plfT+AFXQOW6BpAwjN1W1nG4GHiR1nNCIm7TJSi82ILWFV2Sc81TDUH
 wFdmg6N3cegcGuZz9wN4nlLAH/dkAoCUMg7kSc45MU4g+9sqh623GuMIhl86pdI8ppLh0xP8F1P
 D/Zisai/ZiWsyBvqTSZQq4jJp7D+qGHbNS2dsUB68fZDH/3RYlf4oXQv6fAmBG2DcS06g=
X-Received: by 2002:a05:7300:3082:b0:2a4:7b58:1a25 with SMTP id
 5a478bee46e88-2b4870873dbmr9024607eec.27.1768483232592; 
 Thu, 15 Jan 2026 05:20:32 -0800 (PST)
X-Received: by 2002:a05:7300:3082:b0:2a4:7b58:1a25 with SMTP id
 5a478bee46e88-2b4870873dbmr9024446eec.27.1768483229685; Thu, 15 Jan 2026
 05:20:29 -0800 (PST)
MIME-Version: 1.0
References: <20260114133548.411077-1-pvorel@suse.cz>
 <DFOCQI9JL96T.HVZEHA37O52I@suse.com>
 <CAEemH2fxiAufSaRm9XOJNDh+FG-4ufVEPrjoYi58-ZdJ8oB8iw@mail.gmail.com>
 <DFP293X2K7JS.5UW00YLFRX4R@suse.com>
 <CAEemH2dyAQfuBwg9T1DJL9j_xYKLCC9TNQRobM1063smkdJpgQ@mail.gmail.com>
 <DFP30EO5EZ9M.1UTS5YNH9SX7J@suse.com>
 <CAEemH2c0CpvpTNgoSn9WPGU1MQkgPWjiZ4fOmFpaxgziEZjnUg@mail.gmail.com>
 <DFP6LKYFDHBJ.2NJJ4I23PIGP9@suse.com>
In-Reply-To: <DFP6LKYFDHBJ.2NJJ4I23PIGP9@suse.com>
Date: Thu, 15 Jan 2026 21:20:17 +0800
X-Gm-Features: AZwV_QiWFFZ0s-2Bss4ILBF8b-EWkA6uJcAUqMfgniVkBw76Q3TCarJounibZ2o
Message-ID: <CAEemH2euoF+A05XEQXbxMo_MfC4wL0Zo2mh_YpTtC8yR2rHOVw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r6AqSIlDF74KsE7MBuoo7NYSfINcRDqEJVl9BhyiRfI_1768483233
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] kirk: Update to v3.2
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

QXdlc29tZSwgdGhhbmtzIGZvciB0aGUgdXBkYXRlIQoKT24gVGh1LCBKYW4gMTUsIDIwMjYgYXQg
OTowMuKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8KPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+IHdy
b3RlOgo+Cj4gSSB1cGRhdGVkIGtpcmsgbWFzdGVyIGJyYW5jaCwgaWYgdGhlcmUgYXJlIG5vIG1v
cmUgcmVxdWVzdHMsIEkgY291bGQKPiBjcmVhdGUgYSB2My4yLjEgZHVyaW5nIHRoZSBwcmUtcmVs
ZWFzZSBwcm9jZXNzIG9mIExUUC4KPgo+IEkgd2lsbCB3YWl0IGFuZCBzZWUgaWYgdGhlcmUgYXJl
IG1vcmUgYnVncyB0byBmaXggYW5kIGV2ZW50dWFsbHkgY3JlYXRlCj4gYSBuZXcgcmVsZWFzZS4K
Pgo+Cj4gLS0KPiBBbmRyZWEgQ2VydmVzYXRvCj4gU1VTRSBRRSBBdXRvbWF0aW9uIEVuZ2luZWVy
IExpbnV4Cj4gYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQo+CgoKLS0gClJlZ2FyZHMsCkxpIFdh
bmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
