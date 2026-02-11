Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB16EB597B
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 08:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770798698; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Qa/Shpf+tSoXQsS1Ej5e1IwpM7USC3V+c1fW88iH/Fw=;
 b=NK9eQGiSVTuCbx49uA1Y6dM8Vd0mEGPf42rliWAY7AlooXJxpoBcYa77rNWeTgoibCOZk
 hMajC4rS667ZFKv1rGrNNL5xzZmHC1ctEIZ0ijgYdhMlUdCd+dztcDex8pnMSQ7Hbsxn59g
 uyhuqQkT86/ibCKkozTXfW84Xv8HihE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10EFB3CCB2A
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 09:31:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2678C3C4C25
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 09:31:15 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 89226200ADC
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 09:31:14 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso5663765e9.0
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 00:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1770798674; x=1771403474; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mCG10rRVpEAtdFWdaBF+BSnf2VI/A4l8/lz2oFzsm4I=;
 b=S1LaJVKxbgOrug6nkdODqoliss2mLbV7jv4UntgX2JyT4uVEchsEsMoNtfWEdp8PUC
 NLtv2vS5KsMdf1QnqciIjorO+3fDzA348BEgWLfxaQneGogh8w2PbfxMDcMF6UwrcmK/
 mq7rLyxh7gM415MpV9DYgME0nJu5frG9M/ay4dyYkUQro2Bkvi6gsdjb1tKlZUidmBrX
 egcsGw7LG66xaWV6mBz8fQW1xkk4rwG1Ld48JAFMHhrAUbENDBCzvYEFNgPZlVTUG2yy
 YvsyftStI3ghSeCYQ8I6sYLkAGwO26ZxcYZNWX1moQ3Wvz8xlDbSG2GMfSnv3wAI3+NH
 1I/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770798674; x=1771403474;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mCG10rRVpEAtdFWdaBF+BSnf2VI/A4l8/lz2oFzsm4I=;
 b=bNmerlmdwMUWTciGu/k+z4ldHs260YxGFVUtoYvCmKJ8nYwwLeDDPZJKk3ckOxC4I0
 /2ATC5Q0prVlxndnDi8gnITa5XjkHvtvCFBkYLnwWEWSe8Rp5b6FhWzlFA3F+P9Hmp0g
 rOOjVtGd8fQKmvRxVC7JjId8iAvTjx670cAlIqcR7H7cJxhUPjiMX5emQDakysCzgzr4
 pVX9Ir+kz/NMfkLtDDU3jeJd+KSC6pXmWe/fzlaKY2rFB6W1VroUjBem25hX2jNHs7AY
 sP7orN0eSX29jKgcjav8888TyKdZgDU1eIKWg3bkqoMoDXFddR+HFY+3BOXxnlc2WGbn
 2DFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVE4oa75U0MKV1LmOLm+vKZRaQUvHTLhm+syrB0yxeZmyMV6w+J1GQ2ckzXz/MAtVYj2U=@lists.linux.it
X-Gm-Message-State: AOJu0YxfuYjn7j+ntTVmNs40nH+TtQcpPHjVYq/rfzkP3i6zO8T9QggD
 REkQDEvujPUkjtBA3B1w24MngkkwP+2E1ysmvXFxkh5TzyLXJ5AAC+W4yBJrB8WCyGM=
X-Gm-Gg: AZuq6aKaHVHlVFDbwe/si7pAkIceh/odluZuwIy+cghv1u9gylRsuIC7l95NErXmugJ
 m/wYZ6ezb+hjfRf1Xdi1OSc6phXVa3nSCxhVl8y/P/aKiONLyxYWy9vOrOx6ULH7kQJAQ5op6aB
 UPzboO3bHK3w/5YsID9BALucTS/IBRmngx/llkUmvbAxvFaNeVv2xhqusRqLDw5gMryRTtU07JE
 +gaLuDP+mmq5tbsbmeZaFM5B1pFG09HkhwXryVHogAvHNUggzGwWHnFg2GggXCUhz25Rekf8St8
 kMno7nJqXfLWW5sa68ewXIVlSD9TM/+mWj9MHjaJHk0YE2p0f3rXbw519suBqt81RTKwxe75WKe
 1zJcb8TAo3okqQh3U5qaDwcA+abtTsyl/VODjNVs0ekAw7n6vO4RRJxiTPDBJc21TyOtLpPt00V
 mvTMhjSaac5P4HXcLjthvgLRmzvpbIqLinbN+XaY5fD8AdzJRhA+0t+vZ6KfTQjW9U9gITTV5FV
 1eEBHG30QEt+3nRyTrA4BkajSbIbg==
X-Received: by 2002:a05:600c:548f:b0:475:ddad:c3a9 with SMTP id
 5b1f17b1804b1-483505451c0mr69670545e9.13.1770798673687; 
 Wed, 11 Feb 2026 00:31:13 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d9894f8sm25780225e9.3.2026.02.11.00.31.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 00:31:13 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 11 Feb 2026 09:31:12 +0100
Message-Id: <DGBZQNUV1V01.2NQL451V7SP5Z@suse.com>
To: "Stephen Bertram" <sbertram@redhat.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260209192812.2763299-1-sbertram@redhat.com>
In-Reply-To: <20260209192812.2763299-1-sbertram@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Harden parallel worker execution for
 cachestat02.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

LGTM, but we also need a commit message. With that included,

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
