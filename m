Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B9DC05027
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 14:04:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0FDE3CC22A
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 15:04:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE42C3C632B
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 15:04:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 214321000CED
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 15:04:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EBB991F8B4;
 Wed,  8 Feb 2023 14:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675865063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WJmI+eO0zWSiabxldZrQnHL1fVdO7xukWojv8ZyT+rY=;
 b=qHUZAXMHWlmLwjuIi7rWX6QPIpQCLo6sn+ajMWxT+E/AybedvTxEM6Q6exhkTuBaG6CnaE
 a1NoXjG7jnttN974YwaAP6DU/O2A5zhlTIaoDHXqlIUBv5RVHI3ewmo0sXafoOD9Zxj5E1
 nBqJch6adSaw9ydhAYQmS4X8ribdSG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675865063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WJmI+eO0zWSiabxldZrQnHL1fVdO7xukWojv8ZyT+rY=;
 b=lbNaluKJp9pJYxQzfWtN67Jh5vRtRfi9kwzESl+4ujz1dsG2BqLk3OAZX016De0BRJ5RFG
 LI3pKmMYXWqHRSAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D9D321358A;
 Wed,  8 Feb 2023 14:04:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IJM7NOer42NzGQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 08 Feb 2023 14:04:23 +0000
Date: Wed, 8 Feb 2023 15:05:54 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y+OsQt/ReLv1pt5R@yuki>
References: <20230126215401.29101-1-pvorel@suse.cz>
 <20230126215401.29101-7-pvorel@suse.cz> <Y+N3DxhCsh7NAQoE@yuki>
 <20230208134523.GA31469@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230208134523.GA31469@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/9] tst_net.sh: Rename function + add doc
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
> > What I didn't get here is why do we put the code to detect IPV6 into two
> > different functions and then call it twice nearly from the same place in
> > the library. Is there a reason why can't we put the sysctl check right
> > after the proc check in the current ipv6 detection function?
> 
> Well, the old check (cmdline check for ipv6.disable=1) must be run before
> creating interfaces. But the new sysctl based tests test interfaces
> (${L,R}HOST_IFACES).  Technically it could be run just after ipv6.disable=1
> check, because it's needed only for the non-default ssh based two host setup [1].
> But ${L,R}HOST_IFACES initialization:
> 
> export LHOST_IFACES="${LHOST_IFACES:-eth0}"
> export RHOST_IFACES="${RHOST_IFACES:-eth0}"
> 
> would have to be moved before this check and run only for ssh based test
> (the default netns based single host will create interfaces in init_ltp_netspace()
> and for them ipv6.disable=1 check is good enough). I wanted to keep variables in
> single place, but I'm ok to add this exception. Or we can keep variables where
> they are and run this check on ${LHOST_IFACES:-} and ${RHOST_IFACES:-} (i.e.
> only if these interfaces are set externally - which should be only on ssh two
> host based setup).
> 
> I also thought that having to run this new check separately could be useful
> (setup can change any time). But as nobody required that /complained it's
> needed, let's ignore this.

Ah, it's more complicated than a single switch, there is actually a
master swtich, default settings and per interface settings.

i.e. /proc/sys/net/ipv6/conf/default/disable_ipv6
     /proc/sys/net/ipv6/conf/all/disable_ipv6
     /proc/sys/net/ipv6/conf/${IFACE}/disable_ipv6

Since the deafult value is I suppose inherited by newly added interfaces
we have to check if ipv6 is disabled by sysctl in the case of network
namespaces as well, right? Technically we could probably check the
default/disable_ipv6 before we attempt to create new interfaces, but I
guess that we woudl rather want to have the same code both for ssh and
namespaces.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
