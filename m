Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C9BCCA471
	for <ltp@archiver.kernel.org>; Mon,  6 Oct 2025 07:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1759735608; h=date :
 message-id : to : mime-version : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=PEXCmCFVfPsLeh15+R69B/TZF3VyE9OqiDEx8ThRCBU=;
 b=E1gS5r8Y/ZK0C0zG4KYFOFktj4FxuV8RZivEG6EKGn0jw6Cs2Y2QhPGszIQhmJelGQdFl
 HT0L0UDz74lzHwgWeJrJOpd5kRMhXM/tSJV5MkSZJBjnXAp26YTlUPwKqG1SgAmPxDl1Yy2
 Yb3GaeFy4WVZ4Bs+pNb3w0KVet4vkq4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 058953CDE69
	for <ltp@archiver.kernel.org>; Mon,  6 Oct 2025 09:26:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E53F3C5372
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 09:26:27 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DC482A3C4AE
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 09:26:26 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3ed20bdfdffso3885119f8f.2
 for <ltp@lists.linux.it>; Mon, 06 Oct 2025 00:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1759735586; x=1760340386; darn=lists.linux.it;
 h=in-reply-to:references:content-transfer-encoding:mime-version:from
 :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
 :reply-to; bh=d9z9SIVOV0Y/1ETntfvqhWbQd3xkXfiwBlHU0t6oWlM=;
 b=HG9h06k3DCzd5cIIUkM7Xum5s6APoq2O4FXJT7rOsbXcZ8OqY7TpvVR6PJu3U9Sbrh
 KXoWj6YzvLMflPcNvCKkwiLl7g3i4hus2AzcqDCE1H7DuP4MKdcYm1mm7OUVxrlsDtKh
 2t/Fdj/RxXBf8rkGWdNVRvEHLpwa9GmTkgJca9GpKcmvgH0S3Zqz5cTo98bb2I/Xjm+Z
 ZzIiwh2fNo5VF1YMv4nXGhJxRlhEzCTF+ZUObYnEqKw/Xbf64aXJEKeZHHI8Ik4bgiO2
 k1ybP08I8K5mCTQUL/nTw8PbRY77l//la4ZbyEIR9hnRKNwEJWsXBRMmAvscPxSL2f8W
 bjEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759735586; x=1760340386;
 h=in-reply-to:references:content-transfer-encoding:mime-version:from
 :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=d9z9SIVOV0Y/1ETntfvqhWbQd3xkXfiwBlHU0t6oWlM=;
 b=bTDS3ykQtIk5UfyFJmt5KyUDjiYiEhk/HMcg4r1U2zi2zmjmWH3kdVOVZCMXBRCbUP
 Gs7BI78g6BV9H0j9pTOY9XB7DS9qvXiYpS1T6w1u1xnH6NOwFY5X5TByZuXz0jPaC8lW
 7zIPxezofvAKRnM1Gpb/GRwxxuwFp/TzrbHA498r8jD2Ac1AVkxNcNTaTDVnk/r62NvP
 PKc8tftjsMOkN2qlQXYiQrkrdAI0P/vtZ7OcmxdDrYtSvrNfU3CEC8xScpDpDDQZokSB
 lD5IT7FlaFW4FR1efqkqSPW7d6B92Dy7lYJb8fiEFjf/vL0PO/dcfuUQy50QfauvmtWG
 iqlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEcBr2MMAofOygLsStTBmXN7EC8xLdZnAUnBskNuszPNzARo9wzyGoL5MBIRMbZp5nun8=@lists.linux.it
X-Gm-Message-State: AOJu0YzwIJgnfyDOZvqZQSTWOywLoYdJrUqyM6l4ZZBgaMakXqUYgm6D
 Q70M6kuwHY02o9PLF3fh7NvPGT5t8byFbvOnZXkpDaOHgxcZ1LG/kuYOQLPIcBCTCxE=
X-Gm-Gg: ASbGncudrw1seJmDEtneBOJ+Loo+2ORTebD5Is4y6Pi4u2pf8ClM3cyDmGXQpHkim+W
 YKxoHoY/UrCy5rMIoFDZyqmGR3ThqdqEnqIsJjaJmfEF8gvROB/ws77Pc4Aw68gg3ExuCmlkgYV
 fooQMZPqjTPouBfgKEZG3C9y2o8cVRbxSRp165soFCXljf1kohwFrPk2tBKf0UGwHS7EYAoP9f/
 UOGmyo8kySSDf1/yjFJsA3XsdxuHexFVrdXoIcT5RGVxN0jEMO9wyf2PfCjVmUozYnmZj9klvK4
 HQpIVCcTE3ufhd6gyXThDTF1DDPzsCcO3dcVOTbl79/NVaPfbWx5DpvX8agL2Z0NKCmlkigYHIG
 sXcDeHlEuzuMf34BKza2bRVZ2B1hR5CsT1ouEGQAKGoHHEBAoPpj32+M6C8SW+jQi2bMRwYmuqW
 QQ+w==
X-Google-Smtp-Source: AGHT+IER/Rdj7cauezc+w1mEN2dXrUQVJFZHfavgAL9n3XCKJlBGmYxUCIUi5m0h1l2LcRLPVSND4w==
X-Received: by 2002:a05:6000:43d4:10b0:408:9c48:e26c with SMTP id
 ffacd0b85a97d-425671c6c14mr6198621f8f.62.1759735586177; 
 Mon, 06 Oct 2025 00:26:26 -0700 (PDT)
Received: from localhost ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e58a7f098bsm50161851cf.28.2025.10.06.00.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 00:26:25 -0700 (PDT)
Date: Mon, 06 Oct 2025 09:26:22 +0200
Message-Id: <DDB27AD5V8CC.HACBLFITNI9R@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
Mime-Version: 1.0
X-Mailer: aerc 0.21.0
References: <20251002083701.315334-1-pvorel@suse.cz>
In-Reply-To: <20251002083701.315334-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] ima_{conditionals,
 measurements}.sh enhancements
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
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

hi!

On Thu Oct 2, 2025 at 10:36 AM CEST, Petr Vorel wrote:
>
> Petr Vorel (4):
>   ima_{conditionals,measurements}.sh: Add temporary user
>   ima_conditionals.sh: Split test by request
>   ima_conditionals.sh: Use 'sg' without 'sudo'
>   ima_{conditionals,measurements}.sh: Use 'su' instead of 'sudo'
>
>  runtest/ima                                   |  5 +-
>  .../integrity/ima/tests/ima_conditionals.sh   | 81 ++++++++++++-------
>  .../integrity/ima/tests/ima_measurements.sh   | 15 ++--
>  .../security/integrity/ima/tests/ima_setup.sh | 12 +++
>  4 files changed, 71 insertions(+), 42 deletions(-)

What about creating a tool simulating sudo? I thought that was our main
goal. Using 'su' is ok, but this forces us to create a new user all the
times we execute a new suite, while our new sudo implementation would
create and destroy the user only for the specific session.

- Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
