Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733C8C35FFC
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 10:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742899000; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=6K0ueWh3yq9fswqsbB+rPiMJRB0KARwzEDAmb0K/Qb0=;
 b=kQHO/1gqkSKdhjl/vzX+RDC72aLcf8QJgG7GegVrMjRvdHqVBG4T/F3Nbeg5aCvp8aKux
 kVESYToGzfPYVasw20nAlwbAUvlr3SNB8udGJhDwcwN9AD+b1taf0Kx5Jvv4avMMY7rRh2W
 0sDnhulY/DEkWyJFjfSUMtXV6L88egE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CB4353C9909
	for <ltp@archiver.kernel.org>; Tue, 25 Mar 2025 11:36:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C16CC3C919F
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 11:36:18 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 24B0210009E6
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 11:36:17 +0100 (CET)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so34000635e9.0
 for <ltp@lists.linux.it>; Tue, 25 Mar 2025 03:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742898976; x=1743503776; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z9HhF5RsdrBUQcDM4oxcdOnRW+RLnUrPhiAL+atgQXk=;
 b=RqkvG//Tc/NVmpZs9wrvJic+v5gzou96mG2V0tpHYW0d1CpLW7peR7aZUdqGOd5RfK
 amlT2U5/aMEU++5chQbDdqhQ/cpvDKqk2is2aANpUrxMJle8gvwyoxtgE7NJA8wjiQet
 LcoV8CzqjjMyKZz29L1QMM973FK5MHHfOyWiYXtUil1kjy04Ustrz93kggyV+DfEdhPY
 DOPtlihkvG3ZbPp1Z+m83laM7yMTojpkWtKKZAnTvluIF8qklPVUJDWMlL7wioCDK1r8
 sB3oltlstism3Zvfu/8kdKTZqw5dPlufLEdIxIsqOArtW+sEdhlK+9ApsL0Xqkuv3mxl
 tVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742898976; x=1743503776;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z9HhF5RsdrBUQcDM4oxcdOnRW+RLnUrPhiAL+atgQXk=;
 b=a48twSbyOZ3vWA2Xj2TNTMFYRG5qOySQDAsSBmhGjuEaPexcjnb39Qxn1NlQ76WHvl
 Cz1GfFN5CjRSrAbqPPIlDEZxOAy5BLFoO2rKyaUjFFccJkBG4Kfc+9UML6t3LNFPMdLr
 9Wgy3aEYzP5Mq0mmd5juU6gQGX89swYDqLdSTiGnccNN8hT2yzs2ACAx/e5WH6osRwRO
 Icte/s0Ds7S8X54d+/ys/djLioWaBQ++EKN8ehikk48HRMw5eZULnS2fNI9M7AUK6Xta
 gnwmks/+FQ7mOAiFNUfw18H5PPtut+n7v6HEr35BErVwsoD77gVyzHwzdmGtktU+3Av5
 9Gfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhPHj/lkW3bK6VzKD0cY/kbqvduPuU9kUpKduBjW3sJB90pjAWhqxCRsMUDb/adFsqe2w=@lists.linux.it
X-Gm-Message-State: AOJu0YwPwxXy8Zlg5VNAxu0OOJn9AQPnoVyRgbY2OmvXZ8xKvGWCSMbv
 IiFe+CUjzLC59aK5EIDTLeMz9waR1dOL9oWKOpEWqoyZzEb/vR6fv7OyAGm3e5E=
X-Gm-Gg: ASbGncuuveU5QrVTVVFjCB3bklSFYdZRFDNnH6NqnOf3Gpn4hfshhOdNMAH4Jy5V+9K
 ndlYmY+Aj0jYKmpfmn2MMyi0y24qvDLl0BxoNwvVocGjAiNK7Xz0CkBNWsPqEcqQu/azSYReXWQ
 9cAUUKEZqM2hGjqFbFmoT1SLeG2BvwlKY3+VuJjMhywVd+WjTpg+s9FOCmefvYwtEAzfQd5CQHN
 CTXOTgDilzYyenhFzzB/V+ZcK4bUeydchdPv9wQKsVuejdI7hpVSGAqBS1sn1WJIVI5cdWGQAvn
 PV7l6kmfLlxVqubPTuc8I24fjPxnzRV5vRsT6okfj/EWjo2wFBhMpvU=
