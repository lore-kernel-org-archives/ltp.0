Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6926070CB1
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=OzOwNscs;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TgfnvNUM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=OzOwNscs;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TgfnvNUM
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD3C13EABD4
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 17:15:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C3693E1297
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 17:15:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 281501000463
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 17:15:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 843772200F;
 Mon,  2 Nov 2026 16:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793636111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzYUqxBD7LymgNacMdEGyohGJTU94dFZkRMP5fw1OVg=;
 b=OzOwNscsuPoKY+d7oMjO0dl5NIcKVB6PXBa3p55Hd/T+sJ396FMYIm0qWUX7fOOvruYcc4
 8owSQi4LgV4iKhvkjp3ETiHd5gG7UoN4VURXnEy2sBK05xO9KcyFkF42d6YTy/sT9auPhp
 mBEsQt5gprto7RaV1jdlZg5kbprUUSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793636111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzYUqxBD7LymgNacMdEGyohGJTU94dFZkRMP5fw1OVg=;
 b=TgfnvNUM8byCxxqYnnsny6wjtaHkoJk6KWoTdprzcUztr82OccOUhLiJNC6EkQUhxuKhM8
 0/ethngoNeF0TaCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793636111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzYUqxBD7LymgNacMdEGyohGJTU94dFZkRMP5fw1OVg=;
 b=OzOwNscsuPoKY+d7oMjO0dl5NIcKVB6PXBa3p55Hd/T+sJ396FMYIm0qWUX7fOOvruYcc4
 8owSQi4LgV4iKhvkjp3ETiHd5gG7UoN4VURXnEy2sBK05xO9KcyFkF42d6YTy/sT9auPhp
 mBEsQt5gprto7RaV1jdlZg5kbprUUSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793636111;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zzYUqxBD7LymgNacMdEGyohGJTU94dFZkRMP5fw1OVg=;
 b=TgfnvNUM8byCxxqYnnsny6wjtaHkoJk6KWoTdprzcUztr82OccOUhLiJNC6EkQUhxuKhM8
 0/ethngoNeF0TaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C23C134B3;
 Mon,  2 Nov 2026 16:15:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Au6UCg+36GoDLAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 02 Nov 2026 16:15:11 +0000
Date: Mon, 2 Nov 2026 17:15:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <aui3I3FvsAE86Zsi@yuki.lan>
References: <20260923083300.54026-1-pavrampu@linux.ibm.com>
 <20260923095909.9312-1-linuxtestproject.agent@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260923095909.9312-1-linuxtestproject.agent@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[]; TAGGED_RCPT(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugeshmget: Add hugeshmget07 to test SHM_HUGETLB
 with /dev/zero read
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Pavithra <pavrampu@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >+	zero_fd = SAFE_OPEN("/dev/zero", O_RDONLY);
> >+
> >+	shmid = SAFE_SHMGET(IPC_PRIVATE, size, SHM_HUGETLB | SHM_R | SHM_W);
> >+
> >+	shmaddr = SAFE_SHMAT(shmid, 0, SHM_RND);
> >+	tst_res(TINFO, "shmaddr: %p", shmaddr);
> >+
> >+	for (i = 0; i < size; i += hpage_size) {
> >+		TST_EXP_VAL(read(zero_fd, shmaddr + i, hpage_size),
> >+			(ssize_t)hpage_size);
> >+	}
> >+
> >+	SAFE_CLOSE(zero_fd);
> 
> File descriptors must be initialized to -1 and closed in cleanup() with an
> fd != -1 guard. If SAFE_SHMGET() or SAFE_SHMAT() aborts, zero_fd is not
> closed. Define static int zero_fd = -1 at file scope, open it in setup(),
> and close it in cleanup().
> 
> >+	SAFE_SHMCTL(shmid, IPC_RMID, NULL);
> >+	shmid = -1;
> 
> SAFE_SHMCTL() sets shmid to -1 when called with IPC_RMID. The subsequent
> shmid = -1 assignment is redundant.

These two are valid, the rest of the code looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
