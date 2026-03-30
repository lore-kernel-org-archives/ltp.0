Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45DBDFF4956
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 07:24:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0D3F3E4EFB
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 09:24:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F70B3E1FB4
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 09:24:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 95A6D100041C
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 09:24:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F05A55BE7A;
 Mon, 30 Mar 2026 07:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774855454;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pw3NFxvbwZl7VPm+OBtD0Dl9FOqby479hzlZQocOz6c=;
 b=ZRj2x450GPbduqCmqnaTfUOtuZuDUK7uo8VprJfdjGzKFl8CVv2Cd9mabdDDZH3A8fa/tm
 fj7sPXjTBzH/rpy39230qldiEel96v/XEMHFTh4FKgyYzauSgRzOIKe4V8nRUtYNSL/+QY
 JFUFjroYTZnCEgiJreUs3dJ3ykbbO3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774855454;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pw3NFxvbwZl7VPm+OBtD0Dl9FOqby479hzlZQocOz6c=;
 b=pq7SMittoUHchCksq3BEZVSWe9v/WHUX7P72Ls028vMejUji0l610/d3hI6geWBTMHyg3u
 TLUR3lBLHgu+PLAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774855453;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pw3NFxvbwZl7VPm+OBtD0Dl9FOqby479hzlZQocOz6c=;
 b=SBwWkOMCpeA+hPZdvGm2lH7wB1m6q6H2A+1G2rIA9Wn/O4Uu8L7eaXGWNpePbdwXsDT26x
 6uIFJh1xlgC17H2CTg21frk8Gn59n6aCk1whXl7gB5Xch2kkdcp82NufRCKGTFysHoADIG
 vfROtn173jglYFpKDISC9liar5CGo2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774855453;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pw3NFxvbwZl7VPm+OBtD0Dl9FOqby479hzlZQocOz6c=;
 b=VHmW71q6g5C4x5ekItTdzQGy4lPlmbE0Udf6jiAcyqjG2ej/kq4btELcL5LJ4hsjYeDO2K
 K688iFaeyrCirCAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C06454A0A2;
 Mon, 30 Mar 2026 07:24:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eZcCLh0lymnvGwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 30 Mar 2026 07:24:13 +0000
Date: Mon, 30 Mar 2026 09:24:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <20260330072412.GA62327@pevik>
References: <20260327160157.76906-1-rbranco@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260327160157.76906-1-rbranco@suse.de>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] userfaultfd: Minor fixes
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

Hi all,

> - Use POSIX semantics for thread function
> - Set cleanup to call reset_pages

LGTM.

As a separate effort: Cyril raised a question if (as a separate effort) should
all test have some kconfig check (e.g. CONFIG_USERFAULTFD=y)

IMHO it's a question if we are ok with wide spread of needs_kconfig even if it's
not necessary (i.e. here SAFE_USERFAULTFD() check. In that case the benefit
would be 1) documentation of dependencies for testers in the test catalog 2)
check earlier that before running test code. And of course disadvantage to
really drag kconfig dependency, but we have accepted that already.

Ideally we'd decide on some policy (which may also includes .needs_drivers).
@all I planned to reword my original policy patch [1] to Li's suggestion +
Cyril's kconfig changes [2], but that still does not have "use kconfig to
document dependencies".

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20260128080121.18878-1-pvorel@suse.cz/
[2] https://patchwork.ozlabs.org/comment/3662031/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
