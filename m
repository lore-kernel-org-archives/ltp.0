Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB870C44529
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 08:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784624144; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=eIx218wYQ23IBPrEd2KWhgThSKa3mE/G1kI6FvqYOdE=;
 b=cXp0zRoFqm4pUhgmmwupgxhG+3DX7NopsKBDTJoxQ1GpdC0nNwSYfJwqe2/sVXpyHzXNQ
 Evkx2e4R1NNRLLw6JpZg4DC7SdB3TQ1+uYx0tbDHhiG//lD3PIrwKGBol/cX00TN5pwSO3p
 a2jRUsY07vArKrVsIhyaRkqsq5ZVrag=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 286763E624A
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 10:55:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C30373E2202
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:55:24 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3F50920097B
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 10:55:24 +0200 (CEST)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-69e2266b07fso8865565a12.2
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 01:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784624123; cv=none;
 d=google.com; s=arc-20260327;
 b=nVzpX1ON4gpBa4KCEwhNGAQz2aqIjZF7heISMs/tOP/qOT/zArlYwM8RL/XD/g3Aly
 OE9N0LaH5a/oqlCIYEFsg4H0mzj4c1DmNTavcLJM06nAs+BAyuvNGjdN1Xdlts1dZpCi
 ZtOnjhjADhAwQY1DZWqxkdNpJJqK+q04wGvfqP8w0P35ZrEHAi9mYAJho/ZDCyw9rSGy
 fpgOS2E/7KklRtYAVkK27wVd+jtnH4pul+cj66zpf6+L464z1D6+Eo5dUoT87+vp1YIq
 8e7X4StZ/y26fFyiTxc5bCjdf8Dd7tSp8vHjkH0tiDcAt4khHkX9PDDzKPdf8L2nkDCf
 Gg7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zaTpJFp5022AdOL57WnZcsOq1mu/Z48mPxS4x4djW6c=;
 fh=SQ9N9guitCkSaO+xuxBzp1YyEEXMxSyWmXBWFIZoYuk=;
 b=af+lPfR4GOW4h+RLgAgNG3Uzmi+9vJxRaZHbl/2URLHSUZFyqHX1vlfYxuimiUf+bw
 QjAiKOfkRkXZCTixU7N9eYk/AxJpRuDPrj5rt7fdtGfQukH7r6ytko1UFR1lNbTNbVWw
 IA9ipiIIfAK1AvotBzRS3pWHwVEiU8MhcMz3QxvUtYa1zZno+9Utr8AR4GY2dM2Ni7tE
 Xd5rlIOqNFz2wQvivDS/M4tHaA1Lb6zz79cnEJdV2DVUo7jUVFC7BNpgDhxZPN36tGpp
 Ll/Kyv/gL91X88nuYADX8gIwYy/WGHSgZmO8Q4zEJUi5FSI7FvJeXGn/eEdoUGiQMtQv
 7t1w==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784624123; x=1785228923; darn=lists.linux.it;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zaTpJFp5022AdOL57WnZcsOq1mu/Z48mPxS4x4djW6c=;
 b=FzA7WQ3WosBnOIg9mXKmCdAxDVsxPEtBOUraVHmHYR22bf9ex6nNs6ZRO8B1WB1ghg
 iTVycKD0BL3xdIe/Oj8j22wUQLVdW1khFgwsevnKcoYymjNrRQBcQShspk5t+69FcmGP
 hJ8eXMK5OrSy1oMspnGHPM1DdjIcMcewNzfsbrnE0Mw5afO1U/v4WgGajigMVlP8K0Rs
 Bh0slsk7sraaDuKRxkWc4vPjhRrp/oynUE5t7b1W+4uoTBH60jjUSH/a9dYMardrOilW
 ZcE8mAxpVkgaQsqfG1BeFMp/OE5SF0rcOeHdct/7+EmhHVtnZqEMH8Ep/4dh5cuo4LfC
 ZuWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784624123; x=1785228923;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zaTpJFp5022AdOL57WnZcsOq1mu/Z48mPxS4x4djW6c=;
 b=J2HsbPcWPDyDV/1CpX/mA/PxWE+/5EmYimNeMdDEkh1Nd9X/iFG7l0TKHldUovT4Ta
 5QFd9jkSc2lm6jEslORDBiXoEoOdydNolcBm4ytQKUfsdfdAQpT7esm74SBIIAPeTirv
 1N0XU0uqt0iIhxbXnPVqURvbVRYDUAWz4jEQ2xZWLIymfbmfsc0o+Ov4u0l42gCMmRIs
 Oc+1azlIHZAjxWec9y1zBsuz0cKKryN0GbQ7EFCG0CTs+1W13smv8F4DUHjIuZY+EY5a
 V+l5MuWvhYC6ySN2VUGZcBqB48vIDyYzel/liA7D/q+dlUtlSmAmdWbF/qCqGr17twuy
 DvWw==
