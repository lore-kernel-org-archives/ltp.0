Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4F3C433FE
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 16:20:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76FC93CAF35
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 18:20:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5259F3CAF35
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 18:20:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EEBDF601D1C
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 18:20:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5A2EE21ED9;
 Fri, 14 Oct 2022 16:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665764414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MAnb7Tt1/ouEziJoyLvnur4qe6Vf84WeUVap+9YbLkg=;
 b=FoUFWRlZO3go00RaE+tn+y6f0rzYjIEcDxWtLNWnqbKSGpOOmKPV5sAz5lM3hWPmfWUejI
 RtyAzySJEYcrE7nzB+38PtlyO5KmW6aE+vt+QAfl6F0qw/7yu4en08vW9VoMjd/sv5wraD
 o++Fx2OwZzGD3u+q+8HxzP0xMKpjFOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665764414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MAnb7Tt1/ouEziJoyLvnur4qe6Vf84WeUVap+9YbLkg=;
 b=usgaF531pld3AdmQQ6hOxTsXA8fK01B0KNzpU2gx6qkvP4MuJZGIS3vKvarn+9AdwtkkcT
 dfjQdQwt9IA1JcDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 043B413451;
 Fri, 14 Oct 2022 16:20:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ma2nOT2MSWPMCwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Oct 2022 16:20:13 +0000
Date: Fri, 14 Oct 2022 18:20:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Y0mMO0YkXIbG8GFu@pevik>
References: <20221013154935.20461-1-mdoucha@suse.cz>
 <20221013154935.20461-3-mdoucha@suse.cz> <Y0iMQEXsQbkNMwWf@pevik>
 <6e5e878a-d4ff-f8a5-8dc7-4bd2b99ad5a5@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6e5e878a-d4ff-f8a5-8dc7-4bd2b99ad5a5@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] Move fanotify fallback constants and structs
 to LAPI header
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

Hi Martin, all,

> OK, please update the copyright header. This patch doesn't depend on the
> first one so you can merge it right away.

Merged this one, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
