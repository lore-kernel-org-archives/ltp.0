Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A71BFC5DF81
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 08:56:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BBF143D00CB
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 10:56:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 492C23CFAFA
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 10:56:00 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E6C586000FE
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 10:55:59 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-38dbe53179bso865701a91.0
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 01:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787561758; x=1788166558; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t22vuJOfPja8/At93gr1iFqkPspt1GhF2OKvPKMr9aw=;
 b=MAli5iLdK6cOPFDWil0YRgo6QC8jLVg+1hUscEqhK3a3LST1y4tPta/CpB6lHMHWv5
 kNiY8rX3jWNkt6iiEBuAR3SZ6DfNoAivc2hCtBQ2Oln5blRBrMR4Why3G+uZAOU4xbhH
 fOq4nr2GmcdfCN2Sz+ogfzXOSB5UxTwWMLgcjhAtLxP3152mhbLnUqc1PS5QOaYNzFRy
 Pwi2keML25FgY8RHDAXuQ+eir5hwLatEysHzHXcgkaiq+wkqqAdEGzn4bZGcWlQiVtaK
 PM4GnJAutrSIYqYyjJCRzwHW1OJ3zTnxYyBB7GqHl4DPP+3+oNSdS5tE7Bt0HQ12IpWY
 AqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561758; x=1788166558;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t22vuJOfPja8/At93gr1iFqkPspt1GhF2OKvPKMr9aw=;
 b=IR3GEtB9bsxMDZZPuvWQQzMO2k6vLh51sZq1ZjO99aVerH4Yr5oV7jP2WH6bZxEKm7
 pUGdj2jeEAX3buWt0zgtpTW1XwGGR7GLb7G74aK/3SgJQCYvK2w/ku5q9wPbKP17Bbxc
 blumlFV/75Ns+eeIvPDeLa5NP/TrDzb4LeBeNgMlanIeALv1Pf7AaATyrWKYb+GkrMs9
 bVp55rb3Z68VDrLUXnCeR0vKMsxKXEbRQnhW6+utWqpXr1ii0eqAA7dIaRcnwKz+q9Qg
 fo7+cBX/S5dUCeuZnn7uti2M1N1cWN+dFx0mVBP4dVJ5doqEb/pxBlrtlurOJvnOnJ0D
 oL2A==
X-Gm-Message-State: AFuF++nR0BUDkQUH/hxUfvIR77PHgLjvg+rDm+1Jf0ylb/YOzitYWQcc
 5Z1t9C34V0mh3Bj8q1Y3Az9Wy/dz/QAV9OW+nXXtbCAB1NIPdOi5DHD/D4Os2Ygp
X-Gm-Gg: AR+sD11DDNiE4Gwq0k3fNx5TE6rvH+l46ulKjoCBNvMwBB51yyKOxmLICKHLUwq5rTx
 63ugH13HK+uxqjl2T/aGRKXhfIbW4+39lvvF7uNkq03SXI+eis0VYo/CeznSVWQmQtqXym4X74s
 JlYx2Xmo6XpwEzUylI0WSv5XZDXnz6UQeIznxwlyElQZeSNj3PAPymJ8XNmOTre/8GZdpFLr9N7
 uCi5HRNaQ2muG0btEKFK5JRt2OMZ0hIFNPNqn/GIGGEKq5YVugn3dg0UHmIerESYcVqPl7aedTi
 b5w0styIfO2nu6pTsc6NgvKOti2sohbzN/+Rg6vj0AhojJtj3DbZ6Snas2pZEzZp+UNxWoCNzcW
 1moCJSBxO/MmwbgxUtHG9uZDIENmA0uAyq2IgyiWJMXj6kE/UCV0jnmCiwEjvowAzJIqSAou8UL
 ZjwxMdvFCEp0bAygSkV3sPEZmnworOR2bHuZN5sb7ntR9jqD0TPOS2rH6nDj02mZ6J5AZe4B5fO
 c1U4nVYLXD2F4+Idj5DjDJZeIyA1p9bkZ82Lxk2C14Zr2KQLs2DhMN1ebffTkUEA8/rrtrjZ/04
 RC2y91BcPBvp
X-Received: by 2002:a17:90b:53c3:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-395c39cbc42mr45484622a91.11.1787561758174; 
 Mon, 24 Aug 2026 01:55:58 -0700 (PDT)
Received: from
 runnervm76f27.kbcd0ek5nduelhqehr4h5sjzfe.yx.internal.cloudapp.net
 ([57.151.137.153]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186173199sm22367655c88.9.2026.08.24.01.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:55:57 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 24 Aug 2026 08:55:56 +0000
Message-ID: <20260824085556.9091-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824-coredump-v2-1-42428acf5216@suse.com>
References: <20260824-coredump-v2-1-42428acf5216@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] coredump01: New core_pattern specifiers test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

On August 24, 2026, Andrea Cervesato wrote:
> coredump01: New core_pattern specifiers test

> static struct tst_test test = {
> 	.test = run,
> 	.tcnt = 2,
> 	.setup = setup,
> 	.needs_root = 1,
> 	.needs_tmpdir = 1,
> 	.forks_child = 1,
> 	.save_restore = (const struct tst_path_val[]) {

Could this add a CONFIG_COREDUMP=y entry to .needs_kconfigs?
Without it, the ELF binary format has no core-dump callback, so
vfs_coredump() returns without setting the WCOREDUMP status bit.
crash_child() then reports TFAIL rather than TCONF on a valid kernel
configuration.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
