Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4021FC3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 15:13:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 454213CE77F
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 16:13:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EAB73CB5F0
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 16:12:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E1328600E2F
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 16:12:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EBE711FD17;
 Wed,  3 Jan 2024 15:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704294778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGfAHKM5hre362A8GCvCa+M9bQt/dwX6pHV+NxNjSMc=;
 b=Ue6qfMohrpAMWcDcgEXwEIT7sna/qmqhAHE/qawPdwIE1EkOObi+67YaWZrXfTa7YNzfkI
 mNgU1HFCdWVi1UA+K7aK3/kNrZTOwPWYsqFM6M25ZL7FHPe7UQk3ku9tuhVLDj5lDlC6Jo
 aVGMud3qCN+cGD0R1FGCsxhECnEx5JM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704294778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGfAHKM5hre362A8GCvCa+M9bQt/dwX6pHV+NxNjSMc=;
 b=/Fk/jkL7Ee2uxohKckHF3Jf7heb0UNKAuwNUZzF227W1j/52aTqqJlExbOL3P87v2BNAK5
 3bC7vAvuwZCRNGCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704294777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGfAHKM5hre362A8GCvCa+M9bQt/dwX6pHV+NxNjSMc=;
 b=knU+xImlRgcHYXpx9WpVQeAuj0EOxFswHf6jDKMF3wIlxaapNFubU+cj5hY/PuXI4jUWCr
 xHBk4CNa2AvxUQMRrSVUb1cnqS+Zf0zW+6wUgCRsvUyuQZ2DJm9fpkM1PTQ5V4Z9ZszJZq
 9E93O7g86Vk+qQZbUyrW20d7FD8gOVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704294777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uGfAHKM5hre362A8GCvCa+M9bQt/dwX6pHV+NxNjSMc=;
 b=SIcgkea5p93spS6OjOaf4z58urKy8CdKoBK5ppl4XJT2QOfAupUhPg4zWtRcQEosvyG/WN
 Irz7BZIVCjtHRRAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7BB31340C;
 Wed,  3 Jan 2024 15:12:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ONvwMnl5lWWFVgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Jan 2024 15:12:57 +0000
Date: Wed, 3 Jan 2024 16:13:22 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Subramanya <subramanya.swamy.linux@gmail.com>
Message-ID: <ZZV5kqaLvY93tN92@yuki>
References: <20240103121726.1854-1-subramanya.swamy.linux@gmail.com>
 <ZZVX1LUDuJGOxEXu@yuki>
 <939ec35c-f372-4806-8073-88d35defcf56@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <939ec35c-f372-4806-8073-88d35defcf56@gmail.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [3.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_SPAM_LONG(3.50)[1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FREEMAIL_TO(0.00)[gmail.com]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[33.18%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] read_all :catch alignment faults while reading
 sys entries seen in commit :bc21785b7336619fb6a67f1fff5afdaf229acc
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
> > So the intention is to read the buffer in smaller chunks? I guess that
> > it's hard to tell without having seen the kernel bugfix.
> 
> My bad i provided the wrong commit id in the commit message for the 
> kernel bugfix, 
> https://github.com/torvalds/linux/commit/1bbc21785b7336619fb6a67f1fff5afdaf229acc 

So it looks like the problem happens when we attempt to read the memory
with unaligned offset, so I suppose that single:

pread(fd, buf, 16, 1);

Should trigger the problem, or do I miss something?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
