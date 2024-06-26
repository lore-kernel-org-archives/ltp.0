Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3573C3064D
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 06:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719384814; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=fhjJ8geF04mg6vAIIBLBLPzHch+JBfprs1g6xKlHLVA=;
 b=E9U/P5hkFUtt0iq+FbbIyvDtXoOUftJzkeNUcLpq6xVkjLQY2DqcHpJVsf3c9fCyMRorf
 bUVajlqBrsT6wO5bmAT01CNXMEPn7ZZeptsN940fqA/rGeuAQy8ooo1Xsa+DbdPntLC8fGC
 f8YgHz1ueJtzdrKD+hLc/3kUZddMNbQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 663333D10CF
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 08:53:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A437E3D1091
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 08:53:10 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 46F16609A35
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 08:53:09 +0200 (CEST)
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2eaea28868dso83561941fa.3
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 23:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1719384788; x=1719989588; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4KXbnaSUT68sUxgKnTX9GjliXQeJahroRVyX3ddkFM8=;
 b=giBjVR3wBSyiO5bdcRUdxpE1WOsGWcVRLPX36RFyov879OdHztWw+vZqmvbTohE5+P
 9H56t2mJjqRxasWri0RyrNz1ZTDkXZQNIjwBJCdJndvJMJJKQtiSbmmhmYxjOx0QKr1M
 YtEOm+Mz5aHoOQLk4AmZq7xe0oA9nKQ31FLmYGMuluX5NUFx6qgnnEKVhorfn+9FGSJF
 eGIXo8zUMQHqC7wgQLRqAzZgY4Hx/rHICp2h0fRzp8lBIiPDdeeju448+VajZW754Ia3
 1V2Kvnp4YfuNMCrjrLzzspLdVvdQ7LdJEEvttc29WQcDHite9cnSf6Zo4b7PCZgXG4Jm
 vZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719384788; x=1719989588;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4KXbnaSUT68sUxgKnTX9GjliXQeJahroRVyX3ddkFM8=;
 b=B+CylHz2tTkytQ1jydacTZ0YJm9i14Pno/P0oiGVwtalCJG3LEzCZB2safsPEvxVt+
 D5Dl8kj1L+89mtyhvhhQw/L8p+oDE6YQLmdB7BWOm8abBVBsvn2AoWESIAX3JkIDpiuJ
 oFNlLXRYEUw7Au6YjzlUoex7+91Xi1SsAF18Ch5jJnRN+bmSCpHDNd6Ga2wzdiGkfDao
 m5D/cxgSnu8n/A6ljFZUeVdRHXtFanRzbinQLfKREEETK8Qt5lGAH6CwdOTW4J8fmXlq
 wYwFN8nv7f6d0/KngHoaxnxWz1AEa1cd45/dRosHxztGotEkGdeVSIg6IaHXBDOr19Ow
 35hw==
X-Gm-Message-State: AOJu0YwMWwF4UWGL/3JEpFduoOngdUMEhucpf9BsG055FDm2YsAh/Uhx
 fwHo6pxGho1lV1DBcYIWkhn04VwoEonWUVtmg3KAB1CosHZWTgTIHxGuHi71Zo/SCA4zHVDRQe4
 =
X-Google-Smtp-Source: AGHT+IFqIbwgSBopeELsen3Gdcgc3UsVi88NIfmphoa3iat7Fh3CkORZmV2fSkXrWdZC1EpkT9FQ8A==
X-Received: by 2002:a2e:87c8:0:b0:2ec:a022:880c with SMTP id
 38308e7fff4ca-2eca022884fmr15346931fa.22.1719384787778; 
 Tue, 25 Jun 2024 23:53:07 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7069d59dce1sm2218264b3a.169.2024.06.25.23.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 23:53:07 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 26 Jun 2024 02:52:57 -0400
Message-Id: <20240626065257.14367-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] cgroup_fj_common.sh: Disable cgroup controller in
 cleanup function
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

If you run "cgroup_fj_function.sh cpuset;cpuset_base_ops_testset.sh"
you will encounter following error and cpuset_base_ops will be skipped:
cpuset_base_ops 1 TCONF: Could not mount cgroup filesystem with cpuset on /dev/cpuset

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
index 6d5586534..e866641ba 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -76,6 +76,8 @@ common_cleanup()
     [ -d "$start_path" ] && find "$start_path" -depth -type d -exec rmdir '{}' \;
 
     cgroup_cleanup
+
+    [ "$cgroup_version" = "2" ] && ROD echo "-$subsystem" \> "/sys/fs/cgroup/cgroup.subtree_control"
 }
 
 . cgroup_lib.sh
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
