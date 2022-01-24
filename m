Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80640C433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 09:44:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9AFA3C90AA
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 10:44:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D3C3D3C0F5D
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 10:44:02 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C0638600629
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 10:44:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643017440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YuGS+FnY/0pbaiC1fZibeFy5vDKwz8olhItmTU3QNkk=;
 b=P9DArUrjCYaH9qhbJUu61Zn8OLwAu0TKD1ZcFVISMi9fKke5YLGluTEb1NaYTiZ1jU0MIf
 q1/a7slGnLmtZbVmWmCWN5hOHK8cSA4K7RcKF5G4w37SiH9XkYdqbvP5peIeYD8FAG2pJh
 qqSwpA0Era2yFMk8W+fdzdEEESXiuAQ=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-cU9W-TkdNV2LahFPrMSphA-1; Mon, 24 Jan 2022 04:43:59 -0500
X-MC-Unique: cU9W-TkdNV2LahFPrMSphA-1
Received: by mail-yb1-f199.google.com with SMTP id
 i10-20020a25540a000000b0061391789216so32754579ybb.2
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 01:43:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YuGS+FnY/0pbaiC1fZibeFy5vDKwz8olhItmTU3QNkk=;
 b=wN3tBUIZfhm3g0DFy9GHq5sQWNKSKsrGJZtcpH3AjBGANtzaGufQQ32f7UNUB0eYTN
 JF9jhKY0ODY2Jg2Mct+Ar0DgJn3XAedX7WhGwsQoUxghZtvnF5MntuYD0k/flUxerNvw
 qr26aD7IEmKY8MCfvXiadUma4zYNWpFoCwuL8Xdj7RGDappeqA4YP597F9iKwNMN81gz
 /dp/ziJMxkOlzqa3EmPJksmtCG0A93LRgSSEsJgyKB8wIyvdJZ98FSYrspJQwDU94m7S
 xUFUmE7PuZwsiTxihbXXYu64kfiAc8TlUnOHcQrmP4RLfVbQSn5s3XgauPyAnLJqo3yt
 askw==
X-Gm-Message-State: AOAM531di0wLCoogTK9GgSc42U2Dmrva7WOqzUIZWvqWy3FVf3XoRY3E
 qPJZp7gnEAZ8DQdVvB3Za/4eruh3hkHgvHAcTdlXnszFTYkFZOq1GEMqcKQLrqggEp3G6Xedziv
 8YTLkv8iVEwWUU5/OwBa3GeVzgKE=
X-Received: by 2002:a25:15c3:: with SMTP id 186mr23171161ybv.71.1643017438551; 
 Mon, 24 Jan 2022 01:43:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxrInwfbVNEHYJkXGtyB073U/cs9A7czqe+xPs5l1TBW8E7l76TplR84jd8sZVIi/1pB6SIIaWJWnDry93vziI=
X-Received: by 2002:a25:15c3:: with SMTP id 186mr23171142ybv.71.1643017438306; 
 Mon, 24 Jan 2022 01:43:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <3b78e25c8eba247d0ce2d99cbbdcaeba7994e26c.1642601554.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <3b78e25c8eba247d0ce2d99cbbdcaeba7994e26c.1642601554.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Jan 2022 17:43:44 +0800
Message-ID: <CAEemH2fDx-KejrtrmY_N9c+7Fbe1Btvpxe65rUPyC8Atw_=+nA@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 10/16] controllers: Update memcg_control_test to
 newer test lib and cgroup lib
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

Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> wrote:

> +test1()
>  {
> -       TST_COUNT=1
> -       tst_resm TINFO "Test #1: Checking if the memory usage limit imposed by the topmost group is enforced"
> +       cd $TST_TMPDIR
> +
> +       tst_res TINFO "Test #1: Checking if the memory usage limit imposed by the topmost group is enforced"
>
> -       echo "$ACTIVE_MEM_LIMIT" > $TST_PATH/mnt/$TST_NUM/memory.limit_in_bytes
> -       echo "$TOT_MEM_LIMIT" > $TST_PATH/mnt/$TST_NUM/memory.memsw.limit_in_bytes
> +       ROD echo "$ACTIVE_MEM_LIMIT" > "$test_dir/$memory_limit"
> +       ROD echo "$TOT_MEM_LIMIT" > "$test_dir/$memsw_memory_limit"
...
>  }

> +setup()
>  {
> -       RES=$1
> -       INFO=$2
> -
> -       if [ $RES -eq $PASS ]; then
> -               tst_resm TPASS "$INFO"
> +       cgroup_require "memory"
> +       cgroup_v=$(cgroup_get_version "memory")
> +       test_dir=$(cgroup_get_test_path "memory")
> +       task_list=$(cgroup_get_task_list "memory")
> +
> +       if [ "$cgroup_v" = "V2" ]; then
> +               memory_limit="memory.max"
> +               memsw_memory_limit="memory.swap.max"

As we already built the controller files mapping from V2 to V1
in C library and you actually add many new (in patch 5/16).

I'm thinking maybe we could make use of it in tst_cgctl.c to
avoid handling these (in shell) separately.

Something like:

    # ./tst_cgctl  set  "$pid"  "cgroup.procs"  "$target_pid"
    # ./tst_cgctl  set  "$pid"  "memory.max"  "$ACTIVE_MEM_LIMIT"

Otherwise, it seems to make no sense to add so many new
files mapping (like that patch 5/16) at this moment.

What do you think?


>         else
> -               : $((FAILED_CNT += 1))
> -               tst_resm TFAIL "$INFO"
> +               memory_limit="memory.limit_in_bytes"
> +               memsw_memory_limit="memory.memsw.limit_in_bytes"
>         fi
> -}


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
