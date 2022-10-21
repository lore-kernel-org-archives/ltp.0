Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869D5C4332F
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 14:23:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09C4B3CB23E
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 16:23:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE1F43C1351
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 16:23:08 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BC0471A00719
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 16:23:07 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id z97so6438601ede.8
 for <ltp@lists.linux.it>; Fri, 21 Oct 2022 07:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9fWWrKSb5Q5kJmB22yEmuU1KWXUjHwdXM8dQhofc48Y=;
 b=LIbjbWzVA9TBWhlg9QD0oPuIKlJt7q1TnjKpy5eydVgtxiNAZrc4VnK2yaynw8YWI/
 fTRZEOGVCmpjgqE2AVilzf/hymi6EeJmG/TYm17gdASwKHVv4x12Kh0QL9j5kIkLzXwW
 YC2LhRxMxy+tn5OYCqFsse7b7W3fLIXEzxPFcQpPdNFJ5FDx5fw2ArBogZ5lpMAg6PF+
 Fysj76+zBTj0O4yzMDE8ddafan9/PNci4cj8z6jEpyRFUE6PAdTQyUF7tVMugG4ZEAcz
 y6Wmq75ULzfThQJEgmKS+5o9r2bTIVSPhxM74XHR5TqTxkWNGin/XN5pJKhs+kFnGCiG
 QpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9fWWrKSb5Q5kJmB22yEmuU1KWXUjHwdXM8dQhofc48Y=;
 b=TK3MDogNHnhuPUhhdTk37WP2hRKlXdnGO+hcGQ35akihTlgamJubDc7CV209ljPJoY
 wEfIoBAUn8uBjbGkB/L80AVNTVGkN3kZNpSkmSeUZpb32L/KaEkapG04RnPk9SbFc8oN
 QqRVwuQqH3Hw1UUoCpn7EAusASzaLOTGCY/MW56R59bS0SPBZiDdCH7u5xFQn3nx3oEA
 Aeu7Is32gNZAKD9Z07s/uWs4mOnq+w13J7y3+yhCfWxfoSbw+AbvSlYQbwjW5+exk6Yf
 9/tZnrk/gSR6cR7orNTy4P6huSgWAnAWjb8joVlvV5vXfINGMRww06FRG1qKO8gw8bN7
 1B1A==
X-Gm-Message-State: ACrzQf1JZ5eRFZiSEtoyPrz2lib7a5UOeujW5N2YSR4CeMrvpFR/gKtc
 LYfj1bbJxFzA11FnGZSZfEbDGDXNdpY=
X-Google-Smtp-Source: AMsMyM4FYKq/uM7HAZj2GoxANoZqj339S19++z2mxkDjeDO0a9vS8NjJgnjRbcOLW1Z2MPvaxCjurQ==
X-Received: by 2002:a05:6402:3588:b0:45d:7d14:baf2 with SMTP id
 y8-20020a056402358800b0045d7d14baf2mr17308021edc.1.1666362186740; 
 Fri, 21 Oct 2022 07:23:06 -0700 (PDT)
Received: from lab.hqhome163.com ([194.183.10.152])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a17090618a100b007877ad05b32sm11537424ejf.208.2022.10.21.07.23.05
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Oct 2022 07:23:05 -0700 (PDT)
Date: Fri, 21 Oct 2022 14:18:08 +0000
From: Alessandro Carminati <alessandro.carminati@gmail.com>
To: ltp@lists.linux.it
Message-ID: <Y1KqIExvM4LDcefZ@lab.hqhome163.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix tst_find_backing_dev when no initramfs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

After having discussed this patch content with Jan Stancek, I realized that 
my patch log is too minimal.
By this message, I want to substantiate the case.
I will start by saying the problem I want to fix happens in minimal systems: 
the kernel and minimal onit scripts.
This is the case of many embedded system powered by linux.
Here is the link of a minimal system I used to test the patch.
https://gitlab.com/acarmina/test-files/-/blob/main/testenv.tar.gz
In such a system, you have:

# cat /proc/cmdline 
console=ttyS0 root=/dev/sda rw   rootwait
# cat /proc/self/mountinfo 
14 1 8:0 / / rw,relatime - ext2 /dev/root rw
15 14 0:5 / /dev rw,relatime - devtmpfs devtmpfs rw,size=505412k,nr_inodes=126353,mode=755
16 14 0:13 / /proc rw,relatime - proc proc rw
17 15 0:14 / /dev/pts rw,relatime - devpts devpts rw,gid=5,mode=620,ptmxmode=666
18 15 0:15 / /dev/shm rw,relatime - tmpfs tmpfs rw,mode=777
19 14 0:16 / /tmp rw,relatime - tmpfs tmpfs rw
20 14 0:17 / /run rw,nosuid,nodev,relatime - tmpfs tmpfs rw,mode=755
21 14 0:18 / /sys rw,relatime - sysfs sysfs rw
# /usr/lib/ltp-testsuite/testcases/bin/ioctl_loop05
tst_test.c:1363: TINFO: Timeout per run is 0h 05m 00s
tst_test.c:1115: TINFO: ext2/ext3/ext4 is supported by the test
tst_device.c:88: TINFO: Found free device 0 '/dev/loop0'
loop0: detected capacity change from 0 to 2048
tst_device.c:566: TWARN: stat(/dev/root) failed: ENOENT (2)

Summary:
passed   0
failed   0
broken   0
skipped  0
warnings 1
#

/dev/root is simply not there, and the test fails with a warning.

In the systems where the /dev/root is there, it is typically a symbolic link 
to the actual device.

Digging on why this device is not there, despite the mount info reports the / 
to be mounted over it, I discovered something weird in the early kernel 
initialization:
https://elixir.bootlin.com/linux/v6.0.3/source/init/do_mounts.c#L566
In this recent kernel release it is evident how the kernel creates the 
/dev/root device node and after it mounts the new device on the / .

The problem is not widely known since in systems where the /dev/root is 
used, typically, the init scripts handle it.
Although it may look strange, this behaviour is considered the intended 
behaviour for the kernel.
An indirect proof is that as early as 2013 a patch aimed to fix this 
behaviour circulated in the kernel mailing lists 
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg378443.html
But it never made to the upstream

Assuming the current the intended kernel behaviour, the thesis I'm 
trying to push is that the test, meant to test the kernel, should not 
rely on work done in userspace init scripts.

In the patch I am pushing, my intent is to deal with this /dev/root 
peculiarity at the LTP level, by basically add a logic that replaces 
the actual device in case of stat failing on the /dev/root case.

I hope this make my patch context clear.

Cheers
Alessandro

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
