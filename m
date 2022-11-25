Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E9BFC4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 10:39:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70B6E3CC880
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 11:39:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8A5C3C67D6
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:39:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 96DF5140111C
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 11:39:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E0A5D1F390;
 Fri, 25 Nov 2022 10:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669372787;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/6DozReoyHSS7nwRAKp33NmwNecl8w5TsirixcMU89U=;
 b=2r3tZJB4AjKLDKjL0TTKoXYdVVhwCWlBNuPPNnqGEIZZQA7rMGKjwAxt7kMyzXdHHaquAv
 KGxe1qF3I+uwBfa2U3TFTzfsIhDdp7RIKDIVdC6RzxjykZwaHXv0RWo91Y+x++MXnUZaht
 Ky2sFlsSF1UEQv/7mwQSHjdTZg7tAnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669372787;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/6DozReoyHSS7nwRAKp33NmwNecl8w5TsirixcMU89U=;
 b=Ez/AmcwNhYhRLr9lfiDmH18wUyRX2DAztPg3thttJHqPDIf/1BS3ZVHz5TH4mhWmWsEtQA
 zv9SfN1XhNAeNaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6C9013A08;
 Fri, 25 Nov 2022 10:39:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id P61GK3ObgGPccAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 25 Nov 2022 10:39:47 +0000
Date: Fri, 25 Nov 2022 11:39:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: David Hildenbrand <david@redhat.com>
Message-ID: <Y4CbcQhk/UMkpfEX@pevik>
References: <20221123103547.54246-1-david@redhat.com>
 <8587b908-a035-a96a-7233-2863b7bc30ca@suse.cz>
 <Y4CTrrCb4jtQay9y@pevik>
 <da91a3a8-4609-c128-1c73-8b35dfb2b7c9@redhat.com>
 <af63ed9a-7108-fd19-fe2c-4b56be85d068@suse.cz>
 <79125e1d-760f-432f-1814-502521347680@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79125e1d-760f-432f-1814-502521347680@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] security/dirtyc0w_shmem: Add new test for
 CVE-2022-2590
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

> On 25.11.22 11:25, Martin Doucha wrote:
> > On 25. 11. 22 11:20, David Hildenbrand wrote:
> > > See my other mail, it's the case on all instances that pass NULL (and I
> > > don't really see the need to do this when working with NULL.

> > NULL may be defined as simple integer 0. When int is 32bit and pointers
> > 64bit, this will cause trouble in variadic functions such as execlp().
> > You do not need to remind us that LTP tests have lots of bugs, we know.

> I can send a fixup patch for all these instances.

Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
