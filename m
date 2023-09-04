Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C853C83F2C
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 16:10:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C22B23CEBFE
	for <ltp@archiver.kernel.org>; Mon,  4 Sep 2023 18:10:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F8B63CB68C
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 18:10:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2A008140076D
 for <ltp@lists.linux.it>; Mon,  4 Sep 2023 18:10:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F04D1F74B;
 Mon,  4 Sep 2023 16:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693843823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IQPgcknrFeW1EhVAohFx0loVuUpWk0iuFZ7nruoPnZU=;
 b=vhcl7BLAbQ/Z46pf4oWF4CPGZAOuibrIJCxtiSWpJLu7KVVeDaZeZvIkoOROic6kEi6B5e
 aiC98DaWdv25nBPVzjlJYItSWMrpQK4pguRQZqa7Q3pRsj/Tqakxx++JvQYd+HD98KKhDO
 kZQyDKPOTtK7/GYnL5ui1yLl0PTWoKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693843823;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IQPgcknrFeW1EhVAohFx0loVuUpWk0iuFZ7nruoPnZU=;
 b=VvEo9TEBJ/+J60Wudod6d14NUBdcFOUMmWcAASPrxoa/HXq4xhweyZZlqtkaZdiz16kp7E
 ivyxJ4r9FCYiiUBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDE9613425;
 Mon,  4 Sep 2023 16:10:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GLvhOG4B9mRxYwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 04 Sep 2023 16:10:22 +0000
Date: Mon, 4 Sep 2023 18:11:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <ZPYBlmunkfUdV6BX@yuki>
References: <20230904145035.22939-1-mkittler@suse.de> <ZPXyE9O38JHxfiV0@yuki>
 <4508326.LvFx2qVVIh@linux-9lzf>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4508326.LvFx2qVVIh@linux-9lzf>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Use correct ioctl request for termios
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
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> But we have currently 4 tests that are all executed via both termio and 
> termios. To keep this kind of coverage we would need to duplicate all of those 
> lines. That would be 4 new test lines in total. Is that what you're 
> suggesting? I'm just asking twice because I'm not sure whether it is better 
> (but don't have a strong opinion).

Yes, as far as I can tell one test per entry is much cleaner and easier
to read.

> By the way, how would I submit an amendment here? Just submit the amended 
> commit again in the same way (I used `git send-email --
> to=ltp@lists.linux.it`)?

Yes, and you are supposed to version the commits, so add to format-patch
-v2 for second version, etc.

> And how is this merged? I saw that in another case patchwork was used? How 
> does that come into play?

Things get merged by maintainers who apply the patch to their local git
tree and then push to github. Patchwork is just a tool that monitors the
mailing list and saves a list of patches that needs review, which makes
things easier for developers as it's easy for patches to get burried in
their mailboxes.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
