Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BE5C433F5
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 11:55:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5F513C9AEB
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 12:55:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F422B3C07BD
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 12:55:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 731F010005FE
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 12:55:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 52357210FD;
 Mon,  7 Feb 2022 11:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644234944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rBKnMnVxQavYqdVRAeewGfV3vpOGjnIcTgLF5Ail9i0=;
 b=Y5gouFCjU/a+pWLBdfDSi2W+UvyYxQugpMdnk/rOPnnmrl737sTgLUi2qnFg01S9V/9W3Q
 xYrOX7Ep+jTfEJqrKGncpA8ShLZlIUltE6PYY/6bGDU8e9MkXmh26AE8GEU5OvGUUkTaVV
 l7ylTfaBejGq4NEGrnArXArPfjstLLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644234944;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rBKnMnVxQavYqdVRAeewGfV3vpOGjnIcTgLF5Ail9i0=;
 b=SRG+N0o0iBzk5Jr/wmO+PoOOr2AWScrIF6lzDwbg16WeR9h5J/mIdqAc6lSGdorMk6y+E6
 nm3gYXqVUmRDT7Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A40613B92;
 Mon,  7 Feb 2022 11:55:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CtmmBMAIAWIWbgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 07 Feb 2022 11:55:44 +0000
Date: Mon, 7 Feb 2022 12:55:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YgEIviW5/HrW4yja@pevik>
References: <61F36C39.9030806@fujitsu.com>
 <1643365754-5366-1-git-send-email-daisl.fnst@fujitsu.com>
 <YgEB9/BvNhgIAl2n@pevik> <YgEDBRSBEUMK3dEF@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgEDBRSBEUMK3dEF@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/statx09: Add new test
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
Cc: xuyang2018.jy@cn.fujitsu.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi!
> > > +static void run(unsigned int i)
> > > +{
> > > +	tcases[i].tfunc();
> > > +}
> > OT: we may lack something in the API, when function like this need to be
> > defined.

> See:

> https://lists.linux.it/pipermail/ltp/2017-October/005829.html
> https://lists.linux.it/pipermail/ltp/2017-July/005132.html
https://lore.kernel.org/ltp/860483630.25581747.1507017497043.JavaMail.zimbra@redhat.com/
https://lore.kernel.org/ltp/20170727081437.27995-1-chrubis@suse.cz/

Very nice that you remember your old work :) (we didn't have patchwork back then).

Now I remember it - you already implemented it in 5 years old RFC, Jan didn't
see a value and that's why it haven't been merged.

Yes, Jan is right that it complicates code a bit, but even if you replace this
code:

statx09.c
static struct test_cases {
    void (*tfunc)(void);
} tcases[] = {
    {&test_flagged},
    {&test_unflagged},
};

static void run(unsigned int i)
{
    tcases[i].tfunc();
}

with .test_all where you have the switch it still kind of boilerplate. Thus I
agree with cyrils argument:

https://lore.kernel.org/ltp/20171003125958.GB11692@rei/

	"aiming to avoid the need to have a switch () in each testcase that
	implements a similar tests but cannot be easily data driven (as we do
	for most of tests that loop over an array of structures describing the
	test data)"

Thus, not sure if we want to rething the implementation, but I'd be for adding
the support (sure doc and docparse adoption would need to be added but that's
obvious).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
