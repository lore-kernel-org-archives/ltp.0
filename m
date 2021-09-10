Return-Path: <SRS0=5PST=OA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722E0C433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 09:36:33 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5D7611B0
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 09:36:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6D5D7611B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 936383C8C72
	for <ltp@archiver.kernel.org>; Fri, 10 Sep 2021 11:36:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D5023C2195
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 11:36:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 509A160140E
 for <ltp@lists.linux.it>; Fri, 10 Sep 2021 11:36:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 44BE722427;
 Fri, 10 Sep 2021 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631266578;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9OJi27+mV4UBiqnKi/I6G7zm6peZdOmg22yAv27b7Bs=;
 b=JzPm+h4JlCQNSY6h82e9/BxJoMz37TuRqdMWusXJHDfObY/dWurzLrXmHXr1NEpTzVAvDB
 2mPd3JUDYAgqR+eULb8kgYEI3CU0zhZAIXXflBpnoHloLRCpP9aMz5YfKbXJ583y4b7spL
 CldtgKzUSxsPh00pu62PE/BPfaXh1tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631266578;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9OJi27+mV4UBiqnKi/I6G7zm6peZdOmg22yAv27b7Bs=;
 b=rH3/CMjdKLSlYyHlw6D53zBDmo1hH9MUMhb+gc/jjfFtdho6YZaXlTqGSU7t+4gxlUevEt
 hmEWgcI5uhoyTDBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED11413D1D;
 Fri, 10 Sep 2021 09:36:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id v6iONxEnO2G/dwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 10 Sep 2021 09:36:17 +0000
Date: Fri, 10 Sep 2021 11:36:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Message-ID: <YTsnD0Uw4argiGOJ@pevik>
References: <TY2PR01MB212429263FC238F44A2C1D7D89C79@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <410b2b2d-9633-7a57-527a-1663afe5f631@bell-sw.com>
 <TY2PR01MB21246C459BBCD763BD1C0CBD89CB9@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <0acf816462d49d8a6004c87e36b05d1b@suse.de>
 <8d93deac-eec1-5f87-57a5-c72b2f6e5973@bell-sw.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8d93deac-eec1-5f87-57a5-c72b2f6e5973@bell-sw.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] network/mpls: sleep 1 after setup in mpls02
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
Cc: pvorel <pvorel@suse.de>, suy.fnst@fujitsu.com, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210910093615.JkDhxDDr57JkchVKTcR59_HofV6ZGpyg0RLf_SuITXA@z>

> On 09.09.2021 18:53, pvorel wrote:
> > Hi Su, Alexey,

> > On 2021-08-30 11:26, suy.fnst@fujitsu.com wrote:
> >> Hi,
> >> =A0 I found that it's indeed related to ipv6 DAD as you said.
> >> Calling
> >> `ip netns exec ltp_ns sysctl -n net.ipv6.conf.ltp_ns_veth1.accept_dad=
=3D0`
> >> or tst_wait_ipv6_dad() at end of the setup both solves the problem.
> >> However there is one super strange part that the tentative address is
> >> the local link adress of the ltp_ns_veth1:

> >> 5: ltp_ns_veth1@if4: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
> >> state UP group default qlen 1000
> >> =A0=A0=A0 link/ether f2:8f:24:d4:ba:26 brd ff:ff:ff:ff:ff:ff link-netn=
sid 0
> >> =A0=A0=A0 inet 10.0.0.1/24 scope global ltp_ns_veth1
> >> =A0=A0=A0=A0=A0=A0 valid_lft forever preferred_lft forever
> >> =A0=A0=A0 inet6 fd00:1:1:1::1/64 scope global nodad
> >> =A0=A0=A0=A0=A0=A0 valid_lft forever preferred_lft forever
> >> =A0=A0=A0 inet6 fe80::f08f:24ff:fed4:ba26/64 scope link tentative
> >> <-------------------
> >> =A0=A0=A0=A0=A0=A0 valid_lft forever preferred_lft forever

> >> However, there is no place using the address in mpls02 test.>> It make=
s me wonder how could it be possible to trigger the issue..

> Looks like the problem here in the neighbor discovery of fd00:1:1:1::2
> using link-local address, and vice verse for the other side. mpls is
> using the following route with the address:

> fd00:23::2  encap mpls  60 via fd00:1:1:1::2 dev ltp_ns_veth1 metric 1024=
 pref medium
> so the address there should be in a reachable state...

Thanks for info! I wonder if it's a bug in mpls or elsewhere. WDYT?

> Adding it manually in setup might fix the test as well:

> ROD ip neigh replace $(tst_ipaddr rhost) lladdr $(tst_hwaddr rhost) dev $=
(tst_iface) nud reachable
> tst_rhost_run -s -c "ip neigh replace $(tst_ipaddr) lladdr $(tst_hwaddr) =
dev $(tst_iface rhost) nud reachable"

> > I wonder if test still needs be fixed to work on all setups.


> I think we could set accept_dad to 0 in generic setup of the
> test interfaces, in tst_net.sh/tst_init_iface().
Unless it's a bug we'd hide by setting it, I'd be for this general solution.

It'd be nice to get it fixed before release.

Kind regards,
Petr

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
