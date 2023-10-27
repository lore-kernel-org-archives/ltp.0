Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD1CC25B47
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 10:50:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CEC713CEB97
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 12:50:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2EAF3CCA70
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 12:49:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 63D4714044A1
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 12:49:58 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 4810E21B1E;
 Fri, 27 Oct 2023 10:49:57 +0000 (UTC)
Received: from g78.cable.virginm.net (rpalethorpe.tcp.ovpn1.nue.suse.de
 [10.163.17.14]) by relay2.suse.de (Postfix) with ESMTP id CE1362D7B8;
 Fri, 27 Oct 2023 10:49:56 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 27 Oct 2023 11:49:51 +0100
Message-ID: <20231027104951.32464-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com
 (policy=quarantine); 
 spf=fail (smtp-out1.suse.de: domain of rpalethorpe@suse.com does not designate
 149.44.160.134 as permitted sender) smtp.mailfrom=rpalethorpe@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00]; ARC_NA(0.00)[];
 R_SPF_FAIL(1.00)[-all]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 NEURAL_HAM_LONG(-3.00)[-1.000];
 DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid
 DKIM,quarantine]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-1.00)[-1.000];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(0.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; BAYES_HAM(-0.16)[69.53%]
X-Rspamd-Queue-Id: 4810E21B1E
X-Spam: Yes
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] controllers/cpuset: Make mount failure TCONF
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

It appears that if the subsystem is available under V2 then mounting
the V1 can fail. Probably when the V2 has processes assigned to a
group it controls.

The test should scan the system and find the existing CGroup
hierarchies and work with those. This can be done by converting the
test to tst_cgctl or rewriting it in C. It's not clear what the best
course of action would be.

For now, this commit just changes the result to TCONF.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/controllers/cpuset/cpuset_funcs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index 0cfa0c17e..312654a9d 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -165,7 +165,7 @@ setup()
 	mount -t cgroup -o cpuset cpuset "$CPUSET" 2> /dev/null
 	if [ $? -ne 0 ]; then
 		cleanup
-		tst_brkm TFAIL "Could not mount cgroup filesystem with"\
+		tst_brkm TCONF "Could not mount cgroup filesystem with"\
 					" cpuset on $CPUSET..Exiting test"
 	fi
 
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
