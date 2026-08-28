Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74387C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 21:14:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7DED13E9A78
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 23:14:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DECF3E18A9
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 23:14:30 +0200 (CEST)
Received: from mail-qv2-x0b.google.com (mail-qv2-x0b.google.com
 [IPv6:2607:f8b0:4864:33::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F01D11000752
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 23:14:29 +0200 (CEST)
Received: by mail-qv2-x0b.google.com with SMTP id
 6a1803df08f44-90cd8e172acso3635336d6.0
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 14:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787951668; x=1788556468; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nqwl0Vt7rryEEoPOqjpa9g5Nwr/3OWeoH59WIwj41Cc=;
 b=jFLKcS19cxN6qH6DPr0l+3sJeEEQizGz26xR3/iyEZd/E4dfcLzA8Xe+DxB4UMzEde
 +tbypIeQfPiRJWb1KF+RyqyvDqm0AIV/iwhz8+M9gs1shTmQMnh7cLfY3zKBYmlSGS4V
 5vNr+MKdxox256B0NnUN5hq0HXWQOb24AxyFQqshHXtZ3MoL7EBHZJ5FPDRxAjZ4PKKP
 WLe0vfhAqR1ux2vUsJNhINdOiVQ1vGZsuP+w2C54WaAziOmXqMHF4tMw7do9T52I+60g
 DDtcWLgxJVKmw7f5r0jMQtLlxcs8qFURKjMreMVWY1wtxta1g+k5OwXHWTr0UnxXQ78J
 6d0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787951668; x=1788556468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nqwl0Vt7rryEEoPOqjpa9g5Nwr/3OWeoH59WIwj41Cc=;
 b=MSDD6FctLF8GD1ng4WCsYMw9rpF0NSTbBwWAXH3LoaZnaTuooPNLC7lCj7tjMjf2+t
 MYYTd/RxwuZOI1WXCDJuym/YaQhmewW5H/TiWQOAS9c7qmheO7yOOZU6GpdiW40lGJJy
 8jnd+jZ8TvccQOPhfEh7C0XVDQgrBcoTcxnAc1jcTKJo2RvIKRWtfmq0quWIhQTQ6JA1
 SSQoTGMi2KvS8b+z1sohzxhCY8Dv+0o1+PEe4CwShEHBB6jjLGjKHjN3hr5slumIcmSP
 vsyPWzU2DvXy0J+A6bG/Vq26gEk/UwvmSWh8+FdVXX8JhJ75cgrDt+om+b4eyPLvMjo8
 3TaQ==
X-Gm-Message-State: AFuF++lSK8IM/+J6ePnxPwEdXwxix9fIjzAhSO43mD6fmpzpjmskXlWK
 UgNWoNonc/WgboTgy+S6j/+aT72NnbMVMIaqxilEzNJDjvYn6kdKMU76
X-Gm-Gg: AR+sD12RRXBdBCSOVDBNgxgdR/W4GA5nTS9Np6V1Dn4o9qGfM0kL00x+FloZdLJ6N0Q
 5yc11b3LLKXMJZsicMYNgdf8gYiHWTU2dQVN5aA0Ro79O+ydqAgOoOsVu7eGladmVGNxHZAMJC/
 JoX7N2fymAg9LBzgjbR6BfPjppZrP9dPasJkfvTwwXJTsX7OlWm5cSNXWf6vJVV6m8/P9VsLs3V
 IRy3fYbYaGhSt/f+1aAsgMIS/sup7cw8oylZoSAEmr3iacgmxt2aWIZ4l1hBvO2IRucVc3PHM+W
 VoIRoJGohhTryhnuIHNP914ZejBUoYu5H+fcKNu5wc4Rprnqn+j3Aqk90YP/AV6HA9hJbKDMddZ
 2RWoAUMgAfyp0ZrXgydoaXrMmB3cYPMAFwYQaXiTqKT+3WCEd287Pq3VyZ+c0m4/KMmAWP7yZF5
 PYitNL5gnZmXQ6ImYelm8eEE3ZGjQXyVm+Ph/T17AzchiVRxH7jLDrSQZPyHYS/EgDTLziBOTNe
 RMgzJdur4XpIeTlo3aAF0uWBCFD5zm0QuszC2EG97HTi+hzc6U/tPyisgzToGQMlSE14Inf05PD
X-Received: by 2002:a05:620a:400c:b0:937:2ac8:bbda with SMTP id
 af79cd13be357-93913958017mr1118413085a.35.1787951668399; 
 Fri, 28 Aug 2026 14:14:28 -0700 (PDT)
Received: from
 runnervmgx7h7.4zenpulcgpvenhjux0oihply3f.bx.internal.cloudapp.net
 ([74.235.70.227]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917426e18sm226198985a.46.2026.08.28.14.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 14:14:27 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Aug 2026 21:14:27 +0000
Message-ID: <20260828211427.9415-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828-fchroot-v3-2-656a2b515726@suse.com>
References: <20260828-fchroot-v3-2-656a2b515726@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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

On Fri, 28 Aug 2026, Andrea Cervesato wrote:
> syscalls: add v7.3 syscall numbers

--- [PATCH 4/15] ---

> fchroot01: test fchroot() with a directory fd

Since 7.2 is the latest stable kernel and this test targets a 7.3 feature,
could the subject start with "[STAGING]" as required for unreleased kernel
features?

--- [PATCH 5/15] ---

> fchroot02: test fchroot() invalid arguments

Since 7.2 is the latest stable kernel and this test targets a 7.3 feature,
could the subject start with "[STAGING]" as required for unreleased kernel
features?

--- [PATCH 6/15] ---

> fchroot03: test fchroot() permission checks

Since 7.2 is the latest stable kernel and this test targets a 7.3 feature,
could the subject start with "[STAGING]" as required for unreleased kernel
features?

--- [PATCH 7/15] ---

> fchroot04: test fchroot() into failfs as root

Since 7.2 is the latest stable kernel and this test targets a 7.3 feature,
could the subject start with "[STAGING]" as required for unreleased kernel
features?

--- [PATCH 8/15] ---

> fchroot05: test failfs root can not be referenced

Since 7.2 is the latest stable kernel and this test targets a 7.3 feature,
could the subject start with "[STAGING]" as required for unreleased kernel
features?

--- [PATCH 9/15] ---

> fchroot06: test path walks under failfs root

Since 7.2 is the latest stable kernel and this test targets a 7.3 feature,
could the subject start with "[STAGING]" as required for unreleased kernel
features?

--- [PATCH 10/15] ---

> fchroot07: test execve blocked by failfs root

Since 7.2 is the latest stable kernel and these tests target a 7.3 feature,
could the subject start with "[STAGING]" as required for unreleased kernel
features?

> +fchroot07 fchroot07
> +fchroot08 fchroot08

The subject and body describe only the fchroot07 exec test. Could fchroot08,
which tests inheritance across fork(), be split into its own patch or
documented in a subject and body that cover both tests?

> The exec runs in a
> grandchild so a wrongly successful exec is still detected through
> the exit code.

Could this explanation be corrected to match the implementation?
fchroot07_child reports TFAIL and returns 0, while SAFE_WAIT(NULL) does not
inspect an exit status. The failure is propagated through the reinitialized
LTP result channel rather than through the exit code.

--- [PATCH 11/15] ---

> fchroot09: test setns escape from failfs root

Since 7.2 is the latest stable kernel and this test targets a 7.3 feature,
could the subject start with "[STAGING]" as required for unreleased kernel
features?

>  * Entering failfs with :manpage:`fchroot(2)` is hard to undo: a process
>  * inside counts as chrooted, so :manpage:`chroot(2)` and fchroot() back
>  * out require ``CAP_SYS_CHROOT``. The remaining way out is a pre-opened mount
>  * namespace file descriptor: setns() into it resets both the root and the

Could the raw fchroot() and setns() references use
:manpage:`fchroot(2)` and :manpage:`setns(2)`? Test documentation requires
the man-page role for raw syscall references.

--- [PATCH 12/15] ---

> fchroot10: test failfs entry without no_new_privs

Since 7.2 is the latest stable kernel and this test targets a 7.3 feature,
could the subject start with "[STAGING]" as required for unreleased kernel
features?

> +	SAFE_SETRESUID(ltpuser->pw_uid, ltpuser->pw_uid,
> +		ltpuser->pw_uid);
> +
> +	TST_EXP_FAIL(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
> +		EPERM, "unprivileged fchroot() without no_new_privs");

Could setup first verify that PR_GET_NO_NEW_PRIVS is zero and report TCONF
when it is already set? The bit is inherited and cannot be cleared. If LTP
is launched under a no-new-privileges policy, this child retains the bit,
the kernel permits this fchroot() case, and the test reports a false failure
without exercising the documented precondition.

--- [PATCH 13/15] ---

> fchroot11: test failfs entry with no_new_privs

Since 7.2 is the latest stable kernel and this test targets a 7.3 feature,
could the subject start with "[STAGING]" as required for unreleased kernel
features?

> +	TST_EXP_FAIL(unshare(CLONE_NEWUSER), EPERM,
> +		"user namespace creation blocked by the failfs root");

Could a separate unprivileged child establish that user namespace creation
succeeds before entering failfs? CONFIG_USER_NS=y only proves kernel support.
Runtime policy such as kernel.unprivileged_userns_clone=0, an LSM, or seccomp
can already return EPERM for nobody. In that case this assertion reports
TPASS without exercising the claimed chroot restriction.

--- [PATCH 14/15] ---

> fchroot12: test failfs entry with shared fs_struct

Since 7.2 is the latest stable kernel and this test targets a 7.3 feature,
could the subject start with "[STAGING]" as required for unreleased kernel
features?

--- [PATCH 15/15] ---

> fchroot13: test failfs entry when chrooted

Since 7.2 is the latest stable kernel and this test targets a 7.3 feature,
could the subject start with "[STAGING]" as required for unreleased kernel
features?

>  * of a chrooted task into failfs would allow it to escape its chroot via
>  * ``openat(fd, "..")`` with a pre-opened directory fd, so the kernel refuses

Could the raw openat() reference use :manpage:`openat(2)` and describe the
arguments separately? Test documentation requires the man-page role for raw
syscall references.

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
