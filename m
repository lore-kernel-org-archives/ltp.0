Return-Path: <SRS0=7iMP=PW=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E63C433F5
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 16:20:39 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2952D60EB8
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 16:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2952D60EB8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 300003C6BD9
	for <ltp@archiver.kernel.org>; Wed,  3 Nov 2021 17:20:37 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BEDF3C6BD9
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 17:20:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D01F7100153B
 for <ltp@lists.linux.it>; Wed,  3 Nov 2021 17:20:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E858212C5;
 Wed,  3 Nov 2021 16:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635956427;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kaF+cMFbEPugOLJpafD/dcPfyjvqXS6pLXzUHPAVQqU=;
 b=Z/od403g03nTwfASHVoJEty1kUmAeSIYq4NhlpI7xEvFfs3WCs5FE9irv+SVUKRM2ljT1l
 QF10Y9G0OmyFxtPO+l4hDAcEvt962PwISPS6mrK5emW2RoaBxuVXIYS2bvNT3jz5d2Ga2z
 YOUUTPg8vVHvztvL15S+e1Bok8KeFAY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635956427;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kaF+cMFbEPugOLJpafD/dcPfyjvqXS6pLXzUHPAVQqU=;
 b=V8pdPpYqfJ2qWWGUI0sQzRHYWEh2nodAGBa6L17fbi2bI/AvaJiPcD0Ifkduwx28zUPa+d
 pGGr94OVocweLEDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED6DD13C91;
 Wed,  3 Nov 2021 16:20:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cRNcOMq2gmHQVAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 03 Nov 2021 16:20:26 +0000
Date: Wed, 3 Nov 2021 17:20:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YYK2yYICHcH5k19L@pevik>
References: <20211027075615.19832-1-pvorel@suse.cz> <YYKeZRuVLat/xFuS@yuki>
 <YYKhLrXVhCgTfNS4@pevik> <YYKky6iFvFH/WdKd@yuki>
 <YYKoACdUDPtTeoLb@pevik> <YYKs64osfKyAlcC/@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYKs64osfKyAlcC/@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ver_linux: Print filesystems
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

> > => which is IMHO nogo. I could redirect to a file and cut it after, but in that
> > case v2 is IMHO much better.

> But still we don't need that grep part, right?

> So it should be something as:

> 	if `df -hT 2>/dev/null >/dev/null`; then
> 		df -hT
> 	else
> 		df
> 	fi
Merged this version, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
