Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA128CD3436
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 11:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778067449; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=nurL+9twBOeAoI9m1qGsuSrhKCwnBAMuSJzeoKio0vY=;
 b=dMK8Fm4TMvVqRjXR6+n9QyHCjzDuWqikOiDKevrOb9DyvkUyjmSe10KQHIlLgCjkeyoj5
 yZZxR6R54mbstwaM6Xk24vZyHWNvphSUJAMamOFj8s4sMpzOLjKJmEHwGbocxPJFHXSK35E
 dp9BNqcMGT+K6kv1q6h+1AixNAAX8jU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57BAA3E6156
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 13:37:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DC813E2CC3
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:37:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2741010009DA
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:37:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778067421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jwau9/uKRXTuowftiIELM0UQcpfs4i/wgqca84bJBJQ=;
 b=G7TY/5gaCjbSIesy6N5j02jIhwzRn+a+F08mMjVf964tXF1egp1gJZg6aYI3XBjLZXHUTU
 QoEtvVy9d4Slj5PqAh8t0AVSIYkyjkbtKg3zBY6xlkQt+4CGcuZSufTqN2v8aHvm/ue05y
 G4tf4kmwui+e86k1b2Ds+J7V6Bz43II=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-rIXFlTYMOAypVFxzIzbJ5Q-1; Wed, 06 May 2026 07:37:00 -0400
X-MC-Unique: rIXFlTYMOAypVFxzIzbJ5Q-1
X-Mimecast-MFC-AGG-ID: rIXFlTYMOAypVFxzIzbJ5Q_1778067419
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-44a3aee3813so2690917f8f.3
 for <ltp@lists.linux.it>; Wed, 06 May 2026 04:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778067418; x=1778672218;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jwau9/uKRXTuowftiIELM0UQcpfs4i/wgqca84bJBJQ=;
 b=lpAtS/yPZQfHfEw/6ma0KzmmWE5PHtwwif9WcQcH1EgpIqc1IubT7R3P2FsV90Fzl7
 3LSmkMvFDr+HGkMJQfY9kg94Y8eCnK6CwpGJkE9secK91k9ggRCiV4o31Sa3IpkUEiku
 /z/rBkq1FsANYV1O71TiLaGIJ3DlT6inuFpLTB/LJUVyGUdf29DSDrIRm+xCA6SgIkN9
 NQp1kmT4rDVvljZOnB+umzOdlRwK1SYVb5ziDHYSqYpxeAA6hJ8MzPRtipDosvm239LX
 VjRWAdYIHfFSzEWPkBRVyUyBRrqP1DkuPFfFvggzoa5AImVuOwAqvdq34BbcpJDjLGFC
 YNGw==
X-Gm-Message-State: AOJu0Ywlga1j96y0cwnYvq2Du7Mm9hWn47pkdGNmTwCvT39q+UutHzeU
 wDmfBxQpsqpmwZVnHIVX9sWqmICRvPM9/o5L52TINVkt5gV50LYPcr3oqEV9WAuLOp1tYS3QWaL
 O8+D6ceSNpOZQKomCY0miEaT8RJnYsA2D1Ju9e1AVJuL7GKHQdEj4M4jTFPTiAXGo00Efym6zU5
 2YHRRljrVT0PU0zNBwdW4v3nz1mJHhaoQcrNG2
X-Gm-Gg: AeBDievuP1GZNxR6Yl8l6OMVBGpAAuS/oNbl04u/Tr8lg0tr9BfIdcHUd0OKs2UeqiM
 o21cxIKlv0yUPp9B+sczX8zfvwryivOlYh+/Z8kZPRTO8HhbeYwKGnr0A/WA2z5sNHOFSZxqN2N
 TR6PhjEY9NuS6SRdKNTMMeXTHxc3aHIbrEPiwzcAmT5pkZXvRdFYSfvbD4oxcdaiF5/nog1br5Z
 c7qFARs+tZbBti6oWGUs6Hyz4knrrSuFtU+/+rq3CAcB43CbonI57XSQ30q83Bza5OoC4FhlJ9h
 ePuME0gX4YN+8tpVK/ey9Fe7ZLaUkdYutGxUU0ToNVZo6yDwJOQhoDah49d7UvaQNUoXySxHl6S
 tCdUmuhSFo9QGT6gjQ01NyyENDeMdN9iz4tVCWgsATVHbkyj5cvk5p7lSlGdyOSCkyqxUUPTbac
 8yCIyUbQ==
X-Received: by 2002:a05:6000:2f87:b0:43c:ef4f:79e4 with SMTP id
 ffacd0b85a97d-4515dc808b2mr5045134f8f.37.1778067418379; 
 Wed, 06 May 2026 04:36:58 -0700 (PDT)
X-Received: by 2002:a05:6000:2f87:b0:43c:ef4f:79e4 with SMTP id
 ffacd0b85a97d-4515dc808b2mr5045090f8f.37.1778067417826; 
 Wed, 06 May 2026 04:36:57 -0700 (PDT)
Received: from fedora.redhat.com (85.65.168.167.dynamic.barak-online.net.
 [85.65.168.167]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960022sm11919938f8f.26.2026.05.06.04.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 04:36:57 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed,  6 May 2026 14:36:51 +0300
Message-ID: <20260506113655.10797-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NkMNLAx0xJcOiWomENWunwt0mpPItHnP0ysMvVWN2HE_1778067419
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Improve error handling coverage for futex syscalls by adding tests
for missing error conditions that were previously untested.

futex_wait06 verifies EFAULT is returned when uaddr or timeout
points to unmapped memory.

futex_wait07 verifies EINTR is returned when futex_wait() is
interrupted by a signal.

futex_wake05 verifies EFAULT is returned when uaddr points to
unmapped or PROT_NONE memory.

futex_cmp_requeue03 verifies EFAULT is returned when uaddr or
uaddr2 points to unmapped memory, and EACCES or EFAULT when uaddr
points to memory without read permission (PROT_NONE). The EACCES
behavior was introduced in kernel 5.9.

Michael Menasherov (4):
  futex_wait06: Add EFAULT error coverage test
  futex_wait07: Add EINTR error coverage test
  futex_wake05: Add EFAULT error coverage test
  futex_cmp_requeue03: Add EFAULT and EACCES error coverage test

 runtest/syscalls                              |  7 ++
 testcases/kernel/syscalls/futex/.gitignore    |  4 +
 .../syscalls/futex/futex_cmp_requeue03.c      | 96 +++++++++++++++++++
 .../kernel/syscalls/futex/futex_wait06.c      | 73 ++++++++++++++
 .../kernel/syscalls/futex/futex_wait07.c      | 91 ++++++++++++++++++
 .../kernel/syscalls/futex/futex_wake05.c      | 86 +++++++++++++++++
 6 files changed, 357 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_cmp_requeue03.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait06.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wait07.c
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake05.c

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
