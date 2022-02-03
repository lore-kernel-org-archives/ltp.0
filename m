Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 279B7C433F5
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 11:11:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF12A3C9A93
	for <ltp@archiver.kernel.org>; Thu,  3 Feb 2022 12:11:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E0EA3C9A44
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 12:11:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B259F200991
 for <ltp@lists.linux.it>; Thu,  3 Feb 2022 12:11:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE18A1F443;
 Thu,  3 Feb 2022 11:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643886659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CfNXJJ/k3rW6x39C4BI6vvuxKwP1+8Jph9GSsSDDHgY=;
 b=NiUBYLYd4Cuy+5WTzmsRacTRRcfW0cI/qiP/mKtTFx6z/Y7yuzpwkO6aOpfc638NIrxBw4
 pKSzSqL8dWkzGU6AhN5YUDtwdqtl1hqsK7rMLQipbEIZgABqs3V3fbOMLMtAoyCiJuJVHW
 bkeoK1uVPgy/ZLUn56M7BKijo0biD2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643886659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CfNXJJ/k3rW6x39C4BI6vvuxKwP1+8Jph9GSsSDDHgY=;
 b=GeL+NDUzg8QKXoh6sSQzLvELlQE7pjN9tm9K2OM2eTtflDy9Ime6aCY5AoxQz4kV5Zl04H
 bfiN/+kUTTmyVJBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C559A1348D;
 Thu,  3 Feb 2022 11:10:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YvYlMEO4+2HabQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 03 Feb 2022 11:10:59 +0000
Date: Thu, 3 Feb 2022 12:12:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Message-ID: <Yfu4ucYOvXbOqXYt@yuki>
References: <YfpnVfrto4Elshy5@pevik>
 <Yfp49PCW9Res5gXG@t14s.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yfp49PCW9Res5gXG@t14s.localdomain>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] SCTP tests in LTP vs. on github.com/sctp
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
Cc: Xin Long <lucien.xin@gmail.com>, Neil Horman <nhorman@tuxdriver.com>,
 Vlad Yasevich <vyasevich@gmail.com>, linux-sctp@vger.kernel.org,
 Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > SCTP tests lksctp-tools [1] are also in LTP [2].
> > IMHO it's not worth to have it on both places.
> 
> Agree. I wasn't aware of the copy in LTP, btw.
> 
> A question I have now is, is getting more exposure because it is in
> LTP? As in, does it get executed periodically by bots somewhere?

Generally I think that not many run the LTP network tests, but it seems
that the intel 0-day has at least a job definition for the LTP sctp
tests:

https://github.com/intel/lkp-tests/blob/3fece75132266f680047f4e1740b39c5b3faabbf/jobs/ltp-stress.yaml

Not sure how often of if they even run it though.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
