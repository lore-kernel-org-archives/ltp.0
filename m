Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C84D15D82
	for <ltp@archiver.kernel.org>; Mon, 21 Oct 2024 12:22:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B0543C6F2C
	for <ltp@archiver.kernel.org>; Mon, 21 Oct 2024 14:22:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A3F63C24AE
 for <ltp@lists.linux.it>; Mon, 21 Oct 2024 14:22:38 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 37231619598
 for <ltp@lists.linux.it>; Mon, 21 Oct 2024 14:22:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 53A3C1F38E;
 Mon, 21 Oct 2024 12:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729513353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jv1+tahy/+THgL0qZAx1R1YHhVIDNP1O/SigsTFmSh4=;
 b=u5hTQl+5EDwBf6thVTkG/g/1wiS/Zp7asDqgCaFrav1dxaJihCDMb+6UT3Gji2Ihc35MwV
 sg3VUtuyLUtdMedLDcxL1AaFjnu4qU9GIIUBnVQVyofWvPP07QwK3Mo/07/Qs0iekZ+E5m
 IPfpfgegzCsDIjtJtO4y4/35+IOaSJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729513353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jv1+tahy/+THgL0qZAx1R1YHhVIDNP1O/SigsTFmSh4=;
 b=ihbPpoYw2di+r9h1hIXQR3mjWGNfW3t+0/fgc+gtjY3rG6DtBsApLv3W0rs6SMXBLI21ub
 DonHZ8KO3JeeaxDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729513353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jv1+tahy/+THgL0qZAx1R1YHhVIDNP1O/SigsTFmSh4=;
 b=u5hTQl+5EDwBf6thVTkG/g/1wiS/Zp7asDqgCaFrav1dxaJihCDMb+6UT3Gji2Ihc35MwV
 sg3VUtuyLUtdMedLDcxL1AaFjnu4qU9GIIUBnVQVyofWvPP07QwK3Mo/07/Qs0iekZ+E5m
 IPfpfgegzCsDIjtJtO4y4/35+IOaSJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729513353;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jv1+tahy/+THgL0qZAx1R1YHhVIDNP1O/SigsTFmSh4=;
 b=ihbPpoYw2di+r9h1hIXQR3mjWGNfW3t+0/fgc+gtjY3rG6DtBsApLv3W0rs6SMXBLI21ub
 DonHZ8KO3JeeaxDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CAC8139E0;
 Mon, 21 Oct 2024 12:22:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pqXwCYlHFmeZLAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 21 Oct 2024 12:22:33 +0000
Date: Mon, 21 Oct 2024 14:22:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Chuck Lever <chuck.lever@oracle.com>
Message-ID: <20241021122231.GA463560@pevik>
References: <20240926041358.951923-1-maxj.fnst@fujitsu.com>
 <ZvVklazV8ZF4xE1k@tissot.1015granger.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZvVklazV8ZF4xE1k@tissot.1015granger.net>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tirpc_clnt_destroy: Determine the return value of
 clnt_create()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Thu, Sep 26, 2024 at 12:13:58PM +0800, Ma Xinjian wrote:
> > Determine the return value of clnt_create() to avoid segmentation fault
> > when executing clnt_destroy() when the return value of create is NULL.

...

> That's the basic idea. And then apply the same fix to other tests
> that call the clnt_create(3) APIs.

Thanks a lot for fix and review, very much appreciated.
@Ma Xinjian or @Chen Hanxiao, could you please add this cleanup to all tests
which use clnt_create() as Chuck suggested?

Kind regards,
Petr

> Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
