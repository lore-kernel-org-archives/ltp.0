Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD89AC46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 21:22:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 169773CEE68
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 22:22:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 486BE3CE1FB
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 22:22:42 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::ac;
 helo=out-172.mta0.migadu.com; envelope-from=kent.overstreet@linux.dev;
 receiver=lists.linux.it)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2379F1000DB3
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 22:22:41 +0100 (CET)
Date: Wed, 24 Jan 2024 16:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1706131359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FAfZf4WauMLfm02HdS1GROulAHJclOyFghcU0MJC4oQ=;
 b=YDr4q4pwhY278KZ3Ilmr3SqMJeQIYTV2dsV4d9PzCbHgjcSQJEHD6W2VKiaBWb90cno89i
 JHGcOqe2UK4H84DHmNxtfUfbLG7VroLR1K+IFdwZaJ5gs3YB7bj+BtGtTujWnZdQnVbdyk
 b+ZHM+80j+6cb1uctbVFpXLG0h9+WmY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <5ykyohhnlc7nkbz7usc5sqmluyl7wgyhc6frqmbo5kk4vhuu3c@kgzze4c35gsv>
References: <20240124200032.GA343522@pevik>
 <20240124205149.GA268968@fedora-laptop>
 <20240124210738.GA352616@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240124210738.GA352616@pevik>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] bcachefs fails to mount loop device on kernel
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
Cc: linux-bcachefs@vger.kernel.org, Brian Foster <bfoster@redhat.com>,
 Thomas Bertschinger <tahbertschinger@gmail.com>, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jan 24, 2024 at 10:07:38PM +0100, Petr Vorel wrote:
> > On Wed, Jan 24, 2024 at 09:00:32PM +0100, Petr Vorel wrote:
> > > Hi all,
> 
> > > bcachefs fails to mount loop device on kernel on both 6.7 and 6.8.0-rc1.
> > > Is mounting loop even supported?
> 
> > > [...]
> 
> > > bcachefs mount /dev/loop0 /mnt
> > > => Unknown command mount
> 
> > What version of the bcachefs CLI tool are you using? Is it distribution
> > provided or did you build it yourself?
> 
> Official openSUSE Tumbleweed package:
> 
> $ rpm -qf $(which bcachefs)
> bcachefs-tools-1.4.0-1.1.x86_64

Sounds like Suse isn't building with our Rust code - but, that's about
to become mandatory...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
