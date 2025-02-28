Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC7EC19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 13:06:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5350E3C9CA9
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 14:06:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87A4F3C2781
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 14:06:27 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 78F7E6617E0
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 14:06:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 57E441F37E;
 Fri, 28 Feb 2025 13:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740747985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7jKNuiXLwve+R0B1rbXdA8Fg6iail5XU80h7dorHYqo=;
 b=gEvrsFrwdgFnGDuDIf8AssTNhLa3Cw8s/YDnZFN5aVAKyOmLOXfrnuG0JTOu6YpRjzs6ST
 yRC9BwB4U3mwItDgasOoMwVy3I1uxJvbJOQwZDIrvp1YKLds4g2pz9eFnLJaJ0oluXflCn
 NCn8iQ50sERyifUn4TPLUKVRm1ICbuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740747985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7jKNuiXLwve+R0B1rbXdA8Fg6iail5XU80h7dorHYqo=;
 b=HU0xTpeMLpcHoZ8AHCBxKPuuFcrjBkOrvEzAPmho0CNhH7WJcrGQ27gHY2pCgxcVdA8Aqu
 ErWZz9OR+2HM6NCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740747985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7jKNuiXLwve+R0B1rbXdA8Fg6iail5XU80h7dorHYqo=;
 b=gEvrsFrwdgFnGDuDIf8AssTNhLa3Cw8s/YDnZFN5aVAKyOmLOXfrnuG0JTOu6YpRjzs6ST
 yRC9BwB4U3mwItDgasOoMwVy3I1uxJvbJOQwZDIrvp1YKLds4g2pz9eFnLJaJ0oluXflCn
 NCn8iQ50sERyifUn4TPLUKVRm1ICbuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740747985;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7jKNuiXLwve+R0B1rbXdA8Fg6iail5XU80h7dorHYqo=;
 b=HU0xTpeMLpcHoZ8AHCBxKPuuFcrjBkOrvEzAPmho0CNhH7WJcrGQ27gHY2pCgxcVdA8Aqu
 ErWZz9OR+2HM6NCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3AEE1344A;
 Fri, 28 Feb 2025 13:06:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k7jDMtC0wWerGQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 28 Feb 2025 13:06:24 +0000
Date: Fri, 28 Feb 2025 14:06:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <20250228130619.GB3222454@pevik>
References: <20250227183359.918722-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250227183359.918722-1-cristian.marussi@arm.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_fj_commmon.sh: Avoid explicitly disabling
 controllers on cleanup
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: aishwarya.tcv@arm.com, Michal =?iso-8859-2?Q?Koutn=FD?= <mkoutny@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

[ Cc Way and Li (1204b1d853), Cyril and Michal (the cgroup expert) ]

> The cgroup_cleanup helper, called by common_cleanup, takes already care
> to remove/disable all the subsystems that were previously enabled using
> the complementary cgroup_require helper, for the sake of testing.

> Doing it also explicitly after cgroup_cleanup has been called, causes a
> WARN that makes all cgroup_fj tests to fail.

>   cgroup_fj_function 10 TINFO: Removing all ltp subgroups...
>   tst_rod: Failed to open /sys/fs/cgroup/cgroup.subtree_control for writing: Read-only file system
>   cgroup_fj_function 10 TWARN: echo -cpuset > /sys/fs/cgroup/cgroup.subtree_control failed

cgroup_fj_common.sh has TST_NEEDS_ROOT=1, it checks for root. It might be some bug in the test.

nit: it looks like you're trying to revert 1204b1d853, right? If the code is
really broken, it would be:

Fixes: 1204b1d853 ("cgroup_fj_common.sh: Disable cgroup controller in cleanup function")

I guess you run cgroup_fj_function.sh cpuset, right? I was not able to reproduce
the problem on some old (unupdated) Debian GNU/Linux 11 (bullseye), nor on
Tumbleweed, nor on SLE15-SP4:

=== Debian GNU/Linux 11 (bullseye) ===
$ mount |grep cgroup
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)

$ ls /sys/fs/cgroup/cgroup.controllers
/sys/fs/cgroup/cgroup.controllers

$ grep cgroup /proc/cmdline # nothing (obviously)

$ dpkg -l systemd
ii  systemd        247.3-6      amd64        system and service manager

$ uname -r
5.10.0-28-amd64

