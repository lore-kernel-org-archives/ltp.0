Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50705C433EF
	for <ltp@archiver.kernel.org>; Sat, 27 Nov 2021 00:05:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E69E3C8A8D
	for <ltp@archiver.kernel.org>; Sat, 27 Nov 2021 01:05:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07F2A3C8C0C
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 01:04:34 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 19C48201DBD
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 01:04:34 +0100 (CET)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 949803F1E5
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 00:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1637971473;
 bh=Rb6HJ3KocUnUfoKfRo4pMn3gx99bafRgeLxOtHL8QG4=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=fn8F7BKB47E6wUaka3I+HdcyzF4ihD8aHbv2xrI8qYnFBRAU8tt7snoxodbNRizWN
 w9SDO40aKVJhZXi4UR1ypGtAV3ti/SnKgfZM7ClFetZ+8JC6V+qZp8gt72Hoo2jMuS
 tMhA2NjM2z6qDJ54T1C/jeaZxpw4Jeg1uAwdoBBqL873A+v+zXEXHlwUjMAbPt6sHf
 ew9h5xrA/ft2JuOwFu1i+J/hy/sWq1POIf2kaOufvip/tVV586sCLsLuO1urcKrP0m
 hInEhiT95LNxzodI6kL3LXDh7At3/ZKUIHbcaA6L8ZxBv4ic0ExNTYxPnitfr/C6k0
 q6aOkyTtNSoWg==
Received: by mail-pf1-f199.google.com with SMTP id
 f206-20020a6238d7000000b004a02dd7156bso6093755pfa.5
 for <ltp@lists.linux.it>; Fri, 26 Nov 2021 16:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rb6HJ3KocUnUfoKfRo4pMn3gx99bafRgeLxOtHL8QG4=;
 b=wic6rj78XKRL4DYkpTk5ML2Z6RJ8no1kOCfRCybVe/Hdw5xJROGUMDsLRGePKFPJqO
 IjvVEKiSKMjV1tXfHPAWYskwC89rOvxmtIJnNmm8Nm7Wtfb6qKTHFGwKFBaPa9a/COG+
 61N7x4+gOC6dJX7ZC5+SqEGzfOTsM6SrjixFrGBuDoVT8iBC0k7ifK+kxGKgJQJye4/n
 N+irnHJbPUlWMRAugtDdyesKUGeLncVA5xdvwKCUX3Ll5Zi7FP5jw/d1CrbQtefFWyU+
 aX3KNRQHVD7Ifa8mAxiuFd4uSzQaUGPSpPHtO+ut67y3BDodzvFpeubPHR16b0/8SUTh
 ZjJA==
X-Gm-Message-State: AOAM533mXukF7FXM/U3wJFUHdly5E8FQ/UzHkC7yczse0q1fBDWXrDKj
 NHwtCRyJepVxpLIoXx3UPxwlTGgJU4QufAtWmEHlp9Ui4o5328TYJxG9LckkFybkWuE0bTL6C+f
 geXcZIM/o72055Js9saX9/hbTlgip
X-Received: by 2002:a17:902:ee8d:b0:143:8e80:62a8 with SMTP id
 a13-20020a170902ee8d00b001438e8062a8mr40144272pld.30.1637971471040; 
 Fri, 26 Nov 2021 16:04:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCH24XwS1A3yb4UsCZI9ju50i1416A6NAQmWBMwqj/AeMqpIGZpkRZus0ZGmYa2CfUCf6mQA==
X-Received: by 2002:a17:902:ee8d:b0:143:8e80:62a8 with SMTP id
 a13-20020a170902ee8d00b001438e8062a8mr40144243pld.30.1637971470716; 
 Fri, 26 Nov 2021 16:04:30 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101])
 by smtp.gmail.com with ESMTPSA id d3sm8598125pfv.57.2021.11.26.16.04.30
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Nov 2021 16:04:30 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Fri, 26 Nov 2021 16:04:25 -0800
Message-Id: <9049a47a5d33128bc278e88eca67deacd10bf7d7.1637970912.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 4/4] controllers/cgroup_fj: Update cgroup_fj_function
 to work under cgroup2
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

