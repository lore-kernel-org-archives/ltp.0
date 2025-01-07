Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A599E77197
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 08:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736239877; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Mmsf665el5FbAYkjUWiyNCZfPmQ7c9MoJoAGNcDmEDk=;
 b=KouqZCdGUPgNfrKCVs8yd96EaGbpKRH/BEccf9EsK8vnRVIoZBboM5bx5jB7rTk1hZt1y
 2MsaiIaw2N0AJ/GpADLjCwFvPxkRvp1hUlaSYUr3QkYTQpqlQT5hIztGcdVEjT2OmLyqBJi
 xLjXNycmCxGNRz/ehotDPAn7V6rw1uM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8497C3C031D
	for <ltp@archiver.kernel.org>; Tue,  7 Jan 2025 09:51:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98A8D3C016A
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 09:50:57 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED0D01010C0C
 for <ltp@lists.linux.it>; Tue,  7 Jan 2025 09:50:56 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so172890805e9.1
 for <ltp@lists.linux.it>; Tue, 07 Jan 2025 00:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736239856; x=1736844656; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DgGf32DZh2VLEoll1G8Zl9EJIs6qjQiDUytYuJkC9HQ=;
 b=WUEQvsKDzLpHqA+f5k2j2FbZkG21R13IP+K6fqJmPhAlsm+4c2H/8sMimitsvUC92c
 IltFP6yjIm7/SwJ4HvArU0D0kEEtOah9ICajITlmaMlVewcAeXJXmdalqfK1Nj8fD8RJ
 bWaZQRQ0nN1lxKG3Udy/XvoJ3z4XAQXqAXe0M85wmqhcBbBIN/vWfhgLiN1/QrPLJNjg
 FPZ1e0o2fIHWQ5/M/UrR3X8sFY/UYR8fXTI4XbIPO2KC2gI7z2t8OrlmIVq4P2p8TGTo
 bWXjgo3R6JbtqEF/TvOc39hMFy0SjmR8h72ob3lhKLviIuMvobH0ZdCh5rBEZ3/jbr0i
 Rp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736239856; x=1736844656;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DgGf32DZh2VLEoll1G8Zl9EJIs6qjQiDUytYuJkC9HQ=;
 b=k7NoP84n+0xf/SYCjIlVpe5NS3S+W0lcVRMxNkqB8/MiI/dcgX/MktVEN3lO0l2A5T
 yS8PJVujyqqjJwSztgY7wdikyrjIo14kQYPmMzmI1l5R4+3mqMnH87hcGQ79ixwFYZAc
 rIpmrC1YFKPZjfrJFaY2jGQblGush8fMpy3o4miyvJ/eGs22h76lBiaX0P7Hb27AdXsI
 0wxIosE7yFGEoWRFPIxFkADB+WQZmYB9rJHTBSK9fbW5SCZ/MLPvl3iqF2oyZ2nloLUq
 B4lc9aa5VpUbudzy3VP3O8sMIEnLNN4wGx2pZavXRWhFw9d+JI3a0jMUeTvzcM/5FWNa
 i2Eg==
X-Gm-Message-State: AOJu0YxxRUneiiD8/tn3xEZtIQl4B+gs6sUIvDq2YEL4zCXOEQZWJDpy
 oxRu0koojhy8AmTwJvV9JsvNFI7Qpt3VLvj25E4sU0p0cdz3TYS6vH6F6f97sjQ=
X-Gm-Gg: ASbGncvPghXCQ9HY7sm0UxKtmu+8czNd+B59uHVJR+SPyU5NDUfKTbuWJfrE/EBJX8C
 yGghs+DWWlMqw6wrbHAMgH2IyhcrYNSRazL7nfCaaK2rXaotKZxjieYzwHiwwCU7N9bvz75+rZG
 12vjIlTg2AS37v4e1lSXrpj1A+YlQRH+Z0tKDvBdyouYWJCSstwfpyaJPzRZS/GCe54ktfaJ+iL
 IB5Zz7SACf04meGrjAls6sxUUzWusg6W3vlD+IxC28rgJe0g7sOOa9C17jPfLPnO2VHPMv+bAhb
 fphs21K1shttbjVtWLazJoG4RZygjOJKEdK95493lPgkmbN03D6c0GiXpF+7EEQ7xhX1LKAv87S
 vJz/CypJYloOFFq292rU=
