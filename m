Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A126C636CC
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 13:45:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67CF73CC22B
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 14:45:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D42F3CB0FC
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 14:45:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 190E91A00CCE
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 14:45:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3BCBE1F8B4;
 Wed,  8 Feb 2023 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675863936;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GbEfMTYGkxDsbkJhCMMv0fe311gBOFyZ99hHUlX1I/E=;
 b=wdYD0foua3fCFs7itBIuwbXAxc7ab+jo0InSiOXD8kRvR5n3kUXoEf1U/M9f84ad2yxPp2
 c9tO03byNLfG+RtzvRof/h9BQvGUZ1Uo5xuJyjHdDpeGzzHZy3SObFJX70U8E8vlCjXe9t
 /2vkwv72FT5vbKEVj/89e8q+2JbkIwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675863936;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GbEfMTYGkxDsbkJhCMMv0fe311gBOFyZ99hHUlX1I/E=;
 b=+RkvrDMqt56lbLF+0ATWQ0iNo55H+PlFMS+b6Jq/VVMwyRhYmjo2IblYXxXiQcOIykzkT9
 RPcTGv6sRyij7KBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 279741358A;
 Wed,  8 Feb 2023 13:45:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qu65CICn42OCDwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Feb 2023 13:45:36 +0000
Date: Wed, 8 Feb 2023 14:45:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230208134523.GA31469@pevik>
References: <20230126215401.29101-1-pvorel@suse.cz>
 <20230126215401.29101-7-pvorel@suse.cz> <Y+N3DxhCsh7NAQoE@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+N3DxhCsh7NAQoE@yuki>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

first, thanks for you review!

> Hi!
> What I didn't get here is why do we put the code to detect IPV6 into two
> different functions and then call it twice nearly from the same place in
> the library. Is there a reason why can't we put the sysctl check right
> after the proc check in the current ipv6 detection function?

Well, the old check (cmdline check for ipv6.disable=1) must be run before
creating interfaces. But the new sysctl based tests test interfaces
(${L,R}HOST_IFACES).  Technically it could be run just after ipv6.disable=1
check, because it's needed only for the non-default ssh based two host setup [1].
But ${L,R}HOST_IFACES initialization:

export LHOST_IFACES="${LHOST_IFACES:-eth0}"
export RHOST_IFACES="${RHOST_IFACES:-eth0}"

would have to be moved before this check and run only for ssh based test
(the default netns based single host will create interfaces in init_ltp_netspace()
and for them ipv6.disable=1 check is good enough). I wanted to keep variables in
single place, but I'm ok to add this exception. Or we can keep variables where
they are and run this check on ${LHOST_IFACES:-} and ${RHOST_IFACES:-} (i.e.
only if these interfaces are set externally - which should be only on ssh two
host based setup).

I also thought that having to run this new check separately could be useful
(setup can change any time). But as nobody required that /complained it's
needed, let's ignore this.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/tree/master/testcases/network#single-host-configuration

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
