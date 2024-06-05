Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37DDC25B76
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 11:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717587792; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=J3sXLMBuORgYbZdiXecsjI0C4dBcr+Kc0etCLXMumIs=;
 b=GKhRFU2lS95sHZ6M/26dJc/pKjxc3p4YHcO6xkH/Nv2ntbLRRtgd/z/eSIsagI8534hPo
 H9chzKWvlfXOVjkQa2G72fxcHDgjsx48lPJAZYaYp7+lVLMMkYEXfjdIgE+SgrektmgDkIi
 OoqH85Tj1F1D1MRrmskFE/atmsm0AX0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B4373D098B
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 13:43:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 482DD3D0964
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 13:42:49 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4277E100095F
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 13:42:48 +0200 (CEST)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2e78fe9fc2bso94525741fa.3
 for <ltp@lists.linux.it>; Wed, 05 Jun 2024 04:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717587767; x=1718192567; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AA59Ykg0bNTHdj9M/UPYnuVcldJ4nfN/qrp7Nqi+nVY=;
 b=a+2Tuuhnw1p28fTDKprF8KCtOYbScvg6wmO+C/J4F+ZaUWW4tCMnRP/D6CcgP+b0ld
 3Oy1unuUEP5YS3oEcz5lmuMfhMWIRF6fPCGfTL0y/WMjkkdQ+eXLoDY2UJxQ8lQDZcRX
 iBQPcGufLWFpWBkICdEceRUHh7KRyr/twRY41GoHl4hc4mk9QwUUnWuixJK40L4d0kLJ
 OocY84OHDKIXWaD80+YEjpswbaddqn8WWYIYV1SCkmEYmUanjC64Q5Xb/WsXU/HDUA/n
 m2mQ/8vPOvbKmeapWUSGOfojgjGPkn1FC9ODudWpbHF0I5JPjtV81Tx4anmrGSz5Ir/m
 SMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717587767; x=1718192567;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AA59Ykg0bNTHdj9M/UPYnuVcldJ4nfN/qrp7Nqi+nVY=;
 b=cD4OBWgvyxAFfchSBlNtXotIxVxRxEMNeYAa7tWdvctScgchFa5yZym4Uv6pd0JYGm
 9WFlPAdhyJrJjjWra7hpUSNT7PF+S2ipsjppXAOcA25o2p1cepQRvAB9V/4PeJH/Qzby
 8Tfn3BdtMims8k5tiX/o3LPa1RD3MMazlGMSq8PCbvDLpkqBLJhF/EvM5inpmaRaTSqu
 WS0j1UybVbdPykTMIjEBQaX4pFS9qD1T5hiEgbXPjzha8S/e/yVwQvpsNAQVZxOdGEBx
 zDayCzAnD7ngpNMLvnNjBLEmW5nL28BeCbkc9oyBAHd0OzzHxecFb5pC40ilgpCMwBBK
 rXhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9sdvqd84ceRnPE5qjMGZxmMG3bNHhWLKPS61SMjpRr0bWby0Osikf74m4raf9ciPhQQ5of+JyF1f3aiiNBKNtDMw=
X-Gm-Message-State: AOJu0YwYTMbKATyqhKa/2jvi3qz5wYL2nR/CFJZccu2tJyLFlaRz/5q/
 CnOuNOtE77k/59LeHA/8Ksjw7506kEGhqS9syKymIJgVAn+Nn54bEJw3ACZE4GE=
X-Google-Smtp-Source: AGHT+IHJdRuue21LD6sux0TRjs+auh5aXMrq0yUfobTn/gAIQbhIMomChfMwEhMG0Fl7CCBdj5EZ+Q==
X-Received: by 2002:a2e:968d:0:b0:2e2:2791:9842 with SMTP id
 38308e7fff4ca-2eac7a82a20mr12127891fa.44.1717587767418; 
 Wed, 05 Jun 2024 04:42:47 -0700 (PDT)
Received: from [192.168.178.40] ([212.86.36.118])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63232dd60sm99787795ad.38.2024.06.05.04.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 04:42:46 -0700 (PDT)
Message-ID: <b5b6925d-7a28-4ec2-976e-edda4bb675d3@suse.com>
Date: Wed, 5 Jun 2024 13:42:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
 <ZmAdqhv-VCWqJ3yf@rei> <58dbd04d-95f7-4e56-9ea1-2ef0a87d7f18@suse.com>
 <ZmBMWwO211DBrkI0@yuki>
