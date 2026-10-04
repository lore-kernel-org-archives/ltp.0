Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C80CA5FEF
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 15:48:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F15AC3E4E30
	for <ltp@archiver.kernel.org>; Sun,  4 Oct 2026 17:48:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D77F3E2E4F
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 17:47:47 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 63E26600202
 for <ltp@lists.linux.it>; Sun,  4 Oct 2026 17:47:42 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 d75a77b69052e-53391df636aso2959271cf.0
 for <ltp@lists.linux.it>; Sun, 04 Oct 2026 08:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791128861; x=1791733661; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2LWwbljGJwRZ05XtN+00rYzjr6g9W0ikQ+NE8Y+VF1g=;
 b=fAoondGJMqKCCkV9ubjbMsfIu4n5lOHCjva/oyeOhGmdVPqRkxIV0TPy3ka6szaCTQ
 uD4qjXm9o8RImIbUuOf9sDwrx7uDMuNC39o7TRpGGAd6jOw34WNzm9dj8CeYu1px8Xaa
 fYZoBkv1xF0DypMpLra7mR7Xi4qlV+Dd08l27RmLLQAM6HCuSfenYSwOMKjbxEDKviSO
 7EtGWMb/fPobzzth9p8ZeUSd1PTZmobrgKm+RgdCcrAaIB+gqnmy8WuEvUnBjO5ALFDZ
 HNpNHZNZVBJnw9emHnpmXtDlAJKNfofc7jc+SUFIw9bCBJ+9B9Mf3cM+tUfa2ElmAxPs
 Fubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791128861; x=1791733661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2LWwbljGJwRZ05XtN+00rYzjr6g9W0ikQ+NE8Y+VF1g=;
 b=TP4ViucnnZrrwKJCQtUK0HaPYXona8hw/JY4TfhtBDzLGxBtvrsLLQD5kI0Y+h0bFl
 GWr3OhrvNgp3y6HrubeIaGjXfzrEmpe5kN2suvZS0RsOb1Yg7RV9iHe4d565TtbBIVhB
 /o+wapU0lXyFrgDlUXAVoxBYhTX0hsQKkbjPumiWJFQhrDYgKQfUkUj+eDBjdyPQTNYm
 OhVEdIhVHMD6u6aao56MBxWSfM0eWua9CmsaJhZy/k1kjDvLzJJCxu+YN2LoLFBZIzoI
 0CkIJ2CPEtk0Fgpgc+ie5/74gnZRLrvYaf8YdFu3+tAQUX3FKMxkIcXlFIU/Agd0grkJ
 YxkA==
X-Gm-Message-State: AFuF++khbjx/eqQMsctA9ozb10CF4oE0sjJZ8Fr51e02e5t/HXjFOwcM
 Ry617sPWxFmq/8585zdibP5z3K8xPqMVD0N6NdVr74JfXuEE8g88GgyV
X-Gm-Gg: AYBFou1I/CblmvAttHg5RNRxoxLVUrUoEKc65PC7PTnGVoxoIz6xR0MVapi7bjmunnu
 uUz6vbXzrEFOVXPnu8g+bAWYjNegsT5a+fsxoyeOgtQAhvF1AaxtNg5FO8a6ATtPu1BZ7iYMMXd
 Q1rYmQ4/7zDiDeyian54lfj5n75po64wEH0ZrFssbb4TEFXEtE/StJxkEfm9pKaVitn4AXzotxY
 M27YfLMp6U86LEKhMwdQYGRPW5cc0tygopJg55DDSjzCkvo7N/5ixIZFkbyRuD0fSKPnv81HCdH
 bkRautm1/68d2ld2b8Vg+TZsK5mZVuqbGEb/kNhtLYRZt0nPYeEx8IGQfhRn0LyXKgGaYPpxnoB
 MW84oh5CPWJX4ykampd30Pi0DIirzT9bSZmRghz95JHiPOlevErp3egEFYNR4MYIjofRvz+WBZS
 xnL4AjfaifoKjPhqiBfgRBatwNl4nOMojivdALtDktCF2UqdyvMZn30LQsxyMyNvHNTwMr62SMc
 Xp+zXZuh9otpfEe+sJ3LkLGlzJPwhjaBBXY2vF3SRWVXQ8ak+GOXHfVCzLjDZ/5p/1K1f1T2Seq
 z6GRh3Zh9cFI
X-Received: by 2002:ac8:5f90:0:b0:532:d202:328e with SMTP id
 d75a77b69052e-53511ee1b9dmr87623771cf.55.1791128860922; 
 Sun, 04 Oct 2026 08:47:40 -0700 (PDT)
Received: from
 runnervm8df0l.zwsmc1cdvcpe5b1nwwrkw5zkmd.cx.internal.cloudapp.net
 ([145.132.103.66]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53398aa0baesm75174181cf.13.2026.10.04.08.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 08:47:40 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Sun,  4 Oct 2026 15:47:39 +0000
Message-ID: <20261004154739.9367-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261004143332.25978-2-wegao@suse.com>
References: <20261004143332.25978-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcontrol: Add helpers to set and restore parent memory
 knobs
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

Hi Wei,

On 4 October 2026, Wei Gao wrote:
> memcontrol: Add helpers to set and restore parent memory knobs

--- [PATCH 2/2] ---

> +	set_parent_memory_knob("memory.min", "50M");
> +	set_parent_memory_knob("memory.low", "50M");

High severity: overlapping instances of the same test race on the shared
ltp knob: X saves 0, Y saves X's 50M, X restores 0 while Y is active, and
Y finally restores 50M instead of the original 0. This both removes an
active test's protection and leaves a pre-existing ltp group modified.
Serialize the complete shared-parent save/use/restore interval, not just
the individual reads and writes.

>  static void cleanup(void)
>  {
> +	restore_parent_memory_knob("memory.min");

High severity: the same problem applies to memory.low cleanup: the
snapshots exist only in the forked test worker, which the framework kills
without running this callback on timeout or interruption. The supervisor
does not restore these knobs, so a pre-existing ltp group retains 50M.
Move shared-parent bookkeeping and restoration into supervising cgroup
cleanup, before cgroup teardown.

> Set memory.min and memory.low on trunk_A and parent cgroups up through the
> hierarchy before allocating child pagecache, ensuring protection propagates
> down the tree to prevent kswapd over-reclaim under NUMA memory pressure,

Medium severity: the helper stops at ltp, so it does not establish this
protection when the cgroup mount is rooted in a delegated subtree or
namespace whose root has memory.min/low set to 0. Global reclaim still
walks that real ancestor, and page_counter_calculate_protection() caps
the descendants' effective protection to 0. Handle or report insufficient
ancestor protection and document the restriction instead of claiming
protection throughout arbitrary hierarchies.

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
