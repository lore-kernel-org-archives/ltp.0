Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E644FC433F5
	for <ltp@archiver.kernel.org>; Wed,  2 Mar 2022 23:42:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 752383CA351
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 00:42:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B07C3C96B4
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 00:42:13 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 109E2601C7A
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 00:42:10 +0100 (CET)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 25F523F222
 for <ltp@lists.linux.it>; Wed,  2 Mar 2022 23:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646264528;
 bh=Sa7j4oiaMjipwstCpWbdsX3AYdmiPvlA9WQt5hEbB5o=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=Vra5lM8R9S6QT5f122Fc33y6lfHc1f7vZC+sxWe8IcAv45Vh9bq0p8m7OZxx8raH/
 IWDfSuArpwPo6KvluJzvHKPVGulIHQ4jABvnlrbOB9qFw1uclHlHPsXxN/sVObWGzq
 I7x/b3Wl7Z242mj1XskSiz/N0NlVm115pZYWRoJD/EZonG22x/GEdOowvyUiSmRsDG
 TFiOVEKFkkPRel1Bci3vR+XfVFpxZvOvD/lBsgYuWJWCwsV0AN2TRP1OOXOiN1mxdu
 rU1a9u7PcTwaLBb0//0rfca+V/2QJH6k3mgcuxcCiXkqsPbMACNiOZAe+Yt4UWb6VT
 v2soVRWcIqLAA==
Received: by mail-ed1-f71.google.com with SMTP id
 j10-20020a05640211ca00b004090fd8a936so1819107edw.23
 for <ltp@lists.linux.it>; Wed, 02 Mar 2022 15:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sa7j4oiaMjipwstCpWbdsX3AYdmiPvlA9WQt5hEbB5o=;
 b=J2i6Q32jNxarPVOKpMNqTrGVvGI9L9ig40r2pkkFnat5X0iGrT+Z4xySRM6tAKdywY
 6NMbVcBvJpLfjDi8wLk389KD0qdfebd3QZBDPbfA7CR//l7jcLibtMR8hXiRgj3opcvW
 oyl4OAJh4OnK30bDLWCW6FOWkoVkhdCOmVuRj16Tuiwk8/y1bg7YTmnfe2lCZWNfZA10
 4CwzqdDJmVMel3dAvnX4XLo5C273+L9hUQXS/ADSQKKNrtrQRrIY70KEYLRFM8oulCk6
 j8HA0Aqf4dboCe0v8xgNNdtoNETJSWhs4//1YxDyL3OscVVwxKT557bvJ1+cBS5U9KR/
 XWzw==
X-Gm-Message-State: AOAM530uOrRy+52e8bbdRg6+6M2nHZFBIsWXZ4aIctuIyrFgA7zgF9dG
 MDVDpioocfurzg0o9mR5T4NIHsCKLmAQja09M6C/UyxzQSxIB+Fm4iR4T/jtPg6jAOMl195AaCf
 QcAMsOrtqOcdDxY/yKSQ8pPx+RtlRwNindH+ZeMzE9sjY
X-Received: by 2002:aa7:cad3:0:b0:410:b188:a49a with SMTP id
 l19-20020aa7cad3000000b00410b188a49amr32003127edt.416.1646264527530; 
 Wed, 02 Mar 2022 15:42:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7qfyAuFfOVcpyB7LfFKUZsY5UTZFIoYzC2Ph9e8kXpwicbe7KQPhkIXtQnBqJV3vUEIiFYTcSjINSIhfaCm8=
X-Received: by 2002:aa7:cad3:0:b0:410:b188:a49a with SMTP id
 l19-20020aa7cad3000000b00410b188a49amr32003107edt.416.1646264527209; Wed, 02
 Mar 2022 15:42:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <9ba0c0fafeb4fd18de0df87b700ec2d9a111fc1a.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2dsE4TLjOBrgWjhFfh5ng+xJ-PPGgokpBkrjmLoH9FZNg@mail.gmail.com>
In-Reply-To: <CAEemH2dsE4TLjOBrgWjhFfh5ng+xJ-PPGgokpBkrjmLoH9FZNg@mail.gmail.com>
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Wed, 2 Mar 2022 15:41:31 -0800
Message-ID: <CADS1e3e163hJ0bz1C-XD9=FM3mCFnBP9S8VwQmPGYxmG6eMFJA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Content-Type: multipart/mixed; boundary="===============0470758185=="
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

--===============0470758185==
Content-Type: multipart/alternative; boundary="00000000000059e69a05d944d4ac"

--00000000000059e69a05d944d4ac
Content-Type: text/plain; charset="UTF-8"

Hi Li,

On Mon, Jan 24, 2022 at 12:52 AM Li Wang <liwang@redhat.com> wrote:

