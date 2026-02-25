Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E019EFD211
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 09:25:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B9163C7BA1
	for <ltp@archiver.kernel.org>; Wed, 25 Feb 2026 10:25:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3ACBF3C1AAA
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 10:24:53 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 80A6B14010D7
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 10:24:52 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48069a48629so65925755e9.0
 for <ltp@lists.linux.it>; Wed, 25 Feb 2026 01:24:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772011492; cv=none;
 d=google.com; s=arc-20240605;
 b=htSB0aKWNfLQreDPEMedfA/Veh9JVHrR7NkzWCfOCjwqE/VUkTdzPvIpide4MqDx7s
 NeAhbnla/wOOAd18oAWBKE3Qg8FFmPM5uBXQLQOgBN89PWRhR1eIoP+kObgdHJq9YqBG
 iJxYyQVBrVYq3XWiKPvX/fy3ocl7KzUDKZGMmvq8p20Og43aDmfIVxdTtLmgqEwrEdaG
 2vDoL3cDpK3PESvgLQheViwZGPgRFc+zv7CSJFELBiUMCo8paHNOHLUL/HD1dJwxOPWG
 s83v7BQm1mMIwA9abFlSt1kL8LBx5KVz2DT3zDYhPQnYBbf7DjoMdCguMtpsb5PDaPbK
 QDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dus6SHtktgg5r95juVquSPY6WrV/otvesUmbLSx0OzA=;
 fh=GHsbkj+lME9hcdkEjuJEM3ZWQN+qxS2LbWr+4HYLQ3c=;
 b=cdBSAMIMS8FvN/n9D0AsluCdSpMDX8AhojcYVYJoGUFb5e0Lzf1Gg/lHaFV6Fxg9iV
 bRyNxt6cluP+/5u+De40YLOLUXQCJhkoNoNv2NgetPAgUvGRPBci46XXYFhrAsaJbaU+
 onRn87HkGNPBCO7QgQSXis7pii9B14umIpc4dGHLg5YZMqBlAAvywGTrCghPa5B1nSWu
 656Nr1ASYzD7uzAi/uPxX6pEfvW7sIc/uf+ARWHOq3xS1cZ1tThEMsse3a4ynPTtfThr
 oXM/KNHL3JoIZidNLd0GKfeUO1IWcxGWVF3lBCZs/CW70sYln0XX/mmk3BRwSZw1QFSv
 B6LQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772011492; x=1772616292; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dus6SHtktgg5r95juVquSPY6WrV/otvesUmbLSx0OzA=;
 b=YFlsJbyIf1Q3ankcN+mbX8Ykcz3vn+6AhedHLCnVLIFyW98M/CZuiYnCE3OxrT2eCv
 JR279rhFondFU+vJC+oZibJx/QhEIi4LpqN3EgA8VABR/RCiPSRKHRYhFUyInnZ6jQiY
 2WDnG68++Vzcq+ORr+0Xh9YJUtk0t+oQOPANAR3qa8GCDxQLKxbYtdsP3rCX8K3SD863
 E40syjNBPbw8bhMs93F9c31O95AaSXQAeKKYiLANqLBZ86JCoycpDjYjOCKgZw9/VEXO
 +C9Jeyhq+kz4gI1N1+0BjPlZiN55N9D8KSgYxStJFKoVb3+P5RIJMqeK4WwXYWfI4yLy
 OCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772011492; x=1772616292;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dus6SHtktgg5r95juVquSPY6WrV/otvesUmbLSx0OzA=;
 b=G3A5ihYknS8d/P6nshtXgWth+ab8hoXhXzxUcZHpHuOJYUxonh3dklRAcvx5BnNLpW
 69/DGv97e/55/UUvYZSBvBL5tCQVp0Iv8U8ocdNx7uUfLEFBjW2d0CyYVlAz/ul+c9QV
 WXLtv885ZMJoD5Sxw2sJkRDtzcJ6SIeLr/aqSfYvHjrHJEETgLnr51/M4ylqv0gvtEEu
 yMOqZYnuyNRp4F8pBcdgeqfnzvdEo+DbholhojrDcpQ25giQDaCPBBfWhNgUrPO00Xi7
 IJ4oN95M/06QQ32iXtg9+HMZmEZd2JLEBpaPCIR34HrA5oCDhy92SMMeyeNhlHBZxeyw
 aoVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+sClUazApiVHyaWLFAnlkYAwNdDRCkpXgJCjm79bQgXSEoEqlHelP70k1wK+/3yLVkXw=@lists.linux.it
