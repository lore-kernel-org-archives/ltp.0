Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B8EF433D6
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 08:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776412849; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ILZ9wj+Rmk6IPGxdjHv4AODtsKeDfhvBUR4ZZ3u07ms=;
 b=LbNdHJswH3oofcIF8MwTrA/fUKQhz+kZHY9QO20uugmkGEjI1oh+kh3T2EyXcorL9l2v2
 r9iDk3f6fwqZ44LwkxMUv0tZ/vvvAKKBwjiFkqR9RWEDva1Ib9k3pR8vqluNTYcCcEAKpQ5
 Bab+6l2d1zP9nFA+Bl6Y0EaP/NJin1k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 644AF3E268F
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 10:00:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EF443E1BBF
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 10:00:25 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2DE2D6000E9
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 10:00:25 +0200 (CEST)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so5954305e9.2
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 01:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776412824; x=1777017624; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ut61kuNUHwId5Tj7dpMD0FjalvGSlLRlHK1kyJ5AFJI=;
 b=VBuYi5qm49pa95K8FDB9VDorYtU+sVKeZkDP0LZnBcwyBmnLfy5OJkRZ146vGzobKn
 jN4mxB+DtYnDG04rtaO+aWZiHQhnVPIz/vldPL3JHomOq5GkUmsL8rHCA3TUKOjEtrD2
 9cehm6MNoOOp6lunj234szb6gsmwBr4TmjXmS/9aqAXhVsbA6TH6IXYF+66iSyXeIi9i
 ZuKxTKxOg4q9QICggfpaw/myQw3JDc4gqHJd0kOrALK4+x7MaXb0YV6jaEofenJJdi9h
 6A+oOgPuZheu5i6AsPrPQst4eBmYyx08IN/Kn6W0HqpSxgMmlhGLl5h2ycetwKIdYy89
 eKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776412824; x=1777017624;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ut61kuNUHwId5Tj7dpMD0FjalvGSlLRlHK1kyJ5AFJI=;
 b=MHiqnTZ8evjZhRKkENbYLYVM6+78c8kvhO8aQU52NyggUcY6JKO+TqbwRP5Odm9mcm
 XeOVyzJyrbrbD0XaIUV/MmT8qEVmbAj2h/guqxbJ3OZGlRf48DOAW/v76sw4jenoGy53
 fS5ddSJ5IYcpYOkc+x0KwdpuuGq2+nm+nXAN6G7+LLoNXwPmZFDyvj1tg3QoYoyaxtMY
 okCPG2zPcasTgvw3ajiB1XSuSpxjlS585fWtBdbRLHQQULRUHUWE0zmcX75qeWOFbD8Y
 eW8JdobhFyjpxnN08f2svZ8BOMqhyJq7guINXBfcHBOeejke+HA7UW/FC7QqUXfP3xbi
 2Hdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FAHXZ5VNcGhAkKDRXvK/rUORDKek055oLh/kUrJ4gff+I3wAg8Rr/bflrtekT3lVGfrE=@lists.linux.it
X-Gm-Message-State: AOJu0YwwYX1F9TPjhiAEMxfTIyqI5PPze0aM03HUDQVEq76S8leTvszd
 rMkItgCjD+mK2DbdRXx7x6861bsXp/0pqk4ARqX6NT7YveBjiOXqwSn4DTT2z2b/7IHUHKVvF3A
 KAFzitZE=
X-Gm-Gg: AeBDieuS3Lr2Bje5iySMCwfj1TinblawJjI+NKEE8x64D/I9wRYaDF5uit00NSqLN7J
 3vjNsAJQF0yOINZjz1lPFBCEYS1+U/0/UnDTLQv+8n/gePZeE/+3I3aEJae025Dkmxqp6dgZTh4
 v2Tt01+hZxgLw00Dtg49ix1boCdeHMmZXKE38fE+6Vd+V4l3RQRRbspU1AYZ749Ic/5hQP2F3c8
 dIpSK7WwIPY8QUb9sNyg5NQhbIwPjPKZWj5yyqbtyXyO+GQj76Za3F6D53KSjO2hpo0vsDFbDue
 hWcIbZ30ur8w8VxXa79Ww4qGbKqWRi9hkfrkkTKRSv3YJyuU338xRofTSgHncQb2mlpLPxr+JJu
 72IcIiALDf7fa511A3E0OWmj6gP2zc4zFH/WhruG3IgrBe3dFnRQlFOADM9/vuVylhDAVba3And
 uelID21Cdi1jF3PebBnAmtDeJ6UretuPhju5SFb7nRIfxByWqrItrBH7oTRC+lp+370VGr7tig9
 ALtgl3GpEwUGQWm9oTkojSXq0CJ2iypm0A/+mDSlV+bTA==
X-Received: by 2002:a05:6000:18a6:b0:43d:1bf6:30f3 with SMTP id
 ffacd0b85a97d-43fe3dc117amr2478678f8f.14.1776412824380; 
 Fri, 17 Apr 2026 01:00:24 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a381sm2850858f8f.21.2026.04.17.01.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 01:00:24 -0700 (PDT)
Message-ID: <69e1e898.5d0a0220.3d12d2.9738@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260417075538.3930-1-linuxtestproject.agent@gmail.com>
Date: Fri, 17 Apr 2026 08:00:23 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mremap07.c: New test for mremap() with MREMAP_DONTUNMAP
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> SAFE_MUNMAP does not clear the pointer. If setup() fails on a subsequent
> iteration before SAFE_MMAP reassigns fault_addr, cleanup() will
> double-munmap the stale pointer. Add fault_addr = NULL; after the
> SAFE_MUNMAP call.

The SAFE_MUNMAP() call already set the pointer to NULL, it didn't catch
this error. I will fix it in the agent config.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
