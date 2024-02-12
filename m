Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A87C48297
	for <ltp@archiver.kernel.org>; Mon, 12 Feb 2024 11:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707738866; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=+m3zJiVYxmiPeXGsRs5BwIZifiPSYMkWZDrQa9dnMNc=;
 b=l69w+RvJ4+UMs3F4bXQ2Ex0zEpU3LeNLl8JnN0mQoWssEz7m+pQY4EotpeTNinlzjDDhr
 CebeqGBfXMNqIO8A5aNjG6aGRv5ICurPUqLkDBoOE16AyeXgo7/hoxBwCgbD5xckXoG9HYv
 GRd6waHYX6nIQlM+vvUUKo0LwYCIHng=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D80EC3CDE2B
	for <ltp@archiver.kernel.org>; Mon, 12 Feb 2024 12:54:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 812023C0FDC
 for <ltp@lists.linux.it>; Mon, 12 Feb 2024 12:54:05 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DEA561A0034A
 for <ltp@lists.linux.it>; Mon, 12 Feb 2024 12:54:03 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-339289fead2so1992923f8f.3
 for <ltp@lists.linux.it>; Mon, 12 Feb 2024 03:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1707738842; x=1708343642; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MYBJVNcEH9XUy+7whnWV5B0JS08DO0+eSYQGYQssM2A=;
 b=QqEULvYPcoPxWrxcUjn9SRATXzL7KUkkT/A3BHxIydjLfdRzdHK+wuYgapMKCuevjY
 YetAeiGTWX7UREehp3SgpyMZtixfT0jaGayELvGjBIH/JyXz1Yrg1N5CfP1qHSmtFUj+
 qd+bdFh3jGYxuT4l5qrfmM2mfEcxKazFPHqJDJ6gYYVJNHguiFTHj+bUy5nRFsXucqHL
 FnkYJ5o+9+TlgZqRD8EvveoaKkvD1PDIIOVdBbI3zFquIjgz/k7RM6smuVtMVgpr87at
 4bayV4tj9YNCPvEhi1UucvwQ3UYxSwc43JPMLb7vlxaO7rJz4oIIBMYlVe6FPRPvja1e
 svvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707738842; x=1708343642;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MYBJVNcEH9XUy+7whnWV5B0JS08DO0+eSYQGYQssM2A=;
 b=PYIczcO/bXOdR67AnetqzKYPvHfacFyc02gZmpk6QYKUQcvSTSYiDWuJiKUO/D/Gk6
 zGDx7Ne88wWNj0b7jEK7tN0127/4HsSc+b2nEuYpkFVxClvqPLGk63SOSYCK5gUuOUI1
 bctWxEaQ9YrrOp7I8rdOitHQQkrmpoKkY3JATHNOQdVTRwe7gygt7EtoL2O5XLWQaTSI
 N2y/iPUZJWhfUfFyraEr3qb/cxl3Ikm121ESTewrVIhty5mr6JfUltVMxfQVfZpoJghq
 nsVhjK9XDXfgNnRTNV2jboRmOpo8nnf6sAxpqZ5YjSg4GVbUV1tMmDHuK5G68fdfMV25
 ky3Q==
X-Gm-Message-State: AOJu0YyvmGQge+jAKgMR3JcTARXyJ6EPJwSuiWo6XYXcK1PsXo+1oaeR
 +Ltpv5v6lcq4AUFGTDG61TYMf7w9GKdBQCaZyf5W9y2xOin3jwz4rhMn9JJoxfdBPj3rF1kT6SK
 hpcs=
X-Google-Smtp-Source: AGHT+IENhWQfbsa0d/ZfhNnzTBBdpVB4kY91yGLIE+ouvOzkGEex7eQMonvu65N2h1DNM7GOI9EiMg==
X-Received: by 2002:adf:db52:0:b0:33b:516e:7242 with SMTP id
 f18-20020adfdb52000000b0033b516e7242mr4570545wrj.66.1707738842577; 
 Mon, 12 Feb 2024 03:54:02 -0800 (PST)
Received: from [10.232.133.56] ([88.128.88.50])
 by smtp.gmail.com with ESMTPSA id
 q1-20020adfb181000000b0033b68556c38sm6701058wra.70.2024.02.12.03.54.02
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 03:54:02 -0800 (PST)
Message-ID: <bef63b63-5dd4-48b3-a66c-60b7dd446aca@suse.com>
Date: Mon, 12 Feb 2024 12:54:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: ltp@lists.linux.it
References: <20231204002623.17302-1-wegao@suse.com>
In-Reply-To: <20231204002623.17302-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] cgroup_core01.c: Set umask before create
 directory
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
LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato.suse.com>

On 12/4/23 01:26, Wei Gao via ltp wrote:
> Some specific build's default mask is 0077, this will trigger issue if
> you create directory with A but switch B to access it. Such as following
> failed message will popup in current case:
> cgroup_core01.c:50: TBROK: openat(21</sys/fs/cgroup/memory/ltp/test-3519/child_b>, 'tasks', 2, 0): EACCES (13)
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   testcases/kernel/controllers/cgroup/cgroup_core01.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_core01.c b/testcases/kernel/controllers/cgroup/cgroup_core01.c
> index 2e695deed..0deff6209 100644
> --- a/testcases/kernel/controllers/cgroup/cgroup_core01.c
> +++ b/testcases/kernel/controllers/cgroup/cgroup_core01.c
> @@ -38,6 +38,7 @@ static void test_lesser_euid_open(void)
>   	int fds[TST_CG_ROOTS_MAX] = {-1};
>   	int i, loops;
>   
> +	umask(0022);
>   	cg_child_a = tst_cg_group_mk(tst_cg, "child_a");
>   	cg_child_b = tst_cg_group_mk(tst_cg, "child_b");
>   



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
