Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B1C3FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 07:34:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28BFE3E289C
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 09:34:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7A1D3CA104
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:34:36 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 82E5A1000A06
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 09:34:36 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-12c8ccc7755so13334181c88.0
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 00:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777448075; x=1778052875; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4kxDvjy65kHIR2Oh+m4gqYUuJvYkT+xaImiMINzCtc8=;
 b=me4nIWZXEM/fANA/yeQ6f1uBGpXmsKkKUB4xaDYcaVLx5RkquQG28Ll0WIE0Z0udRY
 b1NG7Owk95q3estUF/FndPe+++5fYRSNrAoKnY9Tro2/kj+TWDVIu5JUVleQxsYUa5Zv
 6S1wP9KkfdXUvfUEeDqihOGwPA0MjEnZc5I0LhHANnDvapOwTQRrvCcZrdn8obNWelwo
 EISXCRR/t+P1PLMSpizNOFfVv/PShV3vSf2r7/HeUKQDeyyI91MhyEqenqUjKbPyFRHn
 GwhrbxsOVNVTImn+PQ2QZZz4uLq5xp58eNJzwgnoJvKmdLrwlxON2xEHL+d3GZs51p4l
 UZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777448075; x=1778052875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4kxDvjy65kHIR2Oh+m4gqYUuJvYkT+xaImiMINzCtc8=;
 b=II9VWYR7XrZc3L155ISf8hsltwbPobZ50/Q6pjxEfvFmFEw35XOMasfK6uhvrfK1zl
 /Jgvs/z0FbhgFX+wOtzmvEM+cqtCTxw6DCiGzBqLAwyeBpMtU2Oxj0SZGFr3kbHKaKss
 FlaA2XohCYK/MiqLM8nYwwe/cbW35Omc7kOC6DIvrBlPa2/c7Z3xLt9qAmUNuT+6VkIW
 KB/ouDe2kxWRtC7DN6p/S4/thFyC9CbqiMP0Jz+/f49+Q5J7JTzn35roJpmvlRUQDdDS
 p0FCjZEqmpHgH3NHmULRxB2Y9etJ9vgwfxwyEu/Bb3tHKr3zMMRX7p3QKEZ0g1W017av
 H6OA==
X-Gm-Message-State: AOJu0YxSnnzxo/p8R0Jt10Ny+OGjPaKYQ06lDNoPpF62xbon6MZOoTAF
 qEYPZDhxIap3KCjHOXihefVG0RFuaCcxXbbY82R3APoMS3nS8vkZi3tr
X-Gm-Gg: AeBDiet9GE60xDeowZq9DPYjHYsfWakKwF82oLucEfixAGWhKS5hhqlbBnjwvtzD9im
 m5CZI4/bvwABOqxD1KdK3Ub2X7HGAbTf9lSI0TnCsWZAn13l4jNLddISSHCoUOy9JkmAk3PIZ2O
 d//wYE23qfylMrrhvDZCXMNR4J6cXAdUMDqzYTjz2727eVwfVP7JZbL/Z2L/tgGuQIy3DWz/uu7
 p/j/6Ob2wb2ZUx2Wn0Oen5WRuthjiKJrLa+sQ18BHJvhKQf7KDXIIPb2BkbGSis11hcOs6TAtyr
 le5KxquOk0SpY56cicFem+3dmebwDvvj7rXmz6u1U041KbtmnncykmrhRGYm1eR4MwF+6XESA2q
 JtHPkUOMkAzdew9v/1dDjtw4MC4q4bteZfdX4W6uvumrgZHUurg4XcysXLXHEGnll2SkEWJ/kYc
 O5o4y5ojkbO/43m+s06T61R290dpa/8U+TikeneHLfO8pvaxTau+jhvC7U8WCnb1KllEhmEuK8G
 ZXUQPLF/zMW+YizHWmpdTfPGK0Jm8vgSt16pCSfU6BoQVEXg5c=
X-Received: by 2002:a05:7022:ec3:b0:127:5c3d:bd95 with SMTP id
 a92af1059eb24-12ddd9abafbmr2500962c88.32.1777448074821; 
 Wed, 29 Apr 2026 00:34:34 -0700 (PDT)
Received: from
 runnervmeorf1.wipwsgxeb1ru5pjoslepaynzca.dx.internal.cloudapp.net
 ([52.159.225.194]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12de326a583sm1690391c88.14.2026.04.29.00.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 00:34:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Wed, 29 Apr 2026 07:34:33 +0000
Message-ID: <20260429073433.4027-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429062650.3191021-1-wakel@google.com>
References: <20260429062650.3191021-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/file_attr01: Dynamically expect EOPNOTSUPP on
 tmpfs without xattr
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

Hi Wake,

On Wed, 29 Apr 2026, Wake Liu wrote:
> syscalls/file_attr01: Dynamically expect EOPNOTSUPP on tmpfs without xattr

> +	if (tc->ufattr == (struct file_attr **)(&null_ptr) && missing_tmpfs_xattr)
> +		exp_errno = EOPNOTSUPP;

The override is scoped only to the null-ufattr tcase. The commit message says
the kernel checks xattr support "before dereferencing the user pointer", which
raises the question of whether usize validation (EINVAL/E2BIG tcases) also
occurs after the support check. If so, those tcases would also return
EOPNOTSUPP on tmpfs without xattr and need the same treatment. Please clarify
the kernel's validation order for usize relative to the xattr support check.

> Changes in v3:
[...]
> Changes in v2:
[...]

Version changelogs should be stripped from the commit message before merging;
they belong in the cover letter only.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25096139400

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
