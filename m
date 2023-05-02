Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF1FC77B7E
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 10:12:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 365B83CD918
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 12:12:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A16AC3CB8AC
 for <ltp@lists.linux.it>; Tue,  2 May 2023 12:12:31 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 97BF1600055
 for <ltp@lists.linux.it>; Tue,  2 May 2023 12:12:29 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 73A7861E5C;
 Tue,  2 May 2023 10:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B07C433EF;
 Tue,  2 May 2023 10:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1683022346;
 bh=aM94D7DjS72A/xp1gAzDQwrhIU7LM7u1+sqKjvi5MHk=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=eLxA1yXf39CWFW9N6n3/xRGGcd/EQyeBUrgZcgthpSDgueB/Td+pzErg6LRLJG6cW
 0XUhgGKXEz++uqaciP6qgrDZL6x0NYjUnLRlt54TgRjEB5fQyqAZ1WQ9cnPCwy3Nx1
 oLdsYIDvkvI7DCVgxSg0bk9sBTVIZ8Qe2BBQfVRDFx34ENNLVWiaAV7QgRW2rb3vuE
 6h9uZqfoQEZYcLyeiSDjlJ14aQea/M7XJx+8Zgks4fxnXglZlaCL5iLF6CeI/HQc6G
 8To9CcfpiGx4cU1jkv1qPoIuDw7X7ZpK9DRH8BdBYs2o7gP8ESDOk2SIQYdxfVRX/X
 FudCgXb+t2LJw==
Message-ID: <500fc91b75ef67263825cf3410a8a66c7bc0fd85.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Date: Tue, 02 May 2023 06:12:24 -0400
In-Reply-To: <20230502003929.GG2155823@dread.disaster.area>
References: <202305012130.cc1e2351-oliver.sang@intel.com>
 <0dc1a9d7f2b99d2bfdcabb7adc51d7c0b0c81457.camel@kernel.org>
 <20230502003929.GG2155823@dread.disaster.area>
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [jlayton:ctime] [ext4]  ff9aaf58e8: ltp.statx06.fail
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
Cc: Christian Brauner <brauner@kernel.org>, lkp@intel.com,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 2023-05-02 at 10:39 +1000, Dave Chinner wrote:
> On Mon, May 01, 2023 at 12:05:17PM -0400, Jeff Layton wrote:
> > On Mon, 2023-05-01 at 22:09 +0800, kernel test robot wrote:
> > The test does this:
> > 
> >         SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &before_time);
> >         clock_wait_tick();
> >         tc->operation();
> >         clock_wait_tick();
> >         SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
> > 
> > ...and with that, I usually end up with before/after_times that are 1ns
> > apart, since my machine is reporting a 1ns granularity.
> > 
> > The first problem is that the coarse grained timestamps represent the
> > lower bound of what time could end up in the inode. With multigrain
> > ctimes, we can end up grabbing a fine-grained timestamp to store in the
> > inode that will be later than either coarse grained time that was
> > fetched.
> > 
> > That's easy enough to fix -- grab a coarse time for "before" and a fine-
> > grained time for "after".
> > 
> > The clock_getres function though returns that it has a 1ns granularity
> > (since it does). With multigrain ctimes, we no longer have that at the
> > filesystem level. It's a 2ns granularity now (as we need the lowest bit
> > for the flag).
> 
> Why are you even using the low bit for this? Nanosecond resolution
> only uses 30 bits, leaving the upper two bits of a 32 bit tv_nsec
> field available for internal status bits. As long as we mask out the
> internal bits when reading the VFS timestamp tv_nsec field, then
> we don't need to change the timestamp resolution, right?
> 

Yeah, that should work. Let me give that a shot on the next pass.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
