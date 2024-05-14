Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83267C04FFE
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 07:21:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BFBC3CF26C
	for <ltp@archiver.kernel.org>; Tue, 14 May 2024 09:21:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9E953C0311
 for <ltp@lists.linux.it>; Tue, 14 May 2024 09:21:23 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D28006001FA
 for <ltp@lists.linux.it>; Tue, 14 May 2024 09:21:22 +0200 (CEST)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-62027fcf9b1so44614237b3.0
 for <ltp@lists.linux.it>; Tue, 14 May 2024 00:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715671281; x=1716276081; darn=lists.linux.it;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wBeCKl7LcryAmwxtp9G0AvavWu8PRYjhBPYLTYFg9xk=;
 b=b7TX/nrca4lqD1Eo5u9zthoZK5LHH3Dn9qGbJk7U3HZcHwLuerfK22PkhNJJ4mjeby
 Ru2JJMJeaBgYh1CEa3BDODGzRV8GecU2QBfdc1EmSh6pSbIhks9qDUpVbAinAJYg4xcU
 UocH580iSgvL4VZfLOmTyMnexThh5UUSowhuH8zax0FW5htBlEzhh0VwDYU2wfbPGCZX
 yx9fm62mo88onr3AFnxUQMQ+tMIU7FUrW7toNaexCmnujTjEIG1l1lriC+uJwbIOErRO
 T4WXt7H6zCEjNR/THMV3BkBLoX84M8wAJn43Bi5HUBYpa7LzJQ0c6zybxyBnTLTHuyBR
 sbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715671281; x=1716276081;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wBeCKl7LcryAmwxtp9G0AvavWu8PRYjhBPYLTYFg9xk=;
 b=bWLWcQi+2JkGuKoiijSpZqs6IbU/9wMbmDkrOsu2JFs2LFM5tzhlBpqCxXih50C5y7
 koSQnBK/xiFP1lZ92DcOO3dPYa7dNeT296gBoeGqrlryueIgVi6mCeipdDHpvPWH8VQV
 jWXgjqKA9kSQjpqaG02bMxMtwqAxC3DZKRoFjXGaGa+Iwx1rCPdAlW+TSqy5pKvGd1gL
 TqhMG6wnIt1z/sCaeX+gq1jTo+FSMhbiKOwQUZ01XttCHYIDrxkAr9Y+YQIKDeSsGdHo
 rBJzGRSLtllm/GPkkZHKKM0VUlQ1dNGlwut85hCszCHkTZrg53lF3LdZ5cQLXl6k5zQF
 W0ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCULEziu2ZJ/YRxQeds1XjJdu9I0AgylgtUVKmWVsvUVvnqxFB6XLFMuksyJOCCSi+dUad25u52bWaB9jfnMYsmT1xg=
X-Gm-Message-State: AOJu0YwRz1rrb9dm6bGHuR7pPnrtK6LpMsVGppn5wwlXn4pGLu2G/+CT
 JIjUh2lQvrEOuyfUvarcvHQF9hKVzNGnezVuyPvMAE1wcPLGADtyf1WflL11b2ZHwJb4WMMim6l
 AGy9VWGsBHU2878hCv6Q3Pa7/pqE=
X-Google-Smtp-Source: AGHT+IF+NWIc/8rzLAPtiJjM76hJROHAL3bG0Wk4uN0kt/k3rpAgSJZcS2PjPAHt7UpzIsBAYQs/JJ94ToJCOKk47OY=
X-Received: by 2002:a81:4883:0:b0:61b:e694:2225 with SMTP id
 00721157ae682-62099329b09mr110264837b3.5.1715671281589; Tue, 14 May 2024
 00:21:21 -0700 (PDT)
MIME-Version: 1.0
From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Tue, 14 May 2024 15:21:10 +0800
Message-ID: <CADJHv_v7BZORM+E6fMBD_TX_+uym7GuykqbpAaLqmCvqymOgCQ@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>, LTP List <ltp@lists.linux.it>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] LTP/fanotify01 corner case
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

When TMPDIR is on NFS, fanotify01 get ENODEV when testing if it supports
reporting events with fid from multi fs in setup():

        if (fanotify_flags_supported_on_fs(FAN_REPORT_FID, FAN_MARK_MOUNT,
> FAN_OPEN, ".")) {
>                 inode_mark_fid_xdev = errno;
>
>                 tst_res(TINFO, "TMPDIR does not support reporting events
> with fid from multi fs");
>         }
>

later in test_fanotify(), fd_notify firstly gets added a mark for the fs
mounted within the NFS TMPDIR,

and then at the end of test_fanotify(), added another mark for the TMPDIR
which is NFS in this case, and check on the errno:

        ret = report_fid ? inode_mark_fid_xdev : 0;
>
>         TST_EXP_FD_OR_FAIL(fanotify_mark(fd_notify, FAN_MARK_ADD,
> FAN_CLOSE_WRITE,
>                                          AT_FDCWD, "."), ret);
>


It worked fine till

commit 30ad1938326bf9303ca38090339d948975a626f5
> Author: Amir Goldstein <amir73il@gmail.com>
> Date:   Thu Nov 30 18:56:19 2023 +0200
>
>     fanotify: allow "weak" fsid when watching a single filesystem
>

After this commit was merged, the first check got ENODEV and the second
check got EXDEV.

The both values make sense in their situation, but it seems like using one
value as expected value for another seems not accurate here for me. I don't
know much here, your help is much appreciated.

Thanks,
Murphy

A simple reproducer attached for handy.

>
> #! /bin/bash
>
> mnt=/lmnt
> nfs_tst_export=/export/nfstest
> mkdir -p $nfs_tst_export $mnt
>
> cp -f /etc/exports{,bak}
> echo $nfs_tst_export \*\(rw,no_root_squash\) > /etc/exports
> systemctl restart nfs-server
> exportfs
>
> umount $mnt > /dev/null 2>&1
> MOUNT_OPTIONS="-o vers=4.2 "
> mount $MOUNT_OPTIONS localhost:$nfs_tst_export $mnt || exit
> mount | grep nfs
>
> TMPDIR=$mnt LTP_SINGLE_FS_TYPE=xfs
> ./ltp/testcases/kernel/syscalls/fanotify/fanotify01
>
> umount $mnt
> cp -f /etc/exports{bak,}
> systemctl restart nfs-server
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
