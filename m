Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F5E9C433FE
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 09:17:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F40063CAD3D
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 10:17:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FF0F3CAC57
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 10:16:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2533A1A0088A
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 10:16:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5747433A0A;
 Tue,  1 Nov 2022 09:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667294214;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/Kb3B3rtnmRaKzp+1OTTrvJQ3JDPgKa3i6BDjFivb0=;
 b=zXejeVTN0BfcrvQtVvhqHEFDz0XHixLOT5jiCl36ay16dyIPoeOW+2o02JXsuvvfZ8DKcf
 OzVj5v6TF9tM4Qe5gh38bWgf87LusYFJSvflJ0kefjLcxGuKOmPhPHvy5JRrFbSKl/4Dg9
 4xuyUMBrCjiyL1RNQEqECP3hBxQ8q3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667294214;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F/Kb3B3rtnmRaKzp+1OTTrvJQ3JDPgKa3i6BDjFivb0=;
 b=UL4JvvOs7QrsxyYX+PqlMA0GMZygQg6yoSojRtUs9AVZnZi1rpaw4LIj4GG7+fSyXWk92/
 x3DTUdas+afOtpCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2DAD11346F;
 Tue,  1 Nov 2022 09:16:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hZL7CQbkYGM1NgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 01 Nov 2022 09:16:54 +0000
Date: Tue, 1 Nov 2022 10:16:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Zhou, You" <you.zhou@intel.com>
Message-ID: <Y2DkBBAL72jXlNPI@pevik>
References: <20221028032103.2050696-1-you.zhou@intel.com>
 <Y1+qkXXu9uqsJaVG@pevik>
 <DM4PR11MB62130CD766817757EBF7683D8A369@DM4PR11MB6213.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM4PR11MB62130CD766817757EBF7683D8A369@DM4PR11MB6213.namprd11.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: Fix a fake failure for setfsuid02
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

Hi You,

> Hi, Petr,

> I try the patch from Avinesh, the test result is normal, so the purpose of this test case is to try to set an invalid uid?

yes, the purpose is to test that setfsuid() syscall fails if an passed invalid fsuid.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
