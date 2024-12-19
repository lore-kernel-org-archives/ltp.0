Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A432AE77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 10:45:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 085DE3EC927
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 11:45:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 414F13E5E55
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 11:45:15 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 68F2C1BD79EC
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 11:45:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0DB8A21164;
 Thu, 19 Dec 2024 10:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734605113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7BUw2Zd0pCAu/TlV54ApAOyBCaG2yPOTpvBvkBF2gBY=;
 b=FWotnnGGnB3qIG2FzzkUcL7u1Vf+9JSzk6t+Az1oUWCDiuUjNIqnUr/oL46/+sCrIwXfMn
 b16/zDiL35W36H/Hkhzh7fsaSq6xKSE9LJjLzajLAWht/jAiPFU9OsPfQgoBi5q25Eq4RU
 xhAiyMBJIP2qGuIoNvbvsH90dUU9ZoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734605113;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7BUw2Zd0pCAu/TlV54ApAOyBCaG2yPOTpvBvkBF2gBY=;
 b=QhL9L6IttFEGyOsXz+EXJkDfQAkXsIhdeKQtg7LSCcFLtodHmtqGdU/NWuKlwLnGMSeqbq
 w7JiyzocHRpR1rAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734605113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7BUw2Zd0pCAu/TlV54ApAOyBCaG2yPOTpvBvkBF2gBY=;
 b=FWotnnGGnB3qIG2FzzkUcL7u1Vf+9JSzk6t+Az1oUWCDiuUjNIqnUr/oL46/+sCrIwXfMn
 b16/zDiL35W36H/Hkhzh7fsaSq6xKSE9LJjLzajLAWht/jAiPFU9OsPfQgoBi5q25Eq4RU
 xhAiyMBJIP2qGuIoNvbvsH90dUU9ZoM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734605113;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7BUw2Zd0pCAu/TlV54ApAOyBCaG2yPOTpvBvkBF2gBY=;
 b=QhL9L6IttFEGyOsXz+EXJkDfQAkXsIhdeKQtg7LSCcFLtodHmtqGdU/NWuKlwLnGMSeqbq
 w7JiyzocHRpR1rAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 005CC13A32;
 Thu, 19 Dec 2024 10:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E3LMOjj5Y2edZgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Dec 2024 10:45:12 +0000
Date: Thu, 19 Dec 2024 11:45:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z2P5Oqs4tSqQrVSV@yuki.lan>
References: <20241218190029.15015-1-chrubis@suse.cz>
 <20241218190029.15015-2-chrubis@suse.cz>
 <20241218190826.GA80422@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241218190826.GA80422@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/9] metadata: metaparse: Parse operators *, +,
 and | properly
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
> > +++ b/metadata/metaparse.c
> > @@ -173,6 +173,9 @@ static char *next_token2(FILE *f, char *buf, size_t buf_len, struct data_node *d
> >  		case '[':
> >  		case ']':
> >  		case '#':
> > +		case '|':
> > +		case '+':
> > +		case '*':
> 
> I suppose we don't need '/' and '%' right?

I guess that it wouldn't harm, these does not seem to be used now, but
someone may do so in the future.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