X-Gm-Message-State: AOJu0YzEs5CNTI7oN4OvmbrifLf1/isd+vNsPCv7UPzhlpe8tucdlzVD
 s2VowGiDGawvhZSMbrHxxC2G9AQiTrcCR0GxkE63j+u7cuGqdMmBbJ48ZhlLn+8yhOyNMWNi6eK
 voShcuq6oub7h7+BxOGy5TaCERWtcjmY=
X-Gm-Gg: ATEYQzxZB7/gk/sP3GCwikSfc1ge+pFFao+cNHk2JFt8vI+/k0aQVJJT1JsK0v0Su4F
 LelQRmjLqfnz+P20BMjH2O7Rc5NlKm3UHpa5Q9dbNLjCRLt8qQ7rwaUi3oGibxNoQ7cFv7TN2LG
 Re8amsEryb45NajHKxmknbfHW/FQqmR4JuMP23ApuhK7AKM0mb+BrIgVKg6BHrp9e+JCFbNKhPf
 5hZdPFoC0H3U6mu9zECmk15/LSvLjmCYi6Ix25LJj18cubBFYun5ne23eqyudR4G/20XFnd8s+L
 nlCV672bQhhFXq1GfatslcQYBwD81lF1PriQig==
X-Received: by 2002:a05:600c:470f:b0:46f:c55a:5a8d with SMTP id
 5b1f17b1804b1-483a95a852cmr269148735e9.4.1772011491586; Wed, 25 Feb 2026
 01:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20260221135338.26236-2-sebastian.chlad@suse.com>
 <20260222203442.GB417048@pevik> <aZyGMpdvgFXoYjHb@yuki.lan>
 <20260224093820.GA37927@pevik> <aZ2BGwrdHKeaxXkD@yuki.lan>
 <20260224114652.GA48499@pevik> <aZ2Xcxf6F9f9Bl8V@yuki.lan>
 <20260224161144.GA69424@pevik>
In-Reply-To: <20260224161144.GA69424@pevik>
From: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Wed, 25 Feb 2026 10:24:39 +0100
X-Gm-Features: AaiRm504Sow62YPbsjz1bVuLza_Wq10FfjhR9X5DV8WwBv6ArjjzpZBA3s77Ncg
Message-ID: <CAJCsO8fUhvFVOeemD0Q_poNG7qta=F-i8fMN9NjCqrt4mB3f1w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] nfs: Adapt the lib to allow to test in 2-host mode
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>,
 Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 24 Feb 2026 at 17:11, Petr Vorel <pvorel@suse.cz> wrote:

