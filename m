Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0F1C433EF
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 08:52:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50C8A3C7E58
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 09:52:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DBAF3C65E6
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 09:52:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 707A9200916
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 09:52:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643014331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e4/DYyWeP9YtHvtfmjsvi6MS5NvfI+yJ4A9JctyAU0g=;
 b=SVUS4Vj1BsSLY1jAoleDkOWtCQlUAmTaQQieNHONkt7I6yVERMoSgNDcrMIKY787d/YQ90
 que0DnozFGPeHRuWX8yUsnnWa+4Ne+AcFVlhuMMrE7MLrF7p/iIdadXZQTI8gjcfPJ7+Xi
 0bnfsVyGN3k9UFQXrbuVGK4qA7LzL84=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-mdJ9gFQFORyL4dVowjYFJg-1; Mon, 24 Jan 2022 03:52:07 -0500
X-MC-Unique: mdJ9gFQFORyL4dVowjYFJg-1
Received: by mail-yb1-f200.google.com with SMTP id
 d65-20020a256844000000b00614359972a6so24561848ybc.16
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 00:52:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e4/DYyWeP9YtHvtfmjsvi6MS5NvfI+yJ4A9JctyAU0g=;
 b=4Z4iJk/KXxxSy6KjspiIgLBg8g8gQFmgFRTmcG6a/ukcrvSb2qb+Nb4eLL9odVzMiX
 DPsfgClmti0LQRD2d0ZmjNIThkZIT8/sH3zS3uHkWqgbBkqTjCMh/MJKTMLMk0yg3aQ4
 5uFbsfiC52qaGL0DAvVZvRo0Ic8oSfC8bxWrcC82ECSTjSXz3yprSQO9jTySBcWXb9gP
 mReZbjReDOzHo4tmfkvl6ySnD064GLjZj4lzcLwTsGWCwA1zpMeiRTFIBuxCkuGGkD3s
 nLw4kyt2uV/UCa0xG1MLk8iH95H0VvX0dRUCsAprnRgFWOL5N76yO+vZf9IjEg+2+jsv
 cUfQ==
X-Gm-Message-State: AOAM532Z3cZTIZvDQjReqVsyeBnb3DXmMYkNZIiyGRbijsXxsi7WJiXf
 VdBbDoWWbDzxmZ3eaNIh8roI99NhQiz6P0HaEL1JO2Y+Wkrwn2kkaYFVJBOkc6G8K1tWCRGRWog
 5WEA7JifP/Km6qn0NMNBXFsF7cCI=
X-Received: by 2002:a25:4cc5:: with SMTP id
 z188mr21719949yba.248.1643014326855; 
 Mon, 24 Jan 2022 00:52:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuHwAl7Q4uRVxpgNdM40RmWa4uSAMRH4x9b9SZJA/9Qw95tMZdjV30LoIG7GKXylxperbTmnYFvPllbd7d9UQ=
X-Received: by 2002:a25:4cc5:: with SMTP id
 z188mr21719918yba.248.1643014326302; 
 Mon, 24 Jan 2022 00:52:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <9ba0c0fafeb4fd18de0df87b700ec2d9a111fc1a.1642601554.git.luke.nowakowskikrijger@canonical.com>
In-Reply-To: <9ba0c0fafeb4fd18de0df87b700ec2d9a111fc1a.1642601554.git.luke.nowakowskikrijger@canonical.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Jan 2022 16:51:52 +0800
Message-ID: <CAEemH2dsE4TLjOBrgWjhFfh5ng+xJ-PPGgokpBkrjmLoH9FZNg@mail.gmail.com>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwan@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 09/16] controllers: Update cgroup_fj_* to use
 newer cgroup lib and test lib
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

On Wed, Jan 19, 2022 at 10:44 PM Luke Nowakowski-Krijger
<luke.nowakowskikrijger@canonical.com> wrote:
>
> Update the cgroup_fj_* tests to use the newer test lib and to use the
> updated version of the cgroup lib which handles mounting and unmounting
> for both v1 and v2 controllers.
>
> The tests were modified to accomodate testing the v2 controller

accommodate ^

> interfaces where it still made sense, and in other places tests were
> skipped as they were testing using specific parts of the v1 interface
> that doesen't exist on v2 controllers.

