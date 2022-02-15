Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B1FC433EF
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 09:39:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EC7B3CA01A
	for <ltp@archiver.kernel.org>; Tue, 15 Feb 2022 10:39:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FFFF3C97C3
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 10:39:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CA64B100113E
 for <ltp@lists.linux.it>; Tue, 15 Feb 2022 10:39:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA2F2210EF;
 Tue, 15 Feb 2022 09:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644917951;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B6MO+8u/H3AQtTfxg+Ox3/yFEnQn2airNiALct7PmDA=;
 b=tmvGGViUn+Y+FBW8xEqxbjHinFqlIujKWtrr94Vx12Qv5FHP14W+FhcCXa0/pgv9d7eeXq
 USseqGQj0YQ6qqMb9aGG7D84GO4WRqJOzgwHx1Z3FHp7vAlFMnGPIXUGMDMla+GlnKiR2y
 gZVx9LYLPh9H8WogGPhd+DF+N0/TSVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644917951;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B6MO+8u/H3AQtTfxg+Ox3/yFEnQn2airNiALct7PmDA=;
 b=9CvZ2ZyYQx5C/oQAdJUth2Vt0JN4fuuJqbcwOEJ3f3wGtWDw12ATetDGpSumm/INytNU27
 JSAvdcwQcAaZcSDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9ABD513C36;
 Tue, 15 Feb 2022 09:39:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZQvsI790C2LmBAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 15 Feb 2022 09:39:11 +0000
Date: Tue, 15 Feb 2022 10:39:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Ygt0vbPsoGc8gIsy@pevik>
References: <20220214165129.32686-1-mdoucha@suse.cz>
 <CAEemH2c=+3_HBez0Pn6Yyx+v4PXJpwD3HZtPt87BR6AohtKvUw@mail.gmail.com>
 <ec14e0ce-21fe-43bf-a8fb-15b2ccd97c8a@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ec14e0ce-21fe-43bf-a8fb-15b2ccd97c8a@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_children_cleanup.sh: Fix race condition
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 15. 02. 22 5:30, Li Wang wrote:
> > It doesn't work for all platforms and we can not guarantee how long it =
will
> > cost before PID 1 reaps zombie process.

> > Also, I just get to know that =A0Docker does not run processes under a
> > special init process that properly reaps child processes, so that it is
> > possible for the container to end up with zombie processes that cause
> > all sorts of trouble.

> > I even try adding `kill -SIGCHLD 1` but does not work as expected.

> > See CI jobs:
> > =A0=A0https://github.com/wangli5665/ltp/runs/5194270998?check_suite_foc=
us=3Dtrue
> > <https://mail.google.com/mail/u/1/%E2%80%8Bhttps://github.com/wangli566=
5/ltp/runs/5194270998?check_suite_focus=3Dtrue>

> > Therefore, I suggest giving a chance to my refined patch V2 :).

> When I was testing the libtest yesterday on a moderately stressed
> machine, I actually saw the child process still in the R state during
> the first state check a couple of times. That's why I've added looping
> with delay.

> On the other hand I did not see any zombies even after several hundred
> tries. But I can add a zombie check to my patch a well.
I'd be for it. As Li noticed, containers behave really differently
(maybe it'd be faster to debug tests using podman).

Kind regards,
Petr

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
