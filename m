Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238D0C25B0E
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 12:52:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 264183C9B66
	for <ltp@archiver.kernel.org>; Tue, 16 Aug 2022 14:52:02 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5E223C1FED
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 14:51:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 12E0B1400BDA
 for <ltp@lists.linux.it>; Tue, 16 Aug 2022 14:51:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E1F237480;
 Tue, 16 Aug 2022 12:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660654309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12IslI2nafDZp4KIs3/IUL/OzWRz1rfWjxi5Z8/rwRU=;
 b=XRpOSJaWPfZdHW6JmawTyH8owC6plxI3Zb9VkpJA7AAEvfezQSkQ+O8spl+s18m+tb/DbN
 PkJwWyYtBEEH5EsdBB7Z8hkdPGmMIv8zukKMN2yfg5j96nNYpAKj8Au6+ujoogj4DhvMBW
 EkUeCi046UWaXG5ccNCNzIIbzb7kbdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660654309;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12IslI2nafDZp4KIs3/IUL/OzWRz1rfWjxi5Z8/rwRU=;
 b=paZ7SLJq/Co+9N7XK9MQmS9lQB+hHcIidA6o420iFCHdNZTibYc+HDcaP1Vh6mzxBXkYuj
 FJeO6RbJnEiA+5BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DFE01345B;
 Tue, 16 Aug 2022 12:51:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hR19IOSS+2IoWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 16 Aug 2022 12:51:48 +0000
Date: Tue, 16 Aug 2022 14:51:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YvuS4nQkzi9oJzi/@pevik>
References: <20220728114258.30832-1-mdoucha@suse.cz>
 <20220728114258.30832-2-mdoucha@suse.cz>
 <b2ff91ff-d65c-325c-c07e-18dcc5fe1805@suse.cz>
 <Yuk66ELT2ugQFAlb@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yuk66ELT2ugQFAlb@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] tst_rod: Fail on directory change commands
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
> > Beware that this patch will cause a lot of broken shell tests to fail.
> > Another patchset fixing the incorrect ROD usage in shell tests is needed
> > before merging this patch.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I also wonder if we should care for pushd/popd which are bashism and should not
be used in LTP tests which use new shell API.

So far they are used in testcases/realtime/run.sh testscripts/test_realtime.sh,
which does not use shell API (and realtime should be removed after porting
anything useful to rt-tests).

> The only broken test I've found is du01.sh that does
> "ROD_SILENT cd basedir" are there actually any other tests that does so?

Indeed it looks just du01.sh.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
