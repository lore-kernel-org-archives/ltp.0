Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AFAC021A4
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 14:08:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30D7B3C9AF4
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 15:08:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 940AF3C1AFC
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 15:07:48 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 477441011986
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 15:07:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 91E2F2117B;
 Fri, 14 Feb 2025 14:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739542065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hEOuszDxu8jBr7wOb+gO9uTqMyzhUwd/70FZMcK9RQg=;
 b=o0ev2zBY4hlv8ui7bW7HM1lxzgpYkEVDgxdbiFtZNB4KzgYrzyZg3Ihgo73/uo46y7Aa98
 bSezghImKu2T6CZjgjkksX5vLBx71QxhMDXBceoRkgBiHOHhmRMZiUluFLX9+/DvhQV0J1
 AHbG23KpW4PhxcpFZ9AQ1nLiuhqvETI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739542065;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hEOuszDxu8jBr7wOb+gO9uTqMyzhUwd/70FZMcK9RQg=;
 b=oSXxS2loY5NdutxymLOhC2h6QdMSKcQYdTtmcvm1twAeF7pf/qnCx57wCCaGfqttbDIFFf
 XkMeyIOBRfCMXCAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739542064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hEOuszDxu8jBr7wOb+gO9uTqMyzhUwd/70FZMcK9RQg=;
 b=OxGb2qEAyYRFD0tTt5y04GW8VG0gnOJSqPstH50BdwkLUnj6oKTn0DPetHV3+ZAsPfwGDW
 VpVewxA3Cv2cOZZPSR4o+JX7y///ItIRYPMxKw6dytxF+JAiaMaFXpWN979YLMFjZQrId8
 bd4ihNE06VzSqKLu2wsyd2uTgFnjAng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739542064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hEOuszDxu8jBr7wOb+gO9uTqMyzhUwd/70FZMcK9RQg=;
 b=8GLhQZl2w6o/EXcOhRl0Nt+o68aqYkoJ0d8gT/k3ZEVKeVK/9k7e/4apYGmeLdCO/0PvPV
 kSWc6sZBUDbMvYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FB9E13285;
 Fri, 14 Feb 2025 14:07:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 29h2HjBOr2feGQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 14 Feb 2025 14:07:44 +0000
Date: Fri, 14 Feb 2025 15:07:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z69OLsDLMzNw6RGt@yuki.lan>
References: <20250214112135.18947-1-chrubis@suse.cz>
 <20250214112135.18947-3-chrubis@suse.cz>
 <20250214135531.GB2221874@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250214135531.GB2221874@pevik>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[test.sh:url, tst_exec.sh:url, tst_loader.sh:url,
 imap1.dmz-prg2.suse.org:helo, tst_env.sh:url, suse.cz:email, yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] shell lib: Add support for test cleanup
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
> Unfortunately TST_SETUP will not work that way - function is not found or if you
> load tst_env.sh at the end, it complains about missing tst_res or tst_brk:
> 
> ./tests/./shell_loader_brk_cleanup.sh: line 16: tst_res: command not found
> 
> Obviously it does not help to add it to tst_loader.sh.
> 
> I'm surprised it checks that, is there shopt option which could disable it?

The problem here the order the scripts are sourced. It looks like this:

test.sh
 . tst_loader.sh
  tst_run_shell test.sh
   . tst_loader.sh
    . tst_env.sh <- at this point in the execution you haven't even started
                    parsing test.sh so you cannot run functions from there
		    at all

If you wanted to have separate setup function you would have to build
things differently, you would have to execute a library shell script
by the tst_run_shell tool, which would source the test.sh and execute
the functions passed to it. So the execution would look like:

test.sh
 . tst_loader.sh
 tst_run_shell tst_exec.sh test.sh
  . test.sh
    . tst_env.sh

And then the tst_exec.sh would do:

	. "$1"

	if [ -n "$TST_SETUP" ]; then
		$TST_SETUP
	fi

	$TST_TEST

or something along these lines.

And the test.sh would have to look like:

TST_SETUP=setup
TST_CLEANUP=cleanup
TST_TEST=runtest

. tst_loader.sh


setup()
{
...
}

cleanup()
{
...
}

runtest()
{
...
}


All the code would have to be in functions.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
