Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92016C433EF
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 09:50:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DB0853C903B
	for <ltp@archiver.kernel.org>; Thu,  2 Dec 2021 10:50:17 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D60013C8CF4
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 10:50:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EF137601357
 for <ltp@lists.linux.it>; Thu,  2 Dec 2021 10:50:06 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C767221709;
 Thu,  2 Dec 2021 09:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638438605;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=460uOUFqagadUvudCRzMglINI2i8l+i3pah7CFYH1dk=;
 b=hVBxU4IA01eQ1gm+kffZWWE7qAMBVFpyI/JES0KkbXZS4IWGBvOKQwj6hDd/zi44GQbyrQ
 6d0jY2+oyhPVref7wjGHF0fGiGOVlJXzJYqK8PdX7tJLygK5G2PuxY8HE9foQGk/UElsoO
 5CLyKL6InxOVRCmDkvAK2c/ba2D5b3Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638438605;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=460uOUFqagadUvudCRzMglINI2i8l+i3pah7CFYH1dk=;
 b=lU1aTHg6oexHOq/ZIbode5x9HOHLvyAEGSMG7AV7uuFJ06KvFU7OkFcIPikBqFISanO4XA
 9+g9Fc0BowHjYSDw==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E3E55A40E8;
 Thu,  2 Dec 2021 09:50:00 +0000 (UTC)
References: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <bbf87d62e2e8274fddc160813e64aedb0a01ffe1.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2ed6DqKw80Xa_BTjUweT0HrhrUN2-7X+sS05K9gCr2F5A@mail.gmail.com>
 <CADS1e3cCXsu=y_GNM3ymwHtOq9R671YnQAWgyycG25FJYnOLaA@mail.gmail.com>
 <CAEemH2cZvK29mrN2xD_EOPx7w3UXFBHrWmAdg+rv5K2vcP3qNA@mail.gmail.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 02 Dec 2021 09:23:27 +0000
In-reply-to: <CAEemH2cZvK29mrN2xD_EOPx7w3UXFBHrWmAdg+rv5K2vcP3qNA@mail.gmail.com>
Message-ID: <87pmqfcp4j.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Cc: LTP List <ltp@lists.linux.it>,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li and Luke
Li Wang <liwang@redhat.com> writes:

> On Thu, Dec 2, 2021 at 6:24 AM Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> wrote:
>
>  Hi Li, 
>
>  On Wed, Dec 1, 2021 at 1:13 AM Li Wang <liwang@redhat.com> wrote:
>
>  Hi Luke,
>
>  Thanks for looking into this.
>
>  On Sat, Nov 27, 2021 at 8:05 AM Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> wrote:
>
>  Update tests to be able to work when memory controller is mounted under
>  cgroup2 hierarchy.
>
>  I'm thinking whether we could achieve these setup functions
>  more generic in cgroup_lib.sh, which to avoid the redundancy
>  behavior over and over again in each cgroup sub-test.

+1 this is very necessary IMO

>
>  Yes I agree. As I was doing the same things a few times I was beginning to wonder if there was a better way. I would be willing to look further into
>  expanding the cgroup_lib.sh and resubmitting my recent patches with
>  those changes.
>
> Thanks a lot!
>  
>  
>  About the compatibility of cgroup V1 and V2 in test, I'd suggest
>  following what the LTP C library did in include/tst_cgroup.h.
>  https://github.com/linux-test-project/ltp/blob/master/doc/c-test-api.txt#L2024
>
>  The solution may be briefly as:
>   
>    1. scan system mounted CGroup path, and judge the situation as one of below:
>       * only CGroup V2 mounted
>       * only CGroup V1 mounted
>       * both CGroup V2 and V1 mounted
>       * no CGroup mounted
>    2. make use of the system mounted CGroup V2 or TSKIP
>        * goto step 5
>    3. make use of the system mounted CGroup V1 
>        * goto step 5
>    4. do mount Cgroup as what we needed (V1 or V2) in test
>        * goto step 5
>    5. do cleanup 
>
>  Yes this would be the way to go through setting up a controller and checking everything.  
>  Going through the steps you mentioned for mounting a single controller and returning that path wouldn't be too hard but 
>  it seems to get more complicated when we want some guarantee of having multiple controllers in a hierarchy (if we even
>  would want to support something like that, which for testing purposes wouldnt seem unheard of).
>
> Right, it is the complicated part and you can take a reference how
> the current C API handles it.

Actually we can use the C API. This would avoid a whole bunch of
issues. It requires creating a utility which we can use from shell
(e.g. tst_cgctl).

We *may* have to track state somehow. Either we could run the utility as
a daemon initially and communicate with a socket to execute commands. Or
we could save/serialise some state to environment/shell
variables. Alternatively we can probably rescan the system each
time. The only state really required is the test's PID which is needed
to find the correct CGroup in the LTP sub-hierarchy.

Still that is probably easier than dealing with all of the corner cases
twice.

>
> TBH, I even think to skip the handling on mixed mounting with V1
> and V2, that is too messy/overthinking and not suggested using way.
>
> We'd better face the future and ideally as myself hoping,
> V2 will replace V1 everywhere someday:).

There are still controllers/features that don't exist on V2. Meanwhile
there are features that only exist on V2. So if someone wants both, then
they have to mount both. Regardless, this was the default in systemd, so
we are stuck with it for about 20 years and can't ignore it ;-)

>
>  
>  Maybe something mimicking the tst_cgroup_require() from the C api would be useful here? I imagine this is where we would
>  do the checking and mounting logic that you were describing. We would just also have to include checking if the controllers
>  we are requiring can be mounted / already exist together.
>
>  For example I am imaging something mimicking the C api something like:
>  tst_cgroup_require "cpu"
>  tst_cgroup_require "cpuset"
>  root_mount_point =$(tst_cgroup_get_mountpoint)
>
> I prefer this one a bit, not only it's consistent with C API but it also
> can do CGroup mounting in tst_cgroup_require for a system without
> V1 nor V2 mounting. Then I'd suggest having tst_cgroup_cleanup to
> help umount that which makes things more clear to understand.
>
> Anyway, it depends on the details achieve, maybe there is a better
> solution we haven't found.

Yes, or if it is a utility then

$ test_cpu_cg_dir = $(tst_cgroup require cpu)
$ test_cpu_cg_dir = $(tst_cgroup require memory)

maybe with an option to pass the PID to indetify the test. I guess there
might be some existing env variable the shell API sets we could use as well.

$ tst_cgroup cleanup --pid $MAIN_PID

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
