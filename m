Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C803CD6E43
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 10:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780049919; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ugW2A+Suk3H0QxWOO8OUdXJQxnkw+yewO9sLHJKqkWQ=;
 b=XXog0C3sOvZ94QcwEvFvUh9XZ5A0JgXNJ+gn2htbFF0HDwp+/9laZTMt0UmEawV7ZQAh3
 Q0mn4X96gvQIEPWeRZN1+kWWRjSdMydQKwe3plYfem+DZjwrHsomBU8+mKHVVBxAlU6xOUG
 FicVYnN3YXvRf4uO2nfmwQYGmr+lZ/Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76C823E5C4B
	for <ltp@archiver.kernel.org>; Fri, 29 May 2026 12:18:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF58A3D0EEC
 for <ltp@lists.linux.it>; Fri, 29 May 2026 12:18:16 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 77C8D600846
 for <ltp@lists.linux.it>; Fri, 29 May 2026 12:18:13 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so175195f8f.0
 for <ltp@lists.linux.it>; Fri, 29 May 2026 03:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780049893; x=1780654693; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=JyLpQfFOwpa6yPXm8a3bYXtFGehVjWK6Aab2c5sZMik=;
 b=Upx7VMcoNvd/yuIHJYbQ/rIwslwVK+YIwrmTO88K6AJIiAdws4bsqE2WO2Qs5JhHPJ
 jUWlqAJ+1b1LZqMKdvy5M+xGVLqelnkiA2gBPQ7NIkFeDP8ZCt+PwuA85IR03BVjY+pc
 mnLeJQnDpAs5yfi8qTNs7RAr0qQHx82cyOqx1jzVcXJUnvzXRr7LX4Hq6RJe9ptrEUOR
 rjgcbYUKauoArZbD9lo6dpCNBsQLJuiHoy9JO6wBK2xecNdkI1vr6Upl+hSZjffzSBFf
 GJeC4fWqRh8BxKGhw45dfelMvgnEYrZ5gLkA6sooqBnBMUh/FEmXqbb1HqItBpv97x7N
 FMNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049893; x=1780654693;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JyLpQfFOwpa6yPXm8a3bYXtFGehVjWK6Aab2c5sZMik=;
 b=BK9CZq5dzLLHL78n2DN/fOwyoFQQNg26kL5roOeMhYibIq42MCoTpYkuJMgF6TAlM9
 4JrD/lwPuzG8lkZm+MZ1i0ZjOJckqcOhnP5UFngND1zYRasKBLtHSImwjTTbeVcD3Nmx
 uiOpsJa/0q9n6+/XSrQ/HBV9geRbfRsZUgq7uMqmb87JeLdMMmTRHD1uzlBeR86xmBvg
 vaut9sAiCUnlaHTD7eh/yAJhZnIjw4d5lWrkEA/iUXKgezliZMYrPDT6dbT6uehylvLl
 qvHy9AUbycdM2B3lsxvWsFGmjEmOVuYGt4M0w2//dknTia0Sq5M5Vj/fWPKlCjhuGH3O
 AIRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ80SmpJKXCBenhmqlYs93vJOxxvAo38XoXbaaDB4ltl/Manex8FhQcjS11Xlw6YwskzYb4=@lists.linux.it
X-Gm-Message-State: AOJu0YwoTcP+hKJrqh59aYpkUyg5g6TareQ/UO9y4++S0g2M/t5pe+WP
 GtuO32j1JKomppF8vMP3be+q/1wy7JUlwqvFmDbKaqhN+5kI5cS15O3UN1ZcXOXdb8A=
X-Gm-Gg: Acq92OG9bktNDuYgCWQcw4k5TSI/CIuFLRFv3N3dInXAs9F0dPTNDgbrJJME3Fovmxj
 bxXux8vGGQBB5VQrQb9/r5oveRzs/0Mc8BLHM30StSm5BBFNLKPZTM/imZHpAdLlU2Almy8TZYo
 bR6P6cC4EokToGaLk6HfMTD9NyT5WnVCfq4ImvsFnUR4mMbKZZ3gBndON4Nysz7y09SNlT9UrLw
 wdVZ3VDaWWqDUeuNpfScZkAaawa3xKJu4r7R3uiLYCuCkKK4+k/DQYVluxkzOoGwKOIHbd9GLXc
 eQt+zxGpq5HYwEmyc3hfKM35jpzqtGCJCLzOGwnfqxeAirno/B/9apgzCzZIRfq4rCJtwuVm7Rt
 yn/Pzps8bCffaGnaIZUwHcBhxZzPT4UA2sLNZ3PxWwPUDD+2ewxK1NGbT9kSgXzjR0sXfKQk6Dh
 aMkyWXh7k3A4LTCv7hk8ztRo/025RdYlHiZh/uXrmbcdVnHvgeE8s=
X-Received: by 2002:a05:6000:2997:10b0:45e:a314:ce0c with SMTP id
 ffacd0b85a97d-45ef13fe06amr2738938f8f.1.1780049892761; 
 Fri, 29 May 2026 03:18:12 -0700 (PDT)
Received: from localhost.localdomain ([80.255.5.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef35598e5sm2322511f8f.27.2026.05.29.03.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:18:12 -0700 (PDT)
Message-ID: <6a1967e4.b251136a.3a1e25.ae04@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ahQYMv2x55-sotGZ@yuki.lan>
Date: Fri, 29 May 2026 10:18:11 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_uring/pintheft: Add CVE-2026-43494 regression test
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> This one is actually wrong. For historical reasons macros are indented
> with spaces after the hash.

You should add a rule because we are actually asking to respect kernel
styling and probably that's the reason why this is spotted by LLM.

regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
