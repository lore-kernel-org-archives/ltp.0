Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB40C3ABC3
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 08:24:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C06D3CC1C5
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 10:24:01 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AA173CC155
 for <ltp@lists.linux.it>; Fri,  9 May 2025 10:23:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D219260070D
 for <ltp@lists.linux.it>; Fri,  9 May 2025 10:23:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 511F52115A;
 Fri,  9 May 2025 08:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746779023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B3RzVtxQnnilXY22E9Ktae77gAB+PImeg8CofiwQC9M=;
 b=KPqmjro41mh2lKUukmMcIa99kDstg4EgPSs7WIiltz224xYiKJflJDPF1hajv8ZCaEXB+l
 oHo1vKEFHWR1TIQAk6T5/0RcsTw2pvtmKQFyvXjxU7MGwT+st84B5wS/rBYoOP9H4l8Ajd
 21lfEIfBWXBT1vjvmU95dFSGygPX6Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746779023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B3RzVtxQnnilXY22E9Ktae77gAB+PImeg8CofiwQC9M=;
 b=amKWhqi0PiW6I7lhdAT1OWb/Zj5EzNiw6bhKIh2uHRRgz1gG+6UvQjOY+sSIce5uxFolaE
 fLqNBSRa03bRgKDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KPqmjro4;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=amKWhqi0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746779023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B3RzVtxQnnilXY22E9Ktae77gAB+PImeg8CofiwQC9M=;
 b=KPqmjro41mh2lKUukmMcIa99kDstg4EgPSs7WIiltz224xYiKJflJDPF1hajv8ZCaEXB+l
 oHo1vKEFHWR1TIQAk6T5/0RcsTw2pvtmKQFyvXjxU7MGwT+st84B5wS/rBYoOP9H4l8Ajd
 21lfEIfBWXBT1vjvmU95dFSGygPX6Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746779023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B3RzVtxQnnilXY22E9Ktae77gAB+PImeg8CofiwQC9M=;
 b=amKWhqi0PiW6I7lhdAT1OWb/Zj5EzNiw6bhKIh2uHRRgz1gG+6UvQjOY+sSIce5uxFolaE
 fLqNBSRa03bRgKDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D7E513931;
 Fri,  9 May 2025 08:23:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XjfzDY+7HWh9WAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 09 May 2025 08:23:43 +0000
Date: Fri, 9 May 2025 10:24:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Mark Wielaard <mark@klomp.org>
Message-ID: <aB27uWaPgL1q-akl@yuki.lan>
References: <20250429052247.GA144682@pevik> <aBSVO8uOE86UGIcp@yuki.lan>
 <4428939d-dc71-488b-9728-030accaca3e8@suse.cz>
 <aBh9Z4QA2YcdOFq1@rei.lan> <20250506080520.GA64990@pevik>
 <20250507151148.yhrnckco7zkrpfzw@lida.tpb.lab.eng.brq.redhat.com>
 <aBt8PJNmiJNuSEB5@yuki.lan>
 <adfcd1e3f129c97c2132a138e70599642566886a.camel@klomp.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adfcd1e3f129c97c2132a138e70599642566886a.camel@klomp.org>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 511F52115A
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; URIBL_BLOCKED(0.00)[yuki.lan:mid];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP in valgrind :)
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
Cc: Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> That looks pretty interesting, I just tried it and it turns:
> 
> $ ./testcases/kernel/syscalls/dup/dup01 
> tst_tmpdir.c:316: TINFO: Using /tmp/LTP_dupbmNNGn as tmpdir (tmpfs filesystem)
> tst_test.c:1907: TINFO: LTP version: VALGRIND_3_25_0-10-g0ce068434ec3
> tst_test.c:1911: TINFO: Tested kernel: 6.13.11-200.fc41.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Apr 10 19:02:09 UTC 2025 x86_64
> tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.13.11-200.fc41.x86_64/build/.config'
> tst_test.c:1729: TINFO: Overall timeout per run is 0h 00m 30s
> dup01.c:24: TPASS: dup(fd) returned fd 4
> dup01.c:27: TPASS: buf1.st_ino == buf2.st_ino (6921515)
> 
> Summary:
> passed   2
> failed   0
> broken   0
> skipped  0
> warnings 0
> 
> into:
> 
> $ LTP_REPRODUCIBLE_OUTPUT=1 ./testcases/kernel/syscalls/dup/dup01 
> tst_tmpdir.c:316: 
> tst_test.c:1907: 
> tst_test.c:1911: 
> tst_kconfig.c:88: 
> tst_test.c:1729: 
> dup01.c:24: 
> dup01.c:27: 
> 
> Summary:
> passed   2
> failed   0
> broken   0
> skipped  0
> warnings 0
> 
> So that still shows the "code flow" and the test results Summary (all
> output goes to stderr). I think this would indeed be useful to compare
> if a testcase runs the same "native" and under valgrind.

I will send a proper LTP patch.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
