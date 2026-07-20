Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288E9C44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 07:53:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E17F3E2BDD
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 09:53:43 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB11F3C2AF3
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 09:53:27 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8CE47600476
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 09:53:26 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4720f3bf164so1824009f8f.1
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 00:53:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784534006; cv=none;
 d=google.com; s=arc-20260327;
 b=gKY06CENbd/pPM6BaSVzQ+9ghO47a/h44eYuGQYr+cTY9V/M233pM/+4/Goc+xElAP
 NrUQ+PU4aWbetjDX9CnNJdhFfT3c/BLZSkSipt0pYxhBKCTuLJ/gHPJM8EQNVM2/SQgD
 +8fq3u5EuyxNxKjnA7Ibxgg2rF580gOLzU4ONrocTHfOMJfZ73+iGFhUd8FblA63Crd6
 8l0UweBpXvxyZFX4WqfkSptEFPrUV57u1+V783npXJM1OIEnJvjiBYLbs8Y9E2V89urM
 ey7YVllZiHg99yk4v7JFy6Ku1YGgspSRCct2VKmAz/FurOBlFmh8AQ9x7LrhToIynODa
 COFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=P4LZlMAedUhvA/1E7z2kT+ax49d8s8Mcqx0hiGnCXe0=;
 fh=OorbeTsjUkhfoRKGyUUhc6UCzQmyTLI/saXjPapaiaI=;
 b=iyxudLKjFCKH5PLCOtS0TrTF0aHyYzSMjSGk41qzNRCX76GIvBDWUFRtVN71CubtOg
 GPVWh148Ae0As113u9Dd6R04oNsbFpfDRQ6ARw95hw2oEJnC8u8hN0jPaoxleh5WiucC
 rfgo1HCxTPUpMG19ZWqj54ojI+I24r5xTH96FGftn5mWJt7guTNo4hdKYhE6YaDE+V3L
 FK++cwcRHeNkf/J7yZVAWKt1ST0A4wX5bFPbmls4g4mzzps9VFVFm1ZPbxuUQeRf+mZv
 QblFBlB5Q4pub4tZeTXk+fv0HBIISq9KOL2WobKcyintsQkheMmHehejces+kLZBQoIL
 QHOw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784534006; x=1785138806; darn=lists.linux.it;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=P4LZlMAedUhvA/1E7z2kT+ax49d8s8Mcqx0hiGnCXe0=;
 b=kMAtMjg+ynIlj1H1+SbQ+wdA41WF0uvpvEPuG5/hpJRhf7XtYu75bbLwBVBatNHAu2
 IjZOFBuDRAjYp0tx0O0Hvq4VOYgJq6qI83C54bbvVDZeG4gaf9O18EZ1IsvT/ZgzL09P
 sHklSUyztCY3KzBu30s0QoddR3So+xyyzLc4aazZ42ypRkUjyO7hND+Ioj8pHwUL5FA9
 pOxdu/lsdhKl+tm1S02NadLaiSR8d701LfulQFEsVFXqFDo1Mm0cummj4/HZzchcjkdO
 M5dPEyduAhNNrhOZFwKbVfGIwvYNalsR4QE9TR4qntXRBAC1ikIJypfOzHUDJknIHQdd
 KOhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784534006; x=1785138806;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=P4LZlMAedUhvA/1E7z2kT+ax49d8s8Mcqx0hiGnCXe0=;
 b=r4CVaVjMR6diA1hJaGK+I8RcmLnOtzqwyYosUslGBnUdVBDwaz+Ld9iVb6B8DglnMC
 eSwMNKSm79h8Wd/wSeivnw5P8H1In3LFSVtEP1ENcVmQxUWs8NSVWJPzYhc5AksOTrtp
 4NQw9Q2z1sKBYekw0oXA7+mLdJTlLHojToJGtXGhRAtbZ8R2Um8LZXvGT2X0htC5vnEh
 51c378ES9pthYUJppxudPn3eQjCO2qBSRhDV42VyKVDKXmA2SdWGgEXEzG2nSPunc8z8
 MNj9k7lHsMqiAJTE+8EbflnY4vsNzQaFe2WDn26pAFfYxkqM5AizLwhvsDNRtKxZA1eb
 dIpQ==
X-Gm-Message-State: AOJu0YyrxVyD+JYKdfOr9ovxQxY1W/4ni9U+2cOxqx7+pbFMrOkJ9xp4
 NeEdZ5OMaly6EMx0MwSdvplQacPC4J5FwCuA5dX4hWEXmj15025YHxMq4Tuh+G5bU/iJ5NhXkGh
 GtKBhh1T8gUGO3cXxmExeDuqgs2yFzZA=
X-Gm-Gg: AfdE7ckKcMRf2hvRjBG1deOLwRQb7ft3vgnQ23xgjMpl7fIiVl+Z93t44riaMU4CUJr
 vzp15KUxn9xzyWvChFmQbjswoKQeu/gGkVo4KcWkdULYpDxWpXQk77bwRQKx8+EHu27/Yx8zDC+
 A0eGWEajfkT75ydI0EDflktibJk+37a+iQhgmhfXRBFGHppdvLp9HkKhRChdn1TUKQwtsSHmvjc
 7yHhsER0kjdMjO2EvE2b1nvURCzeYw7Ni9ozGEavEPTqaUxhl8zAewI4iRhHCuSG7Ofyzi9ZXqD
 Ql8krXKabErJ/+0VYg==