doesn't ^

>
> Also updated the licensing info at the beginning of the file with SPDX
> license identifier.
>
> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
>  .../controllers/cgroup_fj/cgroup_fj_common.sh | 105 ++++-------
>  .../cgroup_fj/cgroup_fj_function.sh           | 169 ++++++++++--------
>  .../controllers/cgroup_fj/cgroup_fj_proc.c    |  24 +--
>  .../controllers/cgroup_fj/cgroup_fj_stress.sh | 168 ++++++++---------
>  4 files changed, 215 insertions(+), 251 deletions(-)
>
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> index 53ab637e8..9017a3cab 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> @@ -1,33 +1,19 @@
>  #!/bin/sh
> -
> -################################################################################
> -##                                                                            ##
> -## Copyright (c) 2009 FUJITSU LIMITED                                         ##
> -##  Author: Shi Weihua <shiwh@cn.fujitsu.com>                                 ##
> -## Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>                          ##
> -## Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>                     ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software Foundation,   ##
> -## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
> -##                                                                            ##
> -################################################################################
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2009 FUJITSU LIMITED
> +# Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> +# Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
> +# Author: Shi Weihua <shiwh@cn.fujitsu.com>
>
>  for arg; do
>      TCID="${TCID}_$arg"
>  done
>
> -. test.sh
> +TST_NEEDS_CMDS="rmdir killall"
> +TST_NEEDS_ROOT=1
> +TST_NEEDS_TMPDIR=1
> +
> +. cgroup_lib.sh
>
>  exist_subsystem()

This function is redundant since we have moved the
existence check into cgroup_require(), isn't it?

