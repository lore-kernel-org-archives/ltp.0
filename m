Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE21C77B7C
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 09:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750756866; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=4uVI9urUBC0OTth/v/mTc4xtTyhvgCMen1mfTBoBplg=;
 b=kUAYWMYpj3IXF74sCHzQyQ3cwOYAbIbUhxQXKtTu+7GTFMgQISN+pxSzt0yAuA0OzFIAQ
 iObEGDTuCJWF+bfv6USJ2AOjK9s6SN6EAhCGFDZ3ePbAghXWATYshv3efVhhnZyXhD5rgUt
 uFhV6X4cPSGTJzojGmY2mP/Jx18l2JI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E22A83CCA98
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 11:21:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF45E3C9AE2
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 11:20:46 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 111C920075D
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 11:20:45 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso4162129f8f.0
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 02:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750756845; x=1751361645; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8clCHOw72muWgeKNQj1PQG295z7swspaTJNfdmafXqA=;
 b=XwJR1d9vT9SKX4+wTltiFbPpbtM65LKlihHHzifBUIaPPv4OK50CMng3pDjgS674xw
 IsgXz5u2GijETojaUT9hf7UDA2IcWtECyOFwZLVtjRJVTR8IealvQ0x+ds2BJY2agSQF
 1IRxiCgz9scnTAL0xn6mCn+CW6wYEPixCYaA0CCGMF1aRvWs4Qw+j4hQYlpKGYiQ3VGp
 jf71Gk+r+D4VyFqcqF5G5RF3XRM6zgPmsQJrkhcxGSczuz5giVsRdc0gX/vx7mN8LGXr
 x0vKne1aiS9kKiB8+RXVklRV13EzVZui7F94UKccB/dLQoj/STNCmveWrFPpfOm5M+LT
 E1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750756845; x=1751361645;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8clCHOw72muWgeKNQj1PQG295z7swspaTJNfdmafXqA=;
 b=KlTGu2cXEPxuYlborqLI3IimzCe7AQS7ar+sMEWgWSQGuKn/nuvGl+egoq2LxutH8T
 Jqhim192wxMHQ6qC7R7GumfUiwr8yC7rjfJj3jrjO/rC5mSr3B5G6NrU5LvjTBjsoQys
 35F0UI8kV1gVfv9bp3Fa64iUU881EYC7ovXJpyzA1nzlMW+NYjnlD2Pe+JbxSJ9j2yM7
 FZG3u60YmpXWRtcvgk0HQQojeC5LDm9K2k5OQlFwjbfNyC4k63iDy0rTv/kJjr/avid4
 u8PZoO1oXRvtmZvHTPjl7OWqkcgB0WseCp7vZq0BZTkxhOYeI0G67zegFm3DVSUiTpbI
 yffQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkgXHti2Hn17o4AlVLTZGEDC1n7eMWOzGkcoP5B5Os+fvSeU3TBGYCoIB1a3LwBjsjZjw=@lists.linux.it
X-Gm-Message-State: AOJu0YxiZJYniy9e7z3HIqN+erLBMjio7fiF5+PgUtkYdzvTzaHJknb0
 h8EN45kcTmL1v6BuAOcxtDM7tPsQLV9K6i6k959t0NlcnsncDiEessN5IHpqpO1mkqQ=
X-Gm-Gg: ASbGncvUMoEzOC6yKfOg260O+q2n42hH4ZYJMxCEpKnxuHv6Pcu9l7h3vFvSo2nO3RA
 Ww5ciCtiJuwH4eSIZVwq4+6oaAUlJofKJ2ZUeneGFzW70ljLXo45/7XQ2xqfoXIGHiRPUZTlu2i
 FC68CEJw/F0u9nEk9LQfckWB3T2UW4JLa5NFGtloeRjPTs0LaXLMwvZa9BfuhTTEVEI33mcSQu6
 wsSHDwcB4DNBPTi8V1po9Dlyia9rexlXUtklWaJsA1Sjh5yvnaB/tqzcSWc0PhEK2tc26s1NnzP
 LO3nwrBsnUb/HLuLV7ACSE22ScO/T7hN9zKHJNz6a1GRoplvweHRJ+1cTH54hnip6jO7LFEw8U+
 Swp9lOx8SmperSGDuWhP8sOHMRhqWvYmHvvLq7jx3M2X+cFWx+5o4so3RoGfSej4Gc4IfAAUxFX
 BttxdyiZ4lYQO3EMUg52avgsmevkQJ+JJ0Rhy0
X-Google-Smtp-Source: AGHT+IFe918bGnP7P/DAziiU+ar0lYAzWMXu09AjM+5cD3qNktMO3U2jnJQ1ZgTVWJgM3r7aQUrldw==
X-Received: by 2002:a05:6000:2c0d:b0:3a5:1c0d:85e8 with SMTP id
 ffacd0b85a97d-3a6d12a9e08mr12270766f8f.22.1750756845336; 
 Tue, 24 Jun 2025 02:20:45 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-315cdf995b8sm443942a91.0.2025.06.24.02.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 02:20:44 -0700 (PDT)
Message-ID: <5be82391-d798-4200-840a-87b9e41385bf@suse.com>
Date: Tue, 24 Jun 2025 11:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250602170831.404641-1-pvorel@suse.cz>
 <20250602170831.404641-2-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250602170831.404641-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] lapi/mount.h: Add missing mnt_ns_id member
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

Moved to Superseeded. Check statmount09 patch.

- Andrea

On 6/2/25 7:08 PM, Petr Vorel wrote:
> It was added 09b31295f8330 ("fs: export the mount ns id via statmount")
> in v6.10-rc1. It also added STATMOUNT_MNT_NS_ID definition, but that's
> not needed yet.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Not needed for the fix (it can wait).
>
>   include/lapi/mount.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/lapi/mount.h b/include/lapi/mount.h
> index aea6bca77a..daca14e551 100644
> --- a/include/lapi/mount.h
> +++ b/include/lapi/mount.h
> @@ -51,6 +51,7 @@ struct mnt_id_req {
>   	uint32_t spare;
>   	uint64_t mnt_id;
>   	uint64_t param;
> +	uint64_t mnt_ns_id;
>   };
>   #endif
>   

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
