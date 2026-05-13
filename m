Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AEDFCD37B6
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 10:37:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 215563E1C39
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 12:37:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DC283E1C39
 for <ltp@lists.linux.it>; Wed, 13 May 2026 12:37:13 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0005C1400108
 for <ltp@lists.linux.it>; Wed, 13 May 2026 12:37:12 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8dbbc6c16b2so849748485a.0
 for <ltp@lists.linux.it>; Wed, 13 May 2026 03:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778668632; x=1779273432; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pswA82bZFekEdgLKZ+HC4Ig/41xOWsnEvZ8TxG+D2r8=;
 b=cIGt2Xi7QDAo0fd5p7j5sJdD+FK2FqQyuUQhbV66ONojSFamj6Chk0wq1kNHIAAXky
 VpNei5MtBAB8dO3KCoPdIG6DHZKO4vDvvp1LXkAQEzx/VuqFiehbecSAwft3GPZ4jRPR
 ZUJrYgSu9+o8fLiXjbIU0GykPsjSYK4DdQJa0LbkZxMQLPeYWvdKNWsVEG+bv0kbE84q
 aEYwAiPC26OsEPP8UQVmlg0PuqWse8ImwMgwzunZ5wr5huVRMtFPA5Uzmcu6UCMQ9LQX
 0i/5dVPXs5IItp1VlMsrQ+gdfi+ochWTe6x8yjYK7MbhApNI85KpVJ0tMlDYeXEYZCv8
 Uwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778668632; x=1779273432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pswA82bZFekEdgLKZ+HC4Ig/41xOWsnEvZ8TxG+D2r8=;
 b=l9Ri+/hp5f/+K7I+56LW96E5MAFyZjpCViLgsXrgeDl0aI3IiEhXJEg33+2MKDRUbA
 W0R6IniyzPJoDS+JXsuhs2RDeRi8umZ0cArQVhQetE+8myZ9uL9vMW0s7IXpQHgRXrh9
 NfCuYsP2MvuSVPpkz9q2vOJX9r3lAfBuDqj5n04F0G3qB19CRBKby/RcCskGQ/nBmqs+
 A9aZ13rTdw88Xvlnp+VYIGUx/vP+xoVCw3w1OTxJNY/yGIx64s6/xOTvekS4i8OWc1Ak
 oGPBtSoIevtoBYHrm+Zdzt7jksq32L9BAlWzLxYYhc5k/iPQPUCxuAgTkEEAM15yZIHE
 5Epw==
X-Gm-Message-State: AOJu0Yx/TfTfSZ0pfDlG3oQ/DLyLYOi5RYpQn4ySKnFADbuq9Z7WoWw/
 /FG/L3GgX1rY/Wv7DeT9xISUQ19IcQlFi1Yfm0Ljoa1v+Rv9PeqWA9IJ
X-Gm-Gg: Acq92OFpYViH2seuVx71ZWIlVFEC8M1b9j1qbUmMPxC470+inIAx0mReoa9Kf8ZX7dp
 EzIcz/6oiH4ncFPyemMAsaNf4l/qyxZupOGvrX6NJc3srxRDlYVOotUfMfPJNDu7mGBaNX3rop9
 FUXFeL4eNFxTgB0GXVEAWUFK+TbVH+EEM76d6gBU/6AgK3Bdwj1u5k2mVw/fmj5l6jtJKFS/pzc
 Omcsb0Fw5xc31hGumm6h53JxkZPT2BoUw1daMtGW3m2zSBlhTPdMG+T8+Ebc02vL+tT+HUY5GfA
 1+ZP8L0SYT6yh2ZV/BnGFjcEY91ptMZplfVpKXHZ2LV6wpKJGxNIBhUEpqYJ9ZQKkcHOPDyv1LM
 8x/A4RWU8FZdT1gyty5WgAcjA2YyCeZc/LzAOpNpCJ/dP/qUsgw6qHuL7VST3Dim5NZaZXmf5yh
 o3TImSV4R7yyOyTH8b8eb3N36Ziofg5Xq/XT9H1CFSxUqDqZAzQ+eGcN0DaCUFO88YT2ZUOl+fV
 1R4B0ysGxDZsl4r7qrKryl+Li7tvuoZTXxLEQ==
