Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A31ECAAA1
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 08:26:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2F843CAA05
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 10:26:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 776473C0727
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 10:26:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A6215100074D
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 10:26:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 67A6F1F891;
 Fri,  9 Sep 2022 08:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662711976; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KP5IoS3RRmZHEIjyYEAxr2R6g0guzm/vtkPDkPE5KEg=;
 b=W5/WPQCPi8RjGh56bZlYSPYMknqZqVnuP0T4wrjs12JnEc6FxWTliwGvNl5ofjNtg3oxJm
 cVue4qRSSUMTH8cZM552QDVUkotKbA5JucndT2UB/wCEHE6I4wYfXprTFOxElBwtu5DYbt
 lt2A+zXoITIwt6r9t7BTIQODH6jP4Ws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662711976;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KP5IoS3RRmZHEIjyYEAxr2R6g0guzm/vtkPDkPE5KEg=;
 b=yW4frhiHWKR2RIieSkIH/X32nae/6to/+R1O5x8X2hn58eJJmcwg4Xm2d3dhV5R2uC079p
 uK7gKOStts61bvCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56115139D5;
 Fri,  9 Sep 2022 08:26:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fgGfFKj4GmNvRwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 09 Sep 2022 08:26:16 +0000
Date: Fri, 9 Sep 2022 10:28:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yxr5G9fgjjgsOe93@yuki>
References: <20220830135007.16818-1-mdoucha@suse.cz>
 <20220830135007.16818-4-mdoucha@suse.cz> <Yw4jYgDzNj9BAqOf@yuki>
 <45d76082-49f3-74bb-fd3c-6f5fd2d6136f@suse.cz>
 <Yw9ZCTP0l7FjRtLg@yuki>
 <fb93f3bd-1a22-6a1d-c0ed-01eba39121bb@suse.cz>
 <YxYgX51MTYG1U3z8@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxYgX51MTYG1U3z8@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 03/10] ksm: Add max_runtime to tests
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > > Alternatively, we could measure 1 full ksmd scan in setup() and then set
> > > > max_runtime dynamically. Each call of create_same_memory() would need
> > > > roughly 16 scan times. Time spent in ksm_child_memset() is included in
> > > > that estimate.
> 
> > > That sounds good as well, but I would still set the .max_runtime to
> > > rough guess in tst_test structure and then adjusted it in the test
> > > setup().
> 
> > The current patch is a good enough guess for ~2-4GB machines. Or do you want
> > to target bigger machines by default?
> 
> I guess it'd be safer to expect machines with bigger memory.

I would just multiply the value you proposed by 10, which should be
large enough default.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
