Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81ACED216A6
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 13:44:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAC353C674E
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 15:44:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54BF23C010E
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 15:44:38 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 952FC600EAD
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 15:44:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D483F1FE44;
 Tue, 15 Oct 2024 13:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728999876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJv8HcQnj+W3DA1QF1FtqWzBDVb1Y7+JO5a7xd87gao=;
 b=REPaPFiuT8SgWSpmLsSwZo84dY2AmcnfWOpSOD33qRV7Cah0ivJkEcUyLEr5GId+eeyV32
 WzE4QixKa2Hw4HWDdKcDhtHrCeqmrrjE5OifspfiF1iH+4wmuGRnyBBdplXUjLgQMgR2V7
 t3fys4oSMC93NP21LVUsBmnRhJyhKjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728999876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJv8HcQnj+W3DA1QF1FtqWzBDVb1Y7+JO5a7xd87gao=;
 b=MlNsl40Kz4V7gWTdgvB3qV19/uKLppyFs6VgAS0yQNfMkXT0kqoAlu3XPcE47HE4OmU3lS
 Ex2AdhijHUabWeCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1728999876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJv8HcQnj+W3DA1QF1FtqWzBDVb1Y7+JO5a7xd87gao=;
 b=REPaPFiuT8SgWSpmLsSwZo84dY2AmcnfWOpSOD33qRV7Cah0ivJkEcUyLEr5GId+eeyV32
 WzE4QixKa2Hw4HWDdKcDhtHrCeqmrrjE5OifspfiF1iH+4wmuGRnyBBdplXUjLgQMgR2V7
 t3fys4oSMC93NP21LVUsBmnRhJyhKjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1728999876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aJv8HcQnj+W3DA1QF1FtqWzBDVb1Y7+JO5a7xd87gao=;
 b=MlNsl40Kz4V7gWTdgvB3qV19/uKLppyFs6VgAS0yQNfMkXT0kqoAlu3XPcE47HE4OmU3lS
 Ex2AdhijHUabWeCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8DE313A42;
 Tue, 15 Oct 2024 13:44:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sVDkK8RxDme2dgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 15 Oct 2024 13:44:36 +0000
Date: Tue, 15 Oct 2024 15:43:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Zw5xhhvjNkvAwKU0@yuki.lan>
References: <892adc7c5b174221bf10e796ad29adaaf1559e5c.1728978957.git.jstancek@redhat.com>
 <d53bcc8476d4c2ef37b92543b2f7fe8338420f0b.1728992854.git.jstancek@redhat.com>
 <Zw5bCxNMuCz4aKWC@yuki.lan>
 <CAASaF6w0Smez5e=hn8UGU2DC3Fi2zrqYX2PwKKE4r23RQ0BM4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6w0Smez5e=hn8UGU2DC3Fi2zrqYX2PwKKE4r23RQ0BM4Q@mail.gmail.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/statmount07: change "invalid buffer
 size" test
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
> Are you sure?
> 
> 17019 08:32:23 write(2, "tst_buffers.c:57: \33[1;34mTINFO: "..., 66) = 66
> 17019 08:32:23 mmap(NULL, 8192, PROT_READ|PROT_WRITE,
> MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x3ff94f75000
> 17019 08:32:23 mprotect(0x3ff94f76000, 4096, PROT_NONE) = 0
> 
> st_mount_bad: 0x3ff94f75fff
> (/proc/self/maps)
> ...
> 3ff94f2e000-3ff94f30000 rw-p 0002e000 fd:03 67110911
>   /usr/lib/ld64.so.1
> 3ff94f75000-3ff94f76000 rw-p 00000000 00:00 0
> 3ff94f76000-3ff94f77000 ---p 00000000 00:00 0
> 3ff94f77000-3ff94f7b000 rw-p 00000000 00:00 0
> 3fffba5a000-3fffba7b000 rw-p 00000000 00:00 0                            [stack]
> 3fffba9f000-3fffbaa1000 r--p 00000000 00:00 0                            [vvar]
> 3fffbaa1000-3fffbaa3000 r-xp 00000000 00:00 0                            [vdso]
> 
> >, since guarded buffers are primarily guarding about off-by-one
> > at the start of the buffer.
> 
> I'd expect going over end of buffer to be a lot more common.

Sigh, for some reason I had the case with PROT_NONE before the buffer
stored in my memory, maybe that was one of the versions the patchset
went through. Sorry for misleading reply.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
