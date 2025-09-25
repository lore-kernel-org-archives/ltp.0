Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12482CAC5B0
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758793783; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=VFmXb/lckvjTKEZ3/DN2Vtlmk/5CAtABkr5FeqvI1t4=;
 b=ngPR1EQPbvGB8H0yvc1tDT6Uh13qGFUMIEkQdQqmGwzzTVh2HjfvNF/HokauTjp1l0/+W
 VhXJvZuQCIhueyX8ri/96Ii5DdHyL8lLA0361k530LwYavvy8mLmIGuHugiO2MQzpGlNEIC
 6HwofXwwFjcCFNn792oWZ02ZUDNo67g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15BC63CDE19
	for <ltp@archiver.kernel.org>; Thu, 25 Sep 2025 11:49:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A7B13CD777
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 11:49:22 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 36F881A0016B
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 11:49:22 +0200 (CEST)
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6318855a83fso1494593a12.2
 for <ltp@lists.linux.it>; Thu, 25 Sep 2025 02:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758793761; x=1759398561; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kVtLqNY8WI39VlnzFT7+3XDTxGENBo0T+O55a7FJPTw=;
 b=M/vPrzYiaguBAyOrKxYeT4imlmUbbAlPc3ua4GQNPutTJt/0VXZLlQHqZ0cyoiRvPN
 KxMepup5G4j+NCfb0S/+zyn7OgdQOwGnrm6EoxzBoeYCjuh29C4bGeyo0R1bZXSVRzQP
 bnqRzSzNrUZQ1g6icSPqXUoAnc3YLgI0GFNgrLCUPySw1be+NI7PoKnFbee4zAh14KGs
 t+qD5tnUW3RyX5h3qjayYuwPiRkQsYs5eS+VFuqah9RfrdWgNT5sXR8wxUsWVEauaW8N
 7k0pBjkLKQ/LMIjItvQRwoRBxBiY0B542DqHcyW1VotuDT7ZhnMnXluwdGsA7MvIj/M7
 CjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758793761; x=1759398561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kVtLqNY8WI39VlnzFT7+3XDTxGENBo0T+O55a7FJPTw=;
 b=oYe5w+7R951U9Nyp9N86h9BqrfN8xmg5PVGOSkJcGCxB/E7IyxJc4nYF3CFEVAA0xP
 tEvrjLpuE3+7blI5jK0AjzQchBF6JGr60pagVzMGU8GlWMO8+nngpB11qaCrrSzugP1f
 3DO2AAg5kSnHU+fzCS2xjhJY0RFeCiiK+hU6Zfw9oDWuQNmWDGEqUhiNny99Y4EHQDz4
 cvmFE/wwYiw6UZzPbIMQpMX5YMXuunXK7BykXjwmKwrPGK8EQ8QHPBnLIp2SdN1m3cMC
 Hfx10DfpQ7fKTZCx3A6PRbIq+QEpfJ94HajZMIafSl6D968APLKb4gV/aM4QAJJwIPyy
 a9CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVGI187sfAk+z7jkWYQ0aQ05RnunEXYpE/0+G5PF9xdZtq23vA7d2V1AXfxJpiPoJMhOA=@lists.linux.it
X-Gm-Message-State: AOJu0YybJ98GNR7W039QfTctdC4ySs5N8jL2tku3muacB0EAKVa0D1hn
 yZ4P6H2znsYdT45dRXbehUB+CvnizGJw1690KzwopIXyfgBqQKSTNnEOVMVWR80WNnsqgoYlcUH
 EIX74
X-Gm-Gg: ASbGncubdV31mO4Z5asSHPfnW+DDpcYAU4uYwNMTePrqtTRTcLt2mFaB0giSzWYry0B
 hGlSyhECHJt4U/VrnkbWNpUKw7+HEuwr0LUHHAu6NNwpxyqqVokEAs+DXeTTdBNuhJVfTwBbn47
 2Rgz/hKALNcfgy/RxLcVBApYgu+8SM6G15M3sXCxcT/xVsRODm1Xey/rop8jolTbz9B5pHVNlva
 8t4VB7BWz20jOA0eitR2AHdMfKcl6HjydDURXlWpY0JcN1uSZbPadBu9yRmI1hbflX6WIAi/2I4
 TCH8siuJUV5ohnzUqmsPRle/SlCu5HOresJYfL2hfgJbZahSwyoIhmYBVbTj8ZGdV5AomrS8M/R
 SjnJHEqZF7j5+8XjWe0EwCZ0j+eRBjRkwPiJ+TXM84/PZqAxDv/LyW+56jNJN4Jdi8SLlrzs6Cg
 5iskHjC4IX9rdjX9t+zvumk3ewEhiV+crDlADD4aF+z7qGPR436zcqKFyAAjHfmxo=
X-Google-Smtp-Source: AGHT+IHoBAh6IScgX+rJS5juFDTiYaUuRR/84gIhviZ+h+p1VlK3GuwizvBbaGCiwrRBn6wIehI2Ow==
X-Received: by 2002:a17:906:c145:b0:b34:103b:484c with SMTP id
 a640c23a62f3a-b34b9d64ae1mr335111366b.16.1758793761456; 
 Thu, 25 Sep 2025 02:49:21 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f17:6d00:961b:d261:4569:b9c8?
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b353e5d11a0sm134284266b.17.2025.09.25.02.49.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 02:49:21 -0700 (PDT)
Message-ID: <d9c5cee7-4f95-4c3e-8915-eedeffe1b6e6@suse.com>
Date: Thu, 25 Sep 2025 11:49:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20250917-open_tree_attr-v3-0-d78d4150b662@suse.com>
Content-Language: en-US
In-Reply-To: <20250917-open_tree_attr-v3-0-d78d4150b662@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 0/2] open_tree_attr syscall coverage
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

On 9/17/25 4:25 PM, Andrea Cervesato wrote:
> open_tree_attr has been added in kernel 6.15 in the following commit:
> https://lore.kernel.org/all/20250128-work-mnt_idmap-update-v2-v1-3-c25feb0d2eb3@kernel.org/
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Changes in v3:
> - define variants only when syscalls are supported
> - Link to v2: https://lore.kernel.org/r/20250902-open_tree_attr-v2-0-b23d2585986d@suse.com
>
> Changes in v2:
> - close FD after opening it with open_tree()
> - revert style edit in setup()
> - use TST_EXP_FD_SILENT()
> - Link to v1: https://lore.kernel.org/r/20250828-open_tree_attr-v1-0-f339a0e51e22@suse.com
>
> ---
> Andrea Cervesato (2):
>        Add open_tree_attr fallback
>        mount_setattr01: add open_tree_attr variant
>
>   configure.ac                                       |  1 +
>   include/lapi/fsmount.h                             |  8 +++
>   .../syscalls/mount_setattr/mount_setattr01.c       | 83 +++++++++++++++++-----
>   3 files changed, 74 insertions(+), 18 deletions(-)
> ---
> base-commit: 2f208c00cfc4a1d7d5d957ac2b866e1248623aa6
> change-id: 20250828-open_tree_attr-4b2ece576c1c
>
> Best regards,

Should I merge this one? I got Reviewed tag already.

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
