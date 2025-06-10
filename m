Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CD0C5B543
	for <ltp@archiver.kernel.org>; Tue, 10 Jun 2025 10:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749552411; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=zOOz/B5SCff4KRQrxf94Cifh6Zz7ZIx+n1QanCvR8v4=;
 b=jyvMzKu8pSlM5TLZczpsviRyBf3VdYJFF8rYba95Yip55aEjgxQcqouuKr5RP80zXTIj/
 L/FOshxxgbweH+P8W3kM+vC6klxk8p46wnk5+TxUtxc8Gr1twvVUf3Vzdt1wbodVETCXyQp
 lmaL7jUCSMHTw51Fh5ZWNXSBPY4jiJ8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAC4D3CAED7
	for <ltp@archiver.kernel.org>; Tue, 10 Jun 2025 12:46:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60F403CAE2C
 for <ltp@lists.linux.it>; Tue, 10 Jun 2025 12:46:30 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 327E61A01168
 for <ltp@lists.linux.it>; Tue, 10 Jun 2025 12:46:28 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so45664025e9.2
 for <ltp@lists.linux.it>; Tue, 10 Jun 2025 03:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749552387; x=1750157187; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0WV5STcEeuBEKN0R3RWmfpxgJmej064QeqK7Gs37GFw=;
 b=JZ9/NLC4Zlml3cGGrtkiFH8FbJNNwAzOfeDj6DVZ47ewhsg15NaiIFH8ZvaXiaCRUR
 p4avrLeronNZeqaR1BGt+R7tu6ty2HE/g5L2vOjTWBECSnjBSWrMVFWyWOXWyS19xMT1
 JlM0Rtl7awzlIMsdfLpa3xaEK15H5y+QRipUphPuYkGTFYnCdhXO1cAn9diw2mhRUvit
 QzHjbiYbG0bjE5w1VoEYOn3h9vsXtAZHG/AJpvlybjk0BVXEXRnpXFPScE+FqUW6wic2
 9/vql4wR1MGnxVTPkLxR7KDVtHSjh66+DCeaJ7ggcZxtRIyP/enAvmJGPkmBRPeW52yO
 y3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749552387; x=1750157187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0WV5STcEeuBEKN0R3RWmfpxgJmej064QeqK7Gs37GFw=;
 b=wuBBfDenr0xPnPTXwJmVehcCTBlyPH2x4ERA9MTMKXp6mj1Tr5IXQCyVWVSlOrfy4R
 2SCiEv7Sod2WgRtTnO4HPVob4vSwwHyeaSCCeS+kl1XlIeVfhQLnb9NSGQ5UpiKSOLQm
 YOxRhjRVFNrcHJmDOxCztr9ZsjQ14BM30E9l98srqUVhdFmeTxsSzjUpwLxt74hDc5hw
 ZMIq6FVr+ot/FK51gC+jQcFyp8qmWf+jsCTqpc+3aEoHRpudU/CwTMkj4AduZriqNGdS
 iavc+r/aMOkfFLgrR66ZE5SxKAGxSNTTGXw6K30YrUbfaRfH1X31Ge7JfhaqbbS9Svkn
 Rb7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8nBLrDYygFkzqTGC6Xxv1NXErw+kpZ86r+gEV1ItxReymgEKTQcC9pPAlITI8itRx8Ok=@lists.linux.it
X-Gm-Message-State: AOJu0YzNb9JWRUN7Gl78yS1CXgOSH7CO9GQYfKSehrX66JpiMuWPU0ik
 I46zJ9l2eYGfWcvxLvdT3nJVV8ptwYgAxz1VHHTS2I9zA1I2CCVTY4kuzULsEFc/Sug=
X-Gm-Gg: ASbGncum1Tzqa+OeqYXc2QpQatzKEhzMTfuE7o8XSj+XuKiS9rqhJE05tSccqzS+CQu
 1qs1b6CsPqIri34uemhGK5bANVzGMqjJtnoTdYq0u7/ecs5u8PWkU0x23KKr+bDT7/0/7yNl89y
 6VxljB3wKhxifHVC1i5b9ewX3tNj8LkPtk4U1KgIYlobf8Qxe8Jor0fst4YAmxRVWFLkKosY70U
 9g8r0hnNPo6WD7/8JbIFPGAUNIffXKEmSGWGRxIjesLiRYsfASiSjyvQ/7AKjaOMkfaFkf/oVYH
 eiBB5Nrjp6VCB9IqSq7aem+GgoXhw31qhpxVnZ3cxrT6YkQG6yYMvni46vxz78NZbrRYRHFq9BO
 PXw1Ma5MjmBeugwQSofz4o4roqzb+hdyT11uRY5dDdZxC4hO2QZ4y6ks+NJ5fQ4q+dQaoQO8+KU
 zRrurOIcnHEkW0c9+4ylZZSfkN
X-Google-Smtp-Source: AGHT+IHEVA6NyzBWQVYJxwqStXJdTzan4QIDAwdcc4PfOVp6+RBlkgQ7SRAs8ZIos5hiIRbp77Vjgw==
X-Received: by 2002:a05:6000:240b:b0:3a4:f8fa:9c94 with SMTP id
 ffacd0b85a97d-3a531caa070mr14051465f8f.13.1749552387485; 
 Tue, 10 Jun 2025 03:46:27 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2363ad3492esm7823475ad.154.2025.06.10.03.46.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 03:46:27 -0700 (PDT)
Message-ID: <0139d8be-66d6-4159-8a6e-30727769935a@suse.com>
Date: Tue, 10 Jun 2025 12:46:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20250610104538.15687-1-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20250610104538.15687-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: Add testers guide
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQ3lyaWwsCgpPbiA2LzEwLzI1IDEyOjQ1LCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gV2hpbGUg
d2UgaGF2ZSBhZGRlZCBhIGRvY3VtZW50YXRpb24gb24gc3VwcG9ydGVkIGtlcm5lbHMsIGNvbXBp
bGVycywgaG93Cj4gdG8gY29tcGlsZSBhbmQgcnVuIExUUCBldGMuIFNvbWUga2luZCBvZiBhIGNv
bXByZWhlbnNpdmUgZ3VpZGUgZm9yCj4gcGVvcGxlIG5ldyB0byBMVFAgYW5kIGtlcm5lbCB0ZXN0
aW5nIHdhcyBtaXNzaW5nLiBUaGlzIHBhdGNoIGFkZHMgYQo+IHNob3J0IGd1aWRlIHRoYXQgdHJp
ZXMgdG8gZXhwbGFpbiBzb21lIG9mIHRoZSBwaXRmYWxscyBvZiBrZXJuZWwKPiB0ZXN0aW5nLiBG
ZWVsIGZyZWUgdG8gcG9pbnQgb3V0IHdoYXQgaXMgbWlzc2luZyBhbmQgc3VnZ2VzdCBhZGRpdGlv
bmFsCj4gY2hhcHRlcnMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4KPiBSZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0
b0BzdXNlLmNvbT4KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4g
UmV2aWV3ZWQtYnk6IDogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+CgogwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBeIHJlbWVtYmVyIHRvIHJlbW92
ZSB0aGUgY29sb24gaGVyZSBiZWZvcmUgCm1lcmdlLgoKQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
