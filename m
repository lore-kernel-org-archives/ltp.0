Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20204C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 12:03:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB6573E287A
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 14:03:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 472713E1F82
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 14:02:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 997E820012E
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 14:02:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5956976494;
 Fri, 10 Jul 2026 12:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783684970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDijSv+OtUfvx1RP7clksIXtYJKnPKLddHlyF2qjg1g=;
 b=VyWwSpApzEkPHy5y7CNyaD6AQoPaJLl48GQdhazCGu2udm2Nmga24euybSS/BCCTKwe8Dn
 sGoVZpVBryT4/3+XqTPyQvICGvl8NvSxb9Zl+dEf91p0TNeuC7am2if4UOG1PKD2j3nV2c
 E7n0WxU2b9DfGWK6xJPIJ6oZQxDb6lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783684970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDijSv+OtUfvx1RP7clksIXtYJKnPKLddHlyF2qjg1g=;
 b=PedF4cBCoK9BISoHWugR+vNlyjDq41Lnb5uzPuCCSvQ+deL1tRn1lR2EK8d60JUbB8K/vH
 E73Nm8XeAmwW+YDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VyWwSpAp;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PedF4cBC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1783684970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDijSv+OtUfvx1RP7clksIXtYJKnPKLddHlyF2qjg1g=;
 b=VyWwSpApzEkPHy5y7CNyaD6AQoPaJLl48GQdhazCGu2udm2Nmga24euybSS/BCCTKwe8Dn
 sGoVZpVBryT4/3+XqTPyQvICGvl8NvSxb9Zl+dEf91p0TNeuC7am2if4UOG1PKD2j3nV2c
 E7n0WxU2b9DfGWK6xJPIJ6oZQxDb6lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1783684970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDijSv+OtUfvx1RP7clksIXtYJKnPKLddHlyF2qjg1g=;
 b=PedF4cBCoK9BISoHWugR+vNlyjDq41Lnb5uzPuCCSvQ+deL1tRn1lR2EK8d60JUbB8K/vH
 E73Nm8XeAmwW+YDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43049779BE;
 Fri, 10 Jul 2026 12:02:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OfeaD2rfUGoFNwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 10 Jul 2026 12:02:50 +0000
Date: Fri, 10 Jul 2026 14:02:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <alDfPHAbN8nssBgX@rei>
References: <20260709175927.268677-1-japo@linux.ibm.com> <alDW49sRfwx0eBw5@rei>
 <alDbqPsc3ueUqXlN@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alDbqPsc3ueUqXlN@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5956976494
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/1] thp04: Add ptrace mode and fix tracee stop
 synchronization
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
> That's a fair point.
> 
> The main goal was to keep thp04 functional on kernels with
> CONFIG_PROC_MEM_FORCE_PTRACE=y, where direct writes via /proc/self/mem
> are no longer possible.
> 
> Do you have a preference for how support for that configuration should
> look?
> 
> Would you prefer:
> 
>   1. Keeping thp04 focused on the original race test and skipping it
>      when only ptrace-based writes are available?
>
>   2. Splitting the ptrace write validation into a separate testcase and
>      leaving thp04 unchanged?
> 
>   3. Some other approach?

1 + 2 please.

The thp04 is a CVE regression test, if there is no chance to trigger the
CVE it should just report TCONF.


> I'm mostly trying to understand the intended coverage for
> CONFIG_PROC_MEM_FORCE_PTRACE=y before making further changes.

For that we should add tests under testcases/syscalls/ptrace/. I suppose
that we need a test that would check that the process cannot modify
itself when that config option is enabled. And another test that would
validate that parent can access child memory.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
