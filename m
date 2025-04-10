Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696D2C3601E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 05:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1744264234; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=DrwDm/jLP+ZqznCP7dGO2Ys/J16vzoNgXhW6vPtt+Rs=;
 b=HGOt9OozsOxbSbcZm0Z5Dl1BG3/Pdu/rpepR2SbrWB4S8tl18O932WS7wZfjsglnPvePF
 vQfsSYHYP6swo8inZe3kqo2OGr//RRvltCdo/44xKAdg+AKb7pFnuZF7OQSIpj65lL4YnaT
 j5euU67PBNkJnfIcHou56PLpm7aYVuw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95DEC3CB44C
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 07:50:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27B563CA0E0
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 07:50:11 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CD748200900
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 07:50:10 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-3914a5def6bso136442f8f.1
 for <ltp@lists.linux.it>; Wed, 09 Apr 2025 22:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1744264210; x=1744869010; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2jld4fR0wDdyblSWuRP5Jh05UaD1pz6tDDBuKkdKLDM=;
 b=ZtYDg0L7XrSc52ITal2oQHQcUU+6r2nuaQ6LD92tgc6nBb4BZZN4hqWveNNaaKxD1a
 0w/zy55yjtxk+rR8WM2sCZGvxLAkR7+v9Lh9ke3y+LqPtUPN46qU6Nra6oTKKSWTpWSA
 blAcR79j0Ya3Ye90wvEhOA4Z9BgVqhKqNW8rUIqGbO0uIKX2Cmqj/HSE4eDFq/YLcOd2
 UhFUVJFrj/2WxVJyQD0xJm3XS0ZIqjFsAdt+9BoB7Etzttdfo5yjvZGwGqggjwJBrwhj
 KzsCtXyo2gBIh8SzWdDbxok+rfelut7Ue5bdDTXIG8BZMBP7KtHSi6zIuJbbe9nphQMQ
 uhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744264210; x=1744869010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jld4fR0wDdyblSWuRP5Jh05UaD1pz6tDDBuKkdKLDM=;
 b=JzUulcOcTkvunnBrX0JcMutjmqH4WNtECm9W475uL3duEsRY4tm7HBdj58UEoe2iVt
 0VA+wrBo/EFZ8vJSx1II6+gz8Ly75kyqRrH89zCvqN+iW5gsI6dFWW1M0rJPiAu2wEfo
 TRkaGnlHgmPetVkwfzNpaCNVPfFdoq7XermTsH/Q3b/Mc3hOqGVXS6eVbfo2i4mSmQ6Z
 qa2De3pfAgLbSR5rfqh4JGtcdWP3CwE4OmvOrslUPfPQmMP0sD+x2B+JZL1JzVRxuP1m
 tfW6AvO2QEeha5xH69faaR8AA9MwWBwneKHMcP7WZJopLZ8LF21qwAuiRGdTDVuinzmo
 /+9A==
X-Gm-Message-State: AOJu0YwkEal7hjUK47CyC+y/ySApQHfTin1gej3s5VS8xdkf+sKOlUDM
 Y4ouVbaGXSw+vMpfe4BhfGd6TDbWS7h9xnDLExA2xjPRlDoQg3FlQldBb0YszACRzXpCBTzckP8
 NFIPz
X-Gm-Gg: ASbGncvEjd8fzvhmVhHUXGa8BBh765qcJdQ27n7O5P7p0dVq4i2798e0Xh1cZQhlILk
 9x1OCrblzmBLsiD0IAFSAKrRkCvly+NxndS6MXOhpOJuKgsmByVxjQ8v6Ygp/xxxxhlHYaLqmd1
 ksyAf2VO/r0ajIqw/Q78LHm4vlVNFM2hAp/7vma68o+vnCw98dxfmxAUDJfXFpbNW6da8Pcx+M0
 UfxBcn9shuEtllLby7pbc+YHpCpS5hoGSWKAOVHnQFVv7fVo3dsbw+WI6ttI6UkE9r0oTuGJ/hC
 Gg8YZmf49MddRpVLZURZ6xNSARJo2A==
X-Google-Smtp-Source: AGHT+IGbbvmz3qCShKnbaVmjziyqbZW0iMqpBKOgjnDo+wP5+d+2b0cSO1njJex7N/+gxQa1iSE6wA==
X-Received: by 2002:a05:6000:4007:b0:39c:2678:302b with SMTP id
 ffacd0b85a97d-39d8f4e4379mr909505f8f.45.1744264210042; 
 Wed, 09 Apr 2025 22:50:10 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bb1d2b36asm2387548b3a.21.2025.04.09.22.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 22:50:09 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 10 Apr 2025 01:49:54 -0400
Message-Id: <20250410054956.5071-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241212085058.29551-1-wegao@suse.com>
References: <20241212085058.29551-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 0/2] ioctl_fiemap01: New test for fiemap ioctl()
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

Changes v5-v6:
* Remove ioctl support check
* Move implementation of safe_statvfs into tst_safe_macros.c
* Move SAFE_CHDIR to setup()
* Other small update base Petr's comments

link to v5:
https://patchwork.ozlabs.org/project/ltp/cover/20241212085058.29551-1-wegao@suse.com/

Wei Gao (2):
  tst_safe_macros.h: Add SAFE_STATVFS
  ioctl_fiemap01: New test for fiemap ioctl()

 include/tst_safe_macros.h                     |   6 +
 lib/tst_safe_macros.c                         |  19 +++
 runtest/syscalls                              |   1 +
 testcases/kernel/syscalls/ioctl/.gitignore    |   1 +
 .../kernel/syscalls/ioctl/ioctl_fiemap01.c    | 119 ++++++++++++++++++
 5 files changed, 146 insertions(+)
 create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