X-Google-Smtp-Source: AGHT+IGTN03+SFVa+H9CfLLHrj1nOKXnHjFGcKOdiYzFBiDSe/oFgePAyKt8ucAJyvwPcGmv+6zkjA==
X-Received: by 2002:a05:600c:468f:b0:434:a815:2b5d with SMTP id
 5b1f17b1804b1-43668b785ddmr477146515e9.24.1736239856318; 
 Tue, 07 Jan 2025 00:50:56 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6d02sm632551445e9.1.2025.01.07.00.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 00:50:55 -0800 (PST)
Message-ID: <b1831052-ed6f-4a3c-9d9f-4e63be30c035@suse.com>
Date: Tue, 7 Jan 2025 09:50:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
 <20241112-lsm-v1-2-e293a8d99cf6@suse.com> <20241218185508.GA77804@pevik>
Content-Language: en-US
In-Reply-To: <20241218185508.GA77804@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/7] Add lsm_get_self_attr01 test
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
Cc: Casey Schaufler <casey@schaufler-ca.com>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIDEyLzE4LzI0IDE5OjU1LCBQZXRyIFZvcmVsIHdyb3RlOgo+IEFsc28sIGtz
ZWxmdGVzdCB0ZXN0IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2xzbS9sc21fZ2V0X3NlbGZfYXR0
cl90ZXN0LmMgaXMKPiB0ZXN0aW5nIGFsc28gZm9yIGN0eCBiZWluZyBOVUxMLiBUaGVuIGl0IHdv
dWxkIG1ha2Ugc2Vuc2UgdG8gdXNlIGl0LgoKTm93IEkgcmVtZW1iZXIgd2h5IEkgc2tpcHBlZCB0
aGlzIHBhcnQuIFRoZSBrc2VsZnRlc3QgaXMgY2hlY2tpbmcgaW4gCnRoaXMgd2F5ICh0aGF0J3Mg
aG93IGxpYnJhcnkgd29ya3MgYXBwYXJlbnRseSk6CgpURVNUKGN0eF9udWxsX2xzbV9nZXRfc2Vs
Zl9hdHRyKQp7CiDCoMKgwqAgY29uc3QgbG9uZyBwYWdlX3NpemUgPSBzeXNjb25mKF9TQ19QQUdF
U0laRSk7CiDCoMKgwqAgX191MzIgc2l6ZSA9IHBhZ2Vfc2l6ZTsKIMKgwqDCoCBpbnQgcmM7Cgog
wqDCoMKgIHJjID0gbHNtX2dldF9zZWxmX2F0dHIoTFNNX0FUVFJfQ1VSUkVOVCwgTlVMTCwgJnNp
emUsIDApOwoKIMKgwqDCoCBpZiAoYXR0cl9sc21fY291bnQoKSkgewogwqDCoMKgwqDCoMKgwqAg
QVNTRVJUX05FKC0xLCByYyk7CiDCoMKgwqDCoMKgwqDCoCBBU1NFUlRfTkUoMSwgc2l6ZSk7CiDC
oMKgwqAgfSBlbHNlIHsKIMKgwqDCoMKgwqDCoMKgIEFTU0VSVF9FUSgtMSwgcmMpOwogwqDCoMKg
IH0KfQoKSWYgdGhlcmUgYXJlIExTTSBpbXBsZW1lbnRhdGlvbnMgaW4gdGhlIHN5c3RlbSwgImxz
bV9nZXRfc2VsZl9hdHRyIiAKd29uJ3QgcmV0dXJuIGFueSBlcnJvciBjb2RlIGJ1dCAwLgpJZiB0
aGVyZSBhcmUgTk9UIGltcGxlbWVudGF0aW9ucywgdGhlIHN5c2NhbGwgd2lsbCByZXR1cm4gLTEu
CgpBbmRyZWEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
