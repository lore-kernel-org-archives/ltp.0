Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE37AC00140
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 16:05:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 838BA3CA1A2
	for <ltp@archiver.kernel.org>; Thu, 18 Aug 2022 18:05:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D3D93C87EF
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 18:05:36 +0200 (CEST)
Received: from sandeen.net (sandeen.net [63.231.237.45])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id F00016006CB
 for <ltp@lists.linux.it>; Thu, 18 Aug 2022 18:05:35 +0200 (CEST)
Received: from [10.0.0.146] (liberator.sandeen.net [10.0.0.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by sandeen.net (Postfix) with ESMTPSA id C3C2F514E45;
 Thu, 18 Aug 2022 11:04:10 -0500 (CDT)
Message-ID: <f03c6929-9a14-dd58-3726-dd2c231d0981@sandeen.net>
Date: Thu, 18 Aug 2022 11:05:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <YvZc+jvRdTLn8rus@pevik> <YvZUfq+3HYwXEncw@pevik>
 <YvZTpQFinpkB06p9@pevik> <20220814224440.GR3600936@dread.disaster.area>
 <YvoSeTmLoQVxq7p9@pevik> <8d33a7a0-7a7c-47a1-ed84-83fd25089897@sandeen.net>
 <Yv5Z7eu5RGnutMly@pevik>
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <Yv5Z7eu5RGnutMly@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

On 8/18/22 10:25 AM, Petr Vorel wrote:
> Hi Eric, all,
> 

...

> 
>> IOWS, I think the test expects that free space is reflected in statfs numbers
>> immediately after a file is removed, and that's no longer the case here. They
>> change in between the df check and the statfs check.
> 
>> (The test isn't just checking that the values are correct, it is checking that
>> the values are /immediately/ correct.)
> 
>> Putting a "sleep 1" after the "rm -f" in the test seems to fix it; IIRC
>> the max time to wait for inodegc is 1s. This does slow the test down a bit.
> 
> Sure, it looks like we can sleep just 50ms on my hw (although better might be to
> poll for the result [1]), I just wanted to make sure there is no bug/regression
> before hiding it with sleep.
> 
> Thanks for your input!
> 
> Kind regards,
> Petr
> 
> [1] https://people.kernel.org/metan/why-sleep-is-almost-never-acceptable-in-tests
> 
>> -Eric
> 
> +++ testcases/commands/df/df01.sh
> @@ -63,6 +63,10 @@ df_test()
>  		tst_res TFAIL "'$cmd' failed."
>  	fi
>  
> +	if [ "$DF_FS_TYPE" = xfs ]; then
> +		tst_sleep 50ms
> +	fi
> +

Probably worth at least a comment as to why ...

Dave / Darrick / Brian - I'm not sure how long it might take to finish inodegc?
A too-short sleep will let the flakiness remain ...

-Eric

>  	ROD_SILENT rm -rf mntpoint/testimg
>  
>  	# flush file system buffers, then we can get the actual sizes.
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