> On Wed, Jan 19, 2022 at 10:44 PM Luke Nowakowski-Krijger
> <luke.nowakowskikrijger@canonical.com> wrote:
> >
> > Update the cgroup_fj_* tests to use the newer test lib and to use the
> > updated version of the cgroup lib which handles mounting and unmounting
> > for both v1 and v2 controllers.
> >
> > The tests were modified to accomodate testing the v2 controller
>
> accommodate ^
>
> > interfaces where it still made sense, and in other places tests were
> > skipped as they were testing using specific parts of the v1 interface
> > that doesen't exist on v2 controllers.
>
> doesn't ^
>
> >
> > Also updated the licensing info at the beginning of the file with SPDX
> > license identifier.
> >
> > Signed-off-by: Luke Nowakowski-Krijger <
> luke.nowakowskikrijger@canonical.com>
> > ---
> >  .../controllers/cgroup_fj/cgroup_fj_common.sh | 105 ++++-------
> >  .../cgroup_fj/cgroup_fj_function.sh           | 169 ++++++++++--------
> >  .../controllers/cgroup_fj/cgroup_fj_proc.c    |  24 +--
> >  .../controllers/cgroup_fj/cgroup_fj_stress.sh | 168 ++++++++---------
> >  4 files changed, 215 insertions(+), 251 deletions(-)
> >
> > diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > index 53ab637e8..9017a3cab 100755
> > --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> > @@ -1,33 +1,19 @@
> >  #!/bin/sh
> > -
> >
> -################################################################################
> > -##
>       ##
> > -## Copyright (c) 2009 FUJITSU LIMITED
>        ##
> > -##  Author: Shi Weihua <shiwh@cn.fujitsu.com>
>        ##
> > -## Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
>         ##
> > -## Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
>        ##
> > -##
>       ##
> > -## This program is free software;  you can redistribute it and#or
> modify      ##
> > -## it under the terms of the GNU General Public License as published
> by       ##
> > -## the Free Software Foundation; either version 2 of the License, or
>       ##
> > -## (at your option) any later version.
>       ##
> > -##
>       ##
> > -## This program is distributed in the hope that it will be useful, but
>       ##
> > -## WITHOUT ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY ##
> > -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License   ##
> > -## for more details.
>       ##
> > -##
>       ##
> > -## You should have received a copy of the GNU General Public License
>       ##
> > -## along with this program;  if not, write to the Free Software
> Foundation,   ##
> > -## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>        ##
> > -##
>       ##
> >
> -################################################################################
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +# Copyright (c) 2009 FUJITSU LIMITED
> > +# Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> > +# Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
> > +# Author: Shi Weihua <shiwh@cn.fujitsu.com>
> >
> >  for arg; do
> >      TCID="${TCID}_$arg"
> >  done
> >
> > -. test.sh
> > +TST_NEEDS_CMDS="rmdir killall"
> > +TST_NEEDS_ROOT=1
> > +TST_NEEDS_TMPDIR=1
> > +
> > +. cgroup_lib.sh
> >
> >  exist_subsystem()
>
> This function is redundant since we have moved the
> existence check into cgroup_require(), isn't it?
>
> >  {
> > @@ -46,13 +32,13 @@ attach_and_check()
> >      local task
> >      shift
> >
> > -    tst_resm TINFO "Attaching task $pid to $path"
> > +    tst_res TINFO "Attaching task $pid to $path"
> >
> > -    ROD echo "$pid" \> "$path/tasks"
> > +    ROD echo "$pid" \> "$path/$task_list"
> >
> > -    for task in $(cat "$path/tasks"); do
> > +    for task in $(cat "$path/$task_list"); do
> >          if [ "$task" -ne "$pid" ]; then
> > -            tst_resm TINFO "Unexpected pid $task in $path/tasks,
> expected $pid"
> > +            tst_res TINFO "Unexpected pid $task in $path/$task_list,
> expected $pid"
> >              return 1
> >          fi
> >      done
> > @@ -64,11 +50,13 @@ create_subgroup()
> >  {
> >      path="$1"
> >
> > -    ROD mkdir "$path"
> > +    [ ! -d "$path" ] && ROD mkdir "$path"
> >
> >      # cpuset.cpus and cpuset.mems must be initialized with suitable
> value
> > -    # before any pids are attached
> > -    if [ "$subsystem" = "cpuset" ]; then
> > +    # before any pids are attached.
> > +    # Only needs to be done for cgroup v1 as sets are inherited from
> parents
> > +    # by default in cgroup v2.
> > +    if [ "$cgroup_v" = "V1" ] && [ "$subsystem" = "cpuset" ]; then
> >          if [ -e "$mount_point/cpus" ]; then
> >              ROD cat "$mount_point/cpus" \> "$path/cpus"
> >              ROD cat "$mount_point/mems" \> "$path/mems"
> > @@ -79,54 +67,25 @@ create_subgroup()
> >      fi
> >  }
> >
> > -
> > -setup()
> > +common_setup()
> >  {
> > -    tst_require_root
> > -    tst_require_cmds killall
> > -
> > -    if [ ! -f /proc/cgroups ]; then
> > -        tst_brkm TCONF "Kernel does not support for control groups"
> > -    fi
> > -
> > -    exist_subsystem "$subsystem"
> > -
> > -    tst_tmpdir
> > -    TST_CLEANUP=cleanup
> > -
> > -    mount_point=`grep -w $subsystem /proc/mounts | grep -w "cgroup" | \
> > -       cut -f 2 | cut -d " " -f2`
> > -
> > -    if [ -z "$mount_point" ]; then
> > -        try_umount=1
> > -        mount_point="/dev/cgroup"
> > -       tst_resm TINFO "Subsystem $subsystem is not mounted, mounting it
> at $mount_point"
> > -        ROD mkdir $mount_point
> > -        ROD mount -t cgroup -o "$subsystem" "ltp_cgroup" "$mount_point"
> > -    else
> > -       tst_resm TINFO "Subsystem $subsystem is mounted at $mount_point"
> > -    fi
> > +    cgroup_require "$subsystem"
>
> > +    mount_point=$(cgroup_get_mountpoint "$subsystem")
> > +    start_path=$(cgroup_get_test_path "$subsystem")
> > +    cgroup_v=$(cgroup_get_version "$subsystem")
> > +    task_list=$(cgroup_get_task_list "$subsystem")
>
> Maybe declare these variables at the top of this file, because
> we hope to export and use them globally.
>
> > +
> > +    [ "$cgroup_v" = "V2" ] && ROD echo "+$subsystem" \>
> "$start_path/cgroup.subtree_control"
>
> Can we just do this in tst_cgctl.c automatically if it requires the
> subsystem on V2.
> (or at least move it to cgroup_lib.sh)
> Then people don't need to take care of this additionally.
>
>
The only problem with this is that we assume that the user doesn't want to
use the test_dir as the directory to work in. If we write to
cgroup.subtree_control we cant add any processes to cgroup.procs in the
test_dir directory.

I think it would be more intuitive to have the test_dir ready to be used as
a leaf cgroup dir and not assume it to be a parent. But thats honestly just
a decision to make :)


> > +    tst_res TINFO "test starts with cgroup $cgroup_v"
> >  }
> >
> > -cleanup()
> > +common_cleanup()
> >  {
> > -    tst_rmdir
> > -
> >      killall -9 cgroup_fj_proc >/dev/null 2>&1
> >
> > -    tst_resm TINFO "Removing all ltp subgroups..."
> > -
> > -    find "$mount_point/ltp/" -depth -type d -exec rmdir '{}' \;
> > +    tst_res TINFO "Removing all ltp subgroups..."
> >
> > -    if [ -z "$try_umount" ]; then
> > -       return
> > -    fi
> > -
> > -    if grep -q "$mount_point" /proc/mounts; then
> > -        EXPECT_PASS umount "$mount_point"
> > -    fi
> > +    [ -d "$start_path" ] && find "$start_path" -depth -type d -exec
> rmdir '{}' \;
> >
> > -    if [ -e "$mount_point" ]; then
> > -        EXPECT_PASS rmdir "$mount_point"
> > -    fi
> > +    cgroup_cleanup
> >  }
> > diff --git
> a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> > index fc3ad1b63..07373dcfe 100755
> > --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> > +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
> > @@ -1,30 +1,16 @@
> >  #!/bin/sh
> > -
> >
> -################################################################################
> > -##
>       ##
> > -## Copyright (c) 2009 FUJITSU LIMITED
>        ##
> > -##  Author: Shi Weihua <shiwh@cn.fujitsu.com>
>        ##
> > -## Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
>         ##
> > -## Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
>        ##
> > -##
>       ##
> > -## This program is free software;  you can redistribute it and#or
> modify      ##
> > -## it under the terms of the GNU General Public License as published
> by       ##
> > -## the Free Software Foundation; either version 2 of the License, or
>       ##
> > -## (at your option) any later version.
>       ##
> > -##
>       ##
> > -## This program is distributed in the hope that it will be useful, but
>       ##
> > -## WITHOUT ANY WARRANTY; without even the implied warranty of
> MERCHANTABILITY ##
> > -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License   ##
> > -## for more details.
>       ##
> > -##
>       ##
> > -## You should have received a copy of the GNU General Public License
>       ##
> > -## along with this program;  if not, write to the Free Software
> Foundation,   ##
> > -## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>        ##
> > -##
>       ##
> >
> -################################################################################
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +# Copyright (c) 2009 FUJITSU LIMITED
> > +# Copyright (c) 2015 Cedric Hnyda <chnyda@suse.com>
> > +# Copyright (c) 2015-2016 Cyril Hrubis <chrubis@suse.cz>
> > +# Author: Shi Weihua <shiwh@cn.fujitsu.com>
> >
> >  TCID="cgroup_fj_function2"
> > -TST_TOTAL=7
> > +TST_TESTFUNC=test
> > +TST_SETUP=setup
> > +TST_CLEANUP=cleanup
> > +TST_CNT=9
> > +TST_POS_ARGS=1
> >
> >  . cgroup_fj_common.sh
> >
> > @@ -36,7 +22,7 @@ usage_and_exit()
> >      echo "  ./cgroup_fj_function2.sh subsystem"
> >      echo "example: ./cgroup_fj_function2.sh cpuset"
> >
> > -    tst_brkm TBROK "$1"
> > +    tst_brk TBROK "$1"
> >  }
> >
> >  if [ "$#" -ne "1" ]; then
> > @@ -46,49 +32,67 @@ fi
> >  # Move a task from group to group
> >  test1()
> >  {
> > +    # mv'ing cgroups is not available in cgroup2
> > +    if [ "$cgroup_v" = "V2" ]; then
> > +        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping
> test"
> > +        return
> > +    fi
> > +
> >      if ! attach_and_check "$pid" "$start_path/ltp_1"; then
> > -         tst_resm TFAIL "Failed to attach task"
> > +         tst_res TFAIL "Failed to attach task"
> >           return
> >      fi
> >
> >      if ! attach_and_check "$pid" "$start_path"; then
> > -         tst_resm TFAIL "Failed to attach task"
> > +         tst_res TFAIL "Failed to attach task"
> >           return
> >      fi
> >
> > -    tst_resm TPASS "Task attached succesfully"
> > +    tst_res TPASS "Task attached succesfully"
> >  }
> >
> >  # Group can be renamed with mv
> >  test2()
> >  {
> > +    # mv'ing cgroups is not available in cgroup2
> > +    if [ "$cgroup_v" = "V2" ]; then
> > +        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping
> test"
> > +        return
> > +    fi
> > +
> >      create_subgroup "$start_path/ltp_2"
> >
> >      if ! mv "$start_path/ltp_2" "$start_path/ltp_3"; then
> > -        tst_resm TFAIL "Failed to move $start_path/ltp_2 to
> $start_path/ltp_3"
> > +        tst_res TFAIL "Failed to move $start_path/ltp_2 to
> $start_path/ltp_3"
> >          rmdir "$start_path/ltp_2"
> >          return
> >      fi
> >
> >      if ! rmdir "$start_path/ltp_3"; then
> > -        tst_resm TFAIL "Failed to remove $start_path/ltp_3"
> > +        tst_res TFAIL "Failed to remove $start_path/ltp_3"
> >          return
> >      fi
> >
> > -    tst_resm TPASS "Successfully moved $start_path/ltp_2 to
> $start_path/ltp_3"
> > +    tst_res TPASS "Successfully moved $start_path/ltp_2 to
> $start_path/ltp_3"
> >  }
> >
> >  # Group can be renamed with mv unless the target name exists
> >  test3()
> >  {
> > +    # mv'ing cgroups is not available in cgroup2
> > +    if [ "$cgroup_v" = "V2" ]; then
> > +        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping
> test"
> > +        return
> > +    fi
> > +
> >      create_subgroup "$start_path/ltp_2"
> >
> >      if mv "$start_path/ltp_2" "$start_path/ltp_1" > /dev/null 2>&1; then
> > -        tst_resm TFAIL "Moved $start_path/ltp_2 over existing
> $start_path/ltp_1"
> > +        tst_res TFAIL "Moved $start_path/ltp_2 over existing
> $start_path/ltp_1"
> >          return
> >      fi
> >
> > -    tst_resm TPASS "Failed to move $start_path/ltp_2 over existing
> $start_path/ltp_1"
> > +    tst_res TPASS "Failed to move $start_path/ltp_2 over existing
> $start_path/ltp_1"
> >
> >      ROD rmdir "$start_path/ltp_2"
> >  }
> > @@ -97,77 +101,104 @@ test3()
> >  test4()
> >  {
> >      if ! attach_and_check "$pid" "$start_path/ltp_1"; then
> > -        tst_resm TFAIL "Failed to attach $pid to $start_path/ltp_1"
> > +        tst_res TFAIL "Failed to attach $pid to $start_path/ltp_1"
> >          return
> >      fi
> >
> >      if rmdir "$start_path/ltp_1" > /dev/null 2>&1; then
> > -        tst_resm TFAIL "Removed $start_path/ltp_1 which contains task
> $pid"
> > -        create_subgroup "$start_path/ltp_1"
> > +        tst_res TFAIL "Removed $start_path/ltp_1 which contains task
> $pid"
> >          return
> >      fi
> >
> > -    tst_resm TPASS "Group $start_path/ltp_1 with task $pid cannot be
> removed"
> > +    tst_res TPASS "Group $start_path/ltp_1 with task $pid cannot be
> removed"
> >  }
> >
> >  # Group with a subgroup cannot be removed
> >  test5()
> >  {
> > +    # We need to move the tasks back to root to create a subgroup
> > +    if [ "$cgroup_v" = "V2" ]; then
> > +        for pid in $(cat "$start_path/ltp_1/$task_list"); do
> > +                   echo $pid > "$mount_point/$task_list" 2> /dev/null
> > +           done
> > +
> > +        ROD echo "+$subsystem" \>
> "$start_path/ltp_1/cgroup.subtree_control"
> > +    fi
> > +
> >      create_subgroup "$start_path/ltp_1/a"
> >
> >      if rmdir "$start_path/ltp_1" > /dev/null 2>&1; then
> > -        tst_resm TFAIL "Removed $start_path/ltp_1 which contains subdir
> 'a'"
> > +        tst_res TFAIL "Removed $start_path/ltp_1 which contains subdir
> 'a'"
> >          return
> >      fi
> >
> > -    tst_resm TPASS "Dir $start_path/ltp_1 with subdir 'a' cannot be
> removed"
> > +    tst_res TPASS "Dir $start_path/ltp_1 with subdir 'a' cannot be
> removed"
> >
> >      ROD rmdir "$start_path/ltp_1/a"
> >
> > -    ROD echo "$pid" \> "$start_path/tasks"
> > +    [ "$cgroup_v" = "V2" ] && ROD echo "-$subsystem" \>
> "$start_path/ltp_1/cgroup.subtree_control"
> > +    ROD echo "$pid" \> "$start_path/ltp_1/$task_list"
> >  }
> >
> >  # Group cannot be moved outside of hierarchy
> >  test6()
> >  {
> > +    # mv'ing cgroups is not available in cgroup2
> > +    if [ "$cgroup_v" = "V2" ]; then
> > +        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping
> test"
> > +        return
> > +    fi
> > +
> >      if mv "$start_path/ltp_1" "$PWD/ltp" > /dev/null 2>&1; then
> > -        tst_resm TFAIL "Subgroup $start_path/ltp_1 outside hierarchy to
> $PWD/ltp"
> > +        tst_res TFAIL "Subgroup $start_path/ltp_1 outside hierarchy to
> $PWD/ltp"
> >          return
> >      fi
> >
> > -    tst_resm TPASS "Subgroup $start_path/ltp_1 cannot be moved to
> $PWD/ltp"
> > +    tst_res TPASS "Subgroup $start_path/ltp_1 cannot be moved to
> $PWD/ltp"
> >  }
> >
> >  # Tasks file cannot be removed
> >  test7()
> >  {
> > -    if rm "$start_path/ltp_1/tasks" > /dev/null 2>&1; then
> > -        tst_resm TFAIL "Tasks file $start_path/ltp_1/tasks could be
> removed"
> > +    if rm "$start_path/ltp_1/$task_list" > /dev/null 2>&1; then
> > +        tst_res TFAIL "Tasks file $start_path/ltp_1/$task_list could be
> removed"
> >          return
> >      fi
> >
> > -    tst_resm TPASS "Tasks file $start_path/ltp_1/tasks cannot be
> removed"
> > +    tst_res TPASS "Tasks file $start_path/ltp_1/tasks cannot be removed"
> >  }
> >
> >  # Test notify_on_release with invalid inputs
> >  test8()
> >  {
> > +    # notify_on_release is not available in cgroup2 so skip the test
> > +    if [ "$cgroup_v" = "V2" ]; then
> > +        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping
> test"
> > +        return
> > +    fi
> > +
> >      if echo "-1" > "$start_path/ltp_1/notify_on_release" 2>/dev/null;
> then
> > -        tst_resm TFAIL "Can write -1 to
> $start_path/ltp_1/notify_on_release"
> > +        tst_res TFAIL "Can write -1 to
> $start_path/ltp_1/notify_on_release"
> >          return
> >      fi
> >
> >      if echo "ltp" > "$start_path/ltp_1/notify_on_release" 2>/dev/null;
> then
> > -        tst_resm TFAIL "Can write ltp to
> $start_path/ltp_1/notify_on_release"
> > +        tst_res TFAIL "Can write ltp to
> $start_path/ltp_1/notify_on_release"
> >          return
> >      fi
> >
> > -    tst_resm TPASS "Cannot write invalid values to
> $start_path/ltp_1/notify_on_release"
> > +    tst_res TPASS "Cannot write invalid values to
> $start_path/ltp_1/notify_on_release"
> >  }
> >
> >  # Test that notify_on_release can be changed
> >  test9()
> >  {
> > +    # notify_on_release is not available in cgroup2 so skip the test
> > +    if [ "$cgroup_v" = "V2" ]; then
> > +        tst_res TCONF "Controller mounted on cgroup2 hierachy, skipping
> test"
> > +        return
> > +    fi
> > +
> >      local notify=$(ROD cat "$start_path/ltp_1/notify_on_release")
> >      local value
> >
> > @@ -178,37 +209,29 @@ test9()
> >      fi
> >
> >      if ! echo "$value" > "$start_path/ltp_1/notify_on_release"; then
> > -        tst_resm TFAIL "Failed to set
> $start_path/ltp_1/notify_on_release to $value"
> > +        tst_res TFAIL "Failed to set
> $start_path/ltp_1/notify_on_release to $value"
> >          return
> >      fi
> >
> >      ROD echo "$notify" \> "$start_path/ltp_1/notify_on_release"
> >
> > -    tst_resm TPASS "Set $start_path/ltp_1/notify_on_release to $value"
> > +    tst_res TPASS "Set $start_path/ltp_1/notify_on_release to $value"
> >  }
> >
> > -setup
> > -
> > -cgroup_fj_proc&
> > -pid=$!
> > -
> > -start_path="$mount_point/ltp"
> > -
> > -create_subgroup "$start_path"
> > -create_subgroup "$start_path/ltp_1"
> > -
> > -test1
> > -test2
> > -test3
> > -test4
> > -test5
> > -test6
> > -test7
> > -test8
> > -test9
> > +setup()
> > +{
> > +    common_setup
> > +    cgroup_fj_proc&
> > +    pid=$!
> > +    create_subgroup "$start_path/ltp_1"
> > +}
>
>
> Btw, I got a TBROK when running the "cgroup_fj_function.sh blkio", but this
> looks not related to your patch, I'll try to look into the problem.
>
> --------------
> tst_cgroup.c:829: TINFO: Could not mount V1 CGroup on
> /tmp/cgroup_blkio: EBUSY (16)
> tst_cgroup.c:932: TCONF: 'blkio' controller required, but not available
> cgroup_fj_function 1 TBROK: cgroup_require: No state was set after
> call. Controller 'blkio' maybe does not exist?
>
>
>
Yes this is the blkio/io controller problem Richard mentioned earlier and
doesent have anything to do with these patches.

