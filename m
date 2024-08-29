Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD87C7EE2D
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 07:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724914801; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=NYkaAJwxSVp7GW7r//qEcUuj7NOwUihj1NzqsWxqPHs=;
 b=GR4s+1qybbtGQ/sNUle5KbHM+LoJxsL+zU1L8YFOOGbT2FJwEzYsaRqttGKoEXbSksMhj
 qmmCb04b5p418DyJ7xAWVwu83TvnF6a3HcwxaXb49SqFhTpdsqrqmQPQILk9yAofOSoL3+g
 hxEixg6cnR3dlOaHbY9cT23jAPHiNNo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C38CD3D2788
	for <ltp@archiver.kernel.org>; Thu, 29 Aug 2024 09:00:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58FFA3C1B92
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 08:59:40 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4654F6009C8
 for <ltp@lists.linux.it>; Thu, 29 Aug 2024 08:59:40 +0200 (CEST)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5343d2af735so281829e87.1
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 23:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1724914779; x=1725519579; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlrNPr53Sah6LFPn0bH3Z7GS+hhk6cq19JXTOel+jLs=;
 b=QT6FjQUVQT2uCVu2egE0aHMAwpNXqa6xPkYG7TBFW+9nRlwciPHS6XcqieN84/dDOp
 4yfMnl7sEg8L9HrALzawcMP1JB8O6mZ2XNW26VmwTu3n8lOFcHvC4XZSWSOQerbcWpAW
 6um7EvfF732r84D2G69DaFZp23YSI3B3IbWlY+UXPNKByy+a0qg/42rbnUDC37qPFZBt
 1cMZLiUZDK/RG3qM9wFiloEzij/E6WEK7ctDTvu1bhGLr4jSNFE/m98cAgRK+PCqnDvF
 VQWtjCjt6DneMjvQdIPDQB9NIANjjBpBCeDthpTR0rCvFjQxz656YsydzS9xuMRIQW/R
 EgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724914779; x=1725519579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VlrNPr53Sah6LFPn0bH3Z7GS+hhk6cq19JXTOel+jLs=;
 b=W3B3S6OLHa0I14dqS3qx5p/Xerrtfm35q/t+KkVaWvQje5EZi/dH2r+ncCHH6pPbiG
 5TLcoRiuLaPPeQmxo+42Wmt3Uzsco+4r/tEXYCVGgpDGM5b4i0J8TbdssAcGNJRSa2Qm
 aDCgZcQnmlNVQdgY6Ndj9RMs/6SJ7Qpx9LuK3RioBSSoDRAjsk0jvIhLZuqFI+4pbKkt
 Tv+iZuT9ZkpQU16A31EIRPImZzexwAD7zaVWMVJQA8ycfSAKwBGI0y+Q7eIlFMjioAq6
 2rYjtocEE5A2Jv6im2pDXuk1JFXcs1uLmVbHSETbhktiLRcY4c4ZF/TGA1jP4jOGCQzj
 OW6g==
X-Gm-Message-State: AOJu0YwOoewZLNOC1xrxk8oCpQti9gUOEp27Dv/UGm/h69QmySU4b+5M
 psyTFzfIf3bVOr3QbBsJRTbkCQ/m9prcO6czglnZ0yF+Cl70KvjDn3gk7k41w4Ffr4KHnpfhdmL
 Y3g==
X-Google-Smtp-Source: AGHT+IGYtNHv4l5cjFNxY+a+JvhINJFlGTQCJrtLPgXPnX5xO7t79cRdW9GduDsNdBreKQF5c3UGWw==
X-Received: by 2002:a05:6512:2815:b0:52c:e4bf:d55d with SMTP id
 2adb3069b0e04-5353e53fbf1mr1109273e87.8.1724914779061; 
 Wed, 28 Aug 2024 23:59:39 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8989230a9dsm36851566b.224.2024.08.28.23.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 23:59:38 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 29 Aug 2024 02:59:33 -0400
Message-Id: <20240829065933.21902-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240828134551.6344-1-wegao@suse.com>
References: <20240828134551.6344-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] isofs.sh: Create group and user before check mount
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
index d1a362d97..9114c1d99 100755
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
 
+test_group="ltp_isofs"
+
+setup()
+{
+	if ! getent group $test_group > /dev/null; then
+		ROD useradd -U $test_group
+	fi
+}
+
+cleanup()
+{
+	ROD userdel -f $test_group
+	ROD groupdel -f $test_group
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
