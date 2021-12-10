Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384D6C433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 10:39:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF6F63C8264
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 11:39:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DC383C1D2E
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 11:39:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 46638600803
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 11:39:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 376E11F3A0;
 Fri, 10 Dec 2021 10:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639132765; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qnwD3NsePZviFFYypWGtnOanaZND5WHOuDeQ1ojqwUs=;
 b=U7m077A2GhZ/A/71bXLK5P61iZ7o5f0ReR36x3z1ZzJBgulrDnYMxZ3qPsFazbexSo3emS
 09lVfF1BAEAkzdUcdx2PEdzqbURasKctlgn0tQDIYWaidv2CY9PSb9/0jUpIsNOvhbhOOb
 Xxvz+HLw6L5PS3xChLbg7jcLCnpWzAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639132765;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qnwD3NsePZviFFYypWGtnOanaZND5WHOuDeQ1ojqwUs=;
 b=PiKiYgfZlMWCmsoF2HM7eIdozJkM2yLbBUUKVtfKncjvXCkpA/n4jHBeNCq2ogYthhwpn1
 2mfisHDXdsgBsoBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14D4A13C1D;
 Fri, 10 Dec 2021 10:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WwsZA10us2GDVQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Dec 2021 10:39:25 +0000
Date: Fri, 10 Dec 2021 11:40:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Message-ID: <YbMurQKsabIfCOMu@yuki>
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
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADS1e3dEh6YAnWmhizVpkuN_EAqwDOeeVnfT_C23mzN2LS-2XA@mail.gmail.com>
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Yes, we would have to remember what we mounted. I think the part I am most
> curious about is how we would generate that state i.e what we mounted,
> because the Cgroup library does not expose any of this as far as I'm aware.
> 
> If we want to use the tst_cgroup C lib to cleanup as well we would have to
> find a way to reintroduce test state to the lib that we are losing between
> calls of the utility, which the only way I could think of is introducing a
> way to export and import test state within the lib. e.g.
> tst_cgroup_print_test_state() tst_cgroup_load_test_state(), which doesn't
> feel good as it exposes some of the nice API you have going on. This is the
> easiest way to tell if we are mounting things because we can just print
> what we mounted, what the test dir of the test is, and reload that state.
> This could have further applications to not just this scenario but also to
> scenarios where if a test dies its state can be reloaded, etc, almost in a
> checkpoint way. Not saying its common but adds some flexibility to the API
> and I could see it having applications outside of this utility.
> 
> Alternatively we could inspect what we created and generate state that way,
> i.e. make a call to tst_cgroup_require() and see if new things were
> mounted. Then we would have to manually be freeing things. I don't like
> this approach because it goes against the whole point of this which was
> code reuse. But the cleanup of things isnt the most difficult part so it
> wouldn't be the biggest deal to redo the logic.
> 
> Yes, sounds good.
> >
> >
> Let me know what you think. I wouldn't want to add anything huge to the API
> without your blessing :)

Wouldn't it be easier to rewrite these test to the C then? I think that
error handling in shell CGroup tests would always be more difficuilt
than in C and given that we have a nice library for C it actually sounds
like a better solution.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
