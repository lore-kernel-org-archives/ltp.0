Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F5B6C87FC9
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1753712175; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=10ESkkREJSe6YmR1kChC7Shhjese/CoYEITXgqm+tbA=;
 b=RZmhVsKTZrnThzNoqd4YyPqfw4xhWxTy30ULpCDKD05gX92nclzp9xf0N5hzLwHF0xPLP
 towF371c5G2NjT1dUOLSb/szgM/sffShvcNvM27gcChdrifr2eMIgtfzQDJ0+gZCyEe8ptj
 3uf5pCF+IiQ3hoRaLTdFKawQ+BazGjg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 822E13C8A51
	for <ltp@archiver.kernel.org>; Mon, 28 Jul 2025 16:16:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA4C53C6391
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 16:15:54 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0AB9E200770
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 16:15:54 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so3247976f8f.3
 for <ltp@lists.linux.it>; Mon, 28 Jul 2025 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753712153; x=1754316953; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xTKQvB2aluDigwQpRO+wISvujhz+C0qoQxbJB6EltQ=;
 b=Xjqkaufs4ofZ7NJ4eOcA5dYjvqVpoEiUbfYwAt5f69K5KJg7pY4rN90xX1t0aCoM4l
 PV8OdGPNfdnNO3uNrVukxG7WkyjMBpNEHtPq16ak4WabM8BywfAPrlgszMRtFMp4X1q0
 j0NFd3lIPO0URHgCPz5wlXc1h4zBV/a4lIOIcOBtSNIZX+XXo9lwPBv3yXnpbgmypz9C
 T64Ot+KCXK/XqRFUN+dqZcOZWLXXQAhErWsRKnGy0qhbctpMc6Do0dfE/0yFJl5AVXLV
 /18xeOFKAQf72PX8XwMkl2ZyS6Ig3dwna57vfdEunCmI/iTy/QSLGMUg0r3SAwzmT6EW
 siFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753712153; x=1754316953;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5xTKQvB2aluDigwQpRO+wISvujhz+C0qoQxbJB6EltQ=;
 b=CkzwUmnyjTSWJ0I54eMsgKiUxf5gei020mD4URn+Utw4qauTCFHRfuUf/flvHOrznT
 uvKkRdoQf4aRmu2f6juKp97H9buvIE0gx9l4CbXix1czQ8HOj2JLrD+RPyaaV3ydYH9r
 g3CXwOXtxMKqyy57p3dqZckwJGQIcBXQDXy+CR3A6F5tscaztoNmlP79fzzRWfGH25ic
 Ogi14EEt/xMtsUWnKWL7bcdBXifYdu7U8HmWKobT7o29POpgWWxVsxuB1FlWGZFb7fwl
 arw0MD3A9049LLwSYocnVXY7yOW5Li84c1jk1D2uxkuUF7l9TwlQmnRjmoPDH1hQhvVT
 A/uA==
X-Gm-Message-State: AOJu0Yy/D7sXPphgonInDrYTO+UuPhIJZ1mhW9ChhPK0R33PGBV9ijPx
 g4aK5ffPyHZiu5j2hsrtQvwP7T724QOnN7uW1dqJ6Q+HlDntNNjjVZUTJZ1Acl/wNbw=
X-Gm-Gg: ASbGncsmxswlwbUD9VE8yDDimNG4Ev3XY0/JSCe2z0s364XDmvoL/yb80UG8eJj6UVc
 3W8GMNC2MxTe3h7UcJkIzf/gDrdJnL7sRz5L5AXJl0CTJiGSJowTkuphRoQgH3n4IQNa2tiyx8N
 61jM0/vjOA0rLe177IGAdxJk0WCkUJAUZVmgqV31EOdqGVSh38Z3wEQ/FOwqOw5C4CZgaqm/GVx
 R/9mT+eq9Afp3/0YoCL0cVfuv1pMBy9H0j7tGYKb3LCOc5Ewbf8Ak/+C4gsG+DEAswb68J5W2a/
 IQeY9KlB1Xae8r3stNiSlpa3v9JMNzY9Pizdsdp63YrLiK5h0X0YR9yMxYmqpHAHeCTFozrgNtO
 mKJDOj64+oQ==
