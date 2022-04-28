Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A963C433EF
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 06:43:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE6F73CA6DE
	for <ltp@archiver.kernel.org>; Thu, 28 Apr 2022 08:43:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BBD33CA684
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 08:43:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 49C4F601370
 for <ltp@lists.linux.it>; Thu, 28 Apr 2022 08:43:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C566210EE;
 Thu, 28 Apr 2022 06:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651128198;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Btecj7aZ/YvfDVN4DvL6SQ2TbCldwxc2hz1kaLS55l0=;
 b=TbgwvBH1wBI9kvt4ZvtpgddQSaKbcRqSFgLcV0rV4xdqMX6vuidW+1agxobI8R9qfHkH3b
 eLK0AgIyh/RDD317oiPVkgb/Sn/o3Rjyo9AL1uooktSiiLscSLyViUkQYzEbco2iE9yIhA
 weiMOk2IEvJhN4iZiopD1fBWEUqbkSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651128198;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Btecj7aZ/YvfDVN4DvL6SQ2TbCldwxc2hz1kaLS55l0=;
 b=4WNw/LzNDIfgUZ1H1g+EQ7PKWa1OZumbP46smWU9VmZwDX1thNrwvRQUuFwt+r5ZgZ9sFR
 LEF3rlRdAviNU6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FBA613A8C;
 Thu, 28 Apr 2022 06:43:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tFDzCYY3amJUVQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 28 Apr 2022 06:43:18 +0000
Date: Thu, 28 Apr 2022 08:43:16 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Ymo3hBI9Lu7Bnvdx@pevik>
References: <20220427083814.1100-1-chenhx.fnst@fujitsu.com>
 <YmlNmOQ2okZgpOlo@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YmlNmOQ2okZgpOlo@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/mount_setattr01: Add basic functional
 test
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

Hi all,

> > +/*\
> > + * [Description]
> > + *
> > + * Basic mount_setattr() test.
> > + * Test whether the basic mount attributes are set correctly.
> > + *
> > + * Verify some MOUNT_SETATTR(2) attributes:
> > + *
> > + * - 1) MOUNT_ATTR_RDONLY - makes the mount read-only
> > + * - 2) MOUNT_ATTR_NOSUID - causes the mount not to honor the
> > + *     set-user-ID and set-group-ID mode bits and file capabilities
> > + *     when executing programs.
> > + * - 3) MOUNT_ATTR_NODEV - prevents access to devices on this mount
> > + * - 4) MOUNT_ATTR_NOEXEC - prevents executing programs on this mount
> > + * - 5) MOUNT_ATTR_NOSYMFOLLOW - prevents following symbolic links
> > + *    on this mount
> > + * - 6) MOUNT_ATTR_NODIRATIME - prevents updating access time for
> > + *    directories on this mount

> The numbers here are useless and confusing I bet that it renders
> strangely in asciidoc too.

+1. Simple bullets done with "-" are good enough.
Some people used numbers in our docs, but I don't think it's necessary and I'd
be for removing it.

BTW if we want to use it, it'd have to be with dot (i.e. 1.).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
