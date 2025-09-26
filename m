Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816ACCAC5AC
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 07:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758872027; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=115rDo+6GTGR82DPJiXZD2YPi9ETutDYGYkrFYV1m+E=;
 b=ba9pBlpwNLJGF80xRBj9RM3Ev+Jgycx4qLYjDHhcX7vIRusCVuOF1oYPuhgOG9fvE8Of+
 ny16yYu7VvIH6CF2wocqaiV2Q1ohyhwsbHMNIj18EqTgJ1tIWXFyrO+Pvrll/9Lgzvy/Hy/
 2PRqeRyGCYpDNdHENI1LULZHnUUV848=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F08003CE089
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 09:33:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D69B93CA9B9
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 09:33:26 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0EF3A100023B
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 09:33:26 +0200 (CEST)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b29ebf9478bso244584966b.0
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 00:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758872005; x=1759476805; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zU/zK4qx3iVqfpIFuTKPEh6aCorMWt7Hsz4H9r87rFU=;
 b=YFQCOYGGzdgX+yg140dKc49ROg3phQlIqBz+NFH2yi3Guj70kn6fwVH5LKJU0hqrrX
 tn0TIOolJA+sAXXaUV2H3X0igwb2mYQQbw2wnLiAIsOZUFjnZ7I8K70GQglzKEYvc5RA
 NHOmQcqyDpgMwvVT14lqUI70YZ8/ByuAgsQ47r2VxoXcosLTa6Fc4pY+A+0cFT3t86vh
 ADteWPYIxs3//mhGCFN+tIdChAFYd4YVZaxS1HQEMLaGgeeS9AgWM2SxSwUeNHpL9SRH
 nCq2KOO58qdv41cvnbf3QRpoAYITcVg2s/QsTPsn1+ArO5hBMOHLDuVtTEE57CHaenT7
 fW5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758872005; x=1759476805;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zU/zK4qx3iVqfpIFuTKPEh6aCorMWt7Hsz4H9r87rFU=;
 b=oEidG7SAWaKwN2aHRzJkBk0LK3LSjYknocBCR626xl/sX3rmUHQVsodPtha87ZgwRy
 KD+i09gPNPlWozBUtP39qBYcZq3pMg/4/qbtyXto5uUJIoGVt/vO/NPUXkVzzLlJ5NUL
 keNvoQh8NhrvW1dIxH5xXznwizDXhzdtEWUaonQXGef0AvpGL0Wlv8y61SHjHN9Y+fkW
 kjKe1myXT4Xmriitd9pB6XNbbX6CBZqFCDSSD0FHME4I+HdhxJ99yB4Ycu/Q5R5IEHWV
 6BrKHbFrL/ukp7pam8ZW7sSDQADI3h/EdJ2ndAI8Xpi88UaYvYjwOdBgepfErBzZK6mh
 9nwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr+hsTp/32EJNS1bnbM+YAGDf76CPS2rEU4F+s0tmNLCzsYJjNuxEgVRf3X3qzTDw6Lf8=@lists.linux.it
X-Gm-Message-State: AOJu0YyQJib844+mFVLbHu8A57fjHjVD1piKiAzWZdV0d6NMwh5ceg+x
 QEENYl42GR5SvLt+eNbhThZON2pDeU9C0GdfADyxtOxYHt+C63hsmo1n8Of2Z0IyQpE=
X-Gm-Gg: ASbGncuSgfEgpMwEd1kGjERBSav1C6QV72CCiNuE4WO037ZYWIP+DEtg3HSPEL6chfJ
 oRgNA/OWt4f80u+uf8OhsDgP1OVmZMSjq5QUg4QjNFi5td5uQwAV3yvLntO4HVwSkFDV3Hb3HZe
 APk2GEhnwRc5nxWprt0r/+E4oKt6OjubN3CpwBsPF7AA5GBAESb8Q9A7Bo8HAX53vVMCALYIUY7
 kS8wqK28+wdgLpF5k46enjh1+KptqtS6n/1Ra6DbS+Ue0InxzgQBBsYhciM5BrMFxySKKG5FxDR
 NO2rpQfNmsq0dR29afaoCpamAV6ybhs0Zl5rNAPBWHMa/l6KykuPxPYVuFh+x8ubK9zN/CYDLhV
 MUYLaDDgPLbBmtTHFuDqSkKW5c4D7nw3uO0sn1PCu9zf6tuIDQrFqXr4eMn6kHtk4rtkQsVoG1n
 n7mGOBcn14X2InvJeyvTQeYcnN5TfjkATbL4DkrtiMNWWW9oXzHYSc2zJ7rtXJf2c=
X-Google-Smtp-Source: AGHT+IFBajcNLF4+B1Oh5B1gHddqAt1P5PboKRL60rtI6Ta6aWtKzH/bwAeqsk+012tSlouCxMZXLQ==
X-Received: by 2002:a17:907:3f0b:b0:b29:64e0:fb2d with SMTP id
 a640c23a62f3a-b34b86a11bbmr590564366b.22.1758872005302; 
 Fri, 26 Sep 2025 00:33:25 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f17:6d00:961b:d261:4569:b9c8?
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-634b46dca59sm1206961a12.8.2025.09.26.00.33.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 00:33:25 -0700 (PDT)
Message-ID: <d39802b7-6ab3-4c78-a660-34d7bc0a3dd3@suse.com>
Date: Fri, 26 Sep 2025 09:33:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jack Morgan <jmorgan@naotchy.com>, ltp@lists.linux.it
References: <20250926040707.671282-1-jmorgan@naotchy.com>
Content-Language: en-US
In-Reply-To: <20250926040707.671282-1-jmorgan@naotchy.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 9/26/25 6:07 AM, Jack Morgan wrote:
> +/* Enable STATMOUNT_MNT_NS_ID check for struct statmount. */
> +#if!defined(HAVE_STRUCT_STATMOUNT) || defined(HAVE_STRUCT_STATMOUNT_MNT_NS_ID)
> +#define LTP_HAVE_STRUCT_STATMOUNT_MNT_NS_ID 1
> +#endif

This is not a good practice, better to avoid defining LTP_* wrappers, 
since we already have the HAVE_* variables defined by autoconf.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
