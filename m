Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CF5CA5FFC
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 18:06:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5AC53E9DB9
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 20:06:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1929A3E4B92
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 20:06:29 +0200 (CEST)
Received: from mail-oo2-x05.google.com (mail-oo2-x05.google.com
 [IPv6:2607:f8b0:4864:31::5])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AE0FC6005C3
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 20:06:28 +0200 (CEST)
Received: by mail-oo2-x05.google.com with SMTP id
 006d021491bc7-6df36d0b4e1so346541eaf.0
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 11:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791223587; x=1791828387; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kcG4CafTLfHp/r9Z3CP8uK5jDanbGLGFcGGQzV4d4gY=;
 b=Xs8tymZm02nYW76B+THaiB7/iURPcGwuWmX/14r0TF9DpFGHzX8FpeXBcukTPJppH7
 HDD2vv7mZMVtTzhG60AKBz7hF4YMgoZ8sQHpFzE6N8sLjvspmm/0RFcUg+6+TuDa8kxl
 87RvXeLb2VpCfb7+a9BxCeCCluzbXmK7KETNTJJIjUKF3GnV9jk1+LkO6VgxzWr9Z/xo
 ijyIM3L8y5WC3AMvqQFwHsZMV7bGyvS6aUDvJny6ug5Bt65OXXDdlDvPF9CqCKAMXTo5
 CAgCWUG8Kf56qzfyQnWDCN8XfWZDLnbJ/o9aLZ85aKl3Vk+KREXSRDFrb4BBvpmGkBx5
 iiRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791223587; x=1791828387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kcG4CafTLfHp/r9Z3CP8uK5jDanbGLGFcGGQzV4d4gY=;
 b=us25l2z9Mj415skdDH5HEWlpJNaGKKEP3j7BpX98VRv7tWl7TAYinQl44/D12PanUU
 dJwWf1GmrdK6H7wP98p0I9jcGnyFa8yDp54Lk7xSfbM3/9rEE/dRT0G7In5I+0gShEsJ
 3MSrpfcdKxWKgbcGIDWshrK9Ho4A7ZWiXr6wgOzC6e+tANloQ85CVuonfISmWBXmI+dX
 hoKuQrFxkE1oljFLXLjRhlBZqJSrSlKkRb9XLful6p7uic5PFTdR73Jh2ZxDUYNJQCI4
 e+Q+w5MJk1FSxQsYP2sZJ/Ivl4Ce4/EifY0usZH+ZqIPdiNzt/yTYG9tPo4dWrUjmEfk
 yqVg==
X-Gm-Message-State: AFuF++nsionnhgMGrg4W4FdyKDnkdLWHasxSXyovBZ7E2SmU+r4f6GnA
 t4N/NuBVyxpO0Cxy6b5DZffvJHaiPHdBAvcVsW3zDAo/JEJI1BnUDuhG
X-Gm-Gg: AYBFou1NVEgs9RwZ+2btvJTu5tJJcswzfkc4Z8SXQVxA2Tq645Z+ZPX4cuTNsV1Gx0x
 aAelPZfrp5XIQQvAgM2u96bdW34KngqS/3YUCsuarTgrVX3DX8P2zy+87gRl8dcoG2vtE9DPBPm
 cBNpmssNKxdFhabrX1kNPTrWwrJpn8fO280ITpIYtgw63ZSnPfUsOKexkuj61jlQTuNvZh+MZaX
 VkP6QVcgdWAZPj4p5COrcM9BBLxfAFYc24yCFTo0b1hiSXMCJwiPuM2Nd98qYPsGXn/u3dlS2p4
 fzdZz7ktOP6wAResImeBnk33otQQWmuURZBvHaErfuW7Li/Y6nS0EiVJHWqecrE+NvktuA+1BEy
 gCINOBSCTjsac+iKiUwbpy9LAjM7FuKVoweDvfR3kK5crDE0PzZVWw6JMVZFdfqKnNN64hbSx/I
 GNyaW/ZocS7nzujSVeizLopnhCowl/ZVdepHpkU/eS4sEXFeI+X85bFAi7seAtRn+zJSTv7Rive
 cYzi5pY4vfjdHi34bNiuZ8EKaZfbYd7m9RW0HTCaJN0kH/LE54CZy5sYcqQODjGoqeCPPq9QjBs
 sxD+OpOMF7k=
X-Received: by 2002:a05:6820:190e:b0:6be:7782:5a5f with SMTP id
 006d021491bc7-6df2f40435amr10085518eaf.5.1791223587206; 
 Mon, 05 Oct 2026 11:06:27 -0700 (PDT)
Received: from
 runnervm8df0l.tsmti5buv0aevewz2pijjmw21c.ex.internal.cloudapp.net
 ([64.236.193.16]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e4c04dce9bsm104266eaf.1.2026.10.05.11.06.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 11:06:26 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon,  5 Oct 2026 18:06:25 +0000
Message-ID: <20261005180626.5304-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-3-fec334ce8e80@suse.com>
References: <20261005-fix_core_lib_deepseek-v1-3-fec334ce8e80@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ujson: Fix 4-byte UTF-8 sequence decoding
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

On 5 October 2026, Andrea Cervesato wrote:
> ujson: Fix 4-byte UTF-8 sequence decoding

--- [PATCH 10/15] ---

> diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
> +	if (copy_str(buf, str, len))
> +		return 1;

Medium: For {"first":1,"bad\q":2}, ujson_obj_next() returns zero but leaves
res->type as UJSON_INT, id as "badst", and the previous integer value.
UJSON_OBJ_FOREACH therefore executes its body again with that stale value.
Set res->type to UJSON_VOID on ID-parsing errors in both obj_next() and
obj_next_filter().

--- [PATCH 11/15] ---

> diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
> +	capacity = len > 0 ? (size_t)len + 1 : 4096;

Medium: On 32-bit musl, where off_t is 64-bit, a 4 GiB - 1 byte file makes
capacity wrap to zero; doubling zero still yields zero, read(..., 0)
returns zero, and loading succeeds with an empty reader.
Reject lengths that cannot fit the allocation before narrowing to size_t,
and check the allocation additions and capacity doubling for overflow.

Verdict - Needs revision

Pre-existing issue exercised by patch 5:

> if (ujson_utf8_bytes(ucode) + 1 >= len - off) {

Medium: The new surrogate-pair path reaches this off-by-one check:
["\uD83D\uDE00"] fails with a five-byte output buffer even though the four
UTF-8 bytes and terminating NUL fit exactly.
Change >= to > so an exactly sufficient buffer is accepted.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
