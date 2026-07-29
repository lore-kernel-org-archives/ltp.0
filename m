Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98075C53219
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 06:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785308082; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=B57DXaQ4dXbTnLYBrZLFcS3477m6uqgcBV/BKH5kFKw=;
 b=a0/xh8t8btKJYtCuaeoEHAQE0FRjELh6kbpp1ORlqx6sL1O1zu4pI5I0Q442WemxocZsv
 qNUlDtscBAnDf7UhWlIxTG6+d9Xv+NFtZ2yPT0gDnBGWT/Vswarjfwzjy9NGw2DHogMpjxF
 qQiF8ouQKDphtPX5EUz528pJjS+190c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE32D3E4B98
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 08:54:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 332483E1436
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 08:54:21 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D88FF1000957
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 08:54:20 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so4367015e9.0
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 23:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785308060; x=1785912860; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4vOVaTFLPgv6tfcUdgXRDjI2ELjjUlEnRiyMnzNz27o=;
 b=BndPLbNsbTjWBdbkcDHlSjDtZlSB2fpy4JPcGcKUNjQwYGiRZUKVW/o+Hg7xl/UvOC
 NX9M3ZUSER7VNMBGJGolJdgxDnN/Qi/JorLnwoo1Ciu9twpFcGKnPdYrYVSrD6cFdmHj
 DaIjaZVfopwgeyAMyR6OFrV/1G2EytRLZlJevQy2MC8+X3r9MyBqaMLqgYY/v9s0Vsab
 pxvJRJZzEsOwWFkMcg6JoT/6deEXhzDCpEN39FtLvSaPxdOoCdt+CRINqKTnoQC06U+l
 7f3OjK83JdIB+ecW6By9yUGT1uk7PZPsgx5FkvE/3Jp0DXXY9B8c6afNJ/6NO2d7mN6J
 T4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785308060; x=1785912860;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4vOVaTFLPgv6tfcUdgXRDjI2ELjjUlEnRiyMnzNz27o=;
 b=q6N5+nic3gFDQFHmZEZ5h2oitIqFsdnua9Aq5LNjHtmzUm31Y7A9AStX/54HWtXaOt
 YV65Y23M0uVsSgFwvHOs/08ZpVerzd+RFvNiZE3C00i1h3FA+mL6E4iM7axHqVoSsG3+
 oxHfqSsShrcw0zrYfiuBqYCm73OXtkBoIDBzUnL5eyy0zccPeI6jO60ka9qSOOL6RtGn
 7QcUWgfwL2NEw/0j78fCy9+cPZQFfsMYuNPjYlwaDXlxaGc9ywFRsGZrdz2KgcjXPkjm
 CLf1bI1mYfGPMyOMevMz3wLHoJo/OU1M5rqUznn1Bca8XJfpMrXXVnzOD/His2gKKst9
 gscw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGT6xqTRMhVAIx7tBfh8dk5PV4iHDYxz1m/mg8bI1cevUDWCrABFJspBkug/TM2455SGc=@lists.linux.it
X-Gm-Message-State: AOJu0YzHiyJI4nVwwa2TPsn0MhVv7CSjbLF+cpgnLUjFxVLysomc7opc
 OM38T+L8xAvjRohQW7LHWQmfow5yw9haTuE/9lG2xX+YJDIHwLrPc5/0Op51fmW5aSOj4ghJ0rd
 SR7eIutnGnA==
X-Gm-Gg: AR+sD107ekbwnz0+8/JSPWo27WGLEkYAEpa3RgLx/Wjkx8N5zfyxLvzMEEtQjHpZEqL
 ltAdmwjNatb01NAYvZ3DXcCAXnFgm00p/y+z/xgVPaHzD/l8kR6nTYYZIWq0c+GPM9yxZ033Bv0
 vauTQbCC4AWVLuxRb+h+E6QJJnxEICTb5yRHLjpYH3wQ2hWnczD7G+LUxdMKmJvHyVCVXrN6lAC
 yeYE/LMk/5R4+h/GNkqCyaTFZXoMBRFQxrp520QC+uzi8AM0ibpNp6NHDYfElvF5chALv/3ToHF
 BbcuAwfmIkUDgJ6DvjI8gFnVQ4abLHS/3QAUuTigMFLk8sCSm4xO4nTK+IDcCYVhs0P4dkISqid
 1Mm0faNz67CJARGX/rSulkzD8jZqzcRq3uLFmoBkycAP1dHCo/hfn/F+CzzXD53q0h/+BKXs5BO
 VGBJl8Xi2HPGFu/KmpftExuLPL5vEE9/3jXQneHnzPb5l8OIEwS5PD4DlQvUYOX9/Qnx5YSwsW1
 HNl/N2JvGxmn/uuLiMH4f+90c3u9rlA5vBg5BC6nwFzo/zd1ibU
X-Received: by 2002:a05:600c:154b:b0:495:5eca:f9b3 with SMTP id
 5b1f17b1804b1-496c6574846mr58541475e9.26.1785308060217; 
 Tue, 28 Jul 2026 23:54:20 -0700 (PDT)
Received: from localhost.localdomain (ip-109-40-50-253.web.vodafone.de.
 [109.40.50.253]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb647a8d4sm5339974f8f.0.2026.07.28.23.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 23:54:19 -0700 (PDT)
Message-ID: <6a69a39b.a148a86f.57214.897a@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260728133556.GA1128467@pevik>
Date: Wed, 29 Jul 2026 06:54:17 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_setup.sh: Fix check_policy_writable() for kernel < 4.5
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it,
 linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> > - "log" is created in the test working directory by
> >   check_policy_writable() and load_ima_policy() and is never removed.
> False positive - file is removed during cleanup of the temporary directory
> because all tests use TST_NEEDS_TMPDIR=1.
> 
> > - $IMA_POLICY is expanded unquoted throughout ima_setup.sh.
> False positive - /sys/kernel/security/ima/policy does not need to be quoted.

this is kinda normal (unfortunately). As you can see the amount of rules
for shell tests is really basic and it doesn't cover many cases:

https://github.com/linux-test-project/ltp-agent/blob/master/rules/shell-tests.md

Feel free to create a PR to avoid these false positive.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
