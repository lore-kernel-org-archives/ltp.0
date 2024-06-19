Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67648C27C79
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 15:59:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A26AB3D0DF1
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 17:59:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 324F03D0B3E
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 17:59:10 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ABF76204B59
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 17:59:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43165219DA;
 Wed, 19 Jun 2024 15:59:08 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC72A13AAA;
 Wed, 19 Jun 2024 15:59:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aDphNEsAc2ZGLgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 19 Jun 2024 15:59:07 +0000
Date: Wed, 19 Jun 2024 17:59:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Eric Sandeen <sandeen@redhat.com>
Message-ID: <20240619155902.GA477172@pevik>
References: <20240617053436.301336-1-liwang@redhat.com>
 <20240619092704.GA428912@pevik>
 <CAEemH2d=m3qAJkiv86B+L+iTc5qc+phGn+GO=kEe_fGOXxEMLQ@mail.gmail.com>
 <CAEemH2fH6tX9obxcVS6XJLcMvAvOz-JPe6wWoQdv26x8GAx2rQ@mail.gmail.com>
 <7aeebecc-d5ef-4eea-a4e5-ddbfa411ee1e@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7aeebecc-d5ef-4eea-a4e5-ddbfa411ee1e@redhat.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 43165219DA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure.ac: Add _GNU_SOURCE for struct
 fs_quota_statv check
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
Cc: linux-xfs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 6/19/24 7:08 AM, Li Wang wrote:
> > cc=A0Eric Sandeen <sandeen@redhat.com <mailto:sandeen@redhat.com>> who =
is the author=A0of:

> If adding _GNU_SOURCE to the LTP configure.ac fixes the problem,
> I have no concerns about that.

> However, I also sent a patch to fix xfsprogs - having this wrapper in the
> header is really unnecessary, and will likely cause problems for others
> as well, so I just proposed removing it.

Interesting. OK, let's merge workaround.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> https://lore.kernel.org/linux-xfs/be7f0845-5d5f-4af5-9ca9-3e4370b47d97@sa=
ndeen.net/

Thanks for info! Your patch IMHO makes sense.

Kind regards,
Petr

> (This problem only recently showed up due to other changes, see the expla=
nation
> in the link above)

> Thanks,
> -Eric

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
