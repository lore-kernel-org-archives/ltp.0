Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A80C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Mar 2022 23:21:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD9C93CA3F3
	for <ltp@archiver.kernel.org>; Sat,  5 Mar 2022 00:21:51 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71CDF3CA3FF
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:58 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E2478200923
 for <ltp@lists.linux.it>; Sat,  5 Mar 2022 00:18:57 +0100 (CET)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 921B43F613
 for <ltp@lists.linux.it>; Fri,  4 Mar 2022 23:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1646435936;
 bh=6i0BCxmqKwBl1nnGesFsEOkqSvj3sOrTD4e81md/lPw=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=kIQN1evuqfVGgAjauTkBQy7xl+xb/ivnMiEqMOYJ0ILmidcdgjeV2ENsiHcf/CasO
 I8ID5HDCb8JjePPc5Me6YwNKHxQ8+q3RT3BMwJxKAFUyoK16AArm16yTDjUzSHNu7O
 HdN4DcX59FtuyyPppnut6vRJXnxPsAFVGEPns7xCj1scqe3z3YltXW+5NdKSktMQJL
 KZkt5ykb7EKQqjS6IsmOaSV4XR9E6PZZKGXMD6mVNaiCUk1z+hJnIkVzTUgd6T0x35
 7o6MUc5+6yHD/uJ0xy6s4mlhH0i2CiuTMo/vvtVzXzMyJZG7csCBC3cOhmz+GDDoZP
 OdQA7mMu9RtoQ==
Received: by mail-pg1-f197.google.com with SMTP id
 o30-20020a634e5e000000b00373598b71d4so5214909pgl.21
 for <ltp@lists.linux.it>; Fri, 04 Mar 2022 15:18:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6i0BCxmqKwBl1nnGesFsEOkqSvj3sOrTD4e81md/lPw=;
 b=HEiPbLzouyoOWVACNCuBi0F+8ms5xxvYXTOmI42b2/ssWgH/6wxOtCuKqaunXHNZy/
 HlaK0PnmmN0gxMnxQw/X5RVP3mSqSG7gX4ek6bUjLGg51t2dMTt62GLbvYsdA3+T4gee
 S4+/Zui894nfnQ65xvnt5dtktJzKpjrjoUsN5VQ1E3TThhydtwHsVwunXGwfgvzyWZpY
 GpckrbkWmM167wzzj4CZVNKG9ZOMnNiJ8XkW8VshW+t/qBUPfvWtrTt3ZfPoTOut77tt
 sb1UkciTDFgbqyGl2WGFFVddd/mZ2sUzsKmvAptl/yZGejfNRJy0yTUgp8yl6WM3RfMv
 w50A==
X-Gm-Message-State: AOAM532S5g7TPrhdt1BP3no3GxagYrpFvGtrRkZcGxwlovLCYMMaZrKl
 hYM77lwbbAyiyntp3H6jZU5FSZZgitwxKAUCCMeDURlpO7jME2h7Ulpi0cB+Gq9e4Dz/NhETcXm
 ZeiZJDaqGqbD8QNvjaE7PFyysn7Zs
X-Received: by 2002:a65:6c0d:0:b0:364:ae2e:9708 with SMTP id
 y13-20020a656c0d000000b00364ae2e9708mr595042pgu.189.1646435929989; 
 Fri, 04 Mar 2022 15:18:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy5KaVA77lp0W7w7iRgUc+hzBXO8pSU1S/UGDNbFVwZaJ/gis7lKRYULVynQgb+G+0HxCnpzA==
X-Received: by 2002:a65:6c0d:0:b0:364:ae2e:9708 with SMTP id
 y13-20020a656c0d000000b00364ae2e9708mr595030pgu.189.1646435929733; 
 Fri, 04 Mar 2022 15:18:49 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101]) by smtp.gmail.com with ESMTPSA id
 h14-20020a63384e000000b00366ba5335e7sm5335760pgn.72.2022.03.04.15.18.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Mar 2022 15:18:48 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it,
	rpalethorpe@suse.de,
	liwang@redhat.com
Date: Fri,  4 Mar 2022 15:18:25 -0800
Message-Id: <1a1841553e6687d34701afd40ad0312dca5c54af.1646434670.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 15/16] controllers: update
 cpuset_regression_test.sh to use newer cgroup lib
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

Update the test to use the newer cgroup lib which handles mounting for
v1 and v2 controllers enabling them both to be tested and cleaning up
the mounting and cleanup process.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: Change variable cgroup_v to cgroup_version

 .../cpuset/cpuset_regression_test.sh          | 26 +++++--------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
index a6806b7b0..67fed791a 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_regression_test.sh
@@ -123,18 +123,13 @@ cpuset_restore()
 
 setup()
 {
-	if ! is_cgroup_subsystem_available_and_enabled "cpuset"; then
-		tst_brk TCONF "Either kernel does not support cpuset controller or feature not enabled"
-	fi
-
-	# We need to mount cpuset if it is not found.
-	root_cpuset_dir=$(get_cgroup_mountpoint cpuset)
-	if [ -z "$root_cpuset_dir" ]; then
-		root_cpuset_dir="$LOCAL_MOUNTPOINT"
+	cgroup_require "cpuset"
+	cgroup_version=$(cgroup_get_version "cpuset")
+	root_cpuset_dir=$(cgroup_get_mountpoint "cpuset")
+	testpath=$(cgroup_get_test_path "cpuset")
+	task_list=$(cgroup_get_task_list "cpuset")
 
-		ROD_SILENT mkdir -p ${root_cpuset_dir}
-		ROD_SILENT mount -t cpuset cpuset ${root_cpuset_dir}
-	fi
+	tst_res TINFO "test starts with cgroup version $cgroup_version"
 
 	if ! [ -f ${root_cpuset_dir}/${cpu_exclusive} ]; then
 		cpu_exclusive=cpu_exclusive
@@ -181,14 +176,7 @@ cleanup()
 		echo ${old_cpu_exclusive_value} > ${root_cpuset_dir}/${cpu_exclusive}
 	fi
 
-	if [ -d "$LOCAL_MOUNTPOINT" ]; then
-		umount ${LOCAL_MOUNTPOINT}
-		if [ $? -ne 0 ]; then
-			tst_res TWARN "'umount ${LOCAL_MOUNTPOINT}' failed"
-		fi
-
-		rmdir ${LOCAL_MOUNTPOINT}
-	fi
+	cgroup_cleanup
 }
 
 test()
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
