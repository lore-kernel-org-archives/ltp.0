Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2688BD44C7D
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 16:29:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 877C63CA33C
	for <ltp@archiver.kernel.org>; Thu, 15 Jan 2026 17:28:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C2823CA107
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 17:28:45 +0100 (CET)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4BF5614010CB
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 17:28:43 +0100 (CET)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-382fb535b73so9296641fa.0
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 08:28:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768494522; cv=none;
 d=google.com; s=arc-20240605;
 b=ZCKAEg5bAHtNuuLZD1lfUr2cJlUz4qTxuwduFNogSWsY+6qoXfeATAmL2/QthTl6t9
 AOpljObvvHEXF7l+de/gRFFsmdl51r25TdeI/gA363PShcB0B6Y85+8LsX2KvfczI2gF
 ZaW6SpBJVwTz7U30uxvrvcMQM0k7fw9bshT+/c+3erVIxOxYeIUpjimVvD6VGDv8+BF0
 p7Htdoz9CT4zyn2eaxAu0QW31tm5ly4kRbHflBwuHVeZQo3i3bFe1Tt6EXYnw/zANQFc
 WD22k9BEWPlV//LHBUM6J827CoOanJi+0p/kkG1T4D7WHBngRNLTQFA68ocCGK+JaK6q
 V0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=vhA7K7u7ZmkZZOj0xF6TRIyvETHbDpHh/OXKF2tK9to=;
 fh=OXyD+Va8HUSNhVHa5nhonUE8Ep/pVK+UxdL86G7L2zc=;
 b=d9SudRDvUzyrx2wKjQzTld+rc81uzuDh2s0x8YFV3ri503WNi/NfunkvoIeHx/ADRH
 if/EnCarLZgZUdQkyqmMVlFieYJm2UoGNB/nOGNz0tTmlGgQqORAOmfhRdFbP8qVd2WJ
 +3+ZWKtv9uRFUED1sc0nl7EFzVoNumean0GUzxlwZ5sClaEy5o4IMvP4ifK8X/+PAoq1
 R3QDep5Wi3nlmMpjXd8q7aGx5T4Kq4yNTNo/CfiSbvB14xCtSnnc0ogcu+YuWFCZkJi3
 1zCDK2+34oh7NBi6MEQTgU8U+q5rVdXcKQtnuFS6Lkw0hjmmXnhDlb1s5kU04k97De5T
 u82Q==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768494522; x=1769099322; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vhA7K7u7ZmkZZOj0xF6TRIyvETHbDpHh/OXKF2tK9to=;
 b=IkUKwLl03IYie+6BSSYAbc/nHmhJGreqHO4WZ0v2ccGhU/EzFwgR2qEBPcHo89yjtw
 VDcM1BG4J3F/1isbSLLEhfQbhUPr/TgB9wCRZ+YsZ+7pJMsedtzm/gm7VB2HoOnwlCSA
 jDJkXP3CvDIpz1zDC8gNbJBb2MKe8bbov4l+Rqobo2uBjLLJv1LG8vw4QMZe1T7C6oTg
 N/Bma4wSCGqwi0HhADZs4B58ud6mMP6fsoSs+yVU15qbe0dO99Blicn75TvfI2dVcHYd
 fZxrba2/KyWFhPiPZdRkVfL6Vmx3FssEg2I2YB5ptRr9dMwFri1VklkJb3qtTpW2FLkX
 yNlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768494522; x=1769099322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhA7K7u7ZmkZZOj0xF6TRIyvETHbDpHh/OXKF2tK9to=;
 b=o2FcXIkrtnczjz/SZw6YOe6VNlIcSc5WF1gVNLR0cuCqpabB2zJa0OifLfyFt2lzxa
 mm3Sbq46fPnj9nlCy1vMlspGqPMKP5tmb2aFzOOAsCObVKyL29LLR0qENnqjDj1rSLsU
 cx2Cruond5JFWB/pvh1wccxDXuwPU7CNM8dgQbctVel0gW37Wkavq9DmOtHGtQGBqK+Z
 4ir9nlcvINqgos8T+blVb9cTX76N87OZMaCRjWWMGeGCXznJXeoYemFQXtstRP+qYjPe
 DPGvQNwC1YuWh5HudeQAY474uc8rNIZ+1VEesZxJOHTHnbS77oljnIJqjajQFW/0NygI
 D07Q==
X-Gm-Message-State: AOJu0YxIuXZTiZIDQ9X9fko+cuPH6xB1ZJBmy/BeZ/xloYgoocvoYqws
 9C8jRb6DxyJ8vYsEfoE+4WHiYQaWrsyAW+4f71FlZ46xvzzFSIZ8VM9o4LWuZun6o36S5NMG3C4
 ufNsFPWszW3rjVzM3r6yjvX4o1/CWQfs=
X-Gm-Gg: AY/fxX56zIbwrScsKmlxtfonZ/H02p7ey1kXSEp0fMlVdPX06FluWS20Hopo/RNERDg
 MyNNBhtsMknVHlaryQBDcNlFMBnYfcdt9uWd2xguuHRWuWS6T0gYHkWzC9Ltv+nVjOsejvYL2bE
 PyvCF5ebR04AXOWir5nqtKJYH0SdF724x/Fe2u5wJzVLljcJQxn4jETNfPYT5SJ9GNaOJmZv/qZ
 5k2aAiuUigI3X7I53Z0v1qmCNdsTz737PwbFNMpSqZYf3GJTgnfy1LfZCufV1QNrqgJwCjGpF+S
 9JkE+2LOY2J3YcxwIClTKyXZ7Q2N4w==
X-Received: by 2002:a2e:be8f:0:b0:383:1ec5:9634 with SMTP id
 38308e7fff4ca-383841c6f37mr795731fa.16.1768494521503; Thu, 15 Jan 2026
 08:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20260114140426.133180-1-liwang@redhat.com>
In-Reply-To: <20260114140426.133180-1-liwang@redhat.com>
From: Pradeep Susarla <pradeep.susarla@gmail.com>
Date: Thu, 15 Jan 2026 16:28:31 +0000
X-Gm-Features: AZwV_Qi8h-RGxbrJI2SFeAfzBNslY_On7ziaxY80VLUy2O4YkOOdFm88zSWhltQ
Message-ID: <CAGsesOQpWLxd9z-pUbJO-ru_ahiEGyCfX-kByKER-X47bBDQVw@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] libs: adopt etst_* prefix instead of tst_*
 for libs/
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

Thank you very much.

Could I please assume that this is now considered the definitive final, and
I can proceed with implementation?

Regards,

Pradeep Susarla

On Wed, 14 Jan 2026, 14:04 Li Wang, <liwang@redhat.com> wrote:

