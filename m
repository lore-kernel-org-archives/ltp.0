Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A918AC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 09:01:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C0E83CA5B6
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 11:01:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B0653C9817
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 11:00:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 777D51400988
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 11:00:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8DF751F380;
 Wed, 27 Apr 2022 09:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651050049;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xK90vK8Ytvuyi0eItVQ9vU/mVKK2dkMup2KrN565F0U=;
 b=O0wPN8DYKN/f3zRkgNlT5Cgux1GzEMo5UmQHVXoF65DTCG/z+FDqBs5Ni8ZPZi/dB6g7VQ
 i9rYoSO0VmS/bqOEzI+H505mWPwdE3I1sTqUPOFk9Li6WbltGjliWXPwY8td+ddVvUbVWl
 p7RmN+ehpg6517D3cuThUieZogWLIh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651050049;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xK90vK8Ytvuyi0eItVQ9vU/mVKK2dkMup2KrN565F0U=;
 b=KlXlB13gOQNJP2szUM8zJpGADv2dN3c5P5qHuzGyV1bJHRYR8IaOFHhOCgjHTrU2LLOYE5
 yFAqe1FmOjTlIuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DBDF1323E;
 Wed, 27 Apr 2022 09:00:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fn0KGUEGaWKmVAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Apr 2022 09:00:49 +0000
Date: Wed, 27 Apr 2022 11:00:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YmkGP5aJcpiQXuK8@pevik>
References: <20220422144141.16848-1-pvorel@suse.cz>
 <20220422144141.16848-2-pvorel@suse.cz>
 <d448fbda-cbfb-e954-f5de-f1aa02b5bfd0@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d448fbda-cbfb-e954-f5de-f1aa02b5bfd0@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] shell: Use conditional expansion for
 library setup/cleanup
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

Hi Martin,

> > diff --git a/testcases/network/busy_poll/busy_poll_lib.sh b/testcases/network/busy_poll/busy_poll_lib.sh
...
> > -TST_SETUP="setup"
> >  TST_TESTFUNC="test"
> > -TST_CLEANUP="cleanup"
> > +TST_SETUP="${TST_SETUP:-setup}"
> > +TST_CLEANUP="${TST_CLEANUP:-cleanup}"

> The setup() and cleanup() functions here should get a prefix, otherwise
> we're asking for duplicate definitions. But that can be added in a
> separate patchset.

Actually setup() and cleanup() are functions in the test, thus the name is correct,
This was written by Alexey, but I also had this approach to put the same
variables into library. Test defines many variables, thus I'd keep them in the
library:

TST_TESTFUNC="test"
TST_SETUP="${TST_SETUP:-setup}"
TST_CLEANUP="${TST_CLEANUP:-cleanup}"
TST_MIN_KVER="3.11"
TST_NEEDS_TMPDIR=1
TST_NEEDS_ROOT=1
TST_NEEDS_CMDS="pkill sysctl ethtool"
# for more stable results set to a single thread
TST_NETLOAD_CLN_NUMBER=1

But I'd suggest to change:

# setup and cleanup defined in the test
TST_SETUP="setup"
TST_CLEANUP="cleanup"

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
