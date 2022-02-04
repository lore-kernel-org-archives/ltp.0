Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A57C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 12:38:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2BA33C9AED
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 13:38:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C53FB3C985F
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 13:37:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CB77D1401117
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 13:37:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 958CC210F8;
 Fri,  4 Feb 2022 12:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643978270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rf2UyQ/b9M/fnXevhwB045dNW1DmEAPDm4j8jm7S6xM=;
 b=UAWXQ69u8HrY2et7v0kMYTWXlYEp55mfLxMQlABQWWHx/hUBJgRA2UpqHu287VFqh4HWof
 QeraHm7hLpj07tpCeV99wvlv48ShYTdSKiI1W5NBg+Mhgs38ZKzBKqkqE2bzlSkiA7O6MH
 HapOdOKNxJAnkJLdt5yuwkfljRj0gqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643978270;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rf2UyQ/b9M/fnXevhwB045dNW1DmEAPDm4j8jm7S6xM=;
 b=z+yGQ0kQqPaUr60jXWgF6diHHfdk7E5vNnejUrJ76HJ/SLTyI6Z4gJNvw58BXRdSy5JO8U
 a0riYdJKQaRKvZCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 615A413A82;
 Fri,  4 Feb 2022 12:37:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id t94qFB4e/WGFWAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 04 Feb 2022 12:37:50 +0000
Date: Fri, 4 Feb 2022 13:39:48 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Yf0elMPsp9gQXVSC@yuki>
References: <a0733b841c7867ca6af1feb033b691c9f72ce0ec.1643291588.git.jstancek@redhat.com>
 <Yf0bW/zvEkb7gajX@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yf0bW/zvEkb7gajX@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mkdir09: rewrite in new LTP API
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
> > +static void test2(int child_num)
> > +{
> > +	/*
> > +	 * Child routine which attempts to remove directories from the
> > +	 * test directory which do not exist.
> > +	 */
> > +
> > +	int j;
> > +	char tmpdir[MAXPATHLEN];
> > +
> > +	while (!done) {
> > +		for (j = 1; j < nfiles; j += NCHILD) {
> > +			sprintf(tmpdir, DIR_NAME, j);
> > +			TEST(rmdir(tmpdir));
> > +
> > +			if (TST_RET == 0) {
> > +				tst_res(TFAIL, "[%d] rmdir %s succeeded unexpectedly",
> > +					 child_num, tmpdir);
> > +				return;
> > +			}
> > +
> > +			if (TST_ERR != ENOENT) {
> > +				tst_res(TFAIL|TERRNO, "[%d] rmdir %s",
> > +					child_num, tmpdir);
> > +				return;
> > +			}
> > +		}
> > +	}
> > +	tst_res(TPASS, "[%d] create dirs that dont exist", child_num);
                             ^
			     remove dirs

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
