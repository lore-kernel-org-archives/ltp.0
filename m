Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F31CD1288
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 14:31:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 645DE3CE1B6
	for <ltp@archiver.kernel.org>; Wed,  3 Apr 2024 16:31:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E12683C1A04
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 16:31:06 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D2D74200938
 for <ltp@lists.linux.it>; Wed,  3 Apr 2024 16:31:05 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 59BBD22BB8;
 Wed,  3 Apr 2024 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712154663;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oK4VlootyxQsk11mfsAgrUVoXvo8DB//CIaKdCQ5aEY=;
 b=lgkM00LXg7YjxX2+z4/y4AJL9G2EAhUA8zi3IB7n1rTjmjYJV/VThzFbV/r2zQALjbF5ws
 xL1RhJTuYPjYuk9dJc4Y/BOp/jF7X9pSjM91lm7UvoSyalrhiZ9u3+LMdzPTE3Jwded6cU
 R42elXaqlTXpKaj5AANZoHCn/GqOXjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712154663;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oK4VlootyxQsk11mfsAgrUVoXvo8DB//CIaKdCQ5aEY=;
 b=kzB5o3QZ1UUTdxWiBImMu+baurR0Uo14u+1B/cUH/VkzZsaRmdLLj88YQknZ3yGaBrfmpQ
 T2aHDmgKYF6m/xAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 19EBB13357;
 Wed,  3 Apr 2024 14:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 3wsXBSdoDWZ1YQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 03 Apr 2024 14:31:03 +0000
Date: Wed, 3 Apr 2024 16:30:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <20240403143053.GA450357@pevik>
References: <fd34e495-75cd-4db2-bbf6-975f3697cd51@suse.com>
 <36d410f8-1946-4a0f-8c30-9810994954ed@suse.com>
 <20240326082629.GA684723@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240326082629.GA684723@pevik>
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.62 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.57)[81.29%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 59BBD22BB8
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Open monthly meeting 4th of April 09:00 UTC
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Hi all,

> > Hi all!

> > Possible discussions for the meeting:
> > - current project status
> > - new LTP documentation website
> > - API documentation

> +1

> > Please, feel free to add more topics :-)

More topic (if we have time):

- require 2FA for LTP github, would it be acceptable for you? [1]

Looking at our members [2], only one of the active developers does not have it. I'll let him
know privately.

The reason is obvious - learn from xz/liblzma backdoor (CVE-2024-3094).

- minimal size per filesystem - do we want it?
Old proposal [3], I posted update [4].

> > On 3/26/24 08:53, Andrea Cervesato wrote:
> > > Hello everyone,

> > > this is a friendly reminder for the LTP mailing list about monthly
> > > meeting.
> > > As previously discussed.

> > > Next meeting will be on the 4th of April 09:00 UTC.
> > > Platform: https://meet.google.com/jon-gytf-uei

> FYI the meeting is not on Wednesday (as usually), but on Thursday
> (Andrea does not have time on Wednesday). Hope it's ok for you.

FYI Andrea created meeting for Thursday the 4th, but there was a discussion
afterwards for Friday:

https://lore.kernel.org/ltp/CAEemH2cft19JByyEOc24_TVQZwTGkzaSPQ70T60Q=LmHKLuGDg@mail.gmail.com/

Also Li suggested to be only on listen only mode (due travelling).

I suggest to postpone to the third week to get all people back.

Kind regards,
Petr

[1] https://docs.github.com/en/organizations/keeping-your-organization-secure/managing-two-factor-authentication-for-your-organization/requiring-two-factor-authentication-in-your-organization
[2] https://github.com/orgs/linux-test-project/people
[3] https://lore.kernel.org/ltp/Yv4MBF79PnJKJbwm@yuki/
[4] https://lore.kernel.org/ltp/20240403142431.GA452858@pevik/

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
