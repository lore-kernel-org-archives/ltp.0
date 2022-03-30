Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CABC433EF
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 09:13:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E23B43C9F4E
	for <ltp@archiver.kernel.org>; Wed, 30 Mar 2022 11:13:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D1543C089F
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 11:13:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 851B91A0088E
 for <ltp@lists.linux.it>; Wed, 30 Mar 2022 11:13:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CBB131F37B;
 Wed, 30 Mar 2022 09:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648631614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nKhVs366udL/JiE1fyr23VUuTvh6xy0v710j8UoKqK0=;
 b=beUl0GzE1F3LPkDfIV49AUqxQNE8eA89IhTbsWKTU28vFrKqh7kjunrWp+JZmq7zf0l3JA
 U8xklABfus2XxPkEbJ1r2rqOSpxzP/Ce/mQUlzMjlAUmSW1047+f2fyX14B2mkvMMozlEg
 tV+RzLFkaive6DHFGkjVv5RIo0iaiOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648631614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nKhVs366udL/JiE1fyr23VUuTvh6xy0v710j8UoKqK0=;
 b=zQuuPpAWV5s0VD2wrzSo4Bb5X4J8B8J6ywrdtrmcf4kiaCkkWgs6l2rCoLOE/MGjhyPrhd
 tWi4trs726pzINAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B742413A60;
 Wed, 30 Mar 2022 09:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FaXRKz4fRGJkVQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 30 Mar 2022 09:13:34 +0000
Date: Wed, 30 Mar 2022 11:15:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YkQfyh3ppXPGMarB@yuki>
References: <20220204194648.32165-1-pvorel@suse.cz>
 <20220204194648.32165-3-pvorel@suse.cz> <Yh98mQNybj1R1Kga@yuki>
 <YjoUprPfTYN1nlt4@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YjoUprPfTYN1nlt4@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] broken_ip-nexthdr.sh: Check IPv6 support
 before forcing it
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
> I tried to implement this [1] (or [2] if I force push), and using getopts the
> end of the script only would require also to move loading '. tst_test.sh' at the
> end of *all* the test scripts because setup functions needs to be loaded before
> sourcing tst_test.sh. Do we want this?

Sounds reasonable. I would go even further and put the line that sources
the tst_test.sh to be last line in the test.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
