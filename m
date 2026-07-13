Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10613C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 14:14:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 975E73E9691
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 16:14:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 274E33C0401
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 16:13:53 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BB0BE20075E
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 16:13:52 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8ed50e588d8so11085586d6.0
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 07:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783952031; x=1784556831; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZD46QZRjLK82wI/3r0RU1z7mzJy5126Ju2EthZ9EKns=;
 b=LcP0+EZpTe8fT0zayDNQrgwJOoooDJe74FNdC/SZIo7PYZ2ZGvpXE92Ax3PRHyoU1O
 +XtJqTWzr//QZfxPCbotqdEq7oFRJgFI2YGu1qg96jnj0KYCyFSeQD/B+yM1lglBuZ5Y
 D7Cne2RVF4oHCiBWtWdVDiGQ3uh1nbLqq+e7ljA3auTepvOseCvRS4lrYYfMCoiu22jw
 aXz86BIp1ZmpW4zZzDOwba8j0DrdGoiCZunGaY9qEaxON9gErLpm838f14PdKaUGatPG
 SwH7DUL4TEhjb0TM4tU1GAhNV9ggsvD819RCJrqzuqTZH28NtirTYP5vwyMT1fAt5PJI
 IcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952031; x=1784556831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZD46QZRjLK82wI/3r0RU1z7mzJy5126Ju2EthZ9EKns=;
 b=oYtt1Cdos/EOyCDAK85PX9Rzm8w9qDQ43+R2HLX4wCH6rDrRjRLgWM0hFxSoduhnXM
 8iAZmcqMCJshpWcWyXebzKh6Q5lfmC7oX/qaUZDaldsspo3IqF/pk8CSf2x/7t3/x6Y2
 LogBznll5iIKuYoob8lpOl24bmyjh62UwqSP1/2Da1QYFyqkN9dvcHHhUi4bqTGBpf70
 WrWYFwlDMRnk7l4WdK5ri2c80VFmYdw7s5AjW5da9jUvDm5PXFqKlKh66rHysjMFi/Do
 n627bImUdrPz8YKpWio9LkRd9CN66h4jRIHj9Yuj2D7uVa5CJtqmEQmMk5wdijmMB0BK
 iq+w==
X-Gm-Message-State: AOJu0Yyy+TxBdgQz4VrPUH8maD3H3Wdw/LReO+3gGk6D5uko3ro1YZfR
 GVwZFoaU0a1Whh2PBfPDdl7V3FkPMDZWDyKC6mGXAu2CNLErwMyV/Q/I
X-Gm-Gg: AfdE7ckYOA/njEtUUGjlWecUlR6e9f671dCfYUb/IlaoOUNNAcqCylGi763CiLvwRCb
 27fftQvGsc//JVzxYUonw6qCE3LJwqlUlAUC/EdbNmaaWTNB/sZZtNimphDq8BLGz9No4cA/KLv
 dmh99xIqlQhhA07uqQUGXsWQ3f5p4l6Ta6Ni4dHG5i9siC7NysA+N/rFB+YLArLya36zrqVpavl
 WB3px2kw65lIHzvrbn4nmf3zKbCiv56rTb+MOtmF9GdABUpCnLasw21hRVeMlXcM32VHePUAMi0
 Df7xAoUCDMavuabDd7Pd0ycke2ffrs4JU7HcdOL1e/xeRwy40w5nLmKdD+FGFodY6w6Q+ALmEGo
 LSfwBSJRHxKmLO8oBm/8ObmLYMUALyuRWoCegh9NBNXrc7uOOaTCDgq2QrJ4wwmHXN1HEWJZYPM
 RcRDtgHEarMHP+9Su0dVKLA2ZAYOP/L5Ca1PInVTERphd9i4iXhwr7E8AvfsdKYIFSCzZFTSG7v
 Xz1K8t99HdRTuPIKpgg8fjM+aV+ng==
X-Received: by 2002:a05:620a:3703:b0:92e:f0a5:ac3e with SMTP id
 af79cd13be357-92ef2b32b67mr962947685a.28.1783952031245; 
 Mon, 13 Jul 2026 07:13:51 -0700 (PDT)
Received: from
 runnervm5mmn9.klrlp4dcigdejebputcgrj1dlb.bx.internal.cloudapp.net
 ([172.174.167.19]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92ee5b4b38dsm1163909385a.10.2026.07.13.07.13.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 07:13:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 13 Jul 2026 14:13:50 +0000
Message-ID: <20260713141350.4119-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260713-cve-2026-46331-v4-1-0089fd01ce62@suse.com>
References: <20260713-cve-2026-46331-v4-1-0089fd01ce62@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi: Add pkt_cls.h fallback
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

Hi Andrea,

On Mon, 13 Jul 2026 14:37:07 +0200, Andrea Cervesato wrote:
> lapi: Add pkt_cls.h fallback

--- [PATCH 4/4] ---

> +static int file_fd = -1;
> +static int listen_fd = -1;
> +static int cli_fd = -1;
> +static int acc_fd = -1;

> +	SAFE_CLOSE(cli_fd);
> +	SAFE_CLOSE(acc_fd);

> +	SAFE_CLOSE(file_fd);

> +	if (cli_fd != -1)
> +		SAFE_CLOSE(cli_fd);
> +
> +	if (acc_fd != -1)
> +		SAFE_CLOSE(acc_fd);
> +
> +	if (file_fd != -1)
> +		SAFE_CLOSE(file_fd);

run() closes cli_fd, acc_fd, and file_fd but does not reset them to -1.
cleanup() is always called after run() completes, sees non-(-1) values,
and calls SAFE_CLOSE() a second time. SAFE_CLOSE() calls tst_brk(TBROK)
on EBADF, so the test always ends with TBROK on a clean kernel.

Add reset-to-(-1) after each close in run():

  SAFE_CLOSE(cli_fd);  cli_fd  = -1;
  SAFE_CLOSE(acc_fd);  acc_fd  = -1;
  ...
  SAFE_CLOSE(file_fd); file_fd = -1;

> +#define NETDEV_MAY_REMOVE_QDISC(ifname, family, parent, handle, qd_kind) \
> +	tst_netdev_remove_qdisc(__FILE__, __LINE__, 0, (ifname), (family), \
> +		(parent), (handle), (qd_kind))

The new macro silently tolerates a missing qdisc (strict=0) while the
existing NETDEV_REMOVE_QDISC fails hard. A short comment before the
definition would clarify that distinction for readers.

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
