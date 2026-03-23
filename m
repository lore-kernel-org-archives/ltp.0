Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD176F483C8
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 16:33:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 81F483E5F0F
	for <ltp@archiver.kernel.org>; Mon, 23 Mar 2026 17:33:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A7E333E5C92
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 17:32:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3051A1000406
 for <ltp@lists.linux.it>; Mon, 23 Mar 2026 17:32:45 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6CAE35BE4D;
 Mon, 23 Mar 2026 16:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774283564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KiFSI8XFQiSKoXAvJwOlSO4RUmqdIv5Ogif+BYohf2k=;
 b=XVA0l6P9x1Hv8HRDEvfoJLlDryHEHsm7yKoRLmlIDKOPMNNQgGhH7l+QhKWPbxXhazuEt6
 Eozhb+lOQClzSrjTUShKOf1/z0qNAGSQtmekxx4kmVcBUg5bDu5mgxeKIFG5JjTccvffEq
 PDNFKHplL18QT6+kha0fzleccfOE86Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774283564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KiFSI8XFQiSKoXAvJwOlSO4RUmqdIv5Ogif+BYohf2k=;
 b=qaXMwlbvTooTZ/jpP+zLwEQrpQ1j1ywP+Mwq3smNaM01Y/xoqir4oj09j2D1LYk0NsQV94
 lI+Xx6ehTEyBmBDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XVA0l6P9;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qaXMwlbv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774283564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KiFSI8XFQiSKoXAvJwOlSO4RUmqdIv5Ogif+BYohf2k=;
 b=XVA0l6P9x1Hv8HRDEvfoJLlDryHEHsm7yKoRLmlIDKOPMNNQgGhH7l+QhKWPbxXhazuEt6
 Eozhb+lOQClzSrjTUShKOf1/z0qNAGSQtmekxx4kmVcBUg5bDu5mgxeKIFG5JjTccvffEq
 PDNFKHplL18QT6+kha0fzleccfOE86Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774283564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KiFSI8XFQiSKoXAvJwOlSO4RUmqdIv5Ogif+BYohf2k=;
 b=qaXMwlbvTooTZ/jpP+zLwEQrpQ1j1ywP+Mwq3smNaM01Y/xoqir4oj09j2D1LYk0NsQV94
 lI+Xx6ehTEyBmBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4028E43985;
 Mon, 23 Mar 2026 16:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GodwDixrwWmOIwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 23 Mar 2026 16:32:44 +0000
