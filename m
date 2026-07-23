Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A7DC531CB
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 12:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784810627; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=3dn12aYibQijmecL5tmGCptp4ufcGv3/ySXm8nn04yw=;
 b=gNOwid8Xa9OUfjbc4VWlTEwRjtMdbf7gKFHYQNtGAkAK3gn1XHJvzuBBqqcKdHSCDFzR8
 KKhCwrngcTVapMYqK2Zc9FHfN7LcJK9IfY3BmzLK/eXm8mocM8qGSPjqNdRYyFMgozOVtxD
 gynTIz/YyGvMENSGRa2adTYIXE2LaCU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F01A3E1C33
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 14:43:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67A103CE5F9
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 14:43:27 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E01C81000458
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 14:43:26 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-47de008b020so395837f8f.1
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784810606; x=1785415406; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/ByoqyQlAN5FgMcRMvCqsiJDcImoZV6iAZRvHMS6jVU=;
 b=JBw5nC5+CdOyEEuW4hNprthPYi4U3hXxSDoY0WWtd9LiLDYIrpi7iwkss9Zmlc/XYk
 Hrk6zVJ0rXA++JikvMVsieF0NzoJMSfcUWIR8ITcp4yCNZeEEDQyq/2T4XEQCdJND1nM
 c5t1Vj5V/v5Cqj5MBSQ/dFyUt8ucUhQvu3QUBBwjxc4kJ4fSLoMHGNtzE7+ey7WSL5FE
 GjT90xxGvEsiurybbIdBQ3PKpXoVVGVKJalq8BbqS+eNALgvMcCxz5ODmWf+hp6KCOiZ
 K75l7AmpTACMytqda5QRgqzwhU0NroijTkKm1NuNw6+Db61GbNCu2R7bHEO1JuCom9Md
 VKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784810606; x=1785415406;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/ByoqyQlAN5FgMcRMvCqsiJDcImoZV6iAZRvHMS6jVU=;
 b=XWc1YCSO9suTj6+lVx9BXFfRL24CVIdy8Db4YFgUxRD9Ngo3BwLANUknk9GjsFk81+
 SgnluCv/JsFQMwbdGpHSqvjXX+T1jsd1ML/2+oI2PtGGjyllL7Rd+9cjqpf2GKGfxXfX
 DDt6X/U0AD/TFJlNKO9vn5WkmNCYGSbbuYJiNXtnqb7EW1rXSRe/owr8RTuEtMWOvnrI
 pHhS5FQn2AXK19nLGxDfX8JtcYPNzwQz3Zb36FQrjHjKVRMLGMd1nQ/H2zu2kMnc0chY
 yo5pYASJpTaxboAqFIImAJlZAxDYyQNhzHTsSnM/48jEJazNk93BNj+eIPpV4CPlPqSy
 gdPA==
X-Gm-Message-State: AOJu0YwRFQq3a9eDy+KjP4z6x1wrRltadwD8ACLAYG53xaDe43jCVIIs
 e/GHIAbN0EoYBoU+X5ajq7e9CR5B865tevgF8D94MOOrm73aM9DlGdcDBlxLrXaNQxk=
X-Gm-Gg: AR+sD11t5RDO36P3N9H4KnqdE2wvDPeylhPwLDnv1PnQ5k3uR8SdiYaGuVmL3ryMaVf
 dgkt0B4/U31Aff92dnpcP/WOFWFdynIrb3jVXXlTOWM6WdDt4lFTtvxU3kPnmjRQcg9lOlmOqMX
 8i0OWhkNeK1C5dUHXROxBr6d8IRs7NsNsYnaTvShqsbrdX2EZzirWZkdi6mnV+vOkEXQThaaUkg
 S0O6LlrTbjKmtn6fPt8DeFsMYjdTxrpLRds3vbbWeGHXaG0E6mZHIogbsw0rMQ1JIPyUkM9lAOx
 boniRR2Si4O4vjzOsIJ9OMXpvcBv6IG1m3Y/3qGReGh3pu2sSCNuQ0t+y4n+u6F/JrVYbD+ul/0
 2YV6Zo1r4dkbQJnzhpkNV6FWiEFdyXS+SL/8AHMJkxMwS/iNhrkv5nRQ1vUmGra89zRvx8pD3Qu
 OcLZnXbmVn+op36Rz9Sr46KQ+iRg==
X-Received: by 2002:a05:6000:25ee:b0:47f:93e8:af81 with SMTP id
 ffacd0b85a97d-47f93e8b017mr228090f8f.10.1784810606218; 
 Thu, 23 Jul 2026 05:43:26 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c66cebsm14585317f8f.30.2026.07.23.05.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:43:25 -0700 (PDT)
Message-ID: <6a620c6d.d5b2c389.2916d0.903b@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260722044732.3547-3-wegao@suse.com>
Date: Thu, 23 Jul 2026 12:43:24 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 2/3] lib: New library function tst_get_free_uid
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> +/**
> + * tst_get_free_gid() - Find a GID not assigned to any group.
> + * @skip: GID value to skip (pass 0 to skip none).
> + *
> + * Scans the group database for the first unused GID starting from 1,
> + * skipping @skip. The @skip argument can be used to ignore e.g. the main
> + * group of a specific user in case it's not listed in the group file.
> + * Calls tst_brk(TBROK) if no free GID is found or a lookup error occurs.
> + *
> + * Return: An unused gid_t value.
> + */

This documentation is out of scope and should be sent from an another
patch-set.

> +		errno = 0;
> +		if (getpwuid(ret))
> +			continue;
> +
> +		if (errno == 0 || errno == ENOENT || errno == ESRCH) {

This contradicts the patch 1/3.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
