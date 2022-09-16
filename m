Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB3DECAAD8
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 08:46:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5ACD3CAC67
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 10:46:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E54D83CAC3A
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 10:46:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6089C602C02
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 10:46:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7ECF42002E;
 Fri, 16 Sep 2022 08:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663317962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MTO/+js9U+gPj4mCnymTjkg6S8xR/TXYqDEkxUpo9io=;
 b=SjtsfohkBcVm9BftG2VDHn8santiSgHh218rYg92PsZst2wt21EK/i1LPwbzd9z1dLNvMe
 7o+wrNgIjlqPZrtPPQ+MwhXfqOCJwV2Od5mpX10fW3ltW/3lfKBtxkioLTkw8tx8o9tUmJ
 +ZbUU5EcNA2pLHhelPpF3WcKuCbHNHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663317962;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MTO/+js9U+gPj4mCnymTjkg6S8xR/TXYqDEkxUpo9io=;
 b=XRkw08juRpgiwSGnVe0uLNiblQPLFadpyTvXRuxlSJGzmEFbohbU2c7Z2ughp8P262RxCh
 /rBOmOyZqbWPZSDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 614BB1346B;
 Fri, 16 Sep 2022 08:46:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id E7kxFso3JGN6SQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 16 Sep 2022 08:46:02 +0000
Date: Fri, 16 Sep 2022 10:47:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyQ4P2PEcatH4mmw@yuki>
References: <20220914161930.27681-1-mdoucha@suse.cz>
 <20220914161930.27681-5-mdoucha@suse.cz> <YyMuR7825dIOUC6R@yuki>
 <4bfb03f3-d508-84c4-d7dd-d10234bc0e98@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4bfb03f3-d508-84c4-d7dd-d10234bc0e98@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/5] readahead02: Add max_runtime
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
> I'm planning to go back to ULP and KVM tests after release so feel free 
> to open a new ticket for the other suggested improvements.

Done in: https://github.com/linux-test-project/ltp/issues/972

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
