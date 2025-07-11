Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C61AC8303C
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 08:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752223793; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Wjnnjzzm11j4gyGZztwZbCRstWpUtc8kbXiH3HQHIvY=;
 b=dK8VN+SFDvRRe6gdWgZlWg+2yRzPjA8Zfxgzh+nb+Cr+3ySBXUE2nVOBNt3FWF2dFesln
 J8nPmY06mhoTR2E8B7m2vFT+povCZn9ELC1TmAWDczvtJXGDf5VJo73OCha2GiUfJjCFtjn
 +cP1MJNlmU9+/IMNqyivKMkI9uVPGws=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA11A3CB17D
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 10:49:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C6B53C0882
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 10:49:31 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8E341200916
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 10:49:29 +0200 (CEST)
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so1893225f8f.0
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 01:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752223769; x=1752828569; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZUEx0bpvFzZJsLogIB0/rb0fXe1nejHyR924SBFq488=;
 b=ZkJPWrbpx9KfDSX9scyiyg4UdgjWf5GQxfP5pS+RMhNOx7pSRuCbopVXyRSGwHQNHZ
 Tiz9Gu7xHiud84KkxeBKB/28nh0xWgJDYOFOBVxRB3m6ybUhL4ofO8nCA7Rv6THYYaLf
 FX6XDL8rQs+qQYgybX78vNxItXy1ujnPFOBUG/VA+NeSGOi2iODFaBBxpk73zs3W47nC
 pzPyD6XPYtvXYaZUvPI5L+YJFtpkdh/I/7E9P4hMVbaZbf9+TGWtCWaX1isDE3pAbms3
 vEBXDmf69nz1nKZtEuFjkSbBKaBJq7WoBaxuguN5Njh4p03OBAyT5P/G1EqZO6fDlGUN
 DRAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752223769; x=1752828569;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUEx0bpvFzZJsLogIB0/rb0fXe1nejHyR924SBFq488=;
 b=L1oNl/UmuHqQu/MEo+pYnh3GCix4u3rgWXzfySXWE4JknAr0iqE1ygLxvLdNz1IRpp
 Hz9nJ/f/wMSA5dPIQSoF3ty0Tr61MMc3tYpfFq6jg0I6WvUEEoEmlJa8ap2kYl0DgHFF
 l2cnf23salDLqF0AiFG+3ZslGKFILnEioQYV++r6IYv+s0NQDlCsA9oVpDeGeXwAFrsU
 zFIvZYg/5KvmLCqEWOkRF5eMY9s9Nu0cORE+Q9o1Ib8Jhqsk4J8CW9jhxWxjDQIILjme
 A0fRzRdI09s6MeGRV1PAJy+ccY6mUT+Z5BMfFLx4C36kXVflIAM/7HohxAU2F+n0BMQR
 ZK/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfLHT98fvTdF4ZOpJMRpWGqSQBQEFcWS98zxv+4RIjKYH6ySV0lHOid0PQQ1gjmBsrcR0=@lists.linux.it
X-Gm-Message-State: AOJu0YxkLVfdlya4vwEyK4gXufO8XabZXmFaHKvElKtYOEv9CjrX6xsU
 U32ep8bKkreH3twCuW7/SczfQ8P2YGuBzsFVJZhgYwmwrOgbsnGeBsVTIz+RWAVLpV9VLv8Hu+2
 /xrHHuYha6rbn
X-Gm-Gg: ASbGncvnGshvAPQtgXlluaS9zb1t4sGL8Arh7DYUHfNCfExWCfwJpkNjNQycsbymj3j
 16jEBvXWUXSzkrzZRKWyLeQduw43NhfzbfIJ8naR1BzvKMzFLICd5+cDcKhdqGtRelAJwWoZu+A
 P4mo61fACHWdGlwRs7z3p2PaYZmMi7UNCSsnEraIcMHBHokf7gV/CMSb3grBnR09H9Ay91cWKoD
 f3PwwlgCjx20V50E80K5A50hokwqCa9PI9cacrd+UOeu+tQMTdsUDfQN/Tf48LRZelXPsKAnLFi
 Ll5Of9uEfvryKPHboXQ6QO4MewdXyOphSz+VRWggTGBsMEBdtXN5VbOOaJe2J7FYkkJXlLuFSQ3
 yF99nbzBBZ+7k2KcuoU+sHDB3ZPwYEKO+EP7YpSq2HMANq8CRkYHt5iVk2Lhx2WPV0rZx5uTzx2
 pCm0DayUer1Dq/AHwM5e8+lhDwuxxGAr3JCi0hOBXsqRL73Z88yk3hG14OUivItg==
