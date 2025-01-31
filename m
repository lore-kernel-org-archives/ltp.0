Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28B5C0218D
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 09:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738316338; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=WfqzgT3sGGsFTHFc0wDGVxje8IUOVQGn/bNiH4MG9aI=;
 b=Weku0ZYycw+UMmmoBSiwNSJ0nItWp5hN+wyfO/qnwlCtWpeBi8Nf8BmU8hvPQ0KWUx6wX
 0qb5wj3hs6Jp6tKQDsPez5W4C2uH4SACW5dFYzDJ/rvoowVR+f1t1UWLCrg6ITg6GiwMuu5
 tTNfhRErGLDKRpP1wKmfCg9M2ZgRvR8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C8963C7ABD
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 10:38:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 998233C69A9
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 10:38:36 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 94C1B228A34
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 10:38:34 +0100 (CET)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38be3bfb045so1941390f8f.0
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 01:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738316314; x=1738921114; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EUcoYekhPjyUhqrydjLb3ZFvHVRlnx9SErkPCKssv2k=;
 b=grlZMXjfmImwghjMZi02PbC0bCEQT+AOtcgs+1mc3o93Lmrn4bBOsk+D2So22IhPFP
 fB0vUW5vjLV/FkV2Xd8E6vp4+3uESYXis8qLZLj8QgA3RjVtS358Pol+ke41+YEau5gR
 7YclfzPzz3CD+59TibK1WNfEQan+paLmoPoKKW1IIbygaX2rBNjyeFhRPwS70H+bbKyA
 M8tjxo2j4cNN0bPBB/dJ28cOTnNFLt7pO2TAmt7rgrzMQT253Y/7ZkXbDlkAigjLCcwB
 ly2eCn1Ht0XQLPmk9mKKo6C94++rpcSfCB6NfdHZl4ru2r3FgvZ8XF8ca2mjjuzGlScY
 MrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738316314; x=1738921114;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EUcoYekhPjyUhqrydjLb3ZFvHVRlnx9SErkPCKssv2k=;
 b=w9wWgTfaj11hgab/90b77VtEONOZWDan2EobAe6WyLxFox932c/vXQDpczS2spslnU
 7JbBkwfNWrwiBjsiBNuT6LDQu1W7TI/VdGPX2zoBfaCBfHYOpjf3XviCY4RkK4HWt298
 1fjMu/wFr5rFpHacAQD5fLYvkKOJJ9yz/moXF+rCYmJsdsF2kd14Sof9D6l1mydrDMEO
 y8tIeAq4A7QKd4SjwMkwaPin7gL7KC/XoOWFk1iXR3Py54OJJ3gOMS3iYy4Aj+W8wFDV
 OHxLL2+SqgG9N+BSPGvgHKsUVARtLBlkRnhf1oUI2wJV0svUu8KNlKfSWZ1bpqVcsLDc
 M3Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpJJjyeYzzwbICqzhbsNblYXc0+t3UUt//Iui3OSHTVqzOMp3+w2puCFAJ+iUhcRGt5lU=@lists.linux.it
X-Gm-Message-State: AOJu0YxC1BkJCi8maOcJaxb9lg+tqMnjYv7OQJpFpbPs4b0EI+146aWC
 VV4DeOA9Wa1qO4z3zpE1ajDPMQ9qXVXvlD4UxZR7lYtQoeP2cfwraaLd3HFvzhw=
X-Gm-Gg: ASbGnct8Qhtz8afNHqQ6MsQh/3fKnuhGZiR0DCyvo5QGv2C5Mh4/Z58PUF8hyOi26uR
 3rGjrvPhMb29RTl6xi/n5AUBcYsBMg34WOXk9bCCMZr+Z24C5Chu9N2e0w+ufVmwe9yhn2RZ9ev
 PTo41z2OU3r27KnTxZCTjbKuG53ErI5JdLS1JvnZpPvlN0Lo1nY2/9cSaAWwQxO51kILGYEDtQo
 c0EdvO39WBgaYTUEIRVi69OzjVmjnWc/ZjtVjAXwDqpeqliTgb1bVi+AAcPWqBOubx9sAmWHncu
 XV85Rn4w1bhd30/muffuyOkr0MBF+WwBB0qqfSP8CB1XYzChHJk9f0YSTH9ilCD+C76sH6AVmOQ
 JSJGhCPDPSMojV54NKEj6seS2h/GQ0yB5kvU8VQboj55cKfTi1C8=
X-Google-Smtp-Source: AGHT+IFM+4Ge7kVpiS5aKPNB77/6mZDNAKfSRZ3+WcjudY9tdOrp/Xx7fCt0CPP15/3LT5ieqPpKXg==
X-Received: by 2002:a05:6000:4022:b0:38a:8b34:76b0 with SMTP id
 ffacd0b85a97d-38c60f78192mr2224738f8f.27.1738316314007; 
 Fri, 31 Jan 2025 01:38:34 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81911sm83946275e9.38.2025.01.31.01.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 01:38:33 -0800 (PST)
Message-ID: <92cb274a-440a-42e5-95ab-5dd0e1513074@suse.com>
Date: Fri, 31 Jan 2025 10:38:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250131091535.GB1090737@pevik>
Content-Language: en-US
In-Reply-To: <20250131091535.GB1090737@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] Remove [Description] subtitle from docparse
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

I'm currently working on parsing metadata in order to produce a tests 
list in the LTP documentation.
I just replace "[Description]" with "**Description**". Same for 
"[Algorithm]".

I would keep the bold version tho, with the double star **.

Andrea

On 1/31/25 10:15, Petr Vorel wrote:
> Hi,
>
> Can we remove [Description] part from docparse documentation in tests?
> This is transformed into "Description" subtitle in resulted html/pdf.
>
> 1) It's not really needed (it's obvious that it's a description of the test)
> 2) Sometimes it's missing (inconsistency).
>
> I would keep other subtitles (e.g. [Algorithm]), just remove the first one.
>
> Kind regards,
> Petr
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
