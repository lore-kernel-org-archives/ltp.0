Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC951C6FD1C
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 11:41:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7EA33CD50F
	for <ltp@archiver.kernel.org>; Tue, 14 Mar 2023 12:41:10 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D1253CACDF
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 12:40:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C25611400BE2
 for <ltp@lists.linux.it>; Tue, 14 Mar 2023 12:40:58 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B15941F893;
 Tue, 14 Mar 2023 11:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678794057; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ld0IpT+FQZmtJTKuyyHN+s5tlPEX/nkytAADXv0pdy8=;
 b=K9/Ng1iIbk2s300qJzAANhnctrIVAutIDRc+VODQDbjR5uWW+D3WRVhrRvf1Mts7AfPykp
 I4uYJB3d0KzJO83ek1gvGes8qjt8cOR46x/rREwKPdQUQdd0Zduh2Ni9ehUF7ZqWY2mC05
 GY0iF7Xa2jeJo06AJnIu8PF1PGaGAyE=
Received: from g78.cable.virginm.net (unknown [10.163.28.198])
 by relay2.suse.de (Postfix) with ESMTP id 3E9B62C141;
 Tue, 14 Mar 2023 11:40:56 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 14 Mar 2023 11:40:37 +0000
Message-Id: <20230314114037.25581-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add goals of patch review and tips
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I see two options for patch review. Either we have a single senior
maintainer who does most of or it is distributed.

For now I think it needs to be distributed which is beyond the scope
of this commit.

In order to distribute it we need new contributors to review each
others' work at least for the first few revisions.

I think that anyone can review a patch if they put the work in to test
it and try to break it. Then understand why it is broken.

This commit states some ideas about how to do that, plus some tips for
more advanced patch review.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Andrea Cervesato <andrea.cervesato@suse.de>
Cc: Avinesh Kumar <akumar@suse.de>
Cc: Wei Gao <wegao@suse.com>
Cc: Petr Vorel <pvorel@suse.cz>
---
 doc/maintainer-patch-review-checklist.txt | 78 ++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/doc/maintainer-patch-review-checklist.txt b/doc/maintainer-patch-review-checklist.txt
index 706b0a516..be0cd0961 100644
--- a/doc/maintainer-patch-review-checklist.txt
+++ b/doc/maintainer-patch-review-checklist.txt
@@ -1,4 +1,80 @@
-# Maintainer Patch Review Checklist
+# Patch Review
+
+Anyone can and should review patches. It's the only way to get good at
+patch review and for the project to scale.
+
+## Goals of patch review
+
+1. Prevent false positive test results
+2. Prevent false negative test results
+3. Make future changes as easy as possible
+
+## How to find clear errors
+
+A clear error is one where there is unlikely to be any argument if you
+provide evidence of it. Evidence being an error trace or logical proof
+that an error will occur in a common situation.
+
+The following are examples and may not be appropriate for all tests.
+
+* Merge the patch. It should apply cleanly to master.
+* Compile the patch with default and non-default configurations.
+  - Use sanitizers e.g. undefined behaviour, address.
+  - Compile on non-x86
+  - Compile on x86 with -m32
+* Use `make check`
+* Run effected tests in a VM
+  - Use single vCPU
+  - Use many vCPUs and enable NUMA
+  - Restrict RAM to < 1GB.
+* Run effected tests on an embedded device
+* Run effected tests on non-x86 machine in general
+* Run reproducers on a kernel where the bug is present
+* Run tests with "-i0"
+* Compare usage of system calls with man page descriptions
+* Compare usage of system calls with kernel code
+* Search the LTP library for existing helper functions
+
+## How to find subtle errors
+
+A subtle error is one where you can expect some argument because you
+do not have clear evidence of an error. It is best to state these as
+questions and not make assertions if possible.
+
+Although if it is a matter of style or "taste" then senior maintainers
+can assert what is correct to avoid bike shedding.
+
+* Ask what happens if there is an error, could it be debugged just
+  with the test output?
+* Are we testing undefined behaviour?
+  - Could future kernel behaviour change without "breaking userland"?
+  - Does the kernel behave differently depending on hardware?
+  - Does it behave differently depending kernel on configuration?
+  - Does it behave differently depending on the compiler?
+* Will it scale to tiny and huge systems?
+  - What happens if there are 100+ CPUs?
+  - What happens if each CPU core is very slow?
+  - What happens if there are 2TB or RAM?
+* Are we repeating a pattern that can be turned into a library function?
+* Is a single test trying to do too much?
+* Could multiple similar tests be merged?
+* Race conditions
+  - What happens if a process gets preempted?
+  - Could checkpoints or fuzzsync by used instead?
+  - Note, usually you can insert a sleep to prove a race condition
+    exists however finding them is hard
+* Is there a simpler way to achieve the same kernel coverage?
+
+## How to get patches merged
+
+Once you think a patch is good enough you should add your Reviewed-by
+tags. This means you will get some credit for getting the patch
+merged. Also some blame if there are problems.
+
+In addition you can expect others to review your patches and add their
+tags. This will speed up the process of getting your patches merged.
+
+## Maintainers Checklist
 
 Patchset should be tested locally and ideally also in maintainer's fork in
 GitHub Actions on GitHub.
-- 
2.39.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
