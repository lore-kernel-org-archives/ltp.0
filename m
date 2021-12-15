Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A723EC433EF
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 09:14:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F4BF3C8F82
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 10:14:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2046F3C81BE
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:14:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 244091A00143
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:14:14 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 395B221136;
 Wed, 15 Dec 2021 09:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639559654; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZT7K/QZe5Z4uMvRz3DCbj+WstUYb4ogA0KWFwTDexTg=;
 b=iXl7bpv14i1UFF14PRSgC4Q7YDZ0GxuEFb9GZCbwdZcL0yAkBjcjADfWX6g+wNPiWDxDcv
 4IfvlCxjJFr/yAvS87Z05aDN7gjIvwHAYqgRn0q8bGm3e8YHBWwbJe12OLGbWpBjDzZiob
 nvg8AdZ8EXuweqBrATHWFIAHTD+aROY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639559654;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZT7K/QZe5Z4uMvRz3DCbj+WstUYb4ogA0KWFwTDexTg=;
 b=nM4hgESGwdEQVWjRj/nwnq+fz2EhPLJpQ7373MCajg5UV5BwLyN29I4ys0yeojIZK7QGOX
 ef0j4dHBrjHElLCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F19613AC7;
 Wed, 15 Dec 2021 09:14:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MSozB+axuWGvTAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 15 Dec 2021 09:14:14 +0000
Date: Wed, 15 Dec 2021 10:15:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YbmyOiLC3Bhe0l4i@yuki>
References: <20211209230854.30755-1-pvorel@suse.cz> <YbM+zuuy41468Dcf@yuki>
 <YbmcfACzQ1SJFCoR@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YbmcfACzQ1SJFCoR@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] github: Add action to update wiki
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
> I'll also update doc/maintainer-patch-review-checklist.txt
> https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist
> See patch bellow if any wording needs to be changed, I forget to add it in the patch.
> 
> > > Next could be uploading metadata HTML and PDF to http://linux-test-project.github.io/.
> 
> > Yes please, that would be awesome!
> I'll do that soon. Where do we want to 1) store HTML and PDF 2) show links to it?
> We have 3 places and 3 git repositories
> https://github.com/linux-test-project/linux-test-project.github.com

I would just put it into this repository and put some links on the front
page. I do not think that it should be put into wiki or somewhere else.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
