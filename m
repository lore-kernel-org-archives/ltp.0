Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C107C433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 15:29:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D54083C9872
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 16:29:05 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 483BC3C8E25
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 16:28:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2E42B140009D
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 16:28:54 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45B2E2110A;
 Tue,  1 Feb 2022 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643729334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GfiYWdDEWBXlucKI/FlqVxFPH+K0YY/SDmVUwuBamh4=;
 b=GRq4hTtiSGZAMsb2LP57/dCiI1nrKWBi4+V8MAnA/6MEnFEAhLktRIKwQMcAnMql9ujC5b
 2Ptr35uD8XFD0tnHMoLem8Tyf1GL2xaYudyoUSuYurL4kMG1MGOxki6M8CY4YM+7d9iHKV
 /pbLhWjcqiMAfcmEFgPmwbIH46LSOUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643729334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GfiYWdDEWBXlucKI/FlqVxFPH+K0YY/SDmVUwuBamh4=;
 b=ZKpZ886RhMbmZ4uTfxvEeVAf2XWtYL13zdOG1NE2ThDZBZZNqyXkB6kvoo39lmkmLlQjj7
 F3gCSB7kC+5JquCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0823913D95;
 Tue,  1 Feb 2022 15:28:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nNiyOrVR+WFhMgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 01 Feb 2022 15:28:53 +0000
Date: Tue, 1 Feb 2022 16:28:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YflRs6o15kRQ7aiI@pevik>
References: <20220126164703.7177-1-pvorel@suse.cz>
 <YfkgZ8Ab6Jl8udbv@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YfkgZ8Ab6Jl8udbv@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Fix tst_mkfs_ doc
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> >   * @fs_opts: NULL or NULL terminated array of mkfs options
> > - * @extra_opt: extra mkfs option which is passed after the device name
> > + * @extra_opts: NULL or NULL terminated array of extra mkfs options which is
>                                                                              ^
> 									     are
I wasn't sure about the grammar, I thought the NULL *is* passed or
the NULL terminated array *is* passed. But not really sure.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
