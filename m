Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABEEC3DA4A
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 11:02:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E3C53CDE6E
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 13:02:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5A793C21C7
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:02:08 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 113831A0C253
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 13:02:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8420D21A89;
 Thu, 11 Jul 2024 11:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720695726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s8w5UQFJdBWq7G1xFEBYj81zIvEDBP8UyEd3AJzcxtU=;
 b=Eq4eXshgf46AO4LSB6IUPII+kSqnJcuV/X+zzSADWZiYBmre9nh/equSVwZaVOLd+pviHo
 WnaZy24HnfvAm9azElfmyyXwd7x573w5nc1iZjS2xONn+xaqTWWfadgwwu0lowJ5fhPaxV
 mF35hfH8pX2cdPvgMzVjSUQWqshCUTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720695726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s8w5UQFJdBWq7G1xFEBYj81zIvEDBP8UyEd3AJzcxtU=;
 b=9IvwAeow+ptaKr17TfUtAMBhV4SPI2svo2UsfJSpnKQWW//Trs1Bn64k6z0rjxI5+0AhQY
 zHX+es9uG9M/H/Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720695726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s8w5UQFJdBWq7G1xFEBYj81zIvEDBP8UyEd3AJzcxtU=;
 b=Eq4eXshgf46AO4LSB6IUPII+kSqnJcuV/X+zzSADWZiYBmre9nh/equSVwZaVOLd+pviHo
 WnaZy24HnfvAm9azElfmyyXwd7x573w5nc1iZjS2xONn+xaqTWWfadgwwu0lowJ5fhPaxV
 mF35hfH8pX2cdPvgMzVjSUQWqshCUTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720695726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s8w5UQFJdBWq7G1xFEBYj81zIvEDBP8UyEd3AJzcxtU=;
 b=9IvwAeow+ptaKr17TfUtAMBhV4SPI2svo2UsfJSpnKQWW//Trs1Bn64k6z0rjxI5+0AhQY
 zHX+es9uG9M/H/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 734E9136AF;
 Thu, 11 Jul 2024 11:02:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j+kxG667j2YxUAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 11 Jul 2024 11:02:06 +0000
Date: Thu, 11 Jul 2024 13:01:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Zo-7oBzMMyrrVA-Z@yuki>
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
 <20240710-landlock-v2-9-ff79db017d57@suse.com>
 <CAEemH2crUwPREXw=QTWSNEUk-_cs0vLeg_VYAgyBuUe5Cet3ow@mail.gmail.com>
 <bddb07dc-d8a2-4946-bfba-8f476bc24613@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bddb07dc-d8a2-4946-bfba-8f476bc24613@suse.com>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.995];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 09/11] Add landlock04 test
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
> The only library we need is libc.so, which is usually installed in /lib 
> or /lib64. I don't really know if LTP supported distros which place libc 
> somewhere else.
> Do you have suggestions on how to get shared-libs eventually? Because 
> the only way I know is to call dladdr() but it doesn't seem the way to 
> go (I obtain the current binary file)

I guess that you can parse /proc/self/maps to get paths to currenlty
loaded so files.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