# PATH="/opt/ltp/testcases/bin/:$PATH" cgroup_fj_function.sh cpuset
cgroup_fj_function 1 TINFO: Running: cgroup_fj_function.sh cpuset
cgroup_fj_function 1 TINFO: Tested kernel: Linux ds 5.10.0-28-amd64 #1 SMP Debian 5.10.209-2 (2024-01-31) x86_64 GNU/Linux
cgroup_fj_function 1 TINFO: Using /tmp/LTP_cgroup_fj_function.m7y4JnrU32 as tmpdir (ext2/ext3 filesystem)
cgroup_fj_function 1 TINFO: timeout per run is 0h 5m 0s
cgroup_fj_function 1 TINFO: test starts with cgroup version 2
cgroup_fj_function 1 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 2 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 3 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 4 TINFO: Attaching task 1850 to /sys/fs/cgroup/ltp/test-1800/ltp_1
cgroup_fj_function 4 TPASS: Group /sys/fs/cgroup/ltp/test-1800/ltp_1 with task 1850 cannot be removed
cgroup_fj_function 5 TPASS: Dir /sys/fs/cgroup/ltp/test-1800/ltp_1 with subdir 'a' cannot be removed
cgroup_fj_function 6 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 7 TPASS: Tasks file /sys/fs/cgroup/ltp/test-1800/ltp_1/tasks cannot be removed
cgroup_fj_function 8 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 9 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 10 TINFO: Removing all ltp subgroups...

Summary:
passed   3
failed   0
broken   0
skipped  6
warnings 0

=== openSUSE Tumbleweed ===
$ mount |grep cgroup
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)

$ ls /sys/fs/cgroup/cgroup.controllers
/sys/fs/cgroup/cgroup.controllers

$ grep cgroup /proc/cmdline # nothing (obviously)

$ uname -r
6.14.0-rc3-1.gb6b4102-default

$ rpm -q systemd
systemd-256.10-2.2.x86_64

# PATH="/opt/ltp/testcases/bin/:$PATH" cgroup_fj_function.sh cpuset
cgroup_fj_function 1 TINFO: Running: cgroup_fj_function.sh cpuset
cgroup_fj_function 1 TINFO: Tested kernel: Linux ts 6.14.0-rc3-1.gb6b4102-default #1 SMP PREEMPT_DYNAMIC Thu Feb 20 12:26:55 UTC 2025 (b6b4102) x86_64 x86_64 x86_64 GNU/Linux
cgroup_fj_function 1 TINFO: Using /tmp/LTP_cgroup_fj_function.6HznnEZMIo as tmpdir (tmpfs filesystem)
cgroup_fj_function 1 TINFO: timeout per run is 0h 5m 0s
cgroup_fj_function 1 TINFO: test starts with cgroup version 2
cgroup_fj_function 1 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 2 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 3 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 4 TINFO: Attaching task 3268 to /sys/fs/cgroup/ltp/test-3220/ltp_1
cgroup_fj_function 4 TPASS: Group /sys/fs/cgroup/ltp/test-3220/ltp_1 with task 3268 cannot be removed
cgroup_fj_function 5 TPASS: Dir /sys/fs/cgroup/ltp/test-3220/ltp_1 with subdir 'a' cannot be removed
cgroup_fj_function 6 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 7 TPASS: Tasks file /sys/fs/cgroup/ltp/test-3220/ltp_1/tasks cannot be removed
cgroup_fj_function 8 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 9 TCONF: Controller mounted on cgroup2 hierarchy, skipping test
cgroup_fj_function 10 TINFO: Removing all ltp subgroups...

Summary:
passed   3
failed   0
broken   0
skipped  6
warnings 0

=== SUSE Linux Enterprise Server 15 SP4 ===
$ mount |grep cgroup # 
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,size=4096k,nr_inodes=1024,mode=755,inode64)
cgroup2 on /sys/fs/cgroup/unified type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate)
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,name=systemd)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,freezer)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,perf_event)
cgroup on /sys/fs/cgroup/rdma type cgroup (rw,nosuid,nodev,noexec,relatime,rdma)
cgroup on /sys/fs/cgroup/misc type cgroup (rw,nosuid,nodev,noexec,relatime,misc)
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpu,cpuacct)
cgroup on /sys/fs/cgroup/net_cls,net_prio type cgroup (rw,nosuid,nodev,noexec,relatime,net_cls,net_prio)
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,nosuid,nodev,noexec,relatime,hugetlb)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,pids)
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset)
cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,memory)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,blkio)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,devices)