X-Google-Smtp-Source: AGHT+IGQpHMFBZ5HRoiM0FZntEgNTBgfPDfsvr8LgPE4JTizFmYlgZXpgHUubHoyG0TRjqHRTeVYiw==
X-Received: by 2002:a05:6000:240e:b0:3a3:70ab:b274 with SMTP id
 ffacd0b85a97d-3b5e7f13a0amr5146890f8f.12.1752223768761; 
 Fri, 11 Jul 2025 01:49:28 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23de4335c8asm47739915ad.167.2025.07.11.01.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 01:49:28 -0700 (PDT)
Message-ID: <b8686bfd-b452-4b7b-905a-7be11ceddd0c@suse.com>
Date: Fri, 11 Jul 2025 10:49:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: lufei <lufei@uniontech.com>, ltp@lists.linux.it
References: <20250711072406.41444-1-lufei@uniontech.com>
Content-Language: en-US
In-Reply-To: <20250711072406.41444-1-lufei@uniontech.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add unshare(CLONE_NEWPID) test
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

SGkhCgpPbiA3LzExLzI1IDk6MjQgQU0sIGx1ZmVpIHdyb3RlOgo+IFRlc3QgdW5zaGFyZShDTE9O
RV9ORVdQSUQpIHRvIG1ha2UgZmlyc3QgY2hpbGQgaW4gbmV3IFBJRCBuYW1lc3BjZSBnZXQKPiBw
aWQgMS4KPgo+IFNpZ25lZC1vZmYtYnk6IGx1ZmVpIDxsdWZlaUB1bmlvbnRlY2guY29tPgo+IC0t
LQo+ICAgcnVudGVzdC9zeXNjYWxscyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEg
Kwo+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bnNoYXJlLy5naXRpZ25vcmUgIHwgIDEg
Kwo+ICAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bnNoYXJlL3Vuc2hhcmUwNS5jIHwgNTQg
KysrKysrKysrKysrKysrKysrKwo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA1NiBpbnNlcnRpb25zKCsp
Cj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bnNoYXJl
L3Vuc2hhcmUwNS5jCj4KPiBkaWZmIC0tZ2l0IGEvcnVudGVzdC9zeXNjYWxscyBiL3J1bnRlc3Qv
c3lzY2FsbHMKPiBpbmRleCA1NzMzODI5N2EuLjgyZTIyMmJmNCAxMDA2NDQKPiAtLS0gYS9ydW50
ZXN0L3N5c2NhbGxzCj4gKysrIGIvcnVudGVzdC9zeXNjYWxscwo+IEBAIC0xNzI2LDYgKzE3MjYs
NyBAQCB1bnNoYXJlMDEgdW5zaGFyZTAxCj4gICB1bnNoYXJlMDIgdW5zaGFyZTAyCj4gICB1bnNo
YXJlMDMgdW5zaGFyZTAzCj4gICB1bnNoYXJlMDQgdW5zaGFyZTA0Cj4gK3Vuc2hhcmUwNSB1bnNo
YXJlMDUKPiAgIAo+ICAgIwo+ICAgIyBUaGVzZSB0ZXN0cyByZXF1aXJlIGFuIHVubW91bnRlZCBi
bG9jayBkZXZpY2UKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy91bnNo
YXJlLy5naXRpZ25vcmUgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vuc2hhcmUvLmdpdGln
bm9yZQo+IGluZGV4IGIxMjA2ZTQ1Mi4uOGVjZTVmOTg4IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS8uZ2l0aWdub3JlCj4gKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy91bnNoYXJlLy5naXRpZ25vcmUKPiBAQCAtMiwzICsyLDQgQEAKPiAgIC91
bnNoYXJlMDIKPiAgIC91bnNoYXJlMDMKPiAgIC91bnNoYXJlMDQKPiArL3Vuc2hhcmUwNQo+IGRp
ZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vuc2hhcmUvdW5zaGFyZTA1LmMg
Yi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Vuc2hhcmUvdW5zaGFyZTA1LmMKPiBuZXcgZmls
ZSBtb2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMC4uY2ZjNTg3N2RhCj4gLS0tIC9kZXYvbnVs
bAo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvdW5zaGFyZS91bnNoYXJlMDUuYwo+
IEBAIC0wLDAgKzEsNTQgQEAKPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b3ItbGF0ZXIKPiArLyoKPiArICogQ29weXJpZ2h0IChjKSAyMDI1IGx1ZmVpIDxsdWZlaUB1bmlv
bnRlY2guY29tPgo+ICsgKi8KPiArCj4gKy8qXAo+ICsgKiBUaGlzIHRlc3QgY2FzZSB2ZXJpZmll
cyB1bnNoYXJlKENMT05FX05FV1BJRCkgY3JlYXRlcyBhIG5ldyBQSUQgbmFtZXNwYWNlCj4gKyAq
IGFuZCB0aGF0IHRoZSBmaXJzdCBjaGlsZCBwcm9jZXNzIGluIHRoZSBuZXcgbmFtZXNwYWNlIGdl
dHMgUElEIDEuCj4gKyAqLwo+ICsKPiArI2RlZmluZSBfR05VX1NPVVJDRQo+ICsKPiArI2luY2x1
ZGUgInRzdF90ZXN0LmgiCj4gKyNpbmNsdWRlICJsYXBpL3NjaGVkLmgiCj4gKwo+ICtzdGF0aWMg
dm9pZCBydW4odm9pZCkKPiArewo+ICsJc3RydWN0IHRzdF9jbG9uZV9hcmdzIGFyZ3MgPSB7Cj4g
KwkJLmZsYWdzID0gQ0xPTkVfTkVXUElELAo+ICsJCS5leGl0X3NpZ25hbCA9IFNJR0NITEQsCj4g
Kwl9OwpUaGlzIHNob3VsZCBiZSBjcmVhdGVkIGluIHRzdF90ZXN0LmJ1ZnMgYW5kIGluaXRpYWxp
emVkIGluc2lkZSBzZXR1cCgpLgo+ICsKPiArCWlmICghU0FGRV9DTE9ORSgmYXJncykpIHsKPiAr
CQlUU1RfRVhQX1BBU1ModW5zaGFyZShDTE9ORV9ORVdQSUQpKTsKV2UgY2FuIHVzZSBTQUZFX1VO
U0hBUkUoKSBzaW5jZSB3ZSBuZWVkIHRvIGJyZWFrIHRoZSB0ZXN0IGlmIHVuc2hhcmUoKSAKaXMg
bm90IHBhc3NpbmcuCj4gKwo+ICsJCXBpZF90IGNoaWxkX3BpZCA9IFNBRkVfRk9SSygpOwo+ICsK
PiArCQlpZiAoY2hpbGRfcGlkID09IDApIHsKPiArCQkJcGlkX3QgcGlkID0gZ2V0cGlkKCk7Cj4g
Kwo+ICsJCQlpZiAocGlkID09IDEpCj4gKwkJCQl0c3RfcmVzKFRQQVNTLCAiRmlyc3QgY2hpbGQg
aW4gbmV3IFBJRCAiCj4gKwkJCQkJCSJuYW1lc3BhY2UgaGFzIFBJRCAxIik7Cj4gKwkJCWVsc2UK
PiArCQkJCXRzdF9yZXMoVEZBSUwsICJGaXJzdCBjaGlsZCBpbiBuZXcgUElEICIKPiArCQkJCQkJ
Im5hbWVzcGFjZSBoYXMgUElEICVkLCAiCj4gKwkJCQkJCSJleHBlY3RlZCAxIiwgcGlkKTsKPiAr
CQkJZXhpdCgwKTsKPiArCQl9IGVsc2Ugewo+ICsJCQlTQUZFX1dBSVQoTlVMTCk7Cj4gKwkJfQo+
ICsKPiArCQlleGl0KDApOwo+ICsJfQo+ICsKPiArCVNBRkVfV0FJVChOVUxMKTsKQWxsIHRoaXMg
cGFydCBjYW4gYmUgc3VtbWVkIHVwIGxpa2UgdGhpczoKCmlmICghU0FGRV9GT1JLKCkpIHsKIMKg
wqDCoCBUU1RfRVhQX0VRX0xJKGdldHBpZCgpLCAxKTsKIMKgwqDCoCBleGl0KDApOwp9CgpBbmQg
bm8gbmVlZCBmb3Igd2FpdCgpIHNpbmNlIExUUCB3aWxsIHRha2UgY2FyZSBvZiBjb2xsZWN0aW5n
IGNoaWxkIApyZXN1bHRzIGFmdGVyIHJlYXBpbmcgaXQuCgo+ICt9Cj4gKwo+ICtzdGF0aWMgc3Ry
dWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gKwkuZm9ya3NfY2hpbGQgPSAxLAo+ICsJLm5lZWRzX3Jv
b3QgPSAxLAo+ICsJLnRlc3RfYWxsID0gcnVuLAo+ICsJLm1pbl9rdmVyID0gIjMuOCIsCldlIHN1
cHBvcnQgZnJvbSA0LjE1LCBzbyB3ZSBkb24ndCBuZWVkIHRvIGRlZmluZSB0aGUgbWluaW11bSBr
ZXJuZWwgCnZlcnNpb24gaGVyZS4KaHR0cHM6Ly9saW51eC10ZXN0LXByb2plY3QucmVhZHRoZWRv
Y3MuaW8vZW4vbGF0ZXN0L3VzZXJzL3N1cHBvcnRlZF9zeXN0ZW1zLmh0bWwKPiArfTsKLSBBbmRy
ZWEKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
