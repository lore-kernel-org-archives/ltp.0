Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41F0606A31A
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 06:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Q9TvYN8V;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=qVpfbZ9I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792565191; h=message-id :
 to : date : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=WX5Al7VX3y41vTTOB8Y6bSwh89EgPxav+uygUJvYVHg=;
 b=Q9TvYN8Vgn+4F9ps3ou8/gBONGDAucWiW8j+h06m+gDrKcdjPSWiU25Qa6WvJRaYBbQzT
 Zxe2Ezfy3dDwavik7/AaebXreDQcfLdblPwxJlf/pJtN13jcOH+aRiIZfklhfNXuDGacB9I
 99M88fELhWcfVYKkHBEsISRuDIrdtYk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56B2E3E60E9
	for <ltp@archiver.kernel.org>; Wed, 21 Oct 2026 08:46:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2E013E2772
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 08:46:11 +0200 (CEST)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C9FAA1000963
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 08:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1792565166; bh=Ael6BLUMPUeTh7w2swXqse6MvpoEdq6NcnO2P7OfPlI=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=qVpfbZ9IDhYbXnBNH2H4uwWlIrmE3WSaeTa+rTYFqgMSCCiCg013k6ut7EPwUIhnY
 am7aZ0r9lmixttlv65BAkvnkCkVIPtpMvSWuGMA4CQYNaNkJOOelziWizJuwlISMq3
 qZlaxNq9nB35kEv6FmRLiy5L7FPTscr4XqohHHco=
Received: from [10.61.27.36] ([120.244.109.81])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id B8510C50; Wed, 21 Oct 2026 14:46:05 +0800
X-QQ-mid: xmsmtpt1792565165tcgbhggfj
Message-ID: <tencent_6DA2BCEE26C49BD5E48BB967538BDD0ADE07@qq.com>
X-QQ-XMAILINFO: N84LmEYa7WqoQUx7MP/iKGzZYG9zrqMkGnf6S8CBGrJqIOcTisXvHMVo6QwIXt
 6mgayIV3bupxsDaLsor9DAgAjk/u7ielAxhgZrxk/UvPTrFwq5NU7GlCvrgLIK2QKqBI5MPXWK4l
 yw0MKgkjwjJPWKVv87pW5XMBCokPwth/WISAY5FrJSwiZAqzujO07Qm2yeDSxFgY2I1TwUnES2sX
 JR8a23PyCjjvAZCY1ovdf4KpzHjJ7pgdPVI0aM4vp+8SXN7mtZvvbG7MoTa/MXR1CF8FMrXVg4gO
 StUj+LhdYdgRnvOxLMtfF0AChiZMexMJhHmnYq4Wf0Gkyicp5xe1QirFxbc9nLN9Z9s5t6whwwB3
 jCPAqulUFIEUkWh3Z6RDbh85yybCzzW3mdfRB0Uwe/TdRC8p012J+qYUQ2QZhyY8wCHAHtRPJyYK
 LQDJDPdHXDmebwt4MfURAk7AyUVAvAKCGYOq14lxf/F9KU7oeL6YYKLRYbAnilPQM4AJwH0WorUn
 QCMciwXfHy5fuvT1YBPNW07TmpGiohn6GACrFk2MvHo0uEYfAMiUpVylg2cCZZ6PBQn/ZnGVs8iv
 2wiDC7VP82AGRpqp8Dcbr31M+qni6VKL+03NJV86CYqoEPQNHjSv9hN4geqR9K7mPCwpBuW1olEu
 NDJxdhAW8KTb6HoQbU9JTO5u+IVEHQjpSww9fckkebrFb0+NKhGhAmp1FZ0OArB8gi7muOI7KalA
 M7XyRywuTEyGaQxua3qnhoKgdyguQTIXbj5T1MyGQwVGhZQxgkhFFcmNR7dBI6SPri6edPEbnzom
 n1GZ7UO1MJolCB1OqWmijD+lxaQ+Gz6cHvleG3Ki5XYxRafubtypAAJNvNQ4QrMpzxtjgB+Ie3Yi
 0GrjGZeZFGK4KASBG9cVA4B3Njx3JQOoYPu/W/++5OpO47W04FJzYZceuMnC9vwx5cXbJ9wmVAZ+
 trsohTk0VaTxa64BbXDqv0ZryZSRQINd0om9Ku7KlQqTQswxeYLUlJ4ZrC39GQMJwEqMUS3Nl4ZA
 M2AgwmG+R/Uxa8AbqP3wWJ+/0f0Q4=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
To: ltp@lists.linux.it
Date: Wed, 21 Oct 2026 14:45:57 +0800
X-OQ-MSGID: <3d91521e681e1a5749306f19.ping@qq.com>
In-Reply-To: <tencent_182C622AB08B4EBB09116956A32EE29EF909@qq.com>
References: <tencent_182C622AB08B4EBB09116956A32EE29EF909@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_REPLYTO_END_DIGIT,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/munmap03: Fix addresses passed to munmap
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wenyuan Li via ltp <ltp@lists.linux.it>
Reply-To: Wenyuan Li <2063309626@qq.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

A polite ping on this patch, submitted on 2026-10-10 and still queued in
patchwork:

  https://patchwork.kernel.org/project/ltp/patch/tencent_182C622AB08B4EBB09116956A32EE29EF909@qq.com/

It still applies cleanly to current master (munmap03.c has not changed since
0c7346cb), CI is green on all builders, and the automated review returned
"Verdict - Reviewed" with no findings.

One detail worth a look: the out-of-range case now reaches the
"len > TASK_SIZE - start" check, because the previous RLIMIT_DATA based
pointer could never get there -- RLIM_INFINITY is not page aligned, so the
request was rejected earlier by the alignment test. That is the only
behavioural change in the patch, and it is explained in the commit message.
If you would rather keep the old construction, I am happy to send a v2
shaped the way you prefer.

Thanks,
Wenyuan


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
