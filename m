Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196C1FA373F
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 17:03:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 501DC3CA154
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 19:03:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26D553C04BF
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 19:03:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F0454200345
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 19:03:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B2D6E21A21;
 Mon, 24 Oct 2022 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666631001;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqpA7qGtKH2ifv5wjlrzlzBVqmzATYEJXDN8BRh+3Bw=;
 b=MaHzbcrw3SZNdL7Wq8ZEkxEbE4TaoTuspQDLYeEdvaWL/Cw2eEySc71cBIlA18lswdq/EC
 1gkYS6WwuYTQAuodarNedAGtL3kSqNDrzofV/wk3GTPCiwbIyTCrNCEVl6kMekqc6NG0Ek
 INGRCGQ0Yie5owCOyA4Yl6FPsG0Oe9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666631001;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqpA7qGtKH2ifv5wjlrzlzBVqmzATYEJXDN8BRh+3Bw=;
 b=C63ck1uln5Q97Xm6cr8psd5gPuZleUzSfi9ZLyqTuK/f1LTihkbBJl9YfiAOF1AcNfZZaC
 XqRV4wJYI+VkszCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6143E13A79;
 Mon, 24 Oct 2022 17:03:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UZ8DFVnFVmNIdgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Oct 2022 17:03:21 +0000
Date: Mon, 24 Oct 2022 19:03:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <Y1bFWLQNBWG9zsdZ@pevik>
References: <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
 <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
 <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
 <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
 <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
 <ea4fd7d6-0985-2983-d0ce-489a32a2f6dc@suse.cz>
 <CAOQ4uxib_vxncQa3RiObKYwQg0CQvPXLH+nyRckO9FVg=ihERQ@mail.gmail.com>
 <d80e2e12-899d-f0d2-27c2-f4a92f1b2be4@suse.cz>
 <Y1a6NXkayyy7esM+@pevik>
 <CAOQ4uxjGGxaa=snebi0wPnPWuFHgQ-9Mt9hPBr3wBAghGQQEJA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjGGxaa=snebi0wPnPWuFHgQ-9Mt9hPBr3wBAghGQQEJA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Add fanotify_get_supported_init_flags()
 helper function
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Mon, Oct 24, 2022 at 7:15 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi all,

> > > On 24. 10. 22 16:34, Amir Goldstein wrote:
> > > > This is how I would fix the problem:

> > > > <snip>

> > > > Give or take using more macros and your nicer flag prints.
> > > > There is no need for auto-detection of the unsupported kernel flags.

> > > > If the test case is expected to get to fanotify_mark() (i.e. non-zero tc->mask)
> > > > EINVAL from fanotify_init() always means "unsupported".

> > > This would be a good approach if fanotify_init() returned distinct error
> > > code for "flag not implemented", like ENOTSUP. But when EINVAL is returned
> > > for both "not implemented" and "wrong use", this has a risk of hiding real
> > > bugs. That's why I'm trying to detect the actual set of flags implemented in
> > > the running kernel before running the real tests.
> > Indeed, that's quite surprising (not really, it was added in 2.6.36 and remember
> > Jan Kara's talk about dnotify/inotify/fanotify history). I wonder if it's
> > possible to fix (backward compatibility would suffer).

Hi Amir,

> The kernel UAPI is not very consistent about ENOTSUP vs. EINVAL
> renameat(2), unlink(2), link(2) and other return EINVAL for unsupported flags
> fallocate(2), ioctl(2) and others return ENOTSUP for unsupported commands.
> It's not a clear cut, but ENOTSUP is generally for unsupported fs methods,
> not for unsupported options.

thanks for info, I didn't know that. Otherwise Martin's note to use ENOTSUP
would help.

> > > And since some flags may be backported to older kernels, generating feature
> > > sets based on kernel version is not a solution.
> > I guess even some not-important fix was not backported. I guess features aren't
> > backported to the stable kernel maybe to enterprise kernels (SLES, RHEL), but
> > even there I'd guess there are related patches backported, not features. But
> > maybe I'm wrong. Jan and Amir?


> I am fine with writing tests that are friendly to distros that want to backport
> features, that is not what my complaint is about.
> As I wrote to Martin, I will accept any imaginary kernel as an example
> for why the test is wrong for that kernel, but I don't see the bug.

> The desire to distinguish between "this kernel should support
> these init flags but failed" and "this kernel does not support those init flags"
> is not realistic, given that fanotify_init() return codes do not
> distinguish between those two cases.

> The suggested logic to work this out by testing flag by flags is faulty
> because of current and future flag dependencies.

> So show me a real bug, as Martin did, and we will fix it.
thanks for info. Fortunately there is no other bug, besides the one Martin
reported and is trying to fix.

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
