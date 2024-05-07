Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B951C10F1A
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 14:17:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C44F73C990E
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 16:16:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C7913C990E
 for <ltp@lists.linux.it>; Tue,  7 May 2024 16:16:44 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.dev (client-ip=95.215.58.179; helo=out-179.mta1.migadu.com;
 envelope-from=kent.overstreet@linux.dev; receiver=lists.linux.it)
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com
 [95.215.58.179])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EBFF562D8C9
 for <ltp@lists.linux.it>; Tue,  7 May 2024 16:16:43 +0200 (CEST)
Date: Tue, 7 May 2024 10:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1715091402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d7uYYjOih6xfXmWBun4mkQeyVXiZPiV6sYGIN/5Ync4=;
 b=fJeUKJOFGMcERPeeQHQEds9mFJV5TD9DfE6OpNiASci3NGIqJ3eCUxsbI73mZhUTyIRjQD
 /UZ8hn7tpuZ/NiTckFZCWNSxgT6uXQ4CEb/rA/1fYIGT6yWX1N4CWGkQ3GQ7yqqycNMO2U
 IZNyok0zDC4qVShz0TBW8B/GFNkIyjc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <xlqa5l5si2mp3troac56tq7q3gansgi2fqs57rd2i2xrudiq34@iit2ymv4pzy6>
References: <20231207194011.273027-1-pvorel@suse.cz>
 <20231207194011.273027-4-pvorel@suse.cz>
 <20231213024617.vx3epsav2n2lxozi@moria.home.lan>
 <ZZvIBO-a1b_nIHJ8@yuki>
 <gjfjylr4bdytdot7ywjispswvgpvjtkdmtsinsbcbc42ik2y3d@ws4tjmwqywrb>
 <ZZ0guBd48WXYapPL@yuki> <ZiJtf07WGFJPb_w2@yuki>
 <20240507081846.GA97446@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240507081846.GA97446@pevik>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] statx04: Skip STATX_ATTR_COMPRESSED on
 Bcachefs
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
Cc: Jan Kara <jack@suse.cz>, Coly Li <colyli@suse.com>,
 Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, May 07, 2024 at 10:18:46AM +0200, Petr Vorel wrote:
> > Hi!
> > > > > Quite likely, other filesystems does have an inode flag that is set when
> > > > > file has been compressed and simply report that in the foo_getattr()
> > > > > callback. Looking at bcachefs I supose that we need to figure out if the
> > > > > inode is v3 and then unpack the v3 info to get to the compressed flag,
> > > > > you probably know best how to do that.
> 
> > > > I'm still not clear how we want to map STATX_ATTR_COMPRESSED, since it's
> > > > extents that are compressed, not entire files - and just reporting the
> > > > compression option is probably not what we want since it can be flipped
> > > > off, and existing data will still be compressed.
> 
> > > > Do you know anything about the intended use case?
> 
> > > As far as I understand the flag it's a hint that the file I/O may be
> > > slower/need more memory because of the compression.
> 
> > Ping.
> 
> > Kent we are getting closer to a next LTP release, are you going to add
> > the compressed flag support into bcachefs or should we add bcachefs to
> > the test skiplist?
> 
> Kent, gentle ping ^.

Add it to the skiplist for now, thanks

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
