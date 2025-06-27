Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDA3C77B7F
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 19:38:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1C773C92AE
	for <ltp@archiver.kernel.org>; Fri, 27 Jun 2025 21:38:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA6E93C5371
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 21:38:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 134AF1000BF2
 for <ltp@lists.linux.it>; Fri, 27 Jun 2025 21:38:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 55F4521185;
 Fri, 27 Jun 2025 19:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751053104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wWCR5PUZYHbnTWJwjSdsdC/TpoSpu8BJTHNPxGUJASU=;
 b=kSM8Njx+VxI5+bRSnLtN4ObkEs3Rj8hf0lGBQ5HaBLNsTS9n3BgEw73q5N5Cs21cuZDBYL
 khKCMNl8hmn+CWzA5SoeA/VkXkVENZKnHStH0ltQDmkClm66Ooz3kTLmfJ448F8WYxct+c
 Y7udm99I4Q1d5F0QLVELWxvCGqMgtyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751053104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wWCR5PUZYHbnTWJwjSdsdC/TpoSpu8BJTHNPxGUJASU=;
 b=8Fh9nTydfnlTjXmtnBaO7mfDt+Noza/smQvsMYcX+O6kVS0oFfHANWRHP8zO6LGgWgxLma
 vp/IvWjPCF1Bs8Dw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751053104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wWCR5PUZYHbnTWJwjSdsdC/TpoSpu8BJTHNPxGUJASU=;
 b=kSM8Njx+VxI5+bRSnLtN4ObkEs3Rj8hf0lGBQ5HaBLNsTS9n3BgEw73q5N5Cs21cuZDBYL
 khKCMNl8hmn+CWzA5SoeA/VkXkVENZKnHStH0ltQDmkClm66Ooz3kTLmfJ448F8WYxct+c
 Y7udm99I4Q1d5F0QLVELWxvCGqMgtyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751053104;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wWCR5PUZYHbnTWJwjSdsdC/TpoSpu8BJTHNPxGUJASU=;
 b=8Fh9nTydfnlTjXmtnBaO7mfDt+Noza/smQvsMYcX+O6kVS0oFfHANWRHP8zO6LGgWgxLma
 vp/IvWjPCF1Bs8Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 412CA138A7;
 Fri, 27 Jun 2025 19:38:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rBgJDjDzXmh5JQAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 27 Jun 2025 19:38:24 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 27 Jun 2025 21:38:23 +0200
Message-ID: <2803405.mvXUDI8C0e@thinkpad>
In-Reply-To: <20250627102957.4165-2-chrubis@suse.cz>
References: <20250627102957.4165-1-chrubis@suse.cz>
 <20250627102957.4165-2-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-7.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 CTE_CASE(0.50)[]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] tst_test.sh: Fix IPC init for checkpoints
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

Hi,

Tested-by: Avinesh Kumar <akumar@suse.de>

cn_pec 1 TINFO: Running: cn_pec.sh 
cn_pec 1 TINFO: Tested kernel: Linux susetest 6.15.3-1-default #1 SMP PREEMPT_DYNAMIC Sat Jun 21 19:19:18 UTC 2025 (d7f7d34) x86_64 x86_64 x86_64 GNU/Linux
cn_pec 1 TINFO: Using /tmp/LTP_cn_pec.Gsup5b4iUP as tmpdir (tmpfs filesystem)
cn_pec 1 TINFO: timeout per run is 0h 5m 0s
cn_pec 1 TINFO: Test process events connector
cn_pec 1 TINFO: Testing fork event (nevents=10)
cn_pec 1 TPASS: All events detected
cn_pec 2 TINFO: Testing exec event (nevents=10)
cn_pec 2 TPASS: All events detected
cn_pec 3 TINFO: Testing exit event (nevents=10)
cn_pec 3 TPASS: All events detected
cn_pec 4 TINFO: Testing uid event (nevents=10)
cn_pec 4 TPASS: All events detected
cn_pec 5 TINFO: Testing gid event (nevents=10)
cn_pec 5 TPASS: All events detected


Regards,
Avinesh

On Friday, June 27, 2025 12:29:57 PM CEST Cyril Hrubis wrote:
> The introduction of magic at the start of the LTP IPC region did break
> the checkpoints for the tst_test.sh shell library. The reason is that
> the library creates the IPC backing file with dd and the magic wasn't
> present there.
> 
> This introduced failures in the pec testcases:
> 
>   cn_pec 1 TINFO: Test process events connector
>   cn_pec 1 TINFO: Testing fork event (nevents=10)
>   tst_test.c:203: TBROK: Invalid shared memory region (bad magic)
>   cn_pec 1 TBROK: tst_checkpoint wait 10000 0 failed
> 
> This patch fixes the tst_test.sh library so that the IPC region is
> created with a correct magic.
> 
> Follow-up: bf9589d5bd ("lib: moves test infrastructure states into a shared context structure")
> Reported-by: Avinesh Kumar <akumar@suse.de>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/lib/tst_test.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index c32bd8b19..4be10a4f9 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -627,6 +627,7 @@ _tst_init_checkpoints()
>  		tst_brk TBROK "tst_getconf PAGESIZE failed"
>  	fi
>  	ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$pagesize" count=1
> +	ROD_SILENT "printf LTPM | dd of="$LTP_IPC_PATH" bs=1 seek=0 conv=notrunc"
>  	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
>  	export LTP_IPC_PATH
>  }
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
