Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F39C8303D
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751643639; h=date :
 message-id : mime-version : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=DtAH2pAUGDQfuk7grhH8qtF2TznPfY8SMhuPoy9p8hY=;
 b=gS1udXwqta/sog5ywCWGcJNqu7BsWjJo+H2YcFsQU/pTC5JzNFdgWP57BmUYu1hOao4F/
 HEvfLP85t5+HlbZT5BgPifcOtHaXHqB0H8ss664c5hnbAywfD/gjEe2YMDtU7oCtzZUcU3b
 KYmKUvkGt2F1O6uwINjtv+3zVxibQbc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3C413C9F52
	for <ltp@archiver.kernel.org>; Fri,  4 Jul 2025 17:40:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF3F13C8653
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 17:40:18 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 83A28600CE1
 for <ltp@lists.linux.it>; Fri,  4 Jul 2025 17:40:17 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a525eee2e3so665462f8f.2
 for <ltp@lists.linux.it>; Fri, 04 Jul 2025 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751643616; x=1752248416; darn=lists.linux.it;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K1CMXfgvSe1H7gOwU8H4J3p/TgE/bqwX3HNxZaNzydU=;
 b=bKxFcEz5eHSkX7jEvJvA7AqGD5uAlPZnTSww5wJRi5y8hoU1a+yuI5fXsStSGA4+BR
 6WN3CdZxua2pHbucKjutFQ+U1A/lcOEdOJKwoy55jEoj4zL+of8JIt3PIeHDlJerUM/P
 uNI5dhnvuB8xkBpz4OFCkVmoqI5RFSF6jb9EPn89VE1o3KSe5buW0AOezuvLtr8skeW7
 ypHEsclZCddEP9PWzlJRZ1jDW1RMNewMNyHDxPrbHO8H0+jaBAp3HRyFzwpg++GKOSNA
 n8r+DXTj9nb+pFfHDOdzQBHRz6/NBje9HhgyXTk/znn5ye+Jc4E3i0dO1E1r2Up81dzm
 1xbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751643616; x=1752248416;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K1CMXfgvSe1H7gOwU8H4J3p/TgE/bqwX3HNxZaNzydU=;
 b=Ne8m07qdqRbEJRSh9EKBFJN8UXKTSGEkKm8/VqLYV2Qs0KA83REGAKuJUivR67z1hx
 QdzQIQ8OSxLXTz+5xowkNZYCdBi1aAObfFW8Qin9Evk5IwerBE1Wlf/dScdEy+H4sCCg
 tL++MNqROdxHVbzJ+zecTNydD95Fy1mCy3Fq2AASICjv33pFikiakMxynww1yAMYeF6k
 MCfEZ3mtj72LwMfaKG33MCf5l8QpnAwrmweTdpBBTU+LYY5xqLGAGsXH8bWxWxKZdOu+
 BUwdLZPPBZETmoWHAKL0baowd0Gc9KMyRrl+kem5ufzHJ1zgGzfh8xA+T4E8P9NCv8ml
 FXJg==
X-Gm-Message-State: AOJu0Yw33z+ZbfdwEpRK93hDS/Kf2Oj2oumq3p8mtKrmstgpSHCPUnql
 2+cWYymDdfKEIR9hNSU5GfCeNUJUTI3OXkfu7s4BnrP7HTFxleqi01BFs2XmbjinNxT25IKB35p
 mFggc
X-Gm-Gg: ASbGncs1ExkHUFMxUXN+KMOd+IJZ6UVXNwvCDWCAabMHHhXVJ85ib7NH/D2T+HFlfeq
 /OS4lTgkERbA6Z4ylkjfcS1rBiiRv0qUSB7MJswwuJMsBODlpwDgdt4aWXjnVgu/xHw7R+L/aTG
 qvVUA+nH7EjxsJ1FFx7VlkFKBe6Se53im8d980lRYLqzuhe2r975c/pMyTFpdE/u1ZABZl0QWXg
 Jw4JROYW7BBN4v05DXh09xMQ7ZF5k+0ISucGEuJI8kLucl8M/3jo5ryxFhxPQ2BzzEhEROIZYVy
 1srC7LZCC8spvgW5Lovs6YfcWxcc2wS0V5UmBEj0wHVSt2PlZQ==
X-Google-Smtp-Source: AGHT+IFaUrRLKwR3HTgn+pf7dJNkRHtwqDaQKQada2fedGU8/d8xImwEOySpjEXJjNo03c1uc77a1A==
X-Received: by 2002:a05:6000:70b:b0:3a4:f7e6:284b with SMTP id
 ffacd0b85a97d-3b4964bdb5fmr2217462f8f.10.1751643616541; 
 Fri, 04 Jul 2025 08:40:16 -0700 (PDT)
Received: from localhost ([177.45.162.214])
 by smtp.gmail.com with UTF8SMTPSA id
 6a1803df08f44-702c4d5ac6dsm13887446d6.96.2025.07.04.08.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 08:40:15 -0700 (PDT)
