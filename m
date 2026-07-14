Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19370C44501
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:54:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75BF73E77FB
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:54:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BD7753E2F07
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:53:49 +0200 (CEST)
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5835560071E
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:53:49 +0200 (CEST)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-c8c1ebd68a1so2720621a12.0
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 03:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784026428; x=1784631228; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8ntK4iRdIpODmBz1fx+OPrEXs2lFA9UnFbSJG8fEP3M=;
 b=Ng+krUgLtTuRJGnBmW0jrtU7vskrfEb/izsehlYYCc80TmxKfKEgFP9S6C7XUratbm
 DgdDdgFm7uyTSwG4h4rc9UR4ol9wvV1MUhNe8rl4aOQe+4oZ4kFsWm41braB/z3QJXSs
 tJKojyI41yrFfJSxlTYuxLFdxp7L3p8NEoL21SA4t6VwYBGQ1CYRpWenuJmnetGPKbzF
 jotdx2Nw122RSUkWToO8hUJXL9YGtHSvWmY/v29W3lR7J21KWJ04H2V6rnh4AxtKAqbu
 Fpp9ucd7kkvDJGfQ3WHHWk2gwQK827JCKtZrL6NDUfE4jbVCgaFxUD76FjNF/FaBm20K
 Y8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784026428; x=1784631228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8ntK4iRdIpODmBz1fx+OPrEXs2lFA9UnFbSJG8fEP3M=;
 b=IlM7cyHGzEmsfwTeltniZEwfutEJdPzM49slAvKJ29A12Dalx52Ucc+bQOUc5vFSC/
 u1ZiiltJohxUMZLOkMPJHPgIZ8gQWZahm11GDFm7EYbstpHXzquwPdhuLEY5uCmmjxKA
 seDnCzt0mNJyFFnsuwUw/x2cIFazxg1Ox/gGmUEVyi0b5ziCbrmpYdc6/ER8wNunJXC5
 wTtC2Yep5wonsbX+0t4rxjsY22PmQZ69jbU4Njtmddzbzf9g3OnirKZe5COlVO4h8tQs
 gAw3aXWDpxskXQdW+bckdTVoJSGKp4e211l249iX+lxt6WerzclYeym3ZxXbu4FJiNMs
 a/Rg==
X-Gm-Message-State: AOJu0YzFCJwKi+nYzwRLFHKE25LVfO1+To09cOkOEx2pMGoWkcycebSl
 vm0FDauqd41E2ySWESjcX64JvTgXI0JIJ/oE8aais6r4OSXjvICugrypJsRNvo7FqUQ=
X-Gm-Gg: AfdE7clnnJvKR6GuidKtQkY10bnrXkb1wMPE4uyFrgBBtgKtqdQ5VGmiCOYIgt+T+kb
 ScWygoLoW2mo90SCe8YYY9o/K6jkPYWJhFBCG9EaE9t8ZFFxIIk2T1fBg0/yG1A3XlGTRb/uvr0
 u8kA925UuBHV5OCykaGE4mAJepYFEH2MqB8jgOuGTC4KezJak2MGqekLeU3pg910ATHaj/7jeh5
 vru9xlugbQhPE1K0pQBAbQ4lU1R70Q9f2T7rAdU4S9y7ldznHZWE+Wx3gpdsQuzdekmqjvZVqF6
 8AKxKYCIiIDQTQhnr9o7uSkQQb7OVM57uNKcd0+gh8go6hN9uRU3cvAp2l+SpGRsAm6t3QH8//l
 zWDp/kChQqORsrqe5EIgWk3/iCozMdPGHgb/aAdgUilX+NtOA60wkQPBm2sSxQWc8jNxQ7Yfi4O
 Ovlp9lMKOPErMrFXE6EoSRMr/sJ0MaAc7f44/irvIXQszGrVW7c4fp3y50ev6bhdct3ibBLiR96
 56OZPlnmYtNk3iVabpgR/2ysV6G3Q==
X-Received: by 2002:a05:6300:2189:b0:3bf:6c08:4ebb with SMTP id
 adf61e73a8af0-3c3571d0894mr2592672637.48.1784026427489; 
 Tue, 14 Jul 2026 03:53:47 -0700 (PDT)
Received: from
 runnervm5mmn9.c1ygo510fseu3ihkomri2qkfzd.phxx.internal.cloudapp.net
 ([20.169.93.26]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm30183014eec.13.2026.07.14.03.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:53:47 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 14 Jul 2026 10:53:46 +0000
Message-ID: <20260714105346.3883-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-cve-2026-46331-v5-1-bab4ac23c1f7@suse.com>
References: <20260714-cve-2026-46331-v5-1-bab4ac23c1f7@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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

On Tue, 14 Jul 2026 10:38:58 +0200, Andrea Cervesato wrote:
> lapi: Add pkt_cls.h fallback

--- [PATCH 4/4] ---

> +/*
> + * Same as NETDEV_REMOVE_QDISC() but does not fail when the qdisc is
> + * missing (strict=0), so it can be used to clear a possibly absent qdisc.
> + */
> +#define NETDEV_MAY_REMOVE_QDISC(ifname, family, parent, handle, qd_kind) \

New public macros in include/ require kernel-doc (/** */), not a plain
block comment. The content is fine; it just needs the right opener:

  /**
   * NETDEV_MAY_REMOVE_QDISC - remove qdisc without failing if absent.
   * @ifname: network interface name
   * @family: address family
   * @parent: parent handle
   * @handle: qdisc handle
   * @qd_kind: qdisc kind string
   *
   * Same as NETDEV_REMOVE_QDISC() but passes strict=0, so it does not
   * fail when the qdisc is missing.
   */

> +#define NETDEV_REMOVE_QDISC(ifname, family, parent, handle, qd_kind) \
>  	tst_netdev_remove_qdisc(__FILE__, __LINE__, 1, (ifname), (family), \
>  		(parent), (handle), (qd_kind))
> +/*

No blank line between the closing of NETDEV_REMOVE_QDISC and the comment
that opens NETDEV_MAY_REMOVE_QDISC. All other macro blocks in the file
have a blank line between them.

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
