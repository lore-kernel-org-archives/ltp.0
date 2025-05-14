Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC06AC3ABD9
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 08:00:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAE243CC393
	for <ltp@archiver.kernel.org>; Wed, 14 May 2025 10:00:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E79433CC349
 for <ltp@lists.linux.it>; Wed, 14 May 2025 10:00:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 041261A00EBC
 for <ltp@lists.linux.it>; Wed, 14 May 2025 10:00:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96B091F391;
 Wed, 14 May 2025 08:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747209601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlHHLOPlh1RrpQn1G74ISrVw2AFUFZ0PDM5u11UKmys=;
 b=RM0cUehOrHfFNVDIMboQb3s9bfwrZw3HKOT19NMapVmIPvCFrDy7O5zvXofj3IKNrO5iwW
 jea70oSlQ2OSAP3q2mMXwditMgtb8MWmRu4ZMkHYizZ9x12f7BLxgKhYk8Zkc9FTmw1vhN
 lLy9VXRmeyZUrkKqaZWLxlO4evGSTDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747209601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlHHLOPlh1RrpQn1G74ISrVw2AFUFZ0PDM5u11UKmys=;
 b=Xch1l8OInTym9qV+SB2hkniLkNz6abGcsmpd2hnBqnsBce4MXOYsqAZC8nHC5OQERRz4t5
 b3WuX1K2iIItBBAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747209601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlHHLOPlh1RrpQn1G74ISrVw2AFUFZ0PDM5u11UKmys=;
 b=RM0cUehOrHfFNVDIMboQb3s9bfwrZw3HKOT19NMapVmIPvCFrDy7O5zvXofj3IKNrO5iwW
 jea70oSlQ2OSAP3q2mMXwditMgtb8MWmRu4ZMkHYizZ9x12f7BLxgKhYk8Zkc9FTmw1vhN
 lLy9VXRmeyZUrkKqaZWLxlO4evGSTDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747209601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlHHLOPlh1RrpQn1G74ISrVw2AFUFZ0PDM5u11UKmys=;
 b=Xch1l8OInTym9qV+SB2hkniLkNz6abGcsmpd2hnBqnsBce4MXOYsqAZC8nHC5OQERRz4t5
 b3WuX1K2iIItBBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8422E13306;
 Wed, 14 May 2025 08:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H4H6H4FNJGjFCwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 14 May 2025 08:00:01 +0000
Date: Wed, 14 May 2025 10:00:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aCRNqIAGRnZQJzua@yuki.lan>
References: <20250513050530.47541-1-liwang@redhat.com>
 <aCM2PrCrCdPqNIGc@yuki.lan>
 <CAEemH2cP78yxJEWi-Z_v=EuXWP+6XDQBNnGMVHKq3pYLiGQRdw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cP78yxJEWi-Z_v=EuXWP+6XDQBNnGMVHKq3pYLiGQRdw@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: initialize lib|main_pid to zero in the
 setup_ipc
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
> > > @@ -1393,8 +1396,6 @@ static void do_setup(int argc, char *argv[])
> > >       if (tst_test->hugepages.number)
> > >               tst_reserve_hugepages(&tst_test->hugepages);
> > >
> > > -     setup_ipc();
> > > -
> >
> > I suppose that this has to go before the tst_reserve_hugepages() so that
> > we have results->lib_pid defined and properly clean up after the
> > hugepages. However for that to work we have to set the
> > results->lib_pid directly in the setup_ipc().
> 
> In this patch, setup_ipc() is already moved up before the
> tst_reserve_hugpages(). I particularly put it after tst_test->runs_scripts,
> which is mandatory to have .child_needs_reinit initialized first.
> 
> And the hugpages cleanup work is completed in tst_sys_conf_restore(0)
> in the do_cleanup, so that might not be a problem.
> I have validated that all hugetlb tests work well.
> 
> Also,
> 
> Or, did I miss anything?

The problem is that no library cleanup will happen unless lib_pid is
set, that means that tst_brk() will be triggered anywhere in do_setup()
the clanup will not be run because we set the lib_pid after the
do_setup() in the patch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
