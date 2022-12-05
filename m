Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A29C4321E
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 11:04:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 915C73CC215
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 12:04:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDEC73CA93B
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 12:03:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4F17814A1E42
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 12:03:57 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E79222A75;
 Mon,  5 Dec 2022 11:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670238237;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZjewXIjuyqSfxLRbROJNRMxFCg6skwy3pM5Ov23KwTE=;
 b=zyTkWr+AhDuBTyRc7uXh+kCK3We84Us607EedNSn5C/i8xUFMfAzlhZCLcGFjbGwOoGiby
 TDjZxvZFwjaymS57dHOQJfYLfEWBuHhNI8kiEGntHisEm6ysXPFnlyUGwGmHeGhNauvS4Z
 hgut8nEtyTqYKSZ5WW8nbSAUFEA29tI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670238237;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZjewXIjuyqSfxLRbROJNRMxFCg6skwy3pM5Ov23KwTE=;
 b=zhHmAVu0hkxqB21oWvwCRjroRhNBTrEsgwVseuaFQQVsCsXARJisbipEUjxoe+mqilLTPx
 OcE1So/vfevx0ECw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DC56513326;
 Mon,  5 Dec 2022 11:03:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id E/MeNBzQjWMuGwAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Mon, 05 Dec 2022 11:03:56 +0000
Date: Mon, 5 Dec 2022 12:03:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Y43QGymNw5cI2Vfm@pevik>
References: <20221202103011.12206-1-andrea.cervesato@suse.com>
 <Y4oFOSgPd+2lxVWx@pevik>
 <32dc63af-0d95-31cc-4dcc-9b2d89d74edd@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <32dc63af-0d95-31cc-4dcc-9b2d89d74edd@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add runltp-ng to upstream
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi Petr,

> On 12/2/22 15:01, Petr Vorel wrote:
> > Hi Andrea,

> > > runltp-ng is the next generation runner for Linux Testing Project and it
> > > will replace the current obsolete runltp script in the next future.
> > > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > > ---
> > >   .gitmodules     | 3 +++
> > >   tools/runltp-ng | 1 +
> > >   2 files changed, 4 insertions(+)
> > >   create mode 160000 tools/runltp-ng
> > > diff --git a/.gitmodules b/.gitmodules
> > > index a3c34af4b..e85fc6279 100644
> > > --- a/.gitmodules
> > > +++ b/.gitmodules
> > > @@ -4,3 +4,6 @@
> > >   [submodule "tools/sparse/sparse-src"]
> > >   	path = tools/sparse/sparse-src
> > >   	url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git
> > > +[submodule "tools/runltp-ng"]
> > > +	path = tools/runltp-ng
> > > +	url = https://github.com/acerv/runltp-ng
> > > diff --git a/tools/runltp-ng b/tools/runltp-ng
> > > new file mode 160000
> > > index 000000000..b08471158
> > > --- /dev/null
> > > +++ b/tools/runltp-ng
> > > @@ -0,0 +1 @@
> > > +Subproject commit b0847115891bd3dddbe920a716342917e7088379
> > Thank you for this submission! Finally we get close to adding runltp-ng :).

> > I've tested runltp-ng separately last few weeks, next week I'll do more testing
> > of b0847115891bd3dddbe920a716342917e7088379. BTW there are 2 more commits in
> > your master.

> > The integration: What I can see now is that it requires to run "git submodule
> > update --init" by user. Looking at tools/sparse/Makefile. sparse is specific
> > (not needed unless make check is evoked), therefore sparse is not installed if
> > not needed (make in tools/ does not init the submodule).

> > Maybe we could add in tools/Makefile add:
> > git submodule update --init runltp-ng/
> > That would update only runltp-ng submodule.

> Yes, submodules are not intuitive and it would be better to add code inside
> the LTP upstream.

> > I suppose there is a reason to deliver the tool separately (without LTP),
> > e.g. separate development or used on systems, which use LTP built into distro
> > package (we already use it in SUSE this way). In that case I'd be for moving the
> > repo to LTP github (https://github.com/linux-test-project/runltp-ng).

> > We could also add it directly to LTP git repository (no submodule), because also
> > for the above case (packaging) is a simple solution using just single
> > repository: there could be two separated packages: ltp and runltp-ng.

> > Otherwise to be part of LTP git repository
> > add code directly to tools/runltp-ng/.
> As far as I know, community wanted runltp-ng to be part of LTP, but at this
> stage it's probably too early (?).

IMHO it's already mature enough. I'm not sure if there is any important enough
runltp feature which it miss, but your code is obviously huge improvement over
legacy runltp.  Also you fixes various things I reported really quickly, thus I
expect you fixes any major issue in reasonable time.

Kind regards,
Petr

> > Kind regards,
> > Petr

> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
