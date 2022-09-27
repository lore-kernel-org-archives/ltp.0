Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BBC1C54EE9
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 09:05:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 676973CAE22
	for <ltp@archiver.kernel.org>; Tue, 27 Sep 2022 11:05:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13E6E3C7319
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 11:05:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 59F5B1000A57
 for <ltp@lists.linux.it>; Tue, 27 Sep 2022 11:05:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B813F1F999;
 Tue, 27 Sep 2022 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664269502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1eS3TuKpwLXo25AmLK3UPOQM0Ev4hSXXgjthBDaiOPs=;
 b=fhkB2hTrjpOAyicxmH2KBEV/2TyFYyWALND8Oe+6vKIOnyouRIjMNBzBfI56CCmK3z429w
 lOSlD+RhXqcY1yh6YvjBUYuz2TBcvvfbpVUJDFBHnJA8rJVe15xv9MuOlr3AgE+VT3lOwf
 6HlUEf3D6x5qGYj7ncQ0KTU6nnjbrjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664269502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1eS3TuKpwLXo25AmLK3UPOQM0Ev4hSXXgjthBDaiOPs=;
 b=+OUf6ej2TsPgBJvxgoglPSwmMalsoyGa9W/Kwt79s/amJYKweHRAHywmzswtsdr9+hn6DM
 PFO+YIYmgZSUQPCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4FF8139BE;
 Tue, 27 Sep 2022 09:05:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KkMtJ768MmPAKQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 27 Sep 2022 09:05:02 +0000
Date: Tue, 27 Sep 2022 11:06:56 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Edward Liaw <edliaw@google.com>
Message-ID: <YzK9MHWocKPypj8B@yuki>
References: <20220913202839.1807979-1-edliaw@google.com>
 <YyGisrbDIgVa/0QA@yuki> <YyHYvCr0PISg6ISY@pevik>
 <YyHcNcTUNG+gU3rq@pevik>
 <CAG4es9Wi8oGf1OmNUqg41wv51Qmb9gewZrifUQW-wOPL0ZKNhA@mail.gmail.com>
 <YyQ+PiN0JBy6PLJI@yuki>
 <CAG4es9VB6AydFCRkBvPm=cyozOiqCBN8vxEo68_yvm-as+9FeA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG4es9VB6AydFCRkBvPm=cyozOiqCBN8vxEo68_yvm-as+9FeA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] minmax: fix type warnings
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Sure thing, I've made an attempt to port mmapstress01, will send that for
> feedback before tackling the others.

We are finalizing a LTP release right now, I will have a look once I
have a bit of time, however it probably wouldn't be sooner than next
week.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
