Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 252A8C433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 09:17:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1B173C9231
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 10:17:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B55043C078E
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:17:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DA5871A014A5
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:16:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 23D7D1F3A6;
 Tue, 21 Dec 2021 09:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640078219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ArC5WflbODU4Ym76KoT6Dx+9SeyZ72kwL9r2KFwy2HA=;
 b=nDM9/HeLrWPPFqAOHaCb/CNEz57NNRBhWsgwplR8yxT9eS9EW56tFGu4PLNlTEw1YjfEwz
 CRb6zQdtttyaiu9jtz1WUxZs/UyuO+nxgIo/R/LMR52u+m0Z+vBTeMVojC7QpS4j1dlNyq
 A4KetwD7mqaiQjTXIZXuQ34yHLEmeDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640078219;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ArC5WflbODU4Ym76KoT6Dx+9SeyZ72kwL9r2KFwy2HA=;
 b=YKqIUMbIyvvEX0oSgNOH8J2BbZtgVANlEZSi5ToTARlwZBZsTg7YIC3bUfpyhGr0aTNxW5
 OstfYmAEPLtutmDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0799713C26;
 Tue, 21 Dec 2021 09:16:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pxrEAYubwWGEPgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Dec 2021 09:16:59 +0000
Date: Tue, 21 Dec 2021 10:18:29 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YcGb5abUqe8PNKoM@yuki>
References: <20211220095416.583323-1-liwang@redhat.com>
 <YcDMnDRgsac/q8D9@pevik>
 <CAEemH2d6PPi94q3PhMyR1Js_Rqr1dpfvch=ex3HpuHfQKJYTnw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d6PPi94q3PhMyR1Js_Rqr1dpfvch=ex3HpuHfQKJYTnw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > >     v2 --> v3
> > >       * rename to tst_disable_oom_protection
> > >       * support set PID as 0 to protect current process
> >
> > > +static void set_oom_score_adj(pid_t pid, int value)
> > > +{
> > > +     int val;
> > > +     char score_path[64];
> > > +
> > > +     if (access("/proc/self/oom_score_adj", F_OK) == -1) {
> > We need to check here also /proc/PID/oom_score_adj, i.e. score_path.
> >
> 
> Good catch, I would add a 'W_OK' checking and skip the setting with
> a reminder message if run without root.
> 
> how about this?
> 
> if (access(score_path, W_OK) == -1) {
>         tst_res(TINFO, "Warning: %s cannot be accessed for writing,
>                 please check if test run with root user.",
>                 score_path);

Hmm, I guess that we should produce TINFO if the file does not exist and
TWARN if we cannot write to it. Something as:

if (access(score_path, F_OK)) {
	tst_res(TINFO,
		"'%s' does not exist, skipping OOM score adjustement",
		score_path);
	return;
}

if (access(score_path, W_OK)) {
	tst_res(TWARN, "'%s' not writeable, are you root?", score_path);
	return;
}

>         return
> }
> 
> 
> -- 
> Regards,
> Li Wang

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
