Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F940CD4F2C
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 09:19:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1715E3E2C3F
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 11:19:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3D733C0528
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:18:46 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 51BD860083B
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 11:18:46 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490b8a97b11so8640535e9.0
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 02:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781255926; cv=none;
 d=google.com; s=arc-20240605;
 b=j3kreP7vp/Bjv+nFBi8cPdLonO+d9bBj9nzNQbUgF+omVxo8i57KprK9xpDmgm2jB5
 8KbOaEzgCFfv5c4vn1tKIyxeNaSF4i8fOpyEF1egysE/TvUobldg1D2MqSzl4cKeD9EJ
 0RUKC+zuELL0kaWj5YlLJ3MvV3EsFa/JCJ6nDfTSevFvWP9uSyKJEimd7q49p6BjRAuB
 mEfn2n2Gh64vMHgxdZstwdBqZ7Pcj1DSeD2lr0b+DZ6ayKhvnUKynoT7+wDNlFx5D27R
 c87fI4/ihr+rnqhoSwIfxnBk6XxWiBiNDhpwX44fy44D5AGp0GcjoqRnsOg1/tgSIi3x
 GkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3u2Mt1954Rh9R9Ex/koBLCz0OBfmAI/3k0kpmVXEaf0=;
 fh=OUuxfE/vljMZo/un0EbICh+FDuosYtNpwvwzmv4vDSg=;
 b=iT5N20te/2TD/zHfRy6+3SxJmotDavrzQ5ocjfuws13QxMfhSOvH44Mq+/+bxz5vzc
 LE3jeqh2paA3WPTlz8HMyusZlFQw+J7huoqafxS3AyNQlaIg+ijsu+HnvcyAScBZC2Dx
 pEN9EGdu24H2hyOTwU7HMr1yrOaUyKiAvknjZuBysgYB06xWQb7T7aRn+MfYbtqoWp1+
 mqzOYaPGU4viM0ZjejTJw/iv4yA/9R9LjPEdBpjTwcJdZoCAoaJnKmoy1fUkacSWCKI1
 ZanDZMwz0plQawcSLAvujKVNjed4aFHI0Da5/fg6dsw3TWuYnZKaym8KeeKxrsPl++Jl
 Dazw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781255926; x=1781860726; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3u2Mt1954Rh9R9Ex/koBLCz0OBfmAI/3k0kpmVXEaf0=;
 b=iDp2mRbFQk8oVOSC+wq8Dt8TDuMLR8fQOc002Ba8grPGavwL/1K04CZRsMF9w19mG8
 4BYpEFY9ZHppQ0eZHLesJCIKnqiaqPx5WtG94jUzGEzoz01aDiB0qzT5iKu3uIdMmhfU
 HMNSv4Z14Jwg3eM84Ad71My1JhUlWT+KtOyOE3ksmUDNDqF3QT5Kq4qCD6OyACWj4ql6
 bXhJeroixmRqR+r4PK+lFxgo/9agWZCbCHwHWAsVQtrqOkEWbAuTv0hprnMRTS1d5rft
 Q4UaZdFUsgo2qpiDbcSJu8D7DzJAi1xAFSv8XJX2Qjoh9nqWivEkpL07lH9omzuEdH2D
 wBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781255926; x=1781860726;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3u2Mt1954Rh9R9Ex/koBLCz0OBfmAI/3k0kpmVXEaf0=;
 b=J0Ynxb7DBD4BhyyTMGVszgXpdf5HdpcZDlED4J/4riGpTTf/xtoQCCxnsnI9kgYto8
 l4WAw3ROkXZRKghbAm+CPuswGFM/yvDsPLOv7vitFQA/J/y6/IaVQHYjqFRyRfETwLC2
 b8axMPs5eH+dXR1/SeEttp87nozIMEKKMGPK7u2uUBgOp/MeWxm7k3e+X7mDz1rVGf/5
 xldmr7YfSQpvBho3JKwzpkMJ8jlFueyCNnJHZjtZvuxZO41TSB60fxTw0r+Fc/sBFCE/
 sZZSPW4+/mq6Pnk7guTmitI/7Wh7ZEvAn6liK1+V6KpZn/4P2V4OE6rNrWq9/0DgCZQ0
 L6tA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/L9kWMG4p569USCIG5ZOw/TnyXvTnBJtTmegJSG2y8TpI0pEC3e4uT0oOSKHCWXXJ/Ao4=@lists.linux.it
