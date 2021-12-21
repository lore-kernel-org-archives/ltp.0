Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B290C433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 10:44:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19F963C91D1
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 11:44:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A1103C104E
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 11:44:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ECBDA1401261
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 11:44:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 40C051F3A6;
 Tue, 21 Dec 2021 10:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640083470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DPTqCE1PtD00oVFnbmbRxB6QQn+CQttP/1Ju/jfijW4=;
 b=uENf03XjWbW3SXPoFt7wA0HYtl3fQ2ebEd6dTH50BFvErtpcsgzN4idbC0gDrLw/pSD4Qz
 LlF94Jd0Pqnq2ucP2x+Bzqo3bN8QKsuewsPYag14xktx2ngjI92NvIec02JLl+yKCPqpI3
 2yO4T5hMTOz2gRU8XOlVbyKeINSpRWg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640083470;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DPTqCE1PtD00oVFnbmbRxB6QQn+CQttP/1Ju/jfijW4=;
 b=hP8wLoNuyqPqo3P4NqpY9qvc6SvoQ1bXtqjB11C0t7xNQG/xjFxT3ullaaDszMtYw/G+RG
 IzqSKfhkyaMymCCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 186C813C26;
 Tue, 21 Dec 2021 10:44:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id w8WSBA6wwWEjZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 21 Dec 2021 10:44:30 +0000
Date: Tue, 21 Dec 2021 11:44:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YcGwDKmi+iQuw3fS@pevik>
References: <20211220095416.583323-1-liwang@redhat.com>
 <YcDMnDRgsac/q8D9@pevik>
 <CAEemH2d6PPi94q3PhMyR1Js_Rqr1dpfvch=ex3HpuHfQKJYTnw@mail.gmail.com>
 <YcGb5abUqe8PNKoM@yuki>
 <CAEemH2dDEM30-fM89LDZq1E7YN8rf44doGgnkPXuce0ttP67OA@mail.gmail.com>
 <YcGlb4NoDGSP4ZkU@yuki>
 <CAEemH2fFY_TuCEqoR9ogqUBA5mFjY-FX+tDufYs39uN0JJ9gvQ@mail.gmail.com>
 <YcGuIJql99Row3o9@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YcGuIJql99Row3o9@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib: add functions to adjust oom score
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > So, I will push (the improved) code like below, after getting
> > Petr and you ack again:

> > +static void set_oom_score_adj(pid_t pid, int value)
> > +{
> > +       int val;
> > +       char score_path[64];
> > +
> > +       if (access("/proc/self/oom_score_adj", F_OK) == -1) {
> > +               tst_res(TINFO, "Warning: oom_score_adj does not exist,
> > +                               skipping the adjustement");

> I'm not sure about the "Warning:" in this message, I would just dully
> informed the user that the interface is not available.

I'd also prefer not having to print "Warning:" in TINFO message
(I know TWARN exit non-zero).

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
