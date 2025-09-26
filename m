Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCFCCAC5AE
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 08:03:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4D883CE0A3
	for <ltp@archiver.kernel.org>; Fri, 26 Sep 2025 10:03:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 40B693CDCDF
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:03:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 25FEF600802
 for <ltp@lists.linux.it>; Fri, 26 Sep 2025 10:03:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5404738C2D;
 Fri, 26 Sep 2025 08:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758873815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paoZHYTzlbz4tn4Wph9pCI5FtmXmRpIjdfae+fgkldE=;
 b=nZ5OBzz20sRdMPBhU9MNhjwVUy9YS0g4sM5yQsgPTSCwvoTAjAkIpOdF4wrn5xWHgglQMW
 LWf8xbykL07nvVRaT+Nw4rlEQQOmzbf+eAf6L1D9asQA79QpH6cwq3KWdEsCVNg+GNlIqg
 Aporbfd38EOdCGe77ZSmZrvM46IHCLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758873815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paoZHYTzlbz4tn4Wph9pCI5FtmXmRpIjdfae+fgkldE=;
 b=ddrMJ+JKn6VuMBq8uyy+86HHIPgFQaNV4bSXFgpuvnWIipj9PgGx4OwnVSkPDOzydQ3Fto
 +L65SDxcwpywt4Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EVKaABOb;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=V9XGyyA3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758873813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paoZHYTzlbz4tn4Wph9pCI5FtmXmRpIjdfae+fgkldE=;
 b=EVKaABObRaHNjeEt+OrIZE1qnGdR31G4EXt4alQ120QsIlWdJVl+BO3w4ARPUxP9yO4LKe
 a9Hqe1wlkaxSmo82A7B8qgGvkjSYg/brlR/UK6RGNVgsvyTP7ZR/kkQb14LNNXcb26Ck6g
 BkaNeNSHzKiozX5FYbP3DDMRygSH2Gk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758873813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=paoZHYTzlbz4tn4Wph9pCI5FtmXmRpIjdfae+fgkldE=;
 b=V9XGyyA3VxSAonmpAMUUUcmUNSCFUBXiCCDOABQaGS8fje/JcBqcj7srfjTrMH1AFST+AK
 cQ1TKn3L+TfaMtDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4392F1373E;
 Fri, 26 Sep 2025 08:03:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xBGRD9VI1mgbbgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 26 Sep 2025 08:03:33 +0000
Date: Fri, 26 Sep 2025 10:04:14 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aNZI_qWdLSLAz5pH@yuki.lan>
References: <20250926040707.671282-1-jmorgan@naotchy.com>
 <d39802b7-6ab3-4c78-a660-34d7bc0a3dd3@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d39802b7-6ab3-4c78-a660-34d7bc0a3dd3@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 5404738C2D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] statmount.h: add check for STATMOUNT_MNT_NS_ID
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
> > +/* Enable STATMOUNT_MNT_NS_ID check for struct statmount. */
> > +#if!defined(HAVE_STRUCT_STATMOUNT) || defined(HAVE_STRUCT_STATMOUNT_MNT_NS_ID)
> > +#define LTP_HAVE_STRUCT_STATMOUNT_MNT_NS_ID 1
> > +#endif
> 
> This is not a good practice, better to avoid defining LTP_* wrappers, 
> since we already have the HAVE_* variables defined by autoconf.

This has to be unfortunately there because the field is present if we
are using lapi fallback or if we have new enough system headers. So
either we open code the ifdefs in the test, or define the macro like
this.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
