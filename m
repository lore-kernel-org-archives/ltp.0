Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AE1ACD5BD5
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 18:44:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CE243CFFC6
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 20:44:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03DC43C5AD2
 for <ltp@lists.linux.it>; Thu, 28 May 2026 20:43:56 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 701CD600736
 for <ltp@lists.linux.it>; Thu, 28 May 2026 20:43:56 +0200 (CEST)
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-910f734b477so1333806985a.0
 for <ltp@lists.linux.it>; Thu, 28 May 2026 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779993835; x=1780598635; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=US/vWQlrTygzSnAqih6HJ3VT3zBsoAE3XiaPXNuoyxA=;
 b=LykhdbJ1wic6qKMk21yyc9LwQuS609nRWD8kcWuZZQHsxA3Mn8joiuMALCJCSUdCre
 vjf/IuO2Lqp+d2o/r/XcOFI9AqmrvDjO/xGKfxKBxfi2+L+TUUXkZkUe+RnZRvT2LAOc
 yWNsqb1mnyKuWMF3J4WgpM5lnyXjvQb2FdCOh1YO7xf8ndw0DRBgQXyYHsSmOG57GzAa
 L1JTcCmQEQNDiskUrlcz2Kst5dyuacV5fH9kU74jqqlwjJnnyAvDtXo3D/nxflIM9F2d
 JraOguTEoom1CzSt22SK3f0mH7UfjWZok/30gYwmazajymeBcsOBBT/Jh/ZWfD6Z9m4R
 OBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779993835; x=1780598635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=US/vWQlrTygzSnAqih6HJ3VT3zBsoAE3XiaPXNuoyxA=;
 b=GGB+Qhz8V8ZlbTSlqLvY59YbNQU4nZyAur1NdTcR2TB7vIz4SvUFBrqBLd4Yoxk0yU
 dTuJb42/4Qfe/lg5SwAnAHaWPhIXGtORKrkoo1NczRKWeYKbPLc4XISL4FU/4us/bR5V
 2T6lHqFC8RLAIG9G5aK2mBPJ8HtwP2O9iOIrkiJXhYZA7NJISwz2U+b2zG9YGt32nIMG
 9fXFu7u1rnc1tfATddOSsMS6xAn79wGpMiWfr+hbpqO8H4cMKmX9vh5q4Y7o7pw77msj
 TbXyp39bqdAc8v4KXD1slTkPDDOQWDcdIdrp65CTTkTSE63jkSd9xfwDEMcbW30BQTg/
 aZUw==
X-Gm-Message-State: AOJu0YzlWORuORBHuDnw3kxN2p9gbz7/4/fqwsNt00O058qrqusWvkrV
 ogAUCKrLjG8NJHAN2H8giA13pmvIJPNAXr1EA2ONi8YJhAXEnBYotHoK
X-Gm-Gg: Acq92OEqYf3Re5udI+uGTYuQt1Q26oV8Mr9uqlPZeQeqtsyu9yNPhDKfu17eAH0tAXp
 2+YUOJJqUClnjtFO3F/aGOIo1vJDU1HZyrtFNScs3d5efaNTbCh+s47yqJLa6YjZwni8vWGO8CU
 eKHUYpQKWDK5znKZeG3Z0ZhoUHkUewMdWXNBGQYihThU/pEea2L8kbaNKqHblwot10133VoHFvQ
 jEecpPZE3ZTa42KnlUAV0Sr0CiZg+ESrEcZ0l9Tu6ZPfz9FE4Z7JUsr6lFbdt4q8Hi+1KXh+SPe
 ZLEPWvUXq5hRVj3GGV5llZRz0dxl+qz9DgI4hdwMloTfAClk7Rj0utAK14YNvlPinTBUA5ySA/4
 Kn8Rv6MgQ5m3pZgjzpsNeKblRrcn/eJgZ22xDEnVtczAcCdtKtHwFKdNoCs8HKE5Feso0TMhNZ8
 nbyWePRucjA0vWLGkrahAycZYVVdPlPYbGnxB3v6RFcz5qVW2lCkrIRRwF3CbUU4ujwUFO4GI0S
 YX6KsX0Q1sJAMc3ROLMI2IWz9UkCWj3pukcclEDTcRosVauSvh7XD3CDLtbjw==
X-Received: by 2002:a05:620a:262a:b0:914:ca75:e8c7 with SMTP id
 af79cd13be357-9152d08cb6amr28453585a.56.1779993835205; 
 Thu, 28 May 2026 11:43:55 -0700 (PDT)
