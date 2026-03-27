Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4111A10BA453
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 09:05:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A51C63CBFB0
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 10:05:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 935393C2AF4
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 10:05:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A7C63601CDB
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 10:05:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BFFE24D343;
 Fri, 27 Mar 2026 09:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774602307;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4BoOzmCTJ9huteR6LibWup6+6a9skbMzf2O7PVjUsZM=;
 b=A9ZTpsT3rMk5xJm5+rVu9rUKSohyu8Y4S41yOR59TDqfH+0FG1Enix+1c3skiBLv2YZJl1
 6tOAWZvBMHgacRmVwP+/EMUWalN82Y8taaYS/HwsVPZUNQiwJU5Kk1wk2Kfn7lPlMi/Xha
 uADN4IX0Bi7ERN3ZWMPqW1EBDOampsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774602307;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4BoOzmCTJ9huteR6LibWup6+6a9skbMzf2O7PVjUsZM=;
 b=NL1G+M2cR/W2aigxtelgWNDPEptX6mQuvJnzyA8q4zp1I4gANe8Re5ixS40DfUxFONbeV6
 DLesmMST/DpJyWAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CgAuWMi2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Rg2pYaP4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774602306;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4BoOzmCTJ9huteR6LibWup6+6a9skbMzf2O7PVjUsZM=;
 b=CgAuWMi2uEnBTGchQcO7SlIbMblvkVao5mGdqbbFIcm8WOpwv7GjJLTUh5vx/fRiLiNgjv
 h7vt53updE7gxwjiCdqDIBYlY9UACHetIE/I2tjf9B0HhLmfq0+HUCham78Zu+EKlANNj7
 D0HMLa+3R5GLyrJEb+6jB403GNKCL8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774602306;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4BoOzmCTJ9huteR6LibWup6+6a9skbMzf2O7PVjUsZM=;
 b=Rg2pYaP4Cxd65G51B3crpGyuA+Pc/wTpUYwpbz+yI8zvvq1B8teJnjmxTUcAIEyMzi/iUL
 L8JT8KTk8i1LPJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C6EE4A0A2;
 Fri, 27 Mar 2026 09:05:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ukFHJUJIxmnkBgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Mar 2026 09:05:06 +0000
Date: Fri, 27 Mar 2026 10:05:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260327090505.GA40147@pevik>
References: <20260326125216.159239-1-pvorel@suse.cz>
 <acYYc47HXGYa5Mqj@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <acYYc47HXGYa5Mqj@redhat.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:email,ozlabs.org:url];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,ozlabs.org:url];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BFFE24D343
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] userfaultfd03.c: Require kernel 6.1
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

TL;DR: refusing my patch. I'm sorry for the noise.

> On Thu, Mar 26, 2026 at 01:52:15PM +0100, Petr Vorel wrote:
> > Required kernel functionality was added in kernel 6.1 (not 6.11)

> - int res = (tst_kvercmp(6, 1, 0) < 0) ? TCONF : TBROK;
First of all, I'm sorry. I was somehow blind to see kernel check above as 6.11,
of course it is 6.1. That was the main idea about this patch.

> > 2d5de004e009 ("userfaultfd: add /dev/userfaultfd for fine grained access control")

> > Because it's a new kernel functionality which has not been backported to
> > enterprise kernels we can simplify check with just .min_kver.

> > Fixes: b63ab54aee ("userfaultfd: Do not use min_kver as gate for test")
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi all,

> > @Li I suppose RHEL kernel haven't backport this.

> Why do you lack confidence in RHEL? haha :)

Lol :). No, just my bad memory and info being on a different place.

> I have confimed that both RHEL 9 and 10 have backported this
> feature (commit 2d5de004e009).

I'm sorry, I have forgotten it. Now I remember you did some related
contributions but 1) that were in userfaultfd05.c (different file), 2) while
this info is in patch on ML [1] instead of it 1840ee23d1 ("userfaultfd05:
require CONFIG_HAVE_ARCH_USERFAULTFD_WP") was merged which does not have this
info.

Having written a reason for things being done differently helps to keep things
not being accidentally removed (or realize it's no longer needed and can be
removed). It's enough to have the info in git log (not everything has to be
documented as a comment in the code). Having it in elsewhere (PR description,
different patch) usually means the info is lost. Also finding the relevant
discussion is why I put Link: tag with URL to patch in lore (yes, I trust lore
archive more than our mailing list archive).

Not everything needs to be in form of a comment in the code, but it's
helps to find the reason if it's at least in git log.

> As RHEL 9 is based on an older kernel(5.14) but includes this
> backport, changing this to .min_kver = "6.1" will cause the
> test to be incorrectly skipped (TCONF) on RHEL 9 systems.

Thanks for info. Of course it will stay. But it'd be good to comment
"needed for RHEL 9" in the test (unfortunately it's not in the commit message).

> Anyway, back to the topic, what is the point of creating this patch?
> Anything I missed?

Nothing besides trying to fix 6.11 (which was not the case) and trying to
simplify. But whole effort is somehow relevant to general checking test
requirements cleanup (we had a discussion runtime checks vs. kconfig/min_kver
which resulted in Cyril's "lib: tst_kconfig: Add runtime checks" [2]).

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20260123054056.131992-1-liwang@redhat.com/
[2] https://patchwork.ozlabs.org/project/ltp/patch/20260326144006.3035-1-chrubis@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
