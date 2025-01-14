Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97AAC02183
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 11:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736854788; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Sj7zueunWikg3FUQIp7n6BvHk93g3BcdQE0Nuoj5eh4=;
 b=GumJGxqyltJ8X/Fr42XaaeGWOqg0Pc7s9Rd7n34ikyAqCSOi1GC1U3aO8803m1Q78uR7R
 r8qdk1AXYkpTuO++f/qK4QTG0zuMitAUMzk0BVVANN2qFVrk6E6VUdlOR4b2WC/lxfFRESz
 UXBjNvvjX0Bk1Uk3wcTKaHphN0KMhnA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 239933C7A3B
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 12:39:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32ADC3C0503
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 12:39:26 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 73FF41BBC770
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 12:39:26 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so55673435e9.3
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 03:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736854765; x=1737459565; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h15RGTpH1DhNJJQh+jHRnslQ/qz8RNuCoAUVG+oVyJs=;
 b=LNKqf1EFNu/GOcf4TlQBVjgX/5len4n6ZExgClTOBwzq/C7KVoOzSc1cMXBlLID7JP
 UhWYbXmdwfq2zvwKNq1OxWv9Zuu4ZuLUrFDdZbEJXdW7tYkju5/PdBrg+8erLFJjStkA
 Mes8Jk0KUXG1DrNi4aYqBvfxQ0RUVWbL5RpFHuaJ/g1MXBr782DhCENltO2xDdNr0nZ0
 +eYh921X+MH9aBw5+JsaXV5vecii6ge7I1FYieUpkKLhIsI8xZaunbg+k1sebWztP/B9
 oMdEbh0g/yP2jylS14WdYmPYLDkT5IVAGLWgWOiCxYGyhSNwu4gnN2UnvrV1TaQDitJr
 FT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854765; x=1737459565;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h15RGTpH1DhNJJQh+jHRnslQ/qz8RNuCoAUVG+oVyJs=;
 b=SnQhf0DEOLh76nWICDaQiycdtxl/tb3I7MnV4FugRsasFBx1GD6iQE4l/4XxJ4eOrl
 QOQz6LHN2uAjTQKQg75UZZvZ9b/0qPqWkr3+bugVylgn5uOhE2D4HvXA5Z3cu4TPW3JT
 zNnPwKnrZ+1XkksVbIeMd32bWtwCyb1aMNuN8dshBXXu8CX2HK+hY7brx1PrjtZGW3lS
 EMzZJfBkZpBsIHKP9XdMfUOvbC8RXd5fuX22KVyRsLLfV67GiIuTd64c2TZgXHdOHBHX
 TiNE9vWJMeq2JzgvvMP2bDUKVW4jcIZQBmGMxdX4Ee56pZfGiqlVNKjt4V+a3v6tbEVu
 3lIA==
X-Gm-Message-State: AOJu0Yw43cLGV9wi5UsJ5bQc5Ybl1Gk8acO11zIB9zMzqh2yWrxAvBSA
 oNz4hlNNANUKhaWL7MJTO3p+f986CSswVJZJCoNC3kuImMHLTYONno+RjaTE1mjemcri18v+x96
 QseM=
X-Gm-Gg: ASbGncvDl9RqtJ60cj/8t4dixgn1cNFEelLQgtBEj6XYFb7dN41dTCOCqbPABdjKuXV
 It5JJOVZWXl4D8iP+qPCxoMmQUFD5vY6p2vNAf7K6peeg4yz901HzhmeCYgSO3hgO5xA7yvP/tF
 /qvDb9VcSbBptCEVjnscx6ECi0yS5qUYAfhmq9pBQuowi/r+sA/JZBvFhm0HQCJdkpDXr6SrzdJ
 qXMY1I8E7dNYSQ9EHA8YM62gb9CcFK5K+Mhss2/oeJiZ1wg9YWh8CUVPrTVIz9H70k=
X-Google-Smtp-Source: AGHT+IGUT8UlGjROnAxx+8h3LaSjUSv6IBeJc98+F13K+1ngUpyPrikLOkvg47LsGADDYN1hKd3F0g==
X-Received: by 2002:a05:600c:3b0c:b0:434:f7e3:bfa0 with SMTP id
 5b1f17b1804b1-436e26e2593mr187542685e9.21.1736854765612; 
 Tue, 14 Jan 2025 03:39:25 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e37d46sm171284755e9.25.2025.01.14.03.39.25
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 03:39:25 -0800 (PST)
Message-ID: <5e30476d-9d86-44bf-b9c4-1026d445f02a@suse.com>
Date: Tue, 14 Jan 2025 12:39:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240307232511.228396-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20240307232511.228396-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] doc/C-Test-API: Mention umask(0) in the
 library
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

Hi Petr,

this is worth to be merged in the new documentation. What do you think?

Andrea

On 3/8/24 00:25, Petr Vorel wrote:
> Update after 50626b4a1.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   doc/C-Test-API.asciidoc | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/doc/C-Test-API.asciidoc b/doc/C-Test-API.asciidoc
> index 08a76c403..90cf1df43 100644
> --- a/doc/C-Test-API.asciidoc
> +++ b/doc/C-Test-API.asciidoc
> @@ -2462,6 +2462,9 @@ settings which may clear some of the bits. If your test depends on specific
>   file permissions you need either to change umask to 0 or 'chmod()' the file
>   afterwards or use 'SAFE_TOUCH()' that does the 'chmod()' for you.
>   
> +NOTE: Temporarily clearing umask with 'umask(0)' is done before creating a new
> +      subdir in the cgroup in 'cgroup_dir_mk()'.
> +
>   2.2 access()
>   ~~~~~~~~~~~~
>   

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
