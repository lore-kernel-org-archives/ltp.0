Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57FAD12D52
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 02:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731293254; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=VmXxidHBgMpvUU8f1IbcuSsyjSTqASWT2MH8RsWV4L0=;
 b=nmS1SVtlClCDn+ln/HAPe/hvNzYX3226wUBNU08EB9YCI6GLen24hvsaRKnSmx4hgS73r
 9UqqmXj0fLM+B8GGIXyHHgrz8kI51bLWuktgsmYq14W9UpWPl7ZEUzwZLuUPwD1+0d0eZb+
 m9qlq8zgDHL7lLKXPpo5E6YPXPuJJY0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD9303D2AE4
	for <ltp@archiver.kernel.org>; Mon, 11 Nov 2024 03:47:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EEC33D2ACF
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 03:47:13 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2779324DE3A
 for <ltp@lists.linux.it>; Mon, 11 Nov 2024 03:47:13 +0100 (CET)
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-539f6e1f756so4342507e87.0
 for <ltp@lists.linux.it>; Sun, 10 Nov 2024 18:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731293232; x=1731898032; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HM7lg68IFaJa02iNTHPghZCGf+97UmW5qeGTWHm9yQc=;
 b=QirYas3ffucI29nDPscMHkEKH0XzeY/mOwQkyPXILY8ATBE/AOl0chAtV8BsCTrmjE
 ++0ff6qoDlCHEEKsjPjfWajpV6WiqYmdfAYqbVDSA8RQJChp2J9Nd4LPNIBAoK4J+L7W
 ukFUOdDqu29r5pZKIiVblkPiIm96UUbGWDRzZGoeWUhd2wbOYErYp+4lcv+2j6uRKsw0
 m/0ATGUaGjy8enHHhG+p9W7YeqRO4/uV4wRuh5uy5JlnN4h5KR13Mk/riNKYrqVQslgu
 Lo3/QyKqkXmI/xybRyYArsSAinBXJ77L8WmmjbSmGKFs6jWQ4TxKUnu7+fdbiV4V4HLo
 pEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731293232; x=1731898032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HM7lg68IFaJa02iNTHPghZCGf+97UmW5qeGTWHm9yQc=;
 b=vMYOSy87ajZOhy1e21bhi9PbuqMByK7Ac2AzN+6/qMlVPbzFs42VnLRTqGG7Vi+XwK
 6Nid/VB5kaH6qp0Witpbi5BHe/MG9oYGrks9UWatmdVEZtdenbBpLcV2c7gQ9iMBNqjH
 yYSJ+pslkB7wOxK6bpBEClHr/kOERl+GpHffiPr+vI+clvuFEwLH8Av1CTUAudoqZaDv
 yJRKHvrc9TuvkFdBppvwlcTjmnqOPhJSfR+uSTMExrd7BGkHD84y7QPvPSuw+ioa/UCk
 WFX0NavmBpgFndj+UddktLbjEoSEX72qIYeFo/2uUrP/SOlpVTFcbz8A3YrpYT6Y7WK3
 f4aw==
X-Gm-Message-State: AOJu0YzhFBbsxCDzRAasoY0PTltvUr7XheHQjSB6bJELXPlEvngCmyOD
 2dHTgG5iAep24n+GKEoaIL1enX8xgx92AzGkEVZB7FTPLQQT8EnRDy68Dw3gXQ==
X-Google-Smtp-Source: AGHT+IHac+apCJXMADDPPRmZOgWoQwzV09gyYfn2kYP1Bgr2YGmFYoRvOmA1NNFN8qzl4ssPmLJD1w==
X-Received: by 2002:a05:6512:ac3:b0:539:fd10:f07b with SMTP id
 2adb3069b0e04-53d862f82d5mr4313258e87.55.1731293231982; 
 Sun, 10 Nov 2024 18:47:11 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21177dc3f3asm66269535ad.3.2024.11.10.18.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Nov 2024 18:47:11 -0800 (PST)
Date: Sun, 10 Nov 2024 21:47:07 -0500
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZzFwK5nP+cegx2fK@wegao>
References: <20241108053710.8639-1-wegao@suse.com> <Zy3fh5YZeJ5djPt3@yuki.lan>
 <Zy30Vzk/14/GaEVk@wegao> <Zy30xPImjjRMKnC0@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zy30xPImjjRMKnC0@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Nov 08, 2024 at 12:23:48PM +0100, Cyril Hrubis wrote:
> Hi!
> > If you add .needs_cgroup_ver = TST_CG_V1 in cpuset02.c and running on sle-micro you will hit
> > https://github.com/linux-test-project/ltp/blob/6408294d83682635393e36c14bbd6ebd94fead94/lib/tst_cgroup.c#L892
> > 
> > Since sle-micro platform already create cgroupv2 mount point, the tst_cg_scan will get cgroupv2 info and
> > will not call cgroup_mount_v1.
> 
> And that is, as far as I can tell, correct. You cannot mount a
> controller under v1 when it was already mounted under v2.
On sle-micro 6.1, you can mount v1 controller when it was already mounted under v2
And after you force mount v1 cpuset controller, the v2 cpuset controller will be removed

localhost:~ # mount | grep cgroup
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)