Thanks,

-  Luke


> --
> Regards,
> Li Wang
>
>

--00000000000059e69a05d944d4ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Li, <br></div><div><br></div><div class=3D"gmail_q=
uote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jan 24, 2022 at 12:52 A=
M Li Wang &lt;<a href=3D"mailto:liwang@redhat.com">liwang@redhat.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed,=
 Jan 19, 2022 at 10:44 PM Luke Nowakowski-Krijger<br>
&lt;<a href=3D"mailto:luke.nowakowskikrijger@canonical.com" target=3D"_blan=
k">luke.nowakowskikrijger@canonical.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Update the cgroup_fj_* tests to use the newer test lib and to use the<=
br>
&gt; updated version of the cgroup lib which handles mounting and unmountin=
g<br>
&gt; for both v1 and v2 controllers.<br>
&gt;<br>
&gt; The tests were modified to accomodate testing the v2 controller<br>
<br>
accommodate ^<br>
<br>
&gt; interfaces where it still made sense, and in other places tests were<b=
r>
&gt; skipped as they were testing using specific parts of the v1 interface<=
br>
&gt; that doesen&#39;t exist on v2 controllers.<br>
<br>
doesn&#39;t ^<br>
<br>
&gt;<br>
&gt; Also updated the licensing info at the beginning of the file with SPDX=
<br>
&gt; license identifier.<br>
&gt;<br>
&gt; Signed-off-by: Luke Nowakowski-Krijger &lt;<a href=3D"mailto:luke.nowa=
kowskikrijger@canonical.com" target=3D"_blank">luke.nowakowskikrijger@canon=
ical.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 .../controllers/cgroup_fj/cgroup_fj_common.sh | 105 ++++-------<=
br>
&gt;=C2=A0 .../cgroup_fj/cgroup_fj_function.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| 169 ++++++++++--------<br>
&gt;=C2=A0 .../controllers/cgroup_fj/cgroup_fj_proc.c=C2=A0 =C2=A0 |=C2=A0 =
24 +--<br>
&gt;=C2=A0 .../controllers/cgroup_fj/cgroup_fj_stress.sh | 168 ++++++++----=
-----<br>
&gt;=C2=A0 4 files changed, 215 insertions(+), 251 deletions(-)<br>
&gt;<br>
&gt; diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.s=
h b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh<br>
&gt; index 53ab637e8..9017a3cab 100755<br>
&gt; --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh<br>
&gt; +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh<br>
&gt; @@ -1,33 +1,19 @@<br>
&gt;=C2=A0 #!/bin/sh<br>
&gt; -<br>
&gt; -#####################################################################=
###########<br>
&gt; -##=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## Copyright (c) 2009 FUJITSU LIMITED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0##<br>
&gt; -##=C2=A0 Author: Shi Weihua &lt;<a href=3D"mailto:shiwh@cn.fujitsu.co=
m" target=3D"_blank">shiwh@cn.fujitsu.com</a>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0##<br>
&gt; -## Copyright (c) 2015 Cedric Hnyda &lt;<a href=3D"mailto:chnyda@suse.=
com" target=3D"_blank">chnyda@suse.com</a>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## Copyright (c) 2015-2016 Cyril Hrubis &lt;<a href=3D"mailto:chrubis=
@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0##<br>
&gt; -##=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## This program is free software;=C2=A0 you can redistribute it and#o=
r modify=C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## it under the terms of the GNU General Public License as published =
by=C2=A0 =C2=A0 =C2=A0 =C2=A0##<br>
&gt; -## the Free Software Foundation; either version 2 of the License, or=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## (at your option) any later version.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -##=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## This program is distributed in the hope that it will be useful, bu=
t=C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHAN=
TABILITY ##<br>
&gt; -## or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Pub=
lic License=C2=A0 =C2=A0##<br>
&gt; -## for more details.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ##<br>
&gt; -##=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## You should have received a copy of the GNU General Public License=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## along with this program;=C2=A0 if not, write to the Free Software =
Foundation,=C2=A0 =C2=A0##<br>
&gt; -## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0##<br>
&gt; -##=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -#####################################################################=
###########<br>
&gt; +# SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; +# Copyright (c) 2009 FUJITSU LIMITED<br>
&gt; +# Copyright (c) 2015 Cedric Hnyda &lt;<a href=3D"mailto:chnyda@suse.c=
om" target=3D"_blank">chnyda@suse.com</a>&gt;<br>
&gt; +# Copyright (c) 2015-2016 Cyril Hrubis &lt;<a href=3D"mailto:chrubis@=
suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt;<br>
&gt; +# Author: Shi Weihua &lt;<a href=3D"mailto:shiwh@cn.fujitsu.com" targ=
et=3D"_blank">shiwh@cn.fujitsu.com</a>&gt;<br>
&gt;<br>
&gt;=C2=A0 for arg; do<br>
&gt;=C2=A0 =C2=A0 =C2=A0 TCID=3D&quot;${TCID}_$arg&quot;<br>
&gt;=C2=A0 done<br>
&gt;<br>
&gt; -. test.sh<br>
&gt; +TST_NEEDS_CMDS=3D&quot;rmdir killall&quot;<br>
&gt; +TST_NEEDS_ROOT=3D1<br>
&gt; +TST_NEEDS_TMPDIR=3D1<br>
&gt; +<br>
&gt; +. cgroup_lib.sh<br>
&gt;<br>
&gt;=C2=A0 exist_subsystem()<br>
<br>
This function is redundant since we have moved the<br>
existence check into cgroup_require(), isn&#39;t it?<br>
<br>
&gt;=C2=A0 {<br>
&gt; @@ -46,13 +32,13 @@ attach_and_check()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 local task<br>
&gt;=C2=A0 =C2=A0 =C2=A0 shift<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 tst_resm TINFO &quot;Attaching task $pid to $path&quot;=
<br>
&gt; +=C2=A0 =C2=A0 tst_res TINFO &quot;Attaching task $pid to $path&quot;<=
br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 ROD echo &quot;$pid&quot; \&gt; &quot;$path/tasks&quot;=
<br>
&gt; +=C2=A0 =C2=A0 ROD echo &quot;$pid&quot; \&gt; &quot;$path/$task_list&=
quot;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 for task in $(cat &quot;$path/tasks&quot;); do<br>
&gt; +=C2=A0 =C2=A0 for task in $(cat &quot;$path/$task_list&quot;); do<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ &quot;$task&quot; -ne &quot;$pi=
d&quot; ]; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_resm TINFO &quot;Unexpe=
cted pid $task in $path/tasks, expected $pid&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TINFO &quot;Unexpec=
ted pid $task in $path/$task_list, expected $pid&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;=C2=A0 =C2=A0 =C2=A0 done<br>
&gt; @@ -64,11 +50,13 @@ create_subgroup()<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 path=3D&quot;$1&quot;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 ROD mkdir &quot;$path&quot;<br>
&gt; +=C2=A0 =C2=A0 [ ! -d &quot;$path&quot; ] &amp;&amp; ROD mkdir &quot;$=
path&quot;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 # cpuset.cpus and cpuset.mems must be initialized =
with suitable value<br>
&gt; -=C2=A0 =C2=A0 # before any pids are attached<br>
&gt; -=C2=A0 =C2=A0 if [ &quot;$subsystem&quot; =3D &quot;cpuset&quot; ]; t=
hen<br>
&gt; +=C2=A0 =C2=A0 # before any pids are attached.<br>
&gt; +=C2=A0 =C2=A0 # Only needs to be done for cgroup v1 as sets are inher=
ited from parents<br>
&gt; +=C2=A0 =C2=A0 # by default in cgroup v2.<br>
&gt; +=C2=A0 =C2=A0 if [ &quot;$cgroup_v&quot; =3D &quot;V1&quot; ] &amp;&a=
mp; [ &quot;$subsystem&quot; =3D &quot;cpuset&quot; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if [ -e &quot;$mount_point/cpus&quot=
; ]; then<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ROD cat &quot;$mount_p=
oint/cpus&quot; \&gt; &quot;$path/cpus&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ROD cat &quot;$mount_p=
oint/mems&quot; \&gt; &quot;$path/mems&quot;<br>
&gt; @@ -79,54 +67,25 @@ create_subgroup()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -<br>
&gt; -setup()<br>
&gt; +common_setup()<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 tst_require_root<br>
&gt; -=C2=A0 =C2=A0 tst_require_cmds killall<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if [ ! -f /proc/cgroups ]; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_brkm TCONF &quot;Kernel does not supp=
ort for control groups&quot;<br>
&gt; -=C2=A0 =C2=A0 fi<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 exist_subsystem &quot;$subsystem&quot;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 tst_tmpdir<br>
&gt; -=C2=A0 =C2=A0 TST_CLEANUP=3Dcleanup<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 mount_point=3D`grep -w $subsystem /proc/mounts | grep -=
w &quot;cgroup&quot; | \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0cut -f 2 | cut -d &quot; &quot; -f2`<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if [ -z &quot;$mount_point&quot; ]; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 try_umount=3D1<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 mount_point=3D&quot;/dev/cgroup&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm TINFO &quot;Subsystem $subsystem =
is not mounted, mounting it at $mount_point&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ROD mkdir $mount_point<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 ROD mount -t cgroup -o &quot;$subsystem&q=
uot; &quot;ltp_cgroup&quot; &quot;$mount_point&quot;<br>
&gt; -=C2=A0 =C2=A0 else<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm TINFO &quot;Subsystem $subsystem =
is mounted at $mount_point&quot;<br>
&gt; -=C2=A0 =C2=A0 fi<br>
&gt; +=C2=A0 =C2=A0 cgroup_require &quot;$subsystem&quot;<br>
<br>
&gt; +=C2=A0 =C2=A0 mount_point=3D$(cgroup_get_mountpoint &quot;$subsystem&=
quot;)<br>
&gt; +=C2=A0 =C2=A0 start_path=3D$(cgroup_get_test_path &quot;$subsystem&qu=
ot;)<br>
&gt; +=C2=A0 =C2=A0 cgroup_v=3D$(cgroup_get_version &quot;$subsystem&quot;)=
<br>
&gt; +=C2=A0 =C2=A0 task_list=3D$(cgroup_get_task_list &quot;$subsystem&quo=
t;)<br>
<br>
Maybe declare these variables at the top of this file, because<br>
we hope to export and use them globally.<br>
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 [ &quot;$cgroup_v&quot; =3D &quot;V2&quot; ] &amp;&amp;=
 ROD echo &quot;+$subsystem&quot; \&gt; &quot;$start_path/cgroup.subtree_co=
ntrol&quot;<br>
<br>
Can we just do this in tst_cgctl.c automatically if it requires the<br>
subsystem on V2.<br>
(or at least move it to cgroup_lib.sh)<br>
Then people don&#39;t need to take care of this additionally.<br>
<br></blockquote><div><br></div><div><div>The only problem with this is tha=
t we assume that the user doesn&#39;t=20
want to use the test_dir as the directory to work in. If we write to=20
cgroup.subtree_control we cant add any processes to cgroup.procs in the=20
test_dir directory. <br></div><div><br></div><div>I think it would be=20
more intuitive to have the test_dir ready to be used as a leaf cgroup=20
dir and not assume it to be a parent. But thats honestly just a decision
 to make :)</div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