>  {
> @@ -46,13 +32,13 @@ attach_and_check()
>      local task
>      shift
>
> -    tst_resm TINFO "Attaching task $pid to $path"
> +    tst_res TINFO "Attaching task $pid to $path"
>
> -    ROD echo "$pid" \> "$path/tasks"
> +    ROD echo "$pid" \> "$path/$task_list"
>
> -    for task in $(cat "$path/tasks"); do
> +    for task in $(cat "$path/$task_list"); do
>          if [ "$task" -ne "$pid" ]; then
> -            tst_resm TINFO "Unexpected pid $task in $path/tasks, expected $pid"
> +            tst_res TINFO "Unexpected pid $task in $path/$task_list, expected $pid"
>              return 1
>          fi
>      done
> @@ -64,11 +50,13 @@ create_subgroup()
>  {
>      path="$1"
>
> -    ROD mkdir "$path"
> +    [ ! -d "$path" ] && ROD mkdir "$path"
>
>      # cpuset.cpus and cpuset.mems must be initialized with suitable value
> -    # before any pids are attached
> -    if [ "$subsystem" = "cpuset" ]; then
> +    # before any pids are attached.
> +    # Only needs to be done for cgroup v1 as sets are inherited from parents
> +    # by default in cgroup v2.
> +    if [ "$cgroup_v" = "V1" ] && [ "$subsystem" = "cpuset" ]; then
>          if [ -e "$mount_point/cpus" ]; then
>              ROD cat "$mount_point/cpus" \> "$path/cpus"
>              ROD cat "$mount_point/mems" \> "$path/mems"
> @@ -79,54 +67,25 @@ create_subgroup()
>      fi
>  }
>
> -
> -setup()
> +common_setup()
>  {
> -    tst_require_root
> -    tst_require_cmds killall
> -
> -    if [ ! -f /proc/cgroups ]; then
> -        tst_brkm TCONF "Kernel does not support for control groups"
> -    fi
> -
> -    exist_subsystem "$subsystem"
> -
> -    tst_tmpdir
> -    TST_CLEANUP=cleanup
> -
> -    mount_point=`grep -w $subsystem /proc/mounts | grep -w "cgroup" | \
> -       cut -f 2 | cut -d " " -f2`
> -
> -    if [ -z "$mount_point" ]; then
> -        try_umount=1
> -        mount_point="/dev/cgroup"
> -       tst_resm TINFO "Subsystem $subsystem is not mounted, mounting it at $mount_point"
> -        ROD mkdir $mount_point
> -        ROD mount -t cgroup -o "$subsystem" "ltp_cgroup" "$mount_point"
> -    else
> -       tst_resm TINFO "Subsystem $subsystem is mounted at $mount_point"
> -    fi
> +    cgroup_require "$subsystem"

> +    mount_point=$(cgroup_get_mountpoint "$subsystem")
> +    start_path=$(cgroup_get_test_path "$subsystem")
> +    cgroup_v=$(cgroup_get_version "$subsystem")
> +    task_list=$(cgroup_get_task_list "$subsystem")

Maybe declare these variables at the top of this file, because
we hope to export and use them globally.

> +
> +    [ "$cgroup_v" = "V2" ] && ROD echo "+$subsystem" \> "$start_path/cgroup.subtree_control"

Can we just do this in tst_cgctl.c automatically if it requires the
subsystem on V2.
(or at least move it to cgroup_lib.sh)
Then people don't need to take care of this additionally.

> +    tst_res TINFO "test starts with cgroup $cgroup_v"
>  }
>
> -cleanup()
> +common_cleanup()
>  {
> -    tst_rmdir
> -
>      killall -9 cgroup_fj_proc >/dev/null 2>&1
>
> -    tst_resm TINFO "Removing all ltp subgroups..."
> -
> -    find "$mount_point/ltp/" -depth -type d -exec rmdir '{}' \;
> +    tst_res TINFO "Removing all ltp subgroups..."
>
> -    if [ -z "$try_umount" ]; then
> -       return
> -    fi
> -
> -    if grep -q "$mount_point" /proc/mounts; then
> -        EXPECT_PASS umount "$mount_point"
> -    fi
> +    [ -d "$start_path" ] && find "$start_path" -depth -type d -exec rmdir '{}' \;
>
> -    if [ -e "$mount_point" ]; then
> -        EXPECT_PASS rmdir "$mount_point"
> -    fi
> +    cgroup_cleanup
>  }
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> index fc3ad1b63..07373dcfe 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> @@ -1,30 +1,16 @@
>  #!/bin/sh
> -
> -################################################################################
> -##                                                                            ##
> -## Copyright (c) 2009 FUJITSU LIMITED                                         ##
> -##  Author: Shi Weihua <shiwh@cn.fujitsu.com>                                 ##
> -## Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>                          ##
> -## Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>                     ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software Foundation,   ##
> -## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
> -##                                                                            ##
> -################################################################################
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2009 FUJITSU LIMITED
> +# Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> +# Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
> +# Author: Shi Weihua <shiwh@cn.fujitsu.com>
>
>  TCID="cgroup_fj_function2"
> -TST_TOTAL=7
> +TST_TESTFUNC=test
> +TST_SETUP=setup
> +TST_CLEANUP=cleanup
> +TST_CNT=9
> +TST_POS_ARGS=1
>
>  . cgroup_fj_common.sh
>
> @@ -36,7 +22,7 @@ usage_and_exit()
>      echo "  ./cgroup_fj_function2.sh subsystem"
>      echo "example: ./cgroup_fj_function2.sh cpuset"
>
> -    tst_brkm TBROK "$1"
> +    tst_brk TBROK "$1"
>  }
>
>  if [ "$#" -ne "1" ]; then
> @@ -46,49 +32,67 @@ fi
>  # Move a task from group to group
>  test1()
>  {
> +    # mv'ing cgroups is not available in cgroup2
> +    if [ "$cgroup_v" = "V2" ]; then
> +        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping test"
> +        return
> +    fi
> +
>      if ! attach_and_check "$pid" "$start_path/ltp_1"; then
> -         tst_resm TFAIL "Failed to attach task"
> +         tst_res TFAIL "Failed to attach task"
>           return
>      fi
>
>      if ! attach_and_check "$pid" "$start_path"; then
> -         tst_resm TFAIL "Failed to attach task"
> +         tst_res TFAIL "Failed to attach task"
>           return
>      fi
>
> -    tst_resm TPASS "Task attached succesfully"
> +    tst_res TPASS "Task attached succesfully"
>  }
>
>  # Group can be renamed with mv
>  test2()
>  {
> +    # mv'ing cgroups is not available in cgroup2
> +    if [ "$cgroup_v" = "V2" ]; then
> +        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping test"
> +        return
> +    fi
> +
>      create_subgroup "$start_path/ltp_2"
>
>      if ! mv "$start_path/ltp_2" "$start_path/ltp_3"; then
> -        tst_resm TFAIL "Failed to move $start_path/ltp_2 to $start_path/ltp_3"
> +        tst_res TFAIL "Failed to move $start_path/ltp_2 to $start_path/ltp_3"
>          rmdir "$start_path/ltp_2"
>          return
>      fi
>
>      if ! rmdir "$start_path/ltp_3"; then
> -        tst_resm TFAIL "Failed to remove $start_path/ltp_3"
> +        tst_res TFAIL "Failed to remove $start_path/ltp_3"
>          return
>      fi
>
> -    tst_resm TPASS "Successfully moved $start_path/ltp_2 to $start_path/ltp_3"
> +    tst_res TPASS "Successfully moved $start_path/ltp_2 to $start_path/ltp_3"
>  }
>
>  # Group can be renamed with mv unless the target name exists
>  test3()
>  {
> +    # mv'ing cgroups is not available in cgroup2
> +    if [ "$cgroup_v" = "V2" ]; then
> +        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping test"
> +        return
> +    fi
> +
>      create_subgroup "$start_path/ltp_2"
>
>      if mv "$start_path/ltp_2" "$start_path/ltp_1" > /dev/null 2>&1; then
> -        tst_resm TFAIL "Moved $start_path/ltp_2 over existing $start_path/ltp_1"
> +        tst_res TFAIL "Moved $start_path/ltp_2 over existing $start_path/ltp_1"
>          return
>      fi
>
> -    tst_resm TPASS "Failed to move $start_path/ltp_2 over existing $start_path/ltp_1"
> +    tst_res TPASS "Failed to move $start_path/ltp_2 over existing $start_path/ltp_1"
>
>      ROD rmdir "$start_path/ltp_2"
>  }
> @@ -97,77 +101,104 @@ test3()
>  test4()
>  {
>      if ! attach_and_check "$pid" "$start_path/ltp_1"; then
> -        tst_resm TFAIL "Failed to attach $pid to $start_path/ltp_1"
> +        tst_res TFAIL "Failed to attach $pid to $start_path/ltp_1"
>          return
>      fi
>
>      if rmdir "$start_path/ltp_1" > /dev/null 2>&1; then
> -        tst_resm TFAIL "Removed $start_path/ltp_1 which contains task $pid"
> -        create_subgroup "$start_path/ltp_1"
> +        tst_res TFAIL "Removed $start_path/ltp_1 which contains task $pid"
>          return
>      fi
>
> -    tst_resm TPASS "Group $start_path/ltp_1 with task $pid cannot be removed"
> +    tst_res TPASS "Group $start_path/ltp_1 with task $pid cannot be removed"
>  }
>
>  # Group with a subgroup cannot be removed
>  test5()
>  {
> +    # We need to move the tasks back to root to create a subgroup
> +    if [ "$cgroup_v" = "V2" ]; then
> +        for pid in $(cat "$start_path/ltp_1/$task_list"); do
> +                   echo $pid > "$mount_point/$task_list" 2> /dev/null
> +           done
> +
> +        ROD echo "+$subsystem" \> "$start_path/ltp_1/cgroup.subtree_control"
> +    fi
> +
>      create_subgroup "$start_path/ltp_1/a"
>
>      if rmdir "$start_path/ltp_1" > /dev/null 2>&1; then
> -        tst_resm TFAIL "Removed $start_path/ltp_1 which contains subdir 'a'"
> +        tst_res TFAIL "Removed $start_path/ltp_1 which contains subdir 'a'"
>          return
>      fi
>
> -    tst_resm TPASS "Dir $start_path/ltp_1 with subdir 'a' cannot be removed"
> +    tst_res TPASS "Dir $start_path/ltp_1 with subdir 'a' cannot be removed"
>
>      ROD rmdir "$start_path/ltp_1/a"
>
> -    ROD echo "$pid" \> "$start_path/tasks"
> +    [ "$cgroup_v" = "V2" ] && ROD echo "-$subsystem" \> "$start_path/ltp_1/cgroup.subtree_control"
> +    ROD echo "$pid" \> "$start_path/ltp_1/$task_list"
>  }
>
>  # Group cannot be moved outside of hierarchy
>  test6()
>  {
> +    # mv'ing cgroups is not available in cgroup2
> +    if [ "$cgroup_v" = "V2" ]; then
> +        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping test"
> +        return
> +    fi
> +
>      if mv "$start_path/ltp_1" "$PWD/ltp" > /dev/null 2>&1; then
> -        tst_resm TFAIL "Subgroup $start_path/ltp_1 outside hierarchy to $PWD/ltp"
> +        tst_res TFAIL "Subgroup $start_path/ltp_1 outside hierarchy to $PWD/ltp"
>          return
>      fi
>
> -    tst_resm TPASS "Subgroup $start_path/ltp_1 cannot be moved to $PWD/ltp"
> +    tst_res TPASS "Subgroup $start_path/ltp_1 cannot be moved to $PWD/ltp"
>  }
>
>  # Tasks file cannot be removed
>  test7()
>  {
> -    if rm "$start_path/ltp_1/tasks" > /dev/null 2>&1; then
> -        tst_resm TFAIL "Tasks file $start_path/ltp_1/tasks could be removed"
> +    if rm "$start_path/ltp_1/$task_list" > /dev/null 2>&1; then
> +        tst_res TFAIL "Tasks file $start_path/ltp_1/$task_list could be removed"
>          return
>      fi
>
> -    tst_resm TPASS "Tasks file $start_path/ltp_1/tasks cannot be removed"
> +    tst_res TPASS "Tasks file $start_path/ltp_1/tasks cannot be removed"
>  }
>
>  # Test notify_on_release with invalid inputs
>  test8()
>  {
> +    # notify_on_release is not available in cgroup2 so skip the test
> +    if [ "$cgroup_v" = "V2" ]; then
> +        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping test"
> +        return
> +    fi
> +
>      if echo "-1" > "$start_path/ltp_1/notify_on_release" 2>/dev/null; then
> -        tst_resm TFAIL "Can write -1 to $start_path/ltp_1/notify_on_release"
> +        tst_res TFAIL "Can write -1 to $start_path/ltp_1/notify_on_release"
>          return
>      fi
>
>      if echo "ltp" > "$start_path/ltp_1/notify_on_release" 2>/dev/null; then
> -        tst_resm TFAIL "Can write ltp to $start_path/ltp_1/notify_on_release"
> +        tst_res TFAIL "Can write ltp to $start_path/ltp_1/notify_on_release"
>          return
>      fi
>
> -    tst_resm TPASS "Cannot write invalid values to $start_path/ltp_1/notify_on_release"
> +    tst_res TPASS "Cannot write invalid values to $start_path/ltp_1/notify_on_release"
>  }
>
>  # Test that notify_on_release can be changed
>  test9()
>  {
> +    # notify_on_release is not available in cgroup2 so skip the test
> +    if [ "$cgroup_v" = "V2" ]; then
> +        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping test"
> +        return
> +    fi
> +
>      local notify=$(ROD cat "$start_path/ltp_1/notify_on_release")
>      local value
>
> @@ -178,37 +209,29 @@ test9()
>      fi
>
>      if ! echo "$value" > "$start_path/ltp_1/notify_on_release"; then
> -        tst_resm TFAIL "Failed to set $start_path/ltp_1/notify_on_release to $value"
> +        tst_res TFAIL "Failed to set $start_path/ltp_1/notify_on_release to $value"
>          return
>      fi
>
>      ROD echo "$notify" \> "$start_path/ltp_1/notify_on_release"
>
> -    tst_resm TPASS "Set $start_path/ltp_1/notify_on_release to $value"
> +    tst_res TPASS "Set $start_path/ltp_1/notify_on_release to $value"
>  }
>
> -setup
> -
> -cgroup_fj_proc&
> -pid=$!
> -
> -start_path="$mount_point/ltp"
> -
> -create_subgroup "$start_path"
> -create_subgroup "$start_path/ltp_1"
> -
> -test1
> -test2
> -test3
> -test4
> -test5
> -test6
> -test7
> -test8
> -test9
> +setup()
> +{
> +    common_setup
> +    cgroup_fj_proc&
> +    pid=$!
> +    create_subgroup "$start_path/ltp_1"
> +}


