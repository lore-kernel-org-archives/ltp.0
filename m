Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4DD8C32772
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 16:27:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B0D63CA249
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 18:27:41 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 817113C9FEA
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 18:27:27 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EA00E200AD7
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 18:27:26 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 23C10B82039;
 Thu, 18 Aug 2022 16:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F1CC433C1;
 Thu, 18 Aug 2022 16:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660840043;
 bh=+y9aJbWtiam2o1FbJCokyrxLMhC6wEx/VJe+9gMP4BM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HCYTENFSNzfPwqtXc6baKz8uyObAhcMjLQlI+gZ8nUjLQSDv6obQGrZAPwpybp3Ni
 M5T5gYDlcwSfZ8rcdejnIZFt9gNcaTQK9dUGkPuJU+9+SgpTWnV9cFO6aaro1/y/Mh
 GCW3ltEWKlQFmsVAKNeyPfbBHIsg22HV+uYWDeFRTJBKBHp1Bwg0HLQg1scBTP4rcG
 UtUoJjcFZbk1gH55MomnQ99FgmvkNlNYGcOvTlPyi0kL7Wfjqk1iaTakwjj6XMo2AF
 ZkWhHAVE3fxY+Hnv8b0Gyjb/fnc12vBdvJvsP2z82xIp/DtPPPRp2BrAmE5gj8usnI
 S9SYzLgOaxPbg==
Date: Thu, 18 Aug 2022 09:27:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <Yv5oaxsX6z2qxxF3@magnolia>
References: <YvZc+jvRdTLn8rus@pevik> <YvZUfq+3HYwXEncw@pevik>
 <YvZTpQFinpkB06p9@pevik>
 <20220814224440.GR3600936@dread.disaster.area>
 <YvoSeTmLoQVxq7p9@pevik>
 <8d33a7a0-7a7c-47a1-ed84-83fd25089897@sandeen.net>
 <Yv5Z7eu5RGnutMly@pevik>
 <f03c6929-9a14-dd58-3726-dd2c231d0981@sandeen.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f03c6929-9a14-dd58-3726-dd2c231d0981@sandeen.net>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP test df01.sh detected different size of loop device
 in v5.19
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Dave Chinner <david@fromorbit.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Aug 18, 2022 at 11:05:33AM -0500, Eric Sandeen wrote:
> On 8/18/22 10:25 AM, Petr Vorel wrote:
> > Hi Eric, all,
> > 
> 
> ...
> 
> > 
> >> IOWS, I think the test expects that free space is reflected in statfs numbers
> >> immediately after a file is removed, and that's no longer the case here. They
> >> change in between the df check and the statfs check.
> > 
> >> (The test isn't just checking that the values are correct, it is checking that
> >> the values are /immediately/ correct.)
> > 
> >> Putting a "sleep 1" after the "rm -f" in the test seems to fix it; IIRC
> >> the max time to wait for inodegc is 1s. This does slow the test down a bit.
> > 
> > Sure, it looks like we can sleep just 50ms on my hw (although better might be to
> > poll for the result [1]), I just wanted to make sure there is no bug/regression
> > before hiding it with sleep.
> > 
> > Thanks for your input!
> > 
> > Kind regards,
> > Petr
> > 
> > [1] https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests
> > 
> >> -Eric
> > 
> > +++ testcases/commands/df/df01.sh
> > @@ -63,6 +63,10 @@ df_test()
> >  		tst_res TFAIL "'$cmd' failed."
> >  	fi
> >  
> > +	if [ "$DF_FS_TYPE" = xfs ]; then
> > +		tst_sleep 50ms
> > +	fi
> > +
> 
> Probably worth at least a comment as to why ...
> 
> Dave / Darrick / Brian - I'm not sure how long it might take to finish inodegc?
> A too-short sleep will let the flakiness remain ...

A fsfreeze -f / fsfreeze -u cycle will force all the background garbage
collection to run to completion when precise free space accounting is
being tested.

--D

> -Eric
> 
> >  	ROD_SILENT rm -rf mntpoint/testimg
> >  
> >  	# flush file system buffers, then we can get the actual sizes.
> > 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