&gt; +=C2=A0 =C2=A0 tst_res TINFO &quot;test starts with cgroup $cgroup_v&q=
uot;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -cleanup()<br>
&gt; +common_cleanup()<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 tst_rmdir<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0 =C2=A0 killall -9 cgroup_fj_proc &gt;/dev/null 2&gt;&amp;=
1<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 tst_resm TINFO &quot;Removing all ltp subgroups...&quot=
;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 find &quot;$mount_point/ltp/&quot; -depth -type d -exec=
 rmdir &#39;{}&#39; \;<br>
&gt; +=C2=A0 =C2=A0 tst_res TINFO &quot;Removing all ltp subgroups...&quot;=
<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 if [ -z &quot;$try_umount&quot; ]; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
&gt; -=C2=A0 =C2=A0 fi<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 if grep -q &quot;$mount_point&quot; /proc/mounts; then<=
br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 EXPECT_PASS umount &quot;$mount_point&quo=
t;<br>
&gt; -=C2=A0 =C2=A0 fi<br>
&gt; +=C2=A0 =C2=A0 [ -d &quot;$start_path&quot; ] &amp;&amp; find &quot;$s=
tart_path&quot; -depth -type d -exec rmdir &#39;{}&#39; \;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 if [ -e &quot;$mount_point&quot; ]; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 EXPECT_PASS rmdir &quot;$mount_point&quot=
;<br>
&gt; -=C2=A0 =C2=A0 fi<br>
&gt; +=C2=A0 =C2=A0 cgroup_cleanup<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function=
.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh<br>
&gt; index fc3ad1b63..07373dcfe 100755<br>
&gt; --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh<br>
&gt; +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh<br>
&gt; @@ -1,30 +1,16 @@<br>
&gt;=C2=A0 #!/bin/sh<br>
&gt; -<br>
&gt; -#####################################################################=
###########<br>
&gt; -##=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## Copyright (c) 2009 FUJITSU LIMITED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0##<br>
&gt; -##=C2=A0 Author: Shi Weihua &lt;<a href=3D"mailto:shiwh@cn.fujitsu.co=
m" target=3D"_blank">shiwh@cn.fujitsu.com</a>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0##<br>
&gt; -## Copyright (c) 2015 Cedric Hnyda &lt;<a href=3D"mailto:chnyda@suse.=
com" target=3D"_blank">chnyda@suse.com</a>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## Copyright (c) 2015-2016 Cyril Hrubis &lt;<a href=3D"mailto:chrubis=
@suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0##<br>
&gt; -##=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## This program is free software;=C2=A0 you can redistribute it and#o=
r modify=C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## it under the terms of the GNU General Public License as published =
by=C2=A0 =C2=A0 =C2=A0 =C2=A0##<br>
&gt; -## the Free Software Foundation; either version 2 of the License, or=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## (at your option) any later version.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -##=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## This program is distributed in the hope that it will be useful, bu=
t=C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHAN=
TABILITY ##<br>
&gt; -## or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the GNU General Pub=
lic License=C2=A0 =C2=A0##<br>
&gt; -## for more details.=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 ##<br>
&gt; -##=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## You should have received a copy of the GNU General Public License=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -## along with this program;=C2=A0 if not, write to the Free Software =
Foundation,=C2=A0 =C2=A0##<br>
&gt; -## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0##<br>
&gt; -##=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ##<br>
&gt; -#####################################################################=
###########<br>
&gt; +# SPDX-License-Identifier: GPL-2.0-or-later<br>
&gt; +# Copyright (c) 2009 FUJITSU LIMITED<br>
&gt; +# Copyright (c) 2015 Cedric Hnyda &lt;<a href=3D"mailto:chnyda@suse.c=
om" target=3D"_blank">chnyda@suse.com</a>&gt;<br>
&gt; +# Copyright (c) 2015-2016 Cyril Hrubis &lt;<a href=3D"mailto:chrubis@=
suse.cz" target=3D"_blank">chrubis@suse.cz</a>&gt;<br>
&gt; +# Author: Shi Weihua &lt;<a href=3D"mailto:shiwh@cn.fujitsu.com" targ=
et=3D"_blank">shiwh@cn.fujitsu.com</a>&gt;<br>
&gt;<br>
&gt;=C2=A0 TCID=3D&quot;cgroup_fj_function2&quot;<br>
&gt; -TST_TOTAL=3D7<br>
&gt; +TST_TESTFUNC=3Dtest<br>
&gt; +TST_SETUP=3Dsetup<br>
&gt; +TST_CLEANUP=3Dcleanup<br>
&gt; +TST_CNT=3D9<br>
&gt; +TST_POS_ARGS=3D1<br>
&gt;<br>
&gt;=C2=A0 . cgroup_fj_common.sh<br>
&gt;<br>
&gt; @@ -36,7 +22,7 @@ usage_and_exit()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 echo &quot;=C2=A0 ./cgroup_fj_function2.sh subsyst=
em&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 echo &quot;example: ./cgroup_fj_function2.sh cpuse=
t&quot;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 tst_brkm TBROK &quot;$1&quot;<br>
&gt; +=C2=A0 =C2=A0 tst_brk TBROK &quot;$1&quot;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 if [ &quot;$#&quot; -ne &quot;1&quot; ]; then<br>
&gt; @@ -46,49 +32,67 @@ fi<br>
&gt;=C2=A0 # Move a task from group to group<br>
&gt;=C2=A0 test1()<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 # mv&#39;ing cgroups is not available in cgroup2<br>
&gt; +=C2=A0 =C2=A0 if [ &quot;$cgroup_v&quot; =3D &quot;V2&quot; ]; then<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TCONF &quot;Controller mounted on=
 cgroup2 hierachy, skipping test&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if ! attach_and_check &quot;$pid&quot; &quot;$star=
t_path/ltp_1&quot;; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm TFAIL &quot;Failed to atta=
ch task&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res TFAIL &quot;Failed to attac=
h task&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if ! attach_and_check &quot;$pid&quot; &quot;$star=
t_path&quot;; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_resm TFAIL &quot;Failed to atta=
ch task&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tst_res TFAIL &quot;Failed to attac=
h task&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 tst_resm TPASS &quot;Task attached succesfully&quot;<br=
>
&gt; +=C2=A0 =C2=A0 tst_res TPASS &quot;Task attached succesfully&quot;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 # Group can be renamed with mv<br>
&gt;=C2=A0 test2()<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 # mv&#39;ing cgroups is not available in cgroup2<br>
&gt; +=C2=A0 =C2=A0 if [ &quot;$cgroup_v&quot; =3D &quot;V2&quot; ]; then<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TCONF &quot;Controller mounted on=
 cgroup2 hierachy, skipping test&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 create_subgroup &quot;$start_path/ltp_2&quot;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if ! mv &quot;$start_path/ltp_2&quot; &quot;$start=
_path/ltp_3&quot;; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_resm TFAIL &quot;Failed to move $star=
t_path/ltp_2 to $start_path/ltp_3&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TFAIL &quot;Failed to move $start=
_path/ltp_2 to $start_path/ltp_3&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rmdir &quot;$start_path/ltp_2&quot;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if ! rmdir &quot;$start_path/ltp_3&quot;; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_resm TFAIL &quot;Failed to remove $st=
art_path/ltp_3&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TFAIL &quot;Failed to remove $sta=
rt_path/ltp_3&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 tst_resm TPASS &quot;Successfully moved $start_path/ltp=
_2 to $start_path/ltp_3&quot;<br>
&gt; +=C2=A0 =C2=A0 tst_res TPASS &quot;Successfully moved $start_path/ltp_=
2 to $start_path/ltp_3&quot;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 # Group can be renamed with mv unless the target name exists<br>
&gt;=C2=A0 test3()<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 # mv&#39;ing cgroups is not available in cgroup2<br>
&gt; +=C2=A0 =C2=A0 if [ &quot;$cgroup_v&quot; =3D &quot;V2&quot; ]; then<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TCONF &quot;Controller mounted on=
 cgroup2 hierachy, skipping test&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 create_subgroup &quot;$start_path/ltp_2&quot;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if mv &quot;$start_path/ltp_2&quot; &quot;$start_p=
ath/ltp_1&quot; &gt; /dev/null 2&gt;&amp;1; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_resm TFAIL &quot;Moved $start_path/lt=
p_2 over existing $start_path/ltp_1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TFAIL &quot;Moved $start_path/ltp=
_2 over existing $start_path/ltp_1&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 tst_resm TPASS &quot;Failed to move $start_path/ltp_2 o=
ver existing $start_path/ltp_1&quot;<br>
&gt; +=C2=A0 =C2=A0 tst_res TPASS &quot;Failed to move $start_path/ltp_2 ov=
er existing $start_path/ltp_1&quot;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ROD rmdir &quot;$start_path/ltp_2&quot;<br>
&gt;=C2=A0 }<br>
&gt; @@ -97,77 +101,104 @@ test3()<br>
&gt;=C2=A0 test4()<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if ! attach_and_check &quot;$pid&quot; &quot;$star=
t_path/ltp_1&quot;; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_resm TFAIL &quot;Failed to attach $pi=
d to $start_path/ltp_1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TFAIL &quot;Failed to attach $pid=
 to $start_path/ltp_1&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if rmdir &quot;$start_path/ltp_1&quot; &gt; /dev/n=
