Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EC5C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 16:31:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 543D33C9F00
	for <ltp@archiver.kernel.org>; Thu, 10 Feb 2022 17:31:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 969963C9C2E
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:31:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 352AD600F84
 for <ltp@lists.linux.it>; Thu, 10 Feb 2022 17:31:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 716921F391;
 Thu, 10 Feb 2022 16:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644510688;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XdCTmJnCbNVQv69JQiwaQaQw2gP6wA4Gzo13n/DvScc=;
 b=agsyQhIIYXcwQksIWLlEdGBiKBZSz+Tj6kPy47HJ9FqlS2zcpC7TsCIJiJX60DptY5dddR
 D/4f0gau8j89YK26hfhiYD1lorn3Us3ZPQMo6xBZzI4PTQAJmvMRk3nvhEAfCmSZ1LVKDF
 m78gDWtOYOj71rI0EZrJTU6SAScVOV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644510688;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XdCTmJnCbNVQv69JQiwaQaQw2gP6wA4Gzo13n/DvScc=;
 b=Py6Jwgkj1H355nMZ5rXPZowRiJkn0cYA3kTJ3PWwoklAzx77UV4/t1J/QAXmGDGEwyPSCs
 zMBZ6kC5KXEN6CBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 431C013BC1;
 Thu, 10 Feb 2022 16:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id o+lADeA9BWI/NAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 10 Feb 2022 16:31:28 +0000
Date: Thu, 10 Feb 2022 17:31:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YgU93mtJnqeTZPv3@pevik>
References: <20220127171455.9809-1-pvorel@suse.cz>
 <61F609C7.1080803@fujitsu.com> <YfeN6fG28AVNC44n@pevik>
 <CAEemH2fRtV+OqrW+x49RosgpyOYqCZ1ULxvZvqwypK8HQn6EQA@mail.gmail.com>
 <YflwND3aDJ1lg0ps@pevik>
 <CAEemH2dRwXdEN+eA5BhEyfK_cuvqhKu+mQFgJAtLJwWga1z+PQ@mail.gmail.com>
 <620095ED.1040808@fujitsu.com>
 <CAEemH2cs3-rBd+XTkh1A0ZtQxU-1WVx_pQtYGMyZX0zG48csew@mail.gmail.com>
 <YgO5XLFXQS+wxu4l@pevik>
 <CAEemH2cHe-Mc9g=ScTH5F0c5_WmrvsvHSObsDVy0aa-ayz76zA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cHe-Mc9g=ScTH5F0c5_WmrvsvHSObsDVy0aa-ayz76zA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run
 at all
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

> On Wed, Feb 9, 2022 at 8:53 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Li, Xu,

> > > > In fact, we don't have mandatory rules that TAPSS or TFAIL only can
> > > > occur one time. a example ie memcontrol02.c

> > > Right, that is my hesitant part for counting that.
> > > Seems many tests abuse the TPASS|TFAIL for defining test fail bound.

> > OK, while it'd be useful for some tests, it'd be confusing due this for
> > other.
> > I guess printing (tst_test->tcnt * test_variants) number can be confusing
> > either.


> Agree, so we might need more time coming up with a better solution.
> Or, we go another way to limit the abuse in TPASS|TFAIL in the test.

> But both sound not easy at this moment.
Given number of the tests we have (and how many of them we need to rewrite)
it'd be hard (and probably not worth of doing it).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
