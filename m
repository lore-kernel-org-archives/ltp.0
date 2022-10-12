Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB336C433FE
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 19:13:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 545633CAEC4
	for <ltp@archiver.kernel.org>; Wed, 12 Oct 2022 21:13:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 945613C071D
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 21:13:05 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9DD912000E9
 for <ltp@lists.linux.it>; Wed, 12 Oct 2022 21:13:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D049222986;
 Wed, 12 Oct 2022 19:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665601983;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFjjG4qAtzypHC7sIqkn9cPA5Qc2icxnvxKuJFJHj9k=;
 b=Zcv/b9ovoOj3e/dog88OXP4gt31gYCBwzcz6dsrXQGUBFqq9oMKaOgPLeqg8VhMKkRsns6
 VGGc21dnyCHPyMrxF6ZsXWbL6KVvaqLUhp815b9DwpYgjtdgJMRFidHkqlUs/x49/Q/bmu
 AZEfPEjp4I1Rf3rOZ51FWTFQi0+WpGc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665601983;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HFjjG4qAtzypHC7sIqkn9cPA5Qc2icxnvxKuJFJHj9k=;
 b=p8KFwQiOc+m4D7C+sMhscQp4ZACx6OEe2r43Ya60gM35ZEylmZOKDpzrO4Zmjt4UFB909J
 MnH8cVFgcifsk+Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7044F13A5C;
 Wed, 12 Oct 2022 19:13:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6Z6eGL8RR2OdOQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 12 Oct 2022 19:13:03 +0000
Date: Wed, 12 Oct 2022 21:13:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "Bird, Tim" <Tim.Bird@sony.com>
Message-ID: <Y0cRvJysXOJcabNL@pevik>
References: <20221012091526.35373-1-zhaogongyi@huawei.com>
 <20221012091526.35373-2-zhaogongyi@huawei.com>
 <Y0al/lzocpDw6hBb@pevik>
 <BYAPR13MB2503DBBBDBB055C42B36DDB0FD229@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR13MB2503DBBBDBB055C42B36DDB0FD229@BYAPR13MB2503.namprd13.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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



> > -----Original Message-----
> > From: ltp <ltp-bounces+tim.bird=sony.com@lists.linux.it> On Behalf Of Petr Vorel

> > Hi all,

> > The subject "lib: Add checking of needs_root" is a bit misleading
> > as it does not mention at all that it's for the loop device.

> > > We need to check needs_root is set when tst_test->needs_device or
> > > tst_test->mount_device is set since access the /dev/* need a
> > > privilege.

> > FYI we had some discussion about it, quoting Cyril [1]:

> > 	Well technically you can be added into whatever group is set to
> > 	/dev/loop-control e.g. disk group and then you can create devices
> > 	without a need to be a root.

> > 	So the most correct solution would be checking if we can access
> > 	/dev/loop-control if tst_test.needs_device is set and if not we would
> > 	imply needs_root. However this would need to be rethinked properly so
> > 	that we do not end up creating something complex and not really
> > 	required.

> > There is also possibility to add custom device via $LTP_DEV. That might allow to
> > add permissions which allow to test without root.

> > I'll write to automated-testing ML (and maybe to LKML ML) to see if people
> > prefers to test without non-root.

> I took a quick look at this, and don't like the change.

> I didn't investigate all the affected tests, and what device exactly is being protected.
> But the overall sense of the change takes makes the authorization checking for tests
> less granular.

> Fuego often runs tests as 'root', but it is also fairly common in Fuego to have a
> dedicated testing user account on a device under test, that has permissions
> for things like mounting, access to device nodes, etc.  This change
> would cause tests to break for that account.

Hi Tim,

thanks a lot for confirming that people are using non-root users for testing.
I'm not sure if we ever implement complex checks, but at least we should not
merge this patchset.

Kind regards,
Petr

> That's my 2 cents.
>  -- Tim


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
