Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4B7C5B572
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 22:28:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82D413CD682
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 00:28:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECE9A3CD537
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 00:27:50 +0200 (CEST)
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 308B160084E
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 00:27:50 +0200 (CEST)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-ca00ea47337so538838a12.0
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 15:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787178468; x=1787783268; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zMmU8bBVQYRHXFCSRreB5N0SCqWzQrFqmxPcX/FSaYk=;
 b=Bdz4RC/ZXSHyXbLk/umDy1QclPSwa0kaJoxpfklklqRH29VQOUQqYK5Ze16Ub97uup
 cr+DQgNcjZzrMNAJjseE/EH+6EeEklFQq9BW+/YqMMtWvTks5oRqmaR5u6atkeWvn308
 PuPkz8Q5A7Af5HBxjXNji/pE5n75uLCAwstWEHuVTT1/Ydl4edKdGZv5RLdAL1av56Yh
 8mr4pQyzKdO1IdUzYvuau8wMH3Llbs9aBhYtYQE7KoYhqrZxMcIjcobTeB7NzW013lts
 eneAnRFsACI2kBzwzIj3nS6CPf+PDRGBGwq41PnEg2uum+vgTUiNfQm6UVpb4iyx5iym
 4C1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787178468; x=1787783268;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zMmU8bBVQYRHXFCSRreB5N0SCqWzQrFqmxPcX/FSaYk=;
 b=rIzqB50Adrem3zfaGkqswpLKrxZFDgG1ANEl/4J3u0dJ3VjlIIwMXcuFuGaRqceAKJ
 HbS5Aa2zRd0X1USZWdKCGKr9cj/pV8OpWqWdlejZ2smMC/EVtR7xdObt6b1jWnI1NN1i
 YgaRbzJ2kz3A5xAd35bVLWRY9NM5fK0rNxfBZrhHpAZxIqnXl3xQjXz5ANhOHEAxxe75
 GQX6up+j1kWzX5g9jibfMKVSW6vMd4JofshoxTHjNbLdoCelDUKTiYnb4VgCI2cji3rZ
 v0fPCpbRMvtsYfdS0w2Xa6n13C7dOmh6O7+FFAOd3lmQ7rVqb3/vL9oir2sJ2CE2SFEI
 n4yg==
X-Gm-Message-State: AOJu0YziWEnMzrDZyd02nqoYTNBbN+61B8u+euu5vytJsB27FDpaSHZJ
 BxDe95w6G454U8CJfxl67zScIavqRbeXmaWAzXm21kH+ulDL+YorJGN2
X-Gm-Gg: AR+sD12Z4AfDwzJL0YbMmDCcPRrFxNUUAUmXQuzaTqJnIoWS9fOTx/HUU7xl0RHcXVS
 9bbmqczokELk6r60r7Mdrkqp0eWIiR/xM4Wtbk+VU6M3R22P1vH2ysJukft1QKwPtAPkkrp20wE
 eEwAT6wJ9eeefczmvA73kTy5D9A+5/HCnybcjuBFc2qDr+4J/BKWJ5tKwtG0pbgfnU46Xn56F3f
 nxwHy2u8YO5SnVKtvxVgDDAjc54Kf9CVj8hKuBv6JsFb6OiUDOT3Yjumh11ys6vTADUtTs0fKLY
 q1WnL55ALJ4W+qYySK6YLOlvbW4QQxozW22dM7mKgURFoCZXTUIAoHZKGbyLzDjGcQXNLMRcfht
 iznxOhMMzUmRjc5OmotLQoKGNx+KKGRbjGMnwydqmHU5ZonICAVTjwEKwlr3pQfn8KHUQFUoJe0
 UCde7tQ6PERmNpuSDIujX5BmU5Q0/V5/t4DKlPEuLtJBXDWpypzWtA1kPy/q9fNk/SICMJ/3Y9l
 QuTbF6PiII2M5sX8At/dScdeB87pmsjvS0eGnfkGdJUErzKECByTG3GTQKr+eTnmSJmV28WvDMJ
 sfifIlPvMw==
X-Received: by 2002:a05:6300:67c8:b0:3c3:76a8:c0f with SMTP id
 adf61e73a8af0-3cd00dcaa72mr14648733637.4.1787178468252; 
 Wed, 19 Aug 2026 15:27:48 -0700 (PDT)
