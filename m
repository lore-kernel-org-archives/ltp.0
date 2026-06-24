Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8FACDE001
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 15:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782315721; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=iGEbQnKX+VF4D4UB6DVXo52pS6FMGcyqVkXQsT7eUqA=;
 b=iIAvpnyhXx2UuojZVM6LNZWI2St4zpSup8XK7f20cNjk+4t+kkIM1VHOdS1wR4VbuU503
 KUvDCkeRJBGZ4KPLqaDmfUOQuT71m1mXADEjcwKd7dttuCjJLxfTa42J5jMNZ2p4s2YbiAy
 5vZ9DdBsdDgsBRCVZElzNsmjRagrvxE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE2943E909D
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 17:42:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 36A903E2AA3
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 17:41:40 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4E2BE1400422
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 17:41:40 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4924e6fda5dso6309695e9.0
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782315699; x=1782920499; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Xb/zmLOhxsoaIGjJhIgc+IHs+RF8eW4onnTj6daTIjQ=;
 b=Go5awzjQQRHbhsjKzdsjuzreFGEKTsZk0YiPUaJL32XvT/a33ujTUW3I0yCwcXLtbj
 FvxxpOM738rp7yyjMcdpc3uYB5XWb2O8vaAh1fP/cxSw/2EpNM1omorOvF/s9/FFTL+D
 XLvs0XimV5R6g93dNsRrhpQKKOulGriVwDJqVJHB57J/pkMJT0iPYi9T/Mm6ycOaKb5C
 EIMAplkf6PWVbxyUwpiD3W6IlLte9Bpoplo3TDPOedxJlj52x8HAngtJfypH7jBYcZca
 H+aG1N8LM80ZdDMHx8s+3SYBsHmgXSy0AyDp00d7DCOtfGxJxIaRJgDV0HTP5L0/mVLR
 RFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782315699; x=1782920499;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xb/zmLOhxsoaIGjJhIgc+IHs+RF8eW4onnTj6daTIjQ=;
 b=ipsi14LNnHm81OYGsKI78RO590WlbKDV/gICRmwZcAgox4SUKvAF7qw6lXC57Rytyv
 qaTztzLmrXo1+PInH2Wljqt8flQwKdmWuGBHawcLdkSp9INY9iegbTu7oK6MqXU5evhu
 2vXfAgua5S9OVyYJbv7JQ6+wNtXT46tOVvbmsMagRYRf6gEM7pixyV4QAb/p2T51Qbxn
 5xK/SpOS3YSIp2+1UdWc1oQXq+Z+zpUSMJARoDo8kM1PIxKp5ZDXjBcjZ1qCw6AZ+aiQ
 7sIsLa+vfuKSS5wYGxjPmXWZRH6ECcbbvz+g6FpzUOMmfdNU7MdIFzFq0RvHY8CvKnX+
 X7sw==
X-Gm-Message-State: AOJu0Yzor0Kk0/ii9wWgtO98J3VrTMkyf++NoPvq5AkzUsSKlTDtGGm4
 d9ubQQXdfdO9SCn9hWw6CJIh7NWgsnpye0yI/AOiGHxUn5iVWr9BLr7b0vfMgNckuxU=
X-Gm-Gg: AfdE7clnLKXZOlXOk8Ll4wIujQi+B3W8rnqIwNpMMwzjistRd5NttiX/RJvgGIlC1de
 TfNGyPBdBTe/1EiEas/7th3xtXYF1wyOvjSrduweZxrocZwSitBEXa9Rj0ykJ1dao/i02nJLx5n
 PGHTOIenXyXZ8Es6GPkasWRHyAQPiCSUKHNj2WoJj3paqwkNVFAdwT7Nc9tUwYuNXCLILvoSCHD
 pjFERmeskyCAVHMH7sb0Ea0pxgnp0pbwrppQQXyv2lIsjDCkaBFHiU4M5qXFnzuM3NOswnzYfrd
 7HMaiJUOwucEwE4PglNMAelJ9qM6w6oeC6WHjF6DONZ5tIlzBDrr85/Ymztlvb2TK6cPsxRxMtx
 6RLZmCtCjyJrkbBWVsNeblJGq+5r7gY35QlFqXolvOL+vNcf0zv8OdUm0tohCFKnMLV+38ZqHtx
 qfuIrtoxrf0oBeiVOaFlptfuLMs6uGrQ==
X-Received: by 2002:a05:600c:a318:b0:492:4c2e:9613 with SMTP id
 5b1f17b1804b1-4924c2e97d2mr230475895e9.18.1782315699633; 
 Wed, 24 Jun 2026 08:41:39 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49264184210sm317905e9.15.2026.06.24.08.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 08:41:39 -0700 (PDT)
Message-ID: <e082e001-88b9-47be-952d-642e293dd229@suse.com>
Date: Wed, 24 Jun 2026 17:41:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>
References: <6a3b91e3.49afda34.2c585d.6125@mx.google.com>
Content-Language: en-US
In-Reply-To: <6a3b91e3.49afda34.2c585d.6125@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] set_mempolicy05: require CONFIG_NUMA
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,


On 6/24/26 10:14 AM, Andrea Cervesato via ltp wrote:
> Hi Avinesh,
> 
> the patch looks good to me, but it's probably not enough. we will
> need to implement the same concept for all set_mempolicy() tests,
> since it's NUMA specific. We just missed this for all this time
> apparently. Did you see the same errors for them as well?

Thanks for the review. Remaining set_mempolicy tests are checking for 
minimum two NUMA nodes and hence reports

tse_numa.c:200: TINFO: Found 1 NUMA memory nodes
tse_numa.c:141: TINFO: File '/sys/devices/system/node/node0/meminfo' 
does not exist! NUMA not enabled?
get_mempolicy02.c:60: TCONF: test requires at least one NUMA memory node

even on systems without CONFIG_NUMA=y.

But I also think that we should add
CONFIG_NUMA=y check in all these tests. Please confirm, I will send 
revised version.


Regards,
Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
