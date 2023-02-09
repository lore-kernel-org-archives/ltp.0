Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288E4C05027
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 14:40:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAA8A3CC0A2
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 15:40:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D8323CB132
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:40:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0C285140097F
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:40:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B39ED5C7BF;
 Thu,  9 Feb 2023 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675953635;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPoqxBKuZ22ZTkRp1/4fM/3sJ/roGTBmsYPj/3AKa6g=;
 b=s3382lD/2yB8tXEXeOdhhyomJVeb2DL0RKchDOzN11rZfinj3eqX1bo5Kq2OOpF8h4JHgk
 GDXjGMqL1vedGDbtmy6nR378xQORMMlc5gJDYERcxfoshoByPtrTi0/veE8QwWteUjgH8H
 gzhQ1aEoxoe12vP9HdQUOspX9lITF8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675953635;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XPoqxBKuZ22ZTkRp1/4fM/3sJ/roGTBmsYPj/3AKa6g=;
 b=Ri5669+4c4mLQarCT7oRx2m/AFxkRlEjNTTWpXrMZ8Euzc++caJVp8OW+MuPcFoeYKUFLr
 PfSfFusbKaqtBTDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C734138E4;
 Thu,  9 Feb 2023 14:40:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rR6uGOMF5WMJHQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Feb 2023 14:40:35 +0000
Date: Thu, 9 Feb 2023 15:40:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y+UF4eCFAR0jy7P7@pevik>
References: <20230129115021.25778-1-wegao@suse.com>
 <20230209131902.12260-1-wegao@suse.com> <Y+UAENJVDUSDPAay@pevik>
 <Y+UCwJZhgIlP5Sjs@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+UCwJZhgIlP5Sjs@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > +static void run(void)
> > > +{
> > > +	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
> > > +
> > > +	for (unsigned int i = 0; i < 5000; i++)
> > > +		TEST(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));

> Also as far as I understand the discussion fsconfig() returns EINVAL on
> new enough kernels here, right? If that is the case we should also check
> that the call fails properly from the v5.17 and newer.

I'd test all kernels and expect them to return EINVAL.
Because 722d94847de29 was backported to 5.10.x and 5.4.x stable kernels.
It'd be worth to check how it behaves on older stable (e.g. 4.19.x) and either
raise .min_kernel lower than 5.4 if easily modified behavior for older kernels
or ask for 5.4 otherwise. (I mean .min_kver = "5.17", is too aggressive).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
