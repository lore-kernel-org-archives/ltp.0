Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83240C5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 03:55:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 603EB3CB4FC
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 05:55:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 454903CB270
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 05:55:41 +0200 (CEST)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9C3582000F3
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 05:55:41 +0200 (CEST)
Received: by mail-qk2-x09.google.com with SMTP id
 af79cd13be357-9349a0fdee9so64326285a.1
 for <ltp@lists.linux.it>; Sun, 09 Aug 2026 20:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786334140; x=1786938940; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ST6Zr7HoIz1a7ELq8782qSDErRAYSbxFN4G0WFQxgt8=;
 b=JH24aqB7FniSF+89UlTq6ZxwqtkiJcgm9pkvDyA7Dsk64fZ76pg9hqLBN44HgvP49Z
 fuYtoen6jgxVjTfNBYuqHDkbjbsYo9a/sndQTHbBoD3G7z9szqbGLeSrIniESJ2fdBlF
 K7wz6ivSkwjQ6IqduuoRHzKTHAgbJfrN4n9tE/jw0D4TGN3K+OVuJ7AP+Kajq4+KBvw5
 R0d0IWteWUjbhgH49siHER5M+e1ZiQtKIt9zCMqE9UZ5xq+C3lVq43VFl4f1juBmD0bD
 P+Tj0cJKiTVnquLwLDlOEnaXJp7eFt0bWaJpzW3C/OjNnBIDAVb0KlFSmAkAdrZfwM+P
 e59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786334140; x=1786938940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ST6Zr7HoIz1a7ELq8782qSDErRAYSbxFN4G0WFQxgt8=;
 b=S9yzO79+BX5ndcQMAr/qsXGcFROruWW2p0NVI/Utzig+ate1NxXwmN6c+uTmqe2h7C
 EKf0BCCc1omUpL+zyG7ztP4VqQQRUK/oqIhM4LVffBxyPnJVzNZPicYnAaPw9vybGCF+
 YZAHvEvZsPLKqXb0iXcyIJ2+HHl+NlhlN+Ku4/yTXDVCHZesLv7BsdFge3XhCgehv22a
 oulrfYPeGnAId7+NG3jiJSUyWl/wRMAVhLO/uGDfZK/weQwRubFwvxNRgSW5iPLghue9
 mlcwlNJkQUd7owQopMWcigszmCgp84GFXlnxlikRKQRBXwFGdt6/Vthg7tU07zILcfvv
 kdcQ==
X-Gm-Message-State: AOJu0Ywe3yi/f6T88kPZ9Eguh46KA6THT74P3u2eA57JxBPsvcEGekLS
 s2SUriFgvGtfV0h81fg/CDU7q+Vb/gulK7oyDPiMFSIu391Pf9/qX8aA
X-Gm-Gg: AR+sD10lDap03OF05rvCk6Uyy26xmNvoCNION43bpfHUs0svuNA+Qw9bIyWVgrhqX9y
 +z2aNn++Xnm2rKtlTFy0Cit+D+A0P9iX7YNkVcUY+k7bC4Iy/sr5OqRgTRUDDifJpA7MLnEFUj3
 VDUJkekY2GSnD2bpznL1nl2azLJF/ueSVuokg/4C5LpmAWLay0w0IHDOUbYze/M9PtfyLKAEi3e
 JGtbxWDIvteFCGYbL4ItrdcKPlMx7Jfdb96SlGbHhonk9PFsvQLbGUQWcNrDLZaQaK9nY3xMTQk
 RkVtOKX5oLoQYGQ+P3EnvsGENhsn/KW+qtL3Fu9KNnjhPLOJCuaxNqAtadZ5H5G6EBggQ6lVcMi
 +lHZS6K+pEhV0MXucZvP5gOdxvckGNq8bAxyIEmGF7GL1b4/pGDnT2UDgSxj67LOstVBCFW4JED
 pTfFFM5tpzW88oMmTWHOU+DgSyYqNhE2EJll/pwadxBYY7VWfjdc/4b6Bh0sh7DDFS6d3LpysgK
 t74sXJX+pCVU1lvkLuFne3O0RKJqpfIBRypVz7XuHTxdEESk1oPOzsI7M2SxeGDi6MWhDNdiZuF
X-Received: by 2002:a05:620a:f10:b0:92e:f3ca:2eaf with SMTP id
 af79cd13be357-936490993a0mr3047626485a.11.1786334140300; 
 Sun, 09 Aug 2026 20:55:40 -0700 (PDT)
Received: from
 runnervmvrwv9.5kyu2zzgdegendbzjeuyb0vebf.bx.internal.cloudapp.net
 ([20.119.102.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9366e229787sm693697885a.22.2026.08.09.20.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 20:55:39 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon, 10 Aug 2026 03:55:39 +0000
Message-ID: <20260810035539.3921-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810033921.1694744-1-wakel@google.com>
References: <20260810033921.1694744-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] controllers/cpuacct_task: Increase execution time to 100ms
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

Hi Wake,

On Aug 10, 2026, Wake Liu wrote:
> controllers/cpuacct_task: Increase execution time to 100ms

> +	struct itimerval it = {.it_value = {.tv_sec = 0, .tv_usec = 100000}};

Could this avoid increasing every helper's CPU time tenfold? The
cpuacct_100_100 runtest case starts 10,000 helpers, so this requires at least
1,000 aggregate CPU seconds. The shell harness has a 300-second default
timeout, which makes that case time out on systems restricted to three or
fewer CPUs, before accounting for setup and process-management overhead.

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