X-Received: by 2002:a05:600c:1381:b0:493:b698:9247 with SMTP id
 5b1f17b1804b1-4954a33dd74mr145138055e9.14.1784534005528; Mon, 20 Jul 2026
 00:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260717-fix_cve-2026-46331_enoent-v1-1-85425e81ff7a@suse.com>
In-Reply-To: <20260717-fix_cve-2026-46331_enoent-v1-1-85425e81ff7a@suse.com>
From: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Mon, 20 Jul 2026 09:53:13 +0200
X-Gm-Features: AUfX_mxwMaCHxqgJIvUWsUiNPAfRwfENuKvSTecz1Fa7o7_DA_G2cKWrT_euZoU
Message-ID: <CAJCsO8edUCW_nLeSGSBsLEjm5LB0QghycTbMF0VphAZHbp9h+Q@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] cve-2026-46331: fix intermittent ENOENT failure
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

Hi Andrea,

the rules say: "rules/ground-rules.md:If root is required, the reason MUST
be documented in the test's doc comment." Maybe worth adding?

Besides the subject says: "fix intermittent ENOENT failure". From your
patch it seems there is nothing intermittent about this behaviour.
I think commit subject should be amended to provide more accurate
description.

On Fri, 17 Jul 2026 at 15:21, Andrea Cervesato <andrea.cervesato@suse.de>
wrote:

> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> The required qdisc, classifier and action modules cannot be
> autoloaded from the unprivileged user namespace, so arming the
> traffic filter sometimes failed with ENOENT.
>
> Preload the modules as root before dropping privileges and entering
> the network namespace.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> tst_kconfig.c:90: TINFO: Parsing kernel config '/proc/config.gz'
> tst_kconfig.c:755: TINFO: CONFIG_FAULT_INJECTION kernel option detected
> which might slow the execution
> tst_test.c:1872: TINFO: Overall timeout per run is 0h 02m 00s
> cve-2026-46331.c:200: TBROK: Failed to modify traffic filter: ENOENT
>
> HINT: You _MAY_ be missing kernel fixes:
>
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=899ee91156e5
>
> HINT: You _MAY_ be vulnerable to CVE(s):
>
> https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2026-46331
> ---
>  testcases/cve/cve-2026-46331.c | 33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/cve/cve-2026-46331.c
> b/testcases/cve/cve-2026-46331.c
> index
> c33d358396f21024d8a68e9cd5c4cae0a9339a9f..dd19860e1d35152547e933850d7b8c91281240c4
> 100644
> --- a/testcases/cve/cve-2026-46331.c
> +++ b/testcases/cve/cve-2026-46331.c
> @@ -35,6 +35,8 @@
>   */
>
>  #include <sys/sendfile.h>
> +#include <sys/prctl.h>
> +#include <pwd.h>
>  #include <linux/rtnetlink.h>
>
>  #include "tst_test.h"
> @@ -128,7 +130,31 @@ static int acc_fd = -1;
>  static void setup(void)
>  {
>         struct sockaddr_in addr;
> -       int i;
> +       struct passwd *pw;
> +       static const char *const mods[] = {
> +               "sch_ingress", "cls_matchall", "act_pedit"
> +       };
> +       static const char *cmd[] = {"modprobe", NULL, NULL};
> +       unsigned int i;
> +
> +       for (i = 0; i < ARRAY_SIZE(mods); i++) {
> +               cmd[1] = mods[i];
> +
> +               if (tst_cmd(cmd, NULL, "/dev/null", TST_CMD_PASS_RETVAL))
> +                       tst_brk(TCONF, "kernel module %s is not
> available", mods[i]);
> +       }
> +
> +       /* Drop privileges so the reproducer runs as an unprivileged user
> */
> +       pw = SAFE_GETPWNAM("nobody");
> +       SAFE_SETGID(pw->pw_gid);
> +       SAFE_SETUID(pw->pw_uid);
> +
> +       /*
> +        * setuid() clears the dumpable flag, which makes /proc/self/*
> +        * owned by root and prevents tst_setup_netns() from writing the
> +        * uid/gid maps. Restore it so the user namespace can be set up.
> +        */
> +       SAFE_PRCTL(PR_SET_DUMPABLE, 1, 0, 0, 0);
>
>         tst_setup_netns();
>         NETDEV_SET_STATE("lo", 1);
> @@ -253,7 +279,12 @@ static struct tst_test test = {
>         .test_all = run,
>         .setup = setup,
>         .cleanup = cleanup,
> +       .needs_root = 1,
>         .needs_tmpdir = 1,
> +       .needs_cmds = (struct tst_cmd[]) {
> +               {.cmd = "modprobe"},
> +               {}
> +       },
>         .needs_kconfigs = (const char *[]) {
>                 "CONFIG_USER_NS=y",
>                 "CONFIG_NET_NS=y",
>
> ---
> base-commit: a67fe5f7b20492ff6ee7f4b1776a7579d4b3859b
> change-id: 20260717-fix_cve-2026-46331_enoent-9b9254da578e
>


Otherwise lgtm.



>
> Best regards,
> --
> Andrea Cervesato <andrea.cervesato@suse.com>
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
