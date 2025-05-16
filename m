Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DA7C3ABD8
	for <ltp@archiver.kernel.org>; Fri, 16 May 2025 12:13:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD6953CC5B2
	for <ltp@archiver.kernel.org>; Fri, 16 May 2025 14:13:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86EB43CC505
 for <ltp@lists.linux.it>; Fri, 16 May 2025 14:12:45 +0200 (CEST)
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D138E1400E6F
 for <ltp@lists.linux.it>; Fri, 16 May 2025 14:12:44 +0200 (CEST)
Received: from r6.localdomain (82-217-174-174.cable.dynamic.v4.ziggo.nl
 [82.217.174.174])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by gnu.wildebeest.org (Postfix) with ESMTPSA id 7708E3021E80;
 Fri, 16 May 2025 14:12:43 +0200 (CEST)
Received: by r6.localdomain (Postfix, from userid 1000)
 id 2FCB93405BA; Fri, 16 May 2025 14:12:43 +0200 (CEST)
Message-ID: <1579a022f9ea78ae74060c03d10a8e1601f1af80.camel@klomp.org>
From: Mark Wielaard <mark@klomp.org>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 16 May 2025 14:12:43 +0200
In-Reply-To: <20250516120943.GA303097@pevik>
References: <20250516075113.522145-1-pvorel@suse.cz>
 <aCb7Pi6Vgkc8OMja@yuki.lan> <20250516093129.GG12775@gnu.wildebeest.org>
 <20250516120943.GA303097@pevik>
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] valgrind-announce: Update valgrind ML
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
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it,
 Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr, Hi Cyril,

On Fri, 2025-05-16 at 14:09 +0200, Petr Vorel wrote:
> > On Fri, May 16, 2025 at 10:45:50AM +0200, Cyril Hrubis wrote:
> > > > valgrind-developers has heavy traffic, use valgrind-announce.
> 
> > > Was this requested by valgrind devs? I suppose this is fine as long as
> > > we get their ack.
> 
> > I think valgrind-developers is a better place for announcing new
> > versions of LTP.  We can then update our own valgrind testing.
> > valgrind-announce is really for users when valgrind itself has a new
> > release.
> 
> Sure, let's keep valgrind-developers. Thanks for feedback.
> 
> I would consider it disturbing for myself to need to subscribe on
> valgrind-developers before the release and unsubscribe then, but
> it's Cyril who is going to send the announcement mail anyway.

You don't really need to subscribe tp valgrind-developers. If you
aren't subscribed then the message goes to moderation and will normally
be approved within a day (and the sender is normally added to the
approved list). I think this is similar to the ltp list (I am not
subscribed, but seem able to post anyway).

Cheers,

Mark

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
