Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34859C83F1D
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 08:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752566487; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=dzM2yOtCH5+dlayVzyEu8A3Lx5+YPmY8T0FjVI00Fvs=;
 b=XeXN+4WndzTf0BxYgHDfo0FVmBPkld/K2BrvLDK72SvNSrk6LnvJdN0mNe7bZpOIH++qK
 xJ6Vj/QRBWWpL2PHoMcegoc8V60JqX6/+wjReU3UbXV4+eS3rm5x1O9Ajdaka6w7XsyyE4G
 Cm9XWP9ynibyW/+eUE0tzVn+t2Aiw4U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 760003CC8AD
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 10:01:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05D0E3CC10B
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:01:05 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 901EC1000527
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:01:04 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a507e88b0aso3900275f8f.1
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 01:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752566464; x=1753171264; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UGWY+1wpSKQbA4fyng8SKJCSJ/+TLqTncCRrqqYYD7U=;
 b=aoV/79gAUrSnsyfhpp9ykapfPda0EHMbQ0GKb2fbLHhv34BUrjPKcL9518SLRAgmbc
 BcfSNkk78CxMpycJMycX53vBBTuu9WxF4bYbQi0nhkY9ZjF/0BdceCE99OXOeZ61a50f
 oowQOwGmHYSj+peC+lsy3mlGiXNFpYEdjju/jcq3J4njcEf7aTX3kfRHKA5pmhFousI2
 Qc9Bec7rNVJ8SorE4GI5hWPgcO3sseCgspATJHtPhEGGkNbs1tI/hjyjvv2He+yOU6Bu
 FDD24B8G7/8tI2IhJ1Qok9lm6FnbxzJ2j9K0tKRDPiQyxByBn4j9ZYCd3WxkU6FIqFAA
 MFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752566464; x=1753171264;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UGWY+1wpSKQbA4fyng8SKJCSJ/+TLqTncCRrqqYYD7U=;
 b=Kd2lDKPBvPUEj9iQyJp1872/krkY6FerIuJqILjHcajdQbjcAHlr7xfG13F9urBUpB
 aVcwKjNZssYMqtH+uI6gH56L8qTr+X34k8XlMxJA1VAYNDskP9gElwIBR4We5BfWelpP
 9yxah/13nLe+Y/DqRttnSeiiJhv7h4sOPJdOVyVC3RTCNRUjgtvHB6fNE2M2f0Nf3nYF
 ZG48qSUgu8gtD0lIJvg2p0zRHX874GM4rtXtgkIg9V6CobXsqy7M7J6OqH3ZPw7rbUWy
 nM2RdVlXEHNwe+VsF1AbWOHoZ5Nq0xWD72dNxiPqLliZtjAg0rbnwtivThYvl6qDh/aI
 CXEw==
X-Gm-Message-State: AOJu0YzGpIiZTpfOF8SeM55LGmvXs6BDvRwYqoYFMcm39xWnth5LkdXY
 QAFeldlCM7PAjKBGB+aHTmYNa/hIpOmxwhDW2yzhmoP7oT4S4G2Q18CNP2p2ojdCRFPiPZiVyCB
 i/AOyLB4=
X-Gm-Gg: ASbGncsrcfFZFl2tqf7JxiwpaXVogBsFMOwYrdHE7Le9hOKGsSqG5viyGPwz4WS/1KB
 qGeB+LGPwmyPeET9OAUKOTIOolDW7jg7Jcg2D2mDI3YO9caAx4KBnXNqkQQBNHotGSrrUBb+qQk
 suKWTRjqCAagv/hGNpU7vFo3BFX0y/xlelp2tpPTw9KkcHPNxC634a1Y/W1lpOj5kzF2TVIQGQn
 u5cHeEqWp5rKDoot13THp9eflSa/IF5ERyrAMWOjVonzLgKgMVzks/919PQYihL0wIdjkeDgUGz
 Bs6ELxgFiLscSKIWEawr5O6AXxILfGFeaaPNn4q/KWUPP5N/pjh5+is2bVZ4+xIplubZBZUwQw5
 dRdNUDaSydqlm9XtlgtWdDeEits/hwUkETMCDE64D/s/aSVznRH9Z8gGF8rvtE9AxpTfnqjMqxu
 UfxQSf1TDfYnuiNL9EOzfq5JZgiEKUWaYonL7PaVeWRylaDwxT9K7bqytZ+Il7kA==