> The intention of moving these headers under include/ was to expose them as
> global interfaces, but using the tst_* prefix there is misleading. Headers
> corresponding to ltp/libs* code should follow the libs* naming to
> distinguish
> them from the core tst_* API.
>
> Rename the following headers/sources to use a etst_ prefix and update all
> includes accordingly:
>
>  include/{ipcmsg.h => etst_ipcmsg.h}
>  include/{ipcsem.h => etst_ipcsem.h}
>  include/{libmsgctl.h => etst_msgctl.h}
>  include/{libnewipc.h => etst_newipc.h}
>  include/{tst_numa.h => etst_numa.h}
>  include/{parse_vdso.h => etst_parse_vdso.h}
>  include/{libsigwait.h => etst_sigwait.h}
>  include/{libswap.h => etst_swap.h}
>  include/{tst_uinput.h => etst_uinput.h}
>  libs/ipc/{libipc.c => etst_ipc.c}
>  libs/ipc/{libmsgctl.c => etst_msgctl.c}
>  libs/newipc/{libnewipc.c => etst_newipc.c}
>  libs/numa/{tst_numa.c => etst_numa.c}
>  libs/sigwait/{sigwait.c => etst_sigwait.c}
>  libs/swap/{libswap.c => etst_swap.c}
>  libs/uinput/{tst_uinput.c => etst_uinput.c}
>  libs/vdso/{parse_vdso.c => etst_parse_vdso.c}
>
> Also, rename tst_* to etst_* in the global non-core libs.
>
> No functional changes intended.
>
> ==== NOTE ====
> From Petr Vorel:
>
>   "Although lib/ vs libs/ is a bit strange, kept these libraries separate
>   (i.e. no move libs/*/ into lib/), because these libraries are built only
> when
>   they are needed. I.e. for testing random test one does not need to wait
> for
>   building these additional libraries (although building them does not
> take long,
>   building LTP main library and tests takes much longer)."
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Pradeep Susarla <pradeep.susarla@gmail.com>
> ---
>  doc/developers/api_c_tests.rst                |  2 +-
>  include/{ipcmsg.h => etst_ipcmsg.h}           | 27 +++------
>  include/etst_ipcsem.h                         | 42 ++++++++++++++
>  include/etst_msgctl.h                         | 27 +++++++++
>  include/{libnewipc.h => etst_newipc.h}        | 21 ++-----
>  include/{tst_numa.h => etst_numa.h}           | 52 +++++++++---------
>  include/{parse_vdso.h => etst_parse_vdso.h}   |  6 +-
>  include/{libsigwait.h => etst_sigwait.h}      | 28 +++++-----
>  include/{libswap.h => etst_swap.h}            | 10 ++--
>  include/{tst_uinput.h => etst_uinput.h}       |  6 +-
>  include/ipcsem.h                              | 55 -------------------
>  include/libmsgctl.h                           | 39 -------------
>  include/tst_uid.h                             |  6 +-
>  include/ujson.h                               |  6 +-
>  include/ujson_common.h                        |  6 +-
>  include/ujson_reader.h                        |  6 +-
>  include/ujson_utf.h                           |  6 +-
>  libs/ipc/{libipc.c => etst_ipc.c}             | 25 ++-------
>  libs/ipc/{libmsgctl.c => etst_msgctl.c}       | 20 ++-----
>  libs/newipc/{libnewipc.c => etst_newipc.c}    |  2 +-
>  libs/numa/{tst_numa.c => etst_numa.c}         | 22 ++++----
>  libs/sigwait/{sigwait.c => etst_sigwait.c}    | 24 ++++----
>  libs/swap/{libswap.c => etst_swap.c}          |  6 +-
>  libs/uinput/{tst_uinput.c => etst_uinput.c}   |  2 +-
>  libs/vdso/{parse_vdso.c => etst_parse_vdso.c} |  2 +-
>  libs/vdso/vdso_helpers.c                      |  2 +-
>  testcases/kernel/input/input_common.h         |  2 +-
>  testcases/kernel/mem/cpuset/cpuset02.c        |  6 +-
>  testcases/kernel/mem/ksm/ksm06.c              |  6 +-
>  testcases/kernel/mem/shmt/shmt02.c            |  2 +-
>  testcases/kernel/mem/shmt/shmt03.c            |  2 +-
>  testcases/kernel/mem/shmt/shmt04.c            |  2 +-
>  testcases/kernel/mem/shmt/shmt05.c            |  2 +-
>  testcases/kernel/mem/shmt/shmt07.c            |  2 +-
>  testcases/kernel/mem/shmt/shmt08.c            |  2 +-
>  testcases/kernel/mem/shmt/shmt09.c            |  2 +-
>  testcases/kernel/mem/shmt/shmt10.c            |  2 +-
>  .../syscalls/clock_gettime/clock_gettime04.c  |  2 +-
>  .../syscalls/get_mempolicy/get_mempolicy01.c  |  8 +--
>  .../syscalls/get_mempolicy/get_mempolicy02.c  |  8 +--
>  .../kernel/syscalls/ipc/msgctl/msgctl01.c     |  2 +-
>  .../kernel/syscalls/ipc/msgctl/msgctl02.c     |  2 +-
>  .../kernel/syscalls/ipc/msgctl/msgctl03.c     |  2 +-
>  .../kernel/syscalls/ipc/msgctl/msgctl04.c     |  2 +-
>  .../kernel/syscalls/ipc/msgctl/msgctl05.c     |  2 +-
>  .../kernel/syscalls/ipc/msgctl/msgctl06.c     |  2 +-
>  .../kernel/syscalls/ipc/msgctl/msgctl12.c     |  2 +-
>  .../kernel/syscalls/ipc/msgget/msgget01.c     |  2 +-
>  .../kernel/syscalls/ipc/msgget/msgget02.c     |  2 +-
>  .../kernel/syscalls/ipc/msgget/msgget03.c     |  2 +-
>  .../kernel/syscalls/ipc/msgget/msgget04.c     |  2 +-
>  .../kernel/syscalls/ipc/msgget/msgget05.c     |  2 +-
>  .../kernel/syscalls/ipc/msgrcv/msgrcv01.c     |  2 +-
>  .../kernel/syscalls/ipc/msgrcv/msgrcv02.c     |  2 +-
>  .../kernel/syscalls/ipc/msgrcv/msgrcv03.c     |  2 +-
>  .../kernel/syscalls/ipc/msgrcv/msgrcv05.c     |  2 +-
>  .../kernel/syscalls/ipc/msgrcv/msgrcv06.c     |  2 +-
>  .../kernel/syscalls/ipc/msgrcv/msgrcv07.c     |  2 +-
>  .../kernel/syscalls/ipc/msgrcv/msgrcv08.c     |  2 +-
>  .../kernel/syscalls/ipc/msgsnd/msgsnd01.c     |  2 +-
>  .../kernel/syscalls/ipc/msgsnd/msgsnd02.c     |  2 +-
>  .../kernel/syscalls/ipc/msgsnd/msgsnd05.c     |  2 +-
>  .../kernel/syscalls/ipc/msgsnd/msgsnd06.c     |  2 +-
>  .../kernel/syscalls/ipc/semctl/semctl01.c     |  2 +-
>  .../kernel/syscalls/ipc/semctl/semctl02.c     |  2 +-
>  .../kernel/syscalls/ipc/semctl/semctl03.c     |  2 +-
>  .../kernel/syscalls/ipc/semctl/semctl04.c     |  2 +-
>  .../kernel/syscalls/ipc/semctl/semctl05.c     |  2 +-
>  .../kernel/syscalls/ipc/semctl/semctl06.c     |  2 +-
>  .../kernel/syscalls/ipc/semctl/semctl07.c     |  2 +-
>  .../kernel/syscalls/ipc/semctl/semctl08.c     |  2 +-
>  .../kernel/syscalls/ipc/semctl/semctl09.c     |  2 +-
>  .../kernel/syscalls/ipc/semget/semget01.c     |  2 +-
>  .../kernel/syscalls/ipc/semget/semget02.c     |  2 +-
>  .../kernel/syscalls/ipc/semget/semget05.c     |  2 +-
>  testcases/kernel/syscalls/ipc/semop/semop01.c |  2 +-
>  testcases/kernel/syscalls/ipc/semop/semop02.c |  2 +-
>  testcases/kernel/syscalls/ipc/semop/semop03.c |  2 +-
>  testcases/kernel/syscalls/ipc/shmat/shmat01.c |  2 +-
>  testcases/kernel/syscalls/ipc/shmat/shmat02.c |  2 +-
>  testcases/kernel/syscalls/ipc/shmat/shmat04.c |  2 +-
>  .../kernel/syscalls/ipc/shmctl/shmctl01.c     |  2 +-
>  .../kernel/syscalls/ipc/shmctl/shmctl02.c     |  2 +-
>  .../kernel/syscalls/ipc/shmctl/shmctl03.c     |  2 +-
>  .../kernel/syscalls/ipc/shmctl/shmctl04.c     |  2 +-
>  .../kernel/syscalls/ipc/shmctl/shmctl06.c     |  2 +-
>  .../kernel/syscalls/ipc/shmctl/shmctl07.c     |  2 +-
>  .../kernel/syscalls/ipc/shmctl/shmctl08.c     |  2 +-
>  testcases/kernel/syscalls/ipc/shmdt/shmdt01.c |  2 +-
>  testcases/kernel/syscalls/ipc/shmdt/shmdt02.c |  2 +-
>  .../kernel/syscalls/ipc/shmget/shmget02.c     |  2 +-
>  .../kernel/syscalls/ipc/shmget/shmget03.c     |  2 +-
>  .../kernel/syscalls/ipc/shmget/shmget04.c     |  2 +-
>  .../kernel/syscalls/ipc/shmget/shmget05.c     |  2 +-
>  .../kernel/syscalls/ipc/shmget/shmget06.c     |  2 +-
>  testcases/kernel/syscalls/kill/kill05.c       |  2 +-
>  testcases/kernel/syscalls/mbind/mbind01.c     |  8 +--
>  testcases/kernel/syscalls/mbind/mbind02.c     | 26 ++++-----
>  testcases/kernel/syscalls/mbind/mbind03.c     | 28 +++++-----
>  testcases/kernel/syscalls/mbind/mbind04.c     | 24 ++++----
>  .../rt_sigtimedwait/rt_sigtimedwait01.c       | 30 +++++-----
>  .../syscalls/set_mempolicy/set_mempolicy.h    | 10 ++--
>  .../syscalls/set_mempolicy/set_mempolicy01.c  | 16 +++---
>  .../syscalls/set_mempolicy/set_mempolicy02.c  | 10 ++--
>  .../syscalls/set_mempolicy/set_mempolicy03.c  | 14 ++---
>  .../syscalls/set_mempolicy/set_mempolicy04.c  | 10 ++--
>  .../syscalls/sigtimedwait/sigtimedwait01.c    | 22 ++++----
>  testcases/kernel/syscalls/sigwait/sigwait01.c |  8 +--
>  .../syscalls/sigwaitinfo/sigwaitinfo01.c      | 18 +++---
>  testcases/kernel/syscalls/swapoff/swapoff01.c |  2 +-
>  testcases/kernel/syscalls/swapoff/swapoff02.c |  2 +-
>  testcases/kernel/syscalls/swapon/swapon01.c   |  2 +-
>  testcases/kernel/syscalls/swapon/swapon02.c   |  2 +-
>  testcases/kernel/syscalls/swapon/swapon03.c   |  4 +-
>  testcases/kernel/uevents/uevent03.c           |  2 +-
>  115 files changed, 387 insertions(+), 461 deletions(-)
>  rename include/{ipcmsg.h => etst_ipcmsg.h} (52%)
>  create mode 100644 include/etst_ipcsem.h
>  create mode 100644 include/etst_msgctl.h
>  rename include/{libnewipc.h => etst_newipc.h} (62%)
>  rename include/{tst_numa.h => etst_numa.h} (51%)
>  rename include/{parse_vdso.h => etst_parse_vdso.h} (93%)
>  rename include/{libsigwait.h => etst_sigwait.h} (57%)
>  rename include/{libswap.h => etst_swap.h} (95%)
>  rename include/{tst_uinput.h => etst_uinput.h} (92%)
>  delete mode 100644 include/ipcsem.h
>  delete mode 100644 include/libmsgctl.h
>  rename libs/ipc/{libipc.c => etst_ipc.c} (82%)
>  rename libs/ipc/{libmsgctl.c => etst_msgctl.c} (77%)
>  rename libs/newipc/{libnewipc.c => etst_newipc.c} (98%)
>  rename libs/numa/{tst_numa.c => etst_numa.c} (87%)
>  rename libs/sigwait/{sigwait.c => etst_sigwait.c} (92%)
>  rename libs/swap/{libswap.c => etst_swap.c} (98%)
>  rename libs/uinput/{tst_uinput.c => etst_uinput.c} (99%)
>  rename libs/vdso/{parse_vdso.c => etst_parse_vdso.c} (99%)
>
> diff --git a/doc/developers/api_c_tests.rst
> b/doc/developers/api_c_tests.rst
> index be3baeaf0..73279973c 100644
> --- a/doc/developers/api_c_tests.rst
> +++ b/doc/developers/api_c_tests.rst
> @@ -62,4 +62,4 @@ Temporary directory
>
>  LTP libraries
>  -------------
> -.. kernel-doc:: ../../include/libswap.h
> +.. kernel-doc:: ../../include/etst_swap.h
> diff --git a/include/ipcmsg.h b/include/etst_ipcmsg.h
> similarity index 52%
> rename from include/ipcmsg.h
> rename to include/etst_ipcmsg.h
> index 3b3fa32c0..be8fbd366 100644
> --- a/include/ipcmsg.h
> +++ b/include/etst_ipcmsg.h
> @@ -1,28 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street
> <https://www.google.com/maps/search/51+Franklin+Street?entry=gmail&source=g>,
> Fifth Floor, Boston, MA 02110-1301 USA
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) Linux Test Project, 2026
>   */
>
>  /*
> - * ipcmsg.h - common definitions for the IPC message tests.
> + * etst_ipcmsg.h - common definitions for the IPC message tests.
>   */
>
> -#ifndef __IPCMSG_H
> -#define __IPCMSG_H     1
> +#ifndef ETST_IPCMSG_H__
> +#define ETST_IPCMSG_H__        1
>
>  #include <errno.h>
>  #include <sys/ipc.h>
> @@ -63,4 +50,4 @@ int getuserid(char *);
>  int get_max_msgqueues(void);
>  int get_used_msgqueues(void);
>
> -#endif /* ipcmsg.h */
> +#endif /* etst_ipcmsg.h */
> diff --git a/include/etst_ipcsem.h b/include/etst_ipcsem.h
> new file mode 100644
> index 000000000..abc8481ee
> --- /dev/null
> +++ b/include/etst_ipcsem.h
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) Linux Test Project, 2026
> + */
> +
> +/*
> + * etst_ipcsem.h - common definitions for the IPC semaphore tests
> + */
> +
> +#ifndef ETST_IPCSEM_H__
> +#define ETST_IPCSEM_H__
> +
> +#include <errno.h>
> +#include <sys/ipc.h>
> +#include <sys/sem.h>
> +
> +#include "test.h"
> +#include "lapi/sem.h"
> +
> +void cleanup(void);
> +void setup(void);
> +
> +#define SEM_RD 0400
> +#define SEM_ALT        0200
> +#define SEM_RA SEM_RD | SEM_ALT
> +
> +#define PSEMS  10              /* a reasonable value for the number of */
> +                               /* "primitive semaphores" per ID        */
> +
> +#ifdef LIBIPC
> +key_t semkey;                  /* an IPC key generated by ftok() */
> +#else
> +extern key_t semkey;            /* an IPC key generated by ftok() */
> +#endif
> +
> +void rm_sema(int sem_id);
> +
> +int getipckey();
> +int getuserid(char *);
> +
> +#endif /* libipcsem.h */
> diff --git a/include/etst_msgctl.h b/include/etst_msgctl.h
> new file mode 100644
> index 000000000..bb5d712b9
> --- /dev/null
> +++ b/include/etst_msgctl.h
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) International Business Machines  Corp., 2002
> + * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + * Copyright (c) Linux Test Project, 2026
> + */
> +
> +#ifndef ETST_MSGCTL_H__
> +#define ETST_MSGCTL_H__
> +
> +#define FAIL   1
> +#define PASS   0
> +
> +struct mbuffer {
> +       long type;
> +       struct {
> +               char len;
> +               char pbytes[99];
> +       } data;
> +};
> +
> +int doreader(long key, int tid, long type, int child, int nreps);
> +int dowriter(long key, int tid, long type, int child, int nreps);
> +int fill_buffer(char *buf, char val, int size);
> +int verify(char *buf, char val, int size, int child);
> +
> +#endif /* ETST_MSGCTL_H__ */
> diff --git a/include/libnewipc.h b/include/etst_newipc.h
> similarity index 62%
> rename from include/libnewipc.h
> rename to include/etst_newipc.h
> index 969c93292..179df3f2a 100644
> --- a/include/libnewipc.h
> +++ b/include/etst_newipc.h
> @@ -1,26 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2016 Xiao Yang <yangx.jy@cn.fujitsu.com>
> - *
> - * This program is free software;  you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - * the GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program.
> + * Copyright (c) Linux Test Project, 2026
>   */
>
>  /*
>   * common definitions for the IPC system calls.
>   */
>
> -#ifndef __LIBNEWIPC_H
> -#define __LIBNEWIPC_H  1
> +#ifndef ETST_NEWIPC_H__
> +#define ETST_NEWIPC_H__        1
>
>  #include <time.h>
>  #include <sys/types.h>
> @@ -60,4 +49,4 @@ void *probe_free_addr(const char *file, const int
> lineno);
>  #define PROBE_FREE_ADDR() \
>         probe_free_addr(__FILE__, __LINE__)
>
> -#endif /* newlibipc.h */
> +#endif /* etst_newipc.h */
> diff --git a/include/tst_numa.h b/include/etst_numa.h
> similarity index 51%
> rename from include/tst_numa.h
> rename to include/etst_numa.h
> index a1f961630..441aa5f49 100644
> --- a/include/tst_numa.h
> +++ b/include/etst_numa.h
> @@ -2,81 +2,81 @@
>   * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
>   */
>
> -#ifndef TST_NUMA_H__
> -#define TST_NUMA_H__
> +#ifndef ETST_NUMA_H__
> +#define ETST_NUMA_H__
>
>  #include <string.h>
>
>  /**
> - * struct tst_nodemap - Numa nodemap.
> + * struct etst_nodemap - Numa nodemap.
>   *
>   * @cnt: Number of nodes in map.
>   * @counters: Page allocation counters.
>   * @map: Array of numa ids.
>   */
> -struct tst_nodemap {
> +struct etst_nodemap {
>         unsigned int cnt;
>         unsigned int *counters;
>         unsigned int map[];
>  };
>
>  /**
> - * tst_nodemap_reset_counters() - Clears numa counters. The counters are
> lazy-allocated on first call of this function.
> + * etst_nodemap_reset_counters() - Clears numa counters. The counters are
> lazy-allocated on first call of this function.
>   *
>   * @nodes: Numa nodemap.
>   */
> -void tst_nodemap_reset_counters(struct tst_nodemap *nodes);
> +void etst_nodemap_reset_counters(struct etst_nodemap *nodes);
>
>  /**
> - * tst_nodemap_print_counters() - Prints pages allocated per each node.
> + * etst_nodemap_print_counters() - Prints pages allocated per each node.
>   *
>   * @nodes: Numa nodemap.
>   */
> -void tst_nodemap_print_counters(struct tst_nodemap *nodes);
> +void etst_nodemap_print_counters(struct etst_nodemap *nodes);
>
>  /**
> - * tst_mempolicy_mode_name() - Returns a name for a mempolicy/mbind mode.
> + * etst_mempolicy_mode_name() - Returns a name for a mempolicy/mbind mode.
>   *
>   * @mode: Numa mempolicy mode.
>   *
>   * return: a name for a mempolicy/mbind mode.
>   */
> -const char *tst_mempolicy_mode_name(int mode);
> +const char *etst_mempolicy_mode_name(int mode);
>
>  /**
> - * tst_numa_map() - Maps pages into memory, if path is NULL the mapping
> is anonymous otherwise is backed by the file.
> + * etst_numa_map() - Maps pages into memory, if path is NULL the mapping
> is anonymous otherwise is backed by the file.
>   *
>   * @path: Path to a file, if not NULL mapping is file based.
>   * @size: Mapping size.
>   *
>   * return: a pointer to a mapped file.
>   */
> -void *tst_numa_map(const char *path, size_t size);
> +void *etst_numa_map(const char *path, size_t size);
>
>  /**
> - * tst_numa_fault() - Writes to memory in order to get the pages faulted.
> + * etst_numa_fault() - Writes to memory in order to get the pages faulted.
>   *
>   * @ptr: Start of the mapping.
>   * @size: Size of the mapping.
>   */
> -static inline void tst_numa_fault(void *ptr, size_t size)
> +static inline void etst_numa_fault(void *ptr, size_t size)
>  {
>         memset(ptr, 'a', size);
>  }
>
>  /**
> - * tst_numa_unmap() - Frees the memory.
> + * etst_numa_unmap() - Frees the memory.
>   *
>   * @ptr: Start of the mapping.
>   * @size: Size of the mapping.
>   */
> -static inline void tst_numa_unmap(void *ptr, size_t size)
> +static inline void etst_numa_unmap(void *ptr, size_t size)
>  {
>         SAFE_MUNMAP(ptr, size);
>  }
>
>  /**
> - * tst_nodemap_count_pages() - Check which numa node resides each page.
> + * etst_nodemap_count_pages() - Check which numa node resides each page.
>   *
>   * Check on which numa node resides each page of the mapping starting at
> ptr
>   * and continuing pages long and increases nodemap counters accordingly.
> @@ -85,28 +85,28 @@ static inline void tst_numa_unmap(void *ptr, size_t
> size)
>   * @ptr:   Pointer to start of a mapping.
>   * @size:  Size of the mapping.
>   */
> -void tst_nodemap_count_pages(struct tst_nodemap *nodes, void *ptr, size_t
> size);
> +void etst_nodemap_count_pages(struct etst_nodemap *nodes, void *ptr,
> size_t size);
>
>  /**
> - * tst_nodemap_free() - Frees nodemap.
> + * etst_nodemap_free() - Frees nodemap.
>   *
>   * @nodes: Numa nodemap to be freed.
>   */
> -void tst_nodemap_free(struct tst_nodemap *nodes);
> +void etst_nodemap_free(struct etst_nodemap *nodes);
>
>  /**
> - * enum tst_numa_types - Bitflags for tst_get_nodemap() function.
> + * enum etst_numa_types - Bitflags for etst_get_nodemap() function.
>   *
>   * @TST_NUMA_ANY: general NUMA node.
>   * @TST_NUMA_MEM: NUMA memory node.
>   */
> -enum tst_numa_types {
> +enum etst_numa_types {
>         TST_NUMA_ANY = 0x00,
>         TST_NUMA_MEM = 0x01,
>  };
>
>  /**
> - * tst_get_nodemap() - Allocates and returns numa node map, which is an
> array of numa nodes which
> + * etst_get_nodemap() - Allocates and returns numa node map, which is an
> array of numa nodes which
>   * contain desired resources e.g. memory.
>   *
>   * @type:       Bitflags of enum tst_numa_types specifying desired
> resources.
> @@ -114,9 +114,9 @@ enum tst_numa_types {
>   *             requested amount of free+buffers memory it's not included
> in
>   *             the resulting list of nodes.
>   *
> - * return: On success returns allocated and initialized struct
> tst_nodemap which contains
> + * return: On success returns allocated and initialized struct
> etst_nodemap which contains
>   *         array of numa node ids that contains desired resources.
>   */
> -struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb);
> +struct etst_nodemap *etst_get_nodemap(int type, size_t min_mem_kb);
>
> -#endif /* TST_NUMA_H__ */
> +#endif /* ETST_NUMA_H__ */
> diff --git a/include/parse_vdso.h b/include/etst_parse_vdso.h
> similarity index 93%
> rename from include/parse_vdso.h
> rename to include/etst_parse_vdso.h
> index 5212fc659..b62c88f50 100644
> --- a/include/parse_vdso.h
> +++ b/include/etst_parse_vdso.h
> @@ -4,8 +4,8 @@
>   * Author: Viresh Kumar <viresh.kumar@linaro.org>
>   */
>
> -#ifndef PARSE_VDSO_H__
> -#define PARSE_VDSO_H__
> +#ifndef ETST_PARSE_VDSO_H__
> +#define ETST_PARSE_VDSO_H__
>
>  #include <stdint.h>
>
> @@ -38,4 +38,4 @@ extern void *vdso_sym(const char *version, const char
> *name);
>  typedef int (*gettime_t)(clockid_t clk_id, void *ts);
>  void find_clock_gettime_vdso(gettime_t *ptr_vdso_gettime,
>                              gettime_t *ptr_vdso_gettime64);
> -#endif /* PARSE_VDSO_H__ */
> +#endif /* ETST_PARSE_VDSO_H__ */
> diff --git a/include/libsigwait.h b/include/etst_sigwait.h
> similarity index 57%
> rename from include/libsigwait.h
> rename to include/etst_sigwait.h
> index 2fca578b1..5958d3844 100644
> --- a/include/libsigwait.h
> +++ b/include/etst_sigwait.h
> @@ -4,8 +4,8 @@
>   * Author: Viresh Kumar <viresh.kumar@linaro.org>
>   */
>
> -#ifndef SIGWAIT_H__
> -#define SIGWAIT_H__
> +#ifndef ETST_SIGWAIT_H__
> +#define ETST_SIGWAIT_H__
>
>  #include "tst_test.h"
>  #include "tst_timer.h"
> @@ -21,24 +21,24 @@ struct sigwait_test_desc {
>         int signo;
>  };
>
> -void test_empty_set(swi_func sigwaitinfo, int signo,
> +void etst_empty_set(swi_func sigwaitinfo, int signo,
>                     enum tst_ts_type type LTP_ATTRIBUTE_UNUSED);
> -void test_timeout(swi_func sigwaitinfo, int signo, enum tst_ts_type type);
> -void test_unmasked_matching(swi_func sigwaitinfo, int signo,
> +void etst_timeout(swi_func sigwaitinfo, int signo, enum tst_ts_type type);
> +void etst_unmasked_matching(swi_func sigwaitinfo, int signo,
>                             enum tst_ts_type type LTP_ATTRIBUTE_UNUSED);
> -void test_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo,
> +void etst_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo,
>                                    enum tst_ts_type type
> LTP_ATTRIBUTE_UNUSED);
> -void test_masked_matching(swi_func sigwaitinfo, int signo,
> +void etst_masked_matching(swi_func sigwaitinfo, int signo,
>                           enum tst_ts_type type LTP_ATTRIBUTE_UNUSED);
> -void test_masked_matching_rt(swi_func sigwaitinfo, int signo,
> +void etst_masked_matching_rt(swi_func sigwaitinfo, int signo,
>                              enum tst_ts_type type LTP_ATTRIBUTE_UNUSED);
> -void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo,
> +void etst_masked_matching_noinfo(swi_func sigwaitinfo, int signo,
>                                  enum tst_ts_type type
> LTP_ATTRIBUTE_UNUSED);
> -void test_bad_address(swi_func sigwaitinfo, int signo,
> +void etst_bad_address(swi_func sigwaitinfo, int signo,
>                       enum tst_ts_type type LTP_ATTRIBUTE_UNUSED);
> -void test_bad_address2(swi_func sigwaitinfo, int signo
> LTP_ATTRIBUTE_UNUSED,
> +void etst_bad_address2(swi_func sigwaitinfo, int signo
> LTP_ATTRIBUTE_UNUSED,
>                        enum tst_ts_type type LTP_ATTRIBUTE_UNUSED);
> -void test_bad_address3(swi_func sigwaitinfo, int signo
> LTP_ATTRIBUTE_UNUSED,
> +void etst_bad_address3(swi_func sigwaitinfo, int signo
> LTP_ATTRIBUTE_UNUSED,
>                        enum tst_ts_type type LTP_ATTRIBUTE_UNUSED);
> -void sigwait_setup(void);
> -#endif /* SIGWAIT_H__ */
> +void etst_sigwait_setup(void);
> +#endif /* ETST_SIGWAIT_H__ */
> diff --git a/include/libswap.h b/include/etst_swap.h
> similarity index 95%
> rename from include/libswap.h
> rename to include/etst_swap.h
> index b22b992ee..aa9a57ef8 100644
> --- a/include/libswap.h
> +++ b/include/etst_swap.h
> @@ -11,8 +11,8 @@
>   * Contains common content for all swapon/swapoff tests.
>   */
>
> -#ifndef __LIBSWAP_H__
> -#define __LIBSWAP_H__
> +#ifndef ETST_SWAP_H__
> +#define ETST_SWAP_H__
>
>  enum swapfile_method {
>      SWAPFILE_BY_SIZE,
> @@ -110,10 +110,10 @@ int make_swapfile(const char *file, const int lineno,
>  bool is_swap_supported(const char *filename);
>
>  /**
> - * tst_count_swaps() - Get the used swapfiles number.
> + * etst_count_swaps() - Get the used swapfiles number.
>   *
>   * Return: used swapfiles number.
>   */
> -int tst_count_swaps(void);
> +int etst_count_swaps(void);
>
> -#endif /* __LIBSWAP_H__ */
> +#endif /* ETST_SWAP_H__ */
> diff --git a/include/tst_uinput.h b/include/etst_uinput.h
> similarity index 92%
> rename from include/tst_uinput.h
> rename to include/etst_uinput.h
> index cf351cdfb..5e0dd8c17 100644
> --- a/include/tst_uinput.h
> +++ b/include/etst_uinput.h
> @@ -3,8 +3,8 @@
>   * Copyright (c) 2019 Cyril Hrubis <chrubis@suse.cz>
>   */
>
> -#ifndef TST_UINPUT_H__
> -#define TST_UINPUT_H__
> +#ifndef ETST_UINPUT_H__
> +#define ETST_UINPUT_H__
>
>  /**
>   * Tries to open the uinput device.
> @@ -44,4 +44,4 @@ void setup_mouse_events(int fd);
>   */
>  void destroy_input_device(int fd);
>
> -#endif /* TST_UINPUT_H__ */
> +#endif /* ETST_UINPUT_H__ */
> diff --git a/include/ipcsem.h b/include/ipcsem.h
> deleted file mode 100644
> index 09a0b3cbe..000000000
> --- a/include/ipcsem.h
> +++ /dev/null
> @@ -1,55 +0,0 @@
> -/*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street
> <https://www.google.com/maps/search/51+Franklin+Street?entry=gmail&source=g>,
> Fifth Floor, Boston, MA 02110-1301 USA
> - */
> -
> -/*
> - * ipcsem.h - common definitions for the IPC semaphore tests
> - */
> -
> -#ifndef __IPCSEM_H
> -#define __IPCSEM_H
> -
> -#include <errno.h>
> -#include <sys/ipc.h>
> -#include <sys/sem.h>
> -
> -#include "test.h"
> -#include "lapi/sem.h"
> -
> -void cleanup(void);
> -void setup(void);
> -
> -#define SEM_RD 0400
> -#define SEM_ALT        0200
> -#define SEM_RA SEM_RD | SEM_ALT
> -
> -#define PSEMS  10              /* a reasonable value for the number of */
> -                               /* "primitive semaphores" per ID        */
> -
> -#ifdef LIBIPC
> -key_t semkey;                  /* an IPC key generated by ftok() */
> -#else
> -extern key_t semkey;            /* an IPC key generated by ftok() */
> -#endif
> -
> -void rm_sema(int sem_id);
> -
> -int getipckey();
> -int getuserid(char *);
> -
> -#endif /* ipcsem.h */
> diff --git a/include/libmsgctl.h b/include/libmsgctl.h
> deleted file mode 100644
> index e1afeab5f..000000000
> --- a/include/libmsgctl.h
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/*
> - * Copyright (c) International Business Machines  Corp., 2002
> - * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of
> - * the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software Foundation,
> - * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> - */
> -
> -#ifndef __LIBMSGCTL_H__
> -#define __LIBMSGCTL_H__
> -
> -#define FAIL   1
> -#define PASS   0
> -
> -struct mbuffer {
> -       long type;
> -       struct {
> -               char len;
> -               char pbytes[99];
> -       } data;
> -};
> -
> -int doreader(long key, int tid, long type, int child, int nreps);
> -int dowriter(long key, int tid, long type, int child, int nreps);
> -int fill_buffer(char *buf, char val, int size);
> -int verify(char *buf, char val, int size, int child);
> -
> -#endif /*__LIBMSGCTL_H__ */
> diff --git a/include/tst_uid.h b/include/tst_uid.h
> index e604effce..2237ddcbf 100644
> --- a/include/tst_uid.h
> +++ b/include/tst_uid.h
> @@ -2,8 +2,8 @@
>   * Copyright (c) 2021 Linux Test Project
>   */
>
> -#ifndef TST_UID_H_
> -#define TST_UID_H_
> +#ifndef TST_UID_H__
> +#define TST_UID_H__
>
>  #include <sys/types.h>
>
> @@ -37,4 +37,4 @@ int tst_check_resgid_(const char *file, const int
> lineno, const char *callstr,
>  #define tst_check_resgid(cstr, rgid, egid, sgid) \
>         tst_check_resgid_(__FILE__, __LINE__, (cstr), (rgid), (egid),
> (sgid))
>
> -#endif /* TST_UID_H_ */
> +#endif /* TST_UID_H__ */
> diff --git a/include/ujson.h b/include/ujson.h
> index 8faeb18f0..1a4bb6bd9 100644
> --- a/include/ujson.h
> +++ b/include/ujson.h
> @@ -3,11 +3,11 @@
>   * Copyright (C) 2021-2024 Cyril Hrubis <metan@ucw.cz>
>   */
>
> -#ifndef UJSON_H
> -#define UJSON_H
> +#ifndef UJSON_H__
> +#define UJSON_H__
>
>  #include <ujson_common.h>
>  #include <ujson_reader.h>
>  #include <ujson_writer.h>
>
> -#endif /* UJSON_H */
> +#endif /* UJSON_H__ */
> diff --git a/include/ujson_common.h b/include/ujson_common.h
> index ed31c090d..11382c4fb 100644
> --- a/include/ujson_common.h
> +++ b/include/ujson_common.h
> @@ -8,8 +8,8 @@
>   * @brief Common JSON reader/writer definitions.
>   */
>
> -#ifndef UJSON_COMMON_H
> -#define UJSON_COMMON_H
> +#ifndef UJSON_COMMON_H__
> +#define UJSON_COMMON_H__
>
>  /** @brief Maximal error message length. */
>  #define UJSON_ERR_MAX 128
> @@ -66,4 +66,4 @@ typedef struct ujson_val ujson_val;
>  /** @brief An array size macro. */
>  #define UJSON_ARRAY_SIZE(array) (sizeof(array) / sizeof(*array))
>
> -#endif /* UJSON_COMMON_H */
> +#endif /* UJSON_COMMON_H__ */
> diff --git a/include/ujson_reader.h b/include/ujson_reader.h
> index 273fe624a..8608b6c81 100644
> --- a/include/ujson_reader.h
> +++ b/include/ujson_reader.h
> @@ -14,8 +14,8 @@
>   * if error has happened at the end of the sequence.
>   */
>
> -#ifndef UJSON_READER_H
> -#define UJSON_READER_H
> +#ifndef UJSON_READER_H__
> +#define UJSON_READER_H__
>
>  #include <stdio.h>
>  #include <ujson_common.h>
> @@ -540,4 +540,4 @@ static inline int ujson_reader_consumed(ujson_reader
> *self)
>         return self->off >= self->len;
>  }
>
> -#endif /* UJSON_H */
> +#endif /* UJSON_H__ */
> diff --git a/include/ujson_utf.h b/include/ujson_utf.h
> index f939fbe8c..313213d8e 100644
> --- a/include/ujson_utf.h
> +++ b/include/ujson_utf.h
> @@ -8,8 +8,8 @@
>   * @brief Unicode helper macros and functions.
>   */
>
> -#ifndef UJSON_UTF_H
> -#define UJSON_UTF_H
> +#ifndef UJSON_UTF_H__
> +#define UJSON_UTF_H__
>
>  #include <stdint.h>
>  #include <stddef.h>
> @@ -165,4 +165,4 @@ static inline int ujson_to_utf8(uint32_t unicode, char
> *buf)
>         return 4;
>  }
>
> -#endif /* UJSON_UTF_H */
> +#endif /* UJSON_UTF_H__ */
> diff --git a/libs/ipc/libipc.c b/libs/ipc/etst_ipc.c
> similarity index 82%
> rename from libs/ipc/libipc.c
> rename to libs/ipc/etst_ipc.c
> index c2ecbf02d..a1dd34c2f 100644
> --- a/libs/ipc/libipc.c
> +++ b/libs/ipc/etst_ipc.c
> @@ -1,25 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street
> <https://www.google.com/maps/search/51+Franklin+Street?entry=gmail&source=g>,
> Fifth Floor, Boston, MA 02110-1301 USA
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) Linux Test Project, 2026
>   */
>
>  /*
>   * NAME
> - *     libmsg.c
> + *     etst_ipc.c
>   *
>   * DESCRIPTION
>   *     common routines for the IPC system call tests.
> @@ -35,8 +22,8 @@
>   */
>
>  #define LIBIPC
> -#include "ipcmsg.h"
> -#include "ipcsem.h"
> +#include "etst_ipcmsg.h"
> +#include "etst_ipcsem.h"
>
>  #include <pwd.h>
>  #include <sys/ipc.h>
> diff --git a/libs/ipc/libmsgctl.c b/libs/ipc/etst_msgctl.c
> similarity index 77%
> rename from libs/ipc/libmsgctl.c
> rename to libs/ipc/etst_msgctl.c
> index ae459d480..104514e17 100644
> --- a/libs/ipc/libmsgctl.c
> +++ b/libs/ipc/etst_msgctl.c
> @@ -1,20 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (c) International Business Machines  Corp., 2002
> + * Copyright (c) International Business Machines  Corp., 2001
>   * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of
> - * the License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software Foundation,
> - * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + * Copyright (c) Linux Test Project, 2026
>   */
>
>  #include <errno.h>
> @@ -25,7 +13,7 @@
>  #include <sys/types.h>
>  #include <sys/ipc.h>
>  #include <sys/msg.h>
> -#include "libmsgctl.h"
> +#include "etst_msgctl.h"
>
>  int doreader(long key, int tid, long type, int child, int nreps)
>  {
> diff --git a/libs/newipc/libnewipc.c b/libs/newipc/etst_newipc.c
> similarity index 98%
> rename from libs/newipc/libnewipc.c
> rename to libs/newipc/etst_newipc.c
> index 331f1b1f5..2c04267dc 100644
> --- a/libs/newipc/libnewipc.c
> +++ b/libs/newipc/etst_newipc.c
> @@ -20,7 +20,7 @@
>  #define        TST_NO_DEFAULT_MAIN
>
>  #include "tst_test.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "tst_safe_stdio.h"
>  #include "tst_safe_sysv_ipc.h"
>
> diff --git a/libs/numa/tst_numa.c b/libs/numa/etst_numa.c
> similarity index 87%
> rename from libs/numa/tst_numa.c
> rename to libs/numa/etst_numa.c
> index c3297013b..dd3989e16 100644
> --- a/libs/numa/tst_numa.c
> +++ b/libs/numa/etst_numa.c
> @@ -14,10 +14,10 @@
>
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
> -#include "tst_numa.h"
> +#include "etst_numa.h"
>  #include "lapi/numaif.h"
>
> -void tst_nodemap_print_counters(struct tst_nodemap *nodes)
> +void etst_nodemap_print_counters(struct etst_nodemap *nodes)
>  {
>         unsigned int i;
>
> @@ -27,7 +27,7 @@ void tst_nodemap_print_counters(struct tst_nodemap
> *nodes)
>         }
>  }
>
> -void tst_nodemap_reset_counters(struct tst_nodemap *nodes)
> +void etst_nodemap_reset_counters(struct etst_nodemap *nodes)
>  {
>         size_t arr_size = sizeof(unsigned int) * nodes->cnt;
>
> @@ -37,7 +37,7 @@ void tst_nodemap_reset_counters(struct tst_nodemap
> *nodes)
>         memset(nodes->counters, 0, arr_size);
>  }
>
> -void tst_nodemap_free(struct tst_nodemap *nodes)
> +void etst_nodemap_free(struct etst_nodemap *nodes)
>  {
>         free(nodes->counters);
>         free(nodes);
> @@ -45,7 +45,7 @@ void tst_nodemap_free(struct tst_nodemap *nodes)
>
>  #ifdef HAVE_NUMA_V2
>
> -const char *tst_mempolicy_mode_name(int mode)
> +const char *etst_mempolicy_mode_name(int mode)
>  {
>         switch (mode) {
>         case MPOL_DEFAULT:
> @@ -64,7 +64,7 @@ const char *tst_mempolicy_mode_name(int mode)
>  }
>
>
> -static void inc_counter(unsigned int node, struct tst_nodemap *nodes)
> +static void inc_counter(unsigned int node, struct etst_nodemap *nodes)
>  {
>         unsigned int i;
>
> @@ -76,7 +76,7 @@ static void inc_counter(unsigned int node, struct
> tst_nodemap *nodes)
>         }
>  }
>
> -void tst_nodemap_count_pages(struct tst_nodemap *nodes,
> +void etst_nodemap_count_pages(struct etst_nodemap *nodes,
>                               void *ptr, size_t size)
>  {
>         size_t page_size = getpagesize();
> @@ -100,7 +100,7 @@ void tst_nodemap_count_pages(struct tst_nodemap *nodes,
>         }
>  }
>
> -void *tst_numa_map(const char *path, size_t size)
> +void *etst_numa_map(const char *path, size_t size)
>  {
>         char *ptr;
>         int fd = -1;
> @@ -178,10 +178,10 @@ static int node_has_enough_memory(int node, size_t
> min_kb)
>         return 1;
>  }
>
> -struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb)
> +struct etst_nodemap *etst_get_nodemap(int type, size_t min_mem_kb)
>  {
>         struct bitmask *membind;
> -       struct tst_nodemap *nodes;
> +       struct etst_nodemap *nodes;
>         unsigned int i, cnt;
>
>         if (type & ~(TST_NUMA_MEM))
> @@ -199,7 +199,7 @@ struct tst_nodemap *tst_get_nodemap(int type, size_t
> min_mem_kb)
>
>         tst_res(TINFO, "Found %u NUMA memory nodes", cnt);
>
> -       nodes = SAFE_MALLOC(sizeof(struct tst_nodemap)
> +       nodes = SAFE_MALLOC(sizeof(struct etst_nodemap)
>                             + sizeof(unsigned int) * cnt);
>         nodes->cnt = cnt;
>         nodes->counters = NULL;
> diff --git a/libs/sigwait/sigwait.c b/libs/sigwait/etst_sigwait.c
> similarity index 92%
> rename from libs/sigwait/sigwait.c
> rename to libs/sigwait/etst_sigwait.c
> index a9fd62d73..801feba41 100644
> --- a/libs/sigwait/sigwait.c
> +++ b/libs/sigwait/etst_sigwait.c
> @@ -5,11 +5,11 @@
>  #include <errno.h>
>  #include <stdlib.h>
>  #include <limits.h>
> -#include "libsigwait.h"
> +#include "etst_sigwait.h"
>  #include "tst_sig_proc.h"
>  #include "lapi/syscalls.h"
>
> -void test_empty_set(swi_func sigwaitinfo, int signo,
> +void etst_empty_set(swi_func sigwaitinfo, int signo,
>                     enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
>  {
>         sigset_t sigs;
> @@ -35,7 +35,7 @@ void test_empty_set(swi_func sigwaitinfo, int signo,
>         SAFE_WAIT(NULL);
>  }
>
> -void test_timeout(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
> +void etst_timeout(swi_func sigwaitinfo, int signo, enum tst_ts_type type)
>  {
>         sigset_t sigs;
>         siginfo_t si;
> @@ -68,7 +68,7 @@ void test_timeout(swi_func sigwaitinfo, int signo, enum
> tst_ts_type type)
>  /* Note: sigwait-ing for a signal that is not blocked is unspecified
>   * by POSIX; but works for non-ignored signals under Linux
>   */
> -void test_unmasked_matching(swi_func sigwaitinfo, int signo,
> +void etst_unmasked_matching(swi_func sigwaitinfo, int signo,
>                             enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
>  {
>         sigset_t sigs;
> @@ -96,7 +96,7 @@ void test_unmasked_matching(swi_func sigwaitinfo, int
> signo,
>         SAFE_WAIT(NULL);
>  }
>
> -void test_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo,
> +void etst_unmasked_matching_noinfo(swi_func sigwaitinfo, int signo,
>                                    enum tst_ts_type type
> LTP_ATTRIBUTE_UNUSED)
>  {
>         sigset_t sigs;
> @@ -118,7 +118,7 @@ void test_unmasked_matching_noinfo(swi_func
> sigwaitinfo, int signo,
>         SAFE_WAIT(NULL);
>  }
>
> -void test_masked_matching(swi_func sigwaitinfo, int signo,
> +void etst_masked_matching(swi_func sigwaitinfo, int signo,
>                           enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
>  {
>         sigset_t sigs, oldmask;
> @@ -166,7 +166,7 @@ void test_masked_matching(swi_func sigwaitinfo, int
> signo,
>         SAFE_WAIT(NULL);
>  }
>
> -void test_masked_matching_rt(swi_func sigwaitinfo, int signo,
> +void etst_masked_matching_rt(swi_func sigwaitinfo, int signo,
>                              enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
>  {
>         sigset_t sigs, oldmask;
> @@ -232,7 +232,7 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int
> signo,
>                          "sigwaitinfo failed to restore the original
> mask");
>  }
>
> -void test_masked_matching_noinfo(swi_func sigwaitinfo, int signo,
> +void etst_masked_matching_noinfo(swi_func sigwaitinfo, int signo,
>                                  enum tst_ts_type type
> LTP_ATTRIBUTE_UNUSED)
>  {
>         sigset_t sigs, oldmask;
> @@ -274,7 +274,7 @@ void test_masked_matching_noinfo(swi_func sigwaitinfo,
> int signo,
>         SAFE_WAIT(NULL);
>  }
>
> -void test_bad_address(swi_func sigwaitinfo, int signo,
> +void etst_bad_address(swi_func sigwaitinfo, int signo,
>                       enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
>  {
>         sigset_t sigs, oldmask;
> @@ -301,7 +301,7 @@ void test_bad_address(swi_func sigwaitinfo, int signo,
>         SAFE_WAIT(NULL);
>  }
>
> -void test_bad_address2(swi_func sigwaitinfo, int signo
> LTP_ATTRIBUTE_UNUSED,
> +void etst_bad_address2(swi_func sigwaitinfo, int signo
> LTP_ATTRIBUTE_UNUSED,
>                        enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
>  {
>         pid_t pid;
> @@ -342,7 +342,7 @@ void test_bad_address2(swi_func sigwaitinfo, int signo
> LTP_ATTRIBUTE_UNUSED,
>         }
>  }
>
> -void test_bad_address3(swi_func sigwaitinfo, int signo
> LTP_ATTRIBUTE_UNUSED,
> +void etst_bad_address3(swi_func sigwaitinfo, int signo
> LTP_ATTRIBUTE_UNUSED,
>                        enum tst_ts_type type LTP_ATTRIBUTE_UNUSED)
>  {
>         sigset_t sigs;
> @@ -373,7 +373,7 @@ static void empty_handler(int sig LTP_ATTRIBUTE_UNUSED)
>  {
>  }
>
> -void sigwait_setup(void)
> +void etst_sigwait_setup(void)
>  {
>         signal(SIGUSR1, empty_handler);
>         signal(SIGALRM, empty_handler);
> diff --git a/libs/swap/libswap.c b/libs/swap/etst_swap.c
> similarity index 98%
> rename from libs/swap/libswap.c
> rename to libs/swap/etst_swap.c
> index 3eb589cdd..38c819007 100644
> --- a/libs/swap/libswap.c
> +++ b/libs/swap/etst_swap.c
> @@ -17,7 +17,7 @@
>  #define BUFSIZE 200
>
>  #include "tst_test.h"
> -#include "libswap.h"
> +#include "etst_swap.h"
>  #include "lapi/syscalls.h"
>  #include "tst_kconfig.h"
>  #include "tst_kvercmp.h"
> @@ -157,7 +157,7 @@ int make_swapfile(const char *file, const int lineno,
>                 blocks = num;
>                 tst_res_(file, lineno, TINFO, "create a swapfile with %u
> block numbers", blocks);
>         } else {
> -               tst_brk_(file, lineno, TBROK, "Invalid method, please see
> include/libswap.h");
> +               tst_brk_(file, lineno, TBROK, "Invalid method, please see
> include/etst_swap.h");
>         }
>
>         /* To guarantee at least one page can be swapped out */
> @@ -239,7 +239,7 @@ bool is_swap_supported(const char *filename)
>         return true;
>  }
>
> -int tst_count_swaps(void)
> +int etst_count_swaps(void)
>  {
>         FILE *fp;
>         int used = -1;
> diff --git a/libs/uinput/tst_uinput.c b/libs/uinput/etst_uinput.c
> similarity index 99%
> rename from libs/uinput/tst_uinput.c
> rename to libs/uinput/etst_uinput.c
> index 16e689153..5a4d3955b 100644
> --- a/libs/uinput/tst_uinput.c
> +++ b/libs/uinput/etst_uinput.c
> @@ -12,7 +12,7 @@
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
>
> -#include "tst_uinput.h"
> +#include "etst_uinput.h"
>  #include "tst_safe_stdio.h"
>
>  #define VIRTUAL_DEVICE "virtual-device-ltp"
> diff --git a/libs/vdso/parse_vdso.c b/libs/vdso/etst_parse_vdso.c
> similarity index 99%
> rename from libs/vdso/parse_vdso.c
> rename to libs/vdso/etst_parse_vdso.c
> index cd75a8945..b5e8a2228 100644
> --- a/libs/vdso/parse_vdso.c
> +++ b/libs/vdso/etst_parse_vdso.c
> @@ -1,5 +1,5 @@
>  /*
> - * parse_vdso.c: Linux reference vDSO parser
> + * etst_parse_vdso.c: Linux reference vDSO parser
>   * Written by Andrew Lutomirski, 2011-2014.
>   *
>   * This code is meant to be linked in to various programs that run on
> Linux.
> diff --git a/libs/vdso/vdso_helpers.c b/libs/vdso/vdso_helpers.c
> index 208c12f65..36bf77d66 100644
> --- a/libs/vdso/vdso_helpers.c
> +++ b/libs/vdso/vdso_helpers.c
> @@ -7,7 +7,7 @@
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
>
> -#include "parse_vdso.h"
> +#include "etst_parse_vdso.h"
>  #include "config.h"
>
>  #ifdef HAVE_GETAUXVAL
> diff --git a/testcases/kernel/input/input_common.h
> b/testcases/kernel/input/input_common.h
> index 5b1755771..1f8f77e0b 100644
> --- a/testcases/kernel/input/input_common.h
> +++ b/testcases/kernel/input/input_common.h
> @@ -10,7 +10,7 @@
>  #include <poll.h>
>
>  #include "tst_test.h"
> -#include "tst_uinput.h"
> +#include "etst_uinput.h"
>
>  static inline int open_event_device(void)
>  {
> diff --git a/testcases/kernel/mem/cpuset/cpuset02.c
> b/testcases/kernel/mem/cpuset/cpuset02.c
> index ccfddd6a2..ec17c941e 100644
> --- a/testcases/kernel/mem/cpuset/cpuset02.c
> +++ b/testcases/kernel/mem/cpuset/cpuset02.c
> @@ -18,13 +18,13 @@
>
>  #ifdef HAVE_NUMA_V2
>  #include <numaif.h>
> -#include "tst_numa.h"
> +#include "etst_numa.h"
>
>  #define MNTPOINT "hugetlbfs/"
>  #define HUGE_PAGE_FILE MNTPOINT "hugepagefile"
>
>  static long hpage_size;
> -static struct tst_nodemap *node;
> +static struct etst_nodemap *node;
>  static int check_node_id;
>  static struct tst_cg_group *cg_cpuset_0;
>
> @@ -88,7 +88,7 @@ static void run_test(void)
>
>  static void setup(void)
>  {
> -       node = tst_get_nodemap(TST_NUMA_MEM, getpagesize() / 1024);
> +       node = etst_get_nodemap(TST_NUMA_MEM, getpagesize() / 1024);
>         if (node->cnt <= 1)
>                 tst_brk(TCONF, "test requires at least 2 NUMA memory
> nodes");
>
> diff --git a/testcases/kernel/mem/ksm/ksm06.c
> b/testcases/kernel/mem/ksm/ksm06.c
> index a8e73275d..f10dc27cf 100644
> --- a/testcases/kernel/mem/ksm/ksm06.c
> +++ b/testcases/kernel/mem/ksm/ksm06.c
> @@ -32,7 +32,7 @@
>  #include <limits.h>
>
>  #include "tst_test.h"
> -#include "tst_numa.h"
> +#include "etst_numa.h"
>  #include "ksm_helper.h"
>  #include "ksm_test.h"
>
> @@ -44,7 +44,7 @@ static unsigned long nr_pages = 100;
>  static char *n_opt;
>
>  static size_t page_size;
> -static struct tst_nodemap *nodes;
> +static struct etst_nodemap *nodes;
>
>  static void test_ksm(void)
>  {
> @@ -124,7 +124,7 @@ static void setup(void)
>
>         page_size = getpagesize();
>
> -       nodes = tst_get_nodemap(TST_NUMA_MEM, nr_pages * page_size / 1024);
> +       nodes = etst_get_nodemap(TST_NUMA_MEM, nr_pages * page_size /
> 1024);
>         if (nodes->cnt <= 1)
>                 tst_brk(TCONF, "Test requires at least two NUMA memory
> nodes");
>  }
> diff --git a/testcases/kernel/mem/shmt/shmt02.c
> b/testcases/kernel/mem/shmt/shmt02.c
> index de1d0b0c3..82c2ad04c 100644
> --- a/testcases/kernel/mem/shmt/shmt02.c
> +++ b/testcases/kernel/mem/shmt/shmt02.c
> @@ -15,7 +15,7 @@
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_rand_data.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define SHMSIZE 16
>
> diff --git a/testcases/kernel/mem/shmt/shmt03.c
> b/testcases/kernel/mem/shmt/shmt03.c
> index 63f5a7b45..a8306719b 100644
> --- a/testcases/kernel/mem/shmt/shmt03.c
> +++ b/testcases/kernel/mem/shmt/shmt03.c
> @@ -16,7 +16,7 @@
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_rand_data.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define SHMSIZE 16
>
> diff --git a/testcases/kernel/mem/shmt/shmt04.c
> b/testcases/kernel/mem/shmt/shmt04.c
> index c07b1ef93..913103d99 100644
> --- a/testcases/kernel/mem/shmt/shmt04.c
> +++ b/testcases/kernel/mem/shmt/shmt04.c
> @@ -18,7 +18,7 @@
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_rand_data.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define SHMSIZE 16
>
> diff --git a/testcases/kernel/mem/shmt/shmt05.c
> b/testcases/kernel/mem/shmt/shmt05.c
> index e8b5d9eb5..2d6c92a9b 100644
> --- a/testcases/kernel/mem/shmt/shmt05.c
> +++ b/testcases/kernel/mem/shmt/shmt05.c
> @@ -14,7 +14,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include <sys/shm.h>
>
>  #define SHMSIZE 16
> diff --git a/testcases/kernel/mem/shmt/shmt07.c
> b/testcases/kernel/mem/shmt/shmt07.c
> index 962479e75..8754af413 100644
> --- a/testcases/kernel/mem/shmt/shmt07.c
> +++ b/testcases/kernel/mem/shmt/shmt07.c
> @@ -16,7 +16,7 @@
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_rand_data.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define SHMSIZE 16
>
> diff --git a/testcases/kernel/mem/shmt/shmt08.c
> b/testcases/kernel/mem/shmt/shmt08.c
> index 9fb2f6b22..7e09b2e9c 100644
> --- a/testcases/kernel/mem/shmt/shmt08.c
> +++ b/testcases/kernel/mem/shmt/shmt08.c
> @@ -14,7 +14,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define SHMSIZE 16
>
> diff --git a/testcases/kernel/mem/shmt/shmt09.c
> b/testcases/kernel/mem/shmt/shmt09.c
> index fb40498e6..db1aa2ab9 100644
> --- a/testcases/kernel/mem/shmt/shmt09.c
> +++ b/testcases/kernel/mem/shmt/shmt09.c
> @@ -19,7 +19,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "tst_test_macros.h"
>
>  #define SHMSIZE 16
> diff --git a/testcases/kernel/mem/shmt/shmt10.c
> b/testcases/kernel/mem/shmt/shmt10.c
> index 2bd48b6b5..22c6c5350 100644
> --- a/testcases/kernel/mem/shmt/shmt10.c
> +++ b/testcases/kernel/mem/shmt/shmt10.c
> @@ -16,7 +16,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define SHMSIZE 0x32768
>
> diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> index 4f262da00..99ed0a3b3 100644
> --- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> @@ -13,7 +13,7 @@
>   */
>
>  #include "config.h"
> -#include "parse_vdso.h"
> +#include "etst_parse_vdso.h"
>  #include "time64_variants.h"
>  #include "tst_timer.h"
>  #include "tst_safe_clocks.h"
> diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
> b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
> index 3c854d109..9f9060b54 100644
> --- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
> +++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
> @@ -22,7 +22,7 @@
>  #include <numa.h>
>  #include <numaif.h>
>  #include <errno.h>
> -#include "tst_numa.h"
> +#include "etst_numa.h"
>
>  #define MEM_LENGTH     (4 * 1024 * 1024)
>  #define PAGES_ALLOCATED 16u
> @@ -32,7 +32,7 @@
>  #define POLICY_DESC_FLAGS(x, y) .policy = x, .flags = y, .desc = "policy:
> "#x", flags: "#y
>  #define POLICY_DESC_FLAGS_NO_TARGET(x, y) .policy = x, .flags = y, .desc
> = "policy: "#x", flags: "#y", no target"
>
> -static struct tst_nodemap *node;
> +static struct etst_nodemap *node;
>  static struct bitmask *nodemask, *getnodemask, *empty_nodemask;
>
>  struct test_case {
> @@ -142,7 +142,7 @@ static void setup(void)
>  {
>         unsigned int i;
>
> -       node = tst_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED *
> getpagesize() / 1024);
> +       node = etst_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED *
> getpagesize() / 1024);
>         if (node->cnt < 1)
>                 tst_brk(TCONF, "test requires at least one NUMA memory
> node");
>
> @@ -175,7 +175,7 @@ static void cleanup(void)
>
>         numa_free_nodemask(nodemask);
>         numa_free_nodemask(getnodemask);
> -       tst_nodemap_free(node);
> +       etst_nodemap_free(node);
>  }
>
>  static void do_test(unsigned int i)
> diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
> b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
> index 79ff5d94f..969ad81b0 100644
> --- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
> +++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy02.c
> @@ -22,13 +22,13 @@
>  #include <numa.h>
>  #include <numaif.h>
>  #include <errno.h>
> -#include "tst_numa.h"
> +#include "etst_numa.h"
>
>  #define PAGES_ALLOCATED 16u
>
>  #define POLICY_DESC_TEXT(x, y) .policy = x, .desc = "policy: "#x", "y
>
> -static struct tst_nodemap *node;
> +static struct etst_nodemap *node;
>  static struct bitmask *nodemask;
>
>  struct test_case {
> @@ -55,7 +55,7 @@ static struct test_case tcase[] = {
>
>  static void setup(void)
>  {
> -       node = tst_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED *
> getpagesize() / 1024);
> +       node = etst_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED *
> getpagesize() / 1024);
>         if (node->cnt < 1)
>                 tst_brk(TCONF, "test requires at least one NUMA memory
> node");
>
> @@ -65,7 +65,7 @@ static void setup(void)
>  static void cleanup(void)
>  {
>         numa_free_nodemask(nodemask);
> -       tst_nodemap_free(node);
> +       etst_nodemap_free(node);
>  }
>
>  static void do_test(unsigned int i)
> diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
> b/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
> index 56d1505fd..06e92d01b 100644
> --- a/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
> +++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl01.c
> @@ -13,7 +13,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static int msg_id = -1;
>  static time_t creat_time;
> diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
> b/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
> index 1ace62f11..1384e6473 100644
> --- a/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
> +++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl02.c
> @@ -13,7 +13,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static int msg_id = -1;
>  struct msqid_ds orig_buf;
> diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
> b/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
> index cc7abd4b9..57fa512d9 100644
> --- a/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
> +++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl03.c
> @@ -12,7 +12,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static void verify_msgctl(void)
>  {
> diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
> b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
> index 4b62896fb..f30ccd8e0 100644
> --- a/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
> +++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl04.c
> @@ -14,7 +14,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/syscalls.h"
>
>  static int msg_id1 = -1;
> diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
> b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
> index 7e059d7f0..c184b855b 100644
> --- a/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
> +++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl05.c
> @@ -8,7 +8,7 @@
>   */
>  #include <sys/msg.h>
>  #include "lapi/msgbuf.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
>
> diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
> b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
> index 2e22f37fe..e34a83998 100644
> --- a/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
> +++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl06.c
> @@ -25,7 +25,7 @@
>  #include <pwd.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/msg.h"
>
>  static int msg_id = -1;
> diff --git a/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c
> b/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c
> index 73eead744..3cfa35f11 100644
> --- a/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c
> +++ b/testcases/kernel/syscalls/ipc/msgctl/msgctl12.c
> @@ -13,7 +13,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static int msg_q = -1;
>  static int index_q;
> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget01.c
> b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
> index dd5a5ad73..ac29f8bbe 100644
> --- a/testcases/kernel/syscalls/ipc/msgget/msgget01.c
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget01.c
> @@ -16,7 +16,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static int queue_id = -1;
>  static key_t msgkey;
> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget02.c
> b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
> index ef9ab34b8..0055ba4b1 100644
> --- a/testcases/kernel/syscalls/ipc/msgget/msgget02.c
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget02.c
> @@ -24,7 +24,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static key_t msgkey, msgkey1;
>  static int queue_id = -1;
> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> index bd0653973..4c6505b3a 100644
> --- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> @@ -17,7 +17,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static int maxmsgs, queue_cnt, used_cnt;
>  static int *queues;
> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget04.c
> b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
> index 28cbb3352..9c068e752 100644
> --- a/testcases/kernel/syscalls/ipc/msgget/msgget04.c
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
> @@ -20,7 +20,7 @@
>  #include <sys/msg.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define NEXT_ID_PATH "/proc/sys/kernel/msg_next_id"
>  static int queue_id, pid;
> diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget05.c
> b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
> index edcb307c6..402da31aa 100644
> --- a/testcases/kernel/syscalls/ipc/msgget/msgget05.c
> +++ b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
> @@ -18,7 +18,7 @@
>  #include <sys/msg.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define NEXT_ID_PATH "/proc/sys/kernel/msg_next_id"
>
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
> b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
> index 58bfd2771..11b6ae1a0 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv01.c
> @@ -10,7 +10,7 @@
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_clocks.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static key_t msgkey;
>  static int queue_id = -1, pid;
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
> b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
> index 3e4462c03..6cd3581d9 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv02.c
> @@ -30,7 +30,7 @@
>  #include <pwd.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static key_t msgkey;
>  static int queue_id = -1;
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
> b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
> index 3e461b307..b3d3c63e7 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv03.c
> @@ -27,7 +27,7 @@
>  #include <pwd.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/msg.h"
>
>  static key_t msgkey;
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
> b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
> index cc385ee6e..6b887cb1e 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv05.c
> @@ -11,7 +11,7 @@
>  #include <stdlib.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static key_t msgkey;
>  static int queue_id = -1;
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
> b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
> index f14526df9..d5f4f0e22 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv06.c
> @@ -13,7 +13,7 @@
>  #include <stdlib.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static key_t msgkey;
>  static int queue_id = -1;
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> index d2d1a882a..8c70a02d2 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv07.c
> @@ -29,7 +29,7 @@
>  #include <sys/wait.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/msg.h"
>
>  #define MSGTYPE1       1
> diff --git a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
> b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
> index 1ab6eba9f..82b0b3f2f 100644
> --- a/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
> +++ b/testcases/kernel/syscalls/ipc/msgrcv/msgrcv08.c
> @@ -27,7 +27,7 @@
>  #include <sys/msg.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static long mtype = 121;
>  static key_t msgkey;
> diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
> b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
> index 6d92f3dec..63fd9a26a 100644
> --- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
> +++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
> @@ -16,7 +16,7 @@
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_clocks.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static key_t msgkey;
>  static int queue_id = -1, pid;
> diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
> b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
> index eca660605..d8d241062 100644
> --- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
> +++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
> @@ -28,7 +28,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static key_t msgkey;
>  static int queue_id = -1;
> diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
> b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
> index 887bfdef2..cc3b53253 100644
> --- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
> +++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
> @@ -21,7 +21,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static key_t msgkey;
>  static int queue_id = -1;
> diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
> b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
> index 8fc665e68..124e47d2d 100644
> --- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
> +++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
> @@ -17,7 +17,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static key_t msgkey;
>  static int queue_id = -1;
> diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
> b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
> index 92a36bff0..c9f65ed28 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl01.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl01.c
> @@ -11,7 +11,7 @@
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_test.h"
>  #include "lapi/sem.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define INCVAL 2
>  #define NEWMODE 066
> diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl02.c
> b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
> index 6ca63472c..254214a02 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl02.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl02.c
> @@ -12,7 +12,7 @@
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_test.h"
>  #include "lapi/sem.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static int sem_id = -1;
>
> diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl03.c
> b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
> index 11530b201..87a35ae54 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl03.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl03.c
> @@ -12,7 +12,7 @@
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_test.h"
>  #include "lapi/sem.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/syscalls.h"
>
>  static int sem_id = -1;
> diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl04.c
> b/testcases/kernel/syscalls/ipc/semctl/semctl04.c
> index f6fa361b2..ca65244fe 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl04.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl04.c
> @@ -17,7 +17,7 @@
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_test.h"
>  #include "lapi/sem.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static uid_t ltp_uid;
>  static int sem_id = -1;
> diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl05.c
> b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
> index 5feee0082..8e6b22d5b 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl05.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl05.c
> @@ -13,7 +13,7 @@
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_test.h"
>  #include "lapi/sem.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static int sem_id = -1;
>
> diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl06.c
> b/testcases/kernel/syscalls/ipc/semctl/semctl06.c
> index b8734c2fa..84e306dc1 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl06.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl06.c
> @@ -53,7 +53,7 @@
>  #include <signal.h>
>  #include "test.h"
>  #include <sys/wait.h>
> -#include "ipcsem.h"
> +#include "etst_ipcsem.h"
>
>  int local_flag = 1;
>
> diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl07.c
> b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
> index 588fb2436..d78c0c68a 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl07.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl07.c
> @@ -20,7 +20,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/sem.h"
>
>  static int semid = -1;
> diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl08.c
> b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
> index f4549adf4..a2f5ed9c0 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl08.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl08.c
> @@ -10,7 +10,7 @@
>  #include "lapi/sembuf.h"
>  #include "lapi/sem.h"
>  #include "tst_test.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #ifdef HAVE_SEMID64_DS_TIME_HIGH
>
> diff --git a/testcases/kernel/syscalls/ipc/semctl/semctl09.c
> b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
> index 32b411efd..4fb5dbe16 100644
> --- a/testcases/kernel/syscalls/ipc/semctl/semctl09.c
> +++ b/testcases/kernel/syscalls/ipc/semctl/semctl09.c
> @@ -40,7 +40,7 @@
>  #include <pwd.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/sem.h"
>  #include "lapi/syscalls.h"
>
> diff --git a/testcases/kernel/syscalls/ipc/semget/semget01.c
> b/testcases/kernel/syscalls/ipc/semget/semget01.c
> index 3c05517e4..a3a25f922 100644
> --- a/testcases/kernel/syscalls/ipc/semget/semget01.c
> +++ b/testcases/kernel/syscalls/ipc/semget/semget01.c
> @@ -12,7 +12,7 @@
>  #include <sys/ipc.h>
>  #include "lapi/sem.h"
>  #include "tst_test.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "tst_safe_sysv_ipc.h"
>
>  static int sem_id = -1, sem_key = -1;
> diff --git a/testcases/kernel/syscalls/ipc/semget/semget02.c
> b/testcases/kernel/syscalls/ipc/semget/semget02.c
> index d381bbd69..9df84ddfc 100644
> --- a/testcases/kernel/syscalls/ipc/semget/semget02.c
> +++ b/testcases/kernel/syscalls/ipc/semget/semget02.c
> @@ -26,7 +26,7 @@
>  #include <pwd.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/sem.h"
>
>  static int sem_id = -1;
> diff --git a/testcases/kernel/syscalls/ipc/semget/semget05.c
> b/testcases/kernel/syscalls/ipc/semget/semget05.c
> index 0e41a1528..c10e918e9 100644
> --- a/testcases/kernel/syscalls/ipc/semget/semget05.c
> +++ b/testcases/kernel/syscalls/ipc/semget/semget05.c
> @@ -16,7 +16,7 @@
>  #include <sys/ipc.h>
>  #include "lapi/sem.h"
>  #include "tst_test.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "tst_safe_sysv_ipc.h"
>
>  static int *sem_id_arr;
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop01.c
> b/testcases/kernel/syscalls/ipc/semop/semop01.c
> index 207263539..433da970f 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop01.c
> +++ b/testcases/kernel/syscalls/ipc/semop/semop01.c
> @@ -9,7 +9,7 @@
>
>  #include <stdlib.h>
>  #include "tst_test.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/sem.h"
>  #include "semop.h"
>
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop02.c
> b/testcases/kernel/syscalls/ipc/semop/semop02.c
> index d8181db17..acfaac352 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop02.c
> +++ b/testcases/kernel/syscalls/ipc/semop/semop02.c
> @@ -23,7 +23,7 @@
>  #include <pwd.h>
>  #include <sys/ipc.h>
>  #include "tst_test.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/sem.h"
>  #include "semop.h"
>
> diff --git a/testcases/kernel/syscalls/ipc/semop/semop03.c
> b/testcases/kernel/syscalls/ipc/semop/semop03.c
> index 636b71531..487def0ec 100644
> --- a/testcases/kernel/syscalls/ipc/semop/semop03.c
> +++ b/testcases/kernel/syscalls/ipc/semop/semop03.c
> @@ -12,7 +12,7 @@
>  #include <sys/types.h>
>  #include <sys/wait.h>
>  #include "tst_test.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/sem.h"
>  #include "semop.h"
>
> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> index 606bdd154..b7b3ebe16 100644
> --- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> +++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
> @@ -26,7 +26,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define ALIGN_DOWN(in_addr) ((void *)(((uintptr_t)in_addr / SHMLBA) *
> SHMLBA))
>
> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat02.c
> b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
> index 3ad1fd08e..505ed1e80 100644
> --- a/testcases/kernel/syscalls/ipc/shmat/shmat02.c
> +++ b/testcases/kernel/syscalls/ipc/shmat/shmat02.c
> @@ -22,7 +22,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static int shm_id1 = -1;
>  static int shm_id2 = -1;
> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat04.c
> b/testcases/kernel/syscalls/ipc/shmat/shmat04.c
> index 7b7b802cb..7dac266f0 100644
> --- a/testcases/kernel/syscalls/ipc/shmat/shmat04.c
> +++ b/testcases/kernel/syscalls/ipc/shmat/shmat04.c
> @@ -21,7 +21,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static int segment_id = -1;
>  static int key_id;
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> index e86cd7103..f38709644 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
> @@ -20,7 +20,7 @@
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_clocks.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define NCHILD 20
>
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
> b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
> index 0b12944ce..45950c423 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl02.c
> @@ -29,7 +29,7 @@
>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/syscalls.h"
>
>  #define SHM_SIZE 2048
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
> b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
> index a3291c37f..8bf74000a 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
> @@ -11,7 +11,7 @@
>  #define _GNU_SOURCE
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static void verify_ipcinfo(void)
>  {
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
> b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
> index da73863dd..43521b830 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl04.c
> @@ -23,7 +23,7 @@
>  #include <pwd.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/shm.h"
>
>  #define SHM_SIZE 2048
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
> b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
> index 63e7f843d..50b76a0c1 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl06.c
> @@ -9,7 +9,7 @@
>
>  #include <sys/shm.h>
>  #include "lapi/shmbuf.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
>
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
> b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
> index 1cc07ead2..f9e62c4fe 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl07.c
> @@ -11,7 +11,7 @@
>  #include <stdio.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define SHM_SIZE 2048
>
> diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
> b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
> index f72f9f9e5..98f8fb4d2 100644
> --- a/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
> +++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl08.c
> @@ -14,7 +14,7 @@
>  #include <stdio.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define SHM_SIZE 2048
>
> diff --git a/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
> b/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
> index 0a6d4096c..fdd4b4fc5 100644
> --- a/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
> +++ b/testcases/kernel/syscalls/ipc/shmdt/shmdt01.c
> @@ -13,7 +13,7 @@
>  #include <sys/shm.h>
>  #include <setjmp.h>
>  #include "tst_test.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "tst_safe_sysv_ipc.h"
>
>  static int shm_id = -1, shm_key, pass;
> diff --git a/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
> b/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
> index 4bdc6eb21..ebf3f3e60 100644
> --- a/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
> +++ b/testcases/kernel/syscalls/ipc/shmdt/shmdt02.c
> @@ -13,7 +13,7 @@
>  #include <sys/types.h>
>  #include <sys/shm.h>
>  #include "tst_test.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static void *non_attched_addr;
>  static void *unaligned_addr;
> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> index 8a0961b04..f3274c490 100644
> --- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
> @@ -32,7 +32,7 @@
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_kconfig.h"
>  #include "tst_test.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/shm.h"
>
>  static int shm_id = -1;
> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
> b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
> index 092f2170e..81860a6c6 100644
> --- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
> @@ -17,7 +17,7 @@
>  #include <sys/shm.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  static int *queues;
>  static int maxshms, queue_cnt, used_cnt;
> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget04.c
> b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
> index 2a6a676cd..33d29fbe9 100644
> --- a/testcases/kernel/syscalls/ipc/shmget/shmget04.c
> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget04.c
> @@ -19,7 +19,7 @@
>  #include <sys/shm.h>
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_test.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "lapi/shm.h"
>
>  static int shm_id = -1;
> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget05.c
> b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
> index d96a98546..c31a59e85 100644
> --- a/testcases/kernel/syscalls/ipc/shmget/shmget05.c
> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
> @@ -21,7 +21,7 @@
>  #include <sys/shm.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define NEXT_ID_PATH "/proc/sys/kernel/shm_next_id"
>  static int shm_id, pid;
> diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget06.c
> b/testcases/kernel/syscalls/ipc/shmget/shmget06.c
> index f4bd61bca..2b1023baa 100644
> --- a/testcases/kernel/syscalls/ipc/shmget/shmget06.c
> +++ b/testcases/kernel/syscalls/ipc/shmget/shmget06.c
> @@ -19,7 +19,7 @@
>  #include <sys/shm.h>
>  #include "tst_test.h"
>  #include "tst_safe_sysv_ipc.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>
>  #define NEXT_ID_PATH "/proc/sys/kernel/shm_next_id"
>
> diff --git a/testcases/kernel/syscalls/kill/kill05.c
> b/testcases/kernel/syscalls/kill/kill05.c
> index 3c317e2fc..66c452f01 100644
> --- a/testcases/kernel/syscalls/kill/kill05.c
> +++ b/testcases/kernel/syscalls/kill/kill05.c
> @@ -20,7 +20,7 @@
>  #include <pwd.h>
>  #include <stdlib.h>
>  #include "tst_test.h"
> -#include "libnewipc.h"
> +#include "etst_newipc.h"
>  #include "tst_safe_sysv_ipc.h"
>  #include "tst_safe_macros.h"
>  #include "tst_uid.h"
> diff --git a/testcases/kernel/syscalls/mbind/mbind01.c
> b/testcases/kernel/syscalls/mbind/mbind01.c
> index 4b8d168cd..3429a1702 100644
> --- a/testcases/kernel/syscalls/mbind/mbind01.c
> +++ b/testcases/kernel/syscalls/mbind/mbind01.c
> @@ -17,7 +17,7 @@
>  #include "config.h"
>  #include "numa_helper.h"
>  #include "tst_test.h"
> -#include "tst_numa.h"
> +#include "etst_numa.h"
>  #include "lapi/numaif.h"
>
>  #ifdef HAVE_NUMA_V2
> @@ -141,7 +141,7 @@ static void check_policy_pref_or_local(int policy)
>         if (policy != MPOL_PREFERRED && policy != MPOL_LOCAL) {
>                 tst_res(TFAIL, "Wrong policy: %s(%d), "
>                         "expected MPOL_PREFERRED or MPOL_LOCAL",
> -                       tst_mempolicy_mode_name(policy), policy);
> +                       etst_mempolicy_mode_name(policy), policy);
>         }
>  }
>
> @@ -221,8 +221,8 @@ static void do_test(unsigned int i)
>                         tc->check_policy(policy);
>                 else if (tc->policy != policy) {
>                         tst_res(TFAIL, "Wrong policy: %s(%d), expected:
> %s(%d)",
> -                               tst_mempolicy_mode_name(policy), policy,
> -                               tst_mempolicy_mode_name(tc->policy),
> tc->policy);
> +                               etst_mempolicy_mode_name(policy), policy,
> +                               etst_mempolicy_mode_name(tc->policy),
> tc->policy);
>                         fail = 1;
>                 }
>                 if (tc->exp_nodemask) {
> diff --git a/testcases/kernel/syscalls/mbind/mbind02.c
> b/testcases/kernel/syscalls/mbind/mbind02.c
> index cd6a03226..e13854c66 100644
> --- a/testcases/kernel/syscalls/mbind/mbind02.c
> +++ b/testcases/kernel/syscalls/mbind/mbind02.c
> @@ -21,25 +21,25 @@
>  # include <numaif.h>
>  #endif
>  #include "tst_test.h"
> -#include "tst_numa.h"
> +#include "etst_numa.h"
>
>  #ifdef HAVE_NUMA_V2
>
>  static size_t page_size;
> -static struct tst_nodemap *nodes;
> +static struct etst_nodemap *nodes;
>
>  static void setup(void)
>  {
>         page_size = getpagesize();
>
> -       nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * page_size / 1024);
> +       nodes = etst_get_nodemap(TST_NUMA_MEM, 2 * page_size / 1024);
>         if (nodes->cnt <= 1)
>                 tst_brk(TCONF, "Test requires at least two NUMA memory
> nodes");
>  }
>
>  static void cleanup(void)
>  {
> -       tst_nodemap_free(nodes);
> +       etst_nodemap_free(nodes);
>  }
>
>  static void verify_policy(int mode)
> @@ -50,11 +50,11 @@ static void verify_policy(int mode)
>         unsigned long size = page_size;
>         int node = 0;
>
> -       ptr = tst_numa_map(NULL, size);
> -       tst_nodemap_reset_counters(nodes);
> -       tst_numa_fault(ptr, size);
> -       tst_nodemap_count_pages(nodes, ptr, size);
> -       tst_nodemap_print_counters(nodes);
> +       ptr = etst_numa_map(NULL, size);
> +       etst_nodemap_reset_counters(nodes);
> +       etst_numa_fault(ptr, size);
> +       etst_nodemap_count_pages(nodes, ptr, size);
> +       etst_nodemap_print_counters(nodes);
>
>         for (i = 0; i < nodes->cnt; i++) {
>                 if (!nodes->counters[i]) {
> @@ -67,24 +67,24 @@ static void verify_policy(int mode)
>
>         TEST(mbind(ptr, size, mode, bm->maskp, bm->size + 1,
> MPOL_MF_STRICT));
>
> -       tst_numa_unmap(ptr, size);
> +       etst_numa_unmap(ptr, size);
>         numa_free_nodemask(bm);
>
>         if (TST_RET != -1) {
>                 tst_res(TFAIL,
>                         "mbind(%s, MPOL_MF_STRICT) node %u returned %li,
> expected -1",
> -                       tst_mempolicy_mode_name(mode), node, TST_RET);
> +                       etst_mempolicy_mode_name(mode), node, TST_RET);
>                 return;
>         }
>
>         if (TST_ERR == EIO) {
>                 tst_res(TPASS | TTERRNO,
>                         "mbind(%s, MPOL_MF_STRICT) node %u",
> -                       tst_mempolicy_mode_name(mode), node);
> +                       etst_mempolicy_mode_name(mode), node);
>         } else {
>                 tst_res(TFAIL | TTERRNO,
>                         "mbind(%s, MPOL_MF_STRICT) node %u expected EIO",
> -                       tst_mempolicy_mode_name(mode), node);
> +                       etst_mempolicy_mode_name(mode), node);
>         }
>  }
>
> diff --git a/testcases/kernel/syscalls/mbind/mbind03.c
> b/testcases/kernel/syscalls/mbind/mbind03.c
> index 3d477c9cb..10e64af8b 100644
> --- a/testcases/kernel/syscalls/mbind/mbind03.c
> +++ b/testcases/kernel/syscalls/mbind/mbind03.c
> @@ -18,25 +18,25 @@
>  # include "mbind.h"
>  #endif
>  #include "tst_test.h"
> -#include "tst_numa.h"
> +#include "etst_numa.h"
>
>  #ifdef HAVE_NUMA_V2
>
>  static size_t page_size;
> -static struct tst_nodemap *nodes;
> +static struct etst_nodemap *nodes;
>
>  static void setup(void)
>  {
>         page_size = getpagesize();
>
> -       nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * page_size / 1024);
> +       nodes = etst_get_nodemap(TST_NUMA_MEM, 2 * page_size / 1024);
>         if (nodes->cnt <= 1)
>                 tst_brk(TCONF, "Test requires at least two NUMA memory
> nodes");
>  }
>
>  static void cleanup(void)
>  {
> -       tst_nodemap_free(nodes);
> +       etst_nodemap_free(nodes);
>  }
>
>  static void verify_policy(int mode, unsigned flag)
> @@ -47,11 +47,11 @@ static void verify_policy(int mode, unsigned flag)
>         unsigned long size = page_size;
>         unsigned int node = 0;
>
> -       ptr = tst_numa_map(NULL, size);
> -       tst_nodemap_reset_counters(nodes);
> -       tst_numa_fault(ptr, size);
> -       tst_nodemap_count_pages(nodes, ptr, size);
> -       tst_nodemap_print_counters(nodes);
> +       ptr = etst_numa_map(NULL, size);
> +       etst_nodemap_reset_counters(nodes);
> +       etst_numa_fault(ptr, size);
> +       etst_nodemap_count_pages(nodes, ptr, size);
> +       etst_nodemap_print_counters(nodes);
>
>         for (i = 0; i < nodes->cnt; i++) {
>                 if (!nodes->counters[i]) {
> @@ -67,15 +67,15 @@ static void verify_policy(int mode, unsigned flag)
>         if (TST_RET) {
>                 tst_res(TFAIL | TTERRNO,
>                         "mbind(%s, %s) node %u",
> -                       tst_mempolicy_mode_name(mode),
> mbind_flag_name(flag), node);
> +                       etst_mempolicy_mode_name(mode),
> mbind_flag_name(flag), node);
>                 goto exit;
>         } else {
>                 tst_res(TPASS, "mbind(%s, %s) node %u succeded",
> -                       tst_mempolicy_mode_name(mode),
> mbind_flag_name(flag), node);
> +                       etst_mempolicy_mode_name(mode),
> mbind_flag_name(flag), node);
>         }
>
> -       tst_nodemap_reset_counters(nodes);
> -       tst_nodemap_count_pages(nodes, ptr, size);
> +       etst_nodemap_reset_counters(nodes);
> +       etst_nodemap_count_pages(nodes, ptr, size);
>
>         for (i = 0; i < nodes->cnt; i++) {
>                 if (nodes->map[i] == node) {
> @@ -95,7 +95,7 @@ static void verify_policy(int mode, unsigned flag)
>         }
>
>  exit:
> -       tst_numa_unmap(ptr, size);
> +       etst_numa_unmap(ptr, size);
>         numa_free_nodemask(bm);
>  }
>
> diff --git a/testcases/kernel/syscalls/mbind/mbind04.c
> b/testcases/kernel/syscalls/mbind/mbind04.c
> index 50028835f..f7f4c3176 100644
> --- a/testcases/kernel/syscalls/mbind/mbind04.c
> +++ b/testcases/kernel/syscalls/mbind/mbind04.c
> @@ -18,12 +18,12 @@
>  # include "mbind.h"
>  #endif
>  #include "tst_test.h"
> -#include "tst_numa.h"
> +#include "etst_numa.h"
>
>  #ifdef HAVE_NUMA_V2
>
>  static size_t page_size;
> -static struct tst_nodemap *nodes;
> +static struct etst_nodemap *nodes;
>
>  #define PAGES_ALLOCATED 16u
>
> @@ -31,14 +31,14 @@ static void setup(void)
>  {
>         page_size = getpagesize();
>
> -       nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * PAGES_ALLOCATED *
> page_size / 1024);
> +       nodes = etst_get_nodemap(TST_NUMA_MEM, 2 * PAGES_ALLOCATED *
> page_size / 1024);
>         if (nodes->cnt <= 1)
>                 tst_brk(TCONF, "Test requires at least two NUMA memory
> nodes");
>  }
>
>  static void cleanup(void)
>  {
> -       tst_nodemap_free(nodes);
> +       etst_nodemap_free(nodes);
>  }
>
>  static void verify_policy(unsigned int node, int mode, unsigned flag)
> @@ -51,7 +51,7 @@ static void verify_policy(unsigned int node, int mode,
> unsigned flag)
>
>         numa_bitmask_setbit(bm, node);
>
> -       ptr = tst_numa_map(NULL, size);
> +       ptr = etst_numa_map(NULL, size);
>
>         TEST(mbind(ptr, size, mode, bm->maskp, bm->size + 1, flag));
>
> @@ -60,12 +60,12 @@ static void verify_policy(unsigned int node, int mode,
> unsigned flag)
>         if (TST_RET) {
>                 tst_res(TFAIL | TTERRNO,
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
