Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502F9C28B2B
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 21:03:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A39473CA1EC
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 23:03:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4316C3C1C63
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 23:03:09 +0200 (CEST)
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au
 [211.29.132.246])
 by in-6.smtp.seeweb.it (Postfix) with ESMTP id 33FBB140032F
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 23:03:07 +0200 (CEST)
Received: from dread.disaster.area (pa49-181-52-176.pa.nsw.optusnet.com.au
 [49.181.52.176])
 by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id A681E62D490;
 Fri, 19 Aug 2022 07:03:00 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
 (envelope-from <david@fromorbit.com>)
 id 1oOmfL-00EjSC-6k; Fri, 19 Aug 2022 07:02:59 +1000
Date: Fri, 19 Aug 2022 07:02:59 +1000
From: Dave Chinner <david@fromorbit.com>
To: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <20220818210259.GG3600936@dread.disaster.area>
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
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62fea908
 a=O3n/kZ8kT9QBBO3sWHYIyw==:117 a=O3n/kZ8kT9QBBO3sWHYIyw==:17
 a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=VwQbUJbxAAAA:8 a=7-415B0cAAAA:8
 a=goNm9uWxpVm3eJU7WO0A:9 a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
 a=biEYGPWJfzWAr4FL6Ov7:22
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
 Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, ltp@lists.linux.it
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

For a single 1MB file? inodegc is delayed 1 jiffie (max 10ms).
If it's processed immediately because everything else is idle and
nothing blocks, it will be done in 250-500 microsends.

Of course, the moment you put such tests in a VM on a host that is
running other VMs nothing is ever idle and inodegc delays are
outside the control of the guest kernel/filesystem....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
