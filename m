Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B0DC44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 23:13:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B47413E9616
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 01:13:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E3323C2697
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 01:13:39 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 327E920074C
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 01:13:39 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-37fb1883fbfso2706364a91.0
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 16:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784589217; x=1785194017; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZcUWpcYdPMT+h94WWDAzJF26xDFxgz6kUgd22/gAVds=;
 b=JhwsI88TOpBxtXj0QaJCumb0bFXmmQM30kSu/9m7eU+HU6GBZX5COL62dcbhJm/MtV
 kD8WroMhwmNfQOeGWEonwHnm3vMMkHBsRzodhJD3BgYeY8hu9S37O49yNBf+m8LGjItb
 ZrNOTuXUJI5vCsIRAjtt/JN7+3zQVJDblIIbYQkze5OoEfGbvbBACqWSeNnreoLAfZ4F
 JiUSxre40t51j8SE5ik6aSov5lpTaAadWADwqbwbnuWZLfclm817ez9KckSBY3yDKTkD
 m3bqlZT6jTWx62Hwa8EUqjMa3texexHwWz9yazCy52Bf0oirLlqsHS7IHOsEEfmYYs4g
 F4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784589217; x=1785194017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZcUWpcYdPMT+h94WWDAzJF26xDFxgz6kUgd22/gAVds=;
 b=TRUfun7DQEcCGBKAZKaA6UWsdMAcPeQzPvwfHFJyFovqjGhyvfzA1b9MDZxrgYHp+H
 reCEbdXi+Bp/eCilB/aJqfTxTvNMZ+vaMpmHDVdY3Xj6z4QuE5pd4ohoS1uMMfmA5Iy0
 q2ZJNv5aDWsPwTn/DYp6Og+lrSX94eikXNKWOoqizSCPDNrSju75nAtjNF4TU2BNhLs6
 8lvI8363rQhKPDbwY0OLc3YiB5BPz0x8iTyqSVNh/tZ7hCQPYNOq+HISgdkALh3esmqv
 y7ysd7dhnBqX6Og265rTgBfGdzcs8gK9FX1dqBMd82XT05wWun52KfBQUz2FVSQ0LuMI
 uMeA==
X-Gm-Message-State: AOJu0YyUc4OL/XxdNgXIFTVmWl6YBsV6cLepviaLqr7GNqbwRhLzj/u3
 8NYx9+57oKouu6Oc7GNT3hDGTjfwOR1uineDdDynOEpNgzhc6mRdIC2N
X-Gm-Gg: AR+sD11GLjHkpA5ZWVz7bEWSjMwwh/apQnOzZyQFrQkd88wn+2JLwvJ+TgLy/fPi4Rv
 MYmDq9bzCj6r2NpxunzPmyg+4LIvZabzP/HQrnbiZsFcPgGwE8zDIYJbM61nEDjz0QGdShebF47
 UzECkxbVS6IBkXT1Dn5lmJdlLRGLnDWsx60qeM7JRn3sD8rIShR03QSnP6ZOm8Jh9IhygU6MuOs
 HV+3b6Yvl/HnNk2y6d4dBLcxBpqgllpCI9xs3Aimt1TrxgAU/497CAqoz4pAlVxTPAYMnJvPkC/
 m8CF3r2eHNvOZlHaxir0FAQy9egq4DpWsGrykZaItF4vTdc4DHHghsqXwv3iER2rXBZKd6/bV76
 s/HK53oghVwhTHEzbjiIhDJy91cQryq4kBLgwsBdmF1sbeW0vOhBeGELTPmjs35S7xvcF1DIqlx
 /EuzFRSMK16Dcjh4+SEC7MHctzg8MZAe+AxuJ2sfOnMwrTCH1u6RZDG9+oYwVC12rrWQQD/TQrH
 m7cpMfwpkdSjx3Z/6LnEPTUWv9J
X-Received: by 2002:a17:903:26c6:b0:2c9:dbdc:c0e with SMTP id
 d9443c01a7336-2cf34997720mr158627935ad.26.1784589217323; 
 Mon, 20 Jul 2026 16:13:37 -0700 (PDT)
Received: from
 runnervm3jd5f.kqwjbbvdnqqefdcj3x0m33zbne.xx.internal.cloudapp.net
 ([4.154.117.242]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf3448f705sm64034145ad.15.2026.07.20.16.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 16:13:36 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Mon, 20 Jul 2026 23:13:35 +0000
Message-ID: <20260720231335.4099-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720224936.2753334-1-sbertram@redhat.com>
References: <20260720224936.2753334-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] semctl01: tolerate SEM_STAT races under parallel LTP runs
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

Hi Stephen,

On Mon, 20 Jul 2026 18:49:30 -0400, Stephen Bertram wrote:
> semctl01: tolerate SEM_STAT races under parallel LTP runs

> +static void setup(void)
> +{
> +	sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
> +}

Moving the SAFE_SEMGET into setup() breaks multi-iteration runs.

The old code had a lazy-init guard inside verify_semctl():

  if (sem_id == -1)
      sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);

func_rmid() sets sem_id = -1 after IPC_RMID. On the next iteration
verify_semctl(0) calls SAFE_SEMCTL(sem_id=-1, 0, IPC_STAT, ...) which
returns EINVAL and triggers TBROK. Running ./semctl01 -i 2 reproduces
this immediately.

The lazy-init guard (or equivalent per-iteration re-creation) needs to
be kept.

> +static int do_sem_stat(union semun arg)
> +{
> +	int idx, rval;
> +	unsigned int retries = 5;
> +
> +	do {
> +		idx = semctl(0, 0, IPC_INFO, (union semun)&ipc_buf);
> +		if (idx < 0)
> +			tst_brk(TBROK | TERRNO, "semctl(0, 0, IPC_INFO)");

IPC_INFO is a helper call here, not the syscall under test. Can
SAFE_SEMCTL be used instead?

  idx = SAFE_SEMCTL(0, 0, IPC_INFO, (union semun)&ipc_buf);

The behaviour is identical; SAFE_SEMCTL already calls tst_brk on
failure.

> +		rval = semctl(idx, 0, SEM_STAT, arg);
> +		if (rval >= 0) {
> +			sem_index = idx;
> +			return rval;
> +		}

After this patch sem_index has no remaining readers. The *semid field
was removed from struct tcases so the variable is now write-only:

  - func_iinfo() writes sem_index = hidx (and sem_index = 0 on TFAIL)
  - do_sem_stat() writes sem_index = idx

But nothing reads it. Can sem_index and all three assignment sites be
removed?

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
