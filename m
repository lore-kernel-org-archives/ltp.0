Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7DE0FF886F
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 06:35:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7763D3E2681
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 08:35:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 660433E250B
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 08:35:01 +0200 (CEST)
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com
 [IPv6:2607:f8b0:4864:20::844])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1A9AB6001EE
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 08:35:01 +0200 (CEST)
Received: by mail-qt1-x844.google.com with SMTP id
 d75a77b69052e-50fb8e9a4edso6347581cf.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 23:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777530900; x=1778135700; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7F0yJvdTcAJ3hfbniqHxMBtPz7ueXINQtrdWTAV3DqA=;
 b=V7Y2wQcN09H7l5DuS1RkyCH2GljmYT9BNThJpS245VnETxN6Ho26eAe4yBOfDtWtAx
 C5xL1mH0qWDNT3ijXOSBgJj3F9WUQcBKW4F564t4d2o8MjVM7VBdYOjNtIyS7aDGu/FI
 gZWgdcI1gwlZdNY6LsEO5PNy4Fnmt0W01NXA3nSbzt8A64d6jra5mgWCkVp0IblN+kUD
 Jn/4ZOubAOJXj+2kiQlSXljUqsdWHqFZD/rg3bGiqVHx7W1XOYBnzE5Q5QQ/CmUSgjSR
 iN9TMexzpNbrQ51kQQBDA9Chywou+5frLs2x+rOPFApjygiHEXiXai7GS3JvQfGscz3c
 LBnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777530900; x=1778135700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7F0yJvdTcAJ3hfbniqHxMBtPz7ueXINQtrdWTAV3DqA=;
 b=PEsnCsm9MlGFE70QWrmpRaNhvVhNQyMzSusdv2bt10tCJzC1e+TjS/zJM6+DTXUkT3
 MYpYmD5Jk9VU4spLG3YEwERt5wwsVgfpfW19M9P9kXZJ5DG/jJ0KnnjP6e22DTcjoFnR
 tBcehi3S5FTI05PtoEzcI4Z0cXRzW2Ry1cmqbZpQYOWUXIaQcpvfIweXkbeUr5qOMYoE
 AUhFeeazOdMQxJ9NoUIv1+j+v/15u+2u/rH4ME2l5UzaOS6wq2CFQu5R41od2pdC56zN
 AVWnMT+gNMyLleOdJGbgt0DSsGpj2H6yx/eMOOba/fq/b26BNyKizga8TmgrFZLS0eqY
 lZgA==
X-Gm-Message-State: AOJu0YyISMSp2v34mHkJMmUZ15BVvlbCzNC188el5YfQm6tnFdnie7hh
 NeojbxgKHzOOyd6YtvGkgpoMYHYTMA7dpAPT//RkOjoUL2+udlNOrPf+
X-Gm-Gg: AeBDieurioKIzE0Rnh98LgvpcYAj/eGY76lr/YPREyT5BbJbz4iRlRFwZ9oKhul7Jgg
 OJU5+sZrxDv1nxdKZCJz7A1YtuS1rdP50vS6BKRdgyKcjg7ySbZg/xkDssX+X8xD8igt0lVO44J
 7yqSLI/epfp7PUg/TBk/b7RjNx92asFKf0HapHePsgjvSHlhBMG8XlulkZdWNDr03VqXXVUMl+f
 ewx4ADEDKgSM17sfUA0fsozrAEPbdmT5f5mxmjgTCVWGOEwRD6Usv0snZ25p3BaZgzC5bpNuPE3
 jYe+9TYTGNPBak3SaXV99k8zF5Wdp3sVcaoEDdnjTpqu9oac8UxcIHFcfLdi25XWPJoFM4rEVSk
 ZzPoExoxsXKJ1i4TbKwTIaublvkISJ1B04wrkaRG7T9ZfX0AB+UXbMXv9t7fDprGXe857rwnwdf
 ptdJmOTJgh67vSRmvMdgl8iSt8cksd4zmkD6UdM/n5OGaCyQQKwUMBIqybfg3YKF96Zp28Oux03
 nA8E9cHZ18NARpqaSMG3HUrk4kUifxRnhZzwn51RoosE9P8SgM=
X-Received: by 2002:a05:622a:1456:b0:50e:42ec:ca76 with SMTP id
 d75a77b69052e-5102ad9af34mr21229011cf.38.1777530899862; 
 Wed, 29 Apr 2026 23:34:59 -0700 (PDT)
