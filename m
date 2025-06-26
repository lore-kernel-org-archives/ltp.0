Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCB5C7115B
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 07:04:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBF883CCBA3
	for <ltp@archiver.kernel.org>; Thu, 26 Jun 2025 09:04:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 876933CB577
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 09:03:59 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B13DB200937
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 09:03:57 +0200 (CEST)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-313154270bbso725642a91.2
 for <ltp@lists.linux.it>; Thu, 26 Jun 2025 00:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750921435; x=1751526235; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9C/yPC65dyt5L285Ad0r8Enf6n6g55IaUv+DoEN+0PI=;
 b=CcWhZrKdvK5HGTM75dcTg4Ny2IQ3+RWoyFUcH1XPEvbktRd8eaArM8o5aDLfmztSN8
 52+xoliRjJt81D4XEZBvUqvdHRE8WDvrXpQkkfoCD7o2E44fEmR86MS1nI9PqSc8cKMJ
 4IX1Uvy4NKPUTskV9Y/lWnlGJJENrWOrQ0F0yl1Rc+cAFj/EQhSwZJuhNDIYV0Gczwvn
 WNTG1al4TS1OC1rTYguYIB1MCO3FgaLghKfzI269ZSr6b/4J2Qk4HOGX2pmSzgw2+eXC
 ZTvuRJG6eB/lPGmraxJ+lKXvYUjZGm96S4mn+DYMJJo/UQgcnBRfc6WwTGkdHzwtmX+Y
 59mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750921435; x=1751526235;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9C/yPC65dyt5L285Ad0r8Enf6n6g55IaUv+DoEN+0PI=;
 b=tficuqWn2R8Lzz0qp71H91EhSSaLbx1tbkT+xLANyptVYsbhW478M+5W5ehFcJw/LI
 x92dNB6DoznXmbRRVk8qZlv4uhRgMMa2HABH+Uz95frUI6AAoULLkIOFRySJf5j7zceQ
 3rBbUVLPvFqY0D1thbIaCbgYtXNrwoeVECFdatHD2woASqk8rlvOxcnUyNW+rwwnvrIz
 IXQS86BrLmAWoKTHyIhwWmZPJuZbRtiA83/I1zzsAo9gE7g4YFMoUsyNS2d+1izhvTwH
 C6iGa+Obaq9n34NhWeyAfN2hgq17hNHEabE/41RkgILMKQHXx8EKcBvu9Au24IqSnzMU
 F/rA==
X-Gm-Message-State: AOJu0YxFnbw83sETWjjOq/GZ902FCHCstu8xHRZmrxLhS4RsefZVtpTO
 ZPBRZjGRk3GY3Xf0WyYOec/IztBFcMbVgiqqy54IlzGzBLV0ivXvbsTSwe/zq4fc/Bd6r69MvZ8
 BU4rnuWjxagEAd89A51HJ5s26Q8yvIVJ7cZQSJb3bx+i8EefcOGwdt1wgOg==
X-Gm-Gg: ASbGncu/1XCGv4j4NvA5ANtTNobnO6jCgJn7i7/H7WgMggYqmgwnNLIV/gP5oZA36L7
 H0euM1D3NSm7bKTTsdOH9R3MRdDaGmLveHWTfTSgJw/xzlLP0HvgF1/1N0H3iRcmm9cqvo6/CZV
 8Ef9xJ07oGoI0N4ESuSoTYeWZfNSdRW9jYpmOv5Qm/IIIB8XG+E+q4NVCV6/agWnMXXbEdIYzh7
 27L
X-Google-Smtp-Source: AGHT+IGB3/XrVvwCiSKGcdM/uKLZZR2BBjt/EJ8TFkLwSBLUw9n1kq4/A/cuTaHIdw+LRFJ+QBCRjPhK4cZiYm51gdc=
X-Received: by 2002:a17:90b:53c5:b0:312:1508:fb4e with SMTP id
 98e67ed59e1d1-315f2675bbbmr9154353a91.17.1750921435517; Thu, 26 Jun 2025
 00:03:55 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 26 Jun 2025 12:33:43 +0530
