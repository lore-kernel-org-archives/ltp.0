Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12C1C433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 18:07:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E91813C91A8
	for <ltp@archiver.kernel.org>; Mon, 20 Dec 2021 19:07:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 469683C912A
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 19:07:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AF139601392
 for <ltp@lists.linux.it>; Mon, 20 Dec 2021 19:07:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5F45218FC;
 Mon, 20 Dec 2021 18:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640023657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jTf/rOfLIo/IHEJv+ideVPj0MhsHO3/HazU84UhMJGo=;
 b=f7s2/f/XtE//e5+p5rqTe+cP4RT8pNVh4oifsm394oTIr7Wzl3ht5ub1dtBmlPEheYm4I+
 WgLqqNGTm4EHv1ca+filzt9wAO9sgP54jw5ONv4epxRiiKe6Pa22qfBWhGsc8mrQ9QtIUd
 VeFk/V8WQt55tX6sM78dG12qXuTTBQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640023657;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jTf/rOfLIo/IHEJv+ideVPj0MhsHO3/HazU84UhMJGo=;
 b=aGlRhTL+kYuxwMfUA/QL8cFY29Xlbwnm3Hl+hN1zuD2P7gInmf1b1/Rw+Uw8GYBVhJ84uf
 V+UGUihUJ8bl3JCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 520BF13DBD;
 Mon, 20 Dec 2021 18:07:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id I3sTEWnGwGFJfAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Dec 2021 18:07:37 +0000
Date: Mon, 20 Dec 2021 19:07:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YcDGZ+eNcQ5fPsmN@pevik>
References: <20211118235744.802584-1-krisman@collabora.com>
 <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
 <8735nsuepi.fsf@collabora.com> <YZtLDXW01Cz0BfPU@pevik>
 <YZ4Wf3d+J36NPMfS@pevik>
 <CAOQ4uxgg6BvUtcaD4stDv7meS0it-0-iDWNiz_-=SRN_tvgzYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgg6BvUtcaD4stDv7meS0it-0-iDWNiz_-=SRN_tvgzYQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

[ Cc Cyril and Richie ]

> On Wed, Nov 24, 2021 at 12:40 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi all,

> > <snip>
> > > > Hi Amir,

> > > > I have pushed v4 to :

> > > > https://gitlab.collabora.com/krisman/ltp.git -b fan-fs-error_v4

> > > FYI I've rebased it on my fix 3b2ea2e00 ("configure.ac: Add struct
> > > fanotify_event_info_pidfd check")

> > > https://github.com/linux-test-project/ltp.git -b gertazi/fanotify21.v4.fixes

> > FYI I removed branch from official LTP repository and put it to my fork
> > https://github.com/pevik/ltp.git -b fan-fs-error_v4.fixes


> Hi Petr,

> Are you waiting with this merge for after release of v5.16?
> or is it just waiting behind other work?
Yes. Thanks for this input, we're just discussing our policy about tests for new
(kernel) release functionality. First we agreed to wait [1] (due problems
described in [2]), Richie is suggesting to merge earlier [2], although Cyril
had doubts it's worth of the work [3].

Kind regards,
Petr

> Just asking out of curiosity.
> I've based my tests for fan_rename (queued for v5.17) on top of your branch.

> Thanks,
> Amir.

[1] https://lore.kernel.org/ltp/20211210134556.26091-1-pvorel@suse.cz/
[2] https://lore.kernel.org/ltp/87lf0ffw1y.fsf@suse.de/
[3] https://lore.kernel.org/ltp/Ybc5QJSZM3YIji70@yuki/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
