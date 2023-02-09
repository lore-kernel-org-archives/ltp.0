Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD6CC61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 14:25:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45DD23CC0A6
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 15:25:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D266B3C1047
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:25:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 677D0200C80
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:25:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DD3120697;
 Thu,  9 Feb 2023 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675952742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kSO0X3K/UpgVlBeIKoxhYFuiEIMBANAHdwhfO6rHHI8=;
 b=yEuhqrONs7BKYWKm1Yd3i/IQdZwVQujX+Na6+jcIhRCv4Lz6eVIcPQC4IrYg9U+CPCc06Z
 ccqCsVY54Yug9OdY04+ES4QwMCmPjAMi4uMuBDAvcfp2wHNRksJg7MOoh1nm2DVkCY7Ymg
 ZHhMzz3FzfbCEIjQ/thEJjRJchoj9/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675952742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kSO0X3K/UpgVlBeIKoxhYFuiEIMBANAHdwhfO6rHHI8=;
 b=itIwZjUaGxUUapulBo0pgUIRXT2AHEgX3E3ynRJbwIgyNKov6MqCBrUHWQMXRB33WGAKZ0
 KrqTuUNe3MzSeWAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 310C3138E4;
 Thu,  9 Feb 2023 14:25:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OnsHCmYC5WNmFAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 09 Feb 2023 14:25:42 +0000
Date: Thu, 9 Feb 2023 15:27:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y+UCwJZhgIlP5Sjs@yuki>
References: <20230129115021.25778-1-wegao@suse.com>
 <20230209131902.12260-1-wegao@suse.com> <Y+UAENJVDUSDPAay@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+UAENJVDUSDPAay@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fsconfig: New case cover CVE-2022-0185
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > +static void run(void)
> > +{
> > +	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
> > +
> > +	for (unsigned int i = 0; i < 5000; i++)
> > +		TEST(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));

Also as far as I understand the discussion fsconfig() returns EINVAL on
new enough kernels here, right? If that is the case we should also check
that the call fails properly from the v5.17 and newer.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
