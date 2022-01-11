Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4842FC433EF
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 09:38:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7208E3C9402
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 10:38:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F12393C2997
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 10:38:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 921D6140132F
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 10:38:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641893914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9YYRxA8YUuZpgTpTTTqfUFY5bJ3n/JuF33+YP3Nlssw=;
 b=Uvw+A8HY05Db0PJMO/FuIeyVgfmhG5WAbbv7PY2UYsn4PmqdkNjfJaTq/UrLTWPNxhcWmw
 wqSlkHYhH7da/41NKXUKFwDW9DvAJbKhi7jJmTW4/CBu/CSKFz0NoGo+9PPUNNdDNxAvFs
 ivJ0W2ZlWWGX9/1IxBD8kvBqushSsCE=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-595-vzCgcE4lNfuD1hc-lALpiQ-1; Tue, 11 Jan 2022 04:38:30 -0500
X-MC-Unique: vzCgcE4lNfuD1hc-lALpiQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 u185-20020a2560c2000000b0060fd98540f7so33036857ybb.0
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 01:38:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9YYRxA8YUuZpgTpTTTqfUFY5bJ3n/JuF33+YP3Nlssw=;
 b=X3t3miO9VYGiVMf8aoJ7jRByDFZZTMbFblKxkt+viW6mL1NGqIu2NuyGmzu1eqgmY1
 BRRSsTQ1fsuG4R8veEkFepSLhnoXu8mgIlT9kSfyMsWTOQQvAwO+jlnoQcOCILebcenf
 3y3SnpHct00r5Yq4+ZiZDv9Ze2+BZj/7qV0Z7QmC2fIT6TrmrqFYoEGP06Q0zlnGieAI
 MnfVbnpD98aRdBzRQVZtr3qXcJwzbelefUq3F+UaLxkmIHpXF+5VLprIlxsvBwvpO7Ce
 OZrqvjErxmsulwHgqc9pj6scgUuYlHUX685+uOxTZ9qnLSGM1sF1xe9Hy8fucUfczjye
 Q/xw==
X-Gm-Message-State: AOAM533aBuInHser8PpogdhrD2HJc83O3J8s1zQNtgPBvW2FVb7vWHk5
 fThw2+AQ/JVhKlR4L5FhEP2LUrHlJ90DU8+I9YSpFWC6q5XYqG/xFJKpnpEsJcjVVJMTsAS67kB
 k4uBkmniGoIHnG4w284aL7ws/KjM=
X-Received: by 2002:a25:e60a:: with SMTP id d10mr5086494ybh.71.1641893909895; 
 Tue, 11 Jan 2022 01:38:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDmIj0EHmMPcEcWcUU2ysdDsjgxyTT8Nv4qMhinsvXCPEYZCrMOT46WNPsUoG77E8Vx9KP3upQz4SN4mKfyVs=
X-Received: by 2002:a25:e60a:: with SMTP id d10mr5086470ybh.71.1641893909581; 
 Tue, 11 Jan 2022 01:38:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641376050.git.luke.nowakowskikrijger@canonical.com>
 <626fb72bcb83352d98e0df828f4b27a4ef5a1d6f.1641376050.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <626fb72bcb83352d98e0df828f4b27a4ef5a1d6f.1641376050.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Jan 2022 17:38:15 +0800
Message-ID: <CAEemH2ccc2WBpVvxz49X4DuO7iCLrpGoy1EJ4rqLN6EQ1TK0sw@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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

On Wed, Jan 5, 2022 at 6:01 PM Luke Nowakowski-Krijger
<luke.nowakowskikrijger@canonical.com> wrote:
>
> Expand the cgroup_lib library by using the tools/cgroup/tst_cgctl binary
> utility to make calls to the Cgroup C API to simplify and centralize the
> mounting and cleanup process of Cgroups.
>
> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
>  testcases/kernel/controllers/cgroup_lib.sh | 129 ++++++++++++++++++---
>  1 file changed, 113 insertions(+), 16 deletions(-)
>
> diff --git a/testcases/kernel/controllers/cgroup_lib.sh b/testcases/kernel/controllers/cgroup_lib.sh
> index 7918b5636..6ab201b95 100644
> --- a/testcases/kernel/controllers/cgroup_lib.sh
> +++ b/testcases/kernel/controllers/cgroup_lib.sh
> @@ -5,22 +5,7 @@
>
>  . tst_test.sh
>
> -# Find mountpoint to given subsystem
> -# get_cgroup_mountpoint SUBSYSTEM
> -# RETURN: 0 if mountpoint found, otherwise 1
> -get_cgroup_mountpoint()

