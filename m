Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A298FC433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 17:46:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 601BC3CAA11
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 19:46:16 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6094B3CA8EB
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 19:46:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D7FF914010F2
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 19:46:05 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 122CE336C6;
 Thu, 14 Jul 2022 17:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657820765;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=70RhgJb/oVWCTeTxwM1j4W59i+z3GfzFORkVaoMQQDw=;
 b=Xz5SSI+fg6PL7UKlx+Df+wkJl/nNnAXcpSr/FMlYvsG3vuHVxlnqR0smMw3AbOMnZ/cNlP
 TzxY29j6KdOERgmZwO8ZGkc+7UWpJHYWaqxpu90F9XgMvo5NtYNsUo8eGmIwI0Gw9DaeeP
 sA1ihwHMQHq7sFf2dsDeBMu5e7Y9KgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657820765;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=70RhgJb/oVWCTeTxwM1j4W59i+z3GfzFORkVaoMQQDw=;
 b=SMzmi/Qs2jVWcFUKgL3wuoIoVHxzvzRDOZGZPLBMYEzZHhg1T4RepsXkTNYElH3Llu5o7E
 SkDzX5oWpuxuz0Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D338613A61;
 Thu, 14 Jul 2022 17:46:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3BvOMVxW0GIlfwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 14 Jul 2022 17:46:04 +0000
Date: Thu, 14 Jul 2022 19:46:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YtBWWm/m/o6PIUiN@pevik>
References: <20220627072709.709035-1-lkml@jv-coder.de>
 <c93e7189-7a11-cce8-7a74-9c241886db1b@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c93e7189-7a11-cce8-7a74-9c241886db1b@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] net_stress: Fix usage of variables from tst_net.sh
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

Hi Joerg,

> Hi Petr,

> did you miss this patch (and the other one for memcg/functional with the
> same type of bug)?
Thanks for ping and the patches, I indeed overlook them. Both fixes merged.

Kind regards,
Petr

> Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