ull 2&gt;&amp;1; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_resm TFAIL &quot;Removed $start_path/=
ltp_1 which contains task $pid&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 create_subgroup &quot;$start_path/ltp_1&q=
uot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TFAIL &quot;Removed $start_path/l=
tp_1 which contains task $pid&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 tst_resm TPASS &quot;Group $start_path/ltp_1 with task =
$pid cannot be removed&quot;<br>
&gt; +=C2=A0 =C2=A0 tst_res TPASS &quot;Group $start_path/ltp_1 with task $=
pid cannot be removed&quot;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 # Group with a subgroup cannot be removed<br>
&gt;=C2=A0 test5()<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 # We need to move the tasks back to root to create a su=
bgroup<br>
&gt; +=C2=A0 =C2=A0 if [ &quot;$cgroup_v&quot; =3D &quot;V2&quot; ]; then<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for pid in $(cat &quot;$start_path/ltp_1/=
$task_list&quot;); do<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
echo $pid &gt; &quot;$mount_point/$task_list&quot; 2&gt; /dev/null<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0done<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 ROD echo &quot;+$subsystem&quot; \&gt; &q=
uot;$start_path/ltp_1/cgroup.subtree_control&quot;<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 create_subgroup &quot;$start_path/ltp_1/a&quot;<br=
>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if rmdir &quot;$start_path/ltp_1&quot; &gt; /dev/n=
ull 2&gt;&amp;1; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_resm TFAIL &quot;Removed $start_path/=
ltp_1 which contains subdir &#39;a&#39;&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TFAIL &quot;Removed $start_path/l=
tp_1 which contains subdir &#39;a&#39;&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 tst_resm TPASS &quot;Dir $start_path/ltp_1 with subdir =
&#39;a&#39; cannot be removed&quot;<br>
&gt; +=C2=A0 =C2=A0 tst_res TPASS &quot;Dir $start_path/ltp_1 with subdir &=
#39;a&#39; cannot be removed&quot;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ROD rmdir &quot;$start_path/ltp_1/a&quot;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 ROD echo &quot;$pid&quot; \&gt; &quot;$start_path/tasks=
&quot;<br>
&gt; +=C2=A0 =C2=A0 [ &quot;$cgroup_v&quot; =3D &quot;V2&quot; ] &amp;&amp;=
 ROD echo &quot;-$subsystem&quot; \&gt; &quot;$start_path/ltp_1/cgroup.subt=