Content-Language: en-US
In-Reply-To: <ZmBMWwO211DBrkI0@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix unlink09 test
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpPbiA2LzUvMjQgMTM6MzAsIEN5cmlsIEhydWJpcyB3cm90ZToKPiBIaSEKPj4+PiArCWZk
X2ltbXV0YWJsZSA9IFNBRkVfQ1JFQVQoVEVTVF9FUEVSTV9JTU1VVEFCTEUsIDA2MDApOwo+Pj4+
ICsJVEVTVChpb2N0bChmZF9pbW11dGFibGUsIEZTX0lPQ19HRVRGTEFHUywgJmF0dHIpKTsKPj4+
PiArCj4+Pj4gKwlpZiAoVFNUX1JFVCA9PSAtMSAmJiBUU1RfRVJSID09IEVOT1RUWSkgewo+Pj4+
ICsJCVNBRkVfQ0xPU0UoZmRfaW1tdXRhYmxlKTsKPj4+PiArCQl0c3RfYnJrKFRDT05GIHwgVFRF
UlJOTywgIklub2RlIGF0dHJpYnV0ZXMgbm90IHN1cHBvcnRlZCIpOwo+Pj4+ICsJfQo+Pj4gSSBz
ZWUgb25lIHByb2JsZW0gd2l0aCB0aGlzIGFwcHJvYWNoLiBJZiBrZXJuZWwgYWNjaWRlbnRhbGx5
IHJlbW92ZXMgYQo+Pj4gc3VwcG9ydCBmb3IgaW1tdXRhYmxlIGZpbGVzIGZvciBhIGNlcnRhaW4g
ZmlsZXN5c3RlbSB0aGlzIHRlc3Qgd2lsbCBiZQo+Pj4gZ3JlZW4uIEFuZCB0aGUgZmlsZXN5c3Rl
bXMgdGhhdCBtaXNzIHRoaXMgc3VwcG9ydCBhcmUgdmVyeSB1bmxpa2VseSB0bwo+Pj4gZ2FpbiBp
dCwgZS5nLiB3aWxsIHZmYXQgZ2V0IHN1cHBvcnQgZm9yIGltbXV0YWJsZSBmaWxlcz8gVGhhdCB3
b3VsZCBiZQo+Pj4gYW4gYXJndW1lbnQgZm9yIGV4cGxpY2l0IHNraXBsaXN0IGluIHRoZSBmb3Jt
IG9mCj4+PiB0c3RfdGVzdC0+c2tpcF9maWxlc3lzdGVtcy4KPj4+Cj4+IFRoYXQncyBhIHZhbGlk
IHN0YXRlbWVudC7CoCBGb3Igbm93IEkgd291bGQgbGlrZSB0byBmaXggdGhlIHRlc3QgZmlyc3Qs
Cj4+IHRoZW4gd2UgY2FuIGZpeCB0aGlzIG90aGVyIHByb2JsZW0gd2l0aCBhbiBhbm90aGVyIHBh
dGNoLgo+IEFzIGxvbmcgYXMgeW91IHByb21pc2UgdG8gZml4IHRoZSB0ZXN0IHByb3Blcmx5IGxh
dGVyIG9uIEkgYWdyZWUgd2l0aAo+IGFkZGluZyB0aGUgdGVtcG9yYXJ5IHdvcmthcm91bmQgd2l0
aCBhIHRlc3QgZm9yIGltbXV0YWJsZSBzdXBwb3J0LgpUaGUgbW9zdCBpbXBvcnRhbnQgdGhpbmcg
aXMgdGhhdCB3ZSBjYW4gZml4IHRlc3Qgc28gaXQgd29uJ3Qgc2hvdyBmYWxzZSAKbmVnYXRpdmUg
b24gY2VydGFpbiBGUywgdGhlbiB3ZSBjYW4KY3JlYXRlIHBhdGNoZXMgdG8gc3BsaXQgaW50byAy
IHRlc3RzIChvbmUgZm9yIGltbXV0YWJsZSBhbmQgb25lIGZvciAKRVJPRlMpLCB1c2luZyAuYWxs
X2ZpbGVzeXN0ZW1zIGZsYWcuCj4KPiBBbHNvIEkgc3VwcG9zZSB0aGF0IGl0IHdvdWxkIG1ha2Ug
c2Vuc2UgdG8gZW5hYmxlIHRoZSB0ZXN0IGZvcgo+IGFsbF9maWxlc3lzdGVtcyBidXQgd2Ugd291
bGQgaGF2ZSB0byBtb3ZlIHRoZSBFUk9GUyB0byBhIHNlcGFyYXRlIHRlc3QKPiBmaXJzdC4KPgpB
bmRyZWEKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
