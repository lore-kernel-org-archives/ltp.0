Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF81C83F17
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 08:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752566580; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=uTfXBOV0kU98LedbHTFu6yz44DIUTLcTY2JSZqfh45A=;
 b=b4KZamCjtOcm93p8f/wg2VoXRlbfvwPaEVdfeVruy6Q+4MH5x/s+tsGX0Z9AdHK+Ff4KG
 jWJSQHFucoBwlvTtxFNPf5FQSDDc8LGJKQhbMP5aBsPKl9JWUzPHWT8kGqJe+g3RE0Cbm/a
 0oaK+XNXae2G4FXgwxlSwn89EpuWdNM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7811A3CCA24
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 10:03:00 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC7043CC185
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:02:39 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 55B01200167
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 10:02:39 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so10983115e9.0
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 01:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752566559; x=1753171359; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xZFSvuGMX+KyIIhcb83F0wQiNrfaVDiDvNRX9TpX3Lk=;
 b=Nu5LF+b5WA/qmDybIofQyVsqVIKpDZ3fel3VTrBd5YjaqZu1z9t1bEfAJ3AykS+bye
 3ppNGS2ZoLHlgvtomwjFKStgW/y6zHS85KCZnTGj1CcMN4+pk6DfVuwxBACBuwc6TUiv
 Pqv2xt/htpjIpQjf39lY1CbSnSMu3dEFJlRP62CLcyQuGQEf8DoVEVY2auWggMLwFYR1
 vsFmGnVgOTYh4bs/bimxPS8DdpEgk/WmIrUjfcgz++4iZggRgb3hI9DgUWDn6d27wlZc
 DapacIfyKGmVWRBmQ5672rgvW6nELF6wDFDv3BN5ejOeOnZA8eo0w4pZCeqFF/yDduJ9
 YY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752566559; x=1753171359;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xZFSvuGMX+KyIIhcb83F0wQiNrfaVDiDvNRX9TpX3Lk=;
 b=m+lVqjiRsKwtQ3je7V83OqfCEkYCK9io2ASZ4f3k9hL/nblsl1BogYM3nreI93nGbs
 evfvK082qfyIsnBQOQTwSllFbKQqM+FNT9U1fyGrvzmEGw1gMs71hAzeIl5qqRU0ICdO
 G7HnDpKP2E8wUFqGw87S2S+k5V9Q2asIVpV8TzmehySL7L/VJDLKIvEPZn4YyBU+eSWH
 5OwwNP3gPAIUtsLngMN28OlorOEdJQUPzu6ogMhVvTRXCzWdUn8D2/x2LnuZ/8ImXNDM
 qnInlhkZEzkVmwVPfyU4AnuMzB4ZDJAya+ZUxL3AU7AjnW8RrEtmT1w1LpeIqjZZDWRr
 /j/A==
X-Gm-Message-State: AOJu0Yx2jJT8PBa2N8JdoPXaU+D16cnKhylcufJAqB6JMTOAjwNRGTDH
 ZXMwiJh6iQQf1/oKMJIRzWlwyWwNtvZe9g+PxjtAofgKbUY5Oayg5vg7AVittoNyXjI=
X-Gm-Gg: ASbGncveEIPlut33Di2/z112wT+nPjk6LzTmc23uaW1+a2fGhBG+iZGIwRPOTNCdo+Q
 Zlv35/+jWPzQ3UXhSP4LU+d/3lhwPGzBBwIZRwPiu6feunisSBzpoWWM4r4ecksGaDaZUBr43gk
 rEb7T4T5dg076UdjikZgAjUlH8eWPEIbxS+FwhlQv8aJX9Vjdjl9R+MVyvwtpul9gMfSkl7o6jM
 orDrHKW+NlzgCZa//cQFPDdw/Opy+Vyz+Z8wlm/zP66fnYMQl+mOl3Tp87/Tr32DaniChyRUoH/
 WSPTv1uezkTXd70TqijfCZED/LheINv7Xh0stCmbjf01j2KA435kbaPU1KA7s+YSEMkW8u8ce3M
 7v7ADIAPwGRPHyUv5c+6Ij2FVQ1vTyaWwTx4cvB/r3oYxqto29+MouX7E74UJZqSJlf8awFT4xW
 9jBTYviw46oy8P3xFF0o0z38+Gi1ny3YYkqc/Gv0W145Sf/ZK9D3XtzH64fbD6FA==
X-Google-Smtp-Source: AGHT+IG73qa9QanPKJAY1GdG9EUeiL5ya+R9zW6yX8MzS49fPstAHKYKS5jE7IdduyS5iQ1iOD7upQ==
X-Received: by 2002:a05:600c:1909:b0:456:29ae:3dbe with SMTP id
 5b1f17b1804b1-45629ae4011mr6191955e9.24.1752566558720; 
 Tue, 15 Jul 2025 01:02:38 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc3a54sm14661471f8f.39.2025.07.15.01.02.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 01:02:38 -0700 (PDT)
Message-ID: <eb838530-b657-46ec-a6df-2e6fe130404a@suse.com>
Date: Tue, 15 Jul 2025 10:02:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Polensky <japo@linux.ibm.com>, chrubis@suse.cz, pvorel@suse.cz
References: <20250709163022.69985-1-japo@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20250709163022.69985-1-japo@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, thanks!

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
