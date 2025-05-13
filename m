Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F43FC3ABCC
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 12:08:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1B6B3CC326
	for <ltp@archiver.kernel.org>; Tue, 13 May 2025 14:08:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 198FF3CAB8E
 for <ltp@lists.linux.it>; Tue, 13 May 2025 14:08:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6E7A9600BEF
 for <ltp@lists.linux.it>; Tue, 13 May 2025 14:08:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 64F901F786;
 Tue, 13 May 2025 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747138108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zo57EatoHHEORyfauBJaW3hfgIdTOdtdh+9lwpjXkoU=;
 b=GF+GT0nJHKrpKAXksLbpN/9fdMab0D2BNeePK8fGB5IOTBJkiiAVxIAFBtm0AT2Qs4WMfU
 cmXibPyAPSShkGrMvpbUa0Rgb3518O9SSsz6kHoRlV0fv58JgWv1HxPpg+JI+vIRnCU54Q
 f0ZFRVMUSAc7bLjMlyXp5AJVm+9m+8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747138108;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zo57EatoHHEORyfauBJaW3hfgIdTOdtdh+9lwpjXkoU=;
 b=II2YoKzCZthTGbnJd878Fdm22fKHFECKo+Fn3gM0nK+cNhZ5tmHJnwKfZctiTumDRrCh8Q
 BDgr0qnr+JfCzyDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747138108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zo57EatoHHEORyfauBJaW3hfgIdTOdtdh+9lwpjXkoU=;
 b=GF+GT0nJHKrpKAXksLbpN/9fdMab0D2BNeePK8fGB5IOTBJkiiAVxIAFBtm0AT2Qs4WMfU
 cmXibPyAPSShkGrMvpbUa0Rgb3518O9SSsz6kHoRlV0fv58JgWv1HxPpg+JI+vIRnCU54Q
 f0ZFRVMUSAc7bLjMlyXp5AJVm+9m+8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747138108;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zo57EatoHHEORyfauBJaW3hfgIdTOdtdh+9lwpjXkoU=;
 b=II2YoKzCZthTGbnJd878Fdm22fKHFECKo+Fn3gM0nK+cNhZ5tmHJnwKfZctiTumDRrCh8Q
 BDgr0qnr+JfCzyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 552ED1365D;
 Tue, 13 May 2025 12:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JDr4Ezw2I2jDPwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 13 May 2025 12:08:28 +0000
Date: Tue, 13 May 2025 14:09:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aCM2YhxlofwOx72y@yuki.lan>
References: <20250513050530.47541-1-liwang@redhat.com>
 <20250513050530.47541-2-liwang@redhat.com>
 <aCOsNW2hFJZOn3zH@MiWiFi-CR6608-srv>
 <CAEemH2cuKr4NLi8193GskSgJ+UuswvT6dP2U0nCYqfVndTjH9A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cuKr4NLi8193GskSgJ+UuswvT6dP2U0nCYqfVndTjH9A@mail.gmail.com>
X-Spamd-Result: default: False [-4.29 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[4]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] dirtyc0w_shmem: set child_needs_reinit
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
> > Do we still need this? Since .needs_checkpoints is already setted.
> >
> 
> I think yes!
> 
> While some fields may have overlapping effects, explicitly setting this
> field
> highlights its intended function and enhances the clarity of the code.

Exactly.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
