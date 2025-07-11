Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E07C8303C
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 09:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752226163; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=GoKkX4+7sp/11VagAAxSGwyU0aUpjS8tcwb0dgu2uCk=;
 b=E3DSA1uSbKUiaHpZ4CxpTZcdpSO730wO5Rewsmv+4mArK0SydjaSJ9yGXgl3D4Bcyea+/
 d5IVZWQj95rjNht7KUvKu53q4gAo+Rgu8STqLAPdTeuV8XPYJgoT9aSj1wm3wBI127KCFRK
 O1kjzFwP1IfVnb7XWgBt7a7jITjVUNE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 360693CB0A3
	for <ltp@archiver.kernel.org>; Fri, 11 Jul 2025 11:29:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 046573C03F4
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 11:29:02 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2BC5910008F5
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 11:29:02 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a575a988f9so1219935f8f.0
 for <ltp@lists.linux.it>; Fri, 11 Jul 2025 02:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752226141; x=1752830941; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8JPnwnqMSvZm92oIxQE54/bpFeFQWQsqNVBTd61Xbd0=;
 b=H5QskK3Zr1cf9U3isF+JJ+aAbNCkXyedVUvUx77Rpcwhx8IlHc2CkW9GjbvXtXU1mp
 ENJ1P/BOng21i7lrCkBX02tAk6KktaJJmU+mIfCW+WZb8oe2fy4U2UMFx+tMnFh/VwUj
 ZcgmqFhI4TDu8hk48rbWUdZeBOcsF7fBq4cYZ3w/qwehCX/QldP//c510v4i41jxqkDr
 ubEuf5T3+cw4A/q/IY+xUavnpQn5sZ6a8JCJd4Xb+lWdgMZqoTjS70d4oscso8ppEsi2
 KKgcPByWDypL4l2L+9Erxl6HwDvhJwtKljuWtH32ECCASzr4pnwWVhHhAlQcmwZ7FD8O
 /D4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752226141; x=1752830941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8JPnwnqMSvZm92oIxQE54/bpFeFQWQsqNVBTd61Xbd0=;
 b=CJYCeLiVrXlwVLtx8Q5wKnXrI+tml7bKqLLOwKFY0yPSPSMnhYyitxWhBeu66/hBWH
 5LZ4f1zJUONR20jySOqHrY1pTogDFC/5aHuMhYcsB+zjz2hWs+5Gd+2eqMvHYNriXJj6
 MP0/Ai6XBINiVQFfZI2BVzaMkbnd8bcYP8tOnnCG/gIivFh4iR3HcJGQAjLjKWtAldNd
 JGqvHcJWTAyd/TcUM2v1oZtqyzQqN51uuBzOjgR6SWf3Zqlxiw9jN5TSSH4FCAvdxenf
 UTB3ym99IIHh9PmlNOIbZkA0+FANcVWbAGFzg991x2Ge9eviWTKLxLf0tRvKc4WS8pze
 BqFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLGsb28joY5yAzemmA+YXPP0NR6D+VIaJJLjMFKs8NEwsWybSbl6q85N8+27vBZ/zIRu8=@lists.linux.it
X-Gm-Message-State: AOJu0YxNyxzdoB6t+423lV5BZ9PfUlsAwlnfpOcGypblGuxZ95p0PfZR
 oIH4NDKmsGMjb4fD0PFRTvUdze0MxE2XHc6hMwjQp528AVYHt6bnp74waMcB9ko+lrJImW2/W3+
 TpVeRxLbuKg==
X-Gm-Gg: ASbGnctHlTHDlQxEpBoK0enguCuvJ+Xz8UxJl/AMtMF7Eyxr8YaUBozYy4s+Fl7iWaN
 7VIjgl9c1bVaEe5fi5buOfOyzbicDcLT+M/bCCpw9Su6HCb3bh76kCEVw3OM4Sxk+4ULFSCvLCJ
 y1BI665AXAwc1Sj1dSaoXstHanTjW6atV0NPluNDkbWUhnNFdhwOIoP3OjSb1bkk8eYpvWvOLY9
 AOPofY/V3SxTnsBp8ayusJjFHdeM2Rlik+rASRPE0mqIC9WAqeOAd297ILl8wFMeuYOSFRFCxTq
 /pUkixKiihjrugTsMaCt28sStBY72u3cYezAdl5zGLOpB/c+bwAcxq3kS1yQqbiQHfzRzEJKa2L
 LKdVT43vJ6xnngpln9mzjAbkfTRIvKAyGuMHIO+2rrjmY2wmFC+9GuAyyZiOSYjWU8bpkR1Lwzo
 pJo9+PbyEe1+rg2sJQOll4ujHiK6DxxTRae4IcKlc7u7MlkTzAfRp/L7eBKJi//g==
