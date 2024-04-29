Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CCADC4345F
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 13:49:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A00EE3C6F51
	for <ltp@archiver.kernel.org>; Mon, 29 Apr 2024 15:49:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C51FD3C68A3
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 15:49:14 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 38BD9200C78
 for <ltp@lists.linux.it>; Mon, 29 Apr 2024 15:49:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8B2E61F392;
 Mon, 29 Apr 2024 13:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714398552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GiIEiBH9l3Dl5/bR3uVe4zkYqhP/3J0vdBLwgNPpz2k=;
 b=1Zmfd8EfJ4VvaEuwbFYZ3xSeJ2bK/FdAGKV2l1WTLdrhbzBm5PSjgWCsdB5sQmDrfSgUQN
 7e2uRmbCXThuKg2E9UEKJqvehqGQEVxKveV2tVOfGQcCPbOWa12ANGPKeW7p16Ng47UBRn
 hTNEqDN227twRwfTbCx98Dg9Nhuc1LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714398552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GiIEiBH9l3Dl5/bR3uVe4zkYqhP/3J0vdBLwgNPpz2k=;
 b=c6B2vrpL5GhBtIqIBqOHLFgXNOREZKHU8rTBsnCsp1CpAKJxJZbegzA4UBGW3J3qV2K9eG
 Gy+EDryNh1XMpfBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714398552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GiIEiBH9l3Dl5/bR3uVe4zkYqhP/3J0vdBLwgNPpz2k=;
 b=1Zmfd8EfJ4VvaEuwbFYZ3xSeJ2bK/FdAGKV2l1WTLdrhbzBm5PSjgWCsdB5sQmDrfSgUQN
 7e2uRmbCXThuKg2E9UEKJqvehqGQEVxKveV2tVOfGQcCPbOWa12ANGPKeW7p16Ng47UBRn
 hTNEqDN227twRwfTbCx98Dg9Nhuc1LI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714398552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GiIEiBH9l3Dl5/bR3uVe4zkYqhP/3J0vdBLwgNPpz2k=;
 b=c6B2vrpL5GhBtIqIBqOHLFgXNOREZKHU8rTBsnCsp1CpAKJxJZbegzA4UBGW3J3qV2K9eG
 Gy+EDryNh1XMpfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DBCD139DE;
 Mon, 29 Apr 2024 13:49:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +/yrHlilL2bHeQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 29 Apr 2024 13:49:12 +0000
Date: Mon, 29 Apr 2024 15:48:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Filippo Storniolo <fstornio@redhat.com>
Message-ID: <Zi-lJZW244sciuW9@yuki>
References: <20240429133336.3166386-1-fstornio@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240429133336.3166386-1-fstornio@redhat.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/mlock05: add mlock test for locking
 and pre-faulting of memory
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
> check VmRSS and VmLck variables from /proc/$pid/status.
> VmRSS size should at least as big as the memory allocation.
> VmLck size should be equal to the size of the memory allocation.

Now the test looks good, however I managed to make it fail. The test
fails if you run it with large enough -i paramater, for me running
'./mlock05 -i 10000' tend to produce failures at the end of the testrun:

tst_test.c:1741: TINFO: LTP version: 20240129-192-geca801321
tst_test.c:1625: TINFO: Timeout per run is 0h 00m 30s
mlock05.c:49: TPASS: Expect: (VmRSS=1048576) >= (MMAPLEN=1048576)
mlock05.c:52: TPASS: VmLck == MMAPLEN (1048576)
...
mlock05.c:52: TPASS: VmLck == MMAPLEN (1048576)
mlock05.c:49: TFAIL: Expect: (VmRSS=983040) >= (MMAPLEN=1048576)
mlock05.c:52: TPASS: VmLck == MMAPLEN (1048576)
mlock05.c:49: TFAIL: Expect: (VmRSS=983040) >= (MMAPLEN=1048576)
mlock05.c:52: TPASS: VmLck == MMAPLEN (1048576)

Summary:
passed   18332
failed   1668
broken   0
skipped  0
warnings 0
...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
