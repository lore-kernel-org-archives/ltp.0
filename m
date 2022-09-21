Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06878C32771
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 07:46:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 272903CAD5D
	for <ltp@archiver.kernel.org>; Wed, 21 Sep 2022 09:46:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB2673CAC37
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 09:46:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5C2491A001CB
 for <ltp@lists.linux.it>; Wed, 21 Sep 2022 09:46:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 39D6821A1B;
 Wed, 21 Sep 2022 07:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663746397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9OXfaeMeZD6jpyL701M66yxkSmfRCNZuUveeI5qc/JU=;
 b=ql1S4jo2l5bsqvRswOXrXKKnEXwDkn0koQrCniOp2RdCbdYmr04/NKk0zVAJItr2hrnnEd
 WVa2TMwLuvMNbvkWoEVl0P9q5AAwuUlie3cYxnYHyh0A/5AAZj/JCoiclELT+Vz8IdnTlv
 1QD7Py1QMCav/2pKPr2xVxMojV+wOtw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663746397;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9OXfaeMeZD6jpyL701M66yxkSmfRCNZuUveeI5qc/JU=;
 b=lGzEtsl37hWv4yUtCeZ5tWw1i+cIbvZkLKYOL/h6kmqeKlGvfMbBMhRZ9JOgLPW6/13Wu1
 CRs8KdiT9IhPmBAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 227B913A00;
 Wed, 21 Sep 2022 07:46:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rbllB13BKmPUFAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 21 Sep 2022 07:46:37 +0000
Date: Wed, 21 Sep 2022 09:48:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <YyrB0fSRu7PvNvLi@yuki>
References: <20220916234552.3388360-1-prohr@google.com>
 <202209211425.14116dd2-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202209211425.14116dd2-oliver.sang@intel.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [tun]  a4d8f18ebc: ltp.ioctl03.fail
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
Cc: Patrick Rohr <prohr@google.com>,
 Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, lkp@lists.01.org,
 Lorenzo Colitti <lorenzo@google.com>, "David S . Miller" <davem@davemloft.net>,
 ltp@lists.linux.it, lkp@intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> tag=ioctl03 stime=1663640405
> cmdline="ioctl03"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1526: TINFO: Timeout per run is 0h 02m 30s
> ioctl03.c:76: TINFO: Available features are: 0x7533
> ioctl03.c:80: TPASS: TUN 0x1
> ioctl03.c:80: TPASS: TAP 0x2
> ioctl03.c:80: TPASS: NO_PI 0x1000
> ioctl03.c:80: TPASS: ONE_QUEUE 0x2000
> ioctl03.c:80: TPASS: VNET_HDR 0x4000
> ioctl03.c:80: TPASS: MULTI_QUEUE 0x100
> ioctl03.c:80: TPASS: IFF_NAPI 0x10
> ioctl03.c:80: TPASS: IFF_NAPI_FRAGS 0x20
> ioctl03.c:85: TFAIL: (UNKNOWN 0x400)

Obviously the test fails since new flag has been advertised. The test
will have to be updated once/if this commit hits mainline.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
