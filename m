Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7FEC83F17
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 07:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752564570; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=NL6JI4VqpqAT+Wytsw0agEDP0TEWhDE+LBKI2igLz3g=;
 b=U+Bc/zK504rCLU9i+vGApOdG7AN/X5v/AdX2lvsgb0d2nfbouXkOaIZIqTvHbEluo7NjW
 KRqFLxH+iwKHZ8BPouO2v950GqfBN689ZgUqBEw/++BICgkE7gWIMbvGc8BXNlyDGWyPQg1
 LXSpGzo2+8tqcUOIZyfg+2IUJjE3qoE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E821D3CC62C
	for <ltp@archiver.kernel.org>; Tue, 15 Jul 2025 09:29:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ADDF73C66F5
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 09:29:09 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 25F9B1400F83
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 09:29:06 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a588da60dfso3428910f8f.1
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 00:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752564545; x=1753169345; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VYAO+WngD7zQuScar+ZI+qWXLp8GpMwBxyhuskKOQUU=;
 b=Rx/FomGgWw3hlc2IFxdL3N4BDFxglMsRNq0ECAZcNs01luxoLeYL/l4U7ZSqB2/30i
 cRBmC+wlx0zf5gTBfq1MnNZKX+n7vhGVek59iQnGCTayOQa7GLc9OLryFzU942vehNPu
 EFpEtKbwU47sPEQiLIKbPPIoKkDwucKSd1A4gJx9B+tLcHUCkEMTk5Hbq+2Afk8zYK4O
 lhdhw1ZULpFg3sVVn4TYAFXR58jZfdX+58dK9rNnfRCB1IUhw7GNWeV8W+ZeK65FRJk7
 pcVtl1ehmBaMoJJZgEH3huT41cjaSIUe5Aq+Q6/YiLxXqqh41069dsErp9bRO6qSZJsD
 GgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752564545; x=1753169345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VYAO+WngD7zQuScar+ZI+qWXLp8GpMwBxyhuskKOQUU=;
 b=s4dWOzKBgm/i/mrjaegvRtw2d4Cy1i32qpihgUgyLmq2B4powrAdbs8Najwo1mQ9K4
 ctlYaxONFtX5r4M0aWcD4iK3EGkrQ4wcPGQPPf1P//wbRCA4unzj+tBBNehMS3WWBTk3
 X4BfmyTre8Fd475uMuklweOjrbqpbHjVY7TuRrNxZcEszdMKJwF3uEdKcrEs02wXyI/0
 bvI2YqgTK/u+GuIlqcfwKk+y7mb/6BW8/jnmkDrfi0qlPX0zEh56cW0UYWgjk5PI9XqZ
 TGzxyVtNGlM5vzG4nO2KzdLmRrMmwqcHkhgcaxRzYmvPqQvefzXcnlaSdIvChIV0slY+
 m0Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7RtQ+Nr7AS50Cohhl1MhclErH9C600HbWXlkPbKNlTam0M7o0BhBMQIKb9VcUgLbKcY0=@lists.linux.it
X-Gm-Message-State: AOJu0YyqAlhh6krQ9OxJm4GRCk7JxkZ5Wqnv+KXHt2gJyKE7CjMI/pVZ
 kDJ51KA7qVDlIROuHw/SWWVqEn8K1kxpGOXJA1HOTGVVo7uyhvDOClBMBjdunowKWT656mQKmgQ
 iKiJbjhc=
X-Gm-Gg: ASbGnctxwuy0JwYyNEbRF2PiapZoCU9NH6rXJtVgP3uCmDUn8DCSPOAdsfjlvTwF8me
 BarB+m8RMlV7/Qgh4ns5/i6EiUWOSZhSpr6XHJv8wwFkZ7yk9r6IUNdJgdjAbFxduRZMNOJZrej
 k9ZVfCw9MrPYn1NqiTRb+YnvS1aMoBF6vh/5+09Uh+16/xDo8uekckSEgDS9nlKHedceUZs+Vcx
 12cs3qsY/LH1pyXFCGUJWSuVva8UjYwMFvxpltS4cYSBBiijPRtaPEeQK6n8hrbvhNyFU4o0bsf
 s4xWkCxOFewhejjW4OBEm/j+W+lkJEmwilcS6Yuxaf6EEt9M/myuxOPE+8OfjTL2U4t5KKRDmXz
 Sf7IDuM3eJ7cNhl2dlH5fb8zzEoOnxOO0byW+7/3H0KYuF1x8CFgzhEOKCzC1Kk+8QFgfoNLfFJ
 rD9mvm6EFJW5nEjiO/59IXxBMJke5ii2PiqwbuaCGTVOXqVacRIfM+x/iB/+LVQA==
X-Google-Smtp-Source: AGHT+IHxtwcy/CU42w3VVyQIl/vF9A/z4gZa/AdS/tK0XCldzImsDMV56GmdzHo1unZ7jvSMmcmArw==
X-Received: by 2002:a05:6000:2710:b0:3a3:ec58:ebf2 with SMTP id
 ffacd0b85a97d-3b5f187e8f5mr9774637f8f.7.1752564545504; 
 Tue, 15 Jul 2025 00:29:05 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560538da14sm96256625e9.23.2025.07.15.00.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 00:29:05 -0700 (PDT)
Message-ID: <2eb02736-bdc1-4b6b-88a7-64e3d6e07c8e@suse.com>
Date: Tue, 15 Jul 2025 09:29:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250714-new-munmap04-v6-1-f043e764e475@suse.com>
Content-Language: en-US
In-Reply-To: <20250714-new-munmap04-v6-1-f043e764e475@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] syscalls: munmap: Add munmap04 to check ENOMEM
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

Merged. Thanks!

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
