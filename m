Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0B2C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 14:54:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41DC93CAE95
	for <ltp@archiver.kernel.org>; Mon, 10 Oct 2022 16:54:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F8293CAE54
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 16:53:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 825CF1400B89
 for <ltp@lists.linux.it>; Mon, 10 Oct 2022 16:53:51 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5DE641F8AC;
 Mon, 10 Oct 2022 14:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665413631;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r5DawTXa+l7lkPqNNCnPV5ZofSautF+l+kSR/Vi7SjY=;
 b=NodEQAfk+JNuzMN2b9FTZii+uMrnTkMQSqkyqKhAZMGitddZ2uxax74Bqv4fBEBsdlzIQ9
 NzSMq+NKGjaR0Z2iDiwEbMqcMiJdE7gSInfZajW9c9fGjWjBifAZtrxrn6BfGqKNDzJzTB
 ZK5eFAXdAeIFIIMjO8t/Nso+o7NO49E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665413631;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r5DawTXa+l7lkPqNNCnPV5ZofSautF+l+kSR/Vi7SjY=;
 b=aIn1FQTtVARMYPF2RGeOfS6wNG1HG8WcAi1bGiIn2GAjXbSs31XDsE8sOVFIsp9hTbY8XO
 0r8o3xA4DbbmhuAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1921913ACA;
 Mon, 10 Oct 2022 14:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3lU+A/8xRGPCJwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 10 Oct 2022 14:53:51 +0000
Date: Mon, 10 Oct 2022 16:53:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Y0Qx/dUX3f/TbZ5R@pevik>
References: <adf3a4e338625d85401a7d5ec94b33f86a277c18.1665385670.git.jstancek@redhat.com>
 <Y0QVyF43F3ngrU3r@pevik>
 <CAASaF6wx-zFhbFG6TQ28hj5g9fwwciJQiZ-TXvPDOkDH-+9+Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6wx-zFhbFG6TQ28hj5g9fwwciJQiZ-TXvPDOkDH-+9+Dg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/ioctl03: add IFF_NO_CARRIER feature flag
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
Cc: ltp@lists.linux.it, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Mon, Oct 10, 2022 at 2:53 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Jan,

> > thanks for fixing this. Sven was faster [1], thus merged his commit
> > with also your Signed-off-by:

> Thanks Petr, I haven't seen his email - I received it only hour ago to
> my mailbox.

I'm sorry, I didn't know it was in ML quarantine (Cyril noticed).
Anyway, thank you.

@Sven it's not a good idea to post to ML without being subscribed,
please subscribe next time before posting.

Kind regards,
Petr


> > Kind regards,
> > Petr

> > [1] https://lore.kernel.org/ltp/20221007105727.2303349-1-svens@linux.ibm.com/



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