Date: Mon, 23 Mar 2026 17:32:44 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <acFrLJYeI3U4Fc1k@yuki.lan>
References: <20260320124742.75946-1-sachinp@linux.ibm.com>
 <20260320124742.75946-4-sachinp@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260320124742.75946-4-sachinp@linux.ibm.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6CAE35BE4D
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] io_uring: Refactor io_uring01 to use common
 code
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
> -static int setup_io_uring_test(struct submitter *s, struct tcase *tc)
> +static int setup_io_uring_test(struct io_uring_submit *s, struct tcase *tc)
>  {
>  	struct io_sq_ring *sring = &s->sq_ring;
>  	struct io_cq_ring *cring = &s->cq_ring;
> @@ -83,43 +46,42 @@ static int setup_io_uring_test(struct submitter *s, struct tcase *tc)
>  		return 1;
>  	}
>  
> -	sptr_size = p.sq_off.array + p.sq_entries * sizeof(unsigned int);
> +	s->sq_ptr_size = p.sq_off.array + p.sq_entries * sizeof(unsigned int);
>  
>  	/* Submission queue ring buffer mapping */
> -	sptr = SAFE_MMAP(0, sptr_size,
> -			PROT_READ | PROT_WRITE,
> -			MAP_SHARED | MAP_POPULATE,
> -			s->ring_fd, IORING_OFF_SQ_RING);
> +	s->sq_ptr = SAFE_MMAP(0, s->sq_ptr_size,
> +			      PROT_READ | PROT_WRITE,
> +			      MAP_SHARED | MAP_POPULATE,
> +			      s->ring_fd, IORING_OFF_SQ_RING);
>  
>  	/* Save global submission queue struct info */
> -	sring->head = sptr + p.sq_off.head;
> -	sring->tail = sptr + p.sq_off.tail;
> -	sring->ring_mask = sptr + p.sq_off.ring_mask;
> -	sring->ring_entries = sptr + p.sq_off.ring_entries;
> -	sring->flags = sptr + p.sq_off.flags;
> -	sring->array = sptr + p.sq_off.array;
> +	sring->head = s->sq_ptr + p.sq_off.head;
> +	sring->tail = s->sq_ptr + p.sq_off.tail;
> +	sring->ring_mask = s->sq_ptr + p.sq_off.ring_mask;
> +	sring->ring_entries = s->sq_ptr + p.sq_off.ring_entries;
> +	sring->flags = s->sq_ptr + p.sq_off.flags;
> +	sring->array = s->sq_ptr + p.sq_off.array;
>  
>  	/* Submission queue entries ring buffer mapping */
> -	s->sqes = SAFE_MMAP(0, p.sq_entries *
> -			sizeof(struct io_uring_sqe),
> -			PROT_READ | PROT_WRITE,
> -			MAP_SHARED | MAP_POPULATE,
> -			s->ring_fd, IORING_OFF_SQES);
> +	s->sqes = SAFE_MMAP(0, p.sq_entries * sizeof(struct io_uring_sqe),
> +			    PROT_READ | PROT_WRITE,
> +			    MAP_SHARED | MAP_POPULATE,
> +			    s->ring_fd, IORING_OFF_SQES);
>  
> -	cptr_size = p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe);
> +	s->cq_ptr_size = p.cq_off.cqes + p.cq_entries * sizeof(struct io_uring_cqe);
>  
>  	/* Completion queue ring buffer mapping */
> -	cptr = SAFE_MMAP(0, cptr_size,
> -			PROT_READ | PROT_WRITE,
> -			MAP_SHARED | MAP_POPULATE,
> -			s->ring_fd, IORING_OFF_CQ_RING);
> +	s->cq_ptr = SAFE_MMAP(0, s->cq_ptr_size,
> +			      PROT_READ | PROT_WRITE,
> +			      MAP_SHARED | MAP_POPULATE,
> +			      s->ring_fd, IORING_OFF_CQ_RING);
>  
>  	/* Save global completion queue struct info */
> -	cring->head = cptr + p.cq_off.head;
> -	cring->tail = cptr + p.cq_off.tail;
> -	cring->ring_mask = cptr + p.cq_off.ring_mask;
> -	cring->ring_entries = cptr + p.cq_off.ring_entries;
> -	cring->cqes = cptr + p.cq_off.cqes;
> +	cring->head = s->cq_ptr + p.cq_off.head;
> +	cring->tail = s->cq_ptr + p.cq_off.tail;
> +	cring->ring_mask = s->cq_ptr + p.cq_off.ring_mask;
> +	cring->ring_entries = s->cq_ptr + p.cq_off.ring_entries;
> +	cring->cqes = s->cq_ptr + p.cq_off.cqes;
>  
>  	return 0;
>  }

Isn't this nearly identical to the io uring setup in the common header?

I was hoping of unifying that part as well.

> @@ -139,7 +101,7 @@ static void check_buffer(char *buffer, size_t len)
>  		tst_res(TPASS, "Buffer filled in correctly");
>  }
>  
> -static void drain_uring_cq(struct submitter *s, unsigned int exp_events)
> +static void drain_uring_cq(struct io_uring_submit *s, unsigned int exp_events)
>  {
>  	struct io_cq_ring *cring = &s->cq_ring;
>  	unsigned int head = *cring->head;
> @@ -175,7 +137,7 @@ static void drain_uring_cq(struct submitter *s, unsigned int exp_events)
>  	        events, exp_events);
>  }
>  
> -static int submit_to_uring_sq(struct submitter *s, struct tcase *tc)
> +static int submit_to_uring_sq(struct io_uring_submit *s, struct tcase *tc)
>  {
>  	unsigned int index = 0, tail = 0, next_tail = 0;
>  	struct io_sq_ring *sring = &s->sq_ring;
> @@ -229,23 +191,20 @@ static int submit_to_uring_sq(struct submitter *s, struct tcase *tc)
>  
>  static void cleanup_io_uring_test(void)
>  {
> -	io_uring_register(s->ring_fd, IORING_UNREGISTER_BUFFERS,
> +	io_uring_register(s.ring_fd, IORING_UNREGISTER_BUFFERS,
>  			  NULL, QUEUE_DEPTH);
> -	SAFE_MUNMAP(s->sqes, sizeof(struct io_uring_sqe));
> -	SAFE_MUNMAP(cptr, cptr_size);
> -	SAFE_MUNMAP(sptr, sptr_size);
> -	SAFE_CLOSE(s->ring_fd);
> +	io_uring_cleanup_queue(&s, QUEUE_DEPTH);
>  }
>  
>  static void run(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
>  
> -	if (setup_io_uring_test(s, tc))
> +	if (setup_io_uring_test(&s, tc))
>  		return;
>  
> -	if (!submit_to_uring_sq(s, tc))
> -		drain_uring_cq(s, 1);
> +	if (!submit_to_uring_sq(&s, tc))
> +		drain_uring_cq(&s, 1);
>  
>  	cleanup_io_uring_test();
>  }
> -- 
> 2.39.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
