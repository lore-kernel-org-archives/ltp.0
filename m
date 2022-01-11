Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1156C433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 10:51:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2670F3C93FA
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 11:51:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 199D83C90AA
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:51:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BD30A60025E
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 11:51:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641898264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=78O0sF73uj5tM451AcyKNLjBpBU118RfSFybLxmbwn8=;
 b=AGQU3bP8uFbklp0UMhl1h1JSOayhnxWS/p8S4VOCbDs6GJNngRVcfPB4nHcEouyrxX4f4W
 DzreRRa9d9w7sz7nkceG3+dlv44FuqSdEKflT0kMS2BUfgrPeOkn+KVWq6b2VQsR8thQkG
 uK/EMPFnIZ6ToPBOBJsxZ0wOTO95fzE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-Cu1WY-X7P0-rGoVzZRuauQ-1; Tue, 11 Jan 2022 05:51:02 -0500
X-MC-Unique: Cu1WY-X7P0-rGoVzZRuauQ-1
Received: by mail-yb1-f199.google.com with SMTP id
 q80-20020a252a53000000b006108776aa8fso23650384ybq.17
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 02:51:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=78O0sF73uj5tM451AcyKNLjBpBU118RfSFybLxmbwn8=;
 b=HOJ/aj6OhR4mIgl7PosONsvQ2zaI1X5guOPkStQ5/TIRRQEmFUr6aoS/e9jp6wyAFQ
 3kvVuqG7Vi80k6jyczFykDdN5MefTRtw8HH+0kOLHr5lKhvAJdn8cwAPC8dJ3AScQCVH
 v2U4BMILTt3lH+Oe+5e4efrsH3nEbutNIJrIw5UMB3ciWEt+8cNDCFshsr82YI83SGB3
 u17YC3ndVNGVMF7tsmHoBHy7XZ375lTVSK6ip5DSHAdhfuik3Ol8rO0EW1r/inmH54u4
 T//i4h1/0Xom79h1VbIKL7yKSn2fEQV73uuqelTfRVvdGEoqoP2GrwLh4zvFAafshEat
 8SPA==
X-Gm-Message-State: AOAM5313fWzfd6XHEyrt5Ls2Zs+UZR/+wZgJ1IwSSH3wnNQ37ZZG3I/o
 mVk36kUp2VNSMkMtk4ACa8Y5a2lVHMm6HSO9V17tvNpCYdEM2LZpbGVX70bTDbPYDF3+yrOqLjU
 lz3GgD9yNh8SpSaMuIkbgOWmTcww=
X-Received: by 2002:a25:452:: with SMTP id 79mr5210057ybe.421.1641898261912;
 Tue, 11 Jan 2022 02:51:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6gVevelmJztSnNht051RsD9eRbFzWfdaumiESSHBuwxksTyl7GGyF/rH14ilQ6aoHUTO3FOgu3I+nxTydqZw=
X-Received: by 2002:a25:452:: with SMTP id 79mr5210036ybe.421.1641898261667;
 Tue, 11 Jan 2022 02:51:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <626fb72bcb83352d98e0df828f4b27a4ef5a1d6f.1641376050.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <626fb72bcb83352d98e0df828f4b27a4ef5a1d6f.1641376050.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Jan 2022 18:50:49 +0800
Message-ID: <CAEemH2eW=4fpi=LqhzOxqNOJMgKn7K1qGOqBPWMSFuAvXX70WA@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/6] controllers: Expand cgroup_lib shell library
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

> +# Find mountpoint of the given controller
> +# USAGE: cgroup_get_mountpoint CONTROLLER
> +# RETURNS: Prints the mountpoint of the given controller
> +# Must call cgroup_require before calling
> +cgroup_get_mountpoint()
> +{
> +       local ctrl=$1
> +       local mountpoint
> +
> +       [ $# -eq 0 ] && tst_brk TBROK "cgroup_get_mountpoint: controller not defined"
> +       [ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_mountpoint: No previous state found. Forgot to call cgroup_require?"
> +
> +       mountpoint=$(echo "$_cgroup_state" | grep -w "$ctrl" | awk '{ print $4 }')
> +       echo "$mountpoint"
> +
> +       return 0
> +}
> +
> +# Get the test path of a given controller that has been created by the cgroup C API
> +# USAGE: cgroup_get_test_path CONTROLLER
> +# RETURNS: Prints the path to the test direcory
> +# Must call cgroup_require before calling
> +cgroup_get_test_path()
> +{
> +       local ctrl="$1"
> +       local mountpoint
> +       local test_path
> +
> +       [ $# -eq 0 ] && tst_brk TBROK "cgroup_get_test_path: controller not defined"
> +       [ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_test_path: No previous state found. Forgot to call cgroup_require?"
> +
> +       mountpoint=$(cgroup_get_mountpoint "$ctrl")
> +
> +       test_path="$mountpoint/ltp/test-$$"
> +
> +       [ ! -d "$test_path" ] && tst_brk TBROK "cgroup_get_test_path: No test path found. Forgot to call cgroup_require?"
> +
> +       echo "$test_path"
> +
> +       return 0
> +}
> +
> +# Gets the cgroup version of the given controller
> +# USAGE: cgroup_get_version CONTROLLER
> +# RETURNS: "V1" if version 1 and "V2" if version 2
> +# Must call cgroup_require before calling
> +cgroup_get_version()
> +{
> +       local ctrl="$1"
> +
> +       [ $# -eq 0 ] && tst_brk TBROK "cgroup_get_version: controller not defined"
> +       [ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_get_version: No previous state found. Forgot to call cgroup_require?"
> +
> +       version=$(echo "$_cgroup_state" | grep -w "$ctrl" | awk '{ print $2 }')

This won't work on my x86_64 KVM platform, maybe we need: grep -w "^$ctrl".

# echo $$
1801

# ./tst_cgctl require memory 1801
Detected Controllers:
memory V1 @ /sys/fs/cgroup/memory Required
cpu V1 @ /sys/fs/cgroup/cpu,cpuacct
cpuset V1 @ /sys/fs/cgroup/cpuset
Detected Roots:
/sys/fs/cgroup/memory Mounted_Root=no Created_Ltp_Dir=no
Created_Drain_Dir=no Test_Id=test-1801
/sys/fs/cgroup/cpu,cpuacct Mounted_Root=no Created_Ltp_Dir=no
Created_Drain_Dir=no Test_Id=NULL
/sys/fs/cgroup/cpuset Mounted_Root=no Created_Ltp_Dir=no
Created_Drain_Dir=no Test_Id=NULL

# _cgroup_state=$(./tst_cgctl require memory 1801)

# echo "$_cgroup_state" | grep -w "memory" | awk '{ print $2 }'
V1
Mounted_Root=no

# echo "$_cgroup_state" | grep -w "memory" | awk '{ print $4 }'
/sys/fs/cgroup/memory
Created_Drain_Dir=no

# ./tst_cgctl cleanup "$_cgroup_state"
tst_cgroup.c:414: TBROK: Could not find root from config. Roots
changing between calls?


> +       [ "$version" = "" ] && tst_brk TBROK "cgroup_get_version: Could not find controller $ctrl"
> +
> +       echo "$version"
> +
> +       return 0
> +}
> +


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
