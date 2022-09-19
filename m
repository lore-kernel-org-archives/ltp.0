Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE11C6FA92
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 08:48:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EE463CACBB
	for <ltp@archiver.kernel.org>; Mon, 19 Sep 2022 10:48:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1862D3CA493
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 10:48:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7C4DB60077A
 for <ltp@lists.linux.it>; Mon, 19 Sep 2022 10:48:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B3A3E223AC;
 Mon, 19 Sep 2022 08:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663577313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/OjoSu6MI4nDtDiTfv0aa4sS5v9AXdP7frCIIVlAJ4=;
 b=B1nHw+4LDEh6TOUwn4GpchLdLl7RtYY7DHs1uQhYhELBtbuxnQSVGcu2PfzNShdvKfXMJ5
 BsZIbj4i37HQHryIGjjdHbfhb4tK6LBsQyjnqleBDpeeUb1RKN69qWJ5HbULtsxAwJUuiO
 +PfigurXaNjv6AdiGb0y75K2h1UaYi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663577313;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/OjoSu6MI4nDtDiTfv0aa4sS5v9AXdP7frCIIVlAJ4=;
 b=GXa0Vy6hKROohKlMPS9/rpuUGQUaLjXQg2Ai36R6NeA+iyI2aXilIr/iEOiBRiz/1q3Mx7
 HDYYROx549X1iJBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 94FAE13A96;
 Mon, 19 Sep 2022 08:48:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3WhTI+EsKGNeQwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 19 Sep 2022 08:48:33 +0000
Date: Mon, 19 Sep 2022 10:50:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YygtVhacmMRTPg41@yuki>
References: <010001834b528ae5-11a8d4c7-4e72-4f8d-af66-e9ec2a864017-000000@email.amazonses.com>
 <YyfeaeMsvACB5dcf@pevik>
 <CAEemH2ddod62+jkLjvxbNAwPxF8DrVGcyH3fKEJfkLrGaLZJng@mail.gmail.com>
 <CAEemH2cLKhrE5SVjfd5Got3adf9+C0dJeuP-qY_r98fDUr2gMQ@mail.gmail.com>
 <YygoFpOWW4Cuh2BB@yuki>
 <CAEemH2f=BQ3bdfKgPQzSYZjkTAx5mptptA31ToSTWzu-GQ1ovw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2f=BQ3bdfKgPQzSYZjkTAx5mptptA31ToSTWzu-GQ1ovw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for cea142b
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
Cc: Martin Doucha <martin.doucha@suse.com>, lkft@linaro.org,
 lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Separate timeouts for setup/cleanup will break the integrity of
> setting functions, my concern is that if tst_pollute_memory stopped
> in uncompleted, the main test part is meaningless, right?
> 
> Or, I may misunderstand you here.

The more we pollute the higher probability is that we hit a piece of
memory that contains non-zero bytes. That's why Martin is reluctant to
stop polluting memory prematurelly.

And separating the timeout for setup/cleanup is of-course only part of
the solution. We can make the test setup smarter by measuring the
pollution speed and aborting early if it's too slow too, but let's
discuss that once we are done with the release.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