X-Gm-Message-State: AOJu0YyfY4OFMBfHidAWfL9rIKugXRC6b3PacLgr7fpaZKfxxCRec3E7
 jLmrmfZMljZgVzcHjp9+kXdzV88tTJ3+nNZjDqFahWEJ8iPzCBu2D8dP4nxljeCG7DdnRxbzO0c
 +Jdjfs+NvDWR07euclqnKqzG3L9RcfMc=
X-Gm-Gg: Acq92OFPniC5oaGRwi336QjZVaduUf8g8PhZ7nnP3JpXqLsOT3xFWHGUvsvajHB3o3s
 VLq5XCYUIBbxy0Z7pLiWY6QY86jUuydjEDfEdKrU2dQHf26JyK+0DsJYeAqHHhCMioaOuvDxMV7
 Gh4sC8PzWyo5OeLVJlEV75Ke+jb/26YpfC7bcB/Uw/tYltVuTCCAvbmP4tf/LmjejN1XGa1RtMV
 6VOrg2W75cF0rp/gkdGvXmHEgbaxcsmYCqqKF4sLreRy9rZXoLtlBfghPKhnAx4bw3oXlqNH7Mg
 T9NQJldwhNgDPcoGGrVaL3UGoHvSh2U1WjuYIA==
X-Received: by 2002:a05:600c:8b84:b0:491:731c:892a with SMTP id
 5b1f17b1804b1-491731c8944mr13066375e9.35.1781255925427; Fri, 12 Jun 2026
 02:18:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260611-fix_cgroup_immutable-v1-1-0bcb90faa6fe@suse.com>
 <aivLjiPDt4TTYtG0@autotest-wegao.qe.prg2.suse.org>
In-Reply-To: <aivLjiPDt4TTYtG0@autotest-wegao.qe.prg2.suse.org>
From: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Fri, 12 Jun 2026 11:18:34 +0200
X-Gm-Features: AVVi8CfM2eV4FD2tq0ODEIo01T-vssFdVRDWkDrMvnpjwt4bSI6F5B3ZXtCeJVI
Message-ID: <CAJCsO8cqT94dF1N6yqswABJCN6+BCM4eawH6D=twnHAA9m5o0A@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 12 Jun 2026 at 11:04, Wei Gao via ltp <ltp@lists.linux.it> wrote:

> On Thu, Jun 11, 2026 at 05:03:41PM +0200, Andrea Cervesato wrote:
> > From: Andrea Cervesato <andrea.cervesato@suse.com>
> >
> > On immutable distributions (and systemd-managed systems in general)
> > the cpuset controller is typically already enabled at the root cgroup
> > level. The cleanup tried to unconditionally disable it via
> > subtree_control, which failed with EBUSY because other system cgroups
> > were still using it, producing a spurious TWARN.
> >
> > Save whether the controller was already enabled at root before
> > cgroup_require and skip the root-level disable in cleanup when it
> > was.
> >
> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > ---
> >  testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh | 10
> +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > index
> 153d351d7936effb15527620f565acaaed7ac747..8b5e73466ba32d2c66a2805a03f4d2136c16509b
> 100755
> > --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > @@ -57,6 +57,14 @@ create_subgroup()
> >
> >  common_setup()
> >  {
> > +    # Check if the controller is already enabled at root before
> > +    # cgroup_require potentially enables it, so that cleanup does
> > +    # not disable a controller the system was already using.
> > +    if [ -f /sys/fs/cgroup/cgroup.subtree_control ] && \
> > +       grep -qw "$subsystem" /sys/fs/cgroup/cgroup.subtree_control; then
> > +        ctrl_was_enabled=1
> > +    fi
> > +
> >      cgroup_require "$subsystem"
> >      mount_point=$(cgroup_get_mountpoint "$subsystem")
> >      start_path=$(cgroup_get_test_path "$subsystem")
> > @@ -77,7 +85,7 @@ common_cleanup()
> >
> >      cgroup_cleanup
> >
> > -    if [ "$cgroup_version" = "2" ]; then
> > +    if [ "$cgroup_version" = "2" ] && [ "$ctrl_was_enabled" != "1" ];
> then
> >          case "$subsystem" in
> >          cpu|io|memory|pids)
> >              :;;
> >
> > ---
> > base-commit: a375e8deed471723f5a0114c56eb48fe6f6f45d3
> > change-id: 20260611-fix_cgroup_immutable-2259f7591f8d
> >
> > Best regards,
> > --
> > Andrea Cervesato <andrea.cervesato@suse.com>
> Reviewed-by: Wei Gao <wegao@suse.com>
>

Feel free to add:
Reviewed-by: Sebastian Chlad <sebastian.chlad@suse.com>


> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
