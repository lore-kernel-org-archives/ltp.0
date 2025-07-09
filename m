Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE20C83F03
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 13:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752068421; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=07rZLFbTuCrxqUru8beQjFt+RlOG5FzPZ10nV81tVMs=;
 b=RP5tRCsHG6hs8FVuf1VM+1tWN9ZdYx/VMGfGsQvgAD5BxBF5kjchWRoQZsewCsl0sLlbJ
 tk9HjEVsprRSejnqXPWPn/PSeIA+RdrS6mXjOUxJikHsNVYexPOmSPYp6Srwivb6+l+HaBW
 +Snt1QgAlxUKTtQ49Xr2hhgcE/O7+ds=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D28853CAC6A
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 15:40:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A09A3CA066
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 15:39:59 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D513460026A
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 15:39:58 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso7479305e9.0
 for <ltp@lists.linux.it>; Wed, 09 Jul 2025 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752068398; x=1752673198; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0EWhJ7au8HJrxEBjewO2J427zxG98QOihGuBzmImprU=;
 b=PUb0S1iSTD52hJt74Tqud0rCaalFfkI5zEbtnwb+4Bh71Ehn8FrXxNbroQbf7Py2mz
 GNwe6cSlk6bTocs69kpBajZI+AGY/29ZNwzCy7Tb/GSR6FCSNfJ8td0zdzImETgkkEVl
 2pYEGQMbq+TzZOBDcDDgdlFHCw6dnPLx79RBw2BTm/b9rlBvwT9zO1Ybc8LFE+Sp+1Tl
 KUFunntgNMY4tl3XJ2zduoihY2sxWEDMDWfbQ5su+fHZ4qoUgodqbl7izmOd4UilcgKz
 pSs5ln3i+YVNkyKGxFXWW4YNWIYXErdEOuaBfTK96x655/n32Lxe6VsC01WA25icv7fS
 HSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752068398; x=1752673198;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0EWhJ7au8HJrxEBjewO2J427zxG98QOihGuBzmImprU=;
 b=NRAM22FFqFnMW3PA8BkZZJohUNfD3LD5RT7BUQyPOi1xI1FDTcJzWI1e9aVgCE5UyA
 NSgCXiBEvGfkQPpCDPJMSBWNWAFimb6rK4nY/pijUeEV7V6MrITT4HPSX5c3Tqyz7Gd7
 jZFH5dskmeuAhfXBbPHeSHhtI60IotvH3Iowo1xIGbGl0xF0GLmzuwXpn4wYI51Yg/WK
 1fna+5vxbYZzWInrJpsJhpQGJat+kLlC47ke+uj4Har/vPYN/y+7lRvmZjmk1zqlga+q
 o/aSX75D5d7AO/DaKO3IXBH3ZYT1V/M13vyVEStCrbCvdcxwvt+/5jSCkimiBhCmMTzN
 5UOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnBzStq6s/lZSTf0xoN7+drR6z5CpojX3WxA3KZFc5h6UGsdRX5CrbLmL6RVqPM3SwekI=@lists.linux.it
X-Gm-Message-State: AOJu0YxiUNTEukIjszfD81DMJY+TW/4gt5lpyvmeDOQD4QI049+4RmBl
 /UKUNbzg0f1/IHLAhERnt1c5zuuAdCXXRC6mkcAAosowAFDm5iilgCsAaMHnH5Cdqwo4AgZT72Y
 XlLQ3OseSHA==
X-Gm-Gg: ASbGncvSLr90L3q3xUbyxxrnRJJYwanyVzEfJVd7f+5m92ZWGsTHKKXCyd+R5fu2IUN
 I1kJtWH5kfD/2DmDNm0l3E71cIvdrMpBLRTianIfTdPfEKO8HPp7ptXW5wK/ZkkFYT3HjusTe5R
 bRe5itmhE9tl5xYbDCUg5BaR+xTYHwYr0rmVgCDa/oAjJ+CpVOqf6PLijclikML3xC7NNidHpr4
 X97AJRM905RB5/onBoN8ZSj6xzOsbrvPOY41a6KubGoH33a6b7cIclQ7gMl2EBlYWWxYlQZssbc
 hNG+x1AUz1z1xAY2Wwmu6/TOID7NN9b3xm3xvwy+3c13mmSdDqzxtSoFPLfNdl68hdF5YqX2x9N
 1TAfDu3Xv3pQtjUe8x1vyOhohRVfmw4ujOedVP2+33XFbxtqCHj5GAj15In6T7vLK0AnLJcggtH
 2ZOFdOO4jI0nI2GupkxLb35UQtOhfkDXIZjQga
X-Google-Smtp-Source: AGHT+IEdK7quw6KPOHvlJ2PWMjzIWqhaKgUz9lywrjMhv3kAls36f9Uj5mcDbTgeQu8cZi9v8z4yxQ==
X-Received: by 2002:a5d:64c6:0:b0:3a5:1388:9a55 with SMTP id
 ffacd0b85a97d-3b5ddfb8af3mr6264183f8f.5.1752068398110; 
 Wed, 09 Jul 2025 06:39:58 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b38ee62f8bdsm14418711a12.57.2025.07.09.06.39.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 06:39:57 -0700 (PDT)
Message-ID: <ad8919eb-5803-4712-8da1-8744cfa76053@suse.com>
Date: Wed, 9 Jul 2025 15:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250708-conversions-mremap-v1-0-aa043b0182fc@suse.com>
 <20250708-conversions-mremap-v1-4-aa043b0182fc@suse.com>
Content-Language: en-US
In-Reply-To: <20250708-conversions-mremap-v1-4-aa043b0182fc@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/7] syscalls: mremap02: Convert to new API
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

This test has been already covered by mremap05 that you are refactoring 
in this patch-set.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
