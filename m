Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A36E77169
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 01:24:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E7303DEBF6
	for <ltp@archiver.kernel.org>; Wed,  4 Dec 2024 02:24:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95E0C3DEB64
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 02:23:49 +0100 (CET)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AEE47101BA47
 for <ltp@lists.linux.it>; Wed,  4 Dec 2024 02:23:48 +0100 (CET)
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-515d8f3afb8so28932e0c.3
 for <ltp@lists.linux.it>; Tue, 03 Dec 2024 17:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733275427; x=1733880227; darn=lists.linux.it;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i9kc1AidN4ki7gwTKVtuDVAi25agJS6Uo7piz5b06AY=;
 b=UopZV32b+KM5tHlH+QPkmMZhRECAiQP0u/AIzro9Prt2dHsQWaalieGLZEXtOEPJ14
 qlv6oYSAHMq6vuyLkVAJqscDIaOUwh22DOkfxxBYH96ckpiy4MQ/sga+q6I3KGQf4fSP
 zbyAbWEEDRbOE32nb0vvZhRDqpikoO8l3B+N71VC4xwexCnr275J1O6+ybgq0zXPdvjG
 oh3rmsxVYLnsZyEN2w0iCgQNkPewY3bFUzSlC/pRiZdxhIgoXSE0lhUuqI7Fpm6Mkzrb
 TA9cfS5MqHtZ8n5H4stPSB0J+NZ59P9pI1eprAMOtJH/4eqF6nfkmDSGr0wnbLR5nXgt
 YZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733275427; x=1733880227;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i9kc1AidN4ki7gwTKVtuDVAi25agJS6Uo7piz5b06AY=;
 b=LrhHnGcnJpaOuUprEesxhW/BGin9yKzDZioOgFhetrtPQgYjrSym+iCkhqpXSLSNoq
 lJDN0zUyPTpq/LAINKm5sqAZiwijeGNYOjfWw28Rzt6CR22ZOC6klwE7GmJLlJQHGIac
 yeuKfUHlFc3O+VbsP7hU2YFXp9qTpnnjlRCrAN2loZyF8/9/MVDk3Y5nxpn4oQ7dg9w+
 63tC38L1InCopzybwohlHMpWugHQxHo4m8DMRnggsrj3bcxY/Vsbp4kE8GRBpeh91v+y
 6owOvY6nEcy/08lubRcpA+XHkhUs6A3HIQQjjJwX5f8AVbyX7u3yVZc7bPKwU5utAct2
 MgqQ==
X-Gm-Message-State: AOJu0YxQcP7mDNWMK5Gk2qI8cTyYTa1ojs8uCXUueuf0KyJGGTRihASl
 bR1PvSJP7Wrb5d4VzABjdMxDzL0VOTRY1CBBO6ejFffKT47auHPViXnzrMXf3UnwzDsRGau7bX7
 fWiJ2flEDM0gEoRXM3YTiSvE8Ua/1OX04ZaMqvyo0
X-Gm-Gg: ASbGncv9oNhiEjLKgegWjQq3MIzibA60OXTX9e0dHWLdziHPR4phJKwYV0QEWEo/cuF
 FAO107+Hqu/qt4YkOAG7xZEviGDCGQUW2
X-Google-Smtp-Source: AGHT+IFMzZqUcWQCINirhk4NkHUOkl2TsaTtPnCXyb5hJrH7HjGNXC3M4+MA1JpXBNayK4VTqOgMpP5VCTwXgAy+6Q0=
X-Received: by 2002:a05:6122:2216:b0:50d:44fd:5b68 with SMTP id
 71dfb90a1353d-515bf673fb9mr5726614e0c.10.1733275426888; Tue, 03 Dec 2024
 17:23:46 -0800 (PST)
MIME-Version: 1.0
References: <25b83072-41aa-45dc-984f-70f5d1f9b6dc.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYT+ANrXktd6hsuA2EUs-Jr1x_ozpkhHyHrr-V=66S5uhg@mail.gmail.com>
In-Reply-To: <CA+B+MYT+ANrXktd6hsuA2EUs-Jr1x_ozpkhHyHrr-V=66S5uhg@mail.gmail.com>
From: Jin Guojie <guojie.jin@gmail.com>
Date: Wed, 4 Dec 2024 09:23:35 +0800
Message-ID: <CA+B+MYSUASROU_8SkfKmz5c-7PjX2epovAzXMRS4a1nDFsVWOA@mail.gmail.com>
To: ltp@lists.linux.it, Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] controllers: skip the test on systems where cgroup
 v2 is already loaded
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

When running "controllers" case on some newer Linux distributions, there
will be 10 ERROR messages during the setup phase, and several TFAIL
results at the end, even though the kernel support for cgroups in these
distributions is correct.

(1) Test platform

