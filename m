Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931C4F43683
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 09:24:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 549553E2DE1
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 11:24:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 751F03C22A5
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 11:24:31 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 13E32600B06
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 11:24:31 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-1279eced0b9so611196c88.0
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 02:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776417869; x=1777022669; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yiLOnbV7e70dY7+nqbu3FUgZmwukzbKl0mp6/6ZfivA=;
 b=Pa3rKlbVgFRVSftq4jrXXZRWFceUNuvLaKEarWYMxnHOtq3RJWZlqCEjZMSM0pL/op
 97wZki1OrU28ZI9uQWcQLgWdTsur5NxwS6+XO4r6s2o/Zk0X/h5lMMLGeqMsHbxgkPIw
 8vLH1M/pshoSXKm9c5+5LdLzx2GYw8xWKcE8srTsv4yOOaKcXMYGquHtLbjhKqTPV96X
 tGQLG1lAql0raP8xxjurOfwIrJUidZzt4DlkkuCM8Ub3fu6ldfdBeIQt86tIWzyXuP6Y
 hJkGQOlGYX9J8iOBjMnsvDFG7zfQBChHuG5pAELGmE2AGrdvipeVLhwcPjKDfWm/BNee
 SKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776417869; x=1777022669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yiLOnbV7e70dY7+nqbu3FUgZmwukzbKl0mp6/6ZfivA=;
 b=kGmwzSfUw26zraWjpgmoTfIZHGN57mlJLRu+fbbhgQTTruB+LMuOOKsdxAAFrC+E6x
 +T1HM0XYB0L9ZLKN3t7KyaWzkpu4tM60b1PkBQSHbZ1vPgvkQqRjFRSx9X8VQh7kfUZm
 gXESgUaDPODOMdOJlpVv4UyLHVlr6o/S/HMWC5JFFBrdsZRnSZXrJBqAy0HMEYxZXJja
 Wh0Y+CIN+a239S53a8SkUwQbeklo4FUqCaVuWHn37fouyK4tb9xWIAg26LFUA2mD4fNI
 wZptJlh89UZJKgU4W/FLMqHG0yzSQG6za8PXWOi8mt/EC3Z96ZcSfr4Npurwx58fP61G
 gjXg==
X-Gm-Message-State: AOJu0YxKGAtK7vEm+8rFyuxtGC3PEKDWcHG7nrpXrIqVmaSalFhgGaaA
 4Au/+7CeMm24u9WQPb6G8LCIK34wtrx9Q1KiQZPtYtw2oWBDXEggiHvR
X-Gm-Gg: AeBDieuoCjMKB/N8Pm4ul3jYOqCczqEcCuhTecPS8ZRM6q/CGYTHDpnskQSs9aRd8Xa
 hoEaKPBRBSKgmoyuTqCqOAGamxwlO8pr09+9u4XNB7pzoOyG6c21ym5adJ4pSNqclmeG6TiArvZ
 ywaed1xgiI7jSIagr040v/RgABu4RKEBRZLsm1J7RUkPAIAMoqOqYme9j007l7bAL2Z2/l030m4
 ou3qW+kiF3TZTbGC418RTRDi7mJBkbvdnhp/z3OcPHHGffrHZKoUzA11p22W+ocDNYkZx7JfCTO
 eME1L89OfHwKCzgSSaWJWqnPVsGby9LyaM7AAcVO1WyA8ADcDvjJRV8GK651mLxv+87cN+i7w/C
 o8x6WRwZsB81UwKH4oWV3h+xcUOo8lSY5x97P2aJiPPrGXh5hn8tZiD0KAtbbjKwcA16ylG0eMG
 bQ/WQQs8GbjMaKNy4n4AEoTzPd/mFms3mj//+gxGM1rU3BtK1VG6DwjJfm04bHmjuRvf8vs3aiW
 86nNuxrValN9+64NjMWbv8riP/aw4e8frN8T813W1jqHH+cWQ==
X-Received: by 2002:a05:7022:90a:b0:128:d715:b717 with SMTP id
 a92af1059eb24-12c73f82878mr789170c88.13.1776417869252; 
 Fri, 17 Apr 2026 02:24:29 -0700 (PDT)