> > Hi!
> > > > > > And with that we would need some kind of "master file" that would
> > > > > > explain which script should be executed on which host etc. But I
> guess
> > > > > > that it would be tricky to desing this properly.
>
> > > > > I'm not sure if separated file is worth of adding. There is
> tst_rhost_run()
> > > > > function which should be used for checking, which works well on
> both netns and 2
> > > > > host based setup (that's why v2).
>
> > > > This is just me thinking if we can actually desing something more
> proper
> > > > in the future now that runltp is gone. I think that the whole
> > > > tst_rhost_run() infrastructure is a bit of a hack and that the
> > > > multimachine test can be desingned differently. I would say that more
> > > > proper solution would be to have the test split into one script per
> > > > worker and having some master script/description to drive the
> testing.
> > > > The testrunner would read the information about which script to run
> on
> > > > which worker and would also have to handle synchronization.
>
> > > FYI tst_rhost_run() is used for testing itself as well, more than for
> setup and
> > > cleanup:
>
> > > $ git grep -l tst_rhost_run |wc -l
> > > 35
>
> > > Therefore we can rethink network test setup, but tst_rhost_run() will
> be needed
> > > anyway.
>
> > What I'm thinking about is to replace the tst_rhost_run() with a
> > synchronization between multiple tests scripts. With that a script can
> > wait for some kind of event instead of running the code itself.
>
> > It would be far more flexible approach than what we have now. With that
> > we could easily scale to tests with three or more machines that are
> > impossible to implement at the moment. But of course unless we actually
> > write a proof of a concept we will not be able fully understand if this
> > concept is going to be better or not.
>
> > > > In the case of the NFS tests the master script would say to run a
> script
> > > > that sets up NFS server and signal the testrunner once it's done and
> > > > wait. The script that would be doing the actuall test would be
> executed
> > > > once the the NFS server script to signaled it's completion and then
> > > > start the actual test. Once it's finished testing it would exit,
> which
> > > > would tell the testrunner to wake up the NFS server script in order
> to
> > > > cleanup. If we decided to write multimachine tests this way we would
> > > > need to add a way how to pass parameters such as IP addresses from
> kirk
> > > > to tests and also add a way how to propagate events between tests via
> > > > kirk so that we can have some kind of locking.
>
> > > Also, you call it a hack, but it works standalone, without any runner.
> I would
> > > be careful to add kirk as a hard dependency to run a single test
> without a
> > > strong reason (sure, using kirk to handle metadata to run tests in
> paralel or
> > > replace runtest files will be a great improvement, but I would like to
> still
> > > keep executing a test itself by just calling it with proper PATH
> setup).
>
> > It should be possible to design the system so that tests can be executed
> > with a simpler solution than kirk.
>
> +1
>
> > Also it's not as standalone as you may think. You need to 1) start two
> > machines and manually install LTP there 2) write the IP addresses into
> > the configuration and only once that is done you can execute tests on
> > two machines.
>
> Yes, that's job of the framework executor (kirk, openQA, TuxMake, Fuego,
> Lava,
> etc).
>
> Yes, but when there is some bug which needs to be bisected, the fastest
> approach
> for network tests is to run with rapido over netns. New approach should
> keep
> support for netns and real host. Of course real communication over network
> is
> not the same as using netns, but quite a lot of bugs can be caught this
> way.
>
> > > FYI "multimachine tests": I know only about 1 test which needs more
> than a
> > > single machine: IPsec (implemented in openQA instead of LTP [1]).
>

FYI openQA has many multimachine tests.
Also in the openqa the multimachine tests are done exactly with localapi,
so basically semaphores.

Personally for development and testing of the ltp 2-hosts I used:
https://github.com/dmacvicar/terraform-provider-libvirt
Yeah, terraform. I imagine hooking things up together so
that terraform-provider-libvirt provides VMs with needed IPs and what not,
and kirk connects to SUT over ssh and the ltp nfs tests simply run the
tests, should be simple exercise.

I do not see a problem with lhost being a driver for net/nfs tests run on 2
machines.
But if we see a need, we could also provide a sort of lock api, so nodes of
multimachine tests could be synchronized that way too.
I guess those approaches are complementary, not exclusive.


>
> > I think that this is because our multimachine design is not as easy to
> > use as it should be.
>
> I'm not saying that there is not a requirement for 3+ machines tests just
> because I don't see it :). But it would be kind of some special tests
> (normally stressing a server is kind of test scenario for multi machine
> tests).
>
> And the reason why I'm asking question "do we need it?" is that I know how
> many
> tests we have to rewrite (+ generally how much of LTP rewrite is
> unfinished,
> including readthedoc migration).
>
> Kind regards,
> Petr
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