Received: from
 runnervmeorf1.azymcduxfoqubelgmubqnbqpmd.ex.internal.cloudapp.net
 ([135.232.232.89]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5101ae657d7sm36359881cf.21.2026.04.29.23.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 23:34:59 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu, 30 Apr 2026 06:34:58 +0000
Message-ID: <20260430063458.3933-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430051915.2178-1-wegao@suse.com>
References: <20260430051915.2178-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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

SGkgV2VpLAoKT24gVGh1LCAzMCBBcHIgMjAyNiAwNToxOTowNyArMDAwMCwgV2VpIEdhbyB3cm90
ZToKPiBmc2NvbmZpZzA0OiBDaGVjayBGU0NPTkZJR19TRVRfUEFUSAoKPiArCUZpeGVzOiBodHRw
czovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9pc3N1ZXMvMTE2OQoKYEZpeGVz
OmAgbXVzdCByZWZlcmVuY2UgYSBnaXQgY29tbWl0IFNIQS4gVXNlIGBDbG9zZXM6YCBmb3IgR2l0
SHViIGlzc3VlIFVSTHMuCgo+ICsJVEVTVChmc2NvbmZpZyhmZCwgRlNDT05GSUdfQ01EX0NSRUFU
RSwgTlVMTCwgTlVMTCwgMCkpOwo+ICsJaWYgKFRTVF9SRVQgPT0gLTEpCj4gKwkJdHN0X2JyayhU
RkFJTCB8IFRURVJSTk8sICJmc2NvbmZpZyhGU0NPTkZJR19DTURfQ1JFQVRFKSBmYWlsZWQiKTsK
ClsuLi5dCgo+ICsJc25wcmludGYocGF0aCwgc2l6ZW9mKHBhdGgpLCAidHVuZTJmcyAtbCAlcyAy
PiYxIiwgZGV2MCk7Cj4gKwl0dW5lMmZzID0gU0FGRV9QT1BFTihwYXRoLCAiciIpOwo+ICsKPiAr
CXdoaWxlIChmZ2V0cyhsaW5lLCBQQVRIX01BWCwgdHVuZTJmcykpIHsKPiArCQlpZiAoKmxpbmUg
JiYgc3Ryc3RyKGxpbmUsICJKb3VybmFsIGRldmljZToiKSAmJiBzdHJzdHIobGluZSwgZGV2aWNl
X3N0cikpIHsKCmBGU0NPTkZJR19DTURfQ1JFQVRFYCBpbnN0YW50aWF0ZXMgdGhlIGZpbGVzeXN0
ZW0gY29udGV4dCBpbiBrZXJuZWwgbWVtb3J5IGJ1dApkb2VzIG5vdCB1cGRhdGUgdGhlIG9uLWRp
c2sgc3VwZXJibG9jay4gYHR1bmUyZnMgLWwgZGV2MGAgd2lsbCBzdGlsbCBzaG93IGRldjEKYXMg
dGhlIGpvdXJuYWwgZGV2aWNlIChmcm9tIHRoZSBsYXN0IG1rZnMpLCBub3QgZGV2MiDigJQgc28g
YGZvdW5kYCB3aWxsIGFsd2F5cwpiZSAwIGFuZCB0aGUgdGVzdCBhbHdheXMgcmVwb3J0cyBURkFJ
TC4gRWl0aGVyIGNvbXBsZXRlIHRoZSBtb3VudCB3aXRoCmZzbW91bnQoKS9tb3ZlX21vdW50KCkg
YW5kIHZlcmlmeSB0aGUgYWN0aXZlIGpvdXJuYWwgdmlhIHJ1bnRpbWUgc3RhdGUsIG9yCmNvbmZp
cm0gd2hldGhlciBleHQ0J3MgRlNDT05GSUdfQ01EX0NSRUFURSB3aXRoIGpvdXJuYWxfcGF0aCBh
Y3R1YWxseSBwZXJzaXN0cwp0aGUgYmluZGluZyB0byB0aGUgc3VwZXJibG9jayAoYW5kIGRvY3Vt
ZW50IGl0IGlmIHNvKS4KCi0tLQpOb3RlOgoKT3VyIGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3
IG9mIHRoZSBwYXRjaC4gVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZQpmYWxzZSBwb3Np
dGl2ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzIGZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmlu
ZCBpc3N1ZXMgd2l0aAp0aGUgcmV2aWV3LCBwbGVhc2UgY29tbWVudCB0aGlzIGVtYWlsIG9yIGln
bm9yZSB0aGUgc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
