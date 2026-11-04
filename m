Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD753608360C
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 20:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793824586; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=2ykjXTifyQxYAm7wZy8A8CEeyIiuZwYXqpEXBUkUwxs=;
 b=VWSoTId8Q/8pB8gDwQH8tHdXIO09d/7uZUM5Daoku2nXkneHk4RefuXkp0Dv77FoHbToe
 UyIQmROgc0vfbII0J3YYUtp7pB/y1Kw2fDjYa4BL5wqhbeCw2JR76j8L4UONlNDQFpB73Yh
 xJlDVPFJbS4HZhbf49kpIjUAq4KMaKw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 543113CD3B4
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 21:36:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7FF2B3CAB26
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 21:36:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BA34B6002C7
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 21:36:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793824563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bUmiuoXqkKJ1kfb6/t2qqxcWHMfw2Sy3ixcQZJrCg7E=;
 b=YvZmisOubXR4nelmCO+Gc1ya1a7W1vmhCFdnKJYdM6IsuJvvM13cdCJLyFefecwwUbypFl
 49+u6ORSRzK9dENHjEZj37Dk0WFQtHlVIFxHAJd3qoKhXpXI1PfUapPRdVgOXivqj2dE5n
 xrSb50iYT88W9/UFoN5xWO0EoWwUOvE=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-69UTrTEHPi2_yfWswDVkTg-1; Wed, 04 Nov 2026 15:36:02 -0500
X-MC-Unique: 69UTrTEHPi2_yfWswDVkTg-1
X-Mimecast-MFC-AGG-ID: 69UTrTEHPi2_yfWswDVkTg_1793824561
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-88322409239so18626267b3.1
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 12:36:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793824561; x=1794429361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bUmiuoXqkKJ1kfb6/t2qqxcWHMfw2Sy3ixcQZJrCg7E=;
 b=DvZM1ZSN9sRNexWIZ9rf6MX9yt8C8vHIL62YkZDpvYExpxUXycGtBqdvSKyWCYsgNA
 6l8RdCEEdbWUm63FilwEKBjpgLzZgpmNy6guv4A+Ha8QOMHEXq8EC2v6BuFZUQjSxJDb
 WVVo/NSKF97XphNSOC5ddWXQ4zMrG1KtBz7Flp3+TFMG2LXAC65tQGpRwmaoCeXav1zo
 M/DkOtDGyK6j+974rN2imNavW6tP0qW/Wq0K9c7c7fXy6bjZ7D8vXQvvmLluypqttQeT
 HKZRKyRgjGwAMXF/IIciwMs5SF6iFkP6FTbuAF7NXyzzQHghkFjcUMPE1Jk4rep2loiB
 SvUQ==
X-Gm-Message-State: APuU4Z+I+A/CGQkCmFPMKb88vd/iSm2U8NCOLADvUp1zkWwfdJptruKV
 Hf9q1PBa6PSU0SrKqMw/RNBngyaar7aYTPOPgcarb/KJZd6pQnL6hUh0zhr8T3+A0sSXSI5rudE
 UazVKT/58yG04ik3aW7Q2CShdkZvpSvE4wLrw74sV6R+tXUUpkVnJ8XBkjEdPzKjdO3KsmZlnRM
 Hv53+hHE+p1qskgAPaMJoR9aTgYCF1bj1sm+GE
X-Gm-Gg: AYBFou39E0L11WwbE8a3PA8GxPIGsVSoLsgDiAcfAEs/W/mGMNyuAuM6nh20iPT0txa
 oEFPCh51w1uLYpwSqGOjRbExMd8TuO+UQkiOBirMJJoKcd+OGYTA+JikvypizVt4Kx/1jRKQzlz
 riMcjpBh9/kjW1ff+VMHxxOCfBK9qe2wGpQ+ASdhiC96108PSOOaK/H3g807VBqy7DZue29+NLC
 QH8BffkWRoBG53lpCFtGG+K+nRSTiFVHL/bdTQPpKqc8TAU+JaTNvdjv+/FjhpMOoFiEYFay/gY
 gSWo0lkmhijf8+u1Jy/Hs5KAlyfH1h1CDBFmGF6ZTezFvIlGXLaj9nuz3kC6Eq8xpoqbOJr7pm2
 GzvDDtDot8O6Gqva86ozYON3cAKqHtuQY/rP0f79r0DZ5nqN/M1el84Qosk4G3lTe4jQwVkciXf
 8=
X-Received: by 2002:a05:690c:e0dc:10b0:8b0:d9ff:4f74 with SMTP id
 00721157ae682-8b2b678f3d6mr98982777b3.42.1793824561565; 
 Wed, 04 Nov 2026 12:36:01 -0800 (PST)
X-Received: by 2002:a05:690c:e0dc:10b0:8b0:d9ff:4f74 with SMTP id
 00721157ae682-8b2b678f3d6mr98982597b3.42.1793824561012; 
 Wed, 04 Nov 2026 12:36:01 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.csb ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b309354759sm26451267b3.0.2026.11.04.12.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 12:35:59 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  4 Nov 2026 15:35:50 -0500
Message-ID: <20261104203555.475536-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104164638.407069-1-sbertram@redhat.com>
References: <20261104164638.407069-1-sbertram@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s8Yp3vrPqXy0CCVtvRq85XEeIavBeQgm6dov1wTpyzs_1793824561
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] accept03/tst_fd: Harden parallel runs against
 shared path races
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Stephen Bertram <sbertram@redhat.com>

TST_FD_FOREACH in accept03, epoll_pwait06, ioctl_pidfd01, and
splice07 creates fixed fd_file and fd_dir names in the current
directory. Parallel runs that share that directory race on those
names. Set .needs_tmpdir so each run gets its own directory.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 testcases/kernel/syscalls/accept/accept03.c           | 1 +
 testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c | 1 +
 testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c       | 1 +
 testcases/kernel/syscalls/splice/splice07.c           | 1 +
 4 files changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/accept/accept03.c b/testcases/kernel/syscalls/accept/accept03.c
index bc472397d..dea4988cf 100644
--- a/testcases/kernel/syscalls/accept/accept03.c
+++ b/testcases/kernel/syscalls/accept/accept03.c
@@ -55,4 +55,5 @@ static void verify_accept(void)
 
 static struct tst_test test = {
 	.test_all = verify_accept,
+	.needs_tmpdir = 1,
 };
diff --git a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
index e12d9d394..b30b7289b 100644
--- a/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
+++ b/testcases/kernel/syscalls/epoll_pwait/epoll_pwait06.c
@@ -78,6 +78,7 @@ static void cleanup(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.needs_tmpdir = 1,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_variants = TEST_VARIANTS,
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
index 95c0e8f3f..629bc2a1e 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
@@ -56,6 +56,7 @@ static void setup(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.needs_tmpdir = 1,
 	.setup = setup,
 	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
diff --git a/testcases/kernel/syscalls/splice/splice07.c b/testcases/kernel/syscalls/splice/splice07.c
index c750a14bf..c42e7ecd3 100644
--- a/testcases/kernel/syscalls/splice/splice07.c
+++ b/testcases/kernel/syscalls/splice/splice07.c
@@ -69,4 +69,5 @@ static void verify_splice(void)
 
 static struct tst_test test = {
 	.test_all = verify_splice,
+	.needs_tmpdir = 1,
 };
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
