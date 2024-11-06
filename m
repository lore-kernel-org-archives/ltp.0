Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BBFD3E78C
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 09:44:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E6243D2FD8
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 10:44:26 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B27D63D2FBB
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 10:44:09 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 32DE21BF51FA
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 10:44:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B5B7C1F86C;
 Wed,  6 Nov 2024 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730886236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DOVrUFcS1MUe6+MK/EF26nWAzUFNZgmHJoMORjmupVk=;
 b=us3fUjUT5QtZ5lkD3XtBxApMJG+U7KCP0ytn4P2z4cn0McmkJV0Nxw3NY0HyB6fbprcuKd
 UimA04cOx09Haf+9Lp7a0Q0Kxg1jdLfEU/6FEsp/ZeJ5Wg/LFiT02g5clpnfO8Z1f6XpG4
 5ePzO/4sJB2dsPOoJR5KlQW1SUGvrRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730886236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DOVrUFcS1MUe6+MK/EF26nWAzUFNZgmHJoMORjmupVk=;
 b=csYd8HeBjl2o4W4WiNqfvhh6Vil1XKBBV2VysK6q3jZ3g6mXS1mdz44HZ/8hYAovY0ovfq
 AEyp6s3eC4AvONDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730886236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DOVrUFcS1MUe6+MK/EF26nWAzUFNZgmHJoMORjmupVk=;
 b=us3fUjUT5QtZ5lkD3XtBxApMJG+U7KCP0ytn4P2z4cn0McmkJV0Nxw3NY0HyB6fbprcuKd
 UimA04cOx09Haf+9Lp7a0Q0Kxg1jdLfEU/6FEsp/ZeJ5Wg/LFiT02g5clpnfO8Z1f6XpG4
 5ePzO/4sJB2dsPOoJR5KlQW1SUGvrRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730886236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DOVrUFcS1MUe6+MK/EF26nWAzUFNZgmHJoMORjmupVk=;
 b=csYd8HeBjl2o4W4WiNqfvhh6Vil1XKBBV2VysK6q3jZ3g6mXS1mdz44HZ/8hYAovY0ovfq
 AEyp6s3eC4AvONDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3BCE137C4;
 Wed,  6 Nov 2024 09:43:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q9WzJ1w6K2cmWAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 06 Nov 2024 09:43:56 +0000
Date: Wed, 6 Nov 2024 10:44:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Zys6YRPAMzHDpMbo@yuki.lan>
References: <20240913134036.12078-1-spoorthy@linux.ibm.com>
 <CAEemH2doMF7EggO_TOP+y=WwS75aXxrFA8mfaZmr-+YWwB1JSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2doMF7EggO_TOP+y=WwS75aXxrFA8mfaZmr-+YWwB1JSQ@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
Subject: Re: [LTP] [PATCH v3] Hugetlb: Migrating libhugetlbfs shm-perms
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
> > +static void compare_free_hugepage_memory(long free_end, long free_start)
> > +{
> > +       if (free_end != free_start)
> > +               tst_res(TFAIL, "Free hugepages after attaching multiple
> > threads differ from initial allocation");
> >
> 
> We cannot make such an assumption for TFAIL because the system
> may be using hugepages in the background by other processes, and
> this test is not alone in occupying huge page so that would be possible
> get false positive in the real testing.

We already have similar assumptions in the rest of the hugepage tests,
however at least it's clear from the message that is being printed that
it may fail if we run more than one test in parallel or if system
allocates hugepages for something.

But I guess that we can do better, we can look at the HugetlbPages:
field in the "/proc/self/status" instead and check that it's incremented
and decremented properly as the test runs.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
