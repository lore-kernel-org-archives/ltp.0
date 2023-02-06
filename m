Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864F1C636D3
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 16:12:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70F2C3CC24D
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 17:12:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 180C33CB174
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 17:12:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1B8811400985
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 17:12:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0EC641FDA5;
 Mon,  6 Feb 2023 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675699958;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uj4ghUrbasV4ORat3NpRbKSfttyenu3bhfXbTrzH1NA=;
 b=ssIff6QIr8qz2PbyiHm9jKeEN6O0EglksiQJMnoaFcD0JlwybXlZi1pFJYp3zWiaF+WqVA
 419f9CamsARXl1mt8gAC4jYnpvpq7GhrIdZlXHWWDA76hlTPWsjUwqZ0NcYIdEHny/Yk2x
 f74hT+Cprcel27uaAdF1B9G1AeG0S/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675699958;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Uj4ghUrbasV4ORat3NpRbKSfttyenu3bhfXbTrzH1NA=;
 b=PUvfHdolCsLfkYVCAtV8LAW8YydbJpPYfrN7QtU0Paw6utrmtxwDSAFy+FrcH6uMY/kB0b
 mb+ubyaC/bMic4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BED20138E7;
 Mon,  6 Feb 2023 16:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uvVFLPUm4WOXBAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Feb 2023 16:12:37 +0000
Date: Mon, 6 Feb 2023 17:12:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Y+Em88G9z/alMBud@pevik>
References: <20230206061001.13164-1-pvorel@suse.cz>
 <CAASaF6yvWLPpvKgXwhk5Z=USN_+yz7pELStWco0A9oGs8yiNag@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6yvWLPpvKgXwhk5Z=USN_+yz7pELStWco0A9oGs8yiNag@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Allow zero iterations (-i0)
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

thanks a lot, merged!

> On Mon, Feb 6, 2023 at 7:10 AM Petr Vorel <pvorel@suse.cz> wrote:

> > -i0 is helpful to test if setup and cleanup are working.
> > We suggest that in maintainer-patch-review-checklist.txt.

> Until now, I never thought of trying -i0 :-)

Credit goes to Martin Doucha, who let me know some time ago.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
