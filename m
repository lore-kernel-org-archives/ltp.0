Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F5F60A2602
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 19:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=dTYuqqn9;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=X8NvGgo3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792439811; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Tno06zCkVOAxmt3kgrrhUp+x7BE1c/LcDtOj1PV7+9Y=;
 b=dTYuqqn99VPvcY6vzGlasjaBpcqquaZ3OIfP6koEJznjUCeUeSrmM94KIftTX/HwTHT3N
 DwSjIWA2PtoMfiisodpJvOvGvx2AliGnYYzz0xfy7P7qfdWnX4C9+A1p9ZhvWouKXxCZ61r
 ps0ulEKoy7ZOTJ9nJ85SfkkgxdQBR+s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 669073E9E13
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 21:56:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0A2B3E58ED
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 21:56:32 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 30A36600756
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 21:56:31 +0200 (CEST)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-487049569b6so1350152f8f.1
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 12:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792439790; x=1793044590; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DcHkyqFXT1xe36fvKxDKnxC6Rfqa1aykIxuEQiZgWLA=;
 b=X8NvGgo3dIs1C4rvdAgUvTL4wPJVo6KWn4IyrrYv6BUgeIMVspxurOVcFV/0S6crhy
 +XgYAuvUSqXsaWNXKJ2GrVpE+NSAlLR40KRWbEU7otURmOozTAXgIqJV9PfXLeIoRJ6U
 C7We6HKMqSmKyNMzfkvaTJiZIFyEeeK6c0deC0mzyaSdTNufg4UvanShXASZC90JWcOy
 Xtri3Fg9Kqjhoo09Pwdn1HXXaK5syAAAYV6zhtHm5lWGLJivrEKtdvgiNJcAkZz/zlRm
 +usTzV3CPPPnCdd4rcLm0oBx6pNM+l9hJrIVC81BKT7sW6eLwvv4IzthouLHaCxuR6T7
 vX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792439790; x=1793044590;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DcHkyqFXT1xe36fvKxDKnxC6Rfqa1aykIxuEQiZgWLA=;
 b=Iz0eLnOV741F971Gk3iSH7ydPAAFrbR32pCPmv+rnQeZwmbkKH1rn9sK1YyE7GF30B
 2vEqyH5D5plJk2DRMcCclaS9vuPYVmogSw6QyHYstIz6lNlzsRYexdl7Stzq45ONQAIP
 37XL/znOcFGU4+4tOJ5NqmWhqGT2j+lzWr5w0Uzz00RDDs7ZGgUfhTJo7Sc95OnQkoGB
 JoPmuaJ5BhyD9b+1sf/rU+XmacyyW2RPAicQNfkowI7Ihf/qczfWhVSUMoz7dMKzBUIs
 gpUuauVcl8kIqhg3IWrBmxftLuDWAnL5PIBu/I5oS5dOKBQi2EwXd00dguygaaYH4t+s
 3CZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8gB69tykVmaTBNaWHNpWk2vrr9qoyfNO4M5jobMYP4iZUmb9xwHq6nRiIxwxDmIjpDnw=@lists.linux.it
X-Gm-Message-State: AFq9FYL43ddGsmqRZKqMfgWnqoGeKyN47KVsaZhVhk3unrx2DtiXz1uT
 rQlaGd5ANN/4umU6zNnAAcHwQIVDCMtpq26LZ5m4rusyjA1Zcq0z186hSb4nxrJjVuw=
X-Gm-Gg: AYBFou0e3ulw7ruQ7NqpegALOvwO/lQML88Txka4sLLhCkQ3gKuEkSBVEkLBNKXQ0U/
 C0LUOT4rFTOVZ0lR2+Mkv9wMVvaRC58sCs7srmwWzrLjxrap4t7N68gJP+Fc3zANlpVMrGhRthG
 ybV8X5eHyX79l3PBOHLL3p5V+HB+OlUFD7XmvuvX40Jl5ATV5bnMpwcAVzuO5XKcxGxQKs1X6QK
 NG3ZE+lCAYRVlx8Qz51uEjmRd7FpI7/asHZN/9uy928JBIVnGurKZOwrkqp6xuRGED/yoK/P0Wv
 wvlQl/FlJCToRIp4b04xCRBZ4cFYlkqzlkcS3ymR947QLWBmkpD7SudGu5Ua2PbX75JfzE5GHVn
 Ncl6GVKZ+3Zz44osUb3muAjGUxM6jiVIo7xI+rZs7bOxKHUScRCWshBrlffjdw+IIDTFHWTcv7X
 gb7MJsDOwOVbPxZXH3LKurOd8GmmTbdxBZ5rvv7rPQo3XNaIB/QG7YxkD+6kEStMHx6tUQ3wP2L
 Pv6/A==
X-Received: by 2002:a5d:4245:0:b0:48d:e5f2:e517 with SMTP id
 ffacd0b85a97d-48e07fbc6ccmr13119736f8f.54.1792439790439; 
 Mon, 19 Oct 2026 12:56:30 -0700 (PDT)
Received: from [192.168.1.109] ([176.114.240.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d80f9b3sm979366f8f.20.2026.10.19.12.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 12:56:30 -0700 (PDT)
Message-ID: <505f1917-c99d-4de4-a32d-c654bb1c5b37@suse.com>
Date: Mon, 19 Oct 2026 21:56:29 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jan Stancek <jstancek@redhat.com>, ltp@lists.linux.it
References: <dc45087f4a5dd1700aae6df3a8181ae349f2bdfe.1792413269.git.jstancek@redhat.com>
Content-Language: en-US
In-Reply-To: <dc45087f4a5dd1700aae6df3a8181ae349f2bdfe.1792413269.git.jstancek@redhat.com>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] float_trigo: Fix acos/asin/atan input generation
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

Regards,
Avinesh


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
