Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E44C433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 07:38:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6570C3CAEE2
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 09:38:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E0B33CA9C7
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 09:38:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 93458140112B
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 09:38:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0376D225C5;
 Thu, 13 Oct 2022 07:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665646722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U9UC2Yy1y+1PU/yG1LhSEFkFvVIJLAvev07G/MsKiGo=;
 b=ZSRzhkVpZaXEnnikCZOBIk8T18Wvjt+2lp5+bi0ugDdhoY87FZyveXrdhzEpX5PLD6Wbg0
 GhvAIMHl4bX8OHze2BZVERRTD/rHhsS6xzWoYFo4m9k7Lu2mhtu+BZihoSemnv3baWhy42
 m4IHG3sii+mJTkp6z8pm2zGIyhltOlA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665646722;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U9UC2Yy1y+1PU/yG1LhSEFkFvVIJLAvev07G/MsKiGo=;
 b=tdKrpQ/UlqerJQn6w8XsLI3a8MQ0k9a0XgL+3ZDkEHUgIDHktvMBuseLQKl6y8pNVTbkOG
 cOyDiKnddBF571Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5441139F3;
 Thu, 13 Oct 2022 07:38:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wA83LoHAR2M9TAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Oct 2022 07:38:41 +0000
Date: Thu, 13 Oct 2022 09:38:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: zhaogongyi <zhaogongyi@huawei.com>
Message-ID: <Y0fAgGH6R8uEbcqh@pevik>
References: <60876907d240408a9496aebde2a7a968@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <60876907d240408a9496aebde2a7a968@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: Add checking of needs_root
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi,

> If we neeed to run the test as a non-root user, the non-root user would belong to the root group.

> Shall we add a checking of needs_root and needs_rootgroup?

How many of these tests we have? I wonder if it's worth to add this.

Kind regards,
Petr

> Regards,
> Gongyi



> > > > -----Original Message-----
> > > > From: ltp <ltp-bounces+tim.bird=sony.com@lists.linux.it> On Behalf
> > > > Of Petr Vorel

> > > > Hi all,

> > > > The subject "lib: Add checking of needs_root" is a bit misleading as
> > > > it does not mention at all that it's for the loop device.

> > > > > We need to check needs_root is set when tst_test->needs_device
> > or
> > > > > tst_test->mount_device is set since access the /dev/* need a
> > > > > privilege.

> > > > FYI we had some discussion about it, quoting Cyril [1]:

> > > > 	Well technically you can be added into whatever group is set to
> > > > 	/dev/loop-control e.g. disk group and then you can create devices
> > > > 	without a need to be a root.

> > > > 	So the most correct solution would be checking if we can access
> > > > 	/dev/loop-control if tst_test.needs_device is set and if not we would
> > > > 	imply needs_root. However this would need to be rethinked properly
> > so
> > > > 	that we do not end up creating something complex and not really
> > > > 	required.

> > > > There is also possibility to add custom device via $LTP_DEV. That
> > > > might allow to add permissions which allow to test without root.

> > > > I'll write to automated-testing ML (and maybe to LKML ML) to see if
> > > > people prefers to test without non-root.

> > > I took a quick look at this, and don't like the change.

> > > I didn't investigate all the affected tests, and what device exactly is being
> > protected.
> > > But the overall sense of the change takes makes the authorization
> > > checking for tests less granular.

> > > Fuego often runs tests as 'root', but it is also fairly common in
> > > Fuego to have a dedicated testing user account on a device under test,
> > > that has permissions for things like mounting, access to device nodes,
> > > etc.  This change would cause tests to break for that account.

> > Hi Tim,

> > thanks a lot for confirming that people are using non-root users for testing.
> > I'm not sure if we ever implement complex checks, but at least we should
> > not merge this patchset.

> > Kind regards,
> > Petr

> > > That's my 2 cents.
> > >  -- Tim


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
