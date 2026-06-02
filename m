Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001C7CD6E4A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:24:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A50703CD731
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 13:24:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2986E3E56C3
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:23:47 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 748F51A000A8
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:23:47 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-9157ec935c5so60300585a.2
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780399426; x=1781004226; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptzcWX3UPUNj0rB07dKXALSiQyQcdBNxOEeqqEE28WU=;
 b=gD3QtnecEOUIhDAjssFuaZ9wS2w88hOaJMcJposztnMmMgzJQQhHbaGdolvtBb3shU
 Zm60Bkis6Ba4t4Nk+BQ+2wZ43MHQvEuaOOjRzZoy2L5Y/6SImX7++GSyRjKFAGyRGS6K
 dbQCeMcLIQJta5KrgcFDVjLFLAhbmZnu3807fBQ11++Chw5dA7S5fxHWZDF2vtphrx7z
 bLsvj7wr9o/v9WVtiaVgAbVuIqBE/njqRT5hQ2QL/u7vyZ4PVi2mglHrZLMj5yzr1SmP
 xuVQTYT+dVJHYSUIYRqUxIy0fiPtleY+vyl7ls+qdkV7wE5Ww1hfz/OeE5JLlW/O81fr
 gC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780399426; x=1781004226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ptzcWX3UPUNj0rB07dKXALSiQyQcdBNxOEeqqEE28WU=;
 b=AD6BtEFS6Gt2oFY4nR9zEXTxsyMOmqLvUNsdV/GAkK1QgtLnn5nn5SrKPp07HaQKKk
 LLQ9ylCtDQ/7G10UwmWe9wRqKR0o4O4B1TN/NLyp67c2R38jd4Nr8P3IA8zyU521xgqs
 MAtwPZqa4XWZN+vYZHCtjLCfOXhoUiss7cdlSQgLYSH8BXlNbJ/bMfCX8ozGKaL0+T3l
 oLdWPkHq9D1Qg0fkrHvWWOKBDP4yQ7SKf8+9zuCqgSy8/zRYKXDNhyYqOGc//14N/xp7
 3uHcFdYZ7hMqR8BVlZxfXQcHoy2+FBH3eue7x4EMayuMGOTyoVerUMJUNweAZDgyxUYW
 euVQ==
X-Gm-Message-State: AOJu0Yx3GerxbDJp17H2ZQ25uoEj2wz7VYTdDQToPCpEljApozlA8zaw
 zk2JJwsWUjcw9nh+zzl7fl+3qY3TnyfnDU5np+CeC6R+5szVxC8YQ5sNwpHbyDwA
X-Gm-Gg: Acq92OH8WFAG/JsF0VgOqcuJl3PMkRi4Mv7sU7fUEfcrpqpI3em+AiIkofehzjVbodd
 530mjhZ8ilGEW6VOTtfEPR7aSfIEQciyXPgZ+MgD2XwY933NG2Bh6JwT7HYlqL5rXtfDLwiucbX
 IWbw4kBsbfgFn5tytM2HwkLio1BAOwoH6YgrB3jUKeu078MnLT4tT7ma0ZTUQ5gt3Zp5V8J6PYA
 nfKl8pXWDSlF5IB2LDtWQJBfNrT/FmoWcdIvzEr9r4sREu9X6/osBUc+7YJ8Y9gO15mOq1gUMVR
 CWHxy+4Ahc8B9LcxYNbkW9XWdJJL1rLrTlg8Qvf+o/UNTkGf6pqG7w4toQIprAvqGsBtGMzO0hL
 Jqvk7DEd1e6+cKSRB2vlrWS3d/gYU/hmaWJwwz9A6n+WIGTC1gydo5jPZ6CxDcDkcA1hsiE/+zn
 ugeGWn+XF+SFzpSGdl5o3h38ppwMSz2Pljlb1DVJU5wPp9hvMBnVgKg5+3D5KmN/pIjPV50Idwp
 65gB5CiR5TJHU6qhjHy4cD5HYDabdcnZcPPy5qr2tXcnKjWKQ==
X-Received: by 2002:a05:620a:a2d2:10b0:915:5215:d90c with SMTP id
 af79cd13be357-9155215db99mr1131029685a.51.1780399426077; 
 Tue, 02 Jun 2026 04:23:46 -0700 (PDT)
Received: from
 runnervm3jyl0.f2me40mcla1u3fgo4t1ed122va.bx.internal.cloudapp.net
 ([57.154.218.71]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ccea26d286sm116546416d6.48.2026.06.02.04.23.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 04:23:45 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: XiaoLei Wu <wxl18715129466@gmail.com>
Date: Tue,  2 Jun 2026 11:23:45 +0000
Message-ID: <20260602112345.4019-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602061441.718227-1-wxl18715129466@gmail.com>
References: <20260602061441.718227-1-wxl18715129466@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/unlink09: report unsupported inode flags as TCONF
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

Hi XiaoLei Wu,

On Tue, Jun  2, 2026 at 14:14:41 +0800, XiaoLei Wu wrote:
> syscalls/unlink09: report unsupported inode flags as TCONF
>
> If FS_IOC_GETFLAGS fails with ENOTTY, the filesystem does not support
> inode flags. This is an unsupported test configuration rather than a
> broken test setup, so report TCONF instead of TBROK.

The change is correct. ENOTTY from FS_IOC_GETFLAGS means the kernel/
filesystem does not implement the ioctl at all, which is definitionally
an unsupported test configuration, not a broken test environment. TCONF
is the right result code.

Commit message is accurate and well-structured.

> diff --git a/testcases/kernel/syscalls/unlink/unlink09.c b/testcases/kernel/syscalls/unlink/unlink09.c
> @@ -63,7 +63,7 @@ static void setup(void)
>         if (TST_RET == -1 && TST_ERR == ENOTTY) {
>                 SAFE_CLOSE(fd_immutable);
>
> -               tst_brk(TBROK, "Inode attributes not supported by '%s'",
> +               tst_brk(TCONF, "Inode attributes not supported by '%s'",
>                         tst_device->fs_type);
>         }

LGTM. When FS_IOC_GETFLAGS returns ENOTTY the filesystem does not
support inode attribute flags; the test cannot run on such a
filesystem so TCONF is correct.

---
Pre-existing issues (informational, do not affect verdict):

In setup(), after SAFE_CLOSE(fd_immutable), fd_immutable still holds
its non-(-1) value when tst_brk() is called. Because tst_brk() invokes
cleanup(), and cleanup() checks `if (fd_immutable != -1)`, it will call
setup_inode_flag() (which does FS_IOC_GETFLAGS+FS_IOC_SETFLAGS) and
SAFE_CLOSE() on an already-closed descriptor.

Fix:

	SAFE_CLOSE(fd_immutable);
+	fd_immutable = -1;
	tst_brk(TCONF, "Inode attributes not supported by '%s'",
		tst_device->fs_type);

---
Reviewed-by: LTP AI Reviewer

LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
