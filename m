Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2808CAC5AC
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 08:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758874427; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=TuxPDiizBKYs7eLjq0BGqAbe8a+WhZVkEHQ3/22ZnTU=;
 b=qiW+Jo0Zv6ahHYVT4EO97wVmXmxjGuFEMq/Ol+ABXLiY9TLKKzJOP8TA8SifSuEy5BQnV
 B5TCQNKZNo8Ni4Edo7ypdGVbSMaURuT3/kYVQ3N0+ITgR6bFPdD2qNy312a/D5V+dfvwkQY
 ETNWO99VE1R8wC0nt0Dwolb/MO09H4s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A00E3CDDE3
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 10:13:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 655343CD9FC
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:13:26 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C79F260065F
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:13:25 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b00a9989633so323912866b.0
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758874405; x=1759479205; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xUCh58BKD5VPRd7NeAbC4Tm82Ck6au1Dtn/xRnh34Z0=;
 b=OOvwJZzYp6c6JERTAAMClU2fRVAHpvYIJ10jRPbVcdQHpjdXU0javXhv0Cjty7CD3Y
 xV0L+Xjl/+VrAoy3H5kAV330Y2hc9BuejsG6Db1c+1yupBmDs3tePFvQH/tqA0+rK1tG
 /Nvk6MatDCyU/Vh2+yMsYytrnyuDNuRtwjTvfvotLtFgUj9yz9BlNI7f43hjGYk6pw0/
 PK9n1EtGY2ClZXQnujnKm06qRUy2y+bZUbC3Kg2zAZdUJUIsoXeI62jaFy8F2Mgm31By
 LCHlX99GgFqE7dz/8W/Ih8Yj0VUOehIgb27x/SfqNhRztMCP0do7IKnSBgpH1LJBy0EK
 5ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758874405; x=1759479205;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xUCh58BKD5VPRd7NeAbC4Tm82Ck6au1Dtn/xRnh34Z0=;
 b=RmP4bCRw7bONnzmbzYLG9sE77O6beC4EDzvxn9R92uPkVlxf3iQ7P88c46n+euKRzz
 68Cp5g+F/qNDYE7Ln4H4FeteIOIkBT7m5Qq+XyNmndYl1lAL39P1LEVDVKwhArehf7qC
 Qeo1Ct45BO8opj2RkeiUD1gqVbP4sevlQJfw2ULlT+/MCoAPvctfLDU81nHOiWiYkjKU
 CiZW2dJVqAo2CWxqSXO4lP0qJnDMH26Zmn0Zmq7b9L7gbE8tA29ajVVGun6bmB5s09/p
 AN8K9CANMCje1WadMB0DSDXUCXoQSOEIQBmsJVSh/krEOTCW05pK5JZDtVQfGWJ3mPeV
 +lfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWYv9ZKxjUiaepH5jMxzOYsV5JOqwFZzdEI5fBOW/KEM0N8rE1leQ6DG/fqvMP2AXYVwk=@lists.linux.it
X-Gm-Message-State: AOJu0Yy1I14y+B9PK1Ov25EmTlZ0j7pdMjmqGdvyp5chmp+KX3y+jQGF
 fXrBrDcw7IJsA+5RYBlOKlCtLQcRKIN2N0xqg8vHAr7tQfC97+3kdfCUmY2YKGvpcRk=
