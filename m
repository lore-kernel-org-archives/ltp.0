Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8E1C433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 09:54:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 181743C8EA3
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 10:54:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E33883C092C
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:54:22 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DAAA91400C63
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:54:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EBE25212C4;
 Wed, 15 Dec 2021 09:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639562060;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F+OrsxxkronFRjD+FWx2bwZZ8H38f+Llt16ebgdtnyE=;
 b=cO0s/Rbg7xn55TnhYMpmTYNGP2K8Vv5YhtlM1PZsj0XUhzZ7EqnKSJR6+cgrbpLiO+mFUr
 bJh8PWRestPH+AryR4vZZDAVY/Pu8mJclslexEJC/wszpPwv+mmATPG0Z0xGAZkyuNPpqE
 axifYBBXhxXfr3oYN403eYuTEkUYaH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639562060;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F+OrsxxkronFRjD+FWx2bwZZ8H38f+Llt16ebgdtnyE=;
 b=4KtG8GuEYqKb7fmQpVezKEm3UK5J3tkxjmASxyRRSzyviamK0VyIW3VC/Oai7kQyvaVDYa
 jpp0gik4kAaS/FBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFF1313B09;
 Wed, 15 Dec 2021 09:54:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VQBsLEy7uWFoXwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Dec 2021 09:54:20 +0000
Date: Wed, 15 Dec 2021 10:54:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Ybm7StGlzB9YQVhH@pevik>
References: <20211214144309.6704-1-pvorel@suse.cz>
 <20211214144309.6704-4-pvorel@suse.cz> <YbjAOffrWpsMvinQ@yuki>
 <YbjKV7yUJS+njaCY@pevik>
 <CAEemH2eXMWXt5GeY8EXaoPbS66-fju71iY+hJERNKMip+DqxLA@mail.gmail.com>
 <Ybm1vgG1OfmTjzzO@yuki>
 <CAEemH2fkMVnRipZ-M_tYber5Y71RzrujyKVJFyEHyt+3AGfX4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fkMVnRipZ-M_tYber5Y71RzrujyKVJFyEHyt+3AGfX4Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] lib: Add support for debugging
 .all_filesystems
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

> Hi Petr, Cyril

> On Wed, Dec 15, 2021 at 5:29 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> > Hi!
> > > Hmm, I think it also makes sense to people who care about the
> > > only one filesystem on their product. So this should _NOT_ be limit
> > > for test/debug, because it can help to reduce testing time for specific
> > > requirements.

> > With that line of reasoning it should be just called LTP_FS_TYPES and
> > user should be able to specify a list...


> Okay right, so just let it is, if there is new requirement we can add that.

OK, I'll merge it as is. Thanks a lot both!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
