Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA6DC433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:21:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DF1B3CA3F8
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:21:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 761F33CA3F3
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:51 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0D82510008F8
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:50 +0100 (CET)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 449E33F5F5
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435930;
 bh=K+1WzYajNsYz63ppTUg3LHQUfDFpmNmoE5gogShWq9E=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=ULjEYeRwxpahM8BJOGJ1SDsqIQDVcFESxsKbhpwYOjAj9meUMJbPZHPgOll1tiUl/
 c6znwFWpJgeyx6mWrRbLfq8y7hXvMsXT5B1ctXbFjaqi5SsJgaM7UjL8aQIyCkqJ7O
 Ik7RFZZv3zEL57qWiMGvJSFb1m7cSn8lMLd++yUIVRColvtXAcK6G4PypFub8hLp5V
 S0MdoHQB3lA1cvvjMnB+IG6HVF7XkIUyPNHDhX6Uml6puk23XGfNW7fdBN3Z3btigh
 CEWa1oehi0tuR7DOBfh0ZqfooLGOLRsJAkrYThOh6IofeBOEJM4/0L088cQxPmddx0
 l8jmXvfBZuzNQ==
Received: by mail-pl1-f199.google.com with SMTP id
 d4-20020a170902f14400b001518350e5c7so5346964plb.13
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=K+1WzYajNsYz63ppTUg3LHQUfDFpmNmoE5gogShWq9E=;
 b=J+lWqI6sinrbmOjokiPKeyYBiUgYbTfzzXmKqDP6bT/Am/+tzw1mOYMCNbWQDP4afB
 PATsNUuAGtFZYHUQ9knZM9fOpS9u0COChlgCG2nJSpJn08MsJEE8Srp1MsMztHuCwcqF
 88g64fIVJxgpMiSAGjSVja6XDdXFFQdqLf4cqVcrE14UJV47Es4pRRM4L/wxxsfFFuDl
 5UMXpti8TUR8bMVULTarp6EpnT3ACZ5w9gInPz5rergHTf8WjFMuDr5fn1mDsiWz1pXc
 9Q+Moc8jBSu62QnOfqJke1La6Q9ZGaKCdBaTgK013HqQj7XL4yQv4TC3TlPV2t3eyF37
 aU5A==
X-Gm-Message-State: AOAM530eXS2lgzMCpBu2Nx6fxSgqRf72WtQmMhJXBUkilU8ENuEtB6NF
 pT7g0y5+ArP53t0Bw+Ifh6HE1/mk9pcK3xIqTQx/65k1UgWoga3JQ4FGiri8uq0etk1mQXbKZAH
 jYVFYXYU7wE12p6idqzDka9xUEofD
X-Received: by 2002:a17:902:cccc:b0:14e:e89c:c669 with SMTP id
 z12-20020a170902cccc00b0014ee89cc669mr700205ple.58.1646435928621; 
 Fri, 04 Mar 2022 15:18:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSBG/63XARLoW9QCmCaiv+VqmZPhohZ9XMRjHbzrMdHYh8iopEj2/2N1SUZUkJFIIAyz1tcQ==
X-Received: by 2002:a17:902:cccc:b0:14e:e89c:c669 with SMTP id
 z12-20020a170902cccc00b0014ee89cc669mr700187ple.58.1646435928325; 
 Fri, 04 Mar 2022 15:18:48 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:47 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:24 -0800
Message-Id: <42c4a457da1c50f344b58055692f754f2b0277e6.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 14/16] controllers: Update pids.sh to use newer
 cgroup lib
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

Updated to use the newer cgroup_lib to make mounting and cleanup
nicer.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: Use version number 2 instead of v2

 testcases/kernel/controllers/pids/pids.sh | 67 +++--------------------
 1 file changed, 9 insertions(+), 58 deletions(-)

diff --git a/testcases/kernel/controllers/pids/pids.sh b/testcases/kernel/controllers/pids/pids.sh
index a3d644eff..ffde41df0 100755
--- a/testcases/kernel/controllers/pids/pids.sh
+++ b/testcases/kernel/controllers/pids/pids.sh
@@ -13,7 +13,7 @@ TST_USAGE=usage
 TST_NEEDS_ROOT=1
 TST_NEEDS_CMDS="killall"
 
-. tst_test.sh
+. cgroup_lib.sh
 
 caseno=$1
 max=$2
@@ -38,66 +38,17 @@ cleanup()
 {
 	killall -9 pids_task2 >/dev/null 2>&1
 
-	tst_res TINFO "removing created directories"
-	rmdir $testpath
-	if [ "$mounted" -ne "1" ]; then
-		tst_res TINFO "Umounting pids"
-		umount $mount_point
-		rmdir $mount_point
-	fi
-}
-
-setup_cgroupv2()
-{
-	mount_point=$(grep -w cgroup2 /proc/mounts | cut -f 2 | cut -d " " -f2)
-	if ! grep -q pids "$mount_point"/cgroup.controllers; then
-		tst_res TINFO "pids not supported on cgroup v2."
-		return
-	fi
-
-	testpath="$mount_point/ltp_pids_$caseno"
-	ROD mkdir -p "$testpath"
-	task_list="cgroup.procs"
-	cgroup_v="v2"
-}
-
-setup_cgroupv1()
-{
-	exist=`grep -w pids /proc/cgroups | cut -f1`;
-	if [ "$exist" = "" ]; then
-		tst_brk TCONF NULL "pids not supported"
-	fi
-
-	mount_point=`grep -w pids /proc/mounts | cut -f 2 | cut -d " " -f2`
-
-	if [ "$mount_point" = "" ]; then
-		mounted=0
-		mount_point=/dev/cgroup
-	fi
-
-	testpath=$mount_point/ltp_pids_$caseno
-
-	if [ "$mounted" -eq "0" ]; then
-		ROD mkdir -p $mount_point
-		ROD mount -t cgroup -o pids none $mount_point
-	fi
-	ROD mkdir -p $testpath
-	task_list="tasks"
-	cgroup_v="v1"
+	cgroup_cleanup
 }
 
 setup()
 {
-	# If cgroup2 is mounted already, then let's
-	# try to start with cgroup v2.
-	if grep -q cgroup2 /proc/mounts; then
-		setup_cgroupv2
-	fi
-	if [ -z "$cgroup_v" ]; then
-		setup_cgroupv1
-	fi
+	cgroup_require "pids"
+	cgroup_version=$(cgroup_get_version "pids")
+	testpath=$(cgroup_get_test_path "pids")
+	task_list=$(cgroup_get_task_list "pids")
 
-	tst_res TINFO "test starts with cgroup $cgroup_v"
+	tst_res TINFO "test starts with cgroup version $cgroup_version"
 }
 
 start_pids_tasks2()
@@ -298,7 +249,7 @@ case8()
 {
 	tst_res TINFO "set child cgroup limit smaller than its parent limit"
 	ROD echo $max \> $testpath/pids.max
-	if [ "$cgroup_v" = "v2" ]; then
+	if [ "$cgroup_version" = "2" ]; then
 		ROD echo +pids \> "$testpath"/cgroup.subtree_control
 	fi
 	mkdir $testpath/child
@@ -328,7 +279,7 @@ case9()
 	tst_res TINFO "migrate cgroup"
 	lim=$((max - 1))
 
-	if [ "$cgroup_v" = "v2" ]; then
+	if [ "$cgroup_version" = "2" ]; then
 		ROD echo +pids \> "$testpath"/cgroup.subtree_control
 	fi
 	for i in 1 2; do
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