X-Google-Smtp-Source: AGHT+IECUqG45ST+BxLpUkj570F/lPPUVTvkprTs4tcoi+rWQ3ABncuUIpc0x+qfacd4S11M5XK8pA==
X-Received: by 2002:a5d:698d:0:b0:3a4:c909:ce16 with SMTP id
 ffacd0b85a97d-3b5f18d97e9mr1808793f8f.49.1752226141432; 
 Fri, 11 Jul 2025 02:29:01 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f22617sm5125552b3a.102.2025.07.11.02.28.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 02:29:00 -0700 (PDT)
Message-ID: <c712df4f-2438-4376-8c21-c20b623a5bfa@suse.com>
Date: Fri, 11 Jul 2025 11:28:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20250620154346.19864-1-chrubis@suse.cz>
 <20250620154346.19864-3-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20250620154346.19864-3-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] metaparse: Map arrays with designated
 initializers to JSON objects
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

SGkhCgpUaGlzIHBhdGNoIGlzIGFjdHVhbGx5IGNhdXNpbmcgZG9jdW1lbnRhdGlvbiBidWlsZCBm
YWlsdXJlIGR1ZSB0byB0aGUgCndheSB3ZSBhcmUgZGVmaW5pbmcgLmh1Z2VwYWdlcyBhczoKCiDC
oMKgwqAgLmh1Z2VwYWdlcyA9IHtUU1RfTk9fSFVHRVBBR0VTfSwKClRoZSBzaG1nZXQwMiBtZXRh
ZGF0YSAoZm9yIGluc3RhbmNlKSB3aWxsIGhhdmUgYW4gZW1wdHkgaHVnZXBhZ2VzIApkaWN0aW9u
YXJ5OgoKIMKgICJzaG1nZXQwMiI6IHsKIMKgwqAgIm5lZWRzX3RtcGRpciI6ICIxIiwKIMKgwqAg
Im5lZWRzX3Jvb3QiOiAiMSIsCiDCoMKgICJmb3Jrc19jaGlsZCI6ICIxIiwKIMKgwqAgInNhdmVf
cmVzdG9yZSI6IFsKIMKgwqDCoCBbCiDCoMKgwqDCoCAiL3Byb2Mvc3lzL2tlcm5lbC9zaG1tYXgi
LAogwqDCoMKgwqAgIjgxOTIiLAogwqDCoMKgwqAgIlRDT05GX01JU1NJTkd8VEJST0tfUk8iCiDC
oMKgwqAgXQogwqDCoCBdLAogwqDCoCAiZG9jIjogWwogwqDCoMKgICJUZXN0IGZvciBFTk9FTlQs
IEVFWElTVCwgRUlOVkFMLCBFQUNDRVMsIEVQRVJNIGVycm9ycy4iLAogwqDCoMKgICIiLAogwqDC
oMKgICItIEVOT0VOVCAtIE5vIHNlZ21lbnQgZXhpc3RzIGZvciB0aGUgZ2l2ZW4ga2V5IGFuZCBJ
UENfQ1JFQVQgd2FzIApub3Qgc3BlY2lmaWVkLiIsCiDCoMKgwqAgIi0gRUVYSVNUIC0gdGhlIHNl
Z21lbnQgZXhpc3RzIGFuZCBJUENfQ1JFQVQgfCBJUENfRVhDTCBpcyBnaXZlbi4iLAogwqDCoMKg
ICItIEVJTlZBTCAtIEEgbmV3IHNlZ21lbnQgd2FzIHRvIGJlIGNyZWF0ZWQgYW5kIHNpemUgaXMg
bGVzcyB0aGFuIApTSE1NSU4gb3IiLAogwqDCoMKgICLCoCBncmVhdGVyIHRoYW4gU0hNTUFYLiBP
ciBhIHNlZ21lbnQgZm9yIHRoZSBnaXZlbiBrZXkgZXhpc3RzLCBidXQgCnNpemUgaXMiLAogwqDC
oMKgICLCoCBncmFuIGVhdGVyIHRoYW4gdGhlIHNpemUgb2YgdGhhdCBzZWdtZW50LiIsCiDCoMKg
wqAgIi0gRUFDQ0VTIC0gVGhlIHVzZXIgZG9lcyBub3QgaGF2ZSBwZXJtaXNzaW9uIHRvIGFjY2Vz
cyB0aGUgc2hhcmVkIAptZW1vcnkgc2VnbWVudC4iLAogwqDCoMKgICItIEVQRVJNIC0gVGhlIFNI
TV9IVUdFVExCIGZsYWcgd2FzIHNwZWNpZmllZCwgYnV0IHRoZSBjYWxsZXIgd2FzIG5vdCIsCiDC
oMKgwqAgIsKgIHByaXZpbGVnZWQgKGRpZCBub3QgaGF2ZSB0aGUgQ0FQX0lQQ19MT0NLIGNhcGFi
aWxpdHkpIGFuZCBpcyBub3QgCmEgbWVtYmVyIiwKIMKgwqDCoCAiwqAgb2YgdGhlIHN5c2N0bF9o
dWdldGxiX3NobV9ncm91cCBncm91cC4iLAogwqDCoMKgICItIEVOT01FTSAtIFRoZSBTSE1fSFVH
RVRMQiBmbGFnIHdhcyBzcGVjaWZpZWQsIHRoZSBjYWxsZXIgd2FzIApwcml2aWxlZ2VkIGJ1dCIs
CiDCoMKgwqAgIsKgIG5vdCBoYXZlIGVub3VnaCBodWdlcGFnZSBtZW1vcnkgc3BhY2UuIgogwqDC
oCBdLAogwqDCoCAiaHVnZXBhZ2VzIjogewogwqDCoCB9LAogwqDCoCAiZm5hbWUiOiAidGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvc2htZ2V0L3NobWdldDAyLmMiCiDCoCB9CgpXaGljaCB3
aWxsIGNhdXNlIHRoZSBmb2xsb3dpbmcgZXJyb3IgaW4gdGhlIGRvY3VtZW50YXRpb24gYnVpbGQ6
CgpUcmFjZWJhY2sgKG1vc3QgcmVjZW50IGNhbGwgbGFzdCk6CiDCoCBGaWxlIAoiL2hvbWUvYWNl
ci9Qcm9qZWN0cy9sdHAvZG9jLy52ZW52L2xpYi9weXRob24zLjEyL3NpdGUtcGFja2FnZXMvc3Bo
aW54L2V2ZW50cy5weSIsIApsaW5lIDk4LCBpbiBlbWl0CiDCoMKgwqAgcmVzdWx0cy5hcHBlbmQo
bGlzdGVuZXIuaGFuZGxlcihzZWxmLmFwcCwgKmFyZ3MpKQogwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIF5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXl5eXgogwqAgRmls
ZSAiL2hvbWUvYWNlci9Qcm9qZWN0cy9sdHAvZG9jL2NvbmYucHkiLCBsaW5lIDUxOCwgaW4gCmdl
bmVyYXRlX3Rlc3RfY2F0YWxvZwogwqDCoMKgIHRleHQuZXh0ZW5kKF9nZW5lcmF0ZV9zZXR1cF90
YWJsZShjb25mKSkKIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBeXl5eXl5eXl5eXl5e
Xl5eXl5eXl5eXl5eXl4KIMKgIEZpbGUgIi9ob21lL2FjZXIvUHJvamVjdHMvbHRwL2RvYy9jb25m
LnB5IiwgbGluZSA0MDcsIGluIApfZ2VuZXJhdGVfc2V0dXBfdGFibGUKIMKgwqDCoCB2YWx1ZXMu
YXBwZW5kKGYne3ZhbHVlWzBdfSwge3ZhbHVlWzFdfScpCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIH5+fn5+Xl5eCktleUVycm9yOiAwCgotIEFuZHJlYQoKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
