Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65929C25B75
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 10:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717410987; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=GhPV05Xpa7+BZAiihtsX1RTsPT76K+hlOezukxbks0I=;
 b=DOOtzYMxqOAVbCiRqQIQFU6XvZV8763u7aqtbVkfHy6TqzD7fauJaszBQknMYI6s5pnlh
 AaIul0JVuIWrigl58iE7EjJSwWlgewUsWHyIyPlM+JYTk8kmEt9hzCkRB4yOsCrAW8b8TWE
 6Mg65r39SBzIPQIESMP1z4/JuAZcfWE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B54793D08E5
	for <ltp@archiver.kernel.org>; Mon,  3 Jun 2024 12:36:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5B7B3C04BB
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 12:36:05 +0200 (CEST)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 595AE600F3B
 for <ltp@lists.linux.it>; Mon,  3 Jun 2024 12:36:04 +0200 (CEST)
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2eaa89464a3so13039521fa.3
 for <ltp@lists.linux.it>; Mon, 03 Jun 2024 03:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717410963; x=1718015763; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBznA3g8uqMq3D0gX6KTUObzS3mQzJwLK+QF1iDz038=;
 b=DTaBPGgyWMCdTf8jNdbwFL6M8t6tE5othErhcHMMZwnhZo0YC2QprtIo9BPAIC43Ng
 sWatATHBoVYNXe+gEy6KFP90Y/0YWrFbRysKl62Z072I8wr2+/4ccYiKdtuCWg16olpu
 uiO/pw1B/L3V0Da/lfQcgP2f8vAOpK/BpDMC/+MIBZj+9lncg5S+PxSg4VhOaUmrNBXr
 tE6TakHNva1u3Z6UCDcQIQRRLI6m9jgW+MW01co7QKize2bn9RrB2Y/sDh04kCzz8oT0
 J6QkZQGRQ55VSeCj+dw1kaD0qcokW47nuBwSA5BEvutNqV/4LqkWlJx9Jowg57PTj42q
 uVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717410963; x=1718015763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBznA3g8uqMq3D0gX6KTUObzS3mQzJwLK+QF1iDz038=;
 b=psBcnGZzZd4Z/bWwn1jEC1GDCT2AYTvnIlfCWIg7LXhpG5RpH0xDiBJlDtdLQ4kAhw
 vD9uMc2Id6UVpmfYQdC02glaqxeul+SbEiQtL+hy+CX/TZivEREwc9pNYCm4nt6CGPAr
 vLpooS+o9fyBufqU9Jfgr3FkPSVNvo+7vp9V/unTxKBveKeO8q663FUr0wOpuHGFBhMz
 ESj5CJHJhpkiAjcEZdocWASO4HbZwDbkCfx+D2fyKdBeGrRz0lJ+n5o4MV7u/0CUEzc1
 hG3QcM9/HJzH+jxNVVSW9GihkWDXctkiepi8cwbUzhsazwacki9VaROaGjZVbERySn1u
 JI4w==
X-Gm-Message-State: AOJu0YwIaUlkofsNAiwTHhW8vMqYK5S8lbvlbV+QWE4+sOLEf7E9mXwd
 f+l5d8nD1ekjks92MURj3x6Nz2JlEBTTkVeQ5i9OR4mB9vX5CeZw4OEXrMay6Y+71E0MMsa9hQ8
 =
X-Google-Smtp-Source: AGHT+IF6UpfwiWTUIRLPBOSuQdIIF6YmawkKydkjHMeiMH1NlJAQrUnin4kY9LcKHL7etfPu6MRE+w==
X-Received: by 2002:a2e:7c12:0:b0:2ea:804a:18b2 with SMTP id
 38308e7fff4ca-2ea951ac739mr54705731fa.35.1717410963290; 
 Mon, 03 Jun 2024 03:36:03 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f677fc9f24sm19124015ad.309.2024.06.03.03.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 03:36:02 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  3 Jun 2024 06:35:51 -0400
Message-Id: <20240603103553.8318-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231201005902.15630-1-wegao@suse.com>
References: <20231201005902.15630-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] ptrace: Refactor
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

Wei Gao (2):
  ptrace05: Refactor the test using new LTP API
  ptrace06: Refactor the test using new LTP API

 testcases/kernel/syscalls/ptrace/ptrace05.c   | 215 ++++--------
 testcases/kernel/syscalls/ptrace/ptrace06.c   | 326 ++++++++++--------
 .../kernel/syscalls/ptrace/ptrace06_child.c   |  16 +
 3 files changed, 269 insertions(+), 288 deletions(-)
 create mode 100644 testcases/kernel/syscalls/ptrace/ptrace06_child.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
