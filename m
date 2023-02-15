Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CC0C64ED8
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 14:55:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5A773CBF2F
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 15:55:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78C5D3CB4DB
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 15:54:51 +0100 (CET)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id B19FF600BC4
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 15:54:49 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86E421042
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 06:55:29 -0800 (PST)
Received: from e126380.cambridge.arm.com (unknown [10.1.196.169])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81C093F703
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 06:54:46 -0800 (PST)
From: Teo Couprie Diaz <teo.coupriediaz@arm.com>
To: ltp@lists.linux.it
Date: Wed, 15 Feb 2023 14:54:37 +0000
Message-Id: <20230215145440.78482-1-teo.coupriediaz@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] lib/tst_pid: Find session PID limit more reliably
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

Hello LTP maintainers,

This patch series heavily reworks the logic to find the session PID limit,
which makes it work on a lot more cases than covered by the current paths.

This was motivated by failures I observed with msgstress03 and msgstress04
which weren't able to retrieve the correct PID limit on a minimal debian image
created with debootstrab.
I believe this could help with other failures I found online[0][1][2].


Indeed, the current paths used to find the session pids.max relies on systemd
to set up cgroups for the user sesssions.
This is not always the case: even if systemd is running, there might not be a
systemd user instance. cgroups might be enabled without the use of systemd, or
manually, which wouldn't match with the current paths. The process might be
controlled by another service's cgroup (for example, the sshd PID limits).

This is addressed by the first patch which uses the information in /proc/self/
to find both the cgroup sysfs mount point and the path to the active cgroup.

Further, currently when "max" is encountered in "pids.max" LTP assumes this
means the kernel "pid_max". This is fine if the cgroup is the only one
imposing a pid limit in its hierarchy, but is invalid if there's any parent
cgroup that restricts the PID count, "max" meaning this restricted value.

The second patch addresses this by going up the cgroup hierarchy until a limit
other than "max" is found, falling back to the kernel "pid_max" if it doesn't.


With our system this wasn't enough to fix the msgstress03 failures as it used
more PIDs than the limit it retrieved. Comparing it to msgstress04, msgstress03
is quite agressive in its PID limit and seems to assume tasks will complete
fast enough to not hit the limit.
Indeed, it will fork nprocs times, which is set to the pid limit if the later
is smaller, but then each forked process will fork again.
Fix that by pessimistically assuming that every fork will be alive at the same
time.


This series has been tested with cgroup v1 and v2, on Alpine Linux, Arch Linux
and Debian.

Thanks very much in advance for your time !

CI build:
https://github.com/Teo-CD/ltp/actions/runs/4184905549

[0]: https://lore.kernel.org/ltp/Yep6yovcY2qJkXSR@yuki/T/#t
[1]: https://forums.sifive.com/t/ltp-message-queue-stress-testcase-failure/4601
[2]: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1783881

Teo Couprie Diaz (3):
  lib/tst_pid: Find cgroup pid.max programmatically
  lib/tst_pid: Go to parent cgroups for max value
  ipc/msgstress03: Assume all forks will run concurently

 lib/tst_pid.c                                 | 133 ++++++++++++------
 .../syscalls/ipc/msgstress/msgstress03.c      |   2 +-
 2 files changed, 90 insertions(+), 45 deletions(-)

-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
