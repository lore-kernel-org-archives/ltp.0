Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF6AC369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 08:52:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B37E3CB972
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 10:52:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD37F3C0EF7
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 10:51:55 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DA3A91A000F2
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 10:51:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8689921184;
 Wed, 16 Apr 2025 08:51:53 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A49513976;
 Wed, 16 Apr 2025 08:51:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VQV2Halv/2cOZwAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 16 Apr 2025 08:51:53 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Wed, 16 Apr 2025 10:51:53 +0200
Message-ID: <12664748.O9o76ZdvQC@thinkpad>
In-Reply-To: <20250416084057.GB577362@pevik>
References: <20250416072113.573818-1-pvorel@suse.cz>
 <CAEemH2e3XLZmS0aO4rRZPQ+qV+QOCvbtLWxngMY2so5gSnZpag@mail.gmail.com>
 <20250416084057.GB577362@pevik>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8689921184
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] cgroup_lib.sh: Improve error messages
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

On Wednesday, April 16, 2025 10:40:57 AM CEST Petr Vorel wrote:
> Hi Li,
> 
> > > +++ b/testcases/kernel/controllers/cgroup_lib.sh
> > > @@ -119,12 +119,12 @@ cgroup_require()
> > >         ret=$?
> 
> > >         if [ $ret -eq 32 ]; then
> > > -               tst_brk TCONF "'tst_cgctl require' exited. Controller is
> > > probably not available?"
> > > +               tst_brk TCONF "'tst_cgctl require $ctrl' exited. $ctrl
> > > controller not available?"
> 
> 
> > s/exited/existed
> 
> I understood that "exited" which was used previously was meant to be "exited
> with non-zero" (I can improve it this way to be more precise). Do you really
> think it's in TCONF related to controller existed?  I actually mean the opposite
> - one wants controller which does not exist due not configured in the kernel.
> 
I was also writing the same.
I think we should just change it to 'failed' as you did below.


Reviewed-by: Avinesh Kumar <akumar@suse.de>


> Kind regards,
> Petr
> 
> 
> > >                 return $ret
> > >         fi
> 
> > >         if [ $ret -ne 0 ]; then
> > > -               tst_brk TBROK "'tst_cgctl require' exited"
> > > +               tst_brk TBROK "'tst_cgctl require $ctrl' failed. LTP
> > > missing $ctrl controller support?"
> > >                 return $ret
> > >         fi
> 

Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
