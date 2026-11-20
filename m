Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA86B606A334
	for <ltp@archiver.kernel.org>; Fri, 20 Nov 2026 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Kdem9le8;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kg3766/E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1795169843; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=WZcgEK25wUkEi22yg84ZoZep69SP+xDPkwWk3TWz6Oo=;
 b=Kdem9le8gebTegdAgtr5Mkdkx3wWsjsERUJQkE95/hK8SLdfMpetptXMuirwlziATz7AZ
 ++zCe3bRechIz9s2jCHt0AaRBhZvjSBIbHjAZBO+yYOmL4aUnTrmJgm8Qps5pwQHJIQlvbe
 CtxL1xkC1BOnLu66kbtj2X+1EVvwjzg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 332603E9274
	for <ltp@archiver.kernel.org>; Fri, 20 Nov 2026 11:17:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B8053E602B
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 10:34:49 +0100 (CET)
Received: from mail-wm1-x346.google.com (mail-wm1-x346.google.com
 [IPv6:2a00:1450:4864:20::346])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 644371A00927
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 10:34:48 +0100 (CET)
Received: by mail-wm1-x346.google.com with SMTP id
 5b1f17b1804b1-4ad3d35e899so5272605e9.1
 for <ltp@lists.linux.it>; Fri, 20 Nov 2026 01:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795167287; x=1795772087; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c9YOoOtU15jHxUyrTMH7Q0YvAasCyCjEJRqPHHiz+mU=;
 b=kg3766/EcuUHIbNtp5PTu4wCSVv9VSBmed6Flq+3wq0CPEIKe7RBoWkmq0rJJmDnld
 dVSs6SKCMGul4CQCo55xICbL/d82ne1xmJq/d0ULQ75n0RzhVdi4o98v89oiQzFLLFMC
 Zee8v/nymd56HPQyyCcTSStst2wsl+OJ5ucMBQ9B5k7XXRRa2ki7/5b4d+6Xnqhph7qU
 2Jw0gaGnUEZ7XR7+6Kg5dOE5gFuJh/5snPbI9t+wO5kOhWSMkNwqIvl+shwllCBgNLBT
 h8Qw1uV5x5aaJ6AtVmGoFdFmyV18PGrG2iEyG4Kr7pNDboWZ4lNEWOjoQimH/Jz21uuZ
 6bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795167287; x=1795772087;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c9YOoOtU15jHxUyrTMH7Q0YvAasCyCjEJRqPHHiz+mU=;
 b=fkKcDc5nsdpUrQIdR1M6vrMCKK3s6Ttia/myc50GsdQAmQrESmhYFyRSAkNeHxpf18
 CwnCrVupW4S9UaqHKMiy9dbGNV+XDP3WmJxMwzbLI4b6FeC+mqy41sNwNJT6qFvAMBTc
 0wwHyGtib9Fs6W3z4evqfCPNwF5lj59nG3gdEHr7/+s75QtHpjIn0WBGP2TFPLK4KKHF
 KA+3wwNBAbqYqzGXrXJI8N61FgOEeSrnvkUrlMywhg9SlLALFrl2Q+L3+EJwCTWX1eUB
 LYpc189l4imfRC73QlPFIIedw+oQm9F1t+o5v7IwWcE2Hwfg1M74qcikhEjqI6sGMQSx
 5Kdw==
X-Gm-Message-State: APuU4Z80QqIkWbwAMSaeOkLVBGtCVMdaqfBnT+ITy75MjIgA0aNNnrOo
 I3FLpvF3DVHx96HHF9YC6iA+o+jP/fwcvkpRRX/7EgCUIXXSmNNzpeDukj4NdjlzvB8fkoCfeht
 /PbBbjX+MwGEnaTPimHEIoCLRYE/eD/Rdy2rMJABtEdojeFA/E522Fk6WR/oCCYt5AA9L13SyW3
 fprafHyfqeDdGEu/zNBUJO0Y0/Y4cY8vw=
