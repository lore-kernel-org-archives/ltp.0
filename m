Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234B1C433EF
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 17:03:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9432B3CA863
	for <ltp@archiver.kernel.org>; Wed, 11 May 2022 19:03:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 851BC3CA863
 for <ltp@lists.linux.it>; Wed, 11 May 2022 19:03:14 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 74E311A0048F
 for <ltp@lists.linux.it>; Wed, 11 May 2022 19:03:13 +0200 (CEST)
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-2ebf4b91212so28453537b3.8
 for <ltp@lists.linux.it>; Wed, 11 May 2022 10:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=IpFPdO/uhoos0ytjMYOded4nPoWVZB+GddWGBdrYbMs=;
 b=DftVrELHUbG6fAglpJBSkYraK/JxtyLTYij8BRwZtbKjUIRS9rXC3CRLLTATNg0yT6
 /BV+kAxtxbvLKnrVBCq0rp4iVtB/4xhip7cMbKBqncF40dKtWBU/O75l6+6mtUQuc9Jf
 7OqdNr68dN+aTIx2kNYySQZF4SNazr9zk17XEMjMRw6dwpWf8ZA09XtvmjNzAv1U0y1d
 GEKn6XWp/zxkLAVu5hg1NlJ4KHcUSYtjiCCzmG5lBNHBzItUWlQVzKhpeEGOwAitnl8d
 uP2bBRoM5MySUSBzHeW1tUa+DBONyCkjwtBe+nX1wiLYnPvzR87oYgJ7gr9jdyn54zaf
 II6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=IpFPdO/uhoos0ytjMYOded4nPoWVZB+GddWGBdrYbMs=;
 b=IC1gwIK6J2u/npJUPui9bFbeMHjpSb0dmy8WKUQ7jmIsjWhW92t1kn+4/dou7Nl8Sy
 CTSZNn03rwSpexRlp+RewhDHZaST6V1ksQRq020Ybt2QIwPAhjKDlMJszX0Plf1iHmU1
 sKxggvz6gaQfwUnpYoJ/ETeogK8YX9tWBSQIe/uwbpBGT3cbcDEcotkIA7UQ7xEFPqIj
 P/Chc1BlwjPOknOOnIK1u3/m3NMkzg1ayIU2lKfsz0df+IhnHr8d0JdK/CDffBiBp0+O
 fqYb6QdFndbBozaRYZUaRpSx+PgcyrrEVtCRUgSwoU1MQhtJP5umKFRevQKFZIBNNbp5
 jvyg==
X-Gm-Message-State: AOAM530Hf1E71d8+xQmg4lJxRZhXOB0Q9USTOn4/HxQcwd6sabACPk07
 roP7dA90kTmWezuRWtIJ461y+FQgmZKb/KhmdPvlVg==
X-Google-Smtp-Source: ABdhPJwPNDG2qz9xm6hazjQfNV88Bgu3tDJb25KA7U+2Gg82o7sTH39Xql9UQcRPBTAYCAQHCh1Bu4zryk5beAVHzQY=
X-Received: by 2002:a0d:d88c:0:b0:2f7:bb41:1bd0 with SMTP id
 a134-20020a0dd88c000000b002f7bb411bd0mr25670953ywe.199.1652288592004; Wed, 11
 May 2022 10:03:12 -0700 (PDT)
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 11 May 2022 22:33:00 +0530
Message-ID: <CA+G9fYtKJ_a2rLSvxsYFrkUjNHpGeTn_xsL8kyz=-pBoeA+eXA@mail.gmail.com>
To: open list <linux-kernel@vger.kernel.org>, 
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, 
 lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [next] mm: overcommit_memory: failed - TFAIL: alloc passed,
 expected to fail
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Michal Hocko <mhocko@suse.com>,
 Arnd Bergmann <arnd@arndb.de>, Ganesan Rajagopal <rganesan@arista.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Peter Xu <peterx@redhat.com>,
 Shakeel Butt <shakeelb@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Following LTP test regressions were noticed on Linux next-20220511 tag on
all the devices.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Regressions found on x86 and arm64.

   ltp-mm-tests/overcommit_memory04
   ltp-mm-tests/overcommit_memory06
   ltp-mm-tests/overcommit_memory03
   ltp-mm-tests/min_free_kbytes
   ltp-mm-tests/overcommit_memory01
   ltp-mm-tests/oom01
   ltp-mm-tests/overcommit_memory05


mem.c:154: TFAIL: victim signalled: (9) SIGKILL
overcommit_memory.c:203: TFAIL: alloc passed, expected to fail
overcommit_memory.c:176: TINFO: malloc 7102100 kB successfully
overcommit_memory.c:203: TFAIL: alloc passed, expected to fail
overcommit_memory.c:176: TINFO: malloc 3523530 kB successfully

overcommit_memory.c:203: TFAIL: alloc passed, expected to fail
overcommit_memory.c:176: TINFO: malloc 8456472 kB successfully
overcommit_memory.c:203: TFAIL: alloc passed, expected to fail
overcommit_memory.c:176: TINFO: malloc 4283276 kB successfully
overcommit_memory.c:203: TFAIL: alloc passed, expected to fail
overcommit_memory.c:176: TINFO: malloc 2114118 kB successfully


metadata:
  git_ref: master
  git_repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git_sha: 6107040c99d5dfc920721c198d45ed2d639b113a
  git_describe: next-20220511
  kernel_version: 5.18.0-rc6
  kernel-config: https://builds.tuxbuild.com/291BWBU964yoppGqYfnVF8AJMg4/config
  build-url: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next/-/pipelines/536448964
  artifact-location: https://builds.tuxbuild.com/291BWBU964yoppGqYfnVF8AJMg4
  toolchain: gcc-11


Full test log on x86:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220511/testrun/9438084/suite/ltp-mm-tests/test/overcommit_memory01/log
https://lkft.validation.linaro.org/scheduler/job/5012581#L10525


--
Linaro LKFT
https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
