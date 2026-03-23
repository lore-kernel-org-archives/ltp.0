Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B21DFC72C5
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 07:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774250463; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=2zGdmric+F8Br9C/waPpNNR0z0ZRlV2/pYWGWvTjMMo=;
 b=qGETutrECJd6IyUDqeCIYiuWBS4Rt3hJJTvRxTkaSRBLwf36CEFq4aBfpRHXrYwvUc9B7
 Lov9rB8KAHVCkA4C+FV4c7u9iXH1nELWBqszlxpdK3I7EDrZXxJiA/VLNFPiBUEtWLRfCGX
 qs11oQ5YrbUie+hRcnC/Sy51lX/nk0M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3FB03E1D75
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 08:21:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 771473C00AF
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 08:20:40 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7B7061A006ED
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 08:20:39 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-486b9675d36so30389105e9.0
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 00:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774250439; x=1774855239; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FuD9/NGMKQpwNsr7EBfIvtFOTJc7JOeumU3V8Nc+Bcs=;
 b=N34KRlhjmU2yGm2xQRSUb0I8EgI3w0GILggN8wDwzT+KypcgfUSOkSQQovpzCcduSi
 mfTEYvGPfGIDu0X2SHc29UQKa55HVHIogTSmpqGA1dU5NZxNRjsLdomZ0w2zjofc4C+J
 CNbJHuSdKNQO+sQBNsjAxMqFhsDBn3bxmYqQ5IZC/is53ZQLDZ8/64AGiOqxaF/vb9Ni
 IR9Dtgvml14ws9RQ7nGoNtYouBKOx3Sq+xI1u93BWTWn8wwSsaRaKEMo0IINC07wgWId
 medjsCoCuvEkvILjfmDQMN1l4QrqJ3WA19SebsZSKJVulIZRLa6S1gfqpzhHyYJfM0MV
 ZVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774250439; x=1774855239;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FuD9/NGMKQpwNsr7EBfIvtFOTJc7JOeumU3V8Nc+Bcs=;
 b=bz0wypsQL5J3CHfHje9RCqT5hYsCZR9dkqn1TepN2i4qAaRqNlFOZbh8jfC/Z6VTvb
 NjaIJB0Ulo8JRkgjSdvAVFmSHamC5RvicmwhLF1AaFAJQpkURIvHqDi3Ur9JSNEHeiCu
 4Q5S7DphE8pHy4iBuSvFsvRfDPxZBNy+R7b833Cm0PEQ+ofoAyYml7Kf55uIPSEdpUmd
 PbT6r0S1yPgBwVzCXZQL5J5XBTqvP/3YNMfxNhZKo9Tyqx8IMw4kii9zu5dpyYUop6C/
 fJi2wJkzOrUfjiCkid8vZF4Jl0XY2Lnx7o8QmBFH/xmPdO1X2xy6808Ns+TCuZWemEWQ
 QlmA==
X-Gm-Message-State: AOJu0Yyucw77twVUayYjiXisRD2MFFJkvzE0koYj8ZfKCIumBzElZkwx
 0jmNFb298kFFSIXUK7wJz5QOgs6J6c/RQquapVL1h0goYPv4xzdcqNXK+NDLg9v+kUTUe9SO0UL
 HpW/JBxM=
X-Gm-Gg: ATEYQzxN1R1V9gf72hx5tTghX7PycfqDUKOx2Ahs7Bg3UnADQQn7alsZb685wt1Fipp
 mSf3hN3pXXexsBozvPBQxQgV1Ew5/Z7N1VYx4xzW6cG4YlR3fs1G0AtywBCLRSCO++UfZyorY5J
 NijBL1YMe7rUCi0/D8BLj2TpOeM1gTGnXA2UZcve9v6n+JT+rLS+/RI9XuivwuJ8NE+3Aa2vLaM
 0vPVHbk4YekxMWcpzvS4sKzFprCpYlrt+fhEY6svXbe/ZT/BqMhINAZGLoOjz1vUqmNr/EqH9i/
 SarK4+cIePGXdA+oyOvycM0aH000tmOhnyqqEO1aY8l66CDPEUBslPjZat3KyJjpY/0Jje5SJmU
 tGcc++r3qJuRTZzPoP1XhzuGDbzilNCX4eUogNKTbKMHMlmgEfE5riy0qL9z641sjNaxIU2cTGo
 G6dJey/a1vnoEmZImQH+zdCxLqJ5VDgonL2pkxUVSBdQ==
