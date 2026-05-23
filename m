Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFA4CD5BAC
	for <ltp@archiver.kernel.org>; Sat, 23 May 2026 18:08:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B7DB3E658C
	for <ltp@archiver.kernel.org>; Sat, 23 May 2026 20:08:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 377A93C58F2
 for <ltp@lists.linux.it>; Sat, 23 May 2026 20:07:57 +0200 (CEST)
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com
 [IPv6:2607:f8b0:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 84E6620014D
 for <ltp@lists.linux.it>; Sat, 23 May 2026 20:07:57 +0200 (CEST)
Received: by mail-ot1-x344.google.com with SMTP id
 46e09a7af769-7e6201aeb2aso608628a34.3
 for <ltp@lists.linux.it>; Sat, 23 May 2026 11:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779559676; x=1780164476; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+uh9BXDP9i1IceRQUrbOtXsPgRWS2k1UOCBFDa98Dk=;
 b=dgshpiVxqnBvuDus8fz0XTYDwDf28mDm0Wma2dYZcmUvMenem9ZfBMTwhFz/OZSyny
 1svhQEfrZVuULNj/7+Z1/4Z3MKFlOyh5r0WMmmvR5vm4qkTfRBrKNxpvX18XoKrTaJFb
 h7zPNV+MHLn0BO9+fGN0j4ssW8xefzjRL4yluI8ztaMh4UspUiOs4cAW5nh5834FvbT7
 0z5aHgg58F7KGN/bj6k2qK3KqG80Up9YsqdKqcX1DGGLHLxix47EYM71o3PCZSGijdEF
 /5yG1qjxWbnGQDlWilV7Pq/192ccKmtXoJ1HtPMGkv4t9MU8jNbaDGXNlsrFnmAiT5cA
 YZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779559676; x=1780164476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=g+uh9BXDP9i1IceRQUrbOtXsPgRWS2k1UOCBFDa98Dk=;
 b=bOEnBZKKHjgDtFFIDaYEXQ3Q20v6S6Q33/kLlautfit58pzMDdqjpFlN2kAdrBA5YN
 kfGLP47gRA5tsqgey6ttlQIzwj5vhM8MRw+/W1wAZr42gOg22iu0rzVwbs2rJZYV6a7b
 Ozgg0j2+YTAJbMUvsfukJczYOeLCP+a9DiyhxH/sMCJcpK0Eecj4+AKPoFGxUMMx9SAd
 Q3wZ7peHdyQmoC1dH9dGkblzNYJCuOF0PpHvSkPN1cKeIs2xP9LIecwiyh/QZngq3Lde
 jXnsQm92nNhcQnsQoip36i3hb8HZSwdLJ0icOWhz9+RXipDcQx+aVcSR9AaLkotG1eeP
 hdDg==
X-Gm-Message-State: AOJu0Ywm07wjE4AFeHI38lfqAmBnWdioY5igUvgOBxHi4+sNF08yzSuw
 R4eHKOmhIn1xjez9btdzKsAnAFm9e8cSptctw+2bPdX1SVyUO5RHyE7T
X-Gm-Gg: Acq92OHZjvuCEInmMphkDIACRiCGCzFfbK7azZ0Zjzj3yM2ldb0BQd4gLOE6aQxftp1
 PtiKKJsm0VGBbfb2y3M0a4JiX4OpNwv3ldjeDiGcg2ncCyZMFFzvbUVWmdhFUBHMGxBSrPUwPTf
 Hg2sYlFV1Cp8Pg0Yt8AR2zIlA4Pb8HLy3wWS6s5Wkfn3u1Hyut/XzjPaAjPmmhpfZ0UplKtZDdb
 yzXsRW5ao0YX5BbBTzU4AcWaJxG0fc6On+82EyHWQG25saKmwXLwy5WbbfpPCQhAPaHZgGnBgXU
 RIvXAHG/JZvkJz9gSDyXRE+4H5TRYT28cklEcJFkRRjzVIR0/6Gc794ungPHht/6kCnmY4y380u
 HWHfUP43KCTUVp9aCzSqo2urs6Y/z8L1rPiuscqsB3CGTjDO5zuMh5ImyMOA6swqCxQ8vww43eZ
 nuWPwe08c9EB2bwax6/qkBLUPiE/K7qXFZP27EHkU0PUNy9G1zEvrQNP9vZ7xh/QvLPhSybcawX
 SogJweLGQC6a2Ns/9HrfWU+ULIkxhtPQtZTcoI3lmkmPtAyK/U=
X-Received: by 2002:a05:6830:7309:b0:7dc:cefa:1c37 with SMTP id
 46e09a7af769-7e5fee7650amr5417397a34.23.1779559676146; 
 Sat, 23 May 2026 11:07:56 -0700 (PDT)
Received: from
 runnervmg397c.puhy35dt5qredbdnpghlbhtnxe.gx.internal.cloudapp.net
 ([172.212.160.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606459dadsm3640337a34.4.2026.05.23.11.07.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 11:07:55 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Sat, 23 May 2026 18:07:54 +0000
Message-ID: <20260523180754.3853-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523165718.26187-1-sebastian.chlad@suse.com>
References: <20260523165718.26187-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_uring/pintheft: Add CVE-2026-43494 regression test
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

SGkgU2ViYXN0aWFuLAoKT24gU2F0LCAyMyBNYXkgMjAyNiAxODo1NzoxOCArMDIwMCwgU2ViYXN0
aWFuIENobGFkIHdyb3RlOgo+IGlvX3VyaW5nL3BpbnRoZWZ0OiBBZGQgQ1ZFLTIwMjYtNDM0OTQg
cmVncmVzc2lvbiB0ZXN0CgpbLi4uXQoKPiArI2lmbmRlZiBIQVZFX1NUUlVDVF9JT19VUklOR19D
TE9ORV9CVUZGRVJTCj4gK3N0cnVjdCBpb191cmluZ19jbG9uZV9idWZmZXJzIHsKPiArICAgICAg
IHVpbnQzMl90IHNyY19mZDsKPiArICAgICAgIHVpbnQzMl90IGZsYWdzOwo+ICsgICAgICAgdWlu
dDMyX3QgcGFkWzZdOwo+ICt9Owo+ICsjZW5kaWYKClRoZSBmYWxsYmFjayBzdHJ1Y3QgZG9lc24n
dCBtYXRjaCB0aGUgdXBzdHJlYW0ga2VybmVsIGRlZmluaXRpb24KKGluY2x1ZGUvdWFwaS9saW51
eC9pb191cmluZy5oKS4gIFRoZSBrZXJuZWwgaGFzOgoKICBzdHJ1Y3QgaW9fdXJpbmdfY2xvbmVf
YnVmZmVycyB7CiAgICAgICAgICBfX3UzMiAgIHNyY19mZDsKICAgICAgICAgIF9fdTMyICAgZmxh
Z3M7CiAgICAgICAgICBfX3UzMiAgIHNyY19vZmY7CiAgICAgICAgICBfX3UzMiAgIGRzdF9vZmY7
CiAgICAgICAgICBfX3UzMiAgIG5yOwogICAgICAgICAgX191MzIgICBwYWRbM107CiAgfTsKClRv
dGFsIHNpemUgaXMgdGhlIHNhbWUgKDggw5cgdTMyID0gMzIgYnl0ZXMpLCBzbyB0aGUgdGVzdCBo
YXBwZW5zIHRvCndvcmsgY29ycmVjdGx5IGJlY2F1c2UgeW91IHplcm8gdGhlIHdob2xlIHN0cnVj
dCBhbmQgb25seSBzZXQgc3JjX2ZkLgpCdXQgdGhlIGxhcGkgaGVhZGVyIGlzIHdyb25nOiBmdXR1
cmUgdXNlcnMgd2hvIHRyeSB0byBzZXQgc3JjX29mZiwKZHN0X29mZiwgb3IgbnIgd2lsbCB3cml0
ZSBpbnRvIHBhZFtdIGluc3RlYWQgb2YgdGhlIHJlYWwgZmllbGRzLiAgRml4CnRoZSBmYWxsYmFj
ayB0byBtYXRjaCB0aGUga2VybmVsIGxheW91dC4KClsuLi5dCgo+ICsJZm9yIChpID0gMCwgZWZh
dWx0cyA9IDA7IGkgPCBHVVBfUElOX0NPVU5USU5HX0JJQVM7IGkrKykgewoKWy4uLl0KCj4gKwkJ
cmV0ID0gc2VuZG1zZyhyZHNfZmQsICZtc2csIE1TR19aRVJPQ09QWSB8IE1TR19ET05UV0FJVCk7
Cj4gKwkJaWYgKHJldCA+PSAwKQo+ICsJCQl0c3RfYnJrKFRCUk9LLCAic2VuZG1zZygpIHVuZXhw
ZWN0ZWRseSBzdWNjZWVkZWQgYXQgaXRlciAlZCIsIGkpOwoKVGhlIFJEUyBzb2NrZXQgaXMgb3Bl
bmVkIHdpdGggU09DS19DTE9FWEVDIGJ1dCBubyBPX0NMT0VYRUMgaXMgc2V0Cm9uIHRoZSBpb191
cmluZyByaW5nIGZkcyAocmluZ19mZDEsIHJpbmdfZmQyKS4gIEJvdGggcmluZ3MgYXJlCnRoZXJl
Zm9yZSBpbmhlcml0ZWQgYnkgdGhlIGZvcmsoKWVkIGNoaWxkLiAgdHJpZ2dlcigpIC0+IGNsZWFu
dXAoKQp1bnJlZ2lzdGVycyBidWZmZXJzIGZyb20gdGhlICpzaGFyZWQqIGlvX3VyaW5nIGluc3Rh
bmNlcyBiZWZvcmUgdGhlCmNoaWxkIGV4aXRzLCBzbyB0aGUgcGFyZW50J3MgY2xlYW51cCgpIGhp
dHMgSU9SSU5HX1VOUkVHSVNURVJfQlVGRkVSUwpvbiBhbHJlYWR5LXVucmVnaXN0ZXJlZCByaW5n
cy4gIFRoZSByZXR1cm4gdmFsdWUgb2YgaW9fdXJpbmdfcmVnaXN0ZXIoKQppbiBjbGVhbnVwKCkg
aXMgc2lsZW50bHkgaWdub3JlZCwgc28gdGhpcyBkb2Vzbid0IGNyYXNoLCBidXQgaXQgbWVhbnMK
dGhlICJkb3VibGUtdW5waW4gV0FSTi9CVUdfT04iIGNhbiBmaXJlIGluIHRoZSBjaGlsZCdzIGNs
ZWFudXAgcGFzcwpiZWZvcmUgdGhlIHBhcmVudCBldmVuIGdldHMgdG8gY2hlY2sgdGFpbnQuICBD
b25zaWRlciBvcGVuaW5nIHRoZSByaW5nCmZkcyB3aXRoIE9fQ0xPRVhFQyBzbyB0aGUgY2hpbGQg
b25seSBvcGVyYXRlcyBvbiB0aGUgcmRzIHNvY2tldCwgb3IKZG9jdW1lbnQgdGhlIGludGVudGlv
bmFsIHNoYXJpbmcgZXhwbGljaXRseS4KClsuLi5dCgpTdW1tYXJ5OiB0aGUgc3RydWN0IGlvX3Vy
aW5nX2Nsb25lX2J1ZmZlcnMgZmFsbGJhY2sgZGVmaW5pdGlvbiBtdXN0IGJlCmNvcnJlY3RlZCB0
byBtYXRjaCB0aGUga2VybmVsIGxheW91dCBiZWZvcmUgbWVyZ2luZy4KCi0tLQpOb3RlOgoKT3Vy
IGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRjaC4gVGhlIGFnZW50IGNhbiBz
b21ldGltZXMKcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzIGZpbmRp
bmdzIGFyZSBnZW51aW5lLiBJZiB5b3UKZmluZCBpc3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVh
c2UgY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUKc3VnZ2VzdGlvbnMuCgpSZWdhcmRz
LApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
