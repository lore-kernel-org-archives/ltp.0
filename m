Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B05C77B75
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 10:08:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC32B3CD40E
	for <ltp@archiver.kernel.org>; Fri, 19 May 2023 12:08:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 206D83CB263
 for <ltp@lists.linux.it>; Fri, 19 May 2023 12:07:55 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3F97C1000D34
 for <ltp@lists.linux.it>; Fri, 19 May 2023 12:07:54 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 58F5261717;
 Fri, 19 May 2023 10:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BADC433D2;
 Fri, 19 May 2023 10:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684490872;
 bh=ErpNX8MfnBhLkqUmYyUGRkGWNEqA9sLH6OQwiqLpoyc=;
 h=Subject:From:To:Date:In-Reply-To:References:From;
 b=WYh8RBFOvz/J2Deh1sUG6sQZv9Nus1qZFyt/B3rR189MwoWNgC95nUamRAk19zlu/
 D47yL+RcmhylZylN/+aKDftfP+mWbOPT6U7TJsAlzfFojyQbuwbZnBqvR26VMJnqyV
 AmmCQl36t9yZtbYyRECwPDEmYTfU79qyBtt1hWN3IMYx+1oHekrGDYqu7ZBzc6hM9q
 ya89X8B9TOayZ8/WqoNJHLlGLIjS52oYcM5LM2LGmuCn0QfiUDv78hNfnorqkp+u4H
 FHxPW1fsZ6/YqolfTAlxyaDHI6fGibqfPnNKRH+K8DFdBUabFvlHHP5BT63VpoCcMS
 qxAa9/7mgxH0Q==
Message-ID: <c6c0ae90df044b883ed65ba1896db8b51dfa70d4.camel@kernel.org>
From: Jeff Layton <jlayton@kernel.org>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>, "ltp@lists.linux.it"
 <ltp@lists.linux.it>
Date: Fri, 19 May 2023 06:07:51 -0400
In-Reply-To: <68340cb2-87e1-ff17-2db8-5610beba761b@fujitsu.com>
References: <20230518113216.126233-1-jlayton@kernel.org>
 <68340cb2-87e1-ff17-2db8-5610beba761b@fujitsu.com>
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/statx06: use a fine-grained timestamp
 for the second time fetch
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, 2023-05-19 at 09:16 +0000, Yang Xu (Fujitsu) wrote:
> 
> on 2023/05/18 19:32, Jeff Layton wrote:
> > I have a patchset in progress to change the kernel to sometimes use
> > fine-grained timestamps for the mtime/ctime. With this, the statx06 test
> > sometimes fails.
> > 
> > Change the test to grab a fine-grained timestamp for the "after" value,
> > which fixes the issue.
> 
> Now, it is not a right time to review this patch,  I prefer to review 
> this when your kernel patchset is merged into linux master or 
> linux-next. Then we can add a comment or a kernel commit id to explain 
> this..
> 
> 

Fair enough. I don't think there is any issue with taking this patch in
earlier however.

The problem with this test is that it makes the assumption that coarse-
grained timestamps are sufficient to bracket a filesystem operation.
While that has largely been true in the past, it's certainly not
specified by any standard.

> > 
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >   testcases/kernel/syscalls/statx/statx06.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/testcases/kernel/syscalls/statx/statx06.c b/testcases/kernel/syscalls/statx/statx06.c
> > index ce82b905bebd..fa75982b0901 100644
> > --- a/testcases/kernel/syscalls/statx/statx06.c
> > +++ b/testcases/kernel/syscalls/statx/statx06.c
> > @@ -109,7 +109,7 @@ static void test_statx(unsigned int test_nr)
> >   	clock_wait_tick();
> >   	tc->operation();
> >   	clock_wait_tick();
> > -	SAFE_CLOCK_GETTIME(CLOCK_REALTIME_COARSE, &after_time);
> > +	SAFE_CLOCK_GETTIME(CLOCK_REALTIME, &after_time);
> >   
> >   	TEST(statx(AT_FDCWD, TEST_FILE, 0, STATX_ALL, &buff));
> >   	if (TST_RET != 0) {

-- 
Jeff Layton <jlayton@kernel.org>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
