Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5D3D2E9E0
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 12:08:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 298C53D5463
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 13:08:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A9903D2B47
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 13:08:15 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 91BB4613004
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 13:08:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD7DD1F38E;
 Mon, 11 Nov 2024 12:08:12 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD4A413301;
 Mon, 11 Nov 2024 12:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MsnrLazzMWcHOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 11 Nov 2024 12:08:12 +0000
Date: Mon, 11 Nov 2024 13:08:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZzHzs-jVLwurbLm0@yuki.lan>
References: <20241108053710.8639-1-wegao@suse.com> <Zy3fh5YZeJ5djPt3@yuki.lan>
 <Zy30Vzk/14/GaEVk@wegao> <Zy30xPImjjRMKnC0@yuki.lan>
 <ZzFwK5nP+cegx2fK@wegao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZzFwK5nP+cegx2fK@wegao>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: DD7DD1F38E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_cgroup.c: Force tst_cg_scan only scan
 specific cgroup version if needs_ver exist
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
Cc: mkoutny@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> On sle-micro 6.1, you can mount v1 controller when it was already mounted under v2
> And after you force mount v1 cpuset controller, the v2 cpuset controller will be removed
>
> localhost:~ # mount | grep cgroup
> cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
> 
> localhost:~ # ll /sys/fs/cgroup/
> total 0
> -r--r--r--  1 root root 0 Nov 11 01:39 cgroup.controllers
> -rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.max.depth
> -rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.max.descendants
> -rw-r--r--  1 root root 0 Nov 11 01:39 cgroup.procs
> -r--r--r--  1 root root 0 Nov 11 01:44 cgroup.stat
> -rw-r--r--  1 root root 0 Nov 11 01:39 cgroup.subtree_control
> -rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.threads
> -r--r--r--  1 root root 0 Nov 11 01:44 cpu.stat
> -r--r--r--  1 root root 0 Nov 11 01:44 cpu.stat.local
> -r--r--r--  1 root root 0 Nov 11 01:44 cpuset.cpus.effective  <<<<
> -r--r--r--  1 root root 0 Nov 11 01:44 cpuset.mems.effective  <<<<
> drwxr-xr-x  2 root root 0 Nov 11 01:39 dev-hugepages.mount
> drwxr-xr-x  2 root root 0 Nov 11 01:39 dev-mqueue.mount
> drwxr-xr-x  2 root root 0 Nov 11 01:39 init.scope
> -rw-r--r--  1 root root 0 Nov 11 01:44 io.cost.model
> -rw-r--r--  1 root root 0 Nov 11 01:44 io.cost.qos
> -r--r--r--  1 root root 0 Nov 11 01:44 io.stat
> drwxr-xr-x  2 root root 0 Nov 11 01:39 machine.slice
> -r--r--r--  1 root root 0 Nov 11 01:44 memory.numa_stat
> --w-------  1 root root 0 Nov 11 01:44 memory.reclaim
> -r--r--r--  1 root root 0 Nov 11 01:44 memory.stat
> -r--r--r--  1 root root 0 Nov 11 01:44 misc.capacity
> drwxr-xr-x  2 root root 0 Nov 11 01:39 proc-fs-nfsd.mount
> drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-fs-fuse-connections.mount
> drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-kernel-config.mount
> drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-kernel-debug.mount
> drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-kernel-tracing.mount
> drwxr-xr-x 40 root root 0 Nov 11 01:42 system.slice
> drwxr-xr-x  2 root root 0 Nov 11 01:39 user.slice
> 
> localhost:/tmp # mkdir /var/tmp/cpuset
> localhost:/tmp # mount -t cgroup -o cpuset cpuset /var/tmp/cpuset  <<<<<<

You are supposed to get an error here, at least that is what I thought.

I do get error here on vanilla 6.10 but on debian 6.1 the mount succeeds
as well. CCing Michal.

Michal I was under an impression that a controller that has been bound
to v2 cannot be removed from there and bound to v1 anymore, but it seems
that it may happen in some cases.

> localhost:/tmp # ll /var/tmp/cpuset/
> total 0
> -rw-r--r-- 1 root root 0 Nov 11 01:53 cgroup.clone_children
> -rw-r--r-- 1 root root 0 Nov 11 01:53 cgroup.procs
> -r--r--r-- 1 root root 0 Nov 11 01:53 cgroup.sane_behavior
> -rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.cpu_exclusive
> -rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.cpus
> -r--r--r-- 1 root root 0 Nov 11 01:53 cpuset.effective_cpus
> -r--r--r-- 1 root root 0 Nov 11 01:53 cpuset.effective_mems
> -rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.mem_exclusive
> -rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.mem_hardwall
> -rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.memory_migrate
> -r--r--r-- 1 root root 0 Nov 11 01:53 cpuset.memory_pressure
> -rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.memory_pressure_enabled
> -rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.memory_spread_page
> -rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.memory_spread_slab
> -rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.mems
> -rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.sched_load_balance <<<<<<
> -rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.sched_relax_domain_level
> -rw-r--r-- 1 root root 0 Nov 11 01:53 notify_on_release
> -rw-r--r-- 1 root root 0 Nov 11 01:53 release_agent
> -rw-r--r-- 1 root root 0 Nov 11 01:53 tasks
> 
> localhost:/tmp # ll /sys/fs/cgroup/
> total 0
> -r--r--r--  1 root root 0 Nov 11 01:44 cgroup.controllers
> -rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.max.depth
> -rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.max.descendants
> -rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.procs
> -r--r--r--  1 root root 0 Nov 11 01:44 cgroup.stat
> -rw-r--r--  1 root root 0 Nov 11 01:39 cgroup.subtree_control
> -rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.threads
> -r--r--r--  1 root root 0 Nov 11 01:44 cpu.stat
> -r--r--r--  1 root root 0 Nov 11 01:44 cpu.stat.local
> drwxr-xr-x  2 root root 0 Nov 11 01:39 dev-hugepages.mount
> drwxr-xr-x  2 root root 0 Nov 11 01:39 dev-mqueue.mount
> drwxr-xr-x  2 root root 0 Nov 11 01:39 init.scope
> -rw-r--r--  1 root root 0 Nov 11 01:44 io.cost.model
> -rw-r--r--  1 root root 0 Nov 11 01:44 io.cost.qos
> -r--r--r--  1 root root 0 Nov 11 01:44 io.stat
> drwxr-xr-x  2 root root 0 Nov 11 01:39 machine.slice
> -r--r--r--  1 root root 0 Nov 11 01:44 memory.numa_stat
> --w-------  1 root root 0 Nov 11 01:44 memory.reclaim
> -r--r--r--  1 root root 0 Nov 11 01:44 memory.stat
> -r--r--r--  1 root root 0 Nov 11 01:44 misc.capacity
> drwxr-xr-x  2 root root 0 Nov 11 01:39 proc-fs-nfsd.mount
> drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-fs-fuse-connections.mount
> drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-kernel-config.mount
> drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-kernel-debug.mount
> drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-kernel-tracing.mount
> drwxr-xr-x 40 root root 0 Nov 11 02:01 system.slice
> drwxr-xr-x  2 root root 0 Nov 11 01:39 user.slice
> 
> localhost:/tmp # mount | grep cgroup
> cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
> cpuset on /var/tmp/cpuset type cgroup (rw,relatime,cpuset)

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
