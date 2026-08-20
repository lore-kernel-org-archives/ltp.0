Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4F8C5DF82
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 08:34:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAB6C3CD74F
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 10:34:57 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B75313C6EE3
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 10:34:39 +0200 (CEST)
Received: from mail-qk2-x09.google.com (mail-qk2-x09.google.com
 [IPv6:2607:f8b0:4864:34::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5BD86600850
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 10:34:39 +0200 (CEST)
Received: by mail-qk2-x09.google.com with SMTP id
 af79cd13be357-934956d1044so100699485a.0
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 01:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787214878; x=1787819678; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YDv9UnhesER+SR6hN/1ozrJqUpcDz1vM8jIQIR2d7lY=;
 b=HUT5BSprBzl4+EKzbfztt5Pkcjh+6F9Y5UdKDU86q/YYmGvkus9N6/UR0aGu7gx0MO
 EY6WfBkrVGIWEkCaWNT8anFvff8gM2G/j3jAPWcbEvAih6JsAb2BDeicIu1gCb1QTOvC
 gLlF19x4w83K93qYEvAwmcFpgoKLjLzFcMkgTkaAaXrG+xa2U/FMVrcm2i/vbkSb/MS9
 e49CzzLQ9jB6poA1nCAUXmQ0ifaXJ0hHSYSYtGYbVeIMsneQkKBWVCigcMKBOt2NcWdO
 eFF3T06i/KMIjCauM2UzCimfibC8SA9vC2VzFGSup0ZAJ8+9bdDckyUbFRyDg9M9Og5F
 2ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787214878; x=1787819678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YDv9UnhesER+SR6hN/1ozrJqUpcDz1vM8jIQIR2d7lY=;
 b=puEyMJuIkKwVmmfyFhbGR0PKBirIhBT3CK3GSQmJt3JBTSRXiP6z14nhcSpcxWRGnF
 uCJaRpndAufCDF9a6pVYqRQ/70jxBC4b4RwOvg9FYFKj8pUaw4Kn9qSScxCFS+7ShlMv
 DnL7KvoiBrDxxrsbz0dH8A0mCwlYCHSPiu1QSeIIUlK8ojPxwM0DZnoeq3l4K4+sPOdL
 tqjsKwxgNPq8EIy+FszjDQRWnLxfQygStE1oHyrvGELtdQzwysYoXiWQP551cRpLPRM+
 G82vHJolQLh2958bj6URBUYPfxtNF7VZ471kaO7BUC6d5QtTcpOzLOlo3QtLoLaiWEMX
 2qcA==
X-Gm-Message-State: AOJu0YzNpHFT9E/XjNre7EozXMKOoHBwCmsoe+cJ3bI0g+XS+GrTWNLH
 PokM4XXLvH+MLJpKOpaFHjVCTQV3ABUBv80AVyn2S7sfxz1KK7bbNfXc
X-Gm-Gg: AR+sD12lAzWrB92a03AHSk9Z3PJJqrDAMwTfo1H5WL4alsV69nZJualvu1IR0xHJTV4
 QcNySeh6FYORHpfQ7GzHF98fiyy+upl1WFA9fxGEP/3+6GHsqkq8+pChhVYRyDYh/aTnxewXJdX
 Y5VmwTdXWaOxIC1d1aE0jDXWdRaJxtMoLDpiES3qoWpJMuGkJA+7KT1NLALA8GGQVylQ+p8UH7i
 dzcE4l8bYUWhHCXsVPRT04idua2tLZXxlCUWuTbWNjfOVl9rdXkSgVPnBAvlALmK9p5eePrwgiH
 N1Xdz/ecG1BdLfLwlxkML6nQO1EAcySMF3vYnS6hApqlvnHrK0lOQWJpRo24Te7Q39oJEbNIkul
 mwx6On8UBLKp9z1oAS0V+wyBnB1cUmIqoEe5s2nSrWw3p6ALumOYXv6LHzBoKoG8lsF8cuGOY3R
 14oBYrtlH9AHxSYfg7MoPCZKDyvgzpXbsF5PD+0H1IU+uatsX+Z3qvU2ryAcogVd5E5NtzJyyj/
 zjN+aRzrhijMQjCqqxivIDizXARrxSOG6BBgIVXiV0onwdE8oRMZLpaMBttNakbyRsZdg+oZmU=
X-Received: by 2002:a05:620a:2847:b0:936:75ba:7c5a with SMTP id
 af79cd13be357-9371e6f65damr889167785a.31.1787214878025; 
 Thu, 20 Aug 2026 01:34:38 -0700 (PDT)
Received: from
 runnervm76f27.co2hjx4eohjutbealrn11xq3rc.cx.internal.cloudapp.net
 ([9.234.151.89]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c5f2b8164sm33303886d6.48.2026.08.20.01.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 01:34:37 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 20 Aug 2026 08:34:36 +0000
Message-ID: <20260820083437.4219-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820-fchroot-v2-1-062ed20957a0@suse.com>
References: <20260820-fchroot-v2-1-062ed20957a0@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: add v7.3 syscall numbers
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

On Aug 20, 2026, Andrea Cervesato wrote:
> syscalls: add v7.3 syscall numbers

--- [PATCH 4/16] ---

> fchroot01: test fchroot() with a directory fd

Could this subject be prefixed with [STAGING]? Linux 7.2 is the latest
stable release, while this test targets fchroot() from Linux 7.3.

--- [PATCH 5/16] ---

> fchroot02: test fchroot() invalid arguments

Could this subject be prefixed with [STAGING] because the tested syscall is
not present in Linux 7.2?

--- [PATCH 6/16] ---

> fchroot03: test fchroot() permission checks

Could this subject be prefixed with [STAGING] because the tested syscall is
not present in Linux 7.2?

>  * :manpage:`fchroot(2) `was introduced in Linux v7.3.

Could the space be moved after the closing backtick? As written, it becomes
part of the man-page role target.

--- [PATCH 7/16] ---

> fchroot04: test fchroot() into failfs as root

Could this subject be prefixed with [STAGING] because fchroot() and failfs
are not present in Linux 7.2?

--- [PATCH 8/16] ---

> fchroot05: test failfs root can not be referenced

Could this subject be prefixed with [STAGING] because fchroot() and failfs
are not present in Linux 7.2?

--- [PATCH 9/16] ---

> fchroot06: test path walks under failfs root

Could this subject be prefixed with [STAGING] because fchroot() and failfs
are not present in Linux 7.2?

> 	off += snprintf(upwards + off, sizeof(upwards) - off, "/..");

Could truncation be handled here? LTP accepts an arbitrary absolute TMPDIR.
With a sufficiently deep path, off grows past sizeof(upwards), the size
subtraction underflows, and the next iteration passes an out-of-bounds
pointer and a huge size to snprintf().

--- [PATCH 10/16] ---

> fchroot07: test execve blocked by failfs root

Could this subject be prefixed with [STAGING] because fchroot() and failfs
are not present in Linux 7.2?

--- [PATCH 11/16] ---

> fchroot08: test failfs root fork inheritance

Could this subject be prefixed with [STAGING] because fchroot() and failfs
are not present in Linux 7.2?

--- [PATCH 12/16] ---

> fchroot09: test setns escape from failfs root

Could this subject be prefixed with [STAGING] because fchroot() and failfs
are not present in Linux 7.2?

> 	SAFE_STAT(tst_tmpdir_path(), &st);
> 	TST_EXP_EXPR(st.st_dev == realcwd.st_dev &&
> 		st.st_ino == realcwd.st_ino,
> 		"working directory restored after setns()");

Could this stat "." and compare it with realroot instead? mntns_install()
sets both fs->pwd and fs->root to the mount namespace root. Calling stat on
an absolute tmpdir path succeeds regardless of the current working directory,
so a regression that leaves pwd unchanged would pass this check.

--- [PATCH 13/16] ---

> fchroot10: test failfs entry without no_new_privs

Could this subject be prefixed with [STAGING] because fchroot() and failfs
are not present in Linux 7.2?

--- [PATCH 14/16] ---

> fchroot11: test failfs entry with no_new_privs

Could this subject be prefixed with [STAGING] because fchroot() and failfs
are not present in Linux 7.2?

--- [PATCH 15/16] ---

> fchroot12: test failfs entry with shared fs_struct

Could this subject be prefixed with [STAGING] because fchroot() and failfs
are not present in Linux 7.2?

--- [PATCH 16/16] ---

> fchroot13: test failfs entry when chrooted

Could this subject be prefixed with [STAGING] because fchroot() and failfs
are not present in Linux 7.2?

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
