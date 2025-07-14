Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFA3C83F1B
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 14:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752502646; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=N/aKo/XoHVCxejZ0rNEl+oIHgQEN1M0/77AU9igkNB4=;
 b=CRqGbE3BGEj8CC/ncC46T/2fM5W+IMemyIq2vQHFouKlV2fFs48ihaFpNTyVO6U3BeFG6
 yvWxiFEkMK2Jsk4ljjvTXfusrcyypBolBd4qGtaJcS428cwN5d4/Amb77Gdo57fgKXxjEbj
 NINN/if203nMh/UpFYlGXlLUV5bOadw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CFB03CB5BF
	for <ltp@archiver.kernel.org>; Mon, 14 Jul 2025 16:17:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1ED7E3C0639
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 16:17:04 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6D528200BBA
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 16:17:03 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4560cdf235cso10102285e9.1
 for <ltp@lists.linux.it>; Mon, 14 Jul 2025 07:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752502623; x=1753107423; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ISM4gKkDfv1AfzXHms+EpHs64XCpf0oNuEd8Joje8FI=;
 b=VGKUEIsgX4bJF7rNH3xnk6e0qP9mf/+D3So6VzRXqQS9m4WscUofcSE/o1TlCUP1jQ
 jF2VESZ134HHCimDVpXiTAhx3uXMuQO/XNrnYocVhA97FjgoppzODegIAfnYB4XelxNL
 ppVjdTNPBudyBubM/Y0IYhXvWx5LMxE9zki7x6VosolVVQwXO5io5d9CkwL+5kpzQ7Yr
 595flbMyi1Sz/RB2hTs8ThPW3gOU0IZFIzCGcmiBn/viVIW4ASxwtqvQ70E7SJhp6svj
 0TWAp8nSGh4GgQvpfk2ILUhJZVhSwePhOAILYKJI17hmThMTZprP2QNAnFaVw9TcAM/X
 f/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752502623; x=1753107423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ISM4gKkDfv1AfzXHms+EpHs64XCpf0oNuEd8Joje8FI=;
 b=nkdakDpsvuk+UnsiQ0cSXAGkzbuRM/C91lKhT0oiMuLi7733Fh8Bwyc8kqEQ6BNJnR
 qQPP8oPBcmWESWumkEdFzHIq0wLNcFol75Sw6mC/PjNNO8p9GODxO89rm9SNVg8HjhYF
 QpLXWZiQg1+DlvnMxXjhv5zJDQ+JD5GkticE5FbXKTEGMyZTXsMNgWgqlt1ZGaphILWu
 fMEYGkIqofRgzEnV0yYc58LzTLSnNBKix6WXn44VlbkRltJzwTlfaneL2nURU/BPVwaq
 zX2STv4yoM8M5RsxXYi4+v/JtwMUWgEfKQgkjtqxZLQzRPB+jSzyM/EGM6aiwYlb5XTu
 GZZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK+Ul9RUWh5g7WePbQ42AKGjEzxeeDQ7xzu5MjI62h7aPEAlXKrVXTHvkzK1YmIjoUKzY=@lists.linux.it
X-Gm-Message-State: AOJu0YzH5sl8tjBZa7f8qfzMFhltI1nO5OeVhembort15/B8tadrrh7k
 yeoyR7pAT/VunI6RtaIsN3SvGGIFy+t/RJPBCxedDQD7E1Q8bDF16IpJ/cLp0pwbTlGqQRaHMJV
 mnfZ8NIxNXw==
X-Gm-Gg: ASbGnctTVkVRv+n9TNFwz+a+pgjFjESq8NzsoNvYC4aQJZ0Q4gNyh8CN2VKGu4YOZ9h
 eda8IuGsdhw5zTiT1E2dvEkz3QKV40pVYQBgaTggiMqTiVCEAU74WOoSxLoAFucejtO9yTFSnxD
 Q3Hqs+iI0JmfEtpd1XjNXF+FlTDXnTaSB1RXQWhzOReI5xhpQz3A8Lc7v2BGEi1vBqRSck5e/rQ
 wqHeEwCxByLTw8OPqxa3xnWDuCNiNZhblCDDr9kayWmLiwqWGvbVNhW3dnKCguF9Q5n65oAYnxS
 uJp1gynZXgOPwRjFy4ia9/55w3FFn4ovDsEs+2l+kT0gA77ff51HOhwWEFP9Ojsg+UttpMk3wVB
 GuSUZ7PTlnqgYiuyZt+S/oJ9ajGxM5z3vHXmQ2Ypj2aI=
X-Google-Smtp-Source: AGHT+IG6JzylZSqeCJqQTDOx+wSla9dD5RO6e6vkGq5HrcEYjeALvkAvAt/byfoEEh/42m4+rwycpQ==
X-Received: by 2002:a05:600c:a18f:b0:456:db0:4f3d with SMTP id
 5b1f17b1804b1-4560db0522emr54145575e9.24.1752502622760; 
 Mon, 14 Jul 2025 07:17:02 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.46])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd180fsm12381979f8f.2.2025.07.14.07.17.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 07:17:02 -0700 (PDT)
Message-ID: <35cb457c-a769-4c08-b23b-a7964da4e4bc@suse.com>
Date: Mon, 14 Jul 2025 16:17:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250710-new-munmap04-v5-1-6db635172be9@suse.com>
Content-Language: en-US
In-Reply-To: <20250710-new-munmap04-v5-1-6db635172be9@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] syscalls: munmap: Add munmap04 to check ENOMEM
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

You will need ".needs_root" flag on:

tst_sys_conf.c:78: TINFO: Path is not writable: 
/proc/sys/vm/max_map_count: EACCES (13)

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
