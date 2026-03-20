Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF9BC108B8E6
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 09:54:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91CF23E2B3B
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 10:54:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 18D8B3C72BE
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 10:54:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8FD6E6023B0
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 10:54:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 174074D23E;
 Fri, 20 Mar 2026 09:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774000450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r7Ik0zZC9Vzv4B95Ise4E2d+5br9T+pxzxBgxAujLG4=;
 b=ul9T+iiGagTmg/UQ6SV3Md+AkE71M0IEokaOBjTS7Ly9lJazB/CpF6D95WyagdUDnCdh+I
 ZnYbuTl7H7TWx4TFCC4FNIYQP2RpMBycs5tc1h9hRqqV9ZQiyN0JDd4eMcKo41gF8VyF4T
 OQIPus9uGYg4f5LU2VQ4pCxu0gYCf6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774000450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r7Ik0zZC9Vzv4B95Ise4E2d+5br9T+pxzxBgxAujLG4=;
 b=3fQ8pEoUSgZpwE6gd02Hzc4Qhk3F4xLvCpkGPJwV8h9b1kuJdUzV+9QkYypdDgHsQ0NLty
 05ikBfqKKYQGCYCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774000450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r7Ik0zZC9Vzv4B95Ise4E2d+5br9T+pxzxBgxAujLG4=;
 b=ul9T+iiGagTmg/UQ6SV3Md+AkE71M0IEokaOBjTS7Ly9lJazB/CpF6D95WyagdUDnCdh+I
 ZnYbuTl7H7TWx4TFCC4FNIYQP2RpMBycs5tc1h9hRqqV9ZQiyN0JDd4eMcKo41gF8VyF4T
 OQIPus9uGYg4f5LU2VQ4pCxu0gYCf6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774000450;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r7Ik0zZC9Vzv4B95Ise4E2d+5br9T+pxzxBgxAujLG4=;
 b=3fQ8pEoUSgZpwE6gd02Hzc4Qhk3F4xLvCpkGPJwV8h9b1kuJdUzV+9QkYypdDgHsQ0NLty
 05ikBfqKKYQGCYCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C7EF4273B;
 Fri, 20 Mar 2026 09:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7KoFA0IZvWkEGwAAD6G6ig
 (envelope-from <jack@suse.cz>); Fri, 20 Mar 2026 09:54:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id BF398A0AFD; Fri, 20 Mar 2026 10:54:09 +0100 (CET)
Date: Fri, 20 Mar 2026 10:54:09 +0100
From: Jan Kara <jack@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <lktxglldaoykzlkv2z5o2yeuyw5nuu4vomer47j6xfgsuiu56d@hkm553ph77kh>
References: <20260319160318.6867-1-chrubis@suse.cz>
 <20260319160318.6867-3-chrubis@suse.cz>
 <xb4a277xjifyrgtwc7xochxc2ysuewk7tioefuje3r6sak3os2@nrgti25k63ul>
 <ab0Yn91oOC0TfVOV@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ab0Yn91oOC0TfVOV@yuki.lan>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] runtest: ltp-aiodio.part2: Limit the maximal
 filesize
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri 20-03-26 10:51:27, Cyril Hrubis wrote:
> Hi!
> > > The test was operating with filesize up to ~500MB which, in certain
> > > cases, was making the runtime too slow. Some test variants, especially
> > > with many processes, were running up to 15 mintues on modern hardware.
> > > After a discussion we agreed that we can reduce the maximal file size to
> > > one quater without sacrificing test coverage.
> > > 
> > > I've also assumed that there was a typo in ADSP072 since the buffer size
> > > was set to be order of magnitude bigger than the file size.
> > > 
> > > CC: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > > ---
> > >  runtest/ltp-aiodio.part2 | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/runtest/ltp-aiodio.part2 b/runtest/ltp-aiodio.part2
> > > index 599c9fd2f..c82f6fd02 100644
> > > --- a/runtest/ltp-aiodio.part2
> > > +++ b/runtest/ltp-aiodio.part2
> > > @@ -25,8 +25,8 @@ ADSP023 aiodio_sparse -o 4 -w 1024k -s 4096k -n 6
> > >  ADSP024 aiodio_sparse -o 4 -w 2048k -s 8192k -n 6
> > >  ADSP025 aiodio_sparse -o 4 -w 4096k -s 16384k -n 6
> > >  ADSP026 aiodio_sparse -o 4 -w 18192k -s 72768k -n 6
> > > -ADSP027 aiodio_sparse -o 4 -w 18192k -s 518192k -n 6
> > > -ADSP028 aiodio_sparse -o 4 -w 65536k -s 262144k -n 6
> > > +ADSP027 aiodio_sparse -o 4 -w 18192k -s 129548k -n 6
> > > +ADSP028 aiodio_sparse -o 4 -w 65536k -s 129548k -n 6
> > 
> > I think the write size of 64MB is too large for 128MB file with 4 AIO
> > contexts - I think the size will be autotrimmed to 32MB. So you might as
> > well just specify -w 32768k.
> 
> Right, will fix that.
> 
> > Otherwise this looks good to me.
> 
> Do I need to send v2 or can I add your Reviewed-by: if I fix the write
> size before applying the patches?

Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

one that one is fixed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