X-Google-Smtp-Source: AGHT+IH6UUbDEz6rO/8AZfU+ii+xZYKKMVPu8x3O/3m7Mw5vXanU4PqN87R1hBRms2oVCOtw4TZE3A==
X-Received: by 2002:a05:6000:2c04:b0:3b5:e6bf:8379 with SMTP id
 ffacd0b85a97d-3b5f18d987cmr15403033f8f.28.1752566463805; 
 Tue, 15 Jul 2025 01:01:03 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454dd47543asm153202565e9.15.2025.07.15.01.01.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 01:01:03 -0700 (PDT)
Message-ID: <dbd371d1-07e5-4569-ac9f-724dfa7b2c62@suse.com>
Date: Tue, 15 Jul 2025 10:01:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Polensky <japo@linux.ibm.com>, Wei Gao <wegao@suse.com>
References: <20250709163022.69985-1-japo@linux.ibm.com>
 <aG_A3DvZ0yRAdWbJ@MiWiFi-CR6608-srv>
 <aG9vFbcjhu648vx3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Content-Language: en-US
In-Reply-To: <aG9vFbcjhu648vx3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH v1 1/1] splice07.c: Skip invalid splice()
 tests involving memfd secret
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ck9uIDcvMTAvMjUgOTo0MyBBTSwgSmFuIFBvbGVuc2t5IHdyb3RlOgo+PiBBbm90aGVyIG9wdGlv
biBtYXliZSB3ZSBjYW4gYWRkIHRoaXMgZXJyb3IgaW50byBleHBfZXJybm9zLCBpIGd1ZXNzIGNh
bgo+PiBmaXggeW91ciBpc3N1ZT8KPj4KPj4gZm9yIGV4YW1wbGU6Cj4+ICAgICAgICAgIGNvbnN0
IGludCBleHBfZXJybm9zW10gPSB7RUJBREYsIEVJTlZBTH07Cj4+ICsgICAgICAgY29uc3QgaW50
IGV4cF9lcnJub3NbXSA9IHtFQkFERiwgRUlOVkFMLCBFQUNDRVN9Owo+Pgo+IEnigJltIGNvbmNl
cm5lZCB0aGF0IHRoaXMgYXBwcm9hY2ggbWlnaHQgbWFrZSB0aGUgdGVzdHMgdG9vIHVuc3BlY2lm
aWMuCj4KPiBBc3NvY2lhdGluZyBzcGVjaWZpYyBjb21iaW5hdGlvbnMgd2l0aCBjb3JyZXNwb25k
aW5nIGVycm9yIGNvZGVzIHdvdWxkCj4gcHJvdmlkZSBtdWNoIG1vcmUgcHJlY2lzZSByZXN1bHRz
LiBIb3dldmVyLCBnaXZlbiB0aGUgdmFzdCBudW1iZXIgb2YKPiBwb3NzaWJsZSBjb21iaW5hdGlv
bnMsIHN1Y2ggYW4gZWZmb3J0IHNlZW1zIGhhcmRseSBwcmFjdGljYWwuCkEgc3BlY2lmaWMgYXBw
cm9hY2ggZm9yIHRoZSBUU1RfRkRfTUVNRkRfU0VDUkVUIGlzIHByb2JhYmx5IHJlcXVpcmVkLCAK
YmVjYXVzZSB3ZSBkb24ndCByZWFsbHkgd2FudCB0byB0ZXN0IEVBQ0NFU1MgZm9yIGFsbCB0aGUg
b3RoZXIgZmlsZSAKZGVzY3JpcHRpb25zLiBUaGF0IG1pZ2h0IGhpZGUgYSBidWcgaW4gdGhlIGtl
cm5lbC4gV2UgbmVlZCB0byBjcmVhdGUgYSAKbmV3IHRlc3QsIHNpbmNlIHRoaXMgb25lIGlzIG9u
bHkgY2hlY2tpbmcgZm9yIEVCQURGL0VJTlZBTCBhY2NvcmRpbmcgdG8gCnRoZSBkZXNjcmlwdGlv
bi4KCi0gQW5kcmVhCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
