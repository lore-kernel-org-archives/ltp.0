Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE38C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 13:00:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 156053CA154
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 15:00:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B07DE3C7FCC
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:00:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1621F10005C0
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 15:00:26 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 458CF37AD0;
 Tue, 26 Jul 2022 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658840426;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGZaTeamaLH0S4xpU6ZgqBI4YwradVFRf+c7qi6Z8OE=;
 b=ifF/ugs2dfZFkirKXuNQE6CPk4rsQlP2UW12FTx8mYR4yzg1zOhULE6bVKwLwzu2ZneO8u
 owuZxqQEPyCJ94rUXbCQHrz2ulPrvw8K2XDG0rmOZqwQF4q0A/e4lXELzYKrBFNUfec0yo
 0MVMj2+zkRDfkgJi46A4eDhCTjuJoYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658840426;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGZaTeamaLH0S4xpU6ZgqBI4YwradVFRf+c7qi6Z8OE=;
 b=KvnREvZWMmB/c3c4udro3r6/49ikIwrk3d/dKRY/sLMw+1oiyZeLPQ4fVyvpysJ7yX+jay
 GkvDrDuQ7qThfyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0894813A7C;
 Tue, 26 Jul 2022 13:00:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ok5RAGrl32IJEQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Jul 2022 13:00:26 +0000
Date: Tue, 26 Jul 2022 15:00:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Message-ID: <Yt/lZ/hQU903JfsH@pevik>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
 <Yt5Q/+Qmm+SVJLnA@pevik>
 <CADS1e3eKZSWBGm1H5h+8R6=1QTXV1Crb4D59pRi2hgEuw65maw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADS1e3eKZSWBGm1H5h+8R6=1QTXV1Crb4D59pRi2hgEuw65maw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> On Mon, Jul 25, 2022 at 1:15 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Luke,

> > could you please next time use the same version number for all patches?
> > Having different versions (patches have v2, v3, v5) is quite confusing.

> > Kind regards,
> > Petr


> Yeah I agree..

> It was supposed to make it easier to not have to re review stuff when the
> version hasn't changed, but it gets quite confusing.
> I'll use the same version number next time.
Thanks!

NOTE: If you want to increase readability, just add "Changes vN+1->vN:" into cover
letter (or to patches themselves).

Kind regards,
Petr

> - Luke

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
