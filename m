Return-Path: <SRS0=2Bls=OD=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C2FC433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 12:56:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7D260FDA
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 12:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8E7D260FDA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D46353C927C
	for <ltp@archiver.kernel.org>; Mon, 13 Sep 2021 14:56:09 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA04A3C8A84
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:56:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 51B1E1400FBB
 for <ltp@lists.linux.it>; Mon, 13 Sep 2021 14:56:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3545C21FD6;
 Mon, 13 Sep 2021 12:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631537760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1EHZx4cPwl2gGVa9xK5hH9OObOOTza9uBsNOhX8jCmM=;
 b=m3RxLGsJ09+Tw7QGeUwNsmVF5SEPKb3xJ5ygxy1kPS7nhXeYyN0XAdnh03adELeNic1hj2
 xxkerXuGtYJ4/NimEaYKI0xu1YRGHUqinZ6MpqVzT7zTzSQnvjhD+qRhT5CGjDEUmKHLwM
 gQlXZLIOhLMsZX53p0Wng/EfZgZXo4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631537760;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1EHZx4cPwl2gGVa9xK5hH9OObOOTza9uBsNOhX8jCmM=;
 b=uYxlCqUMyYxgLY+1ykpPbtbHrMlszpqqnRoz90jzPX9mx/Z/TbVjMNhn++jkfrE5CCNvu5
 kRk2yZ2dqFRVAeAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E95C13AA9;
 Mon, 13 Sep 2021 12:56:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id np2NAWBKP2HxLgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Sep 2021 12:56:00 +0000
Date: Mon, 13 Sep 2021 14:55:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Message-ID: <YT9KXlMO0ez/IJgD@pevik>
References: <TY2PR01MB212429263FC238F44A2C1D7D89C79@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <410b2b2d-9633-7a57-527a-1663afe5f631@bell-sw.com>
 <TY2PR01MB21246C459BBCD763BD1C0CBD89CB9@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <0acf816462d49d8a6004c87e36b05d1b@suse.de>
 <8d93deac-eec1-5f87-57a5-c72b2f6e5973@bell-sw.com>
 <YTsnD0Uw4argiGOJ@pevik>
 <61ea98da-6746-2ad3-c2de-38e148cc9d4c@bell-sw.com>
 <YT9EAQfa02ytbDPr@pevik>
 <289d5bea-8fd5-b009-18dc-5639f3a0c0d2@bell-sw.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <289d5bea-8fd5-b009-18dc-5639f3a0c0d2@bell-sw.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: suy.fnst@fujitsu.com, ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210913125558.x55BqP3XxxGLOv7g6OBGJ4MfNdYvctRc3rnRneSfyxo@z>

> On 13.09.2021 15:28, Petr Vorel wrote:
> >> Hi Petr,
> >> On 10.09.2021 12:36, Petr Vorel wrote:
> >>>> On 09.09.2021 18:53, pvorel wrote:
> >>>>> Hi Su, Alexey,

> >>>>> On 2021-08-30 11:26, suy.fnst@fujitsu.com wrote:
> >>>>>> Hi,
> >>>>>> =A0 I found that it's indeed related to ipv6 DAD as you said.
> >>>>>> Calling
> >>>>>> `ip netns exec ltp_ns sysctl -n net.ipv6.conf.ltp_ns_veth1.accept_=
dad=3D0`
> >>>>>> or tst_wait_ipv6_dad() at end of the setup both solves the problem.
> >>>>>> However there is one super strange part that the tentative address=
 is
> >>>>>> the local link adress of the ltp_ns_veth1:

> >>>>>> 5: ltp_ns_veth1@if4: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
> >>>>>> state UP group default qlen 1000
> >>>>>> =A0=A0=A0 link/ether f2:8f:24:d4:ba:26 brd ff:ff:ff:ff:ff:ff link-=
netnsid 0
> >>>>>> =A0=A0=A0 inet 10.0.0.1/24 scope global ltp_ns_veth1
> >>>>>> =A0=A0=A0=A0=A0=A0 valid_lft forever preferred_lft forever
> >>>>>> =A0=A0=A0 inet6 fd00:1:1:1::1/64 scope global nodad
> >>>>>> =A0=A0=A0=A0=A0=A0 valid_lft forever preferred_lft forever
> >>>>>> =A0=A0=A0 inet6 fe80::f08f:24ff:fed4:ba26/64 scope link tentative
> >>>>>> <-------------------
> >>>>>> =A0=A0=A0=A0=A0=A0 valid_lft forever preferred_lft forever

> >>>>>> However, there is no place using the address in mpls02 test.>> It =
makes me wonder how could it be possible to trigger the issue..

> >>>> Looks like the problem here in the neighbor discovery of fd00:1:1:1:=
:2
> >>>> using link-local address, and vice verse for the other side. mpls is
> >>>> using the following route with the address:

> >>>> fd00:23::2  encap mpls  60 via fd00:1:1:1::2 dev ltp_ns_veth1 metric=
 1024 pref medium
> >>>> so the address there should be in a reachable state...

> >>> Thanks for info! I wonder if it's a bug in mpls or elsewhere. WDYT?

> >> https://github.com/iputils/iputils/issues/300
> > Ah, thanks for pointing this.

> >> So we should be careful with the flood option in ping, especially
> >> if it is the first test to run after initial test interfaces setup.
> >> For example, for mpls02, it is "icmp tcp udp".
> > Flooding is done with -f or -i 0. IMHO we don't do that in tst_ping(),
> > what am I missing? The bug is about flooding (-i 0) with zero packet si=
ze (-s 0,
> > but maybe our use -s 10 would trigger the bug as well).

> Actually, we do have -f option in tst_ping(), in $flood_opt var.
Ah, I'm blind today, thanks :). I wonder if it's really enough for mpls to =
just
move icmp in TST_TEST_DATA to the end (or just not being first). If it's
working, feel free to add ack from my to the commit message.

Kind regards,
Petr


-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