X-Gm-Message-State: AOJu0Yy58j9tp/PrkXIkCLmil5DYOAIVuUV/BQJ5nGUG7IcCnkOQTtC4
 QBDjgbEjJZ+gYiVEF390QBgVFFUb7oaYJqa0NwJA4mzHQutqD8h42uu023if1/1kaLam+HkITjU
 VixkUPHElSu+hYAo2sYXxiVrkfxZCn9WxikvPcGJx+ATIgsJHVAIVaA==
X-Gm-Gg: AR+sD12m71Tp22l9uuiZ/EO+lFpKB9ygdyJytwJAMdIUv6xlqTmuz4jyCOWTLRAih6y
 jqS072gF7XxwB7kUgc9gyCZPDV2H+K3Ux5OwE5ZzQRkTBWIa0Qh7bKMQM9nu7aitnP9xFoDrS8V
 PM/UflyO4sQHjLcLbNadfN7fWK+2TbhN8nMZ7Vj3YAqF/g6B7vPWMIGpSrBB21WfJXlW2tGEXc7
 TZOHK6ZCHexHvhDqcrFJJ4rMKKXFV/K7ui21OPLC2QYRO3og2jjTfQnLsy/ZQ==
X-Received: by 2002:a05:6402:505b:b0:698:50ea:2d97 with SMTP id
 4fb4d7f45d1cf-69e652ddfd9mr6184917a12.20.1784624123609; Tue, 21 Jul 2026
 01:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260721074146.2779-1-wegao@suse.com>
 <6a5f2c65.3fefe569.30a19c.9c0a@mx.google.com>
In-Reply-To: <6a5f2c65.3fefe569.30a19c.9c0a@mx.google.com>
Date: Tue, 21 Jul 2026 16:55:12 +0800
X-Gm-Features: AUfX_mxvlbmKXT9g6m-fVW265XyYtzpIMdHfwlKkbLiA1YjmZDuRkOdunxcyq74
Message-ID: <CAJs-1pVirwOW-FojsEa_gYCdiFQmXodRiyzUcS-i_Ccd6RnBow@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v11 0/2] open16: allow restricted O_CREAT of FIFOs
 and regular files
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhCgpPaywgSSB3aWxsIHNlbmQgaXQgaW4gYSBuZXcgdGhyZWFkLgoKVGhhbmtzLgoK
R2FvIFdlaQoKT24gVHVlLCBKdWwgMjEsIDIwMjYgYXQgNDoyM+KAr1BNIEFuZHJlYSBDZXJ2ZXNh
dG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cndyb3RlOgoKPiBIaSBXZWksCj4KPiBjYW4g
eW91IHBsZWFzZSBzZW5kIHRoZSBwYXRjaC1zZXQgaW4gYSBuZXcgdGhyZWFkLCBpbnN0ZWFkIG9m
IHJlcGx5aW5nCj4gdG8gdGhlIG9sZCB2ZXJzaW9uPyB3ZSBhcmUgaGF2aW5nIGEgcmVhbGx5IGxv
bmcgdGhyZWFkIGluIHRoZSBsb3JlCj4gaW5zdGFuY2UgYW5kIGl0J3MgZ2V0dGluZyBkaWZmY2l1
bHQgdG8gcmVhZC4KPgo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI1MDUxNjE1MTAy
OC4xMjU0MjA3LTEtd2VnYW9Ac3VzZS5jb20vCj4KPiBUaGFua3MsCj4gLS0KPiBBbmRyZWEgQ2Vy
dmVzYXRvCj4gU1VTRSBRRSBBdXRvbWF0aW9uIEVuZ2luZWVyIExpbnV4Cj4gYW5kcmVhLmNlcnZl
c2F0b0BzdXNlLmNvbQo+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