X-Gm-Features: Ac12FXzrp0QOBUWJ7tIxkv-cgchxT19rQvDD483_utcFbw2DHpKfR-GbfFmMvSU
Message-ID: <CA+G9fYtJO4DbiabJwpSamTPHjPzyrD3O6ZCwm2+CDEUA7f+ZYw@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>, open list <linux-kernel@vger.kernel.org>, 
 linux-stable <stable@vger.kernel.org>, lkft-triage@lists.linaro.org, 
 Linux Regressions <regressions@lists.linux.dev>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] stable-rc: 5.4 and 5.10: fanotify01.c:339: TFAIL:
 fanotify_mark(fd_notify, 0x00000001, 0x00000008, -100,
 ".") expected EXDEV: ENODEV (19)
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
Cc: Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
 Al Viro <viro@zeniv.linux.org.uk>, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UmVncmVzc2lvbiBpbiB0aGUgTFRQIHN5c2NhbGxzL2Zhbm90aWZ5MDEgdGVzdCBvbiB0aGUgTGlu
dXggc3RhYmxlLXJjIDUuNAphbmQgNS4xMCBrZXJuZWwgYWZ0ZXIgdXBncmFkaW5nIHRvIExUUCB2
ZXJzaW9uIDIwMjUwNTMwLgoKIC0gVGhlIHRlc3QgcGFzc2VkIHdpdGggTFRQIHZlcnNpb24gMjAy
NTAxMzAKIC0gVGhlIHRlc3QgZmFpbHMgd2l0aCBMVFAgdmVyc2lvbiAyMDI1MDUzMAoKUmVncmVz
c2lvbnMgZm91bmQgb24gc3RhYmxlLXJjIDUuNCBhbmQgNS4xMCBMVFAgc3lzY2FsbHMgZmFub3Rp
ZnkwMS5jCmZhbm90aWZ5X21hcmsgZXhwZWN0ZWQgRVhERVY6IEVOT0RFViAoMTkpCgpSZWdyZXNz
aW9uIEFuYWx5c2lzOgogLSBOZXcgcmVncmVzc2lvbj8gWWVzCiAtIFJlcHJvZHVjaWJpbGl0eT8g
WWVzCgpUZXN0IHJlZ3Jlc3Npb246IHN0YWJsZS1yYyA1LjQgYW5kIDUuMTAKClJlcG9ydGVkLWJ5
OiBMaW51eCBLZXJuZWwgRnVuY3Rpb25hbCBUZXN0aW5nIDxsa2Z0QGxpbmFyby5vcmc+CgpmYW5v
dGlmeTAxLmM6MzM5OiBURkFJTDogZmFub3RpZnlfbWFyayhmZF9ub3RpZnksIDB4MDAwMDAwMDEs
CjB4MDAwMDAwMDgsIC0xMDAsICIuIikgZXhwZWN0ZWQgRVhERVY6IEVOT0RFViAoMTkpCgpUaGUg
dGVzdCBleHBlY3RlZCBmYW5vdGlmeV9tYXJrKCkgdG8gZmFpbCB3aXRoIEVYREVWLCBidXQgcmVj
ZWl2ZWQKRU5PREVWIGluc3RlYWQuIFRoaXMgaW5kaWNhdGVzIGEgcG90ZW50aWFsIG1pc21hdGNo
IGJldHdlZW4gdXBkYXRlZApMVFAgdGVzdCBleHBlY3RhdGlvbnMgYW5kIHRoZSBiZWhhdmlvciBv
ZiB0aGUgNS40IGtlcm5lbOKAmXMgZmFub3RpZnkKaW1wbGVtZW50YXRpb24uCgpUZXN0IGxvZywK
LS0KCmZhbm90aWZ5MDEuYzo5NDogVElORk86IFRlc3QgIzM6IGlub2RlIG1hcmsgZXZlbnRzIChG
QU5fUkVQT1JUX0ZJRCkKZmFub3RpZnkwMS5jOjMwMTogVFBBU1M6IGdvdCBldmVudDogbWFzaz0z
MSBwaWQ9MjM2NCBmZD0tMQouLi4KZmFub3RpZnkwMS5jOjMwMTogVFBBU1M6IGdvdCBldmVudDog
bWFzaz04IHBpZD0yMzY0IGZkPS0xCmZhbm90aWZ5MDEuYzozMzk6IFRGQUlMOiBmYW5vdGlmeV9t
YXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwKMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3Rl
ZCBFWERFVjogRU5PREVWICgxOSkKZmFub3RpZnkwMS5jOjk0OiBUSU5GTzogVGVzdCAjNDogbW91
bnQgbWFyayBldmVudHMgKEZBTl9SRVBPUlRfRklEKQpmYW5vdGlmeTAxLmM6MzAxOiBUUEFTUzog
Z290IGV2ZW50OiBtYXNrPTMxIHBpZD0yMzY0IGZkPS0xCi4uLgpmYW5vdGlmeTAxLmM6MzAxOiBU
UEFTUzogZ290IGV2ZW50OiBtYXNrPTggcGlkPTIzNjQgZmQ9LTEKZmFub3RpZnkwMS5jOjMzOTog
VEZBSUw6IGZhbm90aWZ5X21hcmsoZmRfbm90aWZ5LCAweDAwMDAwMDAxLAoweDAwMDAwMDA4LCAt
MTAwLCAiLiIpIGV4cGVjdGVkIEVYREVWOiBFTk9ERVYgKDE5KQpmYW5vdGlmeTAxLmM6OTQ6IFRJ
TkZPOiBUZXN0ICM1OiBmaWxlc3lzdGVtIG1hcmsgZXZlbnRzIChGQU5fUkVQT1JUX0ZJRCkKZmFu
b3RpZnkwMS5jOjMwMTogVFBBU1M6IGdvdCBldmVudDogbWFzaz0zMSBwaWQ9MjM2NCBmZD0tMQou
Li4KZmFub3RpZnkwMS5jOjMwMTogVFBBU1M6IGdvdCBldmVudDogbWFzaz04IHBpZD0yMzY0IGZk
PS0xCmZhbm90aWZ5MDEuYzozMzk6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgw
MDAwMDAwMSwKMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFWERFVjogRU5PREVWICgx
OSkKCgojIyBUZXN0IGxvZ3MKKiBCdWlsZCBkZXRhaWxzOgpodHRwczovL3JlZ3Jlc3Npb25zLmxp
bmFyby5vcmcvbGtmdC9saW51eC1zdGFibGUtcmMtbGludXgtNS40LnkvdjUuNC4yOTQtMjIzLWc3
ZmYyZDMyMzYyZTQvbHRwLXN5c2NhbGxzL2Zhbm90aWZ5MDEvCiogQnVpbGQgZGV0YWlsIDI6Cmh0
dHBzOi8vcmVncmVzc2lvbnMubGluYXJvLm9yZy9sa2Z0L2xpbnV4LXN0YWJsZS1yYy1saW51eC01
LjEwLnkvdjUuMTAuMjM4LTM1My1nOWRjODQzYzY2ZjZmL2x0cC1zeXNjYWxscy9mYW5vdGlmeTAx
LwoqIFRlc3QgbG9nOiBodHRwczovL3FhLXJlcG9ydHMubGluYXJvLm9yZy9hcGkvdGVzdHJ1bnMv
Mjg4NTkzMTIvbG9nX2ZpbGUvCiogSXNzdWU6IGh0dHBzOi8vcmVncmVzc2lvbnMubGluYXJvLm9y
Zy8tL2tub3duLWlzc3Vlcy82NjA5LwoqIFRlc3QgTEFWQSBqb2IgMToKaHR0cHM6Ly9sa2Z0LnZh
bGlkYXRpb24ubGluYXJvLm9yZy9zY2hlZHVsZXIvam9iLzgzMjkyNzgjTDI4NTcyCiogVGVzdCBM
QVZBIGpvYiAyOgpodHRwczovL2xrZnQudmFsaWRhdGlvbi5saW5hcm8ub3JnL3NjaGVkdWxlci9q
b2IvODMyNjUxOCNMMjg0OTEKKiBCdWlsZCBsaW5rOiBodHRwczovL3N0b3JhZ2UudHV4c3VpdGUu
Y29tL3B1YmxpYy9saW5hcm8vbGtmdC9idWlsZHMvMnl4SEd2VmtWcGNiS3FQYWhTS1JubElUblZT
LwoqIEJ1aWxkIGNvbmZpZzoKaHR0cHM6Ly9zdG9yYWdlLnR1eHN1aXRlLmNvbS9wdWJsaWMvbGlu
YXJvL2xrZnQvYnVpbGRzLzJ5eEhHdlZrVnBjYktxUGFoU0tSbmxJVG5WUy9iekltYWdlCgoKLS0K
TGluYXJvIExLRlQKaHR0cHM6Ly9sa2Z0LmxpbmFyby5vcmcKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
