Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5846103E179
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 13:45:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CF153E5CAA
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 14:45:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C86B93E1107
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:44:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 52531100034E
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 14:44:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E1674D3AF;
 Wed, 18 Mar 2026 13:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773841495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KmQFVRyk1OQPyFmvk3D9TlS3ixQCgz14zXd/FkGc9k=;
 b=JmBPLtf76CAOfHGST1VcEAXwU9EcL4dTdBZIxSgdlkWSacwKhRXeKdsM8pb+/uzbXp0yBV
 WLjze3R3xt7EHwnEIeI8ijGHfzd1yc8TC61KIUr5kOCuPjT77oWQZyMV0CKQUfNHGG+U9r
 A/WqYE+9js93oiemNREw9s3mBp21FaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773841495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KmQFVRyk1OQPyFmvk3D9TlS3ixQCgz14zXd/FkGc9k=;
 b=FhgjnYbm/5IzvdsrUtVC9pl46vi0fsIF4EdXZaOrCETEGc6qReyEkGWkuA/hOQ9VM25QGF
 QaOK9jhmO8mZ9sCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773841495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KmQFVRyk1OQPyFmvk3D9TlS3ixQCgz14zXd/FkGc9k=;
 b=JmBPLtf76CAOfHGST1VcEAXwU9EcL4dTdBZIxSgdlkWSacwKhRXeKdsM8pb+/uzbXp0yBV
 WLjze3R3xt7EHwnEIeI8ijGHfzd1yc8TC61KIUr5kOCuPjT77oWQZyMV0CKQUfNHGG+U9r
 A/WqYE+9js93oiemNREw9s3mBp21FaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773841495;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0KmQFVRyk1OQPyFmvk3D9TlS3ixQCgz14zXd/FkGc9k=;
 b=FhgjnYbm/5IzvdsrUtVC9pl46vi0fsIF4EdXZaOrCETEGc6qReyEkGWkuA/hOQ9VM25QGF
 QaOK9jhmO8mZ9sCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA0814273B;
 Wed, 18 Mar 2026 13:44:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lBNANFasumlrMgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Mar 2026 13:44:54 +0000
Date: Wed, 18 Mar 2026 14:44:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20260318134453.GA19771@pevik>
References: <20260318132639.18818-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260318132639.18818-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] power_management: cleanup
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Hi,

> I wanted to delete whole old testsuite (README mentions ancient kernel
> 2.6.29.4 etc) but because Intel folks contributed power management test
> [1] and CPUFREQ/CPUIDLE sysfs tests are probably valid and should be
> rewritten.

Other problem is that all x86_64 machines I debug have all
/sys/devices/system/cpu/cpu*/topology/physical_package_id
files only 0, therefore all runpwtests_exclusive0*.sh are skipped.

> Of course README itself is also outdated (some scripts has been removed
> and code put into the servers).

> [1] https://lore.kernel.org/ltp/20260318130250.68495-2-piotr.kubaj@intel.com/


> Petr Vorel (2):
>   runpwtests03.sh: Replace modprobe -l to lsmod
>   power_management: Remove runpwtests0[125].sh

>  runtest/power_management_tests                |  3 -
Given how old tests are is completely useless "_tests" suffix on the runtest
file. I know renaming runtest files is not practical (at least Cyril was against
in the past), but in this case I'd be for renaming it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
