Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B78606A31A
	for <ltp@archiver.kernel.org>; Wed, 28 Oct 2026 09:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tp2pdsHq
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9D193E9989
	for <ltp@archiver.kernel.org>; Wed, 28 Oct 2026 10:16:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E2B93E187F
 for <ltp@lists.linux.it>; Wed, 28 Oct 2026 10:15:45 +0100 (CET)
Received: from mail-pz2-x0b.google.com (mail-pz2-x0b.google.com
 [IPv6:2607:f8b0:4864:3b::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4F2B5600819
 for <ltp@lists.linux.it>; Wed, 28 Oct 2026 10:15:45 +0100 (CET)
Received: by mail-pz2-x0b.google.com with SMTP id
 41be03b00d2f7-cd6b195dd0cso151034a12.1
 for <ltp@lists.linux.it>; Wed, 28 Oct 2026 02:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793178944; x=1793783744; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6lxG7+qXrh9Zcdl479wo7Eb0tsLMOYV7chTyfLFK8zE=;
 b=Tp2pdsHqCC3TnuCP+zIZ6uL2i3Ls8sDbkzqiTeCJmHOk/n7Or0G70dBi2Zdldt4THy
 nk3R5gVeAureOvTBXTDqrDZ5YZgcBEaR4WLEP81upXKzlKZ4JU4nM93+gJKHb3pfFxF2
 JDKE/wg2zUTqN3md3Tcg2Xv+rOlwXqq0Tm3QVAvTj/dxm3lXmaFnBKUZXwCe7tsaVIuB
 MQXE5QaYwRB1Aap2/dSoj4Dx6YAYzAFr8/WyjfQBQFbXvYAnFJtb7RYVWoXVXCyPBzti
 QDWZte/fAiIR0+AkyChbQg6GsvMigFx6fFwU8ILqRJTo8+EUWZyxrTogzAwIM3VGEtNm
 /CgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793178944; x=1793783744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6lxG7+qXrh9Zcdl479wo7Eb0tsLMOYV7chTyfLFK8zE=;
 b=YrY7NlIe3rilCiEGuYOw97Oh0OxQsEZe9zwxk2tVXnvyZPra3ooiIH/3t9AqMPn3lu
 uW3frWrsiiOEGShTcLrKuK3T2TJqPD8Nhi0184a2B85Y5Gz2hqkfsOdg2ugIuELoKLku
 l3ASHU4ClGRTNmEgZA4Oa9bO6larjd45huRDHGgGcBF9xEphkPZGXdkpPxRw3pVdL4cX
 osL3vHVQ6nZSWKzGOlpMJ0MS5t+3N0TjSxpfpBfnbTkAGQXG/VcLgbDfhawbcGSGWBRx
 gFVRQBvPfuChrJYs6g7coXwr8dLjhP5WIkMiyen37KyIQU+iv58kXQrbBNA0EYSR8n/S
 XqkQ==
X-Gm-Message-State: AFq9FYLuYgjG9JQEWJuwYA495OfqEDYIyhvfHIthYlM0YsspnJ1mgAJ1
 RooLILD/zsBv9vhwZY6DCKr2DIAFfy06eSIY2e4ssyveure3t92qvX/i
X-Gm-Gg: AYBFou1LIvACP0SJ2YKKXxXzAW+4sKzy3IoWgLPhHyfuZfIqa/SgNVcm5CFhH+grsNx
 57fiUcSdmuc+P6IAqnDEV/YXQuWeX2h+c3lIVD+qMGrGqWUPGpk0vlV0SXncYfzB2W/5qPz1rNt
 Z7pUR1nqUz3EDbocH3hkeKPCENLvgyD3lpejZ+pA0g2FkVN8LbMF+FCezkk8dX6RdJ/V/AzPXox
 K3Gq3n7EyCPDEON/cjQ89jWjn+VmcgocdNBzKBIKotsvsyRXmguW7ZFMext7yQuosxxi1jcSJaK
 QIDo56HbCL213fdadcLH9Vvxs5Fce3EDyPoX4wMcMnhaTlY+ik495IdT6ZsnSGPKSlmDzCYT0wE
 Ink5x+oTRb77p8C6gNHa7AfLACxtZLQx9kg5vezJeNANrmbLlawzgl3ZK+HjOxLAYM+QChZ+2HZ
 Jr1CDPjR6UP558w/jtuDnU2Xqa3wruFuE2ex0SdpOeyWBvp7+Ryn/ftmLVIokccWr3wKS3aJXI5
 fUn5cjAIT1qrhA1hOz6DHycOchp5WMbPrQOThhBfn1kmckse/fZksC5xrSEB69qFpjrpJdRhMtF
 xi+vd1WJKJfCwka9QHbP4TodNCTg14f9ZYJTt/WOBtNJ7PjGMPVNTaOEfceGz5N2lEDXpg1EAkS
 D6X+XPGGdUmbqwUoKS1Ors7ClbBu+vuu1+2k3BDazIQ==
X-Received: by 2002:a05:6a00:94fe:b0:8a3:23c1:c0e3 with SMTP id
 d2e1a72fcca58-8a6e97468d2mr1331384b3a.59.1793178943550; 
 Wed, 28 Oct 2026 02:15:43 -0700 (PDT)
Received: from
 runnervmtai0g.hzbvxcpudzzu3lufc4dns1xcda.xx.internal.cloudapp.net
 ([13.66.225.103]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a6a74b8a3bsm905503b3a.56.2026.10.28.02.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 02:15:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Edvard Conrad <edvard@tuta.io>
Date: Wed, 28 Oct 2026 09:15:42 +0000
Message-ID: <20261028091542.5840-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <P50G-yE--F-9@tuta.io>
References: <P50G-yE--F-9@tuta.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls/fanotify26: Add test for nested permission events
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

> Subject: [PATCH] syscalls/fanotify26: Add test for nested permission events
>
> A permission event reported on a stacked filesystem opens the real file
> on the backing filesystem to install the event file descriptor. If the
...
> The second case fails on a kernel without the pending fix "fs: let
> backing files inherit FMODE_NONOTIFY from the user file", so the test is
> added to runtest/staging for now.

Since the test is added to runtest/staging for an unreleased kernel fix,
the commit subject must include the [STAGING] prefix:

    [STAGING] syscalls/fanotify26: Add test for nested permission events

> +static void answer_one_event(void)
> +{
> +	struct fanotify_event_metadata event;
> +	struct fanotify_response resp;
> +
> +	/* Blocks for good if the event fd generates a nested event. */
> +	SAFE_READ(1, fd_notify, &event, sizeof(event));

Please use SAFE_READ_ALL instead of the literal 1, matching
SAFE_WRITE_ALL below:

	SAFE_READ(SAFE_READ_ALL, fd_notify, &event, sizeof(event));

> +	/* Releases whatever is still queued, so the opener can finish. */
> +	SAFE_CLOSE(fd_notify);
> +
> +	SAFE_WAITPID(opener, NULL, 0);
> +}

This SAFE_WAITPID() is redundant and discards the child's exit status.
The test library calls tst_reap_children() automatically after each
run() iteration, which waits for remaining children and verifies that
they exited cleanly.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