Btw, I got a TBROK when running the "cgroup_fj_function.sh blkio", but this
looks not related to your patch, I'll try to look into the problem.

--------------
tst_cgroup.c:829: TINFO: Could not mount V1 CGroup on
/tmp/cgroup_blkio: EBUSY (16)
tst_cgroup.c:932: TCONF: 'blkio' controller required, but not available
cgroup_fj_function 1 TBROK: cgroup_require: No state was set after
call. Controller 'blkio' maybe does not exist?


>
> -ROD kill -9 $pid
> -wait $pid
> -ROD rmdir "$start_path/ltp_1"
> +cleanup()
> +{
> +    kill -9 $pid >/dev/null 2>&1
> +    wait $pid >/dev/null 2>&1
> +    rmdir "$start_path/ltp_1" >/dev/null 2>&1
> +    common_cleanup
> +}
>
> -tst_exit
> +tst_run
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c
> index 93bc8b744..e3c1153cb 100644
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_proc.c
> @@ -1,24 +1,6 @@
> -/******************************************************************************/
> -/*                                                                            */
> -/* Copyright (c) 2009 FUJITSU LIMITED                                         */
> -/*                                                                            */
> -/* This program is free software;  you can redistribute it and/or modify      */
> -/* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or          */
> -/* (at your option) any later version.                                        */
> -/*                                                                            */
> -/* This program is distributed in the hope that it will be useful,            */
> -/* but WITHOUT ANY WARRANTY;  without even the implied warranty of            */
> -/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See                  */
> -/* the GNU General Public License for more details.                           */
> -/*                                                                            */
> -/* You should have received a copy of the GNU General Public License          */
> -/* along with this program;  if not, write to the Free Software               */
> -/* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    */
> -/*                                                                            */
> -/* Author: Shi Weihua <shiwh@cn.fujitsu.com>                                  */
> -/*                                                                            */
> -/******************************************************************************/
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (c) 2009 FUJITSU LIMITED
> +// Author: Shi Weihua <shiwh@cn.fujitsu.com>
>
>  #include <sys/types.h>
>  #include <sys/wait.h>
> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
> index 292df6f6c..f0f6d32d4 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_stress.sh
> @@ -1,30 +1,16 @@
>  #!/bin/sh
> -
> -################################################################################
> -##                                                                            ##
> -## Copyright (c) 2009 FUJITSU LIMITED                                         ##
> -##  Author: Shi Weihua <shiwh@cn.fujitsu.com>                                 ##
> -## Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>                          ##
> -## Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>                     ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software Foundation,   ##
> -## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
> -##                                                                            ##
> -################################################################################
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2009 FUJITSU LIMITED
> +# Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> +# Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
> +# Author: Shi Weihua <shiwh@cn.fujitsu.com>
>
>  TCID="cgroup_fj_stress"
> -TST_TOTAL=1
> +TST_CNT=1
> +TST_TESTFUNC=test
> +TST_SETUP=setup
> +TST_CLEANUP=cleanup
> +TST_POS_ARGS=4
>
>  . cgroup_fj_common.sh
>
> @@ -47,35 +33,9 @@ usage_and_exit()
>      echo "      each - attach process to each subgroup"
>      echo "example: ./cgroup_fj_stress.sh cpuset 1 1 one"
>      echo
> -    tst_brkm TBROK "$1"
> +    tst_brk TBROK "$1"
>  }
>
> -if [ "$#" -ne "4" ]; then
> -    usage_and_exit "Wrong number of parameters, expected 4"
> -fi
> -
> -case $subgroup_num in
> -    ''|*[!0-9]*) usage_and_exit "Number of subgroups must be possitive integer";;
> -    *) ;;
> -esac
> -
> -case $subgroup_depth in
> -    ''|*[!0-9]*) usage_and_exit "Depth of the subgroup tree must be possitive integer";;
> -    *) ;;
> -esac
> -
> -case $attach_operation in
> -    'none'|'one'|'each');;
> -    *) usage_and_exit "Invalid attach operation: $attach_operation";;
> -esac
> -
> -setup
> -
> -export TMPFILE=./tmp_tasks.$$
> -
> -count=0
> -collected_pids=
> -
>  build_subgroups()
>  {
>      local cur_path="$1"
> @@ -87,6 +47,12 @@ build_subgroups()
>      fi
>
>      create_subgroup "$cur_path"
> +
> +    # We can only attach processes to the leaves of the tree in cgroup v2 which
> +    # means we need to enable the controllers everywhere inbetween.
> +    if [ "$cgroup_v" = "V2" ] && [ "$cur_depth" -ne "$subgroup_depth" ]; then
> +        ROD echo "+$subsystem" \> "$cur_path/cgroup.subtree_control"
> +    fi
>      count=$((count+1))
>
>      for i in $(seq 1 $subgroup_num); do
> @@ -113,8 +79,10 @@ attach_task()
>          pid="$ppid"
>      fi
>
> -    if ! attach_and_check "$pid" "$cur_path"; then
> +    if [ "$cgroup_v" = "V2" ] && [ $cur_depth -eq $subgroup_depth ] || [ "$cgroup_v" = "V1" ]; then
> +        if ! attach_and_check "$pid" "$cur_path"; then
>              fail=1
> +        fi
>      fi
>
>      for i in $(seq 1 $subgroup_num); do
> @@ -123,46 +91,78 @@ attach_task()
>      done
>
>      if [ -n "$ppid" ]; then
> -        if ! attach_and_check "$pid" "$cur_path"; then
> -            fail=1
> +        if [ "$cgroup_v" = "V2" ] && [ $cur_depth -eq $subgroup_depth ] || [ "$cgroup_v" = "V1" ]; then
> +            if ! attach_and_check "$pid" "$cur_path"; then
> +                fail=1
> +            fi
>          fi
>      fi
>  }
>
> -start_path="$mount_point/ltp"
> +setup()
> +{
> +    export TMPFILE=./tmp_tasks.$$
> +    count=0
> +    collected_pids=
> +
> +    case $subgroup_num in
> +        ''|*[!0-9]*) usage_and_exit "Number of subgroups must be possitive integer";;
> +        *) ;;
> +    esac
> +
> +    case $subgroup_depth in
> +        ''|*[!0-9]*) usage_and_exit "Depth of the subgroup tree must be possitive integer";;
> +        *) ;;
> +    esac
> +
> +    case $attach_operation in
> +        'none'|'one'|'each');;
> +        *) usage_and_exit "Invalid attach operation: $attach_operation";;
> +    esac
> +
> +    common_setup
> +}
>
> -tst_resm TINFO "Creating subgroups ..."
> +cleanup()
> +{
> +    common_cleanup
> +}
>
> -build_subgroups "$start_path" 0
> +test()
> +{
> +    tst_res TINFO "Creating subgroups ..."
>
> -tst_resm TINFO "... mkdired $count times"
> +    build_subgroups "$start_path" 0
>
> -case $attach_operation in
> -"one" )
> -    cgroup_fj_proc &
> -    pid=$!
> +    tst_res TINFO "... mkdired $count times"
>
> -    tst_resm TINFO "Moving one task around"
> -    attach_task "$start_path" 0 "$pid"
> -    ROD kill -9 "$pid"
> -    wait "$pid"
> -    ;;
> -"each" )
> -    tst_resm TINFO "Attaching task to each subgroup"
> -    attach_task "$start_path" 0
> -    for pid in $collected_pids; do
> +    case $attach_operation in
> +    "one" )
> +        cgroup_fj_proc &
> +        pid=$!
> +
> +        tst_res TINFO "Moving one task around"
> +        attach_task "$start_path" 0 "$pid"
>          ROD kill -9 "$pid"
>          wait "$pid"
> -    done
> -    ;;
> -*  )
> -    ;;
> -esac
> -
> -if [ -n "$fail" ]; then
> -    tst_resm TFAIL "Attaching tasks failed!"
> -else
> -    tst_resm TPASS "All done!"
> -fi
> -
> -tst_exit
> +        ;;
> +    "each" )
> +        tst_res TINFO "Attaching task to each subgroup"
> +        attach_task "$start_path" 0
> +        for pid in $collected_pids; do
> +            ROD kill -9 "$pid"
> +            wait "$pid"
> +        done
> +        ;;
> +    *  )
> +        ;;
> +    esac
> +
> +    if [ -n "$fail" ]; then
> +        tst_res TFAIL "Attaching tasks failed!"
> +    else
> +        tst_res TPASS "All done!"
> +    fi
> +}
> +
> +tst_run
> --
> 2.32.0
>


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
