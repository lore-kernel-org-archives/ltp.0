Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE36E77188
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 15:48:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1AD53C0B8E
	for <ltp@archiver.kernel.org>; Fri,  3 Jan 2025 16:48:41 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FF173C0652
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 16:48:25 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 154E46161B0
 for <ltp@lists.linux.it>; Fri,  3 Jan 2025 16:48:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1483E1F38E;
 Fri,  3 Jan 2025 15:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735919304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFVhUwOaQVa5bPuo3VeykEwZMCFwj6uWPNXacESQJKw=;
 b=BzOvy16BwgIt5dPIjLjcB8z9Ge8DCfVAELx1WPEVKWpKbjTuh7ZjCphOJaKA22r9lN59yL
 kHaiKZ1ak4OgeNZg6yY6wkG4+81rN06b0onuRGnQ/1kDmT/vCrfEYxevJPb4KDtKz/P8Tu
 xEaYyqv3TfFO75ATbIt3c7K/JlNlAjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735919304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFVhUwOaQVa5bPuo3VeykEwZMCFwj6uWPNXacESQJKw=;
 b=X/MhdLp+tIzFMVcTkKbvmy4J7IIAZXO+MY9VM7eAZrOjYygwsSkn5A7Ob9UrZb5jAOiE1D
 51rMf0MpUNzIQgBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1735919304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFVhUwOaQVa5bPuo3VeykEwZMCFwj6uWPNXacESQJKw=;
 b=BzOvy16BwgIt5dPIjLjcB8z9Ge8DCfVAELx1WPEVKWpKbjTuh7ZjCphOJaKA22r9lN59yL
 kHaiKZ1ak4OgeNZg6yY6wkG4+81rN06b0onuRGnQ/1kDmT/vCrfEYxevJPb4KDtKz/P8Tu
 xEaYyqv3TfFO75ATbIt3c7K/JlNlAjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1735919304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JFVhUwOaQVa5bPuo3VeykEwZMCFwj6uWPNXacESQJKw=;
 b=X/MhdLp+tIzFMVcTkKbvmy4J7IIAZXO+MY9VM7eAZrOjYygwsSkn5A7Ob9UrZb5jAOiE1D
 51rMf0MpUNzIQgBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F317B13418;
 Fri,  3 Jan 2025 15:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cLSnOMcGeGd+cQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 03 Jan 2025 15:48:23 +0000
Date: Fri, 3 Jan 2025 16:48:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Z3gGuFHey5qgQ__6@yuki.lan>
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250102124319.GA81987@pevik>
 <CAEemH2cXL8yu0jhHz7wefvBbDGy-wXcz8Mw1JZv8FqLAXHKm9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cXL8yu0jhHz7wefvBbDGy-wXcz8Mw1JZv8FqLAXHKm9Q@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.986]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_FIVE(0.00)[6]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: multiply the timeout if detect slow
 kconfigsD
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Yes, the benefit of multiplying TIMEOUT (on a slow system) is not only
> to avoid increasing the actual execution time of the test, but also to give
>  the system more time to wait for the test to complete the final work.
> 
> Original:
>   |  -- timeout -- | -- max_runtime -- |
> 
> Previous:
>   |  -- timeout -- | -------- max_runtime * 4 -------- |
> 
> Now:
>   |  -------- timeout * 4 -------- | -- max_runtime --  |

The problems I see here:

There are tests, I think this covers mostly the IO stress tests, where
the max runtime may be significantly larger than the timeout, so
multiplying only the timeout may not be enough there.

I wanted to eventually move to a shorter default timeout, e.g. 10s once
we have enough max_runtime anotation in the testcases.

So in the end we may eventually need both max_runtime and runtime in the
tst_test structure.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