X-Received: by 2002:a05:620a:3b86:b0:90f:c208:9c99 with SMTP id
 af79cd13be357-90fc208a186mr170986885a.21.1778668631699; 
 Wed, 13 May 2026 03:37:11 -0700 (PDT)
Received: from
 runnervmeorf1.djo20zqc0iyezjaecdggufo4df.bx.internal.cloudapp.net
 ([20.83.158.39]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-90fb9d90918sm161898285a.26.2026.05.13.03.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:37:10 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 13 May 2026 10:37:09 +0000
Message-ID: <20260513103709.3924-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513085124.12324-1-wegao@suse.com>
References: <20260513085124.12324-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] nm01: Fix BSD vs POSIX format comparison failure on Power
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgV2VpLAoKT24gMjAyNi0wNS0xMywgV2VpIEdhbyB3cm90ZToKPiBubTAxOiBGaXggQlNEIHZz
IFBPU0lYIGZvcm1hdCBjb21wYXJpc29uIGZhaWx1cmUgb24gUG93ZXIKCj4gLSAgICAgICBST0Qg
YXdrICd7cHJpbnQgZ2Vuc3ViKC9ceSgwKykoWzAtOWEtZkEtRl0rKVx5LywgIlxcMiIsICJnIil9
JyBubV9ic2Qub3V0IFw+IHRyaW1tZWRfbm1fYnNkLm91dAo+ICsgICAgICAgUk9EIGF3ayAnewo+
ICsgICAgICAgICAgICAgICBpZiAoTkYgPT0gMikgeyB2YWwgPSAiMCI7IHR5cGUgPSAkMTsgbmFt
ZSA9ICQyOyB9Cj4gKyAgICAgICAgICAgICAgIGVsc2UgeyB2YWwgPSAkMTsgdHlwZSA9ICQyOyBu
YW1lID0gJDM7IH0KPiArICAgICAgICAgICAgICAgc3ViKC9eMCsvLCAiIiwgdmFsKTsgaWYgKHZh
bCA9PSAiIikgdmFsID0gIjAiOwo+ICsgICAgICAgICAgICAgICBzdWIoL14wKy8sICIiLCBuYW1l
KTsKPiArICAgICAgICAgICAgICAgcHJpbnQgbmFtZSB0eXBlIHZhbAo+ICsgICAgICAgfScgbm1f
YnNkLm91dCBcPiBubTEub3V0CgpHb29kIGZpeC4gUmVwbGFjaW5nIGdlbnN1YigpIChnYXdrIGV4
dGVuc2lvbikgd2l0aCBzdWIoKSBpcyB0aGUgcmlnaHQKYXBwcm9hY2ggaGVyZSBhbmQgY29ycmVj
dGx5IGhhbmRsZXMgdGhlIGhleC1wcmVmaXggc3ltYm9sIG5hbWVzIG9uIFBvd2VyLgoKUmV2aWV3
ZWQtYnk6IExUUCBBSSBSZXZpZXdlciA8bHRwLWFpQG5vcmVwbHkuZ2l0aHViLmNvbT4KClByZS1l
eGlzdGluZyBpc3N1ZXMgbm90aWNlZCBpbiB0aGUgc3Vycm91bmRpbmcgY29kZSAobm90IGludHJv
ZHVjZWQKYnkgdGhpcyBwYXRjaCk6CgotIHRlc3RjYXNlcy9jb21tYW5kcy9ubS9ubTAxLnNoIOKA
lCBVc2VzIGludGVybWVkaWF0ZSBBUEkgKC4gdHN0X3Rlc3Quc2ggLwogIHRzdF9ydW4pIHJhdGhl
ciB0aGFuIHRoZSBjdXJyZW50IHN0eWxlIHdpdGggdHN0X2xvYWRlci5zaCBhbmQgZG9jL2Vudgog
IGJsb2Nrcy4gTm90IGEgYmxvY2tlciBmb3IgdGhpcyBmaXguCgotLS0KTm90ZToKCk91ciBhZ2Vu
dCBjb21wbGV0ZWQgdGhlIHJldmlldyBvZiB0aGUgcGF0Y2guCgpUaGUgYWdlbnQgY2FuIHNvbWV0
aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMKZmluZGluZ3Mg
YXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcsIHBsZWFzZQpj
b21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJlZ2FyZHMsCkxU
UCBBSSBSZXZpZXdlcgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
