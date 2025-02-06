Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F44C02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 15:04:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5B753C9288
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 16:04:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 53B3D3C0558
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:04:30 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9ABDF140BD58
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 16:04:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EFC291F381;
 Thu,  6 Feb 2025 15:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738854268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lZTMSYvDWN6gs90AF33vxHSLIRt23iWM2VDFCOt5hnw=;
 b=jm+aQRe96FOULuFg/1tJd4fH22Jp55GCfvpuymjFSjqryFrvBjX6+L52zF20XP7xwHxGRm
 iRfVyjrjRvT1m1Ogncdt2t4nSQntCBzwIaSc7t4mEcjfNAUODkitcNNc2YvUjHi2V8A3dG
 vBTo3tSN1GZ4vMMRjLXTt25F8kOfF1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738854268;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lZTMSYvDWN6gs90AF33vxHSLIRt23iWM2VDFCOt5hnw=;
 b=DTbBoHIqCEDkvW2yZ+JK2D1LEeduucwEbg5prRFZZnc1O8xdEXp+hgjrRC9isxPBylpSVN
 5VrSlPf/e5wE9tDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738854267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lZTMSYvDWN6gs90AF33vxHSLIRt23iWM2VDFCOt5hnw=;
 b=Pp/OWFVSHv5SnmPLRCDwfI1QmDDR5E2YjGj9HxpoKgE46qw1J5qrq3c3Dv7M+FsDEF1APp
 bCtpzeyaNwNJYk9t8yzD/Ne2o35tfyxRszi15lrbXj+3Iu8tp3hkV3yOvoweApNalSIIx+
 1dVUaQ7ePqNiqrPWsYyHAXfjYg+sm2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738854267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lZTMSYvDWN6gs90AF33vxHSLIRt23iWM2VDFCOt5hnw=;
 b=YcZd5ZfhqWWq5oFsz5zgfAaZrBGNNcicQghVs/Dif4yyUgwC4csGhGaTCMFxFLVyGSzrAi
 8gIAkwcWyO3f7PBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB69813694;
 Thu,  6 Feb 2025 15:04:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LU2XNHvPpGd2MQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 06 Feb 2025 15:04:27 +0000
Date: Thu, 6 Feb 2025 16:04:29 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Z6TPfQF-Evly--5A@yuki.lan>
References: <89d0fb724ea534419942c2647e1ef7ca98f9e72d.1738846569.git.jstancek@redhat.com>
 <Z6TCWQIediqqUUVW@yuki.lan>
 <CAASaF6z-oCHe66zJ_=r_B3HMQg7934xfPhkH2nyOoo2gm=uYFw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6z-oCHe66zJ_=r_B3HMQg7934xfPhkH2nyOoo2gm=uYFw@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,yuki.lan:mid]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/bpf: zero-initialize bpf_attr including
 padding bits
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
> > I had a closer look here, the map_attr is an union with anonymous
> > structures and I suppose that the problem here is that the padding after
> > the union is no longer cleared and that there have been some new fields
> > added, at least compared to the lapi fallback structures we have and we
> > possibly pass random mess in flags.
> 
> It's not just padding, some fields (from other structs) are also not
> initialized:
> 
> void bpf_map_array_get(const int map_fd,
>                        const uint32_t *const array_indx,
>                        uint64_t *const array_val)
> {
>         union bpf_attr elem_attr = {
>                 .map_fd = map_fd,
>                 .key = ptr_to_u64(array_indx),
>                 .value = ptr_to_u64(array_val),
>                 .flags = 0
>         };
> 
>         printf("should be zero? %u\n", elem_attr.func_info_cnt);
> 
> and I get:
> should be zero? 4202093

That's what I meant, but phrased it wrongly. Padding after the shorter
union fields, which are anonymous structures. That means that quite a
lot of the fields may end up non-zeroed in case that we initialize
a structure that is on the shorter side. I would say that in this case
the optimalization is very evil one, because it looks like these members
should have been zeroed at first.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
