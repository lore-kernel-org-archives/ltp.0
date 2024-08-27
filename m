Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7EFC5472F
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 13:23:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1DC83D2739
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 15:23:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D6D13D20B9
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 15:22:51 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9E5A2600D59
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 15:22:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A0C3F21AF8;
 Tue, 27 Aug 2024 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724764969;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7yAxwtgVLBdL+ij/BrepXXwnG1crQ8ixnLWnROohPRA=;
 b=P+35a51m7NJkJwZ5X3Gaqw5LQwtXdgtyc46Um7cH3QDQIYUoESMuDNgKJCeE4JL08Wv0WD
 2PmaQ8uf7zng5DK5bHzzIfcbH9WRpffz+F6kOPmVX73RHJVyqDdAB9x8oUFlgN3wxpFR0G
 J2DIvXfzQqArhBNaHtvWM2p77J88Qjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724764969;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7yAxwtgVLBdL+ij/BrepXXwnG1crQ8ixnLWnROohPRA=;
 b=dpDCVagKgifdDrYydEQHxW3h4ufCNU6LgxhSWVf6pYg9OdGDYcJxpLkZxNsHLj23TX93/m
 2ZdmNNtn6A7svrDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724764969;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7yAxwtgVLBdL+ij/BrepXXwnG1crQ8ixnLWnROohPRA=;
 b=P+35a51m7NJkJwZ5X3Gaqw5LQwtXdgtyc46Um7cH3QDQIYUoESMuDNgKJCeE4JL08Wv0WD
 2PmaQ8uf7zng5DK5bHzzIfcbH9WRpffz+F6kOPmVX73RHJVyqDdAB9x8oUFlgN3wxpFR0G
 J2DIvXfzQqArhBNaHtvWM2p77J88Qjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724764969;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7yAxwtgVLBdL+ij/BrepXXwnG1crQ8ixnLWnROohPRA=;
 b=dpDCVagKgifdDrYydEQHxW3h4ufCNU6LgxhSWVf6pYg9OdGDYcJxpLkZxNsHLj23TX93/m
 2ZdmNNtn6A7svrDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48C4C13AD6;
 Tue, 27 Aug 2024 13:22:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SMZiDynTzWbrdQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 27 Aug 2024 13:22:49 +0000
Date: Tue, 27 Aug 2024 15:22:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240827132242.GA1627011@pevik>
References: <> <20240823064640.GA1217451@pevik>
 <172445038410.6062.6091007925280806767@noble.neil.brown.name>
 <9afef16d-52b2-435d-902a-7ccfa5824968@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9afef16d-52b2-435d-902a-7ccfa5824968@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] nfsstat01: Update client RPC calls for
 kernel 6.9
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
Cc: linux-nfs@vger.kernel.org, NeilBrown <neilb@suse.de>,
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On 23. 08. 24 23:59, NeilBrown wrote:
> > On Fri, 23 Aug 2024, Petr Vorel wrote:
> > > We discussed in v1 how to fix tests.  Neil suggested to fix the test the way so
> > > that it works on all kernels. As I note [1]

> > > 1) either we give up on checking the new functionality still works (if we
> > > fallback to old behavior)

> > I don't understand.  What exactly do you mean by "the new
> > functionality".
> > As I understand it there is no new functionality.  All there was was and
> > information leak between network namespaces, and we stopped the leak.
> > Do you consider that to be new functionality?

Thanks Martin for jumping in. I hoped I was clear, but obviously not.

Following are the questions for kernel maintainers and developers. I put my
opinion, but it's really up to you what you want to have tested.

> The new functionality is that the patches add a new file to network
> namespaces: /proc/net/rpc/nfs. This file did not exist outside the root
> network namespace at least on some of the kernels where we still need to run
> this test. So the question is: How aggressively do we want to enforce
> backporting of these NFS patches into distros with older kernels?

> We have 3 options how to fix the test depending on the answer:
> 1) Don't enforce at all. We'll check whether /proc/net/rpc/nfs exists in the
> client namespace and read it only if it does. Otherwise we'll fall back on
> the global file.

1) is IMHO the worst case because it's not testing patch gets reverted.

> 2) Enforce aggressively. We'll hardcode a minimal kernel version into the
> test (e.g. v5.4) and if the procfile doesn't exist on any newer kernel, it's
> a bug.

I would prefer 2), which is the usual LTP approach (do not hide bugs, we even
fail on upstream kernel WONTFIX [1], why we should refuse the policy here?).

Whichever older LTS upstream kernel gets fixed would drive the line where new
functionality is requested (currently v5.14, I suppose at least 5.10 will also
be fixed). LTP also has a way to specify enterprise distro kernel version if
older enterprise kernel also gets fixed (this should not be needed, but it'd be
possible).

> 3) Enforce on new kernels only. We'll set a hard requirement for kernel
> v6.9+ as in option 2) and check for existence of the procfile on any older
> kernels as in option 1).

Due way to specify enterprise distro kernel version and upstream kernel testing
expecting people update to the latest stable/LTS we should not worry much about
people with older kernels.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ustat/ustat01.c#L48-L49

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