Most of the tests still make sense when a controller is mounted under
cgroup2 hierarchy, but some are skipped as they don't make sense and
would fail.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 .../cgroup_fj/cgroup_fj_function.sh           | 38 +++++++++++++++++--
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index fc3ad1b63..7bff480df 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -62,6 +62,12 @@ test1()
 # Group can be renamed with mv
 test2()
 {
+    # mv'ing cgroups is not available in cgroup2
+    if [ "$cgroup_v" = "v2" ]; then
+        tst_resm TCONF "Controller mounted on cgroup2 hierachy, skipping test"
+        return
+    fi
+
     create_subgroup "$start_path/ltp_2"
 
     if ! mv "$start_path/ltp_2" "$start_path/ltp_3"; then
@@ -81,6 +87,12 @@ test2()
 # Group can be renamed with mv unless the target name exists
 test3()
 {
+    # mv'ing cgroups is not available in cgroup2
+    if [ "$cgroup_v" = "v2" ]; then
+        tst_resm TCONF "Controller mounted on cgroup2 hierachy, skipping test"
+        return
+    fi
+
     create_subgroup "$start_path/ltp_2"
 
     if mv "$start_path/ltp_2" "$start_path/ltp_1" > /dev/null 2>&1; then
@@ -124,12 +136,18 @@ test5()
 
     ROD rmdir "$start_path/ltp_1/a"
 
-    ROD echo "$pid" \> "$start_path/tasks"
+    ROD echo "$pid" \> "$start_path/$task_list"
 }
 
 # Group cannot be moved outside of hierarchy
 test6()
 {
+    # mv'ing cgroups is not available in cgroup2
+    if [ "$cgroup_v" = "v2" ]; then
+        tst_resm TCONF "Controller mounted on cgroup2 hierachy, skipping test"
+        return
+    fi
+
     if mv "$start_path/ltp_1" "$PWD/ltp" > /dev/null 2>&1; then
         tst_resm TFAIL "Subgroup $start_path/ltp_1 outside hierarchy to $PWD/ltp"
         return
@@ -141,17 +159,23 @@ test6()
 # Tasks file cannot be removed
 test7()
 {
-    if rm "$start_path/ltp_1/tasks" > /dev/null 2>&1; then
-        tst_resm TFAIL "Tasks file $start_path/ltp_1/tasks could be removed"
+    if rm "$start_path/ltp_1/$task_list" > /dev/null 2>&1; then
+        tst_resm TFAIL "Tasks file $start_path/ltp_1/$task_list could be removed"
         return
     fi
 
-    tst_resm TPASS "Tasks file $start_path/ltp_1/tasks cannot be removed"
+    tst_resm TPASS "Tasks file $start_path/ltp_1/$task_list cannot be removed"
 }
 
 # Test notify_on_release with invalid inputs
 test8()
 {
+    # notify_on_release is not available in cgroup2 so skip the test
+    if [ "$cgroup_v" = "v2" ]; then
+        tst_resm TCONF "Controller mounted on cgroup2 hierachy, skipping test"
+        return
+    fi
+
     if echo "-1" > "$start_path/ltp_1/notify_on_release" 2>/dev/null; then
         tst_resm TFAIL "Can write -1 to $start_path/ltp_1/notify_on_release"
         return
@@ -168,6 +192,12 @@ test8()
 # Test that notify_on_release can be changed
 test9()
 {
+    # notify_on_release is not available in cgroup2 so skip the test
+    if [ "$cgroup_v" = "v2" ]; then
+        tst_resm TCONF "Controller mounted on cgroup2 hierachy, skipping test"
+        return
+    fi
+
     local notify=$(ROD cat "$start_path/ltp_1/notify_on_release")
     local value
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
