Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47009C369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 08:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744707068; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=bOns9FhxXmQgcCNLgHL8AOgBWuvIOqwcU/aCtOV4IMg=;
 b=nf6cu/NoCWQPVw+0K4z/+r7/w1mCPJoIo6Y7YBKCQUH7sCIwcFdReScc3fhlhL+EVSrVv
 WdP0GLHxSJ205sNPJmVGSfnL4SSxk6sU1nJrFWvtdx0cSXxP3j8AG3eWXTTKb9W0LunxiqD
 lIShjTUE8SQoL6vUmdmJqFF61I7uGuk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48D4C3CB877
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 10:51:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5310D3C6792
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 10:50:46 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BA3061000DE5
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 10:50:44 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c1ee0fd43so5085075f8f.0
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 01:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744707044; x=1745311844; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7HZ3/5MF23z5Lycie/MPfimq+WxVMAVY1W3E5rTj0Qg=;
 b=Ah5V4xyGMEqCLn/SRKrLpzjSWgPPJGyiHyX41RVHPPytUs8i5iB84053ygLpwJpfQs
 LXVEoSf6XtkY3c1Zw8TyZkzpQ9Hq2H+p2UYyAWkKIkHQFOX5eFgR5aL1WXqNlfBIj1Ts
 HBHverEZWSeAEbVhr1q06Kw4FZJxXx9woIe9iZqEjYlKF7PRqWddcNl2K8DI6T56cRBM
 G42aE/pYIPzhi4Cpb4KRwZcirwI3GX47+gIjyiUrWi14jmxFOPLzVrFDvsf643NUXcQO
 aFoUQLyitLSzoRd0dBRbgy7/FzY9WidJVh9Q8vR/yN8Z1MMo/FEC8IriGyzXyf+2qJEg
 wzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744707044; x=1745311844;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7HZ3/5MF23z5Lycie/MPfimq+WxVMAVY1W3E5rTj0Qg=;
 b=gsXYIHbi0nKm9FCLZUT/Fm/xP+e5+Q+1fZvHZ1S7FRaItvnSZaBh4CUCZLMjEyV2VY
 fLk4EDgqrOlxSs27ACzt79cEswTWzBB5KQdPRIYZu0lM+SBJLXGBwajmnNjGxB5IfQwp
 hm3zq8+iHPFWPVfeZfmKLGPB/AEMDD4+gEmFZjjB/v8PgROJNAEduWrTJpNGw+EqNJEq
 h8PqX7B5ki0CDcyWxHSk0bf3RC4w5WdiE/g/meDH+Tv//R2PrUw4OA0xMFjRLwIbDOFC
 H+tQLQ2PEWSmvvtl+BbjY3fzCa6YTqJf2J7etpqDGRd9yNkGQdFfQjT6omFtzfYJTRyA
 HIwg==
X-Gm-Message-State: AOJu0Yz7qpVmkwPWKyMJqi3SaMABp3N5ngwrLCDgyRgyiKSLh3t5vu+e
 YohX5LpEpUBSc0ABCAADcU9Ww2vy9JLv3At50ID8ahn4afvUMqhIlXjR8A8BjDY=
X-Gm-Gg: ASbGncuvvPXgdf6tuYzuGslRslr+7hGwUdojZ8o75CtOlHFQUQdoiUWxZegOnK0hV1r
 UgUnyVakh9tX6e16TKUxqn4FyTrAfxMwtIqoFVhBdUC8Dt+Z7ZWz8vAIhyoERvzkOsX/Mk7jyYw
 JdxicBl5KoZI4Azj8eEU8mDjHQtkNNz2c2yppFHX/nhvSKs4GRCwcZjw20tiHVqK7XH8LHpc3YR
 GEgiw+/4m+cOhQIRa8Og6xj+VajjXNUNs9XYc0cc6aCKIz0dXvq7WI3wckDj8/fDipZv8IqLFJ5
 XOhWDZlyoZ5CSH+9PiFAQ+HPyA5p/UYvtsPQ5WbtcMAR7NNEW2rvUivmWGEZ5+EUBzPzh6+2Iy6
 EES0J1g2DqtCR/3qlMqGgnRFUyATg36gDh0M6HIEDlqetfIGZpq4Nco15Jzm1sew/QGm2OqM2GP
 al54Y=
X-Google-Smtp-Source: AGHT+IHlEnJAmZ7vHH0d8rt50fm1Kc7w8vo4l7rquLMnSb5tDD0YMLGlFaEezVoOOIwtm3HiIas4Ng==
X-Received: by 2002:a05:6000:2282:b0:399:6dd9:9f40 with SMTP id
 ffacd0b85a97d-39ea51f4291mr13044889f8f.9.1744707044064; 
 Tue, 15 Apr 2025 01:50:44 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96cfdbsm13353977f8f.40.2025.04.15.01.50.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 01:50:43 -0700 (PDT)
Message-ID: <c7525a80-2415-4773-ac9b-f82e1e7978f2@suse.com>
Date: Tue, 15 Apr 2025 10:50:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250411114326.526-1-andrea.cervesato@suse.de>
 <20250411114326.526-3-andrea.cervesato@suse.de>
 <20250414140257.GB443040@pevik>
Content-Language: en-US
In-Reply-To: <20250414140257.GB443040@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/4] ci: add patchwork communication script
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

On 4/14/25 16:02, Petr Vorel wrote:
> Generally LGTM, few notes below.
> Feel free to ignore them, note at '-e' and '-z "$run" -o' (at the end) are bugs
> worth to be fixed.
We can remove -e, but what about -x ? It's verbose, but it's quite 
helping in the CI.
Maybe I can just set -x before running the script in the workflow.

The rest looks ok.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
