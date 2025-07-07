Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C80CC83F0C
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751901927; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=ci6ig8OBzNZI730irJrR27M+rc0QIeXs9ViApzF+UA0=;
 b=Cf2Ui4h2J8JggoI5eiwjxpO6IWhhyvdZ1xsCUm1hvXLCoC+JhWm0S7UOAKGYNgcrz3odD
 2JzWqjQUN0VX2Y+qPr3Vb4D/7y611KcI+LkC/uIPoziixk/nZkvy5KNYbyI8Z6BGuIdjGCi
 HPo8/eQaJgijHvUxeriS2kIPkfeaQjA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F7163C99D4
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 17:25:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B5093C99CF
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:25:06 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5E6EA2009CE
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 17:25:06 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ae361e8ec32so665147166b.3
 for <ltp@lists.linux.it>; Mon, 07 Jul 2025 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751901906; x=1752506706; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8oCb9LrX/PShpoTI9xKPJzUZTfc8sp+o+9qaY2Jt4eA=;
 b=EHk8zLYbVHAy02WPZ5MQJpwI4uuzlXv6Rph1BcgENgCAQnGtTcySH5MYwAyNvGGSoU
 SGTjUhfmjiKAmKRVn0yL90OPvfHZ4ea+e5RVkqMeiRLlE8GjjtS9A2VIqLgQHijXOnUM
 X9k1ugu4nycKZLBOPL4MpVaKan42DNsHH/yx8cyi/hIXNBK56qWZSV0fTry7ouDoG/ia
 naCG16t7dkIDqZb4KVBUW6RgX0s+poBY21N9dvA6gnfw2gGdXMXlwHmYzHJBUh66jJCj
 FKVPUKzIesW+kcxXoEZYRMfMz6khX90OOw6o7aqU2gRoMAp17vvSqYCfimVRc2/7k74e
 9Qcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751901906; x=1752506706;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8oCb9LrX/PShpoTI9xKPJzUZTfc8sp+o+9qaY2Jt4eA=;
 b=qKvDPxZ3WsVFGaADYX6e9AifW34gZUsQKXGBE0CKjG5hqqlmJRQYjSapfViKHSGJf+
 g30SmDSvJcnO4qLSkprrUsIdgWAqmCY/mIK/ZGbrI9T8IL+8EwSlNWsqmBibY+Wesbjo
 uRaoc7OV15mYyOVz4lv9ztHY5ewIAFs9nL1hQAB9nVw1f0D87GXkCe+K+q61IeZQNlsR
 DC2RfAnStUHmrGUT0bNSg9O50fPGh3hDuJXd1QJifSbITkbBYXsWiNt5pF1/hVuS8u0J
 6KzjO2Tvus/2L2n4LwNtfJ5Wmcrvt641S9/O4ottBpkVLs+eHTOyN57+ehJaNOui8tLL
 Nlgg==
X-Gm-Message-State: AOJu0YygUaCt6LPUKnEWoIXsV+s0KArrQQ1ZQbFEY35Y60/Ik4LzXDG1
 P+JXfpBbZudbgv9VimX0xmmHwrMU20fwIotDl6A5TcZX9iytFIRdbEav5e5H0Xy7nsQ=
X-Gm-Gg: ASbGncsFHrTc4cNe1i6zodfGx8qf0jmhhZ2pOyblmPIk0R5E0sMTPApe+kS49daMc4o
 wwmtyKlsv87M4TM6F4yaUGzh7wkCp5+CPCfWrekK+GMvKsJxyVi58tX8yw2UBRfEnbjQuUEcqSl
 JHyg8HCKW42rKgFtcTgFRzME/TsgNYd4BwXl+LSLr8y9WkK7MxJ3hx+vqsWBiD3A8ECigempe2M
 6D/5hnwc+I2ypeoFRB1gzPKKqUZhzny5b7SkzWJjOMow9i4uTdkWfs9sEtUBIanDzrdaQ4QlblK
 /l1JGLgPysXXQkaQ4Ia78egFW9vzdNe3Zw+sX6KK9lY9D73V5hqKnmUlKbjEvjsALDHGM1EqkBA
 FRI90yn5Kxl/AEI5jLgN0asQbpu5Cqg==
X-Google-Smtp-Source: AGHT+IF6nnKkUQup1B5if9CCVJ44HlRfa3vhakiPjRAbzyBH+q6AsvvdYpE8n8ys2ylaDBg9awplRg==
X-Received: by 2002:a17:906:dc92:b0:ae0:bd4d:4d66 with SMTP id
 a640c23a62f3a-ae4107f2e00mr891205066b.27.1751901905659; 
 Mon, 07 Jul 2025 08:25:05 -0700 (PDT)
Received: from [172.20.10.3] (ip-109-40-178-88.web.vodafone.de.
 [109.40.178.88]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae3f6ac54a0sm731555966b.109.2025.07.07.08.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 08:25:05 -0700 (PDT)
Message-ID: <10cc62f8-9270-4e68-ae9d-d3342b1baf7c@suse.com>
Date: Mon, 7 Jul 2025 17:25:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
 <20250704-ioctl_pidfd_suite-v2-4-88a6466d9f62@suse.com>
 <aGu-qne-SMpTCEy4@yuki.lan>
Content-Language: en-US
In-Reply-To: <aGu-qne-SMpTCEy4@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/8] Add ioctl_pidfd02 test
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

T24gNy83LzI1IDI6MzMgUE0sIEN5cmlsIEhydWJpcyB3cm90ZToKPiBXb3VsZG4ndCBpdCBiZSBq
dXN0IGVhc2llciB0byBjaGVjayB0aGF0IGluZm8xLT5leGl0X2NvZGUgPT0gMTAwPyBXZQppbmZv
MS0+ZXhpdF9jb2RlIGlzIHRoZSBlcXVpdmFsZW50IG9mIHRoZSAid3N0YXR1cyIgc2V0IGJ5IHdh
aXRwaWQoKSwgc28gCmV2ZW50dWFsbHkgd2Ugc2hvdWxkOgoKIMKgwqDCoCBUU1RfRVhQX0VRX0xJ
KGluZm8xLT5leGl0X2NvZGUsIHN0YXR1cyk7CgotIEFuZHJlYQoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