X-Received: by 2002:a05:600c:c083:b0:485:2fc5:3a5 with SMTP id
 5b1f17b1804b1-486fee19f85mr114950075e9.26.1774250438605; 
 Mon, 23 Mar 2026 00:20:38 -0700 (PDT)
Received: from localhost.localdomain ([37.160.205.41])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470b1f7sm26970695f8f.25.2026.03.23.00.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 00:20:38 -0700 (PDT)
Message-ID: <69c0e9c6.5d0a0220.39fce8.8893@mx.google.com>
To: Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <20260311070235.206921-1-pavrampu@linux.ibm.com>
Date: Mon, 23 Mar 2026 07:20:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [PATCH V6] syscalls: ipc: Add shmget hugepage test
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
Cc: pavrampu@linux.ibm.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGF2aXRocmEsCgpBIGZldyBpc3N1ZXMgdG8gYWRkcmVzcyBiZWZvcmUgdGhpcyBjYW4gYmUg
bWVyZ2VkLgoKPiBDaGFuZ2VzIGluIHY2Ogo+IC0gQWRkZWQgInRzdF90ZXN0LmgiIGFuZCAidHN0
X2h1Z2VwYWdlLmgiIGluc3RlYWQgb2YgaHVnZXRsYi5oCj4gLSBNb2RpZmllZCBjb2RlIHRvIHVz
ZSBURVNUKCkgbWFjcm8KClRoZSBjb21taXQgYm9keSBzaG91bGQgZXhwbGFpbiAqd2h5KiB0aGUg
dGVzdCBpcyBiZWluZyBhZGRlZCDigJQgd2hhdApiZWhhdmlvciBpdCB2YWxpZGF0ZXMgb3Igd2hh
dCBnYXAgaXQgZmlsbHMuIENoYW5nZWxvZyBlbnRyaWVzIGJlbG9uZwpiZWxvdyB0aGUgLS0tIHNl
cGFyYXRvciBpbiB0aGUgcGF0Y2ggZW1haWwsIG5vdCBpbiB0aGUgY29tbWl0IG1lc3NhZ2UKYm9k
eS4gUGxlYXNlIHdyaXRlIGEgcHJvcGVyIGRlc2NyaXB0aW9uIGhlcmUuCgo+ICsgKiBbRGVzY3Jp
cGl0b25dCgpUd28gcHJvYmxlbXM6ICJEZXNjcmlwaXRvbiIgaXMgYSB0eXBvLCBhbmQgdGhlIFtE
ZXNjcmlwdGlvbl0gbGFiZWwKaXRzZWxmIGlzIGRlcHJlY2F0ZWQgaW4gTFRQIGRvYyBjb21tZW50
cy4gRHJvcCB0aGUgbGFiZWwgZW50aXJlbHkgYW5kCndyaXRlIHRoZSBkZXNjcmlwdGlvbiB0ZXh0
IGRpcmVjdGx5LgoKPiArc3RhdGljIGludCByYXdfZmQ7CgpyYXdfZmQgaXMgemVyby1pbml0aWFs
aXplZCBieSB0aGUgY29tcGlsZXIgYnV0IGZkIDAgaXMgc3RkaW4uIE1vcmUKaW1wb3J0YW50bHks
IHJhd19mZCBpcyBvcGVuZWQgaW4gcnVuX3Rlc3QoKSBhbmQgbmV2ZXIgY2xvc2VkIGFueXdoZXJl
IOKAlApub3QgYXQgdGhlIGVuZCBvZiBydW5fdGVzdCgpLCBub3QgaW4gY2xlYW51cCgpLiBUaGlz
IGxlYWtzIGEgZmlsZQpkZXNjcmlwdG9yIHBlciB0ZXN0IGludm9jYXRpb24uCgpJbml0aWFsaXpl
IGl0IHRvIC0xLCBjbG9zZSBpdCBhdCB0aGUgZW5kIG9mIHJ1bl90ZXN0KCksIGFuZCBndWFyZCBp
dAppbiBjbGVhbnVwKCk6CgogIHN0YXRpYyBpbnQgcmF3X2ZkID0gLTE7CgogIC8qIGluIGNsZWFu
dXAoKTogKi8KICBpZiAocmF3X2ZkICE9IC0xKQogICAgICBTQUZFX0NMT1NFKHJhd19mZCk7Cgo+
ICtzdGF0aWMgc2l6ZV90IHNpemU7Cj4gK3N0YXRpYyBzaXplX3QgaTsKClRoZXNlIGFyZSBvbmx5
IHVzZWQgaW5zaWRlIHJ1bl90ZXN0KCkgYW5kIGRvIG5vdCBjYXJyeSBzdGF0ZSBiZXR3ZWVuCmNh
bGxzLiBgaWAgc2hvdWxkIGJlIGRlY2xhcmVkIGFzIGxvY2FsIGFuZCBgc2l6ZWAgY2FuIGJlIGlu
aXRpYWxpemVkCmluc2lkZSB0aGUgc2V0dXAoKSBmdW5jdGlvbi4KCj4gKwlzaG1pZCA9IFNBRkVf
U0hNR0VUKElQQ19QUklWQVRFLCBzaXplLCBTSE1fSFVHRVRMQnxTSE1fUnxTSE1fVyk7Cj4gKwo+
ICsJc2htYWRkciA9IFNBRkVfU0hNQVQoc2htaWQsIDAsIFNITV9STkQpOwo+ICsJdHN0X3JlcyhU
SU5GTywgInNobWFkZHI6ICVwXG4iLCBzaG1hZGRyKTsKClR3byBpc3N1ZXMgaGVyZToKCjEuIHRz
dF9yZXMoKSBhcHBlbmRzIGl0cyBvd24gbmV3bGluZSDigJQgdGhlICJcbiIgaW4gdGhlIGZvcm1h
dCBzdHJpbmcKICAgcHJvZHVjZXMgYSBzcHVyaW91cyBibGFuayBsaW5lIGluIHRoZSBvdXRwdXQu
IFJlbW92ZSBpdC4KCjIuIHNobWFkZHIgaXMgbm90IHRyYWNrZWQgaW4gY2xlYW51cCgpLiBJZiBy
dW5fdGVzdCgpIGlzIGFib3J0ZWQgYWZ0ZXIKICAgU0FGRV9TSE1BVCAoZS5nLiBieSBhIHRzdF9i
cmsoKSBmcm9tIGEgZnV0dXJlIGNoYW5nZSBvciBhIHNpZ25hbCksCiAgIHRoZSBzZWdtZW50IHJl
bWFpbnMgYXR0YWNoZWQuIEFkZCB0byBjbGVhbnVwKCk6CgogICAgIGlmIChzaG1hZGRyKQogICAg
ICAgICBTQUZFX1NITURUKHNobWFkZHIpOwoKICAgQW5kIHJlc2V0IHNobWFkZHIgPSBOVUxMIGFm
dGVyIFNBRkVfU0hNRFQgaW4gcnVuX3Rlc3QoKS4KCj4gKwlTQUZFX1NITURUKHNobWFkZHIpOwo+
ICt9CgpXaGVuIHRoZSB0ZXN0IGlzIHJ1biB3aXRoIC1pIE4sIGVhY2ggY2FsbCB0byBydW5fdGVz
dCgpIG92ZXJ3cml0ZXMKc2htaWQgYW5kIHJhd19mZCB3aXRoIGZyZXNoIHZhbHVlcyB3aXRob3V0
IHJlbGVhc2luZyB0aGUgcHJldmlvdXMKaXRlcmF0aW9uJ3MgcmVzb3VyY2VzOgoKICAtIFRoZSBw
cmV2aW91cyByYXdfZmQgaXMgbmV2ZXIgY2xvc2VkICAgLT4gZmQgbGVhayBwZXIgaXRlcmF0aW9u
LgogIC0gVGhlIHByZXZpb3VzIHNobWlkIGlzIG5ldmVyIElQQ19STUlEJ2QgYmVmb3JlIGJlaW5n
IG92ZXJ3cml0dGVuCiAgICAtPiBzaG0gc2VnbWVudCBsZWFrIHBlciBpdGVyYXRpb247IGNsZWFu
dXAoKSBvbmx5IHJlbW92ZXMgdGhlIGxhc3QuCgpSZW1vdmUgc2htaWQgYXQgdGhlIGVuZCBvZiBy
dW5fdGVzdCgpIGFuZCByZXNldCBpdCB0byAtMSB0aGVyZSwgc28KY2xlYW51cCgpIGlzIG9ubHkg
YSBzYWZldHkgbmV0LiBDbG9zZSByYXdfZmQgYXQgdGhlIGVuZCBvZiBydW5fdGVzdCgpCmFzIHdl
bGwuCgpSZWdhcmRzLAotLQpBbmRyZWEgQ2VydmVzYXRvClNVU0UgUUUgQXV0b21hdGlvbiBFbmdp
bmVlciBMaW51eAphbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
