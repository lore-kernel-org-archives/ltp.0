Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A16C77B71
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 13:50:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49E643CBF28
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 15:50:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C12C23CB9BC
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 15:50:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BA25C1A00272
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 15:50:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0107B21A36;
 Fri, 21 Apr 2023 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682085029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=61jE42RZwaF6lnQPNbT2C8UOoesNkcrNi+C0svTC99w=;
 b=ZLfUd27lAUX+4squKR6ZTWClxMHdC0aE7P8VJObPaC9izTU0OSG/5sM0s8rJ6zmi4SKZd4
 SzFvxgQ714lN5x8wtEvGTMUHLU+Hl+Nl1/ie1yzE9JGdq74rGnpJ5dbdAVoJ9G8LMb1yGQ
 uTMT2G39Ybn/0kOg5QpTJB8KBSpn81k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682085029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=61jE42RZwaF6lnQPNbT2C8UOoesNkcrNi+C0svTC99w=;
 b=fLHmCJpI53G+vaebLRdBB05u8L1YSNv6e3SDOXDIqChclf1KCTzDDidgjrq1kknO+gKEV6
 /NGbnV4/GWVIhuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E04EE13456;
 Fri, 21 Apr 2023 13:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nvOJNaSUQmTQZQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Apr 2023 13:50:28 +0000
Date: Fri, 21 Apr 2023 15:51:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sowmya Indranna <Sowmya.Indranna@ibm.com>
Message-ID: <ZEKU5cfiq3ApMOma@yuki>
References: <MN2PR15MB36640A5589296ACE83A0A422F2609@MN2PR15MB3664.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MN2PR15MB36640A5589296ACE83A0A422F2609@MN2PR15MB3664.namprd15.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/cpuset_regression_test.sh - Issue
 #1033
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> commit 6c681b9480a8aa47b053a8aa5d5b2a6592e79b47 (HEAD -> master)
> Author: SOWMYA INDRANNA sowmya.indranna@ibm.com<mailto:sowmya.indranna@ibm.com>
> Date:   Fri Apr 21 13:31:52 2023 +0000
> 
>     cpuset_regression_test.sh: Renamed the test function
> 
>     Signed-off-by: SOWMYA INDRANNA sowmya.indranna@ibm.com<mailto:sowmya.indranna@ibm.com>

The patch is still corrupted by your email client. Some of the
whitespace was erased before it was send.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
