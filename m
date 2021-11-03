Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8726CC433F5
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 16:13:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E25BE610A8
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 16:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E25BE610A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 51FEB3C72C6
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 17:13:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0409E3C6BD9
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 17:13:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2BAED1001532
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 17:13:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24470218D9;
 Wed,  3 Nov 2021 16:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635956023;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3bTowwt5/5FwY7SC7Z7E2G8TBByJ4VGdF4azpNrDENU=;
 b=T7A2QQNugZkq0mPriLjHnqcNU5MZ9XIBAoAlnlDPGoicll4r8McX8fnQLAS3gArwc6QHy/
 ybAI0KZkollWMNe2lp8qt4066uya90o/gqi2/8UZB0DcuKpvTdtgWeYIfX2P0REZMcvhXY
 4nqdeO1HUymOxec3eLx9NPrZq/TMhNw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635956023;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3bTowwt5/5FwY7SC7Z7E2G8TBByJ4VGdF4azpNrDENU=;
 b=BIGJPluqIwlb2FEe0penCvEqc/62ILWuThez3GOXABfC79DWq9HQraa+6cu6GvLdK1TZaz
 GkB5kBg3TyHhpxBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C7F9513C91;
 Wed,  3 Nov 2021 16:13:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1NP2Lja1gmHKUAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 03 Nov 2021 16:13:42 +0000
Date: Wed, 3 Nov 2021 17:13:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YYK1NQ+wPqzOsK9P@pevik>
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-2-krisman@collabora.com>
 <YYEgqgFoo7oJheFr@google.com>
 <CAOQ4uxiZetvK=r-tedgqNXR4nT=+kWUG5eVRWu8wVUQY5PN0Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiZetvK=r-tedgqNXR4nT=+kWUG5eVRWu8wVUQY5PN0Ew@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/9] syscalls: fanotify: Add macro to require
 specific mark types
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
Cc: kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>,
 Gabriel Krisman Bertazi <krisman@collabora.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Tue, Nov 2, 2021 at 1:27 PM Matthew Bobrowski <repnop@google.com> wrote:

> > On Fri, Oct 29, 2021 at 06:17:24PM -0300, Gabriel Krisman Bertazi wrote:
> > > Like done for init flags and event types, and a macro to require a
> > > specific mark type.

> > > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > > Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > > ---
> > >  testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
> > >  1 file changed, 5 insertions(+)

> > > diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> > > index a2be183385e4..c67db3117e29 100644
> > > --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> > > +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> > > @@ -373,4 +373,9 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
> > >       return rval;
> > >  }

> > > +#define REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type) do { \
> > > +     fanotify_init_flags_err_msg(#mark_type, __FILE__, __LINE__, tst_brk_, \
> > > +                                 fanotify_mark_supported_by_kernel(mark_type)); \
> > > +} while (0)
> > > +
> > >  #endif /* __FANOTIFY_H__ */

> > A nit, but I'm of the opinion that s/_ON_/_BY_ within the macro name. Otherwise,
> > this looks OK to me.

> Agreed. You can change that while cherry-picking to your branch ;-)

+1. And yes, I'll change it while applying it into LTP (no need to repost).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