* Linux distribution: Ubuntu 24.10
* CPU: X86_64, Arm64
* Kernel: 6.6 longterm, with CONFIG_CGROUPS=y enabled
* glibc:  2.40
* LTP version:  commit b21fd2072, Thu Nov 14 11:47:10 2024

(2) Error logs

The output of running the controllers on the above platforms is
(simplified to highlight important content):

root@vm:/opt/ltp# ./runltp  -s controllers

Running tests.......
<<<test_start>>>
tag=controllers stime=1732238600
cmdline="test_controllers.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
TEST 1: CPU CONTROLLER TESTING
RUNNING SETUP.....
ERROR: Could not mount cgroup filesystem on /dev/cpuctl..Exiting test
Cleanup called
cat: /dev/cpuctl/group_def/tasks: No such file or directory
TEST 3: CPU CONTROLLER TESTING
RUNNING SETUP.....
ERROR: Could not mount cgroup filesystem on /dev/cpuctl..Exiting test
Cleanup called
cat: /dev/cpuctl/group_def/tasks: No such file or directory

...{{Repeat between TEST 4 to 9}}...

TEST 10: CPU CONTROLLER STRESS TESTING
RUNNING SETUP.....
ERROR: Could not mount cgroup filesystem on /dev/cpuctl..Exiting test
Cleanup called
cat: /dev/cpuctl/group_def/tasks: No such file or directory
FAIL     The Latency test 1 failed

TINFO Running cpuctl Latency Test 2
mount: /dev/cpuctl: cpuctl already mounted or mount point busy.
       dmesg(1) may have more information after failed mount system
call.
cpuctl_test_fj    1  TFAIL  :  ltpapicmd.c:188: failed to mount cpu
subsystem... Exiting
cpuctl_test_fj    1  TFAIL  :  ltpapicmd.c:188: case1    FAIL
......



On the other hand, multiple applications running on this system(e.g. systemd,
docker) can prove that the kernel's support for cgroups is working properly.

(3) Cause analysis

Current "controllers" case in LTP only implements tests for the cgroup
v1 file interface. Currently,
many Linux distributions, including Ubuntu 24.10, mount the cgroup v2
hierarchy to /sys/fs/cgroup
at startup, which has occupied cpu, memory and other controllers, resulting
in the inability to load the v1 hierarchy again in another directory.

In this case, loading the v1 hierarchy is meaningless and subsequent
tests cannot be executed.

(4) Behavior of the patch

In order to make LTP more elegantly reflect the actual running
situation, a simple solution is to skip the test on systems where the v2
hierarchy has already been loaded.

a. Check whether the cgroup v2 file system has been loaded in the system
b. Make precise prompts, skip the test with TCONF result

On other systems that have cgroup v1 loaded by default, the behavior of
the program is not affected.

(5) Running results after code modification

a. On Ubuntu 24.10

cmdline="test_controllers.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
(null)      1  TCONF  :  ltpapicmd.c:172: V1 'memory' controller
required, but it's mounted on V2
(null)      2  TCONF  :  ltpapicmd.c:172: Remaining cases not
appropriate for configuration

b. On other systems that have cgroup v1 loaded by default, this use case
still works correctly.

(6) Future work

At present, some distributions use cgroup v1 by default, while others
use cgroup v2 by default.
Since cgroup v1 and v2 are incompatible in terms of interface, many test
programs in LTP need to modify their code to support cgroup v2. This is
a large amount of work and will be completed in the future.

Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
---
 .../kernel/controllers/test_controllers.sh    | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/testcases/kernel/controllers/test_controllers.sh
b/testcases/kernel/controllers/test_controllers.sh
index 7aa974ff2..6675e5618 100755
--- a/testcases/kernel/controllers/test_controllers.sh
+++ b/testcases/kernel/controllers/test_controllers.sh
@@ -37,6 +37,27 @@
 #
           #
 ##################################################################################

+
+# Check for cgroup v2, and skip it.
+# In the script called by test_controllers.sh, only the file
interface of cgroup v1
+# is tested. Since many Linux distributions are now turning to v2, cgroup v2
+# hierarchy is mounted to /sys/fs/cgroup at startup, and Linux
documentation does
+# not recommend using v2 hierarchy and v2 hierarchy at the same time
in a running
+# system. Therefore, when the v2 hierarchy is already loaded in the
system, skip the test.
+# In fact, the safest way is to add a new set of test scripts for
cgroup v2 in LTP.
+# But this workload is relatively large, hope someone will do it in the future.
+mount | grep  " type cgroup2 " &>/dev/null
+if [ $? == 0 ]
+then
+       tst_brkm TCONF "" "test_controllers.sh: V1 'memory' controller
required, but it's mounted on V2"
+       exit 32
+fi
+
 if [ -f /proc/cgroups ]
 then
        CPU_CONTROLLER=`grep -w cpu /proc/cgroups | cut -f1`;
--
2.45.2

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
