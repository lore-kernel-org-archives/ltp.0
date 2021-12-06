Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AC5C433F5
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 09:25:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 728DD3C2453
	for <ltp@archiver.kernel.org>; Mon,  6 Dec 2021 10:25:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C71CD3C0CCC
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 10:24:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 867911000A14
 for <ltp@lists.linux.it>; Mon,  6 Dec 2021 10:24:58 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6E1B32113D;
 Mon,  6 Dec 2021 09:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638782697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S7GBdp/Ztzng0neMevLrYvohaWeTvwdcDRgXqoX0GZs=;
 b=Sh5xkjSgMAydZnBKe0vmrVqQQZfUE7k0Twd8mPTxtdPZ1jhpQhtt+YJBNn0xH5x13Zs3oz
 hds512PYEesec9E7TTHUQNIR6RNaRn5QriXPgi2wAeviYtYBQkf/YPvDrboq8eFd5vVOYK
 5OeiGzqHo6OJ2vSBtIgVAQQQgbqyV54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638782697;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S7GBdp/Ztzng0neMevLrYvohaWeTvwdcDRgXqoX0GZs=;
 b=3do3un49VEPxZw9z1wKj6cpyEiFn151VD6sj2GVTdcqirLPWfjMpIiFiWZp/nsLgqq6s1t
 YVR1bKsJRuS35gAg==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F302DA3B87;
 Mon,  6 Dec 2021 09:24:56 +0000 (UTC)
References: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <bbf87d62e2e8274fddc160813e64aedb0a01ffe1.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2ed6DqKw80Xa_BTjUweT0HrhrUN2-7X+sS05K9gCr2F5A@mail.gmail.com>
 <CADS1e3cCXsu=y_GNM3ymwHtOq9R671YnQAWgyycG25FJYnOLaA@mail.gmail.com>
 <CAEemH2cZvK29mrN2xD_EOPx7w3UXFBHrWmAdg+rv5K2vcP3qNA@mail.gmail.com>
 <87pmqfcp4j.fsf@suse.de>
 <CADS1e3dXhKJ0NK0OSWYfu-KB__7OsOkRcGmTH66+Ah-tMW8ijA@mail.gmail.com>
 <CAEemH2cT76bRmeQQPQrALUjjK9VNaGRLY4jOYPNrMjkA4FF7_g@mail.gmail.com>
 <CADS1e3dkYtRibN7ADGh_c9T5uZ4BFTpjgPaXH1+xfBUS8xpKcA@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Mon, 06 Dec 2021 08:31:49 +0000
In-reply-to: <CADS1e3dkYtRibN7ADGh_c9T5uZ4BFTpjgPaXH1+xfBUS8xpKcA@mail.gmail.com>
Message-ID: <87ilw2ccgv.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/4] controllers/memcg: update stress test to work
 under cgroup2
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
Reply-To: rpalethorpe@suse.de
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Luke and Li,

Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> writes:

> Hi Richard and Li,
>
>  Hmm, why do we need that utility as a daemon in the background? 
>  Isn't it easier to execute a binary utility to get the CGroup path
>  only when needed? Just like Richard mentioned the alternative
>  way, rescan system each time and only distinguish correct CGroup
>  path via the test PID.
>
> Yes this would be easier if we only wanted to get access to the path. I was getting ahead of myself and thinking about using the C-api to keep track of creating sub-cgroups and all the state that comes with that. Which we wouldn't want to do for a shell utility because creation/cleanup of subgroups is for the test to take care of and
> that is more trivial in a shell environment.

Yes; tests which require complicated hierarchies have to cleanup
themselves. I think it would be a waste of time to add a generic
sub-directory cleanup mechanism until we have a number of tests which
would benefit from it.

Especially because some controllers might place special restrictions on
directory and process manipulation. (cpuset for example?).

>
>   
>  
>  The nice part of having a daemon that we could fork off for every test that uses it would be that the cleanup / tracking of sub-groups would get cleaned up in the normal way when we want to close the daemon and just call tst_cgroup_cleanup(). The daemons state would be tied to the test that's issuing commands to it.
>  We could also send out the commands via a shared buffer or pipe that
>  we read and write to.
>
>  But is a daemon per test (that uses the cgroup shell api) overkill? It seems it would spare us from having to track the test PID to sub-hierarchy like you were mentioning. Or maybe there are some other drawbacks to the per-test daemon idea that I'm not seeing?
>
>  I think yes, starting a daemon per test is not wise.
>
>  Another drawback I can think of is that will definitely affect paralleling things,
>  we must guarantee the CGroup mounted by testA shouldn't be scanned/used
>  by testB, otherwise, it will fail in the cleanup phase. But, we can make the LTP 
>  test mounted CGroup path is transparent to others just by adding a special string
>  like "ltp-cgroup".
>
> If I understand it correctly, all the cgroup tests are mounted and created like "controller_mount_point/ltp/test-$PID" where every test shares the mount_point and ltp dir. And when tst_cgroup_cleanup() gets called it only cleans up its own test_dir and removes the ltp dir and unmounts the mount point if it was the first test to do it. So
> none of the tests should be touching each other's directories and so
> what you're describing should already be taken care of. Maybe I'm not
> understanding you correctly.

I think maybe you are talking about two different things. However IMO
daemons should be avoided in general. There is no hard requirement here
to have a long running process.

>
> I think the only problem with the binary utility approach where we rescan every time we execute it is that 
> 1) The test-$PID dir that the test would be created with the PID of the program which if we were executing the utility could be different between calls. This could be easily solved by adding an arg to tst_cgroup_opts for a specific PID, which would be the test that is calling it. 
> 2) We lose the reference between calls to the root->test_dir that is filled in when we call tst_cgroup_require(), which is what does the cleanup of the test specific dir. This is where I believe Richard was mentioning passing the PID as "tst_cgroup cleanup --pid $MAIN_PID". Which if we wanted to use the C api for this we would have to
> expose it to knowing about specific PIDs? Or for the root->test_dir to
> be reset somewhere?

I suppose we also need to remember if the current test created the ltp
subdirectory or mounted any controllers.

We could do this by just printing the required command line options to
stdout when the utility exits. Then save this to a variable for the next
use.

>
>  -- 
>  Regards,
>  Li Wang
>
> Let me know if this makes sense and what you think about it, I might be getting confused somewhere. But if I understand you correctly I believe that the binary utility approach where we rescan and call tst_cgroup_require() or tst_cgroup_cleanup() is a good approach.
>
> Best, 
> - Luke

Yes, sounds good.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