X-Google-Smtp-Source: AGHT+IHFgH6il0zomHmRNW4k7rS701+tLTn3eYB2SFLvngpNsG1GT/Q+nwyjyP31Y2YBmOD/Q5D1QA==
X-Received: by 2002:a5d:5f48:0:b0:3a6:e6c3:6d95 with SMTP id
 ffacd0b85a97d-3b77667930cmr7584295f8f.41.1753712153149; 
 Mon, 28 Jul 2025 07:15:53 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-31ecd3cc1b5sm3417703a91.17.2025.07.28.07.15.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 07:15:52 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 28 Jul 2025 11:15:47 -0300
Message-Id: <DBNR2MGNOVGI.OWYEHXUYQ5XZ@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250728-fixes-munmap04-v1-1-e32ef11d594a@suse.com>
 <aId9ge006B4Z8RDY@yuki.lan>
In-Reply-To: <aId9ge006B4Z8RDY@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/munmap04: Stop using MAP_FIXED_NOREPLACE
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIEp1bCAyOCwgMjAyNSBhdCAxMDozOSBBTSAtMDMsIEN5cmlsIEhydWJpcyB3cm90ZToK
PiBIaSEKPj4gT24gc29tZSBtYWNoaW5lcywgbW1hcCgpIGNhbGwgbWlnaHQgcmV0dXJuIE1BUF9G
QUlMRUQgd2hlbiBwYXNzZWQgdGhlCj4+IE1BUF9GSVhFRF9OT1JFUExBQ0UgZmxhZyBmb3IgcmVh
c29ucyBvdGhlciB0aGFuIHdoYXQgdGhlIHRlc3QgZXhwZWN0OiB2bWEKPj4gbGltaXQgcmVhY2hl
ZC4gV2hpbGUgYXQgaXQsIGFkZCBhIHNhbml0eSBjaGVjayBpZiBubyByZWdpb25zIHdlcmUgbWFw
cGVkLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNl
LmNvbT4KPj4gLS0tCj4+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAw
NC5jIHwgOCArKysrLS0tLQo+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKPj4gCj4+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L211bm1hcC9tdW5tYXAwNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvbXVu
bWFwMDQuYwo+PiBpbmRleCBlMDQ2ZDE3YTc1ZjhmNzVjNWIxMWQ1NjljMzNkYTQxZDdhZGM3ZDA5
Li5mNTVhYTc3MGE5OWQyZmFjYjUzMjM0ZmE1OTNmYTNmNDFhMTZjYjAwIDEwMDY0NAo+PiAtLS0g
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jCj4+ICsrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMKPj4gQEAgLTM3LDggKzM3
LDcgQEAgc3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPj4gIAo+PiAgCXdoaWxlICgxKSB7Cj4+ICAJ
CXZvaWQgKnAgPSBtbWFwKCh2b2lkICopKGJhc2UgKyBQQUQgKiB2bWFfc2l6ZSAqIG1hcF9jb3Vu
dCksCj4+IC0JCQkgICAgIHZtYV9zaXplLCBQUk9UX05PTkUsCj4+IC0JCQkgICAgIE1BUF9QUklW
QVRFIHwgTUFQX0FOT05ZTU9VUyB8IE1BUF9GSVhFRF9OT1JFUExBQ0UsCj4+ICsJCQkgICAgIHZt
YV9zaXplLCBQUk9UX05PTkUsIE1BUF9QUklWQVRFIHwgTUFQX0FOT05ZTU9VUywKPgo+IEhvdyBk
byB3ZSBhdm9pZCB0aGUgYWRqYWNlbnQgbWFwcGluZyBtZXJnZXMgd2l0aG91dCB0aGUKPiBNQVBf
RklYRURfTk9SRVBMQUNFIGZsYWc/IFdpdGggdGhlIGZsYWcgd2UgZm9yY2UgcGFydGljdWxhciBh
ZGRyZXNzZXMKPiB0aGF0IGhhdmUgcGFkZGluZyBiZXR3ZWVuIHRoZW4uIFdpdGhvdXQgdGhlIGZs
YWcga2VybmVsIGlzIGZyZWUgdG8gcGxhY2UKPiB0aGUgbWFwcGluZ3MgYW55d2hlcmUgaXQgd2Fu
dHMsIGUuZy4gY3JlYXRlIGEgYmlnIGNvbnRpbm91cyBtYXBwaW5nIGluCj4gd2hpY2ggY2FzZSB3
ZSB3b3VsZCBlZmZlY3RpdmVseSBoYXZlIGEgc2lnbmxlIHZtYSBpbiB0aGUga2VybmVsLgo+Cj4K
Pgo+PiAgCQkJICAgICAtMSwgMCk7Cj4+ICAJCWlmIChwID09IE1BUF9GQUlMRUQpCj4+ICAJCQli
cmVhazsKPgo+IFNob2xkbid0IGl0IGJlIGVhc2llciB0byBjb250aW51ZTsgaGVyZSBpZiBlcnJu
byA9PSBFRVhJU1Q/IHRoYXQgd291bGQKPiBtZWFuIHRoYXQgd2Ugd291bGQgbm90IG1hcCBvdmVy
IGFueSBtYXBwaW5ncyB0aGF0IGV4aXN0cyBpbiB0aGUgcHJvY2Vzcwo+IGFkZHJlc3Mgc3BhY2Ug
YW5kIGNvbnRpbnVlIHJldHJ5aW5nIHdpdGggaW5jcmVhc2luZyBhZGRyZXNzZXM6Cj4KPiAJaWYg
KHAgPT0gTUFQX0ZBSUxFRCAmJiBlcnJubyA9PSBFRVhJU1QpCj4gCQljb250aW51ZTsKPgo+IAlp
ZiAocCA9PSBNQVBfRkFJTEVEKQo+IAkJYnJlYWs7Cj4KPiAJbWFwc1ttYXBfY291bnQrK10gPSBw
OwoKSW5kZWVkLCBtYW55IHRoYW5rcyBmb3IgdGhlIHN1Z2dlc3Rpb24hIFdpbGwgc2VuZCB2MgoK
Pgo+PiBAQCAtNDYsOCArNDUsOSBAQCBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+PiAgCX0KPj4g
IAo+PiAgCWlmIChtYXBfY291bnQgPT0gTUFQX01BWF9DT1VOVCkKPj4gLQkJdHN0X2JyayhUQlJP
SywgIk1hcHBlZCBhbGwgJWQgcmVnaW9ucywgZXhwZWN0ZWQgbGVzcyIsCj4+IC0JCQltYXBfY291
bnQpOwo+PiArCQl0c3RfYnJrKFRCUk9LLCAiTWFwcGVkIGFsbCAlZCByZWdpb25zLCBleHBlY3Rl
ZCBsZXNzIiwgbWFwX2NvdW50KTsKPj4gKwlpZiAobWFwX2NvdW50ID09IDApCj4+ICsJCXRzdF9i
cmsoVEJST0ssICJNYXBwZWQgMCByZWdpb25zIik7Cj4+ICAKPj4gIAl0c3RfcmVzKFRJTkZPLCAi
TWFwcGVkICVkIHJlZ2lvbnMiLCBtYXBfY291bnQpOwo+PiAgfQo+PiAKPj4gLS0tCj4+IGJhc2Ut
Y29tbWl0OiA2YWY2MTk1NTJjZTc2NzYxNzFlNDdiODg5NjRmZmI1YjA4NDk5YjM2Cj4+IGNoYW5n
ZS1pZDogMjAyNTA3MjgtZml4ZXMtbXVubWFwMDQtMDIwODNjNTUwYzZiCj4+IAo+PiBCZXN0IHJl
Z2FyZHMsCj4+IC0tIAo+PiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+PiAK
Pj4gCj4+IC0tIAo+PiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