Received: from
 runnervm3jyl0.1c5fwzodld1edfr115mfuvh5ec.ex.internal.cloudapp.net
 ([64.236.200.105]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f87cda12sm896581385a.31.2026.05.28.11.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 11:43:54 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 28 May 2026 18:43:53 +0000
Message-ID: <20260528184353.3954-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528162920.914321-1-amir73il@gmail.com>
References: <20260528162920.914321-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify21: fix test failure when running iterations
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

SGkgQW1pciwKCk9uIFRodSwgMjggTWF5IDIwMjYgMTg6Mjk6MTkgKzAyMDAsIEFtaXIgR29sZHN0
ZWluIHdyb3RlOgo+IGZhbm90aWZ5MjE6IGZpeCB0ZXN0IGZhaWx1cmUgd2hlbiBydW5uaW5nIGl0
ZXJhdGlvbnMKCkFsbCBnb29kLiBSZXZpZXdlZC4KCk9uIFRodSwgMjggTWF5IDIwMjYgMTg6Mjk6
MjAgKzAyMDAsIEFtaXIgR29sZHN0ZWluIHdyb3RlOgo+IGZhbm90aWZ5MTM6IGZpeCB0ZXN0IGZh
aWx1cmUgd2hlbiBydW5uaW5nIGl0ZXJhdGlvbnMKCj4gK2lmICh0c3RfdmFyaWFudCAmJiAodGMt
Pm1hc2sgJiBGQU5fREVMRVRFX1NFTEYpICYmCj4gKyAgICAoIW92bF9iaW5kX21vdW50ZWQgfHwg
cmVuYW1lX2V4Y2hhbmdlX3Vuc3VwcG9ydGVkKSkgewo+ICsvKiBUaGUgZXZpY3Rpb24gb2YgYmFz
ZSBmcyBpbm9kZXMgaXMgZGVmZXJlZCBkdWUgdG8gb3ZlcmxheSBoZWxkIHJlZmVyZW5jZSAqLwoK
VHlwbzogImRlZmVyZWQiIOKGkiAiZGVmZXJyZWQiLiAoTW92ZWQgZnJvbSBvbGQgbG9jYXRpb24u
KQoKWy4uLl0KCj4gKyNkZWZpbmUgVFNUX1ZBUklBTlRfT1ZMX0xPV0VSICh0c3RfdmFyaWFudCAm
IDEpCj4gKyNkZWZpbmUgVFNUX1ZBUklBTlRfT1ZMX1dBVENIICh0c3RfdmFyaWFudCA+IDIpCgpU
aGVzZSBtYWNyb3MgYXJlIGRlZmluZWQgYWZ0ZXIgZG9fdGVzdCgpIGJ1dCBkb190ZXN0KCkgZG9l
cyBub3QgdXNlIHRoZW0g4oCUCm9ubHkgZG9fc2V0dXAoKSBkb2VzLiBQbGFjZW1lbnQgaXMgZmlu
ZS4KClsuLi5dCgpBbGwgZ29vZCBvdGhlcndpc2UuIFJldmlld2VkLgoKUHJlLWV4aXN0aW5nIGlz
c3VlcyBub3RpY2VkIGluIHRoZSBzdXJyb3VuZGluZyBjb2RlIChub3QgaW50cm9kdWNlZApieSB0
aGlzIHBhdGNoKToKCi0gZmFub3RpZnkyMS5jIOKAlCBmYW5vdGlmeV9mZCBpcyBhIGdsb2JhbCBz
dGF0aWMgaW5pdGlhbGlzZWQgdG8gMDsgaWYKICBkb19zZXR1cCgpIGV4aXRzIGVhcmx5IGZvciB0
c3RfdmFyaWFudD0wIGJlZm9yZSBTQUZFX0ZBTk9USUZZX0lOSVQoKSwKICBkb19jbGVhbnVwKCkg
d291bGQgY2FsbCBTQUZFX0NMT1NFKDApLCBjbG9zaW5nIHN0ZGluLiBTYW1lIHBhdHRlcm4KICBl
eGlzdHMgaW4gdGhlIHByZS1wYXRjaCBjb2RlLgoKLS0tCk5vdGU6CgpUaGUgYWdlbnQgY2FuIHNv
bWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGlu
Z3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFz
ZQpjb21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMs
CkxUUCBBSSBSZXZpZXdlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
