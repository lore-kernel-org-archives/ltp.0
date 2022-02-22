Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84A5C433EF
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 16:07:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00B263CA1B5
	for <ltp@archiver.kernel.org>; Tue, 22 Feb 2022 17:07:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D513C3C8F91
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 17:07:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D3411601206
 for <ltp@lists.linux.it>; Tue, 22 Feb 2022 17:07:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 16E3421136;
 Tue, 22 Feb 2022 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645546033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I6ZLnW4QO3+YuMwNBueZR8I3XMAS59gVv27/2auuf3k=;
 b=wRq0G4SBctP0lRXoWwn2PJP0o+Z/GCnTYx6z3WVNKCol9Gpewr1WzdpvaQZf/R6RQvpsD0
 dODrIad6ctZGoIMydJ1mFaDXPa9KxOHCLQzt4/V4JOwdtDh8T4iUnFMfapeV9s+Falji9u
 LRESGv9AAd6PhVF+RjqdN5FDPFD1sIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645546033;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I6ZLnW4QO3+YuMwNBueZR8I3XMAS59gVv27/2auuf3k=;
 b=+AkTedhXc1HYcYqjzwGym2NAIdgUOLi6JDPe3UXKWlElwNr5jf6M7g2lvavBOzSKN9zkP4
 kBbtK+b5S6xNZyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0085A139B5;
 Tue, 22 Feb 2022 16:07:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id whUbOjAKFWJ5NwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 22 Feb 2022 16:07:12 +0000
Date: Tue, 22 Feb 2022 17:09:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <YhUKtWP8dwNBAcmy@yuki>
References: <20220222155514.2255913-1-nikita.yushchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220222155514.2255913-1-nikita.yushchenko@virtuozzo.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] testcases/lib: introduce sysctl wrapper
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
Cc: kernel@openvz.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Linux sysctl utility does not propagate errors returned from proc writes
> to it's exit code:
> 
> > sysctl -q -w net.ipv4.tcp_congestion_control=dctcp
> sysctl: setting key "net.ipv4.tcp_congestion_control": Operation not permitted
> > echo $?
> 0

I wonder why we use sysctl in the first place, all that it does in our
case is write to /proc/sys/net/.... file. I guess that it may be easier
if we just echo the value into the corresponding files instead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
