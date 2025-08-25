Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31565C8303F
	for <ltp@archiver.kernel.org>; Mon, 25 Aug 2025 18:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756146684; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=tsSAmKpvTv3MynqLp1mYVN+0k1Tqnov2/0gYcGn/aaM=;
 b=MNawjqRvKetQ47lLbLS74LUddSUx0+aCWIfGmvQivpn0YsbSmfjNnD+UuklTICPUR2NRM
 BDVOXkhjY3+x97Pm+RGwMQRUE02rasb7tCCsmWAo0FSEdmcLaIJ4q01zpf9oMRNyLbuOIK5
 Mmr2vDacwBeVuGkdONMuLVz/B0peqw0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 873E33C62A9
	for <ltp@archiver.kernel.org>; Mon, 25 Aug 2025 20:31:24 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F4643C0372
 for <ltp@lists.linux.it>; Mon, 25 Aug 2025 20:31:04 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E8C86600287
 for <ltp@lists.linux.it>; Mon, 25 Aug 2025 20:31:02 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-afcb7347e09so810332466b.0
 for <ltp@lists.linux.it>; Mon, 25 Aug 2025 11:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756146662; x=1756751462; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GIWeGDunUhnDXhPTNyQn4bn/DGOnRzxJnod2ScQyYfI=;
 b=GqtS00MBoQbmIwrhwuZDhnVY24Clc7vVuhZl2q81JqLrhB/pg/sDGs+jT0KYiOfqrK
 lqQkiniYFooqrRrCyniekdheMAMwI2UPGo//Bi+0Ug3mJ5hFGEJ6bJly92OAzIMTfaCk
 QJ31+gdrgTq+0UVC6SxUBazKKUX6bKsr35lJxGNf1XqdLdlYvhe8Hp2iOJCanC8t10wc
 Ydq8P60SgIeDezjYEN3pkRUukxFn3os5tcmVkzlKTMKkmwumFJaS14wr8c1oHrLmabAM
 enAen0oLgXIafHhmlHJIsa61JzkqwRJjgwygv3pltHX4OxcJWxvm5JlYnaI6KIE7xHxe
 sRAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756146662; x=1756751462;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GIWeGDunUhnDXhPTNyQn4bn/DGOnRzxJnod2ScQyYfI=;
 b=XOBt6US6Ug39Wrm5UeShgCbK1/7I3YSEhDU4dRURWQVVVcwZG3zHT8iXvIxtd3/xTN
 VNYHqPLVHmnm/GWNCdSf1tXca94HIRdA7Yu4ym1WxNK/cxm9S1ICd9d/C2KXDwEKjTTE
 3AHPpA+c+ZUq7tFzvDsoOyJH0m3uNwmiSa2WYbkp4yu+GviQT5ybZMR1GwkIlsZ03GRI
 GyGk+jsUHc5AVyvtB2LK9VppWG+TARcNRGzlS5+2BCQv10eB+9S1TQM4BOFFYxxnttmQ
 AhpVHwhZ91QTN5dtE327je9HlbnnmG7hDKRX+Z4Y0o3riGJzvFOznrvRKBJ4Lr2+YVXy
 vyRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTzse8Xmjqsx1k8eNvwrZYloiIa9Ph67zfiWzHC8j7mebKhQPKF9sBSqaMxZXy7ENTxj4=@lists.linux.it
X-Gm-Message-State: AOJu0Yywn3nN/hqc4cYY8Ut3xnpa00hOGRcHt6a5MBAbjCVRn2eaqcDX
 ziaBvCAPB7ceKMnon4LHoPl2M4p1UmZEUFQFj9wIKdO902/Elv1tHMFCJVnRbokhJ9Y=
X-Gm-Gg: ASbGnctzuxvkSfo9HynNdDI9K5/LSMzf79+velPLKSc2q3nzlavpniOVNH+K6nNafch
 5vHkl1dayawF2wmrUqX6iNtVSePA2t/T1AE4rKUNYxEomGq8xn534MYTxZIvWdM2UCRLD2G8Kao
 xTbTdcUKDpGkxtGcFpG9MWRsbfX4+aiDci71+AGkKUBhd7Uz4WElxYHBmh9wTGhR7I9BdVy0z7f
 COX914AsR+nDNsozBkuE2udxY6fh2Hb/xWApqRe8GHNOjUJQC4l5mN5RJoc1CHpm8i6T4yW+hyS
 7534XaKRpHO2uYRle4P4Xt6c+e0y/ZQsCsfjv8EOiLagjv3FKCnDJM8RwqcdHUddnqZX+j2pN8n
 uEAVCsmlTqlp3F3DbcOyZzfrBmOsTTdDFJg==
X-Google-Smtp-Source: AGHT+IHqCMHfd25gvMUCI5O+wxTo4HtM7StZvOkqGt6Bt1SMhijqDpo9W9ssOjV4KSmN0gZyUFr1fw==
X-Received: by 2002:a17:906:c515:b0:afe:8c69:4c3a with SMTP id
 a640c23a62f3a-afe8c6957d3mr191784066b.37.1756146662329; 
 Mon, 25 Aug 2025 11:31:02 -0700 (PDT)
Received: from [192.168.1.91] ([151.51.238.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afe9e76f15dsm21014066b.62.2025.08.25.11.31.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 11:31:01 -0700 (PDT)
Message-ID: <7977a3d6-da86-4270-ade6-e558d87422da@suse.com>
Date: Mon, 25 Aug 2025 20:31:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250825-whitelist_file_attr-v1-1-60c6d36fdb39@suse.com>
Content-Language: en-US
In-Reply-To: <20250825-whitelist_file_attr-v1-1-60c6d36fdb39@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: whitelist file_setattr/file_getattr
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

Merged, since it was mandatory for correct statistics documentation.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
