Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F51C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 09:32:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E43C3C89AE
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 10:32:56 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 247B93C8867
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 10:32:46 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 205B71000421
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 10:32:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639387964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hs5PLIGmpkHSgAn93cc2SKKv2BHx+6Ddd1AljP4EUu4=;
 b=VeoudfUXAdhWr43/pQ3m0Q0UT5GFXNsweLFj+pc30dyONaTGXIM+0NkznLvA3m+dNDQQtQ
 TyGlFQiA32PB+W0dpDqcHoFBQzcdekAPx3jfEr92WAvj0BZbXq4nHe1r7EFirlpXrWKOid
 Svm78aP8lDc3Ff9kdxc4o3bah9D/Q9o=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-bil8et9rMbOqY_oS7PUNig-1; Mon, 13 Dec 2021 04:32:41 -0500
X-MC-Unique: bil8et9rMbOqY_oS7PUNig-1
Received: by mail-oi1-f199.google.com with SMTP id
 k124-20020acaba82000000b002a7401b177cso10651661oif.8
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 01:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hs5PLIGmpkHSgAn93cc2SKKv2BHx+6Ddd1AljP4EUu4=;
 b=hN5fpeet8VlyLS6z3VgxyO4s6NoMg8gbWFCLuAhJabhn7/Qey413PCz+1fEVhreh3o
 lkf5iOSMWm2V7NmR89nsFqM5A5YrVmrNVQZ10eOVL8Jkakqor1HOBc/fNmmBQr8wCfgB
 7ITr5Zqnob77bqehNyJXkYP1QgwUk6VRB2FdtDD1GDbrv7CUPHLoavE7ZpWs03m+Pg07
 CK6Jlucg8uPoxkk7jRkKt54KlDdzf9Skoeb0iiVDbJsFPOU0UvWWH8qDSnhRCJkl3nwC
 OguRGROpgE2Uv3I7Tx4CqTfuSorYIanRY8eRmLIcYSo781M/eHXifzGFbv20aPjUYvzL
 MsQw==
X-Gm-Message-State: AOAM5307/hnl+PK+oqa4wmcWQQLqNhFb1X43XbGH14nlbsDhzMA3l9mq
 TinLAxwwaeDq4kaID6UE2WT+r6supq2cFC15usik4St1MJF8LpAscrJJbJnVPGjJaVXDxXFsixt
 7zxiNLuFLH+/BE2C7pmMMR4c2Lws=
X-Received: by 2002:a05:6808:1116:: with SMTP id
 e22mr26432601oih.45.1639387960525; 
 Mon, 13 Dec 2021 01:32:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyptbelrIZenEVE6qQ8YlL8Yk/svABWSQU2P9BUI8nPtOnuaUAEaEIC538N6LDNWlWz1NdR9EC1E4MpKN4A/0Y=
X-Received: by 2002:a05:6808:1116:: with SMTP id
 e22mr26432580oih.45.1639387960170; 
 Mon, 13 Dec 2021 01:32:40 -0800 (PST)
MIME-Version: 1.0
References: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
In-Reply-To: <CAEemH2d+-rqscLPdn8q0AEkKaCSkCZ-pET_E=eWWN7Z=aB1k0w@mail.gmail.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 13 Dec 2021 10:32:23 +0100
Message-ID: <CAASaF6zRCAYo3f4bRc+mxKHnprwtworq-fCif81ECZUWawumbQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] enable OOM protection for the library and test
 process?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Dec 13, 2021 at 9:04 AM Li Wang <liwang@redhat.com> wrote:
>
> Hi All,
>
> As we observed that oom tests occasionally ended with TBROK (Test killed) on small
> RAM system, the reason seems test process(test_pid) get killed early than the expected
> victim process so that can't report the status correctly.
>
> I'm thinking maybe we can purposely make the OOM ignore test process(test_pid)
> and the main process? (achieve this only in mem library for OOM test)

There are likely more processes that could become unintended targets
(e.g. harness process)
(if we haven't tried already) Could we make expected victim process
more appealing target by tweaking its oom_score/oom_score_adj ?

>
> e.g.
>
> set oom_score_adj to -1000 for pid-305071 and main-process
>
> oom03:
> main ---> tst_run_tcases --> ... --> fork_testrun
>    (pid 305071)    testrun  --> run_tests --> ... --> testoom --> oom()
>             (pid 305072)    child_alloc --> child_alloc_thread --> alloc_mem
>
>
> =============
>
> 3 cmdline="oom03"
> ...
> 10 mem.c:218: TINFO: start normal OOM testing.
> 11 mem.c:140: TINFO: expected victim is 305072.
>
> 12 mem.c:39: TINFO: thread (7fe173d1a700), allocating 3221225472 bytes.
> 13 mem.c:39: TINFO: thread (7fe173d1a700), allocating 3221225472 bytes.
>
> 14 tst_test.c:1410: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> 15 tst_test.c:1411: TBROK: Test killed! (timeout?)
>
> ==========
>
> [ 1117.558867] Tasks state (memory values in pages):
> [ 1117.559373] [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
> [ 1117.560167] [ 305071]     0 305071     2215       31    61440        4             0 oom03
> [ 1117.560889] [ 305072]     0 305072 1577128 259389 10326016 1019452 0 oom03
> ...
>
> [ 1117.596510] oom-kill:constraint=CONSTRAINT_MEMCG,nodemask=(null),cpuset=/,mems_allowed=0,oom_memcg=/ltp/test-305071,task_memcg=/ltp/test-305071,task=oom03,pid=305071,uid=0
> [ 1117.597963] Memory cgroup out of memory: Killed process 305071 (oom03) total-vm:8860kB, anon-rss:124kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:60kB oom_score_adj:0
>
> =============
>
> # free -h
>               total        used        free      shared  buff/cache   available
> Mem:          3.6Gi       270Mi       2.3Gi        18Mi       1.1Gi       3.3Gi
> Swap:         4.0Gi          0B       4.0Gi
>
> # lscpu
> Architecture:        x86_64
> CPU op-mode(s):      32-bit, 64-bit
> Byte Order:          Little Endian
> CPU(s):              2
> On-line CPU(s) list: 0,1
> Thread(s) per core:  1
> Core(s) per socket:  1
> Socket(s):           2
> NUMA node(s):        1
>
>
> --
> Regards,
> Li Wang
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
