Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986FCC369CB
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 07:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745912457; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=w8VtZKYXCm7wTHIP6iICCyCYkOXqru/00+VHyrNsQXQ=;
 b=CyJji4j+XOWa0ypN2SsNXXgqRchpN26hJowxs4bMoXC35OcbNkUprbaO0DuASPYCOUW2o
 mbkxjq7+tjsN/OBlBrpriPwO9mW2urkYjFUXsFtCly0PubOcAD59KKdUP3JrrENQTuwLNxj
 /8YE3OepXMCw7hdtwM9opLQaFi3jZlI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A02C3CBBF7
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 09:40:57 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E14E3C53B4
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:40:33 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0D839600325
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 09:40:32 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso4322218f8f.2
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745912432; x=1746517232; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CdiQXbt1q8Hg2HkURKu3fUqRQ8BhC3EMhkS0RpGA4w4=;
 b=ashO1cdOzQZZJ+Md4GLXR79NfRLo1VBmj5jN/N/DTzhRAwVNSR65LS4Jopvo97Tg30
 Oa6eRo0DXpYisEzHmBHuOnQOPvnWcaGWhGhPY/gz/QOjtg8D4doAB2BOm6HpXgUeu6lC
 Q7eIae3FVr63scW9+VtW50yL4Ki1fSkJHWkBOOTTm3u3bmxccwfdDsGIad+HBxLRhva8
 Ne9IfPx2J17XFTL10qfqSDV7Y3bLtqEGZtHYfIoUjR+ywwmq8I+8p1b7p08xYFrAntao
 50+mTOz+gcOJztp/0ASQzSELS4MPhRFHyrbmYBkj0F8w/NVyw1M/4cKS+3eX1BoX/xO4
 Orbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745912432; x=1746517232;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CdiQXbt1q8Hg2HkURKu3fUqRQ8BhC3EMhkS0RpGA4w4=;
 b=jWa6KMxM8RhqoJGvWdgn0hTG/98lpo3GtqS5yp3w66wXltblQ+rjfHvSqr4MZMr55p
 aDdo8yV+0SrqaMm9GWkscrWOzij9VpJXfS++EOMdLmwJSWV44vAPMZAEhJVvGI2xSfQJ
 /991izZfJqA4afgecaa5KTs355KdE+4DZjeglc0CgSOr1tRvS/Uqf9oI6WJOnFb63bF/
 tQ3+PiEUIZc/EhsFJM69mriNHrv2SOHQ6PFSOumuxlg+ms6QrEDkhvrL3zeoIhiOf/WZ
 fzS/TccSmPddfuzstv4Kdo7oFKWpdPeUrWBHMxjxu9jwPH0JYZoPIcF79azY2DxZilih
 Hldg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCQAhkNjE0XVv/LGIXTdP2Mc7Kz8JUXl9AG/emqaF5ySURuNct9IiFL1xIsSgy89609mY=@lists.linux.it
X-Gm-Message-State: AOJu0Yx5nmGZzJ0xYlh8ER259ac585Wcsn/KxY49Vl0sVoP6UYyzqeUJ
 rfa6kj357ExOvogadIY4qvOsqi3rzB9Ad4EVtyLUWhHKu5ctS0BfpGH2u5J5EG+Cw45QMhPq+Az
 1
X-Gm-Gg: ASbGncvjaxLsibdas6TNaqDolYU+6nOn52j9yVvbrwd4mcMzz2ia/4w/juYJUCdh5G2
 uQRH2P2Mw+7WVbKSlJUM8NA1O9ULD2x2bWEQCVUMx5kses8pC0OzqPzpm2IPR3UTDziagHJjEwF
 78EaIW3+Lg9s0De3wtRnoHmbI6bk39Us35SocOZ0ZwTZ5tA6Jm8fDQsoUIusdvhqGoLpBYYJovo
 mQgOtKNn8cQtYmFSRwjIB3Yo75te3tQpqkRbRAajEGv3f5OibMZMADmYvAJu5e6sjU29lGgZTOq
 3U+hM9Xr56+fJiXBXz0eHORoJZMMWfA9kgV4fI/3bTxBwS8OE5Nc4gxOhC8zJLBeoMVM1UHTrwr
 0cNAAdhZt7Byr7IwiFNB1LmCTjGi/+/f55cAM9U2rG2t8dLLLNmiAZv6M8i1IuW+NAdRLJaRja6
 u1kNQ=
