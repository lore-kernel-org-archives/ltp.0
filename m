Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FFDC001DF
	for <ltp@archiver.kernel.org>; Wed,  2 Aug 2023 10:00:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A2C53CDAFD
	for <ltp@archiver.kernel.org>; Wed,  2 Aug 2023 11:59:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BDF693CC888
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 11:59:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1AE301A0239F
 for <ltp@lists.linux.it>; Wed,  2 Aug 2023 11:59:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 61F981F37F;
 Wed,  2 Aug 2023 09:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690970386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hBx3ndg4hQriIn4NT7u25ZkthJot+sJh+D2Cn35Kx2Q=;
 b=AfD9zkx7n/7p1YlYdA4BPo2KPNxFcscf9QhEUd97WUGTNvGMPMI9ZlGowPemokhuN+o2PK
 Flp1XOAQFcHaD5WXevVMj4LUP0LLOzEvljERBRqKRBQeCaDOcZt+h0N5aMy5rKrKhenfV3
 epY7xnj8ir5vMgi0If2YbT/gOmaSfzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690970386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hBx3ndg4hQriIn4NT7u25ZkthJot+sJh+D2Cn35Kx2Q=;
 b=u25yBi+Kd1qEBnVEVOfmPunsJfixHhg6ZlB8s46Q24k5d03jYMi7Obc2Ct/VI4Jz0te/qT
 V/qfSAI3YTG3YBDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FE6613909;
 Wed,  2 Aug 2023 09:59:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FW0OEhIpymRndgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 02 Aug 2023 09:59:46 +0000
Date: Wed, 2 Aug 2023 12:00:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZMopSzK0MpPIj3p4@yuki>
References: <20230719113906.22317-1-akumar@suse.de> <ZL-mb1nXfwpAklYr@yuki>
 <422745784.q2UjYaihZW@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <422745784.q2UjYaihZW@localhost>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/pipe08: Remove the test
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
> > Hmm, this one is actually hard to figure out. Indeed the write test
> > implmenents the SIGPIPE case, however it would make more sense to have
> > the SIGPIPE test in syscalls/pipe/ directory instead. I guess that any
> > kernel developer that would like to use LTP for testing changes in
> > pipe() implementation would rather want to have the test under pipe/
> > directory.
> > 
> > Maybe we should keep the pipe08 test and remove the case from the
> > write05 test instead? Or should we keep both?
> 
> Thank you for your feedback. Now I too think we can keep both, but you guys 
> can decide. Please let me know, I can send the patch for pipe08 to convert to 
> new API if we decide to keep it.

I would wote for converting the test into the new API.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
