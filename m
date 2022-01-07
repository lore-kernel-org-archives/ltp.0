Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2DB0C433EF
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 09:50:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DFC63C7E58
	for <ltp@archiver.kernel.org>; Fri,  7 Jan 2022 10:49:59 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EEA873C2005
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 10:49:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 865A61A0061D
 for <ltp@lists.linux.it>; Fri,  7 Jan 2022 10:49:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A99D81F39C;
 Fri,  7 Jan 2022 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641548989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mYGi4m7AQqbBL2AGYDggu0KmvQ3WPDpOBM+G0XeN9qc=;
 b=K1kpkHWZDQRNVFtqWoHLf1GmCFzMKI8Fs3ZGISU9yilVVGZJETS71fU7ADXTZhmPavMOpd
 6F8J3P4rOzxo1rbJ4e5kYSbJxtW/h9h/0HmAkz3v9hlQYIuDEpzTW6McmtL295NBzX0lmj
 HGXBq3nN4ocROv0jACHFIar//5kGbrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641548989;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mYGi4m7AQqbBL2AGYDggu0KmvQ3WPDpOBM+G0XeN9qc=;
 b=zUE9tXDPV8HZxf3tHhJz7PzcFwPGS47/ZY2Lsfl58ZnrqiRXIR7YCgb26P3PJnVyqd1LP8
 XPBHPSbd5gP961Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92AD913CC8;
 Fri,  7 Jan 2022 09:49:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id q52qIr0M2GH0WQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 07 Jan 2022 09:49:49 +0000
Date: Fri, 7 Jan 2022 10:51:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YdgNGp1UT38yuday@yuki>
References: <YdWC0f+70TF6Eluk@yuki>
 <CAEemH2ceOdg2W+0ZsZEQGfoCCC0a7hDz9XLsbgQ_HqQXPRPOeg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ceOdg2W+0ZsZEQGfoCCC0a7hDz9XLsbgQ_HqQXPRPOeg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Also if there are patches that you think should be merged before the
> > release let me know ASAP so we can have a look soon enough.
> 
> Maybe could consider the concept of the test max_runtime series?
> https://patchwork.ozlabs.org/project/ltp/list/?series=268799

I want to make some changes there, as Ritchie pointed out some
interesting ideas about how runtime and timeout should coexist. I will
make sure to redo the patchset after the release has been finalized.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
