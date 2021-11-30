Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B118C433EF
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 10:50:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06D433C6355
	for <ltp@archiver.kernel.org>; Tue, 30 Nov 2021 11:50:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A0813C4E59
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:50:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BB1A21A014F3
 for <ltp@lists.linux.it>; Tue, 30 Nov 2021 11:50:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 09F5B1FD58;
 Tue, 30 Nov 2021 10:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1638269433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LO+cCNa6ljF/AzCwLcchUh+aeU6Cw4mCk/uNqiNC5U4=;
 b=1gqHaqf7sqEiERdW9ANsxx2Ou5f7F+guji/Hk0QNERj4S9o2Uz/shwNHapUgjnH0cADyRP
 FUO9xMBnnPezAYqQGqkvNJ6Q7vObdJKrPL+U5SeV5cisHT5R6jHL3Xi4wQfWhZnFaZYd4c
 k1yaooL9IsBQTISTgOZ7749qCphS4wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1638269433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LO+cCNa6ljF/AzCwLcchUh+aeU6Cw4mCk/uNqiNC5U4=;
 b=ys5MYzEWtTjpDx77zBxgbBlpgQHeb13TYbVdnNf83rHePMVhVvI5rypycaTNSgobwtsIMe
 8rDtLgiR7Xh+wLBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA99A13C44;
 Tue, 30 Nov 2021 10:50:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pqR4N/gBpmF5QQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 30 Nov 2021 10:50:32 +0000
Date: Tue, 30 Nov 2021 11:51:44 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YaYCQKX+ns1F5ldR@yuki>
References: <20211123124348.31073-1-rpalethorpe@suse.com>
 <20211123124348.31073-2-rpalethorpe@suse.com>
 <YZ3l+QtJA+/RCp6v@pevik> <87v90akpyy.fsf@suse.de>
 <YaX6nLRGwtfUTjrP@yuki> <YaX7i/ezRhxANBwM@yuki>
 <87mtllly6e.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mtllly6e.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] tools/sparse: Add static check
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
Cc: chrubis@suze.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >> > Thanks! pushed. Please pull and try it out.
> >> 
> >> Looks like it fails on fuzzy sync since it uses tst_ but it's in an
> >> header.
> >> 
> >> These definitions should be static inline and changing them so fixes the
> >> warnings. It looks like static inline functions does not make it into
> >> the symbol test at all.
> 
> Ah, I vaguely remember now that "static inline" is the correct way to
> include functions in header files. Otherwise they shouldn't be in header
> files. We have LTO now as well so possibly Fuzzy sync shouldn't be all
> in the header, but that's another matter.

If I recall correctly LTO is currently broken on ARM and even if that
was working we still have to support 10 years old compilers anyways...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