X-Google-Smtp-Source: AGHT+IG37/2gWnpkz+gVXlY+i9xSJ2z8j1sy8WpFy7b6MRLKG4gAt8DjzTQTJ1gPe5UEvkOJPw+HHw==
X-Received: by 2002:a05:600c:1c9b:b0:43d:526:e0ce with SMTP id
 5b1f17b1804b1-43d50a21233mr97928895e9.21.1742898976353; 
 Tue, 25 Mar 2025 03:36:16 -0700 (PDT)
Received: from [10.232.133.75] ([88.128.90.56])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f47196sm195675175e9.16.2025.03.25.03.36.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 03:36:15 -0700 (PDT)
Message-ID: <64c224da-662b-4430-82bc-d6646a8f9587@suse.com>
Date: Tue, 25 Mar 2025 11:36:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rbm@suse.com, Linux Test Project <ltp@lists.linux.it>
References: <20250324-conversions-modify_ldt-v1-0-8d6d82f10768@suse.com>
 <20250324-conversions-modify_ldt-v1-2-8d6d82f10768@suse.com>
Content-Language: en-US
In-Reply-To: <20250324-conversions-modify_ldt-v1-2-8d6d82f10768@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] syscalls/modify_ldt: Refactor modify_ldt03
 into new API
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

