Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FFC606A329
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=X1CAa66B
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46DC53CD783
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 20:01:01 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFD823CAB26
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 20:00:45 +0100 (CET)
Received: from mail-dy2-x08.google.com (mail-dy2-x08.google.com
 [IPv6:2607:f8b0:4864:36::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 71B9F2009DF
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 20:00:45 +0100 (CET)
Received: by mail-dy2-x08.google.com with SMTP id
 5a478bee46e88-3678f64d078so1324243eec.1
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 11:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793818844; x=1794423644; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=foRxULgp349Lfs5GsGk3zPUHhbSeKhVEkVGwqyxrbgs=;
 b=X1CAa66B8HoPWww5TDOrdhOorh3Lv67OoJ+Z16crJVWYKEhkiv3wpEJtrt07HDn3gh
 +IhLCmLhqs4rI3MJItSxJLSJoK2Zqlyb/jxsFk3auM7pfA+J9Eds6zqioYo7CJ7N74rv
 YKio+C+ZlkZMN3obJYT4ExPU2Y+TO8EGQ61JI1032noNChIVQB2+ao2m3dzA18YeQepC
 yirPhCEMFKHSM9NW0NkojwIwGH1uTiaGm9Fv8dsSJ8RVFV/Bd0ZOQSp5DEr+YIf9hLng
 t1fbEx55nPwngyIlY6nN1PxCjKq2bW4+ha/AozsaYMSc1QwevVNCXUydA2Vw21E4zguc
 Umlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793818844; x=1794423644;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=foRxULgp349Lfs5GsGk3zPUHhbSeKhVEkVGwqyxrbgs=;
 b=Ij0REDttQP1vp2MuXkDlz4ykTaRgFUFqDIM9gXU9GemCgbZhSkLPO89Ob4lO0yYjS8
 oLypYOiaidgnlptuPl52AR+9yldQBP0l7uwR860EQvwwjp6d60oH8+ZL+VAU/pP9zVr1
 mejxLKuMRUR49glFuosF9jrqTYSWBl/NFVRMOmEtArb4ypTQv03AJCXlSHtAuDxVt7iA
 xZOx2sJTaj4x96/KLltoJkukaH0smimGUwnw52fIqUyBFbZD9giQoW6GuZMZtPlvG2xn
 kWSLC2oZu00F5a0gzcKBkw9ddCi7S2WM3iL0zuuuzL/jBUDDoJn/GvJbBTi91ANXTtYO
 LALg==
X-Gm-Message-State: APuU4Z+d1g8rqSbnE+Psobw2fzGTsfLHRoB92hAfQ1Jm9P/3mg0Dd/zo
 Ja7Dq9NO9/b6bE3WGyV0z2jwCPES0Srb2KcIhzjLb2oNFQg0zyw9crDx
X-Gm-Gg: AYBFou1O3mNyxQFuR80LKHPPLSOPO8LN1aHkAt3X4Ty8GmIzuJGkfcDXFC54OmITcTU
 uP1ZM5xpjXExUNNGRWgvI1g/SNnAJ9k8exwV20Yx+w6YeXYmVSZWghpVZ8DtpisPlGQb2xLEuW3
 d9vkikoGkcbFek0xtzDNTWPSLGB/GdmvQAZuUTSkUbC1gtKeh5erI9dUjgLxGo96sLM742/muHu
 5Qs5Vsf3LaXpRlGP2oKYhGSdsxkvqqNiuR2UOoAUdFP9dIESjKAMZclHzGbzgG0mgbi3tjpCLhl
 oabVuS4Pi1H039jka+9QIFXVNmk4dUk9N16ObYa+S+5vlt51DNlQxQyClLenvH/Vl9+hoHWKtwT
 YCaQmT5YoQP1KLVZM7kc60va/y9uUrBHEr2oPSNDBo7pgNorMsykYJUxf3InhW8xXRL4wu/Jk09
 0t8IT0OOCJHAttQlqvXF/3PlMitjsNhS7JXPG9MUujo2GlQoiAnin9uzVeloq+YIraG9iagdoFA
 aB+FjrlxQyMWHK0M1UBqJRVwReTb/+ZsBpB3/eST7qLf06tYBUVqghDsvRtq0jbEewvo6QGKd5D
 rAZz7V3SooZH5loeDs4nifLeVXAt+AXmKV0u5TouscmtX0c8KiPK5ZjSqc+eEUUWz2PPh/Kkw6w
 OPsUdY1Ohdduwyu07Zn/bA15/PnBb957g2V0dChjjhA==
X-Received: by 2002:a05:693c:4159:10b0:356:7ddb:2e54 with SMTP id
 5a478bee46e88-36a423f186cmr28664144eec.29.1793818843164; 
 Wed, 04 Nov 2026 11:00:43 -0800 (PST)
Received: from
 runnervmnwato.pp30uvdt4hsedibpjocm02dith.dx.internal.cloudapp.net
 ([13.83.162.129]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca3785430sm14105631eec.3.2026.11.04.11.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 11:00:42 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Wed,  4 Nov 2026 19:00:41 +0000
Message-ID: <20261104190041.4928-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104164638.407069-1-sbertram@redhat.com>
References: <20261104164638.407069-1-sbertram@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] accept03/tst_fd: Harden parallel runs against shared path
 races
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Stephen,

On Wed Nov 4 11:46:36 2026 -0500, Stephen Bertram <sbertram@redhat.com> wrote:
> accept03/tst_fd: Harden parallel runs against shared path races

> This covers accept03, epoll_pwait06, ioctl_pidfd01, and splice07,
> which call TST_FD_FOREACH without a private tmpdir.
>
> +static void fd_path(char *buf, size_t len, const char *prefix)
> +{
> +	snprintf(buf, len, "%s_%d", prefix, getpid());
> +}

Tests that create temporary files or directories must set .needs_tmpdir = 1
in struct tst_test rather than creating files in the current working
directory. Without .needs_tmpdir = 1, open_file(), open_path(), and
open_dir() fail with EROFS/EACCES when run from a read-only working
directory and leave leftover files behind if interrupted before
SAFE_UNLINK()/SAFE_RMDIR(). Set .needs_tmpdir = 1 in accept03,
epoll_pwait06, ioctl_pidfd01, and splice07 (as epoll_ctl06, readahead01,
ioctl_ficlone04, and file_attr04 already do) and guard file creation in
tst_fd.c with tst_tmpdir_created().

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
