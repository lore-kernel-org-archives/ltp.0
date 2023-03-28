Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238FEC76195
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 10:40:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC39D3CCBA2
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 12:40:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E29C3CA2F9
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 12:39:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 85EA12009F9
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 12:39:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6BC92219CE;
 Tue, 28 Mar 2023 10:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679999993;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GwzGOMbfgCaLSqbGaB0hREirR6jzpycHNQBwCJTZ0Vo=;
 b=n4g0RE4quTXQMaq8NN4Kvdzt97hCtWcG80o69zsXeavTtXAJZpRvbRKjGAVcFQvtdQc2RH
 jEYNES3fyR1KhZwCwEyayZ0dMVRu5ONTQUCaGXZFSxFSaFijA8Xc8j+kuJDoqd6Iqobo5b
 Qj9o6G+w2OGg4LwjcKWpXk2R+Nrmiz8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679999993;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GwzGOMbfgCaLSqbGaB0hREirR6jzpycHNQBwCJTZ0Vo=;
 b=Qt9sHw9aRzWDNqOs0fjBEjzLIcZ6uPgPMYVCeiOJWQXlxLd8OuFyLhL/S6ucUixiyIzbvU
 U/F8xHiYaY1qhVBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0D5461390D;
 Tue, 28 Mar 2023 10:39:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id znC7AfnDImRHcgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 28 Mar 2023 10:39:53 +0000
Date: Tue, 28 Mar 2023 12:39:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230328103951.GA755576@pevik>
References: <20230323121330.92244-1-paulson@zilogic.com>
 <20230324103334.GA557284@pevik>
 <CA+O3cCRGPfMP2EVigECgJ8c0Uo-yd7JUm64wSgvvgxoRqe7-Jw@mail.gmail.com>
 <CAEemH2e69a5DOq9eqJVau8YCENZchm8miOH3upQY_Pi6SUFyng@mail.gmail.com>
 <20230328081710.GB743322@pevik>
 <CAEemH2cKfGMdLHut7x5QfDkdsoX_stCzxXntei4msCRZ7PeBsA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cKfGMdLHut7x5QfDkdsoX_stCzxXntei4msCRZ7PeBsA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Added test for mmap() with MAP_SHARED_VALIDATE.
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
Cc: ltp@lists.linux.it, Paulson Raja L <lpaulsonraja@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > Li, if you don't mind, I'll merge "v2" I prepared [1] (part of
> > paulson/mmap.fixes branch in my fork). Can I add your Reviewed-by tag? As the
> > work is already done, I'd prefer to postpone the work you propose to separate
> > patch after.

> Of course yes!! Feel free to do that.

Li, thanks for your ack, merged.

> My suggestion is only to Paulson for familiarity with the patch
> contribute workflow,
> but he can get to know this by your operation too.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
