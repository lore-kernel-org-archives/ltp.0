Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E708CC369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 22:09:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2E5593CB936
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 00:09:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5004F3C2EFA
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 00:08:55 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 28962600477
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 00:08:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 028CF1F461;
 Tue, 15 Apr 2025 22:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744754931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tC5ZwqqPxCUf/Rd6A+GL6w/p/mB4x3oneBgZVIzCmC0=;
 b=2LVOkqzapbGZh4A1JR/hSuJMlQJvfFnpC6kR89HThH3Y7GtzELlTmUpMJgNPe1QET3zzAS
 Qka8CKPQwi569Qv+HauegMJc1H8fjff8IWCADCfBKdpq8aVkXlts+r4d5YCezSa4WKoyGw
 aCDplFCPRbobQu2KNsCsb6fY8QoeFQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744754931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tC5ZwqqPxCUf/Rd6A+GL6w/p/mB4x3oneBgZVIzCmC0=;
 b=/C7+edqL2t3ppTjD4tqgpFSfavTcijKcfY0x+iVwjKTuoczYGycSznT2JS9jq8hobqWivc
 sT7P6vmojAcMxUBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744754931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tC5ZwqqPxCUf/Rd6A+GL6w/p/mB4x3oneBgZVIzCmC0=;
 b=2LVOkqzapbGZh4A1JR/hSuJMlQJvfFnpC6kR89HThH3Y7GtzELlTmUpMJgNPe1QET3zzAS
 Qka8CKPQwi569Qv+HauegMJc1H8fjff8IWCADCfBKdpq8aVkXlts+r4d5YCezSa4WKoyGw
 aCDplFCPRbobQu2KNsCsb6fY8QoeFQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744754931;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tC5ZwqqPxCUf/Rd6A+GL6w/p/mB4x3oneBgZVIzCmC0=;
 b=/C7+edqL2t3ppTjD4tqgpFSfavTcijKcfY0x+iVwjKTuoczYGycSznT2JS9jq8hobqWivc
 sT7P6vmojAcMxUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D22BA137A5;
 Tue, 15 Apr 2025 22:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GiaqMfLY/mf/PAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 15 Apr 2025 22:08:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 16 Apr 2025 00:08:44 +0200
Message-ID: <20250415220845.548155-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.61 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_SHORT(-0.01)[-0.041]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[4];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] tst_cgroup: Add "dmem" cgroup controller
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

"dmem" cgroup controller [1] was added in 6.14 [2]. Add it to fix cgroup_regression_test.sh:

cgroup_regression_test 1 TINFO: Tested kernel: Linux susetest 6.14.0-1-default #1 SMP PREEMPT_DYNAMIC Tue Mar 25 06:23:18 UTC 2025 (ab99d4c) x86_64 x86_64 x86_64 GNU/Linux
...
cgroup_regression_test 7 TBROK: 'tst_cgctl require' exited

New cgroup should be v2 only.

[1] https://docs.kernel.org/next/admin-guide/cgroup-v2.html#dmem
[2] https://kernelnewbies.org/Linux_6.14#dmem_cgroup_for_better_control_of_GPU_memory_resources

Reported-by: Avinesh Kumar <akumar@suse.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/tst_cgroup.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 73b696c588..0cb7282113 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -84,6 +84,7 @@ enum cgroup_ctrl_indx {
 	CTRL_MEMORY = 1,
 	CTRL_CPU,
 	CTRL_CPUSET,
+	CTRL_DMEM,
 	CTRL_IO,
 	CTRL_PIDS,
 	CTRL_HUGETLB,
@@ -207,6 +208,12 @@ static const struct cgroup_file cpuset_ctrl_files[] = {
 	{ }
 };
 
+static const struct cgroup_file dmem_ctrl_files[] = {
+	{ "dmem.capacity", NULL, CTRL_DMEM },
+	{ "dmem.current", NULL, CTRL_DMEM },
+	{ }
+};
+
 static const struct cgroup_file io_ctrl_files[] = {
 	{ "io.stat", NULL, CTRL_IO },
 	{ }
@@ -218,6 +225,7 @@ static const struct cgroup_file pids_ctrl_files[] = {
 	{ }
 };
 
+
 static const struct cgroup_file hugetlb_ctrl_files[] = {
 	{ }
 };
@@ -289,6 +297,7 @@ static struct cgroup_ctrl controllers[] = {
 	CGROUP_CTRL_MEMBER(perf_event, CTRL_PERFEVENT),
 	CGROUP_CTRL_MEMBER(debug, CTRL_DEBUG),
 	CGROUP_CTRL_MEMBER(rdma, CTRL_RDMA),
+	CGROUP_CTRL_MEMBER(dmem, CTRL_DMEM),
 	CGROUP_CTRL_MEMBER(base, CTRL_BASE),
 	{ }
 };
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
