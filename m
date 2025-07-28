Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EA4C87FC9
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753712741; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Xf85qytYgbiYIbAMiN4IUIFQYQTXddqhHnpDNWSgBzo=;
 b=Y9FjWehpXVVUIeBuZQNdjP3eMezyvsK1Vtnju6FtpOlfUWZczAWHZJBNQxKL46drjSmTL
 Lo68NqKA/sJfPaSrTHUZ1TKxys69OjqqeJXW/WsOImuRt4YM8ghmh+R8h2lVwVwU3m2WhG1
 /bHy1n+JiwkZyXOd/PkyZUlcP63Rrd4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 208D23C6391
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 16:25:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8B8E3C6391
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 16:25:17 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5405D1400C73
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 16:25:17 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso2285396f8f.1
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753712717; x=1754317517; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IunL292TLoHJBVN547W8uNolOLNh5FUe1UIVqoy+ym8=;
 b=VWd+X5mRkKdOVoWB+KTHwZ4IFVVQ7oFLRdzNv0xUAX/AEbBlaggNaEvOG8qYZza8Gm
 8Wda4T42YuXtAlb5sxA3Xlo54lpwrb9P5ywkY07cOCd5F/HSGf1cC8xAbZAQvR6FVVHo
 oLNhJD3SCdsfEB9SAIkHb2YmJxhhiQh/UodUgK4NCA3WkycfEhjxZkoecqISBZXETatk
 sDSTBQywbKx8w/NfZf9Zn0XqIcJmtFd6hL7GIz9/d6in3ZB5nY605peHIsyyIlbuKmgq
 mE3rCoGIsz/1wpXHsLQ0Us73spXd79FrBwkUGStSSXyU/crY2R6fHEk1L1zRjpxOUam+
 EszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753712717; x=1754317517;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IunL292TLoHJBVN547W8uNolOLNh5FUe1UIVqoy+ym8=;
 b=QW3zQtGsCvBLpXETlMRzUMNi6Cl/xvW5mHTa8cv2D5LSCgYlnu8lRDjTLpeYWp23NY
 27217a7H1QTQXwyr4p4P26n1n+fPXksWLtrAX8voN8z/KrBe8KboYwHm7Rr08cU+q0I+
 hBwQjHC+CnvJGUj8tvg/gRa+GWTgEBRW8wK0FbTJYz8yHYIWv1kMpoSNA6vXmNK2YZ/N
 7tFhn2YL0sHK0eykRiShnvRQsg7errZmRXdpJoRpmv8aD9x9X/ghYQFOSKmORD5OQgjy
 eSfcJ7Rh/cvBMAXTrqyWRKTGY/r9CBGrj9YsIWGYFcjiBJeyJNwooLuxuHgdYA4RFhFP
 pPIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSWgUJofe0lRX/4jNkFwYrMBkHXMMPoJcB1C0kzRUFp73tdVmBwSvr2KYtLrdAacr0Fzs=@lists.linux.it
X-Gm-Message-State: AOJu0Yz5btcO9ZXnAwmwBK5moecgrLZYziaY9JHVbBB3itGePCji398R
 1jLJrgMUSpNsqIXiOGV6yDmMMfqgqKVlA0bxRrZ6pPf28U++OM10iFcVMkbzRiMjMjk=
X-Gm-Gg: ASbGnctaYgqnr0qXA7srBLr1bH0N3tP/YR5j8SnrhY/RLS8jv6Elo4XbtjKH51EICmo
 +4+fOzte+a/MIP4Rl638HyT8EO5Cuzd7RcTMphhb1DVBvunJkidFQ/GUN9aasQkuYeDFgDat4C6
 wJs8Tvc874CygFZHXZobPbbvfkBn77VvvHCYF8R0CsZ1mty6GO/ynuyN+shvbhsmtV6DZDg/vRn
 z8nlkTNNQ0A87ClROqM1KXJb4hxyzeIq8VuSskXAqMZo7RYBEsNGWbHDnY30UhcEaet+PdTsoih
 g6rgC71NHRT3z7gkNjbjepwcp/5g7okevMJKkXfNS6OHyXn8sXiT4NGbTPxIAbGNwm3P5j/XLKl
 YehiV8JvVfg==
X-Google-Smtp-Source: AGHT+IF52TE3EfmYFDYvxwFz+3ov/hhsqrXq63qvDb/QB7vGA6i3MEBuC/FIAdTlAgqsbnDP1dRekg==
X-Received: by 2002:a05:6000:4313:b0:3b5:dafc:1525 with SMTP id
 ffacd0b85a97d-3b77663f17bmr8373295f8f.33.1753712716559; 
 Mon, 28 Jul 2025 07:25:16 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-31eb413d7basm4229745a91.16.2025.07.28.07.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 07:25:16 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 28 Jul 2025 11:25:13 -0300
Message-Id: <DBNR9UKU3J5U.22BZ9TZDVD6DF@suse.com>
To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>, "Linux Test
 Project" <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250728-fixes-munmap04-v2-1-17813370a0ee@suse.com>
