Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB06C606F3C6
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=g3RBkXec;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nvcBZPI1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=g3RBkXec;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nvcBZPI1
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 533F83EB011
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 16:59:34 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C42053E60E0
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 16:59:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2CB361A00800
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 16:59:19 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C50D2201A;
 Mon,  2 Nov 2026 15:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793635156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GbHKcheLDsJky1neuCrHNv0kauIOJ3TmsAzTOkyYYWM=;
 b=g3RBkXecVLDFyhIVpRA8787EoTkwfdtlms78kPd4vFMCIjpfpQz1Axg1/4LKzg8yFIbTFI
 UVE6ZesRKcIzpYbZokJm0m4WBYPtpjIDR7zsIWeQ30CtjiE/biEVbjilka2gvBEzikbBX5
 hC8+Fwhr5LErbfRMx80BFVMaEjutCxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793635156;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GbHKcheLDsJky1neuCrHNv0kauIOJ3TmsAzTOkyYYWM=;
 b=nvcBZPI1PiTx4LVAqroO7+FomzJ+3UDqPq0wNnAwQV1CBayPeVR22GjG9B7lHnwQdI6Dke
 NfbhSJjRxefCt9AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793635156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GbHKcheLDsJky1neuCrHNv0kauIOJ3TmsAzTOkyYYWM=;
 b=g3RBkXecVLDFyhIVpRA8787EoTkwfdtlms78kPd4vFMCIjpfpQz1Axg1/4LKzg8yFIbTFI
 UVE6ZesRKcIzpYbZokJm0m4WBYPtpjIDR7zsIWeQ30CtjiE/biEVbjilka2gvBEzikbBX5
 hC8+Fwhr5LErbfRMx80BFVMaEjutCxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793635156;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GbHKcheLDsJky1neuCrHNv0kauIOJ3TmsAzTOkyYYWM=;
 b=nvcBZPI1PiTx4LVAqroO7+FomzJ+3UDqPq0wNnAwQV1CBayPeVR22GjG9B7lHnwQdI6Dke
 NfbhSJjRxefCt9AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 359DF134B3;
 Mon,  2 Nov 2026 15:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6XDuAVSz6GpHGwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 02 Nov 2026 15:59:16 +0000
Date: Mon, 2 Nov 2026 16:59:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <auiza7MDTyAN1sC0@yuki.lan>
References: <20260923080150.44934-1-pavrampu@linux.ibm.com>
 <20260923100043.9301-1-linuxtestproject.agent@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260923100043.9301-1-linuxtestproject.agent@gmail.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -13.30
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugetlb/hugefallocate: Add hugefallocate03 to stress test
 fallocate on hugetlbfs
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
> > +	SAFE_SIGACTION(SIGBUS, &sa, NULL);
> > +
> > +	fault_mmap_addr = SAFE_MMAP(NULL, max_hpages * hpage_size,
> > +			PROT_READ | PROT_WRITE, MAP_SHARED,
> > +			fd, 0);
> > +
> > +	pthread_cleanup_push(thread_fault_cleanup, NULL);
> > +
> > +	while (1) {
> > +		tpage = ((long long)random()) % (max_hpages);
> > +
> > +		if (sigsetjmp(fault_jmp, 1) == 0) {
> > +			foo = *((char *)(fault_mmap_addr + (tpage * hpage_size)));
> > +			*((volatile char *)(fault_mmap_addr + (tpage * hpage_size))) = foo;
> > +		}
> 
> Save the original SIGBUS handler and restore it upon thread termination or in
> cleanup. If SIGBUS is raised after this thread terminates, siglongjmp() jumps
> to an invalid stack.

More generally we can just remove all the thread cleanup registration
and cancelation points if we just do:

static volatile int run;

...

void *pthread_func(void *)
{
	...

	while (run) {
		...
	}

	SAFE_MUNMAP(...);
	reutrn NULL;
}

The main thread can then stop all three threads by setting run = 0 and
the cleanup runs without the pthread cleanup complexity.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