localhost:~ # ll /sys/fs/cgroup/
total 0
-r--r--r--  1 root root 0 Nov 11 01:39 cgroup.controllers
-rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.max.depth
-rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.max.descendants
-rw-r--r--  1 root root 0 Nov 11 01:39 cgroup.procs
-r--r--r--  1 root root 0 Nov 11 01:44 cgroup.stat
-rw-r--r--  1 root root 0 Nov 11 01:39 cgroup.subtree_control
-rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.threads
-r--r--r--  1 root root 0 Nov 11 01:44 cpu.stat
-r--r--r--  1 root root 0 Nov 11 01:44 cpu.stat.local
-r--r--r--  1 root root 0 Nov 11 01:44 cpuset.cpus.effective  <<<<
-r--r--r--  1 root root 0 Nov 11 01:44 cpuset.mems.effective  <<<<
drwxr-xr-x  2 root root 0 Nov 11 01:39 dev-hugepages.mount
drwxr-xr-x  2 root root 0 Nov 11 01:39 dev-mqueue.mount
drwxr-xr-x  2 root root 0 Nov 11 01:39 init.scope
-rw-r--r--  1 root root 0 Nov 11 01:44 io.cost.model
-rw-r--r--  1 root root 0 Nov 11 01:44 io.cost.qos
-r--r--r--  1 root root 0 Nov 11 01:44 io.stat
drwxr-xr-x  2 root root 0 Nov 11 01:39 machine.slice
-r--r--r--  1 root root 0 Nov 11 01:44 memory.numa_stat
--w-------  1 root root 0 Nov 11 01:44 memory.reclaim
-r--r--r--  1 root root 0 Nov 11 01:44 memory.stat
-r--r--r--  1 root root 0 Nov 11 01:44 misc.capacity
drwxr-xr-x  2 root root 0 Nov 11 01:39 proc-fs-nfsd.mount
drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-fs-fuse-connections.mount
drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-kernel-config.mount
drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-kernel-debug.mount
drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-kernel-tracing.mount
drwxr-xr-x 40 root root 0 Nov 11 01:42 system.slice
drwxr-xr-x  2 root root 0 Nov 11 01:39 user.slice

localhost:/tmp # mkdir /var/tmp/cpuset
localhost:/tmp # mount -t cgroup -o cpuset cpuset /var/tmp/cpuset  <<<<<<
localhost:/tmp # ll /var/tmp/cpuset/
total 0
-rw-r--r-- 1 root root 0 Nov 11 01:53 cgroup.clone_children
-rw-r--r-- 1 root root 0 Nov 11 01:53 cgroup.procs
-r--r--r-- 1 root root 0 Nov 11 01:53 cgroup.sane_behavior
-rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.cpu_exclusive
-rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.cpus
-r--r--r-- 1 root root 0 Nov 11 01:53 cpuset.effective_cpus
-r--r--r-- 1 root root 0 Nov 11 01:53 cpuset.effective_mems
-rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.mem_exclusive
-rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.mem_hardwall
-rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.memory_migrate
-r--r--r-- 1 root root 0 Nov 11 01:53 cpuset.memory_pressure
-rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.memory_pressure_enabled
-rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.memory_spread_page
-rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.memory_spread_slab
-rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.mems
-rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.sched_load_balance <<<<<<
-rw-r--r-- 1 root root 0 Nov 11 01:53 cpuset.sched_relax_domain_level
-rw-r--r-- 1 root root 0 Nov 11 01:53 notify_on_release
-rw-r--r-- 1 root root 0 Nov 11 01:53 release_agent
-rw-r--r-- 1 root root 0 Nov 11 01:53 tasks

localhost:/tmp # ll /sys/fs/cgroup/
total 0
-r--r--r--  1 root root 0 Nov 11 01:44 cgroup.controllers
-rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.max.depth
-rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.max.descendants
-rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.procs
-r--r--r--  1 root root 0 Nov 11 01:44 cgroup.stat
-rw-r--r--  1 root root 0 Nov 11 01:39 cgroup.subtree_control
-rw-r--r--  1 root root 0 Nov 11 01:44 cgroup.threads
-r--r--r--  1 root root 0 Nov 11 01:44 cpu.stat
-r--r--r--  1 root root 0 Nov 11 01:44 cpu.stat.local
drwxr-xr-x  2 root root 0 Nov 11 01:39 dev-hugepages.mount
drwxr-xr-x  2 root root 0 Nov 11 01:39 dev-mqueue.mount
drwxr-xr-x  2 root root 0 Nov 11 01:39 init.scope
-rw-r--r--  1 root root 0 Nov 11 01:44 io.cost.model
-rw-r--r--  1 root root 0 Nov 11 01:44 io.cost.qos
-r--r--r--  1 root root 0 Nov 11 01:44 io.stat
drwxr-xr-x  2 root root 0 Nov 11 01:39 machine.slice
-r--r--r--  1 root root 0 Nov 11 01:44 memory.numa_stat
--w-------  1 root root 0 Nov 11 01:44 memory.reclaim
-r--r--r--  1 root root 0 Nov 11 01:44 memory.stat
-r--r--r--  1 root root 0 Nov 11 01:44 misc.capacity
drwxr-xr-x  2 root root 0 Nov 11 01:39 proc-fs-nfsd.mount
drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-fs-fuse-connections.mount
drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-kernel-config.mount
drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-kernel-debug.mount
drwxr-xr-x  2 root root 0 Nov 11 01:39 sys-kernel-tracing.mount
drwxr-xr-x 40 root root 0 Nov 11 02:01 system.slice
drwxr-xr-x  2 root root 0 Nov 11 01:39 user.slice

localhost:/tmp # mount | grep cgroup
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate,memory_recursiveprot)
cpuset on /var/tmp/cpuset type cgroup (rw,relatime,cpuset)


> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
