Return-Path: <SRS0=gXt9=N7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB79CC433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 16:27:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1007B610C9
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 16:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1007B610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 44C083C913D
	for <ltp@archiver.kernel.org>; Thu,  9 Sep 2021 18:27:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF8933C7F5D
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 17:53:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC7BF2005E6
 for <ltp@lists.linux.it>; Thu,  9 Sep 2021 17:53:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AA193201E6;
 Thu,  9 Sep 2021 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631202797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qfH1P1Ua1erw7UUsO0XjbwmgFXj8FnzKEKfWfFewkI=;
 b=jHrM7bBvi76b3+9e9s+n4hGnZ+F6fzTttuNYrOcnPPdXF/jfl8TSaM3nI/XIQEDNSVadOK
 qDI5geNsjvoxc6CLG9bM/hhc88OzZyUaYwTbLrpm/EFFIsp7pe5t9Buoza2Sbuz3yGgrBu
 4RsMSOiixOsQ61XWRcMAMjG4DsRjkrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631202797;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qfH1P1Ua1erw7UUsO0XjbwmgFXj8FnzKEKfWfFewkI=;
 b=zGbOmDW3bfo32GC2nGIUAySYqbK6EEI4FssXbWb1IDGM64yGa7i65So4sLB03Vek3gdgtY
 kupw3HY3OwscByBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9331113CC8;
 Thu,  9 Sep 2021 15:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SKfVIu0tOmEyYAAAMHmgww
 (envelope-from <pvorel@suse.de>); Thu, 09 Sep 2021 15:53:17 +0000
MIME-Version: 1.0
Date: Thu, 09 Sep 2021 17:53:17 +0200
From: pvorel <pvorel@suse.de>
To: suy.fnst@fujitsu.com
In-Reply-To: <TY2PR01MB21246C459BBCD763BD1C0CBD89CB9@TY2PR01MB2124.jpnprd01.prod.outlook.com>
References: <TY2PR01MB212429263FC238F44A2C1D7D89C79@TY2PR01MB2124.jpnprd01.prod.outlook.com>
 <410b2b2d-9633-7a57-527a-1663afe5f631@bell-sw.com>
 <TY2PR01MB21246C459BBCD763BD1C0CBD89CB9@TY2PR01MB2124.jpnprd01.prod.outlook.com>
User-Agent: Roundcube Webmail
Message-ID: <0acf816462d49d8a6004c87e36b05d1b@suse.de>
X-Sender: pvorel@suse.de
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 09 Sep 2021 18:27:19 +0200
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
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210909155317.Ji7G_vJgGnS1ebIlMxvVLF4xQ6OkEFusOL2d5MIlGwc@z>

Hi Su, Alexey,

On 2021-08-30 11:26, suy.fnst@fujitsu.com wrote:
> Hi,
>   I found that it's indeed related to ipv6 DAD as you said.
> Calling
> `ip netns exec ltp_ns sysctl -n 
> net.ipv6.conf.ltp_ns_veth1.accept_dad=0`
> or tst_wait_ipv6_dad() at end of the setup both solves the problem.
> However there is one super strange part that the tentative address is
> the local link adress of the ltp_ns_veth1:
> 
> 5: ltp_ns_veth1@if4: <BROADCAST,UP,LOWER_UP> mtu 1500 qdisc noqueue
> state UP group default qlen 1000
>     link/ether f2:8f:24:d4:ba:26 brd ff:ff:ff:ff:ff:ff link-netnsid 0
>     inet 10.0.0.1/24 scope global ltp_ns_veth1
>        valid_lft forever preferred_lft forever
>     inet6 fd00:1:1:1::1/64 scope global nodad
>        valid_lft forever preferred_lft forever
>     inet6 fe80::f08f:24ff:fed4:ba26/64 scope link tentative
> <-------------------
>        valid_lft forever preferred_lft forever
> 
> However, there is no place using the address in mpls02 test.
> It makes me wonder how could it be possible to trigger the issue..

I wonder if test still needs be fixed to work on all setups.

Petr

> 
> Thanks!
> --
> Su

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
