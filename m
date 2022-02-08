Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B5DC433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 15:00:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 68CFE3C9B80
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 16:00:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57B2D3C9B28
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 16:00:35 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5E420200BBE
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 16:00:34 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5F1CA210E5;
 Tue,  8 Feb 2022 15:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644332434;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Chh2Bg1sIq00SsGssmnenyei4Ru6N6p7DxE+u4no4Y8=;
 b=b/n9yL2RHuTVx3AvoDdIhyhxkEdk8H1ttkucSYrX3Gqt3QpQlFu/PCkf5Y0q9G9U7KtB2t
 Ia39teW6qmPBiSQu1oEqTrQeM9HbwrM+Z/p8ecR8ic6G8ImXJnfNj/4UHXr1vhTkS+IJ+3
 6+rdvgJevrJP5KrHC2ZMjaw++WBmBUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644332434;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Chh2Bg1sIq00SsGssmnenyei4Ru6N6p7DxE+u4no4Y8=;
 b=Lq1oZ1f7BU8WWr3D2XO5kGH9uGPjnaehkXUGtu9Mi5Q0UBZ5RNWqZP4Y8xLDcXWpU2w14Y
 O4gFCaFJ7OlTYiCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3198113CBF;
 Tue,  8 Feb 2022 15:00:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UyDNCZKFAmKrFgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 08 Feb 2022 15:00:34 +0000
Date: Tue, 8 Feb 2022 16:00:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YgKFkOUo6MXF4CX7@pevik>
References: <20220126141152.6428-1-pvorel@suse.cz> <YfFeXoHL5iTx4QNh@pevik>
 <YgJtJeKJz9Ne+BBu@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgJtJeKJz9Ne+BBu@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Rename array used for .all_filesystems
 flag
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

Hi Cyril,

> Hi!
> > > Although fs_type_whitelist[] is also used for whitelisting with
> > > .skip_filesystems, the main purpose is to be used for .all_filesystems.

> > > Thus rename it to all_filesystems[].

> > NOTE: the main purpose of this change is to increase code readability.
> > https://lore.kernel.org/ltp/CAEemH2fNfFes-eUtiQKX9JJxqEQUQ+O5nWQM8G-yNyTo8sxviw@mail.gmail.com/

> > That's why I added doc.

> I guess that fs_type_whitelist[] may be confusing but all_filesystems[]
> is IMHO not that much better since we use that a as base for the
> all_filesystem before we filter out these that are not supported. Maybe
> we should call it try_filesystems[] instead?
Well, how I understand it the main feature is to be for .all_filesystems. And
items of this array can be whitelisted. Thus try_filesystems does not evoke much
to me that it's for all_filesystems.

I considered to have array all_filesystems[] and .fs_type_whitelist pointer to
that array, but having pointer just to document things is bad idea.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
