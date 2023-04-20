Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8214EC77B73
	for <ltp@archiver.kernel.org>; Thu, 20 Apr 2023 08:49:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDE393CBFAC
	for <ltp@archiver.kernel.org>; Thu, 20 Apr 2023 10:49:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 347993CAC3E
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 10:49:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 61AC16007B9
 for <ltp@lists.linux.it>; Thu, 20 Apr 2023 10:49:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 28A0B1FDB9;
 Thu, 20 Apr 2023 08:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1681980575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/llZfKgJYxwzIQ8WRBs+dx78W0LbRqL8gI9R/YuKgY=;
 b=kp4C88eqgfi2cXG3IIk4MANzaY9eBBxWusCKI0WXbTxL73jQtC0XzAvlJIqQ8t8zcjNJxW
 yds0bznA2WVkHU9R7to+QdZUL37jEcucAVFdeFADi02Xm4jxzaQayoAV1872oQNZnN8Iql
 3mCoFUwrcnUv1P0dbfQVdBQ9BRfMF4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1681980575;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/llZfKgJYxwzIQ8WRBs+dx78W0LbRqL8gI9R/YuKgY=;
 b=wBvzFdCiAObNf/OJPJhXk+KUmdxVT1cdJkuZH4b27jEu6igd47IHBxO5gemsOxTO/HfdwR
 A8/Ne5tyGI5X1GBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14C231333C;
 Thu, 20 Apr 2023 08:49:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9AE6BJ/8QGRtegAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 20 Apr 2023 08:49:35 +0000
Date: Thu, 20 Apr 2023 10:50:38 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <ZED83l2ke1whTc4E@yuki>
References: <20230418130944.181716-1-teo.coupriediaz@arm.com>
 <ZD/JxunXsz7Lms9U@yuki>
 <CAEemH2caEaXVzrgVD70VvvnVYRvo4BLRs1GvbMJutma9p-OW1Q@mail.gmail.com>
 <b589a29f-98e5-b3dc-530b-af3a2a1207d2@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b589a29f-98e5-b3dc-530b-af3a2a1207d2@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setpgid02: Use pid_max as PGID for EPERM
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The mechanism is indeed different. My first approach to this patch was =

> to fork and setsid() the child, which
> implied an EPERM due to the session difference.
> However, when discussing this approach on the mailing list (see =

> https://lists.linux.it/pipermail/ltp/2023-April/033505.html )
> it was brought to my attention that setpgid03 is in fact doing exactly =

> that already.
> =

> Knowing that, I didn't feel it would be worthwhile to add such a case in =

> setpgid02.
> =

> However, I spent more time looking at the code on the kernel side =

> prompted by your remark and I think
> that setpgid03 is going through another path:
> =

>  =A0=A0=A0 if (same_thread_group(p->real_parent, group_leader)) {
>  =A0=A0 =A0=A0=A0=A0 err =3D -EPERM;
>  =A0=A0 =A0=A0=A0=A0 if (task_session(p) !=3D task_session(group_leader))
>  =A0=A0 =A0=A0=A0=A0 =A0=A0=A0 goto out;
> =

> So it might indeed make sense to add another case in setpgid02.
> =

> Would initializing a pty be necessary though ? Could it be simply =

> achieved by spawning a child that
> setsid() itself, and try to setpgid the parent to the child PGID ? =

> (Rather than setpgid the child as in setpgid03)

Right, no need for a tty, we can just change the session.

> Maybe it would make sense to add that case to setpgid03 rather than =

> setpgid02, as setpgid03 already has
> the necessary scaffolding ?

That would be the best, we can simply add TST_EXP_FAIL() to the
do_child() in setpgid03. However please make sure to update the test
descriptions in both tests.

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
