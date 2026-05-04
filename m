Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8E0FF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 14:08:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82AA43E49A2
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 16:08:40 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 022D53E49A2
 for <ltp@lists.linux.it>; Mon,  4 May 2026 16:08:22 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E01DB1A004C9
 for <ltp@lists.linux.it>; Mon,  4 May 2026 16:08:21 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8b5de17382cso22819636d6.1
 for <ltp@lists.linux.it>; Mon, 04 May 2026 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777903701; x=1778508501; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=af07Tah/vocyD6OLI8GWk+tv80rcPyRr6++tyI/yfGY=;
 b=KbVncBNvGceEQtPjITX0RZSKFpdab6JFuSKt5jqkeV37BxG+cdHdGlvjrKoPKmnbtC
 lK6qAXp2+7oSUrj7nFuXYPwqW72fKpp5yasHKyZtS74JTGmckTU6MCgvu1fRnYZOYnlw
 XsLUCBj74eJHPuQQXSj/lM4gr+ZSSpmdi38ZB5Bvbc5EcgiNO9PzHEvUs2A2OHXB9P2f
 oAkwb7c3pL3X5ZKQQKEQQ3rWHwlJr21SpW69WCPwIuPqYpdWNiGx0S0gvo2ky4lWglvW
 XLBdPs3NWZ5zCPDHzh0LcdcDRjJ0lvWhGfLRtxLB0BQeVnSRIbnOoBxrDxVovy7oJR0P
 XgGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777903701; x=1778508501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=af07Tah/vocyD6OLI8GWk+tv80rcPyRr6++tyI/yfGY=;
 b=SzCy5RsqesvzMgclML1mkr24y2AEVkt4ImRzCWtF2L9ObcR6ptHjgc2x3yNI7Qp8bY
 DcV7UHiQ/89Y4A8e6gPngSWowKJ9HVUgl7O9Rsp5axOqQ1/exgQTTkD3wIB0oBiRg4du
 4/0jqCJMtTcHIhbSCndHzj4n7Wb45pGH3sCTWZLVfx8RRxKJz4Cb0uNIfDZitmcDiwUf
 NaNITse4KmfZMTpmW/4XyFKPjHVe0zsq32ckrVKhXE2nA/H3800KupgH/j06uEQ5E8Dd
 D2ExjhEyKXuZJOAV6AtngOxOv+MDufgNciV8vBIHJ8uVmiwgwk5VHb78qpzTWy/1MmV4
 9vVw==
X-Gm-Message-State: AOJu0YzsWwqysPwZR/X4Y36jPMuwClQTjmWvSbH0jzfxc4UyurkkBTOe
 UPWEnXv6jj1f5aSe9DCXypZZ21PX8s8q5BUF26ylRXlX0OCqs8SRn2v0
X-Gm-Gg: AeBDietgN8bnFd5oDW3VGTU3BaMWy4p8UcW3JuZ9/z2wfr9BQEpCaBDaxvsegWC1BLc
 vcKoz5YFy+pRCe7CfyUJ1aYhJIPfUGTpa5mF2MUQOQLEksWxyMKKq3bgJpKc/3LRxvuNEfK6wV8
 gju+yAfacVGn425NBRnxEJHaFB3XYkwVqN5O9Ic743j/iC0bB41/AoOUM+NOOftKGwXnOUcMtPa
 ESrx3skxaOKTTQbkrLlON9pG7heNiJxsQ5TdWDRpivwpZBjc13XB2FzIfzsvenU5ucZkUZ+BmXz
 fqovDFejQOR1Az6tIWUcgClIJVS2L/4AUqt+t8uT+43fgSiaKioQHoTJGMxcv5/h0qFCrflTpK7
 doBXNuafi5w2p8a6BuqaerHWREne5x/Ltsq4RWJRI9yXn/xX2Z/8/bBunuA8iSHUccfkxmrQ7fe
 QUcy7vyZiF83qCqjE3VpOJi9U2B09qC7lvpQJVp/cDV+a+Bh1rxVtwsrt2WpbgQ5ekPQWQIyinS
 awLi4j1scH/V8TPKeK95npclpiPvmRLJ3xrWAhrDj2HK+sRGA==
X-Received: by 2002:a05:6214:29e3:b0:89c:4f7f:8479 with SMTP id
 6a1803df08f44-8b66573a772mr168633306d6.6.1777903700515; 
 Mon, 04 May 2026 07:08:20 -0700 (PDT)
Received: from
 runnervmeorf1.25nck5mkgfoenofczkdl0zm0ze.cx.internal.cloudapp.net
 ([20.55.223.185]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b538c14514sm118990786d6.8.2026.05.04.07.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 07:08:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Mon,  4 May 2026 14:08:19 +0000
Message-ID: <20260504140819.4067-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504133020.14129-1-li.wang@linux.dev>
References: <20260504133020.14129-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Introduce tst_path.h to consolidate system paths
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

Hi Li,

On Mon, 4 May 2026, Li Wang wrote:
> lib: Introduce tst_path.h to consolidate system paths

> +#define PROC_SYS_USER	"/proc/sys/user/"

userns08.c includes tst_test.h (line 24), which now includes tst_path.h
added by this same patch, so PROC_SYS_USER is already visible. This local
definition causes a -Wmacro-redefined warning. Remove it.

> +#endif /* TST_PATH_H */

The guard symbol is TST_PATH__, so the comment should read
/* TST_PATH__ */ to match.

> +	SAFE_FILE_SCANF(PROC_SYS_KERNEL	"pid_max", "%d\n", &inval_pgid);

A few replacement sites (pidns05.c, userns06_capcheck.c, waitid10.c,
userns01.c) have a tab between the macro and the string literal instead
of a single space like the rest of the patch.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25323298192

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
