Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A29D91098782
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 14:19:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D4733E52AB
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 15:19:25 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8FF53CDFB2
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 15:19:06 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4E24D60048F
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 15:19:06 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E1D814D27B;
 Fri, 20 Mar 2026 14:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774016345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=srwMRkxj6vbQPTD+O/8Cshm7J2vSDpH+TPyYF69DyV8=;
 b=zLZsJrEmI7oCNaGekdE5j1YlQj0G3jXW2swqAAC+LndkjVYdY8rZ/W8WURsJoM7bg0CvaS
 hBzWmKvXh61nPK9S70119GQM6te1nquwZvknJ8sJCOEH+BlgOd31ph4/vfABjKGlTljOPE
 lYaV4eDx/cik3JsaAriApTDpzVvVHy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774016345;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=srwMRkxj6vbQPTD+O/8Cshm7J2vSDpH+TPyYF69DyV8=;
 b=7lxnZBmEpUER0xnNBOKOhOmeAJHGg4DMKVaSBXrM18QfrxRoqzr++fSem0pIt0GJLdJAmT
 R2Yrbt4+HL69/3Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774016344;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=srwMRkxj6vbQPTD+O/8Cshm7J2vSDpH+TPyYF69DyV8=;
 b=PG96vFgT31cB9gXNL5VWfL4VPxIN+6ffRgxogfwedFa9xloU4ugPuyPMC9+kDUzzM45k75
 nAxFq2dWBbRC6ZT3YKfsVQGZnsoQt5Kgq8+GgPs9UPj3wmQ+2PhV37FM27FH0no+6pHOam
 dQ6Zst1VNF9VOotn9osWCSa2Do2fgjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774016344;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=srwMRkxj6vbQPTD+O/8Cshm7J2vSDpH+TPyYF69DyV8=;
 b=qs0XVCVBMP0a3tezjn6C/l754wZEHDrEXw9YESMi5wdha10GwzwcvxOHDpN5q8rbuTU9Ny
 eMDAjhIyT4j/ynAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDEB74283D;
 Fri, 20 Mar 2026 14:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yId4LFhXvWmlMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 20 Mar 2026 14:19:04 +0000
Date: Fri, 20 Mar 2026 15:18:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260320141859.GA158409@pevik>
References: <20260318144113.30981-1-pvorel@suse.cz>
 <69bd15a1.050a0220.27cce5.4d03@mx.google.com>
 <20260320113040.GB140154@pevik> <ab01vxdLgFfeFSg2@yuki.lan>
 <ab02mGftGg-a4krj@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ab02mGftGg-a4krj@yuki.lan>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,du01.sh:url,suse.cz:replyto]; 
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print tcnt in tst_{brk,res}()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > tst_test.c:1887: [lib] TINFO: Overall timeout per run is 0h 00m 30s
> > > test04.c:26: [setup] TINFO: setup() executed by pid 147535
> > > test04.c:16: [test 1] TPASS: PASSED message
> > > test04.c:19: [test 2] TBROK: BROKEN message
> > > tst_test.c:479: [lib] TINFO: Child process reported TBROK killing the test
> > > tst_test.c:1950: [lib]  TINFO: Killed the leftover descendant processes

> > This looks good to me. Maybe we can also color the setup/lib/test
> > differently if the output goes into the terminal.


> And in order to make it work in the shell as well we would need a
> function tst_set_context() that would set the current context so that we
> can call it from shell. I suppose that this needs to be designed
> carefuly in order to make ti work properly with threads/forked
> processes.

How about having enum with few states (lib, setup, test, cleanup), which would
be switched when context switches (and test_get_state() would just print the
string). And test would get the number (idea from this patch).

I'm still missing how to call C API code from shell test, because C API code
forks child and execute the script, how it could "talk back"?
The question I have asked in du01.sh rewrite:
https://lore.kernel.org/ltp/20260318154019.GE31214@pevik/

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
