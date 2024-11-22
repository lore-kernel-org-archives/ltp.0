Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDE5E65D10
	for <ltp@archiver.kernel.org>; Fri, 22 Nov 2024 02:19:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7FA43D99AA
	for <ltp@archiver.kernel.org>; Fri, 22 Nov 2024 03:19:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 79FA93D982D
 for <ltp@lists.linux.it>; Fri, 22 Nov 2024 03:18:49 +0100 (CET)
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com
 [IPv6:2607:f8b0:4864:20::e2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EA3F4219FE0
 for <ltp@lists.linux.it>; Fri, 22 Nov 2024 03:18:48 +0100 (CET)
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4a5c4d8ee99so206169137.1
 for <ltp@lists.linux.it>; Thu, 21 Nov 2024 18:18:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732241927; x=1732846727; darn=lists.linux.it;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4kytzDtTBdsXiGV+HYwOSEo5TfJUKlxT0iON4AUO/DY=;
 b=f2d+UTQf9ioCHn0gUbbFJhEe3JmtNKzl0vzMPLARK3IPJttXd80FPu++72CmCwSaZm
 YNqYJpNVYQq94gKGPCz06xgNoxL94DrwOaN+6qatcVoR7Bjj+kufI6NJkDs5nTp+E3OM
 CtOJkJyuKEuzrZLRIMzV1DWuxWX2LzBOmvJwQwkNIS5TKC7qQCToaP7VtLLL0+0tFubv
 Nuj25xSuMIDw61wq+RbvfsGBfpPVMPKjcOkmb3RqUYOnLFDmWlbkSHwj+MCPqU6FpIpX
 ink5SG8v3uQ/j2YgVAtbEgI44HK1q91RHcW01NOS6t3uGwj+3TWkkx4FH3FIzfIL+uc4
 XN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732241927; x=1732846727;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4kytzDtTBdsXiGV+HYwOSEo5TfJUKlxT0iON4AUO/DY=;
 b=jiYBNwZZ40+luTdOpq3KMle/cysOF6VwphTFbt5yYbc8HLcOWEhDNASkcThfkXUVXL
 WfSrT+G/jbCS0899XDtir7V8W19sQSxHgmO+iX1rusnfMpvTX+CB3QvDdXMDsLC0kvNC
 9FRdpw5OKWds0DVsJSlsOza5m3pqKBRsInylOlfo1wJtDJFOsniwG0WrDRQuMznZzYV6
 Ic5/DWz8eeFOo772JTBp14Dml7HdfTr/Y0k9DUVlw32BJygnGO5ojFB4rHGw+nlW3cwZ
 bGHA/Eo5zdQ9X2Ui442akFGE/85PMalshD/Ax+DDFjjQT8EEhxvmkpi2r8Lg/SIvhEv/
 rntg==
X-Gm-Message-State: AOJu0YxmuU7MV79pGZ3QujcCAlYStajzmsYhuBnO2NTS6PVZkGSyQcf7
 xi7Q4KHan//xAJEYWACXnMo6kAn3S8C2aDq1rUA/cqeb4hYwY39Ip10q7tqaglXfmSCRWaoJq6G
 3keqtljtFe3YZdwqRHNwZQBI2Mcrf+OcpdkUA8bsN7Eg=
X-Gm-Gg: ASbGncsY0gnxxZT5ZzktJzZh1TOCP7V8TuLG08HZejk+aS31HR+nYj10Q8i9hnS5J+z
 F32we+K+HwJcoUViqu9iJiaiGY6GuG3rb
X-Google-Smtp-Source: AGHT+IG0RC77vwvvhZW90AQnE+bZAQBvU/Iczqb8mfYHkc+b2XpfwTJi6XLojMqCK+eCMfMO9EcIWsjCKSdjKwKsY/I=
X-Received: by 2002:a05:6102:3589:b0:4a4:7928:637c with SMTP id
 ada2fe7eead31-4addcbfb02cmr1368369137.8.1732241927035; Thu, 21 Nov 2024
 18:18:47 -0800 (PST)
MIME-Version: 1.0
References: <25b83072-41aa-45dc-984f-70f5d1f9b6dc.jinguojie.jgj@alibaba-inc.com>
In-Reply-To: <25b83072-41aa-45dc-984f-70f5d1f9b6dc.jinguojie.jgj@alibaba-inc.com>
From: Jin Guojie <guojie.jin@gmail.com>
Date: Fri, 22 Nov 2024 10:18:35 +0800
Message-ID: <CA+B+MYT+ANrXktd6hsuA2EUs-Jr1x_ozpkhHyHrr-V=66S5uhg@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] Fwd: [PATCH] controllers: skip the test on systems where
 cgroup v2 is already loaded
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
CONTROLLERS TESTCASES: WARNING
The OS has enabled cgroup v2 hierarchy,
while LTP only implements v1 interface.
Skipping all controllers testcases....
(null)      1  TCONF  :  ltpapicmd.c:172: test_controllers.sh: skipping
cgroup v2 hierarchy
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
+       echo "CONTROLLERS TESTCASES: WARNING"
+       echo "The OS has enabled cgroup v2 hierarchy,";
+       echo "while LTP only implements v1 interface.";
+       echo "Skipping all controllers testcases....";
+
+       tst_brkm TCONF "" "test_controllers.sh: skipping cgroup v2 hierarchy"
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
