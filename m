Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FBACF6A85
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 08:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767861381; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Sc/eht/AHnhylCpyggm/FkJNmcwPiRWHauvCr5Ox4N0=;
 b=jQDwColvQaq3wwo+FMJ5KmXBS6QEOAqs2pvSpeI33riFF5ZHx+IUUJ76si2Rot07q/Xfj
 9TDRFAtZOaOKyqjcuJrOSVEebnfaXYfuLEIChSVVgvflbBcekOT8QVdev3uUV310cnszedB
 O2eTxDHTvANAsBM5v4svsSK3AZwB8tc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEC763C54D2
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 09:36:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 069D23C2CC4
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 09:35:58 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 71B3360004C
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 09:35:58 +0100 (CET)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-64dfb22c7e4so2889836a12.1
 for <ltp@lists.linux.it>; Thu, 08 Jan 2026 00:35:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767861358; x=1768466158; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dIbJ2wG1G5xB50qIGGNVyEXqqpkzu6R16wRUBrsWlwA=;
 b=Fzn/We6hq3LlRpAQ6oSwR80k+KHNXfO4oCgc0OZMgBUU9O0fSPuDrtYXgs+v3HLQkv
 b1HfbAbeuEBUq9rdaeUZlVkC3Ehlt3p3tRK15+JWmbpJKuYtExRa2BkML4JXhbp3PJuR
 cNSX2wjbwsiGYxgk/lrtIKzIk845hJ6P22qVS2h358+CF2DgaOOntvNhhVavdVAGmEYI
 oIcNPv6ydzLWIphQauu4V2R+XmZeqiRaaDWzhhH4VSMgiR2WPaW10iXl+L3iNdJmYUDE
 TCdg9bG3EgQfKIjIrNviMeyRTA0EjoN0R3+lRdACLA0r+HDnV7jccQ5dhx4FgQBIvgn4
 PNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767861358; x=1768466158;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dIbJ2wG1G5xB50qIGGNVyEXqqpkzu6R16wRUBrsWlwA=;
 b=dtAZ/22za//olZxVx/BojVV9NMGa7vbVzJwN7bFhfWBuc3qO5anenU1+NcPWa2D52a
 IxMGAbT4rl7O9YnodkkbVPwh6X2hBYtWDriudw3T8XzOiSHUwivkZPhAWe/wy/dzJRDJ
 EXiOXpe8SQApsYFVZ013eBjNqOy1y1KPV1ArLNbmB9lkUfoInIVX4HXIqRF+ARbGpHpB
 w0v29rqKHIblYCc/gWysWq5LDK1VC7zjXZQcCkUGd7cGIsFzNz+aKW3Efn/8ZIU+GWgC
 7wJrV+i7S7UAp2wm5vMQIzVVg5GgpU4w2S+oqzvLOcrcDA0U2yJqt2VSI/YnseN0Jh86
 /d5Q==
X-Gm-Message-State: AOJu0YxWW80pAaoeakDtxBVbfUMgXaip5vPtKx/pMkHHUqfbMVg8/nuL
 212mpo9iS1xkwfYTAOsr40zXeL+DXc4GBSCMkINazEm/2MZeyayLyyh54BQPFeJ4Zrs=
X-Gm-Gg: AY/fxX4dTCHstXi84kLVEDZLhg27GKcn2PZOByplmzUC7FB1pt1gH6fJxGAs3qxomxv
 8YH43dNUB51GiJoKhxyS9cG83XhveaacPksEud/c6kQRakqe9Zpz2lz78tkIZgzIPjSDCgl/5zV
 wfQFhK4I/fqARG5NG3cr0x84meUJXZUMzP4fFAT1jv5pZWb9qXtHzg/G51kMNsiXD0yJfTbekpu
 seQ5gDnNMpLZ+K6yUbBTsgez074e9irxgGrTgIO2mQ3aqQiLPwh05UK3rBD6ljgKpIJ6Yy66uUr
 yHE+6/qtBtZ82zLETiK4P4gh0FkzqycD1BHVRCUFXbonxmcVeRfMUG9n77X+2hjUFwWj5L0lG3U
 3SoHQ4c4zFjOyDs8zMPm3UGr+8MqPSf32Zi7xdVcvjnbmAJBAcgYge2pxRGbu15Dzn9pUjJ+Ial
 doUiVL7s9acUIMi5eyPPqB2K22rVNCvRra8bodcQFFjOahO126WQQ/rZxBFRzIbJp5Vv0B47C74
 GOoDAk=
X-Google-Smtp-Source: AGHT+IHcVSESfJYtxkZyELkI2PBTqebwl4gBg2Lwxv5SYhIa9is++h/P6g+E2Ik/cJgAWKOjVOdIdA==
X-Received: by 2002:a17:907:7f8f:b0:b79:d08c:a7d6 with SMTP id
 a640c23a62f3a-b8429b97ffdmr913083166b.28.1767861357738; 
 Thu, 08 Jan 2026 00:35:57 -0800 (PST)
Received: from localhost
 (p200300ef2f19f800fd6433c69db8d45a.dip0.t-ipconnect.de.
 [2003:ef:2f19:f800:fd64:33c6:9db8:d45a])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b8c4479sm7058744a12.1.2026.01.08.00.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 00:35:57 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 08 Jan 2026 09:35:56 +0100
Message-Id: <DFJ2JRL7LR8L.3P1WOI00EDDRI@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Stephen Bertram" <sbertram@redhat.com>
X-Mailer: aerc 0.18.2
References: <20251104193942.4080083-1-sbertram@redhat.com>
 <aQstFByWQ6Zkz6ZP@yuki.lan>
In-Reply-To: <aQstFByWQ6Zkz6ZP@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add config check for systems that do not
 support CONFIG_XFS_FS.
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Wed Nov 5, 2025 at 11:55 AM CET, Cyril Hrubis wrote:
> Hi!
> There was a bug in the test library filesystem availability check,
> should have been fixed by:
>
> commit 5e1e0e2d81e564df09542b7caa2a66928c05dd3a
> Author: Cyril Hrubis <chrubis@suse.cz>
> Date:   Mon Oct 27 16:09:24 2025 +0100
>
>     lib/tst_test: Fix FS kernel supported check

Should we reject the patch?

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
