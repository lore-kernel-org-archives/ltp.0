Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645BCC433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 17:24:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 990EE3C9B3D
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 18:24:08 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 406D93C071A
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 18:24:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9D860200BCA
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 18:23:59 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 996AD1F383;
 Tue,  8 Feb 2022 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644341038;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1u+6z6yrgdIdIDBu9RT5X7g6VnS+DxeSfcG4TAkX0rw=;
 b=juNAhcagWXee0uANF+nrNt7Ci3EPNwVFT9QUFe6+kUfwhzMAidXgvlnhCZ9xBiQU3iJsA5
 VDcVAUhE/khhBOkHt1Y5vgiICUUlHUWGzHZ7z/UsufoEYhH7CYijOzTbppdLMwrp/s/RmT
 YrTY7cm0PObs/u1xT92a4O8ssHdGwo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644341038;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1u+6z6yrgdIdIDBu9RT5X7g6VnS+DxeSfcG4TAkX0rw=;
 b=P67ZxltmaERF+GTwk1JIITMcVe/pz99wnN/hZxZ/iYmbx9HtEaMRKte1BXXs5mWzt0rGhw
 RGYvjoblNuSqUhCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6436D13CF5;
 Tue,  8 Feb 2022 17:23:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BiSGFi6nAmKrYgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 08 Feb 2022 17:23:58 +0000
Date: Tue, 8 Feb 2022 18:23:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YgKnLPyjwf3netv8@pevik>
References: <20220126141152.6428-1-pvorel@suse.cz> <YfFeXoHL5iTx4QNh@pevik>
 <YgJtJeKJz9Ne+BBu@yuki> <YgKFkOUo6MXF4CX7@pevik>
 <YgKHi9eYqd35Li71@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgKHi9eYqd35Li71@yuki>
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

> Hi!
> > > I guess that fs_type_whitelist[] may be confusing but all_filesystems[]
> > > is IMHO not that much better since we use that a as base for the
> > > all_filesystem before we filter out these that are not supported. Maybe
> > > we should call it try_filesystems[] instead?
> > Well, how I understand it the main feature is to be for .all_filesystems. And
> > items of this array can be whitelisted. Thus try_filesystems does not evoke much
> > to me that it's for all_filesystems.

> > I considered to have array all_filesystems[] and .fs_type_whitelist pointer to
> > that array, but having pointer just to document things is bad idea.

> The reason why I do not think it's reasonable to name the array
> all_filesystems is that setting the .all_filesystems flag does not mean
> that the test would be run over all these filesytems. We just silently
> skip these that are not supported...

Understand. Also try_filesystems is certainly better than fs_type_whitelist.
How about default_all_filesystems or just default_filesystems?

Regardless we rename it or not, at least the comment I put in the patchset would
improve things (although you may phrase it better).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