ree_control&quot;<br>
&gt; +=C2=A0 =C2=A0 ROD echo &quot;$pid&quot; \&gt; &quot;$start_path/ltp_1=
/$task_list&quot;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 # Group cannot be moved outside of hierarchy<br>
&gt;=C2=A0 test6()<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 # mv&#39;ing cgroups is not available in cgroup2<br>
&gt; +=C2=A0 =C2=A0 if [ &quot;$cgroup_v&quot; =3D &quot;V2&quot; ]; then<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TCONF &quot;Controller mounted on=
 cgroup2 hierachy, skipping test&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if mv &quot;$start_path/ltp_1&quot; &quot;$PWD/ltp=
&quot; &gt; /dev/null 2&gt;&amp;1; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_resm TFAIL &quot;Subgroup $start_path=
/ltp_1 outside hierarchy to $PWD/ltp&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TFAIL &quot;Subgroup $start_path/=
ltp_1 outside hierarchy to $PWD/ltp&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 tst_resm TPASS &quot;Subgroup $start_path/ltp_1 cannot =
be moved to $PWD/ltp&quot;<br>
&gt; +=C2=A0 =C2=A0 tst_res TPASS &quot;Subgroup $start_path/ltp_1 cannot b=
e moved to $PWD/ltp&quot;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 # Tasks file cannot be removed<br>
&gt;=C2=A0 test7()<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 if rm &quot;$start_path/ltp_1/tasks&quot; &gt; /dev/nul=
l 2&gt;&amp;1; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_resm TFAIL &quot;Tasks file $start_pa=
th/ltp_1/tasks could be removed&quot;<br>
&gt; +=C2=A0 =C2=A0 if rm &quot;$start_path/ltp_1/$task_list&quot; &gt; /de=
v/null 2&gt;&amp;1; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TFAIL &quot;Tasks file $start_pat=
h/ltp_1/$task_list could be removed&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 tst_resm TPASS &quot;Tasks file $start_path/ltp_1/tasks=
 cannot be removed&quot;<br>
