Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0045FC433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 07:59:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2CD53C98BD
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 08:59:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E07CA3C6AF8
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 08:59:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0BC731A00784
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 08:59:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EEF081F3A5;
 Thu,  3 Feb 2022 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643875177;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3gnhRGlZjo3NseJTm9jfeY3YKsqDlK4PKkAAsHQc2K8=;
 b=UJNqQU2aV61/gi9j4Hz7KsKTfOpU5W5zSJSXXGw+6Fy+knwopJxxJt5bVMEzHnGsynw53d
 1CBdSSRqKc47zXedIcoeFH6anfD2jPbhOoi8/wFs+yus9U30I+IA8wf8iH4Ug3aHjAm8AT
 MGelURZSNJZdpZcidJrWwd+rWeUkGd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643875177;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3gnhRGlZjo3NseJTm9jfeY3YKsqDlK4PKkAAsHQc2K8=;
 b=wvxO/r4YfQXzaOZAxPytnKqG63VKHjQ3Cou6sz137sxiGCSV5jwzpCaVV4pyyU4As8hnfT
 CuQnQTrXlk9CIGCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4EAD13BA0;
 Thu,  3 Feb 2022 07:59:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +8GpKmmL+2GNDQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 03 Feb 2022 07:59:37 +0000
Date: Thu, 3 Feb 2022 08:59:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YfuLZxav/jI35QQF@pevik>
References: <20220203061222.625948-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220203061222.625948-1-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/inotify: New test for IN_DELETE
 regression
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
Cc: Ivan Delalande <colona@arista.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

thanks for this test.

> Check that files cannot be opened after IN_DELETE was reported
> on them.

> This test is based on the reproducer provided by Ivan Delalande
> for a regression reported in kernel v5.13:
> https://lore.kernel.org/linux-fsdevel/YeNyzoDM5hP5LtGW@visor/

> Reported-by: Ivan Delalande <colona@arista.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

> Hi Petr,

> The fix for this regression was applied to stable kernels
> 5.4.y, 5.10.y, 5.15.y, 5.16.y.
> The mentioned git tag is only the upstream commit.
> Feel free to add the stable git tags if you think they are needed.
FYI we don't track stable git commits which are normally backported
(vast majority of commits), we track only stable git specific fixes,
i.e.:

* c4a23c852e80 ("io_uring: Fix current->fs handling in io_sq_wq_submit_work()")

"No upstream commit, this is a fix to a stable 5.4 specific backport."

* cac68d12c531 ("io_uring: grab ->fs as part of async offload")

[ Upstream commits 9392a27d88b9 and ff002b30181d ]

Mentioned at note:
https://github.com/linux-test-project/ltp/wiki/C-Test-API#138-test-tags

The reason is that user can search simple backports himself.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
