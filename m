Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC72C88E4D
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 16:03:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D384D3E9230
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 18:03:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2AADE3D227C
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 18:03:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 88251600ADE
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 18:03:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8598B1FEF0;
 Fri, 11 Sep 2026 16:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789142612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYAdDRZ1h+P9u/Y4vilu4kf6z7js7QvGzFLIIrqe8I8=;
 b=kZQ1MQLSQ8u4X5poZohzratApeMQ/4od6lQRncRnT6GYcFi2KzRuLDjuY+Brk/LGA3iEUA
 w6CyNf8OEkiAa8GrV7kdXfKppr1eassaPdKRhp2ExZERtMCCeDbKv1GcSjQEsyIV2gV7Jn
 B3dAqioDMj0T7t99yUuerJLbsecJspo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789142612;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYAdDRZ1h+P9u/Y4vilu4kf6z7js7QvGzFLIIrqe8I8=;
 b=6jpe9eBkI4WKhQHK3C09QROGoYRt09CLefxtHuAaNI4oHPgCNotymtD2Piir1rnMkLHfV3
 qIi5sV/LU5vyjhDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789142608;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYAdDRZ1h+P9u/Y4vilu4kf6z7js7QvGzFLIIrqe8I8=;
 b=Igk989cjFIMu/+ovrZzesAVnZpKFGBO0zRo5CWjLMVUyv0zN5SwwPxuLGl2u/bTQqfIxvM
 7c7GUsQWJTgkUXe5rQRgI1fppSDp8/LIkFyFOOCpZ7mu6q8mAhA+3n7JAk0q4vNPJVh3aR
 3P8xNzq95Eiof0j+ORz8BMBsn9h9Kh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789142608;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XYAdDRZ1h+P9u/Y4vilu4kf6z7js7QvGzFLIIrqe8I8=;
 b=HTfJ9NjFRznGQ+88/2oXQNtrk1H4f5/A+Jl3rZChabn+9O6PZLeoDUQEVJRcB1/lHNeGrY
 f5olvGcv9sQZ+BBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3EB8913715;
 Fri, 11 Sep 2026 16:03:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1D3CDVAmpGpEWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 16:03:28 +0000
Date: Fri, 11 Sep 2026 18:03:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260911160326.GA1534936@pevik>
References: <20260911135907.GC1488703@pevik>
 <6aa41b43.63ed6291.2b47ca.90d9@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6aa41b43.63ed6291.2b47ca.90d9@mx.google.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] mmap24: add test for MAP_32BIT address limit
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

...
> > BTW I was wondering if I can get this failing when running on VM with really
> > small RAM, but even with 249 MB I get get mapped 928 MB (or 960 MB when I run
> > with -i):

> > mmap24.c:81: TPASS: Mapped 928 MB across 29 chunks within 2GB before ENOMEM

> > What am I missing?

> Thanks for checking, I didn't verify 32-bits indeed..

> I found the reason and it's really tricky. In arch/x86/kernel/sys_x86_64.c,
> MAP_32BIT forces the mapping range to:

> 	begin = 0x40000000 (1 GB)
> 	end = 0x80000000 (2 GB)

+1. That might explain the different value on mmap23.c as well.

> Which is 1GB max.

> And probably the reason why you can "map" 928 MB in a short memory system
> is becasuee you are actually seeing virtual memory allocation. The test
> is touching just 2 pages instead of all:

> 	((char *)addr)[0] = 'a';
> 	((char *)addr)[CHUNK_SZ - 1] = 'z';

> can you try to apply a memset() for the whole allocation and see what
> happens? The only problem if I use this method, tho, is that memory might
> be swapped out.

If you mean something like code below, the result is the same (+ of course big
slowdown).

+++ testcases/kernel/syscalls/mmap/mmap24.c
@@ -67,8 +67,9 @@ static void run(void)
                        return;
                }

-               ((char *)addr)[0] = 'a';
-               ((char *)addr)[CHUNK_SZ - 1] = 'z';
+               for (size_t j = 0; j < CHUNK_SZ; j++) {
+                       ((char *)addr)[j] = 'a';
+               }

                addrs[num_chunks++] = addr;
        }

> I will send a new version with PROT_NONE that is allocating virtual
> pages and changing a bit the logic of the final check.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