X-Google-Smtp-Source: AGHT+IGCnw0kRysQ2v2bCpZcqhl+qtLtsWEGOB/zglAaDYD9ZCZ9KkZDmagmkWI52JPJsz/eGsDAtQ==
X-Received: by 2002:a5d:64a3:0:b0:3a0:8429:a2e2 with SMTP id
 ffacd0b85a97d-3a08a370f14mr1516639f8f.32.1745912432400; 
 Tue, 29 Apr 2025 00:40:32 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c6a0sm13089243f8f.86.2025.04.29.00.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 00:40:32 -0700 (PDT)
Message-ID: <9f41e34d-3bfe-4baf-84e0-bce28e39091b@suse.com>
Date: Tue, 29 Apr 2025 09:40:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250408-conversions-modify_ldt-v8-0-7bdba108f64a@suse.com>
 <20250408-conversions-modify_ldt-v8-1-7bdba108f64a@suse.com>
Content-Language: en-US
In-Reply-To: <20250408-conversions-modify_ldt-v8-1-7bdba108f64a@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/3] syscalls/modify_ldt: Add lapi/ldt.h
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

SGkgUmljYXJkbywKCk9uIDQvOC8yNSAxMzoyNiwgUmljYXJkbyBCLiBNYXJsacOocmUgd3JvdGU6
Cj4gRnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPgo+IEFkZCBhIHdy
YXBwZXIgdG8gbW9kaWZ5X2xkdCBhbmQgYSBmYWxsYmFjayBkZWZpbml0aW9uIHRvIHN0cnVjdCB1
c2VyX2Rlc2MsCj4gd2hpY2ggYXJlIG5lZWRlZCBpbiBhIGZldyB0ZXN0cyBhbmQgc2hvdWxkIGJl
IHJldXNlZC4KPgo+IFJldmlld2VkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4K
PiBSZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNv
bT4KPiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+
IC0tLQo+ICAgaW5jbHVkZS9sYXBpL2xkdC5oICAgICAgICAgICAgICAgICAgICAgIHwgNTggKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4gICB0ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1
LTMyOTAuYyAgICAgICAgICAgfCAyNiArKy0tLS0tLS0tLS0tLS0KPiAgIHRlc3RjYXNlcy9jdmUv
Y3ZlLTIwMTctMTcwNTMuYyAgICAgICAgICB8ICA2ICsrLS0KPiAgIHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZm9yay9mb3JrMDUuYyB8ICA1ICsrLQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA2NCBp
bnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xh
cGkvbGR0LmggYi9pbmNsdWRlL2xhcGkvbGR0LmgKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+IGlu
ZGV4IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAuLmNmYjk4ODgzNjMz
YjQwNDhiYWJiOTNjODNmMDljNmI0MTNjMDA0ZjYKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvaW5j
bHVkZS9sYXBpL2xkdC5oCj4gQEAgLTAsMCArMSw1OCBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjUg
U1VTRSBMTEMgUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPiArICovCj4gKwo+
ICsjaWZuZGVmIExBUElfTERUX0hfXwo+ICsjZGVmaW5lIExBUElfTERUX0hfXwo+ICsKPiArI2lu
Y2x1ZGUgImNvbmZpZy5oIgo+ICsjaW5jbHVkZSAibGFwaS9zeXNjYWxscy5oIgo+ICsKPiArI2lm
ZGVmIEhBVkVfQVNNX0xEVF9ICj4gKyNpbmNsdWRlIDxhc20vbGR0Lmg+Cj4gKyNlbHNlCj4gK3N0
cnVjdCB1c2VyX2Rlc2Mgewo+ICsJdW5zaWduZWQgaW50IGVudHJ5X251bWJlcjsKPiArCXVuc2ln
bmVkIGludCBiYXNlX2FkZHI7Cj4gKwl1bnNpZ25lZCBpbnQgbGltaXQ7Cj4gKwl1bnNpZ25lZCBp
bnQgc2VnXzMyYml0IDogMTsKPiArCXVuc2lnbmVkIGludCBjb250ZW50cyA6IDI7Cj4gKwl1bnNp
Z25lZCBpbnQgcmVhZF9leGVjX29ubHkgOiAxOwo+ICsJdW5zaWduZWQgaW50IGxpbWl0X2luX3Bh
Z2VzIDogMTsKPiArCXVuc2lnbmVkIGludCBzZWdfbm90X3ByZXNlbnQgOiAxOwo+ICsJdW5zaWdu
ZWQgaW50IHVzZWFibGUgOiAxOwo+ICsjaWZkZWYgX194ODZfNjRfXwo+ICsJdW5zaWduZWQgaW50
IGxtIDogMTsKPiArI2VuZGlmIC8qIF9feDg2XzY0X18gKi8KPiArfTsKPiArI2VuZGlmIC8qIEhB
VkVfQVNNX0xEVF9IICovCj4gKwo+ICtzdGF0aWMgaW5saW5lIGludCBtb2RpZnlfbGR0KGludCBm
dW5jLCBjb25zdCBzdHJ1Y3QgdXNlcl9kZXNjICpwdHIsCj4gKwkJCSAgICAgdW5zaWduZWQgbG9u
ZyBieXRlY291bnQpCj4gK3sKPiArCXJldHVybiB0c3Rfc3lzY2FsbChfX05SX21vZGlmeV9sZHQs
IGZ1bmMsIHB0ciwgYnl0ZWNvdW50KTsKPiArfQo+ICsKPiArc3RhdGljIGlubGluZSBpbnQgc2Fm
ZV9tb2RpZnlfbGR0KGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIGludCBmdW5j
LAo+ICsJCQkJICBjb25zdCBzdHJ1Y3QgdXNlcl9kZXNjICpwdHIsCj4gKwkJCQkgIHVuc2lnbmVk
IGxvbmcgYnl0ZWNvdW50KQo+ICt7Cj4gKwlpbnQgcnZhbDsKPiArCj4gKwlydmFsID0gbW9kaWZ5
X2xkdChmdW5jLCBwdHIsIGJ5dGVjb3VudCk7Cj4gKwlpZiAocnZhbCA9PSAtMSkKPiArCQl0c3Rf
YnJrXyhmaWxlLCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5PLAo+ICsJCQkgIm1vZGlmeV9sZHQoJWQs
ICVwLCAlbHUpIiwgZnVuYywgcHRyLCBieXRlY291bnQpOwo+ICsJZWxzZSBpZiAocnZhbCkKPiAr
CQl0c3RfYnJrXyhmaWxlLCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5PLAo+ICsJCQkgIm1vZGlmeV9s
dGQoJWQsICVwLCAlbHUpIGludmFsaWQgcmV0dmFsICVpIiwgZnVuYywgcHRyLAo+ICsJCQkgYnl0
ZWNvdW50LCBydmFsKTsKClRoZSBMVFAvS2VybmVsIGNvZGluZyBjb252ZW50aW9uIGlzIHRoYXQg
YSBzdGF0ZW1lbnQgdXNpbmcgbW9yZSB0aGFuIG9uZSAKbGluZSBuZWVkcyB0byBiZSBzdXJyb3Vu
ZGVkIGJ5IGJyYWNlczogCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3By
b2Nlc3MvY29kaW5nLXN0eWxlLmh0bWwjaW5kZW50YXRpb24KVGhlIHJlc3QgbG9va3Mgb2suCgpS
ZXZpZXdlZC1ieTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4K
Ci0gQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
