Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E4B0E9A03B
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 11:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771500919; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=nU8JlaoQhdbGdxEFIEuoeaoFdRRhgLJhgRVHDEwHl68=;
 b=njmOvxEqMvWtKYUinOpLSpIJprnfiWYpBJlva9XotyHCYrcki7dT2p7hNTU1t4hY2GM7V
 iNXwSES9y9+Ji9kDh0ptGcqeRkO6oLLig6q9PWgEgpfgWDN+UUjF6ryN/4gnzhH2uxu4MgK
 c6xRhcklNR5zsZGQhTSXvdBN23WquoE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3D7D3D073F
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 12:35:19 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E41E3C634E
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 12:34:56 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA68760044F
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 12:34:55 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-481188b7760so7199665e9.0
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 03:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771500895; x=1772105695; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RzZjzdEF+4BzoEug1N71sK5Wmc/dSRqCr2LqY0FL2k4=;
 b=Z2qNyFEujVFi8Ptq+uQAGNMIV2wsLJe7MUuN/l1YvevYbk58edCS+6Q5ViTaGZ8GPU
 0yKzDQIqsijg3mN2ht8hOXqwh4ZTTp6jgkr8kc1s46wn+5dxrC7Yy46d0VNtwyRSxmfz
 bwZe3+SF9m3xykaFH+Vmhnc85BcjsHvjDh4wg5ZNcj7wTAYJYWH/ofPPJ6ae0OpzkpWF
 IxBDpa+7f+nxApJLAVVBfIO22y3jiM8KgjWoQYPNb7LpJ7n2zN73N/APUY1xEkgQhQbU
 IyA+eoIXn6C/L0u00zA8xqiQjj19/l2VI8MlKfC6Kd1GjPZdE3gjdg7oyPdPg5uL8Wbk
 3NNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771500895; x=1772105695;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RzZjzdEF+4BzoEug1N71sK5Wmc/dSRqCr2LqY0FL2k4=;
 b=YheentXavrsaPWFXzQ8WSOLA6Px3LlU6N+bbgH4mdVBTrOvzwsbRmq8Qwh8ev4grTy
 VW4NK6gsJ/40jnbyIlUwetVrkjcIrds5FkdzD8JTAqBIM1BbpzVl+PqMuKjkz5j27oDV
 u9W1U7/xpK/qxqPJrZDK2RS+MoKMW6oUziT+O2qcJr8UVoYs0ikiS7JJcuXUdVyDyahB
 1er0mbm+V/53pJvlqYqjNFD1I75P0nsdXwGgYi0uKK3JDnUQx6FEQ3CMwRLILKaKF2fo
 qQ/SbsWRgKP+5uJwFAbI5/TNEkInbDLtX2ZC87vNVipEDWy26BsJPOMuy+WLP2MviSoK
 LRFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP+P0GgEmE7SBln/lZzSmqMaP0Yj2efMG72L4NHnO0HsTyPBUX6GWJ/0AORoh3YyDurm8=@lists.linux.it
X-Gm-Message-State: AOJu0YyEvMwKZlqr3v5Sw/IMOgNJzYx09v9cYz3PR/Kd6yD8+CBIXqc4
 Cco4IosR+6ARh9wN61sXK4j3xgk903k4/EXCeeYwZ9CCxdQchB9Nxnj280kC5KsjvbTisNCymye
 77ygvEFU=
X-Gm-Gg: AZuq6aLKcyQzuMUGBk9ULr9nXRnMt9fn66IG37G3vvzJaxC9vgDn1V7bTPoH/Wzq7Yj
 WHzvDUymye3OiBZ3Cj9/dQJ9hkBhp4jSrhj/uXQ0yXD290pOgGVFd6CoMwa13JuiKXc1b71oxN9
 7G3oK+GjHaQ6aFjvQTBTmEPgBzfYryJQmd4QYsmDKR9YXnWhIzmuZRLV+1xyN6G9BmboEQmUWrh
 vo5EBsKdM8fFieUlmAjUINDYGiX6qRCT/0MLM1ldmdpUllR4xzDTlvBl+ecx6Glrsn9u9vpGCtC
 GU91msGxEwXSea9ujzzqdQv4lTR2gKlD9q8vJCbJkBfW6Sx8dMN0A1RpexRxl9HckSn+coexn15
 tbhXC76L4nxJJDoU+8PbfHXadF3aKzklcZX3+dAd0dzJiok9BBO5pZgl6bST48zbMOIluK+klDs
 g4mMbBvfFVCu+91Am67io+Vj50
X-Received: by 2002:a05:600c:8b35:b0:480:49ce:42cc with SMTP id
 5b1f17b1804b1-4839e63e74amr41121015e9.9.1771500895068; 
 Thu, 19 Feb 2026 03:34:55 -0800 (PST)
Received: from localhost ([88.128.90.50]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483801ff9b3sm370730415e9.13.2026.02.19.03.34.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 03:34:54 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 19 Feb 2026 12:34:54 +0100
Message-Id: <DGIWNNWNF5LV.1P4CJX8BP5CP1@suse.com>
To: "Ricardo Branco" <rbranco@suse.de>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260218135026.159676-1-rbranco@suse.de>
 <DGIUIYEL9H07.TK6CF1O2WP7H@suse.com>
 <8b371cb1-b612-46c7-8cdc-8d9e4da09109@suse.de>
In-Reply-To: <8b371cb1-b612-46c7-8cdc-8d9e4da09109@suse.de>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] userfaultfd: Add test using UFFDIO_POISON
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> CRITICAL: This is not a prep-managed branch.
>

That's because you didn't start to develop this feature in a `b4`
branch. The tool requires `b4 prep -n <my starting branch>` command
before starting the implementation.

But this (of course) requires `b4` knowledge :-) I'm planning to create
a small section inside documentation for `b4` usage.

Kind regards,
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
