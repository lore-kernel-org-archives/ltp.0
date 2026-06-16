Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE73CD98CF
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 09:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781600811; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=HuVpJHRmf2OuWDchKRNJjjkVul3XIICICPqxXI+6HiE=;
 b=g3bveANQw6Hbd+1CrCLR32Y5zL1GYE9Z5CjGyCb8CoGECcud+Pip4fzc3iMZQyHHoBfwC
 MTucGb2qfolusOykjsU8086B0RU4TrjRA6jP0pTQ7n7gyuaGamHeJKMV5/AWD4I7Q6GEojX
 hQnDOpYIwPL4+D3HLlyrP0/Hil1zxcA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10C6E3E596B
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 11:06:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4129D3C96A5
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:06:29 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 702AB600902
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 11:06:29 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-490c1915793so36644965e9.2
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 02:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781600789; x=1782205589; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=TviBoAjlXMOEoBtlXOL46Y+sZzT7YdfZDVU/LFfsq6k=;
 b=VGZqxQlmEusrMS67uBX4pAYk9vRPJ4J0zPB3qPa/Qep9Gb8LW7bwvXpmtonmWYF/+J
 KunKRXa+ERfmhkB5E1BJtsuapwA7Kz06Zci3ZibDAxyt+04dCGk8U5li1EJ2GWx4Ytbh
 +/sF6MZhO4i1n+9xylRcYFKXXVjlVl2EqD62EpDyRQSo8+DoSK9aEagTTrSC3e551lTZ
 Ie1dVRJDTf5qtFAHVt8fGMumgIbX6zLDf/32F4XfK/Q4dtbU9YHVs/SA5GOk8ytsoI3p
 s3N8eQaEQ9jIRS9+jwKCmrV24CTnUKiCNOk8KB7dxcPLQTSgnI913/68UYiNkZ3Oqwmt
 9NrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781600789; x=1782205589;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TviBoAjlXMOEoBtlXOL46Y+sZzT7YdfZDVU/LFfsq6k=;
 b=bBXasm28S35K8OWf+iS2xMvjqRikLSCEOd6CQKCxjGgyOIGjmGKoFeT2H1h9PsdvuK
 uLehtJdTLsM3M2tvS8BhQRz8DvqDo8CwOuSx2JkLf9R5bM+K3jM9EWvuc0Jc5UwPMhxU
 I+3mJQ5Cvk1QUJL423koJImqJgC8TSDtDgvB7ybD9I3n8ytJigAy3Qml1IYjRPbVQ3T0
 7jom+KEBabF4klyfCx26C20z+tF+53FT9QauEMVwGSQgNvWFUD0Z0Hyg321WRJDdMbQW
 O47sc/JX5FOdVVBwazcRuisECHQ0zyacyC3o3QHBLjuHVg5LtRCfWBP7LD29Z1mhwhiU
 8o/w==
X-Gm-Message-State: AOJu0Yy1KjRRkyDOOEowVDgtvJ1zrrn/pTJ3DHlf9RbJSVltcS8WsW2K
 rAjQRYg026qQ2KjTOAJ60P5wseLcqeVT6ix06l4nI1Lf522NVJbPBAuuigH4FJIXYEjVCWoYlIB
 Ad9yYiJGJdQ==
X-Gm-Gg: Acq92OHYdbQk7CmiSH0Y80xDLB7QmNv+1AVaEJsCRWGwiB1fgU1vQejArT72ES/etxi
 KOeiQp+PWO6cY4hN6IsbDHAneZH7lba/71ksYnBgtx/4X/yQhOG3nSCPfZw17wa30A7yEyvxiaE
 CUjU2A1b21TyAhWxwg+SF9tH3xMwb3ckl8khb/+GyW54Ks7nNespY466U0EaJMHVKq4CTHHMKBG
 ALXyyJtEiriD1KdZsbaajFsb0irWTKugFiJJN5QV1BRQtqypZkYMuJq70CjeesfO/ZUiXuAIyTC
 YF7vTt8PPk4hDHXqbbYDMnMVj2No/FX1tEXNqZlRXq5ficMxJTx/486Q3j6tjOaLzG9JDdWW4v0
 f/vOjNu8OZyakj7R/f2ZvzR+2Yrv+WI8bXNhQGwt4uLKBgz/krbcC47fkgUNKxgHY0LWxd3EutF
 kdcU7hY1hj5tMeV5cklDesykcxx5JIoTlf1MSadugnlQ7Fyb2uL3sCfQM83Qe7NBg8u0WsDY0On
 riV6mMh0sn9DcReBBRVLQDxkOmZgHXF5gg=
X-Received: by 2002:a05:600c:4745:b0:490:d32b:39d6 with SMTP id
 5b1f17b1804b1-490ec4fe770mr237199735e9.19.1781600788721; 
 Tue, 16 Jun 2026 02:06:28 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4ff67sm43492035e9.6.2026.06.16.02.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 02:06:28 -0700 (PDT)
Message-ID: <6a311214.459cdc55.395752.6be4@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260616-fix_clock_gettime_openposix-v1-1-ae4ade48039d@suse.com>
Date: Tue, 16 Jun 2026 09:06:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clock_settime/4-1: CLOCK_MONOTONIC for timer
 validation
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Please ignore this patch. It's not correct.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
