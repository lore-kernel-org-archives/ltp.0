Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8E8CFC287
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 11:01:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A1983C671C
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 13:01:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 903843C12D0
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 13:01:06 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6AE42143EFBD
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 13:01:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2D3821DF8;
 Tue, 15 Oct 2024 11:01:02 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3E0213A42;
 Tue, 15 Oct 2024 11:01:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HasmJ25LDmeVQAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 15 Oct 2024 11:01:02 +0000
Date: Tue, 15 Oct 2024 12:59:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Zw5LLGMX0R9qKfRM@yuki.lan>
References: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
 <Zw46_xyBaWFPMShv@yuki.lan>
 <CAASaF6wY8AHH76YVf+UtJrcXtRL9d+UcR4rDf6S96EJiroPnKg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6wY8AHH76YVf+UtJrcXtRL9d+UcR4rDf6S96EJiroPnKg@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B2D3821DF8
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statmount07: drop "invalid buffer size"
 test
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
> > > This check relies on access_ok() check, which can be skipped
> > > on some arches/configs, for example on s390x with
> > > CONFIG_ALTERNATE_USER_ADDRESS_SPACE=y. Test then fails with:
> > >   statmount07.c:117: TFAIL: invalid buffer size succeeded
> >
> > And does it fail later on in the copy_to_user() if the buffer is
> > physically not accesible?
> >
> > We may add a test that would look like:
> >
> > | page mapped rw | page mapped read only |
> >              ^
> >              buf pointer starts here
> >
> > What do you think?
> 
> we can add that, it would be variation of "invalid buffer pointer" test

Looking at kernel __check_object_size() there seems to be a special case
for a NULL pointer in check_bogus_address(). The part that would check
if the page is writeable is done later. There are some checks in
check_heap_object() but I'm not 100% sure what these do. If I'm reading
it right it will abort the operation if the memory is not one continuous
vma, which is probably the case if we have two pages with different
access next to each other.

It may be interesting to go over the copy_to_user() code with someone
who understands mm and find a few cases to test.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
