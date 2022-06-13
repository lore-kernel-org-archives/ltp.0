Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20D1C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 13:51:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B7963C9458
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 15:51:35 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24F2B3C257E
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 15:51:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 40CDB60075F
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 15:51:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6771F1F38A;
 Mon, 13 Jun 2022 13:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655128282;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GDDGc858geMcJO2NLiKQC78kcDOxtdXqolgPaGwvbyc=;
 b=DRVSUkyEgNBn1b1BZ35TgjaoFnKYC06oCdr8gygYgX5lutBbvxU0SxY8LBpEipnxws3qrz
 4WV26Wx6H4MqN27aCICm493QW6PVEi8vLOlaDririfEwnLDBk1OYqFVZAP7y06DmSB6gwZ
 QV5UgveLT1xxDm0BpO3R0OVNgD99XMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655128282;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GDDGc858geMcJO2NLiKQC78kcDOxtdXqolgPaGwvbyc=;
 b=IFWC3PbXyv7wTbZMcsvhC9fyYKZd649f31uLXCzGXmicA8XbCf22UDS/5Ts04np1oSEJX9
 MG2COAS32jEFmxBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30D08134CF;
 Mon, 13 Jun 2022 13:51:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id h4bzCdpAp2LLNQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Jun 2022 13:51:22 +0000
Date: Mon, 13 Jun 2022 15:51:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YqdA2P+NCeGKdB5q@pevik>
References: <20220613125153.20423-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220613125153.20423-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/execve06: Add test for argv[0] = NULL
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

HI Cyril,

> Adds a test that kernel sets argv[0] to a dummy empty string if NULL was
> passed to the execve() syscall. This was introduced in commit:

> commit dcd46d897adb70d63e025f175a00a89797d31a43
> Author: Kees Cook <keescook@chromium.org>
> Date:   Mon Jan 31 16:09:47 2022 -0800

>     exec: Force single empty string when argv is empty

> in order to fix all potential CVEs where userspace programs attempt to
> blindly process the argv[] list starting at argv[1]. There was at least
> one example of this caught in the wild CVE-2021-4034 in polkit but there
> are likely more.

Great, thanks for addressing this.

> Fixes: #911

>  testcases/kernel/syscalls/execve/.gitignore   |  2 +
>  testcases/kernel/syscalls/execve/execve06.c   | 49 +++++++++++++++++++
>  .../kernel/syscalls/execve/execve06_child.c   | 27 ++++++++++
>  3 files changed, 78 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/execve/execve06.c
>  create mode 100644 testcases/kernel/syscalls/execve/execve06_child.c

This should go to runtest/syscalls and runtest/cve, right?
(can be fixed before merge).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