$ ls /sys/fs/cgroup/cgroup.controllers
ls: cannot access '/sys/fs/cgroup/cgroup.controllers': No such file or directory

$ grep cgroup /proc/cmdline # nothing, due v1 + v2? But what sets both?

$ uname -r
5.14.21-...

$ rpm -q systemd
systemd-249.15-*

# PATH="/opt/ltp/testcases/bin/:$PATH" cgroup_fj_function.sh cpuset
cgroup_fj_function 1 TINFO: Running: cgroup_fj_function.sh cpuset
cgroup_fj_function 1 TINFO: Tested kernel: Linux s4 5.14.21-150400.24.49-default #1 SMP PREEMPT_DYNAMIC Tue Mar 7 08:07:05 UTC 2023 (bad820e) x86_64 x86_64 x86_64 GNU/Linux
cgroup_fj_function 1 TINFO: Using /tmp/LTP_cgroup_fj_function.U0V6xiD1hU as tmpdir (btrfs filesystem)
cgroup_fj_function 1 TINFO: timeout per run is 0h 5m 0s
cgroup_fj_function 1 TINFO: test starts with cgroup version 1
cgroup_fj_function 1 TINFO: Attaching task 2809 to /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1
cgroup_fj_function 1 TINFO: Attaching task 2809 to /sys/fs/cgroup/cpuset/ltp/test-2759
cgroup_fj_function 1 TPASS: Task attached successfully
cgroup_fj_function 2 TPASS: Successfully moved /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_2 to /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_3
cgroup_fj_function 3 TPASS: Failed to move /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_2 over existing /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1
cgroup_fj_function 4 TINFO: Attaching task 2809 to /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1
cgroup_fj_function 4 TPASS: Group /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1 with task 2809 cannot be removed
cgroup_fj_function 5 TPASS: Dir /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1 with subdir 'a' cannot be removed
cgroup_fj_function 6 TPASS: Subgroup /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1 cannot be moved to /tmp/LTP_cgroup_fj_function.U0V6xiD1hU/ltp
cgroup_fj_function 7 TPASS: Tasks file /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1/tasks cannot be removed
cgroup_fj_function 8 TPASS: Cannot write invalid values to /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1/notify_on_release
cgroup_fj_function 9 TPASS: Set /sys/fs/cgroup/cpuset/ltp/test-2759/ltp_1/notify_on_release to 1
cgroup_fj_function 10 TINFO: Removing all ltp subgroups...

Summary:
passed   9
failed   0
broken   0
skipped  0
warnings 0

> Observed on a Debian Bullseye with systemd using by default cgroup_V1:
> in such a case the cgroup_require/cleanup helpers take care to create and
> cleanup the cgroup_V2 needed by the testcase, but fail to cleamup for
> the above reasons.

As shown above and also from from runc doc [1] it is obvious that Bullseye already
uses cgroup v2. How do you force v1? That is not the default behavior, right?

@Wei, do you remember which SLES version required to to disable the tests?
Important is which cgroup version it uses and maybe kernel and systemd version.

Kind regards,
Petr

[1] https://github.com/opencontainers/runc/blob/main/docs/cgroup-v2.md

> Cc: Petr Vorel <pvorel@suse.cz>
> Cc: Ma Xinjian <maxj.fnst@fujitsu.com>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Tried to add also cpuset to the set of skipped subsystem for cgroup_V2
> and it worked but it did feel like the proper solution: digging a bit
> into the cgroup helper and debugging the testcase I came to realize that
> there was nothinhg to remove/disable left after cgroup_cleanup...

> ...thoughts ?
> ---
>  .../kernel/controllers/cgroup_fj/cgroup_fj_common.sh      | 8 --------
>  1 file changed, 8 deletions(-)

> diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> index 153d351d7..6d5586534 100755
> --- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> +++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
> @@ -76,14 +76,6 @@ common_cleanup()
>      [ -d "$start_path" ] && find "$start_path" -depth -type d -exec rmdir '{}' \;

>      cgroup_cleanup
> -
> -    if [ "$cgroup_version" = "2" ]; then
> -        case "$subsystem" in
> -        cpu|io|memory|pids)
> -            :;;
> -        *) ROD echo "-$subsystem" \> "/sys/fs/cgroup/cgroup.subtree_control";;
> -        esac
> -    fi


>  }

>  . cgroup_lib.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