Date: Fri, 04 Jul 2025 12:40:08 -0300
Message-Id: <20250704-conversions-munmap-v2-0-bac3a0aa117b@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANj1Z2gC/32NQQ6CMBBFr0K6tqYUQXDlPQyLoQzSRVsyA42Gc
 HdbDuDyJe+/vwtGssjiUeyCMFq2wSfQl0KYGfwbpR0TC610re6qkib4iJQ1lm7zDhZZDQ3obgL
 QTSvScCGc7OeMvvrEAzDKgcCbOacc8IqUxdnyGuh7nscy639/YimVrNSIrR7rTqnbkzfGqwlO9
 Mdx/ACzIk9wzAAAAA==
X-Change-ID: 20250703-conversions-munmap-3b6a29faa268
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1045; i=rbm@suse.com;
 h=from:subject:message-id; bh=KPUaRiVf+b7tx/4gCxN9nR9mUkpyZt0aywtbTExKDu4=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBoZ/XaQO6lCqdBhEf1iJBDTye9JYx1McADVG8vH
 Zt3qrCRFFqJAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCaGf12gAKCRDJC4p8Y4ZY
 ppfkD/48xfRnbOYsFgExf558SZDBU2kiJOzrfW4XS9oqdeUWUbj4uXrGN9hZ9BlVMyNimW3mOHc
 eMITvtnXK5V6w5ltT0AhPvr6U9Dva2hWgjAYYVe2sqSt2efsQ1u4Ycvcj6jJ9CskY6Zqdpvm8Bd
 bX/tKdMdEq99ZahU89QcWBUwp0i4pNBl21f3XEcaXigWaJ1ZBOAocmmHkIQKI9mwjh2Is3lm94q
 SIWO4+Db9V8/ny8eJAcUVdKqsfd7EGzi0Okx7PEl8e/5RMHUY8hUxTkd9gXvCH0uGDr4QkKx2d8
 MFp/rSf/T+bJmD8CDMlgqU56I6iagKC/YDPRGQHFXKDROXCYzbQwf43aEIpIVcJlB3/2CC6ohtN
 EsKit6RxYL5h3l97EEqm9Uw5PrdG1KipD7QnryApOg8je7FGyxoPQbUZyKjh2qioUpSeZbyLpBd
 ybp7kCqg45h1pqtR1ZVk83S3cCET8EReKNFGLWJGjaUnazHBYMdSXWQoGvJj8SfR/ew+r4ICoRU
 JtRn6M7Wzw26lHaPIf6puW0LtvRNEURheb5cp1PbP4MgQ9Op39/cYRdjRnRGLD0oTG845Iw+/SY
 ix7UycZExkcZ8abn27epT2iAHr5POIfMIF/cm71iH2/eIdHiOUu3VFqnLCkgqUrzQz+xISxgQw0
 g4VuBNR7tb0zQ/g==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] syscalls: munmap: Convert to new API
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
Cc: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KLS0tCkNo
YW5nZXMgaW4gdjI6Ci0gbXVubWFwMDM6IFVzZSBzdGF0aWMgdmFyaWFibGVzIGZvciBzcGVjaWZp
YyB0ZXN0IGNhc2VzCi0gbXVubWFwMDE6IFVzZSBmb3JrKCkgaW5zdGVhZCBvZiBzaWduYWxzCi0g
T3ZlcmFsbCBjb21tZW50IGNsZWFudXAKLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjUwNzAzLWNvbnZlcnNpb25zLW11bm1hcC12MS0wLTMwZGU4MmQ1OTAwNEBzdXNl
LmNvbQoKLS0tClJpY2FyZG8gQi4gTWFybGnDqHJlICgzKToKICAgICAgc3lzY2FsbHM6IG11bm1h
cDAxOiBDb252ZXJ0IHRvIG5ldyBBUEkKICAgICAgc3lzY2FsbHM6IG11bm1hcDAyOiBNYWtlIGl0
IGEgdmFyaWFudCBvZiBtdW5tYXAwMQogICAgICBzeXNjYWxsczogbXVubWFwMDM6IENvbnZlcnQg
dG8gbmV3IEFQSQoKIHJ1bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgIDEgLQogdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tdW5tYXAvLmdpdGlnbm9yZSB8ICAg
MSAtCiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwMS5jIHwgMjg3ICsr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVu
bWFwL211bm1hcDAyLmMgfCAyNTIgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwMy5jIHwgMTcyICsrKysrLS0tLS0tLS0tLS0t
CiA1IGZpbGVzIGNoYW5nZWQsIDEyNSBpbnNlcnRpb25zKCspLCA1ODggZGVsZXRpb25zKC0pCi0t
LQpiYXNlLWNvbW1pdDogMTZjZDY3ZWYxZjg1ZTZiMTRjMTgyZmE0OTYzMmE1MDE0NTYwZWRmYQpj
aGFuZ2UtaWQ6IDIwMjUwNzAzLWNvbnZlcnNpb25zLW11bm1hcC0zYjZhMjlmYWEyNjgKCkJlc3Qg
cmVnYXJkcywKLS0gClJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+CgoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
