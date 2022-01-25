Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC27C433EF
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 10:56:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8C84B3C959C
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 11:56:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 798253C6349
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 11:56:37 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8BE8110009E1
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 11:56:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A95A221129;
 Tue, 25 Jan 2022 10:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643108195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xQ/8J+eH282iHeyq6sIakytGtAnkLW65gSr2/tGKy6Y=;
 b=rOUUGQXtjPJQx+Cu/CNRMjCIZLBNyKEg2rSgdjG72ge1VPTEkMW4QvM05FvZ+2ywtOMiwq
 TC4V5iCeQ2HwFYhIcJDH3mKDhNh5fZy2xvxruCjWLVY+E0sEuwwANi6xUOGvqOAzvdAL03
 olj38ivIkaUp7s+egKgobAg0kq6ODI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643108195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xQ/8J+eH282iHeyq6sIakytGtAnkLW65gSr2/tGKy6Y=;
 b=/6xb1uI/A5BvkmfDHwr65oZt9eih00lS6MB4JGirEFO/59Se6lw1+jnmi/5LixgLoZddg4
 8R3LHllB5ayxnJBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70FB213DB8;
 Tue, 25 Jan 2022 10:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OLK6GGPX72EqeAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Jan 2022 10:56:35 +0000
Date: Tue, 25 Jan 2022 11:56:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Murphy Zhou <jencce.kernel@gmail.com>
Message-ID: <Ye/XYWGiAEdzuhLT@pevik>
References: <20220125025008.xlnm3uwafi4dvaun@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220125025008.xlnm3uwafi4dvaun@xzhoux.usersys.redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] include/mk/env_pre.mk: remove dup makefile
 sourcing
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

Hi Murphy,

> This will cause file not found errors.
...

> +++ b/include/mk/env_pre.mk
> @@ -88,9 +88,6 @@ endif
>  # autotools, *clean, and help don't require config.mk, features.mk, etc...
>  ifeq ($(filter autotools %clean .gitignore gitignore.% help,$(MAKECMDGOALS)),)

> -include $(abs_top_builddir)/include/mk/config.mk
> -include $(abs_top_builddir)/include/mk/features.mk
> -
This is most certainly wrong, these includes are needed.

I guess you run make without running:
make autotools && ./configure

https://github.com/linux-test-project/ltp#quick-guide-to-running-the-tests

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
