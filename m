Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A4FCD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 09:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781255078; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ONLklb0SX8Wmpf8iK3IScFtRxxOnoRzeN2nOESoEU4o=;
 b=L/NxaO6Ys7PyfVuP/4/hGGvHrh3G5DvGGszwro1dCaQJlosT1DuOvddDzNSihtoXVmjGz
 puwWZur4CUMW46yEdit+Yihqj9054WtbisgnbL/p1kci+XT827UaUQsGlefNQM0gqR8EUhN
 ahy9tkU6ghJkV4vlVswdtXIVsVZv9B4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD8833E2FB1
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 11:04:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D31CD3C0528
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:04:18 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 991FB1A009AD
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:04:17 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490ac10e337so4558235e9.3
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 02:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781255057; x=1781859857; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=RY1zYgvaaJ5iNS9fD6tn6MYlYEvFR4sFNQI5JlDKO/c=;
 b=Q8/j53hThS+rdgl1wzMulRpPnuRA2+odLVdXjaWT10+iYspeZ8888F2Sun9FOLLPTe
 oTxsUbiKDhmBGN49nQ3T5DGoij6ds2gkhRq88g5WyIPt09kNWdCCKpZGqOkHtXCswYjE
 J34itF/Pd9KMQZPhV8AEBM2QnF5cjA8kyP3Z319F8mqOb+v4bgKtJHV00n0WZTeZQC/9
 ASAn2xn8iHBI1POVRuotiKDWC79zcUQ9V/o85jx4o3k/wAgdc6qcyxma148AffeR0qrB
 gLLn0Ha33dS4okKg2Xph6kpi3IrzaVhzu5d81o2AhDGVW5+pHwP+rypTEt2IdXwkArMa
 vX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781255057; x=1781859857;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RY1zYgvaaJ5iNS9fD6tn6MYlYEvFR4sFNQI5JlDKO/c=;
 b=MQG2ji21K8k4WQIqQc+E8yQn0go8duLonz1Kxg0rVKy1CORh9lb2+DgknGFDeTjGuQ
 qoecER/b6Q/r2oo3sXgbqSJLpEloknqahoDFUJxWw7ZjU+GjeK5qPsK3bkpHP4YF4sWU
 GyR/LxswtxlZdxb2SJkpdZxs/tnIqPH68m5p2YvQ1dJ1HlmfBEhgvXDcjS6o/J9GZmRY
 6vGCsXNF6eHDczxOnbc7GxGX5dFVWNpNOLRxxG0Ncl41NGrsWGfKoCE+cJ1DJjGGz68C
 x+HIphFp7Or3RVnOnMmPkqRJm+CXOLUQPkzFB4a9wmdBzlmOu8+keswvnBAa6CIYY8oF
 4YwA==
X-Gm-Message-State: AOJu0YxSkUWqiGyRLfBzW8GAYcuuYN5qa9IoNphFeE042Y2khr4/FMdF
 AyRqZxg0MDJNqIn7LSZnEld5XZzuNH1QiLQaL3Mgs9kWkzlceRqmUxwZVIOwUrJmSk8oY/XKY+b
 cbnw=
X-Gm-Gg: Acq92OEYdpJa3qkif1OtU6X9oL77TbwDGnIdQbCQnB6XfT2iZHsuZ28vb/ymKz12JXp
 9dFUnSnbRvy25sAI7yVbq/UUOoz7GagpaFDnvBfo/h8EC205kjYq+p2p5JniVsVJeBm3gQj/+15
 Ac7VEe6Z5pBXrData9rZLJVjFDeuPpp98KRaDF1AyPy1e5TkiNPvvHCrfxHCV7k+5/Na24kkdXC
 y10C/gnTeTLbxQg+T3ttFDoDFtsiVRP1bIUc+n7yh1wFp9yKe39DwymBifgGkTH60LIjCezv6BG
 1KBuSAuw6f5sHNc5K5nSeWyqmeO63Yf8nKlmfbc14WooFifVCaBAgpLNFciUu5az8U7FvWY+G0w
 sfd9fpxkABXNYcu1rz0LnsmC7Dz/1xvAB9J3KgDgCNDq7MZWdDZX6Sc/b55xw6l6vqt2mVgjDMn
 LIWu7IG4UdLU0zhjKViy9ho6IMMms3t4oh7BlMgITi
X-Received: by 2002:a05:600c:138e:b0:490:b0e0:3de2 with SMTP id
 5b1f17b1804b1-490ec524005mr18992795e9.33.1781255056628; 
 Fri, 12 Jun 2026 02:04:16 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e592csm3909844f8f.36.2026.06.12.02.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 02:04:16 -0700 (PDT)
Date: Fri, 12 Jun 2026 09:04:14 +0000
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aivLjiPDt4TTYtG0@autotest-wegao.qe.prg2.suse.org>
References: <20260611-fix_cgroup_immutable-v1-1-0bcb90faa6fe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260611-fix_cgroup_immutable-v1-1-0bcb90faa6fe@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_fj: don't disable controller that was
 already enabled
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jun 11, 2026 at 05:03:41PM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> On immutable distributions (and systemd-managed systems in general)
> the cpuset controller is typically already enabled at the root cgroup
> level. The cleanup tried to unconditionally disable it via
> subtree_control, which failed with EBUSY because other system cgroups
> were still using it, producing a spurious TWARN.
> 
> Save whether the controller was already enabled at root before
> cgroup_require and skip the root-level disable in cleanup when it
> was.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> index 153d351d7936effb15527620f565acaaed7ac747..8b5e73466ba32d2c66a2805a03f4d2136c16509b 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> @@ -57,6 +57,14 @@ create_subgroup()
>  
>  common_setup()
>  {
> +    # Check if the controller is already enabled at root before
> +    # cgroup_require potentially enables it, so that cleanup does
> +    # not disable a controller the system was already using.
> +    if [ -f /sys/fs/cgroup/cgroup.subtree_control ] && \
> +       grep -qw "$subsystem" /sys/fs/cgroup/cgroup.subtree_control; then
> +        ctrl_was_enabled=1
> +    fi
> +
>      cgroup_require "$subsystem"
>      mount_point=$(cgroup_get_mountpoint "$subsystem")
>      start_path=$(cgroup_get_test_path "$subsystem")
> @@ -77,7 +85,7 @@ common_cleanup()
>  
>      cgroup_cleanup
>  
> -    if [ "$cgroup_version" = "2" ]; then
> +    if [ "$cgroup_version" = "2" ] && [ "$ctrl_was_enabled" != "1" ]; then
>          case "$subsystem" in
>          cpu|io|memory|pids)
>              :;;
> 
> ---
> base-commit: a375e8deed471723f5a0114c56eb48fe6f6f45d3
> change-id: 20260611-fix_cgroup_immutable-2259f7591f8d
> 
> Best regards,
> -- 
> Andrea Cervesato <andrea.cervesato@suse.com>
Reviewed-by: Wei Gao <wegao@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
