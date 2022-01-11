Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A042FC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 12:43:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA9C83C93F2
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 13:43:21 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC7943C1DE6
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 13:43:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58C93601E0B
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 13:43:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641904988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OEuziffwEglnk52T+oPDxOrBvdzx1fshRbqP+2EtaLI=;
 b=jMDu3eNoiX63T8xArJEEyIrhgBxB3/95ubV1FHEO3o25Nbf3xXXzfum4gZ/xVU2G8st50d
 r57qv1A1lkgjJdC5WURmBW0fN5nOtzS0oupkjpO805/GgBEXTMjr3KuN7SSDg7LyB9a3wZ
 5FOtPEQWb+Q+C0vNdIIByI/iw9iIvM8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-192-kdBwVZKMMoiabPPIYFl-eA-1; Tue, 11 Jan 2022 07:43:07 -0500
X-MC-Unique: kdBwVZKMMoiabPPIYFl-eA-1
Received: by mail-yb1-f197.google.com with SMTP id
 n129-20020a254087000000b00610d09107e0so17384703yba.19
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 04:43:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OEuziffwEglnk52T+oPDxOrBvdzx1fshRbqP+2EtaLI=;
 b=WNWx8Oqe/+H0SYmaC1jb2uLzGTzP4wDC+nB11/V0DmkNps7jTkTVYQUev7BcSxm51f
 EYiggFF0s4oVhakdRXw/VQV+zN46dozUp2TrwNEhmMMCgwdt5hwvVQR1gSyVSWc65oLm
 VLsVYuHkklkimrd8HtTYWUc9isXL4jhwkPtRlZx/Yt+1iTTe/iYB8IlXruqsmeHvKnA1
 pLIevEU4uLGx96pp7QcATzAi4mPP104Z0c3tVMCblFnvX0qatcmVP4p3VsXuSDqyPFNM
 vah2sYWuVsJMvr7pmZqJatT572zCY69KSZd6WUzBFFLkeA2q+XwFxLGfj3JKUIV2AFfV
 OfxA==
X-Gm-Message-State: AOAM530vs1yEcYNENOegm2COewLQXt9jU5kUqnkM/WP7eLQRoG99LHrG
 TylH+0+Nmly1oIvZYqgO9AgiRyGVQqdV58TS1Wr7HstANK3fAmVjVvJRvGYzzu3/TMrT2WWjbdz
 730RTvzKBu5lOO79ZSkgtzuqOrTI=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr5923543ybe.32.1641904987225; 
 Tue, 11 Jan 2022 04:43:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzVKs4F0dHEnXoO6HzoXsaMF9xHVob9yYZ+G+2LSuMVamuzW9QHwq1ICtAR6wUkETiaRWE2TWD3fsdWT+GUzuE=
X-Received: by 2002:a25:f90d:: with SMTP id q13mr5923523ybe.32.1641904986990; 
 Tue, 11 Jan 2022 04:43:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <91b9d5928cd129ebb21430a60e715113a6a6f6b7.1641376050.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <91b9d5928cd129ebb21430a60e715113a6a6f6b7.1641376050.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Jan 2022 20:42:54 +0800
Message-ID: <CAEemH2dHHNz25Vacu3r49MHgyd+Urk3c=NHMwA6zV=FFAQSpQw@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] tools: Implement tst_cgctl binary utility
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

>  tools/cgroup/Makefile    |  7 ++++
>  tools/cgroup/tst_cgctl.c | 69 ++++++++++++++++++++++++++++++++++++++++

Looks like putting this tst_cgctl.c in testcase/lib/ will be better,
we have no necessary to create it under a bit far directory, and
that tool/ is more generic for LTP, but this process is only for
shell tests.

> +static int cgctl_cleanup(const char *config)
> +{
> +    tst_cgroup_scan();
> +    tst_cgroup_load_config(config);

This tst_cgroup_load_config() does not work as expected.
From my manual check, the ltp and drain dir have been created
but it prints " Created_Ltp_Dir=no Created_Drain_Dir=no" strings.

...
Detected Roots:
/sys/fs/cgroup/memory Mounted_Root=no Created_Ltp_Dir=no
Created_Drain_Dir=no Test_Id=test-1801
...


> +    tst_cgroup_cleanup();

This does not work as expected too, but the problem should exist
in previous patches. Anyway, I will look into the details tomorrow.

# ./tst_cgctl cleanup "$_cgroup_state"
tst_cgroup.c:414: TBROK: Could not find root from config. Roots
changing between calls?


> +
> +    return 0;
> +}


--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
