Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFEEF3D61E
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 08:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774859994; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=IAzDvRtXfo4e1t7IElMwzUPy0bxTFGZHddVY1jvoisk=;
 b=TrqmCanc1BrU/uhQ5u3x05Jy6KrMXF11z27eZh5EsfGCySE2eNCaDsMwJj3zzb3vFJNvj
 QMNvCijx7UtcuHGvPl5U1MGqwES+jEFWhYcGOyeHrCME9wwMUfzaLdFOzfUZ3WsFkXjlLKH
 Z75xps1hx3q10E/eG8YhvEVHmzYBlwY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 568D53C8235
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:39:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F36743C1014
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:39:29 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9F4D2600795
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:39:28 +0200 (CEST)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43cfde3c3f3so621639f8f.3
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 01:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774859968; x=1775464768; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BWeNb0BQAXCOg4SVOPRcHn+U10d+F1WiQeE5mWAyh1E=;
 b=IL9R7rlc0VLuBWBWzXsEp4qFfBfBQeq1hsxP7qI0HOJs+q+o1S3IveDVvylFPkSKBp
 wUMtILTab/lXsXB+sf9Oa4bQtVBis2Q6bDa3EFZnjxYp2haI3v0cbTq99MvNqu8leQYm
 uZvRe1Vuz5XbL///de5rUZbB5fPq16mzR0Lmjp2n+fddgSV22/cqVnLuLj/UUHNLrwfk
 k46lvdP6Ry/DxGABn1GrLWOsIkKTkmjNxO7ZeUUsDU7Xew3sVuutAfwTgIc+kX7EdLv4
 9dE6tGxH8Rli+PHxGTNYdbTkQCFiCkR/cqf1WR2OqZLfaD1mjSXIf113Sf/mRVyZHQQB
 QWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774859968; x=1775464768;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BWeNb0BQAXCOg4SVOPRcHn+U10d+F1WiQeE5mWAyh1E=;
 b=gjE0TK/XL1V2pyxMuJVSDsJVLy4E3f8WYleS4glXF8loubTwli3Okt7GJ/TDGD/vRU
 C/3ytMMIlRhCg1gnD3zTMbeRiufqljT9KZBvEqyoDsOPZbir8aYQl/OxMEbZyHv4FSQg
 dY1GoIZVpof7ih7M6swqIgj6m5dH2w5XvwFDyRM4kZxOafOJbcCkSnafoaWfqdZ6pQKj
 vc+gnhG2Sa/bxUwYq9IwBNXcKLp2pBRHUMED1FwmiNZyCK+ix7LGo6QyZdX5e/15hiqf
 K9WJ0xb1nBtD6Tw6Dx7mn2PdYN1XR2fn+l5gy0hSI70mvwz1TtEGUiOuSE0sJCeq+1zD
 fWMA==
X-Gm-Message-State: AOJu0YzYsFQdwNRfjhMcYdgZxHJ1fPObexOQ1pk8Yz50ZFLYIg1Tgli4
 l/0o53Fu0egPB4wlmLqkxR2KWad/ciGz6nYU47kRYoDCIa2MjM7mdZuHT/IdNq4og9admQFEIQP
 ic8PLpgk=
X-Gm-Gg: ATEYQzzAoyEwYbS7iMlJVJVtbDeh2hEdiv3WhZysT9fsURxkEJhRps7QE2FiwMFbZjo
 LNeXZwpu5jDzGvuqI1cAeK4AZOL+2LbQ9pBWhIIv8DI1MR2N0Gr9gI/x2uao0aNILDtf0b0W/kd
 3ET9Ezo29HkkidVYjYtNS4dr2kdW4FsFbtoxl+Xe29mNJzdd/o/Fjnsirm5+kK1LuzRHUXLp9ZK
 bNye6mnteYYE24KsbnP1iGLjRMdd/c4sCwwk7mV17Xe8suRakMY4ZH5fUOj8v/bYWrGWxzQXJ5V
 bjwk55jVkWRfJAltxOWVv1ecuXiMiZAZf+FygqRW6j8b/vAM+WqByhccu2h/brd0iKAUdEc8uwa
 /AI61Qcn/xqlmkwy13OBMMusPGV4QljW63i4h8CRni+MGKL5qV/wNkkgUVhUyn3ykwNvJSbga3p
 0s+K/PaFezR9NdIAQzjH1b/GbaDALrfNNLnMK1s1vcq8tTG5ss8t7hl0jIC2Xl69FCJ16OlAo1P
 Z/ao5csJsrQZsPcqxq+E2Y4z0W6qOTV2zA=
