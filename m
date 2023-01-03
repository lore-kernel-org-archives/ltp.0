Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E76C3DA7D
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 18:13:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB6083CDEA7
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 19:13:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 630F23C8201
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 19:13:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BE3A11A00155
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 19:13:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 96AA534421;
 Tue,  3 Jan 2023 18:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672769588;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dWPB3jza8TlUzA5+V/CWkrI/gRAViJufwWlrYxCr4Ac=;
 b=MBqqncI8JEJ6JuY/+MYLSjgMI9LQ0FDLgsTUzR28kpLLX7WAu50pkKJnYSsLguocwNL2S/
 YKQnP4gS/9bZqFnL2DMj8zSKPxEHPxd7E2PGYw52D7t79Bcs3eGpb7og6yMDV7Bg/1GxeS
 09/DNwfhh2Dc08P78UcLhHWgoB2kUBk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672769588;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dWPB3jza8TlUzA5+V/CWkrI/gRAViJufwWlrYxCr4Ac=;
 b=4ocsfIN41zCFz45zM3XuOUJ1lX3bvv2bzrC5h847apGcGVRXujISPn12LxPEWzwOFfU3kn
 pLJYKYobBYdY4yBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 773281390C;
 Tue,  3 Jan 2023 18:13:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wiF5GzRwtGOxQAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 Jan 2023 18:13:08 +0000
Date: Tue, 3 Jan 2023 19:13:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
Message-ID: <Y7RwMvU1+QUPbz59@pevik>
References: <1672132813-26636-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Y7KlxBSIvN3q576G@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y7KlxBSIvN3q576G@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] shell: Remove old kernel version check below
 3.10
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

...
> This evaluates to FLAG_PREFIX=
> => please remove the variable as it's always empty

> >  		/bin/echo "$FLAGS_SET" | while read -r FLAG_LINE ; do
> >  			/bin/echo -n "$FLAG_LINE" \
> >  				| awk -v prf="$FLAG_PREFIX" -F " |:" \
> change to:
>   				| awk -v prf= -F " |:" \

FYI I suggested:
 
>   				| awk -v prf= -F " |:" \

But you added: prf=-F (no space between =), which broke cleanup.

Fixed in af98698067.

And yes, prf variable is not needed at all, I'll try to find time to cleanup
dynamic_debug01.sh.

Kind regards,
Petr

> NOTE: I'm going to cleanup the test after you merge (/bin/echo + variables).

> With these changes:
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
