Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DF0CD6E57
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:25:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EC583E3096
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 13:25:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACC793E56CA
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:24:03 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 21DAE10000CA
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:24:03 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8ccea53f35cso46153366d6.1
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 04:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780399442; x=1781004242; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VL2coPTUxijZ4sOch/LVcN3Xfp40mvD7+AVE4QD4VWQ=;
 b=C3LSrDheMmiXyDARWtiEG3iD/jdckHcPUUtvQ8OPBtPFqvWqbEvYc1dBPNTfBdgOfZ
 v8r4rQcJiWZXpg3cwx0juTTNynosQTqkzvSx9r/Pg0qeFXAsgtRvQrFKQ2mfEeUn7MSa
 1vlppasgv1zBTmB8oFtqIEWZhUXeyFuhcnqa2PSw7HwcX4YxaZyvyJF2zNa+jHGMgtJJ
 vq+9TIYpdBS7dy7i3xi+SP75qrp1MztpdsjHpbaPLV2SMbJK0ACews2x9UsPyv8PlFCX
 U2jYufoMceWB05BYb/zPz0Hx/JaKL+cRNAvga+ZBVfS59EdaHxij4i0VPKziAHaox6OL
 q5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780399442; x=1781004242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VL2coPTUxijZ4sOch/LVcN3Xfp40mvD7+AVE4QD4VWQ=;
 b=MYH85XZm7DXpLWfr+WN5xhv840IICYNjyeJRWYKBnQiq5IbMp7cECfBxAaSmLcKE10
 8rm+1BItkMwCkdrn7mO4XltntxqkvWX/As+DSw4Bk0jJGzP1zP0KfJqdAEKPX4mFUzyQ
 THnl0ekMsNmBRr1yyZKUWaceFilmjE4jsIxD5LGqR/e6+2wd91OzC8ykE5TMOw3gIYtv
 AQanWyXqR+mHSrH/V8/b/JrpblDstnpZAgqmyJmWQr++cdHUa3C9dZxDd+YGYqN9PelV
 t7nUYr8sj2/m8uTob8I1dVEIaiaXdq2lFKaY+AICAwRvywV4MiQzyJLFcbIaOPFJBKhs
 yPhQ==
X-Gm-Message-State: AOJu0Yy+E41D8ufzvErdv1oGDnOHqC3yj/hN6C3BTd4YSkFv0mlb3r85
 iq6kXtVq0H/fjCs8TjXfZMsZOPTY7YncEBZm2Br6POWWKqHENLZknygQ
X-Gm-Gg: Acq92OGpW3T1u+3Dn85Wg1TDWRJ5NzXSpj7ho9WhLXwsqgabdmkmcUIT1PMIFA1ASRO
 EVBQhb9+DLOnJS78TdOne7eLWgRXBTsR/5s8gWiJOCN7DrDYJdbf9mLSCkFI/dkUNcUN2y7diEj
 bSV5W6/rpiymPP/ZYcoSMFiJ5QAMCcZYIw8/eXaitiHiFqZoct47dbHEdpC02wVY4aUAqLM1atu
 8adNPf33KzfFb4UKKk9fzJNo0I1LCtsThAQQiZ07WTMZo7ZFH31JbYlcfaCTzC2i9b/zaeEWQ+d
 tqDR9yCswpgDepP+tfGa+QXOmw/kxDVIvwHsfwVqgTDpTSqwxghRR9GefwSlrmTI07/FI7NXT8L
 CzxOAif9cbR2JIebmowlfWjjsdS9Iyyyq5Ol1x0xhuIuUfs+TWS7P+3iO9yoL8OkquJuVmZb0TF
 blYKzgE8kPp45zvsNsHtaZ+AbMpdRx0iyC/1Hy2hkme2AWlL/qgEwxe/ZZxNFh+JVY2L1+T1L05
 GMU8suj9l6F1Ex7uXDRwQBBcTrsRNDcHvlg8KJ6o5Yb8Zq/tA==
X-Received: by 2002:a05:6214:8088:b0:8cc:f0e0:f90b with SMTP id
 6a1803df08f44-8ccf0e0fbb0mr230034486d6.40.1780399441753; 
 Tue, 02 Jun 2026 04:24:01 -0700 (PDT)
Received: from
 runnervm3jyl0.cqadvpg5n3kehpcxmdhhiz2x0h.ex.internal.cloudapp.net
 ([64.236.133.99]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea0635b1sm118725136d6.11.2026.06.02.04.24.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 04:24:01 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir <samir@linux.ibm.com>
Date: Tue,  2 Jun 2026 11:24:00 +0000
Message-ID: <20260602112400.4056-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602100512.404810-1-samir@linux.ibm.com>
References: <20260602100512.404810-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cfs-scheduler: Fixed "make check" warning in
 cfs_bandwidth01.c
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Samir,

On Tue Jun  2 12:05:12 2026 +0200, Samir wrote:
> cfs-scheduler: Fixed "make check" warning in cfs_bandwidth01.c

> -static int may_have_waiters = 0;
> +static int may_have_waiters;

All good. Reviewed.

Pre-existing issues noticed in the surrounding code (not introduced
by this patch):

- cfs_bandwidth01.c in do_test() -- sleep(1) and sleep(2) are used
  for process synchronization (waiting for workers to start and for
  throttling to take effect). Is there a checkpoint-based or
  polling-based approach that could replace these to avoid flakiness
  under load? The checkpoint mechanism is already used elsewhere in
  this test.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
