Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74ED3C88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 08:42:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 274D53E72B2
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 10:42:37 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BCD93E53C2
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 10:42:20 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F3086600633
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 10:42:19 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-38de693676dso382458a91.0
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 01:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789116138; x=1789720938; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ko9OeUIU6KJHmDH6xt9Dncg+pipFP80FtE3HEiLEmj0=;
 b=d5RtgdDSj3k6AWKpgKSbkax/nHON+fUxvvMi4ep9SldocjInzfQO/Q5aR9Te58pk8J
 VFW6Hjf2ycwYqsdZ37YZDko1oFlf9cmV22R/GS3UTTV4WRMkG0n/YfLGC+JaCvUacara
 +vyIugsn6MPaCCENFFK5fwUWCBRv38TFC+sJEz0H+oJ3fM9qnCPRFPo2k7ezG0Z5sOJr
 G1JlY+GUnlv0qR2EST/lyFR36SUWuaZOxSzADFuJBACWC4DI8MTyDzDLKrrqLS9fUceA
 iHoqMlhGy1jRmpHV2s0SIgnnH8ml4IxDCQEZ10vR4ujbjVT61sZ/xw2C8a6MYYigGwX0
 Tq3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789116138; x=1789720938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ko9OeUIU6KJHmDH6xt9Dncg+pipFP80FtE3HEiLEmj0=;
 b=mW7oxzFtXH/E8pGgwiCl287wdYXWIkrRxzfoCZfVMB3GiYL9LV7g7xIZqCQHsmM6ML
 8OTJuEGuTx3u+hkeOK/8IRiNKLw7FZupW9gZWWjOArFwT7wjX5ZWkFyK+Kxgw+AK34EZ
 l1V2AoKmosRA4/XqLj6FpP7Nd/2hvmzdLHptZSx79L6SpAQhuzegcbu4MpaGxW2GwkpK
 v1dspG/k7IRyvkuc+dh5JZFZjNs3uh6K9TDY3FR4/6qdYhUjhRYdTgaeyIK+5r0x/GyB
 ZglKZ4REINhWA82F9b5MNGWhNw4l5S1+sFgmV0r5xXosxSpVg98/S1clu73HvbDEowxX
 /PIg==
X-Gm-Message-State: AFuF++nhEGBy1pewz5Wf27hEo7gTD69slx/OV60vf+ndtiNDAjY2ALHk
 gh79lNUrsFx7wZUZ9nuC2RwkZLwGtKkUV71RC4X5iPu8X9wUOozPtiiB0+EGywMe
X-Gm-Gg: AYBFou1Sfr6P0MRXapFE8kvvCegiQEsLteKkyy6H7um0v9DIMj5tqNcIMVDrm/letxW
 vWRJw2n/M5XGetjP/jsgBrPQtvjE109UU6hyD7xqWqh1UMBLb96yV+5/SxaRipjK2tbHJm25eHq
 TE1QrlZ2EDO6kBIqG/bBNdNfWclS7kHOCWqMJmqtNXwN0bH5m7srKlbx50uALW0wI0h0noXS+z1
 T3Gej3pRRuU24bf1j9h0YLe9EUivAegaifuCyI8h7+f70rSzJirD9OPu5ij2XL5oFv38Xy7BpzV
 EQSPQxJpM1LaQNzvb+p+GZk2Br0hZf7tNyTwpgnRrZlEs1vAh03fAIfy+M5OvUit8C4zKECh7np
 8aTceSboJNJOulTaBBc+eaZCxwPFCgKp3MHis9Ad4ZgU4Gx9NWJ62V6NfwAGRZR9z78/YJaOaM/
 hwxzMU/flbcLcw2qCMAysUHKwWPM2dd2g/6yd82Gg8AwJ/c8XG5Pt+kKOeB4c3Xn8u6WLbVGuYn
 a/iBO8/n2IUUJD6Sk7qUh8mEtz93fAeGk66sgg/dThtQXjJB9uFTGLejPjzvuhCuN91B/av6ZbH
 rtIgwB8XCw==
X-Received: by 2002:a17:90b:3dc6:b0:398:bc52:825b with SMTP id
 98e67ed59e1d1-39d9c3aeedfmr5706273a91.21.1789116138229; 
 Fri, 11 Sep 2026 01:42:18 -0700 (PDT)
Received: from
 runnervmlun5p.0ec3n2hyagzerni52n0yzw2ude.dx.internal.cloudapp.net
 ([40.75.131.18]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm5043560eec.24.2026.09.11.01.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 01:42:17 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 11 Sep 2026 08:42:16 +0000
Message-ID: <20260911084216.8614-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911-fix_core_leak_astra-v1-1-bc5cb35a182a@suse.com>
References: <20260911-fix_core_leak_astra-v1-1-bc5cb35a182a@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_af_alg: Fix control buffer memory leak
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

On Fri Sep 11 09:53:40 2026 +0200, Andrea Cervesato wrote:
> tst_af_alg: Fix control buffer memory leak

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