&gt; +=C2=A0 =C2=A0 tst_res TPASS &quot;Tasks file $start_path/ltp_1/tasks =
cannot be removed&quot;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 # Test notify_on_release with invalid inputs<br>
&gt;=C2=A0 test8()<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 # notify_on_release is not available in cgroup2 so skip=
 the test<br>
&gt; +=C2=A0 =C2=A0 if [ &quot;$cgroup_v&quot; =3D &quot;V2&quot; ]; then<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TCONF &quot;Controller mounted on=
 cgroup2 hierachy, skipping test&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if echo &quot;-1&quot; &gt; &quot;$start_path/ltp_=
1/notify_on_release&quot; 2&gt;/dev/null; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_resm TFAIL &quot;Can write -1 to $sta=
rt_path/ltp_1/notify_on_release&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TFAIL &quot;Can write -1 to $star=
t_path/ltp_1/notify_on_release&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if echo &quot;ltp&quot; &gt; &quot;$start_path/ltp=
_1/notify_on_release&quot; 2&gt;/dev/null; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_resm TFAIL &quot;Can write ltp to $st=
art_path/ltp_1/notify_on_release&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TFAIL &quot;Can write ltp to $sta=
rt_path/ltp_1/notify_on_release&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 tst_resm TPASS &quot;Cannot write invalid values to $st=
art_path/ltp_1/notify_on_release&quot;<br>
&gt; +=C2=A0 =C2=A0 tst_res TPASS &quot;Cannot write invalid values to $sta=
rt_path/ltp_1/notify_on_release&quot;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt;=C2=A0 # Test that notify_on_release can be changed<br>
&gt;=C2=A0 test9()<br>
&gt;=C2=A0 {<br>
&gt; +=C2=A0 =C2=A0 # notify_on_release is not available in cgroup2 so skip=
 the test<br>
&gt; +=C2=A0 =C2=A0 if [ &quot;$cgroup_v&quot; =3D &quot;V2&quot; ]; then<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TCONF &quot;Controller mounted on=
 cgroup2 hierachy, skipping test&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt; +=C2=A0 =C2=A0 fi<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 local notify=3D$(ROD cat &quot;$start_path/ltp_1/n=
otify_on_release&quot;)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 local value<br>
&gt;<br>
&gt; @@ -178,37 +209,29 @@ test9()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if ! echo &quot;$value&quot; &gt; &quot;$start_pat=
h/ltp_1/notify_on_release&quot;; then<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_resm TFAIL &quot;Failed to set $start=
_path/ltp_1/notify_on_release to $value&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 tst_res TFAIL &quot;Failed to set $start_=
path/ltp_1/notify_on_release to $value&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return<br>
&gt;=C2=A0 =C2=A0 =C2=A0 fi<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ROD echo &quot;$notify&quot; \&gt; &quot;$start_pa=
th/ltp_1/notify_on_release&quot;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 tst_resm TPASS &quot;Set $start_path/ltp_1/notify_on_re=
lease to $value&quot;<br>
&gt; +=C2=A0 =C2=A0 tst_res TPASS &quot;Set $start_path/ltp_1/notify_on_rel=
ease to $value&quot;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -setup<br>
&gt; -<br>
&gt; -cgroup_fj_proc&amp;<br>
&gt; -pid=3D$!<br>
&gt; -<br>
&gt; -start_path=3D&quot;$mount_point/ltp&quot;<br>
&gt; -<br>
&gt; -create_subgroup &quot;$start_path&quot;<br>
&gt; -create_subgroup &quot;$start_path/ltp_1&quot;<br>
&gt; -<br>
&gt; -test1<br>
&gt; -test2<br>
&gt; -test3<br>
&gt; -test4<br>
&gt; -test5<br>
&gt; -test6<br>
&gt; -test7<br>
&gt; -test8<br>
&gt; -test9<br>
&gt; +setup()<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 common_setup<br>
&gt; +=C2=A0 =C2=A0 cgroup_fj_proc&amp;<br>
&gt; +=C2=A0 =C2=A0 pid=3D$!<br>
&gt; +=C2=A0 =C2=A0 create_subgroup &quot;$start_path/ltp_1&quot;<br>
&gt; +}<br>
<br>
<br>
Btw, I got a TBROK when running the &quot;cgroup_fj_function.sh blkio&quot;=
, but this<br>
looks not related to your patch, I&#39;ll try to look into the problem.<br>
<br>
--------------<br>
tst_cgroup.c:829: TINFO: Could not mount V1 CGroup on<br>
/tmp/cgroup_blkio: EBUSY (16)<br>
tst_cgroup.c:932: TCONF: &#39;blkio&#39; controller required, but not avail=
able<br>
cgroup_fj_function 1 TBROK: cgroup_require: No state was set after<br>
call. Controller &#39;blkio&#39; maybe does not exist?<br>
<br>
<br></blockquote><div><br></div><div>Yes this is the blkio/io controller pr=
oblem Richard mentioned earlier and doesent have anything to do with these =
patches. <br></div><div><br></div><div>Thanks, <br></div><div><br></div><di=
v>-=C2=A0 Luke<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
-- <br>
Regards,<br>
Li Wang<br>
<br>
</blockquote></div></div>

--00000000000059e69a05d944d4ac--

--===============0470758185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp

--===============0470758185==--
