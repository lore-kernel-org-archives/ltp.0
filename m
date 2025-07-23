Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B024C83F34
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 13:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753279195; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=eAmx4bJY4hb0Urjng6rIONb2tv+Ly/4vScZi9kH8ODk=;
 b=ULQDLjUeVzuVoUGMGntjcpbxMDnr/LhqbO6xyoyrkX2Ar2wPxn70qAzKgVpfN+uTPmbAs
 uvS5v33j7qrcw0NTNSOccGqYJZuFWTfVIljB0+jsPDok3XP2v2weLFpeonjx26+wxabDf7f
 N0XJGM/PSvSm63z33E9IC9+QX55Cw9o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 796EA3CCD4A
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 15:59:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C04B73C57A8
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 15:59:33 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 10B1E100047C
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 15:59:33 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so4776134f8f.3
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753279172; x=1753883972; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AI5GNye/0eSz3Ew63RK2W4CYPz6K1EW/MwCtJaMQPSE=;
 b=I+3fzCIqCzR8gwkgCLNxQxtPkclNlAMG3fVi63hZcSg1GYm7Azzdpdj9YgfyxjO+jU
 kBNTtHuYni/x9wqafnAaA5adGn76piDqtqhIzWwZ9A14OCnF83itlXgBBojQlSzk2yTa
 sXFzsSX5y/Bw+hRYteFIYurxraCCkHEQt5ZtO1RQKkbE5QZFWI4CjC7a4SpsolW8GNDe
 Xu8/jPDGVEffuQ8CJcmJk0l0xaIZz2Fm1IhQeWakKf+GJzca2xbQSegBOpMN4lFr4fTJ
 +axGf80Gz7X6/Om+R3F6BXF8fZt/n0xWUdrktiqEALmEyPz4HrpM93mqA6C2ZTu5BvXw
 u6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753279172; x=1753883972;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AI5GNye/0eSz3Ew63RK2W4CYPz6K1EW/MwCtJaMQPSE=;
 b=QPp5fz7ymCDRMcSuUTFGnCC/lw4s1yHb6kVq4f7tIkgVCSTDmiczfvz2Dsm/1DvpdE
 LKvUCr7HK7hx7Z7jAosbJB78RV0FwOSU7V00ZgeoTG4u5HcdHJqBzhR2Hfmp3S3yn0vG
 Jlwz7IWNkc28DqZsl07uQZFiwd5fT2yDWhudaxN8BQwCIKSXM262XHzQsiRx+H3lUQEP
 9pCVVupB/bQmrlPmnunF2BdjmAXhM/DIl66V/LNX2VL+U3OOhFfMnhRTSETSyQHoEVXi
 WsM0pkRBUrJp5Pr6Xbpq/c9j0BbSOHdFefwKpicawpjL2toOd2DcnLS/jzj1MZTcOH5j
 RITg==
X-Gm-Message-State: AOJu0YzH5JzWhZ3Dsr+lfZ4868v0B+uJHyT7DN/dPefa+o7Hkgqrd3yf
 HbHwOAjjir23n6/kj32sSgOcFEczIzEiYRBpXXJjGBlqTEhNkndusNNFP043qGZbBXo=
X-Gm-Gg: ASbGncsKyOUZEbTLAewS4L4V6pYa67b3cZ3L5rQDUTRzA2kVBEbLIx4/Zp1SfGYjzoS
 KQh/za4S+lJ2jqpKPsgrK7yYMcAR8kq2Vk99NHHVcjAa/176js3kBhM6KjP3KHYHYyccXh8Q9qL
 hPwDl3M3bGofyO+uep8ncYfTanM8faBq/qD5+US8i2sOuoR4AhGy6iPXA/vZRgie7wkvzx63Pd8
 zRBbpauZSlupB5C5tNqPf0+Y3p4oZ8inGzaI3QobVrv82HrzTEwx17ciTFuyuBIBZQxIiU7Iszu
 ZwXzd0Km/Jaee6mNc+2vtZX0GSbhjYp2n4HH99dMAk7W1WXmoQXK09VpgUkz5q73eyBoh1t/iyr
 gbPnkkuxd1vlSlTPQtPRbZ28wdsMIgHKPqGOqtEoXNdmFa+K83QQ/n8UmIGMWOIktdrng/jNxkT
 OixHezkuStZRAj5G8pWiPwbO76BXb3f77sGMGeJU35eWKcQhTZrIoPiIeKNDAmmg==
