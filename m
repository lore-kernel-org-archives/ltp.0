Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E688C83F1B
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 09:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752745458; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Jm3wykrZpajvVUNyxF0X9QKXiq10scp50Yu/IdW1+gI=;
 b=MVbr9tNtUzKgTd5eLRlWc2HU2kYMg+gd+dmHpNWyHrm4yLMhvWcaXdVOu8KIV3UtMwtvp
 rLR5q5jxPVnfyUDiolK1DJX4NoJRb2T21AHFsyEyrSWPhJ10UpqjC0ukNAEMBoxWXp6eaCQ
 ks6+Ru0d0ZxVybb/c7FVskG1YaYxpjU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8925F3CC10B
	for <ltp@archiver.kernel.org>; Thu, 17 Jul 2025 11:44:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32EA93CACE4
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 11:43:55 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A7A9E1A00997
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 11:43:54 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so429217f8f.1
 for <ltp@lists.linux.it>; Thu, 17 Jul 2025 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752745434; x=1753350234; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K2cbB/ViUjl6ZBeKj+JvRa2c4MiRPZXjoa3u2YXH564=;
 b=AnwdylgRPtew7ZAxA5UisNOjnrR2xPizLKKaYZcgeM19bvvlWVAk8/uRPsbWVeoKLv
 QdmDltwM/MCQp9LYewhculBfbmanJRDOlRFZbCAySwAi/AzBppdP5o5GjwBIM33NJT3M
 d7Guh6LQxFPnhEd7+JKKNKV9Opcv+Hn7xrw8e4bVChBhARE9qW9Sin5rlR8JJ8GFpSZY
 uLE/mVS0Ek5d2tFSHlB8/2H8VIumwP9XVVWGDphFcq74fgwBrmwsXumN+sbY0wzALAPA
 Ln1dp+UdNiTEqKKix/R1X3XXPGa7Ut/jJhv4+gr+rj35optri/RMRNweD6qvDh3scMSc
 DYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752745434; x=1753350234;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K2cbB/ViUjl6ZBeKj+JvRa2c4MiRPZXjoa3u2YXH564=;
 b=uVJ21hHjSXFRM7giyc602egE7W4RdwoZhkI1iLQbGEo9A9aKaa0NMb9AEo3SEPrxP9
 VpMZoNMNNL/R413r14lHJ4GSxZVDoFIVmv7ML09qR9upbEVgBhrGzqEbt1ZfTp86SOp9
 kVr6fVOU49NTRFunMZWvTf6/ZIW4glF2SVuI1xvc/k29sPfIww/DQ9B/6uABat5o3bC9
 DpQHHoNY3OZ+NgpyN1MphiWzste06YrU13KA3kACebMzCcWxSy0mI72hYD2bSFDkeLcy
 QPT+hYvceRVXg5c+zO5tezstGciXgiV4AnTNvru1lYzMrT3E2y673XMnymwsoNUgOGtT
 8XWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA2XudBav7tvNCv75nderqzGrS2X/5nHPLcALNIVqrtb9h3ZHQIEZ3wg8IbOTALCMeOaQ=@lists.linux.it
X-Gm-Message-State: AOJu0Yy4pF1JYpbUvm+77mxWDNQUIitORByGxnwKnHLo9E4FbxcKF1s0
 Sb5YP+35vPcX2sVhXj4mGkKac93P8p2fejaCZXm1q3AZdJW2P4wTX1xU53deDQ3kYdhZc7RRW05
 0eq5E8J8=
X-Gm-Gg: ASbGncsJCFDA8SO9bF6a9TCK6juCupzk+yCWTmLk73em8D0wa1zMxxq+7AIufFhd/JB
 08fE9/9fVcfvnQtyh4WZOcfVLuIIw3fdrWWzI5dMUS0Y5cr4ikd+wA3eTu78mgY/1zw+gNiTTPW
 Sv4Q3+h3BB4u/YNwIfeoNRCVdi/PTwJ5eUuhv4Qfh6qnkqzBv23fdczwMsFR5AbXJpqh/nRkYiq
 vbsx6l4WCA5YSTPlivmraVLHz/O4pbkS4kO5N1k32tx27XjD9mZKWCmr0b2hSKATRE9nVKNRNqZ
 drxVeKVp8Rl7rP+vlAyj33AEiwPTB313+Sq8h8H47t7AhIwrgRJVM45a1e83GwtIOGPvdY29xyY
 9u22YecZDiVz39O1NPEuDteQd4stplJI4
X-Google-Smtp-Source: AGHT+IFshmMdYOctwPiXjvZFuUuMlmsvgy2BtpcVfk5AothhSuQIelGk61MeAFIvO01wdhUSmtRcJA==
X-Received: by 2002:adf:9ccc:0:b0:3b5:def6:4b2 with SMTP id
 ffacd0b85a97d-3b60dd87d53mr3915799f8f.45.1752745434104; 
 Thu, 17 Jul 2025 02:43:54 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9f4af33sm15347046b3a.122.2025.07.17.02.43.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 02:43:53 -0700 (PDT)
Message-ID: <1cbfe607-6be0-4c8d-8d59-8415a3c9c7c5@suse.com>
Date: Thu, 17 Jul 2025 11:43:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250717-clock_nanosleep05-v3-0-6934fc1a2505@suse.com>
 <20250717-clock_nanosleep05-v3-2-6934fc1a2505@suse.com>
Content-Language: en-US
In-Reply-To: <20250717-clock_nanosleep05-v3-2-6934fc1a2505@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add clock_settime04 test
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

I realized I didn't change the description. Gonna send the v4. Please 
ignore this patch.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
