Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2282C433FE
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 10:32:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFD9B3CAD20
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 11:32:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2A723CAC14
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 11:32:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 09AB1200915
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 11:32:45 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 51608338F7;
 Tue,  1 Nov 2022 10:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667298765;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KucHhAsju8yRC+RUxzJcjnPfCaEfSdz/rIstuhy9YeY=;
 b=xtN9Qfqm/qhWPi3ZYAI/00Xl2o1uVQ6Y+ZL6pZoVJkZ66X4YdQGm4U62xYLqQ2FU0PJTg8
 570QhoX+shxnmmKoFweHigG9F/lle7zZ2Bzd29ApUUIyVF9v1kDLRg9hbl/e8z8j8XVADe
 WG286i3qYx8AXEsRIfTJMMbSI+9o3rE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667298765;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KucHhAsju8yRC+RUxzJcjnPfCaEfSdz/rIstuhy9YeY=;
 b=wjSi10ONgFAYLyLwXknU+ieR7/ndWa1mfjEvrHdwDivghoycvbth+ZpYQEptmic1G55N/G
 KcJYOmGNEuScAWDQ==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 036A12C141;
 Tue,  1 Nov 2022 10:32:44 +0000 (UTC)
References: <20220808081501.21395-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 01 Nov 2022 10:31:16 +0000
Organization: Linux Private Site
In-reply-to: <20220808081501.21395-1-andrea.cervesato@suse.com>
Message-ID: <87h6zj9d83.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor pidns12 test using new LTP API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Pushed!

With changes to use TST_EXP_EQ* macro.

i.e.

...
static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
{
	TST_EXP_EQ_LI(si->si_pid, 0);
}

static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
{
	struct sigaction sa;

	TST_EXP_EQ_LI(getpid(), 1);
	TST_EXP_EQ_LI(getppid(), 0);
...

-- 

Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