As we have renamed this function to cgroup_get_mountpoint(), so the
invoke part in test cases should be updated too. Maybe you're going
to complete that in following up patches, but as a completed patch set,
we'd better keep the code not broken in running.

cgroup/cgroup_regression_test.sh:
cpu_subsys_path=$(get_cgroup_mountpoint "cpu")
cgroup/cgroup_regression_test.sh:       local
subsys_path=$(get_cgroup_mountpoint $subsys)
cpuset/cpuset_regression_test.sh:
root_cpuset_dir=$(get_cgroup_mountpoint cpuset)

Btw, it would be great you can write simple test demos to verify the
new shell API works well.
Just like what people done at: ltp/lib/newlib_tests/shell/*

> -{
> -       local subsystem=$1
> -       local mntpoint
> -
> -       [ $# -eq 0 ] && tst_brk TBROK "get_cgroup_mountpoint: subsystem not defined"
> -
> -       mntpoint=$(grep cgroup /proc/mounts | grep -w $subsystem | awk '{ print $2 }')
> -       [ -z "$mntpoint" ] && return 1
> -
> -       echo $mntpoint
> -       return 0
> -}
> +_cgroup_state=
>
>  # Check if given subsystem is supported and enabled
>  # is_cgroup_subsystem_available_and_enabled SUBSYSTEM
> @@ -37,3 +22,115 @@ is_cgroup_subsystem_available_and_enabled()
>
>         return 1
>  }
> +
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
> +       [ "$version" = "" ] && tst_brk TBROK "cgroup_get_version: Could not find controller $ctrl"
> +
> +       echo "$version"
> +
> +       return 0
> +}
> +
> +# Cleans up any setup done by calling cgroup_require.
> +# USAGE: cgroup_cleanup
> +# Can be safely called even when no setup has been done
> +cgroup_cleanup()
> +{
> +       [ "$_cgroup_state" = "" ] && return 0
?> +
> +       tst_cgctl cleanup "$_cgroup_state"

I don't understand what exactly the $_cgroup_state do here,
isn't that just 0 or 1 which returned by 'tst_cgctl require "$ctrl" $$' ?
Maybe you can add brief comments on this variable.

> +
> +       return 0
> +}
> +
> +# Get the task list of the given controller
> +# USAGE: cgroup_get_task_list CONTROLLER
> +# RETURNS: prints out "cgroup.procs" if version 2 otherwise "tasks"
> +# Must call cgroup_require before calling
> +cgroup_get_task_list()
> +{
> +       local ctrl="$1"
> +       local version
> +
> +       version=$(cgroup_get_version "$ctrl")
> +
> +       if [ "$version" = "V2" ]; then
> +               echo "cgroup.procs"
> +       else
> +               echo "tasks"
> +       fi
> +
> +       return 0
> +}
> +
> +# Mounts and configures the given controller
> +# USAGE: cgroup_require CONTROLLER
> +cgroup_require()
> +{
> +       local ctrl="$1"
> +
> +       [ $# -eq 0 ] && tst_brk TBROK "cgroup_require: controller not defined"

We have already do parameter "$1" checking in
is_cgroup_subsystem_avalibale_and_enbale,
so here looks reductant.

And, I think we don't need to invoke that independent function at any
other place
if we put that in this cgroup_require() function. It might be good to delete
is_cgroup_subsystem_avalibale_and_enbale and move the process to here.

> +
> +       if ! is_cgroup_subsystem_available_and_enabled "$ctrl"; then
> +               tst_brk TBROK "cgroup_require: Controller not available or not enabled"

Maybe using TCONF here is more elegent.

> +       fi
> +
> +       _cgroup_state=$(tst_cgctl require "$ctrl" $$)
> +
> +       [ "$_cgroup_state" = "" ] && tst_brk TBROK "cgroup_require: No state was set after call. Controller '$ctrl' maybe does not exist?"
> +
> +       return 0
> +}
> --
> 2.32.0
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
