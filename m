Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CDDC54FB3
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 13:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724852780; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=kIKEosyv3rF2FARin8QzeBeGwHK/pJ647I7LgOqIS/o=;
 b=fJLuicT57ap/BlRJ1h/dsn21YRsZjxLzg3/QjOqN1w/gz7uiE8eLbtb9uCmbDI5rTQwCA
 ZvPhSo0jIF7KY72iws8OvjmGca42aYGZKEBD5zmkbZlMzN+9FfffT0QGmoPbPQ1IRyS1Rpr
 SOn1JH5x1bj89WgTCf1Ijhi2QIU+ZnQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A21613D27A2
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 15:46:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55CE13D2614
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 15:45:58 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B19E01B61060
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 15:45:57 +0200 (CEST)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a86e5e9ff05so252405566b.1
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 06:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1724852757; x=1725457557; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=27fB1sv7lJnHTJvSQ7aumWnJOwQ01sswBp6MSI50Eg0=;
 b=GOi0SyWQsJEesDdrqWQDN7dvFtVXzTZnfCInkeeT+p8gnn0YWL5XErCxnvcnlOHX9H
 wWR6d/pr1zBznTadP+hCw0TSVCuDBpE6+GUB1/D7zLLKBpJ6izxuYQj/HA1Q7SR5m2bv
 YJDxeKxuXm5IqelDv+IaWMrY5VdaL5dl5KYUrWLDawyC4YdwYpBNzh5aI+3R/GRHuzht
 jZEtQJ6sdlhuqiWhWlC3lF6/XD9ias8PFcFCf4ZJRC0aFI/iiG9bVg1xhVhJyVQFxaoP
 zUJZyL53n2Or/EqL7b+TDQuzjtpcmmMJeaBBqfz+oCjfy18oibisQbtHeFMOEaeJCdMc
 6H2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724852757; x=1725457557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=27fB1sv7lJnHTJvSQ7aumWnJOwQ01sswBp6MSI50Eg0=;
 b=dhomecU/gjOvb0+ZFHTfHx9p40FnWOtZ91XClutY+iwIbcgFHivATwYbKifb5k/EU7
 pIXn8qmCkVdidpTKsh95PqovyqPA0lUCXMaDGjyxN742/OPXNZtFFx1qyEfh2lRnXyFf
 zYpvTCG8vQF5WanY9Lws7t26nyjioK1sxi66XwWgKLuzEsjFxMvCcCi7DExPawf2JBiM
 V8NKYpdWZ+mPrAyDFnnMbfbYkJQLrDNtN8EMWVtFU1+ZOHbTA/zNLSPqmCkR0tTOyE7p
 kC17CmayL7Qo2SDKWJBrV8dEbR/o5TTqqUXWy4Tyjpc7DxGWlasGXncPgPYQ1cXdubdz
 yzaA==
X-Gm-Message-State: AOJu0YytkAwBUCDzN+vk6fBwJ8dPKPwaFYRK7f6eTsO7LwaX2hdAgdaM
 SL7MCPCNq0J3X5kV4VWqOpEXlsG1Zy+wM5MK4e5xK1XM1uJ9aejIaL/IzrfX6cEUd3q+NUeL92g
 TDQ==
X-Google-Smtp-Source: AGHT+IFW77icXI1sTwuwBBAPw/upCQ1V6nQZLGWWN63Kiu9R87ah9/OvD6iDszcF3od95nfZvZB6YA==
X-Received: by 2002:a17:907:7ea2:b0:a86:9053:d93a with SMTP id
 a640c23a62f3a-a870a9d7f73mr150600666b.31.1724852756189; 
 Wed, 28 Aug 2024 06:45:56 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e5486994sm252020866b.14.2024.08.28.06.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 06:45:55 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 28 Aug 2024 09:45:51 -0400
Message-Id: <20240828134551.6344-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240828052500.2395-1-wegao@suse.com>
References: <20240828052500.2395-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] isofs.sh: Create group and user before check mount
 option
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

Case will failed if default system has no group named "bin", such
as suse sle-micro, so this patch will create specific group for test
instead of fixed "bin" group.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/fs/iso9660/isofs.sh | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/fs/iso9660/isofs.sh b/testcases/kernel/fs/iso9660/isofs.sh
index d1a362d97..812df1caa 100755
--- a/testcases/kernel/fs/iso9660/isofs.sh
+++ b/testcases/kernel/fs/iso9660/isofs.sh
@@ -13,10 +13,27 @@ TST_NEEDS_CMDS="mount umount"
 TST_NEEDS_TMPDIR=1
 TST_TESTFUNC=do_test
 TST_CNT=3
+TST_SETUP="setup"
+TST_CLEANUP="cleanup"
 
 MAX_DEPTH=3
 MAX_DIRS=4
 
+test_group="abc"
+
+setup()
+{
+	if ! getent group $test_group > /dev/null; then
+		useradd -U $test_group
+	fi
+}
+
+cleanup()
+{
+	userdel -f $test_group
+	groupdel -f $test_group
+}
+
 gen_fs_tree()
 {
 	local cur_path="$1"
@@ -92,8 +109,8 @@ do_test()
 			"loop,block=512,unhide" \
 			"loop,block=1024,cruft" \
 			"loop,block=2048,nocompress" \
-			"loop,check=strict,map=off,gid=bin,uid=bin" \
-			"loop,check=strict,map=acorn,gid=bin,uid=bin" \
+			"loop,block=2048,nocompress" \ "loop,check=strict,map=off,gid=$test_group,uid=$test_group" \
+			"loop,check=strict,map=acorn,gid=$test_group,uid=$test_group" \
 			"loop,check=relaxed,map=normal" \
 			"loop,block=512,unhide,session=2"
 		do
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