X-Google-Smtp-Source: AGHT+IEYsqZT6q7yzXCETnw3psDCy+3RGMWElBQ2ifVV7SEua7i5C31zxCKfZIarCh6eusq6B70IwA==
X-Received: by 2002:a05:6000:2283:b0:3a5:2e84:cc7b with SMTP id
 ffacd0b85a97d-3b768ee046emr2857069f8f.11.1753279172358; 
 Wed, 23 Jul 2025 06:59:32 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759c84e2c91sm9613794b3a.5.2025.07.23.06.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Jul 2025 06:59:31 -0700 (PDT)
Message-ID: <e22bb254-b97c-4866-900c-126d7f06ffd8@suse.com>
Date: Wed, 23 Jul 2025 15:59:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250707-ioctl_pidfd_suite-v3-0-22ba4d15ee02@suse.com>
 <20250707-ioctl_pidfd_suite-v3-8-22ba4d15ee02@suse.com>
 <aIDe4n_4kTZE9feR@yuki.lan>
Content-Language: en-US
In-Reply-To: <aIDe4n_4kTZE9feR@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 8/8] Add ioctl_pidfd06 test
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

T24gNy8yMy8yNSAzOjA4IFBNLCBDeXJpbCBIcnViaXMgd3JvdGU6Cj4gU0FGRV9DTE9TRShwaWRf
Y2hpbGQpIGhlcmU/Cj4KPiBPdGhlcndpc2Ugd2UgZW5kIHVwIG91dCBvZiBmaWxlIGRlc2NyaXB0
b3JzIHdpdGggbGFyZ2UgZW5vdWdoIC1pCj4gcGFyYW1ldGVyLgo+Cj4gT3RoZXJ3aXNlOgo+Cj4g
UmV2aWV3ZWQtYnk6IEN5cmlsIEhydWJpczxjaHJ1YmlzQHN1c2UuY3o+CgpEbyB5b3UgbWVhbiBw
aWRmZD8gSW4gdGhhdCBjYXNlIGl0IGhhcyB0byBiZSBhcHBsaWVkIGFsc28gZm9yIHRoZSBhbGwg
CnRoZSBvdGhlciBwYXRjaGVzIGFzIGZvbGxvd2luZzoKCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsX3BpZGZkMDYuYyAKYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2lvY3RsL2lvY3RsX3BpZGZkMDYuYwppbmRleCBkZjRiZWMzODQuLjY2Yjk2YTI5
YyAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bF9waWRm
ZDA2LmMKKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pb2N0bC9pb2N0bF9waWRmZDA2
LmMKQEAgLTQ0LDYgKzQ0LDEwIEBAIHN0YXRpYyB2b2lkIHJ1bih2b2lkKQogwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIFRTVF9FWFBfRkFJTChpb2N0bChwaWRmZCwgUElERkRfR0VUX0lO
Rk8sIGluZm8pLCBFU1JDSCk7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXhpdCgw
KTsKIMKgwqDCoMKgwqDCoMKgIH0KKworwqDCoMKgwqDCoMKgIHRzdF9yZWFwX2NoaWxkcmVuKCk7
CisKK8KgwqDCoMKgwqDCoCBTQUZFX0NMT1NFKHBpZGZkKTsKIMKgfQoKIMKgc3RhdGljIHZvaWQg
c2V0dXAodm9pZCkKCi0gQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
