Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928F3E77182
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1734012855; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=3GSAeuzaUAFvELXc5RuXW6ZrP/ZNRUa2myMbciQnH18=;
 b=FBp8f2wvZKj2W0RTqtaJz4SlNe/NErkybO+67KXs9Cke5Fu9DAITRRxb2hVZvOW4TJNS5
 m4eHCsK2mr5S3pUQ8ixMrK9sUS1hi9ATugG6p0B3i5WEucy9rfSvyxYpdds5FhCNRxtpvdv
 dLIxmMqndOzp4ZHwrXTubFnYCbnqxVQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 136523E9917
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 15:14:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BEB33E1529
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 15:13:54 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 45E6D257355
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 15:13:53 +0100 (CET)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa689a37dd4so115922566b.3
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 06:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734012832; x=1734617632; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8F+r+FR6YSs9zG+qxsz75a9XyNwt5IwRlAusxJtlCBQ=;
 b=cXEeDXrmX4gOjfTFBwgGM0YRAb1aiXtvPaVdehff8h67EC0EWM19uYzkg9MzN5tM4f
 1JRl+dfXeZaE3KfAYvN6kgN69K/w/igEHXOmPs5agaXl/jatc4yUtwbq8AR8K67R73wF
 173xeeJN3yUDHez88K9fW9tFh1NKYKYBoWu4VffV52X3qAQFwMMXaZ5hwCnqBB6A5FAw
 hZkXtRerF88ndOX8AXsgmErMrf0mKLoVCanD89QP4O2fDhhuD6wKnGbHfv/cXEnF1Xpm
 tAwE603e+5EuNr5yUhOxF9ihgRvXMAf2i8z5njQpQg0ki7Ib5sr5vnTQVqlWbRAQqV9/
 uzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734012832; x=1734617632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8F+r+FR6YSs9zG+qxsz75a9XyNwt5IwRlAusxJtlCBQ=;
 b=UwPl0s1LY81S1b/cuSjImndAQSsdxWJHb+DUOf/+8mRUZNqGeEYPlxaWPFbGBbIPhn
 dQm7U2BgPShPZAYxEWPW2XsEnTUj8p8ssIOq1JQ+I/L23GWk1LYjEzuuyleMH02SJt1C
 nhcdl4abNAOVF76+XcntRP1dPpoZ1q1S9FNhP0mhPNtLxNHvhd+3HV0I/Ol1nWfMHYAF
 ULCzSRgA1CCd23b2jaMv3x6oThl7hN3uM+XMsMI3JPYWtOocwgkxfhFa3paK36rF5nIG
 7D8LnyxBim96d1nR1iV+RD3AOqGq/p4mxnkQ8FRtjA5YfW73PY8l+/KUWwmYQGMbEa5Z
 mwPg==
X-Gm-Message-State: AOJu0YwafhwFVzzPN+UspqtwdMrgXzY6Os5kWWjDPMbqZcw2o3F2e/Wx
 /Tls3eMOwSzwscLGeZ3YeTsumr7cEyV0uj19xOa9gZ8q7XzEPg/eUoSf4j45Ie8EqV3U50NEMV5
 fbIoz/Q==
X-Gm-Gg: ASbGnctoB6+rjVVbGIgnPz4BTJPGtjkShLqldjk/AkCJc9bqmhMz/F9VGbJDA5zITLC
 UpZc30jl0t5A4yMQWIHEXZLrfFKHxmRs613nf/P4hQLE9mJ6MJKuugoycIRlykHYhJrIulTxj3l
 QlJf1zjQdLmeS8DNWbZ40IGRzGvpd8OHoN7ShxWZLsVITnk/xInGMEt1r9XpsKv25poTt4e7c+O
 kLHZ7fFxrijJIAq9W3apfwLyZgTbSUED9DglFeFA9Ojs/KEIkxrBFCAWU2lclSJbQvXJDc+Fz8U
 vXBqxBq4wUHAkrM054HQUfjzvsfsAnujxxJGxjHnND2oyJMcozGk7csyxs4RwrtaM0Ykau4i+26
 seDs17SumX2XCa4H4DEw=
X-Google-Smtp-Source: AGHT+IFmM+eqI+7h2L76NP49/FjJs4iDjerCd40XiwHlUcsVs4C/llDRjbLdzMs5/Q6XdjSdHtwiAg==
X-Received: by 2002:a17:906:292a:b0:aa6:7d82:540a with SMTP id
 a640c23a62f3a-aa6b14fcce0mr619630766b.61.1734012832271; 
 Thu, 12 Dec 2024 06:13:52 -0800 (PST)
Received: from ?IPV6:2003:ef:2f27:8800:6a22:ade0:fb79:fefa?
 (p200300ef2f2788006a22ade0fb79fefa.dip0.t-ipconnect.de.
 [2003:ef:2f27:8800:6a22:ade0:fb79:fefa])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa686d933ffsm599741566b.1.2024.12.12.06.13.51
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2024 06:13:52 -0800 (PST)
Message-ID: <d2025fe4-91aa-4c06-b5ae-888612c9941b@suse.com>
Date: Thu, 12 Dec 2024 15:13:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20241212-doc_syscalls_link-v1-0-69a916958ba9@suse.com>
Content-Language: en-US
In-Reply-To: <20241212-doc_syscalls_link-v1-0-69a916958ba9@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] doc: support for links in syscalls
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

Pushed with follow up patch for blacklist.

Thanks!
Andrea

On 12/12/24 11:33, Andrea Cervesato wrote:
> This is an optimization of the documentation, which adds a bit of
> refactoring and clickable syscalls names inside the statistics table.
> In this way, users can click on a syscall and being redirected to the
> source code which is testing it.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Andrea Cervesato (2):
>        doc: cleanup conf.py script
>        doc: support for clickable syscalls under stats
>
>   doc/conf.py | 158 ++++++++++++++++++++++++++++++++++--------------------------
>   1 file changed, 91 insertions(+), 67 deletions(-)
> ---
> base-commit: 8f2292af050fd64c447dd462880d0b0a19d79448
> change-id: 20241204-doc_syscalls_link-a184545389ba
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
