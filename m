Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2981DC433EF
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 11:42:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 562673CAAD6
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 13:42:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CED43C0894
 for <ltp@lists.linux.it>; Thu, 19 May 2022 13:42:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A26961A0115A
 for <ltp@lists.linux.it>; Thu, 19 May 2022 13:42:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2EFE1F9E1;
 Thu, 19 May 2022 11:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652960553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVmTqDW0PmZsZK9gVw4hPVZWzQM8AZBJ6YJQ2jLTk6o=;
 b=n+fdUyKbbfKS/KfNQr3xdDxZu1Yq2H14Q5xBnCv99IyrvHW1DOLrdz0SCts5hgK3ZzNEBd
 yqdsZtQy5cNulDugqQ3/XwnziSGV/685+GNrx2vVM21h4v2WnSTvdovVqxmbLStsIbFADk
 dJQLjmuef33LgPYZO7Bi6nHBbdlKDjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652960553;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sVmTqDW0PmZsZK9gVw4hPVZWzQM8AZBJ6YJQ2jLTk6o=;
 b=Or+hhWcgIxZUznN+c1DL2vw5O0mcYwOLPpCUhNRuTbxUGc+WWgEJMoYgWpQ+dZTKVZM/0O
 nBM1rWfCtyH2eSCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACB2E13456;
 Thu, 19 May 2022 11:42:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LzklKSkthmI3cQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 19 May 2022 11:42:33 +0000
Message-ID: <2a205b3e-9d80-5134-fa9a-b28fbbf31297@suse.cz>
Date: Thu, 19 May 2022 13:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <YnkOEruIKIwEeC3M@yuki>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <YnkOEruIKIwEeC3M@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 09. 05. 22 14:50, Cyril Hrubis wrote:
> Hi!
> It's time to start working on pre-release preparations. As usually we
> should start by considering patches that should be applied before we
> freeze the git.
> 
> As for me I would like to get the runtime patchset in if possible.
> 
> What else should be considered for the release?

I'd like to add the two KVM patches - memory access helper functions and
multiple iteration support. I can't finish the KVM documentation until
they're merged.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