Received: from
 runnervm76f27.jugp4dghd53ezkxajpihhsqn3f.dx.internal.cloudapp.net
 ([13.83.98.86]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327cbb46ff8sm3109844eec.23.2026.08.19.15.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 15:27:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 19 Aug 2026 22:27:46 +0000
Message-ID: <20260819222746.4120-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819-fchroot-v1-3-2dc2c3c3cf29@suse.com>
References: <20260819-fchroot-v1-3-2dc2c3c3cf29@suse.com>
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

On Aug 19, 2026, Andrea Cervesato wrote:
> syscalls: add v7.3 syscall numbers

--- [PATCH 3/16] ---

> /* Roots of kernel internal pseudo filesystems, usable as fd sentinels */
> #ifndef FD_PIDFS_ROOT
> # define FD_PIDFS_ROOT		-10002

Could these new public macros use kernel-doc comments? Public macros added
under include/lapi must be documented in syntax recognized by linuxdoc.

--- [PATCH 4/16] ---

> fchroot01: test fchroot() with a directory fd

Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
stable release, while this test targets fchroot() from the 7.3 development
cycle and is placed in runtest/staging.

--- [PATCH 5/16] ---

> fchroot02: test fchroot() invalid arguments

Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
stable release, while this test targets fchroot() from the 7.3 development
cycle and is placed in runtest/staging.

--- [PATCH 6/16] ---

> fchroot03: test fchroot() permission checks

Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
stable release, while this test targets fchroot() from the 7.3 development
cycle and is placed in runtest/staging.

--- [PATCH 7/16] ---

> fchroot04: test fchroot() into failfs as root

Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
stable release, while this test targets fchroot() and failfs from the 7.3
development cycle and is placed in runtest/staging.

--- [PATCH 8/16] ---

> fchroot05: test failfs root can not be referenced

Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
stable release, while this test targets fchroot() and failfs from the 7.3
development cycle and is placed in runtest/staging.

--- [PATCH 9/16] ---

> fchroot06: test path walks under failfs root

Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
stable release, while this test targets fchroot() and failfs from the 7.3
development cycle and is placed in runtest/staging.

> #define UPWARDS "../../../../../../../../../.."

Could this walk continue until the inode stops changing instead? LTP accepts
any absolute TMPDIR, so a path more than ten components deep leaves this
lookup at an intermediate directory and fails the root inode comparison on a
correct kernel.

--- [PATCH 10/16] ---

> fchroot07: test execve blocked by failfs root

Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
stable release, while this test targets fchroot() and failfs from the 7.3
development cycle and is placed in runtest/staging.

--- [PATCH 11/16] ---

> fchroot08: test failfs root fork inheritance

Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
stable release, while this test targets fchroot() and failfs from the 7.3
development cycle and is placed in runtest/staging.

--- [PATCH 12/16] ---

> fchroot09: test setns escape from failfs root

Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
stable release, while this test targets fchroot() and failfs from the 7.3
development cycle and is placed in runtest/staging.

> 		SAFE_STAT(".", &st);
> 		TST_EXP_EXPR(st.st_dev == realcwd.st_dev &&
> 			st.st_ino == realcwd.st_ino,

Should this compare "." with realroot instead? mntns_install() resolves the
target namespace's "/" and assigns it to both fs->root and fs->pwd; it does
not restore the previous working directory. Unless the test starts in "/",
this comparison fails on a correct kernel.

--- [PATCH 13/16] ---

> fchroot10: test failfs entry without no_new_privs

Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
stable release, while this test targets fchroot() and failfs from the 7.3
development cycle and is placed in runtest/staging.

> static void setup(void)
> {
> 	ltpuser = SAFE_GETPWNAM("nobody");
> }

Could setup query PR_GET_NO_NEW_PRIVS and return TCONF when it is already
set? The bit is inherited and cannot be cleared, so such a launcher makes
this test exercise the allowed-entry path and report a kernel failure.

--- [PATCH 14/16] ---

> fchroot11: test failfs entry with no_new_privs

Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
stable release, while this test targets fchroot() and failfs from the 7.3
development cycle and is placed in runtest/staging.

> 	TST_EXP_FAIL(unshare(CLONE_NEWUSER), EPERM,
> 		"user namespace creation blocked by the failfs root");

Could a separate unprivileged child first prove that user-namespace creation
works, with TCONF when the environment blocks it? Runtime policy, seccomp, or
an LSM can return EPERM even with CONFIG_USER_NS=y, making this assertion pass
without testing the failfs restriction.

--- [PATCH 15/16] ---

> fchroot12: test failfs entry with shared fs_struct

Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
stable release, while this test targets fchroot() and failfs from the 7.3
development cycle and is placed in runtest/staging.

--- [PATCH 16/16] ---

> fchroot13: test failfs entry when chrooted

Could the subject carry the "[STAGING]" prefix? Linux 7.2 is the latest
stable release, while this test targets fchroot() and failfs from the 7.3
development cycle and is placed in runtest/staging.

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