SGkhCgpUaGlzIHRlc3QgaXMgYWN0dWFsbHkgYSBiaXQgc2ltcGxlLiBBY2NvcmRpbmcgdG8gbWFu
IHBhZ2VzOgoKIMKgwqDCoMKgwqDCoCBXaGVuIGZ1bmMgaXMgMCwgbW9kaWZ5X2xkdCgpIHJlYWRz
IHRoZSBMRFQgaW50byB0aGUgbWVtb3J5IHBvaW50ZWQKIMKgwqDCoMKgwqDCoCB0byBieSBwdHIu
wqAgVGhlIG51bWJlciBvZiBieXRlcyByZWFkIGlzIHRoZSBzbWFsbGVyIG9mIGJ5dGVjb3VudAog
wqDCoMKgwqDCoMKgIGFuZCB0aGUgYWN0dWFsIHNpemUgb2YgdGhlIExEVCwgYWx0aG91Z2ggdGhl
IGtlcm5lbCBtYXkgYWN0IGFzCiDCoMKgwqDCoMKgwqAgdGhvdWdoIHRoZSBMRFQgaXMgcGFkZGVk
IHdpdGggYWRkaXRpb25hbCB0cmFpbGluZyB6ZXJvIGJ5dGVzLsKgIE9uCiDCoMKgwqDCoMKgwqAg
c3VjY2VzcywgbW9kaWZ5X2xkdCgpIHdpbGwgcmV0dXJuIHRoZSBudW1iZXIgb2YgYnl0ZXMgcmVh
ZC4KClNvIHdlIHNob3VsZCB2ZXJpZnkgdGhhdCBieSByZWFkaW5nIHRoZSBMRFQgd2UgYXJlIGFi
bGUgdG8gb2J0YWluIGRhdGEgCmZyb20gbW9kaWZ5X2xkdCgpIHN5c2NhbGwuCgpNb3JlIGNvbW1l
bnRzIGJlbG93LgoKT24gMy8yNC8yNSAyMTo0NSwgUmljYXJkbyBCLiBNYXJsaWVyZSB2aWEgbHRw
IHdyb3RlOgo+IEZyb206IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4KPiBT
aWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+IC0tLQo+
ICAgLi4uL2tlcm5lbC9zeXNjYWxscy9tb2RpZnlfbGR0L21vZGlmeV9sZHQwMy5jICAgICAgfCAx
MTQgKysrKy0tLS0tLS0tLS0tLS0tLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9u
cygrKSwgOTQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9tb2RpZnlfbGR0L21vZGlmeV9sZHQwMy5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9tb2RpZnlfbGR0L21vZGlmeV9sZHQwMy5jCj4gaW5kZXggMDE3MzBlMGUxNGFlOThhOTM0
ZTdiNjZjOTA1ODQ1NDUwNmJiZTA2NC4uNmVjZmExZTlmOTg3YTZmYzM0OWU1NTFiNGYwZTE3NWQx
NGU2MjY0MiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vZGlmeV9s
ZHQvbW9kaWZ5X2xkdDAzLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21vZGlm
eV9sZHQvbW9kaWZ5X2xkdDAzLmMKPiBAQCAtMSwxMDUgKzEsMzEgQEAKPiArLy8gU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiArCj4gICAvKgo+IC0gKiBDb3B5cmln
aHQgKGMpIDIwMTQgRnVqaXRzdSBMdGQuCj4gLSAqIEF1dGhvcjogWmVuZyBMaW5nZ2FuZyA8emVu
Z2xnLmp5QGNuLmZ1aml0c3UuY29tPgo+IC0gKgo+IC0gKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBz
b2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeSBpdAo+IC0gKiB1
bmRlciB0aGUgdGVybXMgb2YgdmVyc2lvbiAyIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBhcwo+IC0gKiBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4K
PiAtICoKPiAtICogVGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQg
aXQgd291bGQgYmUgdXNlZnVsLCBidXQKPiAtICogV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhv
dXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZgo+IC0gKiBNRVJDSEFOVEFCSUxJVFkgb3Ig
RklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuCj4gLSAqCj4gLSAqIFlvdSBzaG91bGQg
aGF2ZSByZWNlaXZlZCBhIGNvcHkgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFs
b25nCj4gLSAqIHdpdGggdGhpcyBwcm9ncmFtLgo+IC0gKi8KPiAtLyoKPiAtICogREVTQ1JJUFRJ
T04KPiAtICoJQmFzaWMgdGVzdCBmb3IgbW9kaWZ5X2xkdCgyKSB1c2luZyBmdW5jPTAgYXJndW1l
bnQuCj4gKyAqIENvcHlyaWdodCAoYykgMjAxNCBGdWppdHN1IEx0ZC4gWmVuZyBMaW5nZ2FuZyA8
emVuZ2xnLmp5QGNuLmZ1aml0c3UuY29tPgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjUgU1VTRSBM
TEMgUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPiAgICAqLwo+ICAgCj4gLSNp
bmNsdWRlICJjb25maWcuaCIKPiAtI2luY2x1ZGUgInRlc3QuaCIKPiAtCj4gLWNoYXIgKlRDSUQg
PSAibW9kaWZ5X2xkdDAzIjsKPiAtaW50IFRTVF9UT1RBTCA9IDE7Cj4gLQo+IC0jaWYgZGVmaW5l
ZChfX2kzODZfXykgJiYgZGVmaW5lZChIQVZFX01PRElGWV9MRFQpCj4gLQo+IC0jaWZkZWYgSEFW
RV9BU01fTERUX0gKPiAtIyBpbmNsdWRlIDxhc20vbGR0Lmg+Cj4gLSNlbmRpZgo+IC1leHRlcm4g
aW50IG1vZGlmeV9sZHQoaW50LCB2b2lkICosIHVuc2lnbmVkIGxvbmcpOwo+IC0KPiAtI2luY2x1
ZGUgPGFzbS91bmlzdGQuaD4KPiAtI2luY2x1ZGUgPHN0cmluZy5oPgo+IC0jaW5jbHVkZSA8c3lz
L3dhaXQuaD4KPiAtI2luY2x1ZGUgPGVycm5vLmg+Cj4gLSNpbmNsdWRlICJzYWZlX21hY3Jvcy5o
Igo+IC0KPiAtI2lmZGVmIEhBVkVfU1RSVUNUX1VTRVJfREVTQwo+IC0jIGRlZmluZSBTSVpFIHNp
emVvZihzdHJ1Y3QgdXNlcl9kZXNjKQo+IC0jZWxzZQo+IC0jIGRlZmluZSBTSVpFIDE2Cj4gLSNl
bmRpZgo+IC0KPiAtc3RhdGljIGNoYXIgYnVmW1NJWkVdOwo+IC1zdGF0aWMgdm9pZCBjbGVhbnVw
KHZvaWQpOwo+IC1zdGF0aWMgdm9pZCBzZXR1cCh2b2lkKTsKPiAtCj4gLWludCBtYWluKGludCBh
YywgY2hhciAqKmF2KQo+IC17Cj4gLQlpbnQgbGM7Cj4gLQo+IC0JdHN0X3BhcnNlX29wdHMoYWMs
IGF2LCBOVUxMLCBOVUxMKTsKPiAtCj4gLQlzZXR1cCgpOwo+IC0KPiAtCWZvciAobGMgPSAwOyBU
RVNUX0xPT1BJTkcobGMpOyBsYysrKSB7Cj4gLQo+IC0JCXRzdF9jb3VudCA9IDA7Cj4gLQo+IC0J
CVRFU1QobW9kaWZ5X2xkdCgwLCBidWYsIFNJWkUpKTsKPiArLypcCj4gKyAqIFZlcmlmeSB0aGF0
IGEgc2ltcGxlIHJlYWQgKGZ1bmM9MCkgd29ya3Mgd2hlbiBjYWxsaW5nIG1vZGlmeV9sZHQuCj4g
KyAqLwo+ICAgCj4gLQkJaWYgKFRFU1RfUkVUVVJOIDwgMCkgewo+IC0JCQl0c3RfcmVzbShURkFJ
TCB8IFRURVJSTk8sCj4gLQkJCQkgIm1vZGlmeV9sZHQoKSBmYWlsZWQgd2l0aCBlcnJubzogJXMi
LAo+IC0JCQkJIHN0cmVycm9yKFRFU1RfRVJSTk8pKTsKPiAtCQl9IGVsc2Ugewo+IC0JCQl0c3Rf
cmVzbShUUEFTUywgIm1vZGlmeV9sZHQoKSB0ZXN0ZWQgc3VjY2VzcyIpOwo+IC0JCX0KPiAtCX0K
PiArI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gICAKPiAtCWNsZWFudXAoKTsKPiAtCXRzdF9leGl0
KCk7Cj4gLX0KPiArI2lmZGVmIF9faTM4Nl9fCj4gKyNpbmNsdWRlICJsYXBpL2xkdC5oIgo+ICAg
Cj4gLXN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gK3ZvaWQgcnVuKHZvaWQpCj4gICB7Cj4gLQl0
c3Rfc2lnKE5PRk9SSywgREVGX0hBTkRMRVIsIGNsZWFudXApOwo+ICsJY2hhciBidWZbc2l6ZW9m
KHN0cnVjdCB1c2VyX2Rlc2MpXTsKTm90IGEgZ29vZCBpZGVhIHRvIGluaXRpYWxpemUgc3RydWN0
cyBpbiB0aGlzIHdheSwgc2luY2UgdGhlaXIgZGltZW5zaW9uIAptaWdodCBjaGFuZ2Ugd2l0aCB0
aW1lLgpXZSBzaG91bGQgdXNlIGEgZ3VhcmRlZCBidWZmZXIgYW5kIHRvIGNsZWFuIGl0IGJlZm9y
ZSB1c2luZyBpdC4KPiAgIAo+IC0JVEVTVF9QQVVTRTsKPiArCVRFU1QobW9kaWZ5X2xkdCgwLCBi
dWYsIHNpemVvZihidWYpKSk7CldlIGNhbiBnbyBzdHJhaWdodCB1c2luZyBUU1RfRVhQX0VRX0xJ
KCkKPiArCVRTVF9FWFBfRVFfTEkoVFNUX1JFVCwgMCk7Cj4gICB9Cj4gICAKPiAtc3RhdGljIHZv
aWQgY2xlYW51cCh2b2lkKQo+IC17Cj4gLX0KPiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0
ID0gewo+ICsJLnRlc3RfYWxsID0gcnVuLAo+ICt9Owo+ICAgCj4gLSNlbGlmIEhBVkVfTU9ESUZZ
X0xEVAo+IC0KPiAtaW50IG1haW4odm9pZCkKPiAtewo+IC0JdHN0X2Jya20oVENPTkYsCj4gLQkJ
IE5VTEwsICJtb2RpZnlfbGR0IGlzIGF2YWlsYWJsZSBidXQgbm90IHRlc3RlZCBvbiB0aGUgcGxh
dGZvcm0gdGhhbiAiCj4gLQkJICJfX2kzODZfXyIpOwo+IC19Cj4gLQo+IC0jZWxzZSAvKiBpZiBk
ZWZpbmVkKF9faTM4Nl9fKSAqLwo+IC0KPiAtaW50IG1haW4odm9pZCkKPiAtewo+IC0JdHN0X3Jl
c20oVElORk8sICJtb2RpZnlfbGR0MDMgdGVzdCBvbmx5IGZvciBpeDg2Iik7Cj4gLQl0c3RfZXhp
dCgpOwo+IC19Cj4gLQo+IC0jZW5kaWYgLyogaWYgZGVmaW5lZChfX2kzODZfXykgKi8KPiArI2Vs
c2UKPiArVFNUX1RFU1RfVENPTkYoIlRlc3Qgc3VwcG9ydGVkIG9ubHkgb24gaTM4NiIpOwpUaGlz
IHRlc3QgaXMgcHJvYmFibHkgc3VwcG9ydGVkIGJ5IHg4Nl82NCBhcyB3ZWxsLgo+ICsjZW5kaWYg
LyogX19pMzg2X18gKi8KPgpLaW5kIHJlZ2FyZHMsCkFuZHJlYSBDZXJ2ZXNhdG8KCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