In-Reply-To: <20250728-fixes-munmap04-v2-1-17813370a0ee@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/munmap04: Check errno while trying to
 exhaust VMA count
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIEp1bCAyOCwgMjAyNSBhdCAxMToyMyBBTSAtMDMsIFJpY2FyZG8gQi4gTWFybGnDqHJl
IHdyb3RlOgo+IEZyb206IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4KPiBJ
biB0aGUgbG9vcCB0aGF0IGV4aGF1c3RzIHRoZSBhbW91bnQgb2YgVk1BcyB3ZSBtdXN0IGNoZWNr
IG5vdCBvbmx5IGZvcgo+IE1BUF9GQUlMRUQgcmV0dXJuIGZyb20gbW1hcCgpIGJ1dCBhbHNvIGlm
IHRoZSBlcnJvciB3YXMgRUVYSVNULiBJbiB0aGF0Cj4gY2FzZSwga2VlcCByZXRyeWluZyB3aXRo
IGluY3JlYXNpbmcgYWRkcmVzc2VzLiBXaGlsZSBhdCBpdCwgYWRkIGEgc2FuaXR5Cj4gY2hlY2sg
aWYgbm8gcmVnaW9ucyB3ZXJlIG1hcHBlZC4KPgo+IFN1Z2dlc3RlZC1ieTogQ3lyaWwgSHJ1Ymlz
IDxjaHJ1YmlzQHN1c2UuY3o+Cj4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUg
PHJibUBzdXNlLmNvbT4KPiAtLS0KPiBDaGFuZ2VzIGluIHYyOgo+IC0gRURJVE1FOiBkZXNjcmli
ZSB3aGF0IGlzIG5ldyBpbiB0aGlzIHNlcmllcyByZXZpc2lvbi4KPiAtIEVESVRNRTogdXNlIGJ1
bGxldHBvaW50cyBhbmQgdGVyc2UgZGVzY3JpcHRpb25zLgo+IC0gTGluayB0byB2MTogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDcyOC1maXhlcy1tdW5tYXAwNC12MS0xLWUzMmVmMTFk
NTk0YUBzdXNlLmNvbQoKT29wcywgZm9yZ290IHRvIGVkaXQgdGhpczoKCkNoYW5nZXMgaW4gdjI6
Ci0gQ2hlY2sgZm9yIGVycm5vID09IEVFWElTVCBpbnN0ZWFkIG9mIHJlbW92aW5nIE1BUF9GSVhF
RF9OT1JFUExBQ0UgZmxhZwoKPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5t
YXAvbXVubWFwMDQuYyB8IDcgKysrKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvbXVubWFwL211bm1hcDA0LmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1h
cC9tdW5tYXAwNC5jCj4gaW5kZXggZTA0NmQxN2E3NWY4Zjc1YzViMTFkNTY5YzMzZGE0MWQ3YWRj
N2QwOS4uYWViOTA1Mjg2ZTlkNDIxNGFjNjQyM2VmMjZlOTU3MDY3NGI2MDUzMCAxMDA2NDQKPiAt
LS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jCj4gKysrIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYwo+IEBAIC00MCwxNCAr
NDAsMTcgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiAgCQkJICAgICB2bWFfc2l6ZSwgUFJP
VF9OT05FLAo+ICAJCQkgICAgIE1BUF9QUklWQVRFIHwgTUFQX0FOT05ZTU9VUyB8IE1BUF9GSVhF
RF9OT1JFUExBQ0UsCj4gIAkJCSAgICAgLTEsIDApOwo+ICsJCWlmIChwID09IE1BUF9GQUlMRUQg
JiYgZXJybm8gPT0gRUVYSVNUKQo+ICsJCQljb250aW51ZTsKPiAgCQlpZiAocCA9PSBNQVBfRkFJ
TEVEKQo+ICAJCQlicmVhazsKPiAgCQltYXBzW21hcF9jb3VudCsrXSA9IHA7Cj4gIAl9Cj4gIAo+
ICAJaWYgKG1hcF9jb3VudCA9PSBNQVBfTUFYX0NPVU5UKQo+IC0JCXRzdF9icmsoVEJST0ssICJN
YXBwZWQgYWxsICVkIHJlZ2lvbnMsIGV4cGVjdGVkIGxlc3MiLAo+IC0JCQltYXBfY291bnQpOwo+
ICsJCXRzdF9icmsoVEJST0ssICJNYXBwZWQgYWxsICVkIHJlZ2lvbnMsIGV4cGVjdGVkIGxlc3Mi
LCBtYXBfY291bnQpOwo+ICsJaWYgKG1hcF9jb3VudCA9PSAwKQo+ICsJCXRzdF9icmsoVEJST0ss
ICJNYXBwZWQgMCByZWdpb25zIik7Cj4gIAo+ICAJdHN0X3JlcyhUSU5GTywgIk1hcHBlZCAlZCBy
ZWdpb25zIiwgbWFwX2NvdW50KTsKPiAgfQo+Cj4gLS0tCj4gYmFzZS1jb21taXQ6IDZhZjYxOTU1
MmNlNzY3NjE3MWU0N2I4ODk2NGZmYjViMDg0OTliMzYKPiBjaGFuZ2UtaWQ6IDIwMjUwNzI4LWZp
eGVzLW11bm1hcDA0LTAyMDgzYzU1MGM2Ygo+Cj4gQmVzdCByZWdhcmRzLAoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
