Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EC4C5B543
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 02:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749090630; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=gNsRAy73t7PRnnhfMI1tUTtlLWManOZv8hMxs0L+2m4=;
 b=aBmVUABfGy0L1evN12a6Zny92DcDBUYcuMQgRz0q9csj6gp/caDZGUCe/IIG6kxweCAzl
 MeqIGUBCLLaOifjj+D9eDqUEU0hjFlE5bf6uMcE4iIXYmM+yHA2PQGawyvAEzhN2miEq7HD
 mbhc5Efwc1EXhpGwEgw9XYIRi2ysntU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A7EE3C91FB
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 04:30:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D05883C91D9
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 04:30:08 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 03C5120651D
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 04:30:07 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-450cfb790f7so3258445e9.0
 for <ltp@lists.linux.it>; Wed, 04 Jun 2025 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749090607; x=1749695407; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oSyZsPiDyzF8zEgI5LBNJGcS1WVxgufDl1osj34UZYU=;
 b=UGeQc09bu1hTyNUqLFEpk0AAi/ek3fjxtcqrc53XLJhzhA9XqUjfXN44bY90ooahxg
 s1JpCIjBS1T4x4DmPjicv0bKK4f9YTL48cvB7YhdjRKWrOCV5F2oWgmfzNi2YB+pScMQ
 foIHaETYQyUBsqjFVDgaKPnwISpfQ2wXQ5f/3luxC48O5EHeoxt0v2380/bWQDxD8JmT
 SwbZjk0+51QOUM7n1gwIdbhqNnqGSt106jyaST9GPOWWIapDR4/Q+Hb995KhufkBOC0w
 UOutHk9abeiDeTfqu0moOKxpWJJmyzVRw5ZivXpv2Jxnqg5B7tyJcKQjaC0F2agmfVub
 KwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749090607; x=1749695407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oSyZsPiDyzF8zEgI5LBNJGcS1WVxgufDl1osj34UZYU=;
 b=ZXl3i7PXjZOG4Kmw7s2Tfx8I3WWyrvEANJNqR0hzOusoxcx/uPSQiH4ld/pSSdzQS+
 gwJ/YvxTqFwA55cKk9lIC9SMbQRP/jMGk97b87ZkV6YEuHm1e7NKnLy+8wGUwrEEGZXO
 LdkI0qRfabAGpK5M9bQkDmYIUB7LW03rTnvN+PuFqOUZ8VUyHRwXSC+8PqkACCTgtEbl
 R1lZUflWM+LiS+T8x7hTZrJCWfJLIGLaX8zOBfTwkmeQVWuwMGELGPbZNkOWItk4g6uA
 RuXhqCvnFH0cebMUQAdHEugeKVKG14L2tA8AwJcKZpyj5EKblxiHYTRo4cas/sI9bmXL
 2J0g==
X-Gm-Message-State: AOJu0YzXsuvvrtVe74KGh0pO6qo50Lk7GifuCymHl3HGEYq8/+yclkyW
 QSGFbMDL3FujRmNidDCUj7gmUTqDJ3DjIlSh0pK18yvKFfDDM0C39+Pe+S7YBaJnekKdm9plEnJ
 wK9s=
X-Gm-Gg: ASbGncv9ywrkBqp9OESOd1zIxO6t+Px/rbhwRzoWTpVYJJgd4apQe5hb6hDl8HvBUjA
 fIpG9yWbHSSi7Ye8hmu5+IeB8cEatkAJ2JlGmWQQFCXMWpMRZ1igJ2E6TSKxGbgmOankj040voc
 q+CMySt+v9/hbyd9Wbbb1HEX2sgNLFzzRtrROLiHF0j0b1AC4lDwlBzIQxspAcXrP1gnXwq9Ifp
 bbF+B51/8VfactAgHhOHf0KlaWkbqjWp9o8DDBjn5d6HnQRu3JsnO97iI3OKzH6eBLS0nb9GG04
 zbudfOwTNm/bArkRFiUgRp/mO/FQg71PV1Pu+0twBYg/DPsJg6w=
X-Google-Smtp-Source: AGHT+IGRmIqYfXl8U+bxFRQOh1ygiZluxmXbDle+dZAPrBPvc2a8HGC2l+x2vC6b6+wlL+BAsvxGoA==
X-Received: by 2002:a05:6000:2303:b0:3a4:d898:3e2d with SMTP id
 ffacd0b85a97d-3a51d92f833mr4249175f8f.24.1749090607083; 
 Wed, 04 Jun 2025 19:30:07 -0700 (PDT)
Received: from localhost ([202.127.77.110])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-23506cf3c95sm110446505ad.159.2025.06.04.19.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 19:30:06 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu,  5 Jun 2025 10:29:40 -0400
Message-ID: <20250605142943.229010-1-wegao@suse.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process into
 absolute root cgroup (0::/)
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

When the CONFIG_RT_GROUP_SCHED=y config is set, test cases like sched_rr_get_interval01
will failed since limitation of RT processes with cgroup v2 cpu controller.
The limitation is RT processes have to be in the root cgroup before enabling cpu controller.
By default the shell will not running in root cgroup "0::/" since systemd will put shell
into 0::/user.slice/user-xx.slice/session-xx.scope, so ltp case run within shell will failed.
We can use this patch to workaround above limitation. If we agree on this patch, i will
continue do same patch to following cases:
sched_rr_get_interval02
sched_rr_get_interval03
sched_setparam02
sched_getscheduler01

Fixes: https://github.com/linux-test-project/ltp/issues/1245
Signed-off-by: Wei Gao <wegao@suse.com>
---
 .../sched_rr_get_interval/sched_rr_get_interval01.c         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index b4d75bdcc..55516ec89 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -43,6 +43,12 @@ static void setup(void)
 
 	tp.type = tv->ts_type;
 
+	if (access("/sys/fs/cgroup/cgroup.controllers", F_OK) == 0) {
+		int pid = getpid();
+
+		SAFE_FILE_PRINTF("/sys/fs/cgroup/cgroup.procs", "%d", pid);
+	}
+
 	if ((sys_sched_setscheduler(0, SCHED_RR, &p)) == -1)
 		tst_res(TFAIL | TERRNO, "sched_setscheduler() failed");
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
