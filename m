Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DBFC54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 07:05:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B11723C2C71
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 09:05:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 03C4D3C0229
 for <ltp@lists.linux.it>; Tue, 27 May 2025 09:04:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C349220097F
 for <ltp@lists.linux.it>; Tue, 27 May 2025 09:04:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EF1D121E81;
 Tue, 27 May 2025 07:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748329485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqZyCxbeqSPn34b4ntxYgPZAisPMjxQ8dbMEoFp0TUM=;
 b=plYdKXcl9haG53n1mg84t0N/JFprbe6HGDwR4dPe3taKgZG5pxrCcvha1xDz7W2pFmbLNg
 SpU+vhOfO5Abc7ekvHTnPb0Tx41YRo73WaNMeHjiHD8q3Xz/wPSbS5UuXjSAVzuGu7vL0/
 qJiy0ieuTpYruyehEPK79KHAviKjAJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748329485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqZyCxbeqSPn34b4ntxYgPZAisPMjxQ8dbMEoFp0TUM=;
 b=co6OZzU3/CDc3H8v/dpm67qEIL2FIqOud6vYSkdFWkQRn5oms40tusJR41TGVdJs40EjDh
 ml3nh+PqgTaEVQAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748329484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqZyCxbeqSPn34b4ntxYgPZAisPMjxQ8dbMEoFp0TUM=;
 b=eI+CJyesu0U8AqfQ/mWM0GRZd5i0jJe7g+dhTCJZ07dX/PJuzc4cGeqOpOo3NzQZKQVHHW
 454GjQY9JC35SIB6FDSkg8Li+cZz1KeCX2b/1OGxE64FtSXf2nktFdnmrIbVE9QpOs4VBN
 Bugz5heUnHN0hfDhPdcnzqod5Mplq/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748329484;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mqZyCxbeqSPn34b4ntxYgPZAisPMjxQ8dbMEoFp0TUM=;
 b=WW1d/peNy70aJwVbouj+g7oFyoaL7/a/QylfpZ5eHqtlKxhby9L8EHpeDuOpx3yDyHgnAJ
 GQBQEZSKZ5KDtSAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D97D41388B;
 Tue, 27 May 2025 07:04:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VQQ0NAxkNWhcKAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 27 May 2025 07:04:44 +0000
Date: Tue, 27 May 2025 09:05:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aDVkKHCmBTm1emH5@yuki.lan>
References: <aBSURzY2zu2HGI2x@yuki.lan> <20250507175707.GC182617@pevik>
 <CAEemH2cYmWZDAXHAR9zBTYiX1JcN69Jvj2Je3vHE427xx-ipkw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cYmWZDAXHAR9zBTYiX1JcN69Jvj2Je3vHE427xx-ipkw@mail.gmail.com>
X-Spamd-Result: default: False [-5.30 / 50.00]; REPLY(-4.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > As usuall we are going to produce a release at the end of the May, let's
> > > start with pointing out patches that should be reviewed before we freeze
> > > the git. If there is anything I should have a look on please let me
> > > know.
> >
> > It'd be nice also this macros doc related patchset merged:
> >
> > https://patchwork.ozlabs.org/project/ltp/list/?series=439525&state=*
> 
> I completed my pre-release test on both RHEL 9 and 10, everything looks good.

Great, thanks!

> Btw, I hope we can get this merge:
> https://patchwork.ozlabs.org/project/ltp/patch/20250520202429.577890-1-luizcap@redhat.com/

Yes, that one is on my radar along with a few more, ideally I think that
we should get in at least these two:

http://patchwork.ozlabs.org/project/ltp/patch/20250505105310.15072-1-mdoucha@suse.cz/
http://patchwork.ozlabs.org/project/ltp/list/?series=458430

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
