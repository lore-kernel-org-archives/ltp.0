Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196C6C00144
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 16:04:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B2173CA165
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 18:04:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB0CB3C0727
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 18:04:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 01AF56005C1
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 18:04:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26EA7380F7;
 Tue, 26 Jul 2022 16:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658851474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uMM0MW/AS84+7A+Pfg+JjDmjsj5E7cWPPhV8J5oCm6E=;
 b=aO9Ob1JhHjMdE4FLHot3vze/GDaYVOnUjTw/KDmgo22W69o3ZHPrdkcYeAIU6uhGFFguCX
 6ijSgzn0RHa2OUfRSYZyweCGKeE6+NIBD2ivSb0zBP7MkIkp2mt5YSYaK9gES5B0/iJoez
 pe86c3E2OWkaQP/tAqiGmFNhGuZuBtc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658851474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uMM0MW/AS84+7A+Pfg+JjDmjsj5E7cWPPhV8J5oCm6E=;
 b=ZnDhX2mXL4PQUOqpFg7WUX7xyBjXZqQ/4TEti8H33THMb54+9g6PZM+393oCWA7TCM9G5U
 7x8hc+KUxMNFuvBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C54EE13A7C;
 Tue, 26 Jul 2022 16:04:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sDqCLpEQ4GJWZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Jul 2022 16:04:33 +0000
Date: Tue, 26 Jul 2022 18:04:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YuAQkA6xjE/j5FDp@pevik>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2cW-yEk598waeFkDT4tkN0hoXqDwKL3LKCuzBqWfNqvUg@mail.gmail.com>
 <87y1wg45jr.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y1wg45jr.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 00/18] Expand Cgroup lib and modify controller
 tests
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
Cc: LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hello,

> Li Wang <liwang@redhat.com> writes:

> > Hi All,

> > I have completed my review (and test) on this patch set, generally looks good!

> > With regard to the tiny issues, I think Luke you can just against the concrete
> > problem to follow up and fix it. No need to resend all patches with a new version.

> > I would suggest merging this patchset at present (in case of blocking other's (or duplicate) work).

> > CI builds pass: https://github.com/wangli5665/ltp/runs/7460955660

> > Reviewed-by: Li Wang <liwang@redhat.com>

> I'm also very keen to get this merged and can make the necessary
> fixups. However I will give Petr Vorel chance to look at the shell
> tests.

I can send tomorrow proposed fixes (diff or a patchset) so that we get the rest
merged this week.

Kind regards,
Petr

> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
