Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1092BC4332F
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 13:25:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2905F3CE999
	for <ltp@archiver.kernel.org>; Thu,  2 Nov 2023 14:25:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 058223CB831
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 14:25:46 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5BCB6204730
 for <ltp@lists.linux.it>; Thu,  2 Nov 2023 14:25:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 05450219C8;
 Thu,  2 Nov 2023 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698931545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uAQ7A6Php6K/esz5F905ZQLaTmMdc+g7QIGKy9H5qSQ=;
 b=D2pipzBx0ihXR6MOaCsruvzO4mNvfn8OeG+oaqIBGpHTBnXn99RHOfB7OOJnnEyxG+azRI
 MwQn+C+Nlu16lNMSIPgcyxpwDvFa1aWGWSfe61YjklHoYnxXsT5pT4MGq6gmpWOGKqtX/a
 lMGnWYyBve6y6DWfPFnB9wCGGV70maQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698931545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uAQ7A6Php6K/esz5F905ZQLaTmMdc+g7QIGKy9H5qSQ=;
 b=ak/0glazbPCauU8m40wpUbtJ+bndYSE8yz+Dy4+ewEEW4nSyqv5fXJm/IbantNdPtuS3yi
 gnwQP1YbgO5CqiAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E27FF13584;
 Thu,  2 Nov 2023 13:25:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ou2CM1ijQ2VkaQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 02 Nov 2023 13:25:44 +0000
Date: Thu, 2 Nov 2023 14:26:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <ZUOjeXGrVZizSLBi@yuki>
References: <20231026114716.17545-1-mkittler@suse.de>
 <20231026114716.17545-5-mkittler@suse.de> <ZTvQMpx-q4LnBJgN@yuki>
 <1880149.tdWV9SEqCh@linux-9lzf>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1880149.tdWV9SEqCh@linux-9lzf>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 4/4] Extend ioctl02 to test termio and termios
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
> So I'm honestly not sure whether any of this is better than just making it a 
> macro or maybe I don't understand your suggestion.

And that what macros are for, avoiding repetitive parameters, my
soulution would be to add a macro that just prepares the parameters
for the function and then keep all the code in a function, i.e.

#define CMP_ATTR(term_exp, term, attr) \
        cmp_attr((term_exp)->attr, (term)->attr, #attr)

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
