Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FB7C433EF
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 12:26:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F46A3C8CE0
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 13:26:16 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 824A03C2AE3
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 13:26:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 139051A00919
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 13:26:05 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3ADE82198B;
 Mon, 24 Jan 2022 12:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643027165;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m4qxU5zFhFjTlHv+NYfBsXie1SbrtRjgBTZrmXDTd+U=;
 b=m3NHvpXxz1bzY1LSK3PxjvnUB+mRAPl0Co8WmKBiO2qgm/z/NHZDSZG6QyoViSt46vmJg6
 6BwZ8gix5zsBy2W1zI+J4+Zq4Wo1QpMWZWzOIdPzl9En+u3MW3SbQzphN0a1A6ImkPdkTL
 MNSTFWLiSdE9oOrGXaq5/muhRTV8gU0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643027165;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m4qxU5zFhFjTlHv+NYfBsXie1SbrtRjgBTZrmXDTd+U=;
 b=wuY+lv551DCxwhZ3pz3llBtYg0bMksWaft8JbwddLivtyka7KxqPHeH6pRn3y+nnxIGff0
 mvKLb+lTErvGNzDg==
Received: from g78 (unknown [10.163.24.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F0F16A3B88;
 Mon, 24 Jan 2022 12:26:04 +0000 (UTC)
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <3b78e25c8eba247d0ce2d99cbbdcaeba7994e26c.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2fDx-KejrtrmY_N9c+7Fbe1Btvpxe65rUPyC8Atw_=+nA@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 24 Jan 2022 12:24:44 +0000
In-reply-to: <CAEemH2fDx-KejrtrmY_N9c+7Fbe1Btvpxe65rUPyC8Atw_=+nA@mail.gmail.com>
Message-ID: <877dapz5er.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> wrote:
>
>> +test1()
>>  {
>> -       TST_COUNT=1
>> -       tst_resm TINFO "Test #1: Checking if the memory usage limit imposed by the topmost group is enforced"
>> +       cd $TST_TMPDIR
>> +
>> +       tst_res TINFO "Test #1: Checking if the memory usage limit imposed by the topmost group is enforced"
>>
>> -       echo "$ACTIVE_MEM_LIMIT" > $TST_PATH/mnt/$TST_NUM/memory.limit_in_bytes
>> -       echo "$TOT_MEM_LIMIT" > $TST_PATH/mnt/$TST_NUM/memory.memsw.limit_in_bytes
>> +       ROD echo "$ACTIVE_MEM_LIMIT" > "$test_dir/$memory_limit"
>> +       ROD echo "$TOT_MEM_LIMIT" > "$test_dir/$memsw_memory_limit"
> ...
>>  }
>
>> +setup()
>>  {
>> -       RES=$1
>> -       INFO=$2
>> -
>> -       if [ $RES -eq $PASS ]; then
>> -               tst_resm TPASS "$INFO"
>> +       cgroup_require "memory"
>> +       cgroup_v=$(cgroup_get_version "memory")
>> +       test_dir=$(cgroup_get_test_path "memory")
>> +       task_list=$(cgroup_get_task_list "memory")
>> +
>> +       if [ "$cgroup_v" = "V2" ]; then
>> +               memory_limit="memory.max"
>> +               memsw_memory_limit="memory.swap.max"
>
> As we already built the controller files mapping from V2 to V1
> in C library and you actually add many new (in patch 5/16).
>
> I'm thinking maybe we could make use of it in tst_cgctl.c to
> avoid handling these (in shell) separately.
>
> Something like:
>
>     # ./tst_cgctl  set  "$pid"  "cgroup.procs"  "$target_pid"
>     # ./tst_cgctl  set  "$pid"  "memory.max"  "$ACTIVE_MEM_LIMIT"
>
> Otherwise, it seems to make no sense to add so many new
> files mapping (like that patch 5/16) at this moment.
>
> What do you think?

I think it looks nice!

>
>
>>         else
>> -               : $((FAILED_CNT += 1))
>> -               tst_resm TFAIL "$INFO"
>> +               memory_limit="memory.limit_in_bytes"
>> +               memsw_memory_limit="memory.memsw.limit_in_bytes"
>>         fi
>> -}


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
