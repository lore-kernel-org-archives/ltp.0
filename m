Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE71C02192
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 09:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738749493; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=R/xl9RuvCBntLZRnFylOuPuPlysbnVIIpe9vWFyRjic=;
 b=qzf1IV3WmmQmZCmXSswEDnoTKwfq3cFDvMDBeyeSJkKii0hTryZMbi9QmF0VFTwt63oxo
 cc9UYi5ODSSxOxIhVLtRlygHCLaS4dkmIyr6v2EZPniF/HETz07IV7e337KSrv/xJTTvEtz
 U1K+56ht/OECpb5WbxgVYA7FAhBdXpQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E72F3C91F8
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 10:58:13 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAEF63C8F58
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 10:57:51 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 731291BDC58F
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 10:57:50 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361f796586so76410395e9.3
 for <ltp@lists.linux.it>; Wed, 05 Feb 2025 01:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738749470; x=1739354270; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=syXxxrap6mv6cStke7putEfYPd4xWX6davkC38MEBRg=;
 b=C0rBQz7VcHKROnIMHtPLwXxK0J5mCPAzHgfnWmbr/AgGk09G0rUmgy4Q9si98yeETH
 YKyx1eqvvoxwsYOmYS4YOuGclMHa8YKmb9ZWx0E5YkgJ0oxzr7kcpmqOjDbJUH8z2fmx
 SLXo2k8bl3hz5gsJoBJecp58SwCC/n0PSxATC5Dl1a18WspCyXS3o5C2j36qqCpLzjYr
 4AvbMx3cekGGe4IgyN2iKpvQ55oXd0fCvpLGVUG6X40xcP0NnmtA/7HNhPh4GLPt+jLY
 kvUjQKSjJi5NoU50zBUivOO5Rwt7P8snziZs+jJjnD8i4hymfh19639hd+lope3RLVHP
 dI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738749470; x=1739354270;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=syXxxrap6mv6cStke7putEfYPd4xWX6davkC38MEBRg=;
 b=qqRjF0TN9bfAWzZ/hEdX0lBMi9IHPFf0q2mEqqAYucVu9nlIdBYBbVHZ6p4on6ivg7
 ANjT1xRxEHIhiMUpY9/b2bqUta4odNeSeswWVsfcUU6M3hu/dJB/UN9f9YsXQQi4UeoP
 U/tIlTzw+lLz9b0cSmXrHD60q0I4EyKMCWN/PaiAONRwnDfUWfu/j0iiEDaRMOs7S5nr
 /b+CtIBcpt6VAbV0TSWceDBKyIm+Rc4oQ0+ZL0JTw+U1VvtwehzqMzcA6c16DnOYSQxj
 BggvxWUaxx3nvHRPXxh/+ry8xgvOPYwj0bsCX9RK8+8g89e4pnMMVhX2mGc06bZbFiY3
 2PfA==
X-Gm-Message-State: AOJu0Yx584/Rw2UNivHAyqXTiNQvF75Ry0a3h01nX/1UhB/8jBUyJtZg
 Wqt3mD3BcOu7YOiYlrgsuT32CRF6q4IUzIz2/R/wq3fMG48nl9yH2C0LfY5c0BI=
X-Gm-Gg: ASbGnctVn9LObo/u9ySg8K3eCQs3IwjsUiJHiWsvU98PY/SEU1a5G8o6MT5w3bajA4W
 hIyCd1qeVSUALEg5YTubxz68n/VMJVk+ervqxVNR2L7ZlP9JTzcjzWATmEiwSWL8UmhqGrL6ba3
 CgQ9bTfiMXfRlUJRmbvdeABoJGYAYrUEq1Ek66iEEus+Uexa6lAYkAoJ+Zkm92wRTdvSHQS9XXM
 RH+A/opnp4cST0l3s8UVThMnRj4eHolyXwiloDyCO6N3kROvV0gFTbmXjCGKgK78Cs6AdPF7x/b
 ID6eIVV4XzfIe1i4Ss7TezuXxA==
X-Google-Smtp-Source: AGHT+IGWHAN40uBqT+qgcEi3AKB5EUc+dCYZwYmxZVmHrDLjUYyQi+DXFxrKTLzSgdOy9tUMXA6HPw==
X-Received: by 2002:a5d:524f:0:b0:38b:ec2d:c0cf with SMTP id
 ffacd0b85a97d-38db491062cmr1623318f8f.44.1738749469896; 
 Wed, 05 Feb 2025 01:57:49 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.53])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6e47a83e3sm1067017766b.29.2025.02.05.01.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2025 01:57:49 -0800 (PST)
Message-ID: <7a5638e3-cb49-479b-9b80-5c6f148f9521@suse.com>
Date: Wed, 5 Feb 2025 10:57:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>
References: <20250204-doc_tests_list-v2-1-9d29aeacc3f3@suse.com>
 <99e715d2-d30c-4bee-bd0a-30ab6929e58d@suse.com>
 <20250205093918.GB1473026@pevik>
Content-Language: en-US
In-Reply-To: <20250205093918.GB1473026@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] doc: add tests catalog page
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

I sent a followup message for the broken format after sending the v3 patch.

On 2/5/25 10:39, Petr Vorel wrote:
> Hi Andrea,
>
> first, thanks for doing the migration.
> I haven't checked whether all necessary keys are shown (will do).
>
> It would be nice, if the keys (e.g. mount_device) were references, then user can
> click to the documentation.
I can check how to do that
>
> I'm also thinking that splitting tests by alphabet would help to have shorter
> page + not that long list of the tests on the left side. But for searching it's
> better to have all tests on a single page. WDYT?
That's quite a thing. It requires more code and I don't know how to do 
it honestly. It would be nice to push the patch and add this feature 
later on eventually.
>
> Kind regards,
> Petr
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
