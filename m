Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2901EC636CC
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 14:50:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C43753CC147
	for <ltp@archiver.kernel.org>; Wed,  8 Feb 2023 15:50:43 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 397FC3C4AF6
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 15:50:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A51C71A00F32
 for <ltp@lists.linux.it>; Wed,  8 Feb 2023 15:50:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E1E1633787;
 Wed,  8 Feb 2023 14:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675867832;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnAQpHOCa1JVi78KqPd6K69otx8lx/6Uu3eKPvf3LJ4=;
 b=sRnniTvTxp8/e1lIyBcCfubAZspSNaZlrAfYq4NCRbmg3qyTxYLUzb+ilGShCKmlB12WoW
 7n+nGPadPOZCwMm5/H5zFXPO38XZkUYeeo4B4naufeTRWEkJiics4CX82xtxo57JBl28Vw
 SM72jTVXqWT7pic6Ie9pXd72wgqxuUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675867832;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnAQpHOCa1JVi78KqPd6K69otx8lx/6Uu3eKPvf3LJ4=;
 b=lPLdYJObVlNBJx11H6S26eg1M94b3P3KzJjv/Pr30Yy69Hw5fwOgASZLiTC7KdM91Zktzs
 147ROJVgckRAh9DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D02E213425;
 Wed,  8 Feb 2023 14:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NJIAMri242MEMAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 08 Feb 2023 14:50:32 +0000
Date: Wed, 8 Feb 2023 15:50:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230208145023.GA1918@pevik>
References: <20230126215401.29101-1-pvorel@suse.cz>
 <20230126215401.29101-7-pvorel@suse.cz> <Y+N3DxhCsh7NAQoE@yuki>
 <20230208134523.GA31469@pevik> <Y+OsQt/ReLv1pt5R@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+OsQt/ReLv1pt5R@yuki>
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

> Hi!
> > > What I didn't get here is why do we put the code to detect IPV6 into two
> > > different functions and then call it twice nearly from the same place in
> > > the library. Is there a reason why can't we put the sysctl check right
> > > after the proc check in the current ipv6 detection function?

> > Well, the old check (cmdline check for ipv6.disable=1) must be run before
> > creating interfaces. But the new sysctl based tests test interfaces
> > (${L,R}HOST_IFACES).  Technically it could be run just after ipv6.disable=1
> > check, because it's needed only for the non-default ssh based two host setup [1].
> > But ${L,R}HOST_IFACES initialization:

> > export LHOST_IFACES="${LHOST_IFACES:-eth0}"
> > export RHOST_IFACES="${RHOST_IFACES:-eth0}"

> > would have to be moved before this check and run only for ssh based test
> > (the default netns based single host will create interfaces in init_ltp_netspace()
> > and for them ipv6.disable=1 check is good enough). I wanted to keep variables in
> > single place, but I'm ok to add this exception. Or we can keep variables where
> > they are and run this check on ${LHOST_IFACES:-} and ${RHOST_IFACES:-} (i.e.
> > only if these interfaces are set externally - which should be only on ssh two
> > host based setup).

> > I also thought that having to run this new check separately could be useful
> > (setup can change any time). But as nobody required that /complained it's
> > needed, let's ignore this.

> Ah, it's more complicated than a single switch, there is actually a
> master swtich, default settings and per interface settings.

> i.e. /proc/sys/net/ipv6/conf/default/disable_ipv6
>      /proc/sys/net/ipv6/conf/all/disable_ipv6
>      /proc/sys/net/ipv6/conf/${IFACE}/disable_ipv6

> Since the deafult value is I suppose inherited by newly added interfaces
> we have to check if ipv6 is disabled by sysctl in the case of network
> namespaces as well, right? Technically we could probably check the
> default/disable_ipv6 before we attempt to create new interfaces, but I
> guess that we would rather want to have the same code both for ssh and
> namespaces.

Good catch, yes, conf/default/disable_ipv6 is inherited, thus
mandatory for check altogether with conf/${IFACE}/disable_ipv6 
(for ${LHOST_IFACES:-} and ${RHOST_IFACES:-} - ssh).
We can ignore conf/all/disable_ipv6 [1]:

	Reading this value does not have any particular meaning. It does not say
	whether IPv6 support is enabled or disabled. Returned value can be 1 also in
	the case when some interface has disable_ipv6 set to 0 and has configured
	IPv6 addresses.

I'd add this check before calling init_ltp_netspace(). That expects:
1) nobody changes this setup (one day we may want to test this functionality,
thus even LTP itself can change this setup) 2) any NIC without IPv6 means no
IPv6 testing, right?

BTW at least network tests which use virt_lib.sh requires IPv6 for IPv4 tests.
ip6_virt_remote="$(TST_IPV6=6 tst_ipaddr_un rhost)"
which is then used in virt_setup():

# ./macsec02.sh
macsec02 1 TINFO: setup IPsec transport/esp_aead des3_ede
macsec02 1 TINFO: setup local macsec with 'icvlen 16 encodingsa 0 replay on window 300 encrypt on protect on'
macsec02 1 TINFO: setup rhost macsec with 'icvlen 16 encodingsa 0 replay on window 300 encrypt on protect on'
RTNETLINK answers: Operation not supported
macsec02 1 TBROK: ip addr add ::2/64 dev ltp_v0 nodad failed

# ./vlan03.sh
RTNETLINK answers: Operation not supported
vlan03 1 TBROK: ip addr add ::2/64 dev ltp_v0 nodad failed

These tests would have to be either split to IPv4 (default) and IPv6 (-6)
or entirely depend on IPv6 (obviously first is better, but more work).

Kind regards,
Petr

[1] https://docs.kernel.org/networking/ip-sysctl.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
