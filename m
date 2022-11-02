Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01FEC4332F
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 07:40:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B1923CAD5C
	for <ltp@archiver.kernel.org>; Wed,  2 Nov 2022 08:40:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C16A3CA8A4
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 08:40:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A1007600950
 for <ltp@lists.linux.it>; Wed,  2 Nov 2022 08:40:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B3EF01F94C;
 Wed,  2 Nov 2022 07:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667374810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFXnwkVZbQRyN93mShNiqoq6qQFCbQEbU5HEkDAEHPM=;
 b=kW/TWQ0iTeOLSCps08I+VIahFG1Ob7DDCCe9Jr9r7+U8wOCPMrfPyOW/5Prez10oNcy6hB
 ZhMmrbT4Z5n6NSxGzX/rEFIPKp/c+DXGkFlYuGf5gho7YpsEZJft9jIxHQ0HW8aB7PsA14
 +MG1BnClSzO/rkteK+UivLP5M9A0y04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667374810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFXnwkVZbQRyN93mShNiqoq6qQFCbQEbU5HEkDAEHPM=;
 b=ZZ4NgVWdf7Z/Jg7SDKhjMhvUthG5MfvldDw+lb9nirH2YuucRhIVdIzugSl9mkjHYhpY6Z
 J2M8x+r87hJHXyCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A19D61376E;
 Wed,  2 Nov 2022 07:40:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DRPHF9keYmP6bgAAMHmgww
 (envelope-from <akumar@suse.de>); Wed, 02 Nov 2022 07:40:09 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Martin Doucha <mdoucha@suse.cz>, Petr Vorel <pvorel@suse.cz>
Date: Wed, 02 Nov 2022 13:10:06 +0530
Message-ID: <20846440.eidTIuNkkK@localhost>
Organization: SUSE
In-Reply-To: <Y2BAiPUPKS3gimLD@pevik>
References: <20221027140954.4094-1-akumar@suse.de>
 <7c3efc21-229f-5e76-21e4-3e778e7ba140@suse.cz> <Y2BAiPUPKS3gimLD@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: using -1 as invalid fsuid for
 setfsuid()
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

Hi Petr, Martin,

Thank you for the discussion and fixing the patch for 16-bit.
I am making a note to always test 16-bit binaries also.

On Tuesday, November 1, 2022 3:09:20 AM IST Petr Vorel wrote:
> > On 31. 10. 22 15:56, Petr Vorel wrote:
> > > Ah, sure, I see current_uid is used for checking only. So what is your
> > > suggestion to fix the problem on 16-bit?
> 
> > I guess using UID_T (defined in the LTP compat headers) instead of uid_t is
> > the solution, then -1 will be cast to the correct bitsize.
> 
> Thank you, that worked.
> 
> Merged, with additional cast to long to keep compiler happy.
> 
> Kind regards,
> Petr
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
