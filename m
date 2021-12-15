Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D2AC433EF
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 09:20:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D46123C8F5E
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 10:20:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B29B93C1351
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:20:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 28AB71001558
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 10:20:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DA2721108;
 Wed, 15 Dec 2021 09:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639560003;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kBxKBR7K8xm22S21W0kPVOlHuEa8lNCVa0Pjni8FVNM=;
 b=g4GJyrvkWJLcDynRZ7F55d7Cfme6/PWddZ3k5Mso/8XI5uo7dSjb62q+jIDiEdUrB07Rcs
 U2t2V3vVL5K8WLqY+m0hnVui7bt2T3IeMFr7ZzDyL0RFUCfZm/midFpXkyU3LcQo5bG+GH
 SxLYIe+asgy5xMkwyQ2BEIgFWta6/R8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639560003;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kBxKBR7K8xm22S21W0kPVOlHuEa8lNCVa0Pjni8FVNM=;
 b=Myxr4DLzB5uLECUXnHN0iH2ov9SUmLLMCt8G7DVnry2F7Liayur132dPH0vbg0ovOgUFRD
 xn0geyUjePkazUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09B1E13AC7;
 Wed, 15 Dec 2021 09:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xZl8AEOzuWFKTwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Dec 2021 09:20:03 +0000
Date: Wed, 15 Dec 2021 10:20:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YbmzQSxYo2wjiLor@pevik>
References: <20211209230854.30755-1-pvorel@suse.cz> <YbM+zuuy41468Dcf@yuki>
 <YbmcfACzQ1SJFCoR@pevik> <YbmyOiLC3Bhe0l4i@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YbmyOiLC3Bhe0l4i@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > I'll also update doc/maintainer-patch-review-checklist.txt
> > https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist
> > See patch bellow if any wording needs to be changed, I forget to add it in the patch.

> > > > Next could be uploading metadata HTML and PDF to http://linux-test-project.github.io/.

> > > Yes please, that would be awesome!
> > I'll do that soon. Where do we want to 1) store HTML and PDF 2) show links to it?
> > We have 3 places and 3 git repositories
> > https://github.com/linux-test-project/linux-test-project.github.com

> I would just put it into this repository and put some links on the front
> page. I do not think that it should be put into wiki or somewhere else.
OK, makes sense.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
