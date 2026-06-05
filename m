Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197B2CD6E5D
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 07:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780643250; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=x2QtyKetOx1ES/m/3O8d9xDkJGvAT+wVgFv4Ct3bZEk=;
 b=MNJBoUMGExMvlnijY0pR9zrz86fb168GJKbu/KRFxqmIOO7KQU2Yvxe6LDa4cjA1SLtz+
 rS/WD+BhBUJ+traflUQEWyWDrISdv5Ixhe9jYl0b5V/pRE6Y0kiPDWhZwe0CuXi9eUizec3
 yJlGjIwwyQNKDS7FE6lH67V1jHcS1r8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8758C3E196A
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 09:07:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A9663CDA3F
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 09:07:12 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EC8AF1000A33
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 09:07:11 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490af320e2aso18035135e9.2
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 00:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780643231; x=1781248031; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=RLJwB29qmC88U3VydMqHsjKWM0mK4aJaiKjpt5TFxcI=;
 b=IcByCT4ryrVw5UeQR/UHVgpBsVbKyWLPWdi3i+TCZAwNRbDFeAnYZXpNxZeQI1Jh0s
 lpBwo5aSyDqkYmzvVhnNSaYVtn2r/XtYPCnKnpr1zkW3uvvQi6v94aNYk5ufNaP/p/3p
 VKTVr5wIUZkhP121lEUll3v0zv4ViuuoaYR/NEMg2a9ZHiFsRVCDx16UP9PBYr1Chnhx
 t17QKoZ3O+GycpVpOd7FKHPm36vE6i3ky8nsGKmDZFFKXrju6EGYQ5VnxW+dariN87Nh
 hFHjAYKk5CQjK1HIm30l6UikI0kLhWgE8uGD0LGdbsC2t83DAStBV1V0Qv4LLrsApIDt
 62pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780643231; x=1781248031;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RLJwB29qmC88U3VydMqHsjKWM0mK4aJaiKjpt5TFxcI=;
 b=SdyUPw290wgsKpGd98bO48QxMBfh54q0whnTAtUN6L1kbeLaQV+TtFNjmAdR9dz2zq
 jjh0kc0sDesaX0Vd0nnTac4HdvlMVoJR4d0pjMXd0hWADn7d9ag87JMUaBh4gJNKiUE7
 BQbPS/WPAZpklgB/JzEWVK9A9BDdY2mGWqHS+FZJFqNwOCJz3WRir3BOLSxqrgfu37Av
 enyn2xD6BP+rRpi/WpUOhy2bWLyGzKT6IXM7iaVSij7NCYwHPmhnTWzf1+rGwqeRQLkJ
 Tm+1zd7aGPSqufyORsE8v32qP3wTvyQRkaHHVYhg96fj+rTe2SysYZMdNBdszdBTA86O
 5pZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0i5nwIXZJedVUQ/7beouqP3MaU1wKyfgHc7ei2kO8DOMOBeP31N+8IqcWpVTbBk71pjw=@lists.linux.it
X-Gm-Message-State: AOJu0YzFVyVBjGFhwXXu7gfR1lek+geXaT464I9FvECBIHDnN7GJ5GlE
 WoflgN0CIOu5hKJZBRVBlj7MxsrZAEZVq3YfYkYPurNVyUQ6Q0+AApeS+akYKqgHdYE=
X-Gm-Gg: Acq92OHRzahXZTa+wcz0ht5hGIt6zK/CiwiQiN2rxz/C3BI89Xd1bhl8PBuJNRepHP9
 9o7cjfXMtUTpKzejQJT9jA0lFMWkZ4MwhlyPid9HWX00YxPqWrKSi8Nm6dwcKt7bd3yvmL92ztd
 L5bW+9FnvCjdmicfDGnFycGhqT1ca+EtBHLWiRRERyqcfWe9FoyRq5oTh+5nmYmOmRqt6sodP1n
 zjVqDnhwzvpv6qLMt9OJ2+2RVTmJ7vcMVEKhQfBJlFanBZ9937PVALQMNn9OBxua3bbQr3FztF8
 ZID4yFa24+6awV09hA5Igs+vH5NDbKjieT5MlxnOLZhfCB9RYvchRmPMnEjJZBI9wymm3zwjgEV
 oP8VyZE7tZOK3ceLyi0sHDVgu5aS/XD8CRPT8bRhWR/Vu5UAjsHt0kNn5xI7rjoZOmvXMB+2h93
 bknl3cvpL5MvxCKeBtp9n4e/c/x+/KJMPYmHzXMb2p8OwywlPD8uk+GvbFVA==
X-Received: by 2002:a05:600c:82c3:b0:490:9782:3eb8 with SMTP id
 5b1f17b1804b1-490c25f4963mr30715165e9.25.1780643231234; 
 Fri, 05 Jun 2026 00:07:11 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc391aaasm152525095e9.1.2026.06.05.00.07.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 00:07:10 -0700 (PDT)
Message-ID: <6a22759e.a05553f2.14c34d.4228@mx.google.com>
To: "Jan Stancek" <jstancek@redhat.com>
In-Reply-To: <CAASaF6y7ub0XFU3Cf66=_ztNWAhWVRuxWJGx6on=jaMLJSpJEw@mail.gmail.com>
Date: Fri, 05 Jun 2026 07:07:09 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] gitignore: ignore ltp-agent setup files
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> Can you elaborate? Wouldn't better place for it be your repo-specific
> ignore list? (.git/info/exclude)

Indeed, this was related to a specific ltp-agent setup that now it's not
supported anymore. I recently changed the installation workflow for the
agent, so skills are installed in the $HOME configuration instead.

The previous installation was causing many hallucination in any model,
since rules were not discovered locally due to the symlinks setup.

I can revert this commit.

Thanks for pointing out,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
