Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA064C433F5
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 12:39:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93D273C9A48
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 14:39:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E03413C07B7
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 14:38:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 567D810009E4
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 14:38:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7AD2B210EB;
 Mon, 28 Mar 2022 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648471138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8IUprMlwUdd+yKfKL3NvuiFa1MqijO3nohmm2i/Tdc=;
 b=QFN04wYldH++RhtQj5LH2AWaLuAQ4T0RivomRwHGj32Oe8BB+ZIh6GVWRxXG/lX/SGL3Cs
 JmhEK+TSw244hC7COV9gt9RS18VGiaVMi5F2jT+i9+zRUE/o95awxV19lJMcGxExFnvpoR
 iNVoupl6uh44oT9+RbFu0SlBiJtOM4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648471138;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8IUprMlwUdd+yKfKL3NvuiFa1MqijO3nohmm2i/Tdc=;
 b=aBdjoZUoJlV2NCly7a6BcnDQURrYVKEc1txQYfraYuNtth8ObMfAOaooUuMhYaPnM0blVh
 EW5Nvl6K22ouQhAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6090313215;
 Mon, 28 Mar 2022 12:38:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8z5pF2KsQWJJAgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 28 Mar 2022 12:38:58 +0000
Date: Mon, 28 Mar 2022 14:41:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YkGs7Zf0dfCPkGwg@yuki>
References: <20220325040057.544211-1-liwang@redhat.com> <Yj2V2fu/3Zzio3TZ@yuki>
 <CAEemH2fVf8tMbY4R_O-BrSy7vtmyGgNq3NbYF=LfjyHDbDgkBg@mail.gmail.com>
 <YkF4pVQXMqEO32r2@yuki>
 <CAEemH2dSkAFF6Mh7m=o9Ejnut9iKT-Ud=Wm10+98-1BT9w+TPA@mail.gmail.com>
 <CAEemH2eSWor_gpVv=vpXCz0+9bt6xK5+2H4zjg66Y=yVPeS1Mg@mail.gmail.com>
 <CAEemH2e4d1RicxROvxgY79GYnL9kAx88oyBZ03N7s6GuyGFX-A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2e4d1RicxROvxgY79GYnL9kAx88oyBZ03N7s6GuyGFX-A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clock_gettime04: set threshold based on the clock
 tick rate
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Eirik Fuller <efuller@redhat.com>,
 Waiman Long <llong@redhat.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Thinking of it again I think that:

- the COARSE clocks runs on jiffies, the rest of the clocks may use high
  resolution if available

- we need two deltas, one for the coarse clocks and one for the rest

- the delta should generally be clock resolution + epsion (5ms)

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
