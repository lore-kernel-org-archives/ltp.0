Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F39C19F32
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 12:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741176705; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=Whim/obOTt3qTK50GR+CwYeleVV0/PUUllYDQIqpmzI=;
 b=P4hNHeo2FuAJAnM9dsbUrJG/SoGWee1+jHII5uP/TPcbwXOcA42O5JQBPHYiGQf66QZdQ
 fgPW0Or0oWsv+owvpYS1BUEa7T3YWxGEzs7miIZvzI/8SOrHe5WjybfYV7PcHfX+IdbWmr6
 ow3nZ9E9/Ubt+g/Bl3E0JftIyAtQHbw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDB433CA0A1
	for <ltp@archiver.kernel.org>; Wed,  5 Mar 2025 13:11:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21E963C1B9A
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 13:11:23 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3C308636634
 for <ltp@lists.linux.it>; Wed,  5 Mar 2025 13:11:23 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bbc8b7c65so36633265e9.0
 for <ltp@lists.linux.it>; Wed, 05 Mar 2025 04:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741176682; x=1741781482; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWp/nUBfE9MziBSS/25Krks/++BVUBk1WrytNfYiTNs=;
 b=WSLYmpVBIl8FnSUFshWSFL+sxy8KZV31qwF6lyWI1OwjfT5DBG7kKDqK1IDS/pvCy7
 z3tAjv2eQv1qVnK/JppEJ6MllEpA2vKkD3E0y+fbEDn8NR82ocDwTVg4GgwaclOf9x8w
 zpDfHwnA70shoaoYfxovMJeurYXxK8Ax7sKs7y6aPHcPGd1Ndykhu0vc2RKQwU84ni3w
 H9ubXJLPucB++be0Oa/7gqdqAT3Jy7VrAvut3DgmH9NGy2coigsyVp1T7k9PgqlKsvbo
 kd0IPeVmpqPUEk6OLn3ALrYBW9Kv1JXWz8yZqn5p99PE2NNp9IiZn0Q4eu3+a59//bL9
 hWbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741176682; x=1741781482;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XWp/nUBfE9MziBSS/25Krks/++BVUBk1WrytNfYiTNs=;
 b=c9AhUp6mX1qKPbce+ElMi7K56Al3YUiVJ+5FeshujjhyE8y936qXUSXOYWqvycpf4I
 hl3GNocuJq39TqLbO2jEh1UEAwp8gV0a9Tg/JEtjeVBXOOlZgKYTPwvWMYLSUyQQhWhZ
 1k7STMatsoISnV5pRq7O+7ypmJ3JyTOt5W4zxvOPU/AxY/MKd+DBgo//moVmBF9eLuHL
 ovi897Fz/4ZNbLuFYvu1SD9eVpAUYqGvuIGGIDJi0S8ktk6Z72/j31SE9L+Xq05g052b
 +3l/Abp1gphlBx5Ka30muyyb0hVbdSpAPPBfDX124qDYMX6vj9hoU+2S/1uxIbvDhk/A
 QqNQ==
X-Gm-Message-State: AOJu0YyfjvTbUe/mZi/pcW4JHXa6cRU1pDEYmKgrarGEmdrMO3bOzyvg
 Bi05l/Q3p107rvkzsUem1xCGJq1ZyAgRaNfsyNMXvLpXizI80RYnn8vJDVtSDCg=
X-Gm-Gg: ASbGnctp8xzqFUAvqkboqbHD84RFY6vDQzSeHLQdUnyQMm0fvLvaAV46Y4g+Jaf8gQM
 Abm5ZzVNWL1jZHOJOoRSYmi+KXVUarkz19r/4rF4DdAEN1BuSnxyBtQuM7r3VQiAYWRkYFl0mcK
 x6e85+Y4edIQn/X26TwgxzCVzH5mMg4/Gy82X1jCvRsEj3BFaRKu2sRXP0N0fiTXVWQsk/Edn0j
 MgBLHA9GzARlPGxwrhyPedfca0QLByDpzolnc54xhvg6SCkwFD+JKvAgc2cDOclZ8TcBlMfe5aj
 5oW05ogSCKijqx4XjgeBl0QQ0gffTxmYq77g96c9x9y6mOjnpXr8kWc=
X-Google-Smtp-Source: AGHT+IG16QiYthCdvEsNMIMI5XFWZ2lNm0ZxPLfUEd+66fyTtpvI9A9M0QMY+ucITOLQJzuZw0V2XA==
X-Received: by 2002:a05:6000:1844:b0:390:ef45:1a37 with SMTP id
 ffacd0b85a97d-3911f7cb125mr2295764f8f.55.1741176681022; 
 Wed, 05 Mar 2025 04:11:21 -0800 (PST)
Received: from [10.232.133.75] ([88.128.90.43])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7c43sm20475173f8f.49.2025.03.05.04.11.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 04:11:20 -0800 (PST)
Message-ID: <777ccd32-5b2c-42c8-aec5-8abaa3884751@suse.com>
Date: Wed, 5 Mar 2025 13:11:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>
References: <20250304034348.23389-1-wegao@suse.com>
 <20250304040601.23920-1-wegao@suse.com>
 <361f2b39-3deb-462d-90fe-4f2ee2de9b60@suse.com> <Z8f3fbHD56aJrsMk@wegao>
Content-Language: en-US
In-Reply-To: <Z8f3fbHD56aJrsMk@wegao>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] unshare03.c: Add test coverage for dup_fd()
 failure handling in unshare_fd()
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

Hi,

On 3/5/25 08:04, Wei Gao wrote:
>>> +	if (!SAFE_CLONE(&args)) {
>>> +		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
>>> +		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
>>> +		TST_CHECKPOINT_WAKE(0);
>> There's no need to use synchronization mechanisms because at the end of the
>> test we call tst_reap_children() waiting for all the children to be
>> completed.
> There are some race condition happen and trigger failure sometimes if you do not
> use this synchronization(Currently no idea why this happen).
> Rerun case 30 times can trigger 2 or 3 cases failed if not use synchronization in my env.

I'm really trying to reproduce this issue, but I can't. Run the test 
with 100000 iterations and it didn't stuck. Can you please check again? 
I tried on TW.

Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