Received: from
 runnervm35a4x.zs354342tb2e3kgisxlw23eeif.dx.internal.cloudapp.net
 ([13.87.216.115]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c75388a20sm784442c88.2.2026.04.17.02.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 02:24:29 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 Apr 2026 09:24:27 +0000
Message-ID: <20260417092427.3643-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417084758.329107-1-pvorel@suse.cz>
References: <20260417084758.329107-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] safe_stdio: More checks for invalid function return values
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCi0tLSBbUEFUQ0ggMS8yXSAtLS0KCk9uIDIwMjYtMDQtMTcsIFBldHIgVm9yZWwg
d3JvdGU6Cj4gc2FmZV9zdGRpbzogTW9yZSBjaGVja3MgZm9yIGludmFsaWQgZnVuY3Rpb24gcmV0
dXJuIHZhbHVlcwoKPiAtCWlmIChyZXQgPT0gRU9GKQo+IC0JCXRzdF9icmttXyhmaWxlLCBsaW5l
bm8sIFRCUk9LIHwgVEVSUk5PLCBOVUxMLCAiZmZsdXNoKCVwKSIsIGYpOwo+ICsJaWYgKHJldCA9
PSBFT0YpIHsKPiArCQl0c3RfYnJrbV8oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJOTywgTlVM
TCwgImZmbHVzaCglcCkgZmFpbGVkIiwgZik7Cj4gKwl9IGVsc2UgaWYgKCFyZXQpIHsKPiArCQl0
c3RfYnJrbV8oZmlsZSwgbGluZW5vLCBUQlJPSyB8IFRFUlJOTywgTlVMTCwKPiArCQkJCSAgIklu
dmFsaWQgZmZsdXNoKCVwKSByZXR1cm4gdmFsdWUgJWQiLCBmLCByZXQpOwo+ICsJfQoKIXJldCBp
cyByZXQgPT0gMCwgd2hpY2ggaXMgZmZsdXNoKCkncyBzdWNjZXNzIHJldHVybiDigJQgdGhpcyBi
cmVha3MgZXZlcnkKY2FsbGVyIG9uIHN1Y2Nlc3MuIGZmbHVzaCgpIG9ubHkgcmV0dXJucyAwIG9y
IEVPRiBwZXIgUE9TSVg7IHRoZXJlIGlzIG5vCmludmFsaWQgcmV0dXJuIHZhbHVlIHRvIGd1YXJk
IGFnYWluc3QsIHNvIGRyb3AgdGhlIGVsc2UgaWYgYnJhbmNoIGVudGlyZWx5LgoKPiArCX0gZWxz
ZSBpZiAocmV0IDwgMCkgewo+ICsJCXRzdF9icmttXyhmaWxlLCBsaW5lbm8sIFRCUk9LIHwgVEVS
Uk5PLCBOVUxMLAo+ICsJCQkJICAiSW52YWxpZCBmdGVsbCglcCkgcmV0dXJuIHZhbHVlICVsZCIs
IGYsIHJldCk7Cgo+ICsJfSBlbHNlIGlmIChyZXQgPCAwKSB7Cj4gKwkJdHN0X2Jya21fKGZpbGUs
IGxpbmVubywgVEJST0sgfCBURVJSTk8sIE5VTEwsCj4gKwkJCQkgICJJbnZhbGlkIGZpbGVubygl
cCkgcmV0dXJuIHZhbHVlICVkIiwgZiwgcmV0KTsKClVzZSByZXQgPCAtMSBoZXJlIHRvIGJlIGNv
bnNpc3RlbnQgd2l0aCBzYWZlX2ZzZWVrKCkgaW4gdGhlIHNhbWUgZmlsZSBhbmQKd2l0aCB0aGUg
cG9saWN5IGVzdGFibGlzaGVkIGJ5IHBhdGNoIDIvMjsgYWxzbyBmaXggdGhlIGNvbnRpbnVhdGlv
bi1saW5lCmluZGVudGF0aW9uICh0YWJzIG9ubHksIG5vIG1peGVkIHNwYWNlcykuCgotLS0gW1BB
VENIIDIvMl0gLS0tCgpPbiAyMDI2LTA0LTE3LCBQZXRyIFZvcmVsIHdyb3RlOgo+IGxpYjogQmUg
cGVkYW50aWMgb24gaW52YWxpZCBjb21wYXJpc29uIGNoZWNrCgo+IGRpZmYgLS1naXQgYS9saWIv
c2FmZV9zdGRpby5jIGIvbGliL3NhZmVfc3RkaW8uYwo+IEBAIC02Nyw3ICs2Nyw3IEBAIGludCBz
YWZlX2FzcHJpbnRmKC4uLikKPiAtCX0gZWxzZSBpZiAocmV0IDwgMCkgewo+ICsJfSBlbHNlIGlm
IChyZXQgPCAtMSkgewo+IC4uLgo+IEBAIC0xNTQsNyArMTU0LDcgQEAgaW50IHNhZmVfZnNlZWso
Li4uKQo+IC0JfSBlbHNlIGlmIChyZXQgPCAwKSB7Cj4gKwl9IGVsc2UgaWYgKHJldCA8IC0xKSB7
CgpUaGlzIGZpeGVzIGFzcHJpbnRmIGFuZCBmc2VlayBidXQgbWlzc2VzIHNhZmVfZnRlbGwoKSBh
bmQgc2FmZV9maWxlbm8oKQpmcm9tIHBhdGNoIDEvMiwgd2hpY2ggYXJlIGxlZnQgd2l0aCByZXQg
PCAwLiBFaXRoZXIgZml4IHRoZW0gaGVyZSBvcgpzd2FwIHRoZSBwYXRjaCBvcmRlciBzbyBuZXcg
Y2hlY2tzIGFyZSB3cml0dGVuIHdpdGggcmV0IDwgLTEgZnJvbSB0aGUgc3RhcnQuCgotLS0KTm90
ZToKCk91ciBhZ2VudCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guIFRoZSBmdWxs
IHJldmlldyBjYW4gYmUgZm91bmQKaW4gdGhlIGNvbnZlcnNhdGlvbiBjb250ZXh0IGFib3ZlLgoK
VGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2gg
b2Z0ZW4gaXRzIGZpbmRpbmdzCmFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBpc3N1ZXMgd2l0aCB0
aGUgcmV2aWV3LCBwbGVhc2UgY29tbWVudCB0aGlzIGVtYWlsCm9yIGlnbm9yZSB0aGUgc3VnZ2Vz
dGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
