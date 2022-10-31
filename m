Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C29ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 14:48:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22B653CAC10
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 15:48:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD2BF3CAA97
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 15:47:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0A54C200230
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 15:47:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 594CC338F2;
 Mon, 31 Oct 2022 14:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667227668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qlKvawRivyXqaXEVJsVuD1nmOklWz7P8+3gt/M4kzHg=;
 b=vQgHg/FvnlBYw70ysmyhHKuuHD6ELdU67Y/pdImJgEh19YVIljtHD4+J6RcGIx0da8IBVm
 0+MZEtxcSDitRJlztK+k3iXS6aac1rblRV8nsl/Psez0MU4DOEFKBNS+eSLjvuA6Jrg6kc
 SZsGDxjAlraokkOoMhTBSp4T6XH4ZEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667227668;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qlKvawRivyXqaXEVJsVuD1nmOklWz7P8+3gt/M4kzHg=;
 b=5r6nHr8yvDYvjDZHSM6jtqvgiGMvYB2zzyx4r6veIBo2r0JKUPlpPL1TUqi+gyeYwUmpE2
 YCmn3x/Powpl0ECg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45C1613451;
 Mon, 31 Oct 2022 14:47:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id owusEBTgX2PeBgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 31 Oct 2022 14:47:48 +0000
Date: Mon, 31 Oct 2022 15:49:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y1/gdNbWYxWBZYhv@yuki>
References: <20221029071344.45447-1-tsahu@linux.ibm.com>
 <20221029071344.45447-2-tsahu@linux.ibm.com>
 <CAEemH2e+FUZnQws-9pW5E25Uq01T0zaHzsk8QUa2KJsCKQpDBA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e+FUZnQws-9pW5E25Uq01T0zaHzsk8QUa2KJsCKQpDBA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] Hugetlb: Add new tst_test options for
 hugeltb test support
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > @@ -357,6 +369,12 @@ unsigned int tst_remaining_runtime(void);
> >   */
> >  void tst_set_max_runtime(int max_runtime);
> >
> > +/*
> > + * Create and open a random file inside the given dir path.
> > + * It unlinks the file after opening and return file descriptor.
> > + */
> > +int tst_create_unlinked_file(const char *path);
> >
> 
> what about renaming this function to tst_'get|create'_unlinked_file_fd?
> I guess the 'fd' part should be emphasized here.

It has create in name and in UNIX creat() creates file and returns a
file descriptor so I think it's fine. Maybe we can be even shorted with
something as tst_creat_unlinked(const char *path).

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