X-Received: by 2002:a05:6000:1cd:b0:43c:f1a5:56f6 with SMTP id
 ffacd0b85a97d-43cf1a55854mr10231724f8f.43.1774859967948; 
 Mon, 30 Mar 2026 01:39:27 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf2580168sm17916897f8f.36.2026.03.30.01.39.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 01:39:27 -0700 (PDT)
Message-ID: <69ca36bf.df0a0220.9a4c5.bfe1@mx.google.com>
To: lufei <lufei@uniontech.com>
In-Reply-To: <20260330071554.49304-1-lufei@uniontech.com>
Date: Mon, 30 Mar 2026 08:39:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Rewrite ftrace_regression tests with new C API
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
Cc: lufei <lufei@uniontech.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgbHVmZWksCgo+ICsvKioKPiArICogZmlsZV9jb250YWluc19saW5lIC0gQ2hlY2sgaWYgYSBm
aWxlIG9jbnRhaW5zIHNwZWNpZmljIGxpbmUsIHN0cmljdGx5CgpUeXBvOiAib2NudGFpbnMiIC0+
ICJjb250YWlucyIuCgo+ICtzdGF0aWMgaW5saW5lIGludCBmaWxlX2NvbnRhaW5zKGNvbnN0IGNo
YXIgKnBhdGgsIGNvbnN0IGNoYXIgKnN0cikKPiArewo+ICsJY2hhciAqYnVmID0gU0FGRV9NQUxM
T0MoRlRSQUNFX0ZJTEVfQlVGX1NJWkUpOwo+ICsKPiArCWJ1ZlswXSA9ICdcMCc7Cj4gKwlTQUZF
X0ZJTEVfU0NBTkYocGF0aCwgIiUxMDQ4NTc1W15ceDAxXSIsIGJ1Zik7CgpUaGUgaGFyZGNvZGVk
IHdpZHRoIDEwNDg1NzUgbXVzdCBiZSBrZXB0IGluIHN5bmMgd2l0aCBGVFJBQ0VfRklMRV9CVUZf
U0laRSAtIDEKbWFudWFsbHkuIEFsc28sIGFsbG9jYXRpbmcgMSBNQiBvbiBlYWNoIGNhbGwgaXMg
aGVhdnkg4oCUIGZpbGVfY29udGFpbnMoKSBpcwpjYWxsZWQgdHdpY2UgaW4gZnRyYWNlX3JlZ3Jl
c3Npb24wMi4gQ29uc2lkZXIgYSBzaW1wbGVyIGZpbGUgcmVhZGluZyBhcHByb2FjaC4KCj4gZGlm
ZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvdHJhY2luZy9mdHJhY2VfdGVzdC9mdHJhY2VfcmVn
cmVzc2lvbjAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3RyYWNpbmcvZnRyYWNlX3Rlc3QvZnRyYWNl
X3JlZ3Jlc3Npb24wMS5jCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKWy4uLl0KPiArCWZvciAoaSA9
IDA7IGkgPCBMT09QOyBpKyspIHsKPiArCQlTQUZFX0ZJTEVfUFJJTlRGKFNUQUNLX1RSQUNFUl9Q
QVRILCAiMSIpOwo+ICsJCVNBRkVfRklMRV9QUklOVEYoVFJBQ0VfT1BUSU9OUywgInVzZXJzdGFj
a3RyYWNlIik7ClsuLi5dCj4gKwkJU0FGRV9GSUxFX1BSSU5URihwYWdlX2ZhdWx0X3BhdGgsICIx
Iik7Cj4gKwl9CgpUaGUgb2xkIHNoZWxsIHNjcmlwdCBzYXZlZCBhbmQgcmVzdG9yZWQgdGhlIHBh
Z2UgZmF1bHQgZW5hYmxlIHZhbHVlIGFmdGVyCnRoZSBsb29wLiBUaGlzIHZlcnNpb24gd3JpdGVz
ICIxIiBidXQgbmV2ZXIgcmVzdG9yZXMgaXQuIFVubW91bnRpbmcgZGVidWdmcwpkb2VzIG5vdCBy
ZXNldCBrZXJuZWwgdHJhY2luZyBzdGF0ZS4gUGxlYXNlIGFkZCB0aGUgcGFnZV9mYXVsdF9wYXRo
IHRvCi5zYXZlX3Jlc3RvcmUgb3Igc2F2ZS9yZXN0b3JlIGl0IG1hbnVhbGx5LgoKPiBkaWZmIC0t
Z2l0IGEvdGVzdGNhc2VzL2tlcm5lbC90cmFjaW5nL2Z0cmFjZV90ZXN0L2Z0cmFjZV9yZWdyZXNz
aW9uMDIuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvdHJhY2luZy9mdHJhY2VfdGVzdC9mdHJhY2VfcmVn
cmVzc2lvbjAyLmMKPiBuZXcgZmlsZSBtb2RlIDEwMDY0NApbLi4uXQo+ICsvKlwKPiArICoKPiAr
ICogQ2hlY2sgc2lnbmFsOnNpZ25hbF9nZW5lcmF0ZSBnaXZlcyAyIG1vcmUgZmllbGRzOiBncnAg
cmVzCj4gKyAqCj4gKyAqLwoKUmVtb3ZlIHRoZSBibGFuayBsaW5lcyBiZWZvcmUvYWZ0ZXIgdGhl
IGRlc2NyaXB0aW9uIGluc2lkZSB0aGUgLypcIGJsb2NrLgoKPiArCWlmIChmaWxlX2NvbnRhaW5z
KFRSQUNFX0ZJTEUsICJncnA9IikgJiYgZmlsZV9jb250YWlucyhUUkFDRV9GSUxFLCAicmVzPSIp
KQoKVGhlIG9sZCB0ZXN0IHVzZWQgJ2dycD1bMC05XSByZXM9WzAtOV0nIHdoaWNoIHZlcmlmaWVk
IGJvdGggZmllbGRzIGFwcGVhciBvbgp0aGUgc2FtZSBsaW5lIHdpdGggZGlnaXQgdmFsdWVzLiBU
aGlzIG9ubHkgY2hlY2tzIGZvciBzdWJzdHJpbmdzIGluZGVwZW5kZW50bHksCndoaWNoIGlzIGxl
c3Mgc3RyaWN0LgoKQWxzbywgdGhlcmUgaXMgbm8gLmdpdGlnbm9yZSBpbiB0aGUgZnRyYWNlX3Rl
c3QgZGlyZWN0b3J5LiBQbGVhc2UgYWRkIG9uZQp3aXRoIGVudHJpZXMgZm9yIGZ0cmFjZV9yZWdy
ZXNzaW9uMDEgYW5kIGZ0cmFjZV9yZWdyZXNzaW9uMDIuCgpSZWdhcmRzLAotLQpBbmRyZWEgQ2Vy
dmVzYXRvClNVU0UgUUUgQXV0b21hdGlvbiBFbmdpbmVlciBMaW51eAphbmRyZWEuY2VydmVzYXRv
QHN1c2UuY29tCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
