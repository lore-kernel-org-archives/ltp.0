Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46DCC74A4B
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 10:24:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7C0C3CCD5A
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 11:24:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43E863CADA6
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 11:24:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id AC8EC140052C
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 11:24:20 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C1F921FE06;
 Mon, 13 Mar 2023 10:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678703059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aAqElaCI811xkWIT5M3DrcgjxxgHChELthZDhQUnjyU=;
 b=o+NTNtYVP5rPLaiaYLou3FK+FaPqvVmzPjdVDn+66FIc5WZIJ9Op5FPEhgRxKJ1k0OyW63
 SYsB+22yeAix1d7WW5MmjDYUQb7evzfD8cB/pofGXCKay3PdXNcIqmWhOwPm+Yb/M/8jzo
 6F9tn8EN0DtXvMtHMGgecHmFdYci/bE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678703059;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aAqElaCI811xkWIT5M3DrcgjxxgHChELthZDhQUnjyU=;
 b=ELlWfEUmlLGeqJHkfmx7NiYAqfPhV0aGkFFt+a+JrfIoUMGWQM0l3byd6aeIQ/ovywTTwV
 GTiWXj58O+YuGnCw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 400832C141;
 Mon, 13 Mar 2023 10:24:19 +0000 (UTC)
References: <20230307133431.6636-1-andrea.cervesato@suse.de>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 13 Mar 2023 10:22:29 +0000
Organization: Linux Private Site
In-reply-to: <20230307133431.6636-1-andrea.cervesato@suse.de>
Message-ID: <87y1o154q5.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Remove tomoyo testing suite
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
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Andrea Cervesato <andrea.cervesato@suse.de> writes:

> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> The tomoyo testing suite is built and installed inside the LTP testcases
> folder, but it's not used and maintained anymore.
> This patch removes it, so we get rid of ltp_clone_quick as well and make
> some space in the installation folder.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

TBH, this might be the best thing to come out of removing
ltp_clone_quick.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
