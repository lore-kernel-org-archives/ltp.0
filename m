Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCD0C433F5
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 07:43:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 924213C8F36
	for <ltp@archiver.kernel.org>; Wed, 15 Dec 2021 08:43:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A600D3C7FC9
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:42:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 58CA31001533
 for <ltp@lists.linux.it>; Wed, 15 Dec 2021 08:42:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3BBD51F382;
 Wed, 15 Dec 2021 07:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639554174;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U9/M0ZlepkN8uZLICRzVQpvPr79LD+PscoWuc4hMhiY=;
 b=NRAjczdWbjQ0vn+iGDpTkMkZS39Yy4EGxj/nmMJ2frip279EbSHjRyGDH7xGtRGGJi+UNp
 v782+hkyffBZ/hkxQUp+2EMN5dWkXd76vIo75lFtzFYCCpfwf99dAD7kdBunVJcUTZ5CiU
 WTQeL+Yq6CIAm8eiUPinZ8UBGnLkvfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639554174;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U9/M0ZlepkN8uZLICRzVQpvPr79LD+PscoWuc4hMhiY=;
 b=8PW4JArmCv7HqVMHuCBhlHs6u5nWYwB8CaP7kCimc8FJ8SP5hI4CqM63COXWapfBJvHUKY
 TbccUFl+eIxNfaAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11FAD13A9F;
 Wed, 15 Dec 2021 07:42:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ERmwAn6cuWGAIgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Dec 2021 07:42:54 +0000
Date: Wed, 15 Dec 2021 08:42:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YbmcfACzQ1SJFCoR@pevik>
References: <20211209230854.30755-1-pvorel@suse.cz>
 <YbM+zuuy41468Dcf@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YbM+zuuy41468Dcf@yuki>
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

Hi Cyril,

> Hi!
> > Tested on my fork:
> > https://github.com/pevik/ltp/runs/4477321979?check_suite_focus=true
> > https://github.com/pevik/ltp/wiki/Test-Writing-Guidelines#0-special-paragraph-for-testing

> Looks good:

> Acked-by: Cyril Hrubis <chrubis@suse.cz>
Thanks, merged!

I'll also update doc/maintainer-patch-review-checklist.txt
https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist
See patch bellow if any wording needs to be changed, I forget to add it in the patch.

> > Next could be uploading metadata HTML and PDF to http://linux-test-project.github.io/.

> Yes please, that would be awesome!
I'll do that soon. Where do we want to 1) store HTML and PDF 2) show links to it?
We have 3 places and 3 git repositories
https://github.com/linux-test-project/linux-test-project.github.com
https://github.com/linux-test-project/ltp.wiki.git
https://github.com/linux-test-project/ltp

Kind regards,
Petr

diff --git doc/maintainer-patch-review-checklist.txt doc/maintainer-patch-review-checklist.txt
index c7bb47810b..4e10dc514b 100644
--- doc/maintainer-patch-review-checklist.txt
+++ doc/maintainer-patch-review-checklist.txt
@@ -20,8 +20,9 @@ Commit messages should have
 After patch is accepted or rejected, set correct state and archive in
 https://patchwork.ozlabs.org/project/ltp/list/[LTP patchwork instance].
 
-Also update LTP WIKI (git URL https://github.com/linux-test-project/ltp.wiki.git)
-if touch `doc/*.txt`.
+Also update `.github/workflows/wiki-mirror.yml` script which mirrors
+`doc/*.txt` to LTP wiki (git URL https://github.com/linux-test-project/ltp.wiki.git)
+if new wiki page is added.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
