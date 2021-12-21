Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5439C433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 08:33:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6ADCA3C9234
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 09:33:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 109A03C9168
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 09:33:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 43261200C9B
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 09:33:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0DF59210EF;
 Tue, 21 Dec 2021 08:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640075595;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w3k7cB1jZ3gSQ6MEmZxtmPmGO/ZHWiKdJWhgmr+9T7M=;
 b=KAK1ozXgadZ9wkH4uTukUOV2geZRT8fGS9fbcvrYjUFN0CvgLOqOEtgGxHum7NxMARCqwu
 Qx3oWY1N6Q6gTlr7/ldmCRQxxLZrNboY4rNCGG0Pm9IlB175rQvxmtJg+KvoHV9UpgvqrS
 qrfC7ZweMJ3qOi+LP8D15LmjTqK8tew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640075595;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w3k7cB1jZ3gSQ6MEmZxtmPmGO/ZHWiKdJWhgmr+9T7M=;
 b=KoB9W64DJ7QPn54Kbzj1ttlnvf0a/GENXMcpkQFY7jdLnkp1RIWwQXjYYB6xFQ2ca0u/1P
 T1pMMHtvtFDv27Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DAF2013BEC;
 Tue, 21 Dec 2021 08:33:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rZTqM0qRwWFAKQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 21 Dec 2021 08:33:14 +0000
Date: Tue, 21 Dec 2021 09:33:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YcGRST7vAycVk0AA@pevik>
References: <20211220095416.583323-1-liwang@redhat.com>
 <YcDMnDRgsac/q8D9@pevik>
 <CAEemH2d6PPi94q3PhMyR1Js_Rqr1dpfvch=ex3HpuHfQKJYTnw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d6PPi94q3PhMyR1Js_Rqr1dpfvch=ex3HpuHfQKJYTnw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib: add functions to adjust oom score
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> > > +     if (access("/proc/self/oom_score_adj", F_OK) == -1) {
> > We need to check here also /proc/PID/oom_score_adj, i.e. score_path.


> Good catch, I would add a 'W_OK' checking and skip the setting with
> a reminder message if run without root.

> how about this?

> if (access(score_path, W_OK) == -1) {
>         tst_res(TINFO, "Warning: %s cannot be accessed for writing,
>                 please check if test run with root user.",
>                 score_path);
>         return
> }

No, value < 0 obviously requires root, thus access() check is not enough.
Try  echo -1 > /proc/$$/oom_score_adj

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
