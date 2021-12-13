Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243E7C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 10:22:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B03683C89BC
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 11:22:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B79C53C093B
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 11:22:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8E4DB200B78
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 11:22:45 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B733E1F3BA;
 Mon, 13 Dec 2021 10:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639390964;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DrevJBElhvBWHdc8cEzhdTjbEYs5RuZukQcuChwQdGU=;
 b=PlUDScsh1yKu5bmM+y+lJ6Mp+Pfn7KSMeYj+PWbEkSZ3BUI2zGFVAKPHI9P1Z9cp31O9ig
 uFKqQo+HHqz2xZg3e5FTuQ6Bk32xDbz1Bqtynuh0Hkr3zg7ueruXX0miAvygLP0vb10HBu
 ckEeGfWU8BcR0hTZ9wfFVd+T4KSAN14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639390964;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DrevJBElhvBWHdc8cEzhdTjbEYs5RuZukQcuChwQdGU=;
 b=DbnXIOHqB46wAdNY8LJbbeeFJ/WnoFAMxHTiGV/MxtcsWwDagzOjwE7CCyt67CquqTzF+z
 aqJkYCd/4acPtFAw==
Received: from g78 (unknown [10.163.24.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 70139A3B83;
 Mon, 13 Dec 2021 10:22:44 +0000 (UTC)
References: <bbf87d62e2e8274fddc160813e64aedb0a01ffe1.1637970912.git.luke.nowakowskikrijger@canonical.com>
 <CAEemH2ed6DqKw80Xa_BTjUweT0HrhrUN2-7X+sS05K9gCr2F5A@mail.gmail.com>
 <CADS1e3cCXsu=y_GNM3ymwHtOq9R671YnQAWgyycG25FJYnOLaA@mail.gmail.com>
 <CAEemH2cZvK29mrN2xD_EOPx7w3UXFBHrWmAdg+rv5K2vcP3qNA@mail.gmail.com>
 <87pmqfcp4j.fsf@suse.de>
 <CADS1e3dXhKJ0NK0OSWYfu-KB__7OsOkRcGmTH66+Ah-tMW8ijA@mail.gmail.com>
 <CAEemH2cT76bRmeQQPQrALUjjK9VNaGRLY4jOYPNrMjkA4FF7_g@mail.gmail.com>
 <CADS1e3dkYtRibN7ADGh_c9T5uZ4BFTpjgPaXH1+xfBUS8xpKcA@mail.gmail.com>
 <87ilw2ccgv.fsf@suse.de>
 <CADS1e3dEh6YAnWmhizVpkuN_EAqwDOeeVnfT_C23mzN2LS-2XA@mail.gmail.com>
 <YbMurQKsabIfCOMu@yuki>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Dec 2021 08:50:25 +0000
In-reply-to: <YbMurQKsabIfCOMu@yuki>
Message-ID: <87pmq0ajnw.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> Yes, we would have to remember what we mounted. I think the part I am most
>> curious about is how we would generate that state i.e what we mounted,
>> because the Cgroup library does not expose any of this as far as I'm aware.
>> 
>> If we want to use the tst_cgroup C lib to cleanup as well we would have to
>> find a way to reintroduce test state to the lib that we are losing between
>> calls of the utility, which the only way I could think of is introducing a
>> way to export and import test state within the lib. e.g.
>> tst_cgroup_print_test_state() tst_cgroup_load_test_state(), which doesn't
>> feel good as it exposes some of the nice API you have going on. This
>> is the

struct tst_cgroup_opts and tst_cgroup_print_config could be
extended. These are presently only used for debugging IIRC.

BTW don't worry about the purity of API too much or how it's implemented
to begin with. The current API is nice, but that is only after a lengthy
review process.

>> easiest way to tell if we are mounting things because we can just print
>> what we mounted, what the test dir of the test is, and reload that state.
>> This could have further applications to not just this scenario but also to
>> scenarios where if a test dies its state can be reloaded, etc, almost in a
>> checkpoint way. Not saying its common but adds some flexibility to the API
>> and I could see it having applications outside of this utility.

Perhaps, but if a test dies then we usually assume a kernel bug happened
and abort. In the future we want tests to be able to restart the system,
but we don't have concrete information about such scenarios.

>> 
>> Alternatively we could inspect what we created and generate state that way,
>> i.e. make a call to tst_cgroup_require() and see if new things were
>> mounted. Then we would have to manually be freeing things. I don't like
>> this approach because it goes against the whole point of this which was
>> code reuse. But the cleanup of things isnt the most difficult part so it
>> wouldn't be the biggest deal to redo the logic.

We have to save the PID (or some kind of test ID) that is used to
identify the CGroup. So may as well save what CGroups we created as
well.

>> 
>> Yes, sounds good.
>> >
>> >
>> Let me know what you think. I wouldn't want to add anything huge to the API
>> without your blessing :)
>
> Wouldn't it be easier to rewrite these test to the C then? I think that
> error handling in shell CGroup tests would always be more difficuilt
> than in C and given that we have a nice library for C it actually sounds
> like a better solution.

Yeah, I would prefer C in general. I'm not sure what is the path of
least resistance though.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