X-Gm-Gg: ASbGncsfk2b8TvXI6LAjhmxCWDstqhGoXgBeUc6dQm+G7ofUQcF/Wejbpo2+6l5X0/T
 X6teAF0zT90waTmYc4nLM5NcQJ6/90sR1hnFsDbPVwq0eb0vVq5L3HtTRZiyItiHqnWY0y/CbSG
 T/nq+SuLfYNdtqls449FmWdJFrpJznbTrVcEE/KbSzXKLb9h8E3dAj1l3wq7/uAAPw2p79OLBvB
 k16mxsAC8tdGglOE6gSf5QMPMV1CWL+MCNyvuiywGQgEdbBoUNIuSQb7MKliaENAmkAOcPqFcuP
 lpN0A4Dd+8/fHTevxW0wEx/yDp64TFTY8mhUKEcySTrqHnvf05RcAHtNYv4tK7Hd3pD6n5wdEEf
 BHIjA7IF/nfcMzzGq2086UhHXB+vXxcYtbORDOgupWfPyr990+Y3hAi6ucJv6zaUlvvpS3z2i8G
 5sqENWJY9fwTrDmFJbkkNC/A4PxSfRnv4fHmb5JUmLpKAzx0v7ht3tfbSAArknyPbsjcy/K8B6X
 DzfMYhlaw==
X-Google-Smtp-Source: AGHT+IFXcBWDVgel7wUcDIwBVpSCL/VoPKJjDPJbaNgtcouH24z+vLdBtOSvzV+L4GCTiAyKDZHQwA==
X-Received: by 2002:a17:907:db15:b0:b04:7eba:1b55 with SMTP id
 a640c23a62f3a-b354bc59795mr607905566b.19.1758874405155; 
 Fri, 26 Sep 2025 01:13:25 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f17:6d00:961b:d261:4569:b9c8?
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3544fcdd89sm326836366b.79.2025.09.26.01.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 01:13:24 -0700 (PDT)
Message-ID: <9da94554-faae-4864-8908-c1484ee55ac4@suse.com>
Date: Fri, 26 Sep 2025 10:13:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>
References: <20250926040707.671282-1-jmorgan@naotchy.com>
 <d39802b7-6ab3-4c78-a660-34d7bc0a3dd3@suse.com> <aNZI_qWdLSLAz5pH@yuki.lan>
Content-Language: en-US
In-Reply-To: <aNZI_qWdLSLAz5pH@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] statmount.h: add check for STATMOUNT_MNT_NS_ID
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gOS8yNi8yNSAxMDowNCBBTSwgQ3lyaWwgSHJ1YmlzIHdyb3RlOgo+IFRoaXMgaGFzIHRvIGJl
IHVuZm9ydHVuYXRlbHkgdGhlcmUgYmVjYXVzZSB0aGUgZmllbGQgaXMgcHJlc2VudCBpZiB3ZQo+
IGFyZSB1c2luZyBsYXBpIGZhbGxiYWNrIG9yIGlmIHdlIGhhdmUgbmV3IGVub3VnaCBzeXN0ZW0g
aGVhZGVycy4gU28KPiBlaXRoZXIgd2Ugb3BlbiBjb2RlIHRoZSBpZmRlZnMgaW4gdGhlIHRlc3Qs
IG9yIGRlZmluZSB0aGUgbWFjcm8gbGlrZQo+IHRoaXMuCgpXaHkgbm90IGp1c3QgdXNpbmfCoCAi
I2lmIWRlZmluZWQoSEFWRV9TVFJVQ1RfU1RBVE1PVU5UKSB8fCAKZGVmaW5lZChIQVZFX1NUUlVD
VF9TVEFUTU9VTlRfTU5UX05TX0lEKSIgaW5zaWRlIHRoZSBzdGF0bW91bnQwOSB0ZXN0IAp0aGVu
PyBUaGVzZSBMVFBfSEFWRV8qIHdyYXBwZXJzIGFyZSBhIGJpdCB3ZWlyZCBiZWNhdXNlIHRoZXkg
YXJlIG1peGluZyAKd2l0aCBpbnRlcm5hbCBMVFAgbWFjcm9zLCBhbHNvIGNvbnNpZGVyaW5nIHRo
ZSBmYWN0IHdlIGFyZSBub3QgdGVzdGluZyAKInN0cnVjdCBzdGF0bW91bnQubW50X25zX2lkIiBh
bnl3aGVyZSBlbHNlIGJ1dCBpbiBzdGF0bW91bnQwOS4KCi0tIApBbmRyZWEgQ2VydmVzYXRvCmFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
