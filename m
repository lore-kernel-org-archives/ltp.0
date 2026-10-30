Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9911606A31A
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=yB85AetW;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Y55rCBaB;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=tS0I+tR9;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CsuxdG9T
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EE0C3E98A4
	for <ltp@archiver.kernel.org>; Fri, 30 Oct 2026 16:21:02 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B3A83E9885
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 16:20:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8BFE014010D5
 for <ltp@lists.linux.it>; Fri, 30 Oct 2026 16:20:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CB73322CDB;
 Fri, 30 Oct 2026 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793373644;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sZvcZDpb6qn7GIBmCCXbLxl0l0JJI0ojLMNlbdttaVE=;
 b=yB85AetWT1UL2iptPQ4i84SrxmJgmdwqWegahaRwSUhzJCAu4U3UAid3wewjdJeETbkpSg
 f62LsloG4iPG/vs3sklnyUZlK2+M9R81TOklN5m+6vbCNfvbA2LkB68FIhy9D09Be/WrOr
 ctIirkoqIVhHZFgEl48wyk4yMk7Y/Cg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793373644;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sZvcZDpb6qn7GIBmCCXbLxl0l0JJI0ojLMNlbdttaVE=;
 b=Y55rCBaBsgvuAqL6lNHQSgXR2ba2wXN2MaOLmw2R+geNZPxFAUYalYG8jOKN35fLYP3xuq
 wkKX6TTao0B6mgBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793373642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sZvcZDpb6qn7GIBmCCXbLxl0l0JJI0ojLMNlbdttaVE=;
 b=tS0I+tR9xaymRqhq0K5nGlz8weMB/kE8r5f72wXv0Rw6au6b7RQZB7LA+r4uwvfBePl9W1
 yZ48P06ZXtOl5KBtFab6WdV8kQEzA3AIUlBXLEFnurbNuZvZLhtqNGlWoIdH3gwHNnW7Gj
 f0fo72epcFax3mMHAZKRMm2mEyHxaoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793373642;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sZvcZDpb6qn7GIBmCCXbLxl0l0JJI0ojLMNlbdttaVE=;
 b=CsuxdG9Ti/i0BxqVMY7KX5PG4dXyIrPM/6pZdTFeo5Lg4SFrI+mBcqaUiTHrC3XBaFxkNb
 7PdmAIvq7joDn9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 350CF13432;
 Fri, 30 Oct 2026 15:20:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nK7COsm15GpuTwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 30 Oct 2026 15:20:42 +0000
Date: Fri, 30 Oct 2026 16:20:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20261030152036.GA4701@pevik>
References: <20261030113637.78343-1-pvorel@suse.cz>
 <20261030133732.3727-1-linuxtestproject.agent@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261030133732.3727-1-linuxtestproject.agent@gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_TO(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; TAGGED_RCPT(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,nfs_lib.sh:url,suse.cz:email,suse.cz:replyto,tst_net.sh:url];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] nfsstat02.sh: Properly fix netns enforcement
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi Petr,

> On Fri Oct 30 12:36:37 2026 +0100, Petr Vorel <pvorel@suse.cz> wrote:
> > nfsstat02.sh: Properly fix netns enforcement

> > diff --git a/testcases/network/nfs/nfsstat01/nfsstat02.sh b/testcases/network/nfs/nfsstat01/nfsstat02.sh
> > index 75a1a01b5..193a52b59 100755
> > --- a/testcases/network/nfs/nfsstat01/nfsstat02.sh
> > +++ b/testcases/network/nfs/nfsstat01/nfsstat02.sh
> > @@ -20,7 +20,7 @@ do_test()
> >  }

> >  # Force use of nested net namespace
> > -unset RHOST
> > +tst_net_use_netns || tst_net_unset_2_hosts_variables

> >  . nfs_lib.sh
> >  tst_run

> tst_net_use_netns and tst_net_unset_2_hosts_variables are called before
> nfs_lib.sh (which sources tst_net.sh) is sourced, so both functions are
> undefined at this point and fail with "not found". Calling them after
> sourcing nfs_lib.sh is also too late because tst_net.sh already evaluates
> RHOST and runs tst_net_setup_network at top level while being sourced. Set a
> variable such as TST_NET_FORCE_NETNS=1 before sourcing nfs_lib.sh and handle
> unsetting the 2-host variables inside tst_net.sh before the RHOST check.

I must have been really tired to overlook so obvious error.
TST_NET_FORCE_NETNS might be overkill, but I really prefer have that code in the
library than broken test due forget to set some variable.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