X-Received: from wmxb18.prod.google.com ([2002:a05:600d:8452:b0:4a2:853:1e95])
 (user=hmazur job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b8a:b0:4ba:761:c0c5
 with SMTP id 5b1f17b1804b1-4bb8880f0e0mr54254785e9.5.1795167286985; Fri, 20
 Nov 2026 01:34:46 -0800 (PST)
Date: Fri, 20 Nov 2026 09:34:44 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261120093444.609481-1-hmazur@google.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 20 Nov 2026 11:17:02 +0100
Subject: [LTP] [PATCH] sys_cpu_topology02: Drop upper bound on core_id
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Hubert Mazur via ltp <ltp@lists.linux.it>
Reply-To: Hubert Mazur <hmazur@google.com>
Cc: Kazuhiro Inaba <kinaba@google.com>, Hubert Mazur <hmazur@google.com>,
 Wake Liu <wakel@google.com>, Grzegorz Jaszczyk <jaszczyk@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

sys_cpu_topology02 currently checks that each online CPU's
/sys/devices/system/cpu/cpuN/topology/core_id is in the range
[0, poss_max_id], assuming that core_id is a dense 0-based index bounded
by the highest possible CPU id.

Per Linux Documentation/ABI/stable/sysfs-devices-system-cpu, core_id is:
"Typically it is the hardware platform's identifier (rather than the
kernel's). The actual value is architecture and platform dependent."

- On x86, arch/x86/kernel/cpu/topology_common.c derives core_id from the
  hardware APIC ID domain bits. On Intel hybrid CPUs, APIC IDs are
  sparsely allocated across core types and clusters; for example, on an
  8-CPU Intel hybrid system (possible: 0-7), core_id values are
  0, 4, 8, 12, 32, 33, 34, 35, causing sys_cpu_topology02 to fail on
  cpu2..cpu7:

  sys_cpu_topology02.c:83: TFAIL:
    /sys/devices/system/cpu/cpu2/topology/core_id = 8 out of range [0, 7]
    /sys/devices/system/cpu/cpu3/topology/core_id = 12 out of range [0, 7]
    /sys/devices/system/cpu/cpu4/topology/core_id = 32 out of range [0, 7]

- On arm64 with ACPI PPTT, drivers/acpi/pptt.c populates core_id from
  the firmware ACPI processor UID or the PPTT table byte offset, neither
  of which is bounded by the CPU count.

Drop the upper bound on core_id to LONG_MAX (preserving the >= 0
sanity check), update the test documentation comment accordingly, and
remove the now-unused poss_max_id parameter from check_cpu_topology().

Fixes: d19bf8f7dede ("testcases: sysfs: Add sys_cpu_topology02")
Signed-off-by: Hubert Mazur <hmazur@google.com>
---
 .../kernel/sysfs/devices/system/cpu/sys_cpu_topology02.c   | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology02.c b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology02.c
index 7098da9f3..57353d9d1 100644
--- a/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology02.c
+++ b/testcases/kernel/sysfs/devices/system/cpu/sys_cpu_topology02.c
@@ -22,8 +22,12 @@
  *   in sync on every architecture, and avoids a spurious failure if a
  *   sibling CPU is hot-unplugged concurrently with this test running.
  * - the CPU itself is contained in its own thread_siblings_list
- * - core_id is in [0, highest possible CPU id], since there can be at most
- *   as many cores as possible CPUs (every core has at least one thread)
+ * - core_id is non-negative. Per
+ *   Documentation/ABI/stable/sysfs-devices-system-cpu, core_id is typically
+ *   the hardware platform's identifier rather than a dense kernel index, so
+ *   it is not bounded by the highest possible CPU id (e.g. x86 derives it
+ *   from the hardware APIC ID, which is sparse on Intel hybrid CPUs, and
+ *   arm64 ACPI PPTT may export a firmware UID or table byte offset).
  * - physical_package_id is in [-1, highest possible CPU id] on physical
  *   hardware, or just at least -1 under virtualization (see below). -1 is a
  *   legitimate value here, not just a range extension for safety: per
@@ -66,7 +70,7 @@ static void check_self_in_threads(int cpu)
 		PATH_SYS_CPU "/cpu%d/topology/thread_siblings_list", cpu);
 }
 
-static void check_cpu_topology(int cpu, int poss_max_id, long pkg_max_id)
+static void check_cpu_topology(int cpu, long pkg_max_id)
 {
 	char sub[PATH_MAX], super[PATH_MAX];
 
@@ -80,7 +84,7 @@ static void check_cpu_topology(int cpu, int poss_max_id, long pkg_max_id)
 
 	tst_res(TINFO, "Checking cpu%d topology", cpu);
 
-	TST_SYSFS_ASSERT_RANGELL(0, poss_max_id,
+	TST_SYSFS_ASSERT_RANGELL(0, LONG_MAX,
 			       PATH_SYS_CPU "/cpu%d/topology/core_id", cpu);
 
 	TST_SYSFS_ASSERT_RANGELL(-1, pkg_max_id,
@@ -124,7 +128,7 @@ static void do_test(void)
 		pkg_max_id = poss_max_id;
 
 	for (cpu = 0; cpu <= max_id; cpu++)
-		check_cpu_topology(cpu, poss_max_id, pkg_max_id);
+		check_cpu_topology(cpu, pkg_max_id);
 }
 
 static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
