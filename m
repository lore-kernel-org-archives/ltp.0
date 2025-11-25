Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1784CFD37F
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 10:45:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 540253CDE81
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 11:45:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E88A3CAAA4
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 11:44:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1D2E1200978
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 11:44:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0AAFC5BD10;
 Tue, 25 Nov 2025 10:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764067487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCSr+rKQt2HY14bBE5k+NCq9U1d5jtHfS+5Jg/w5XpE=;
 b=1MYRb2Q8vuxX7BofH4S1MAf1v0Rg4jKB2db0utipczFDHPn9q1T9HiMSS+4RwaAFB0hG2J
 B/7oirTyJ8dQGHbuw6gYJYxzI9w6HGbKxJ7cMIYzy0pu+Bvx7Se2tynbpl/J6XFtYWFzwQ
 Z/pFex7XG8F/RDy0e6AP5tylzbVqm9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764067487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCSr+rKQt2HY14bBE5k+NCq9U1d5jtHfS+5Jg/w5XpE=;
 b=zo+Nxijzra4tATm4UVWr/GN7/xUjNXwgjxJKfQV66lCsC4I3rv0rwTwPRCktgVSUdK/5hT
 UBzzDD7VSTgceRDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1764067486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCSr+rKQt2HY14bBE5k+NCq9U1d5jtHfS+5Jg/w5XpE=;
 b=n4VAP5knA2p75ItQxzsZ7UjgFEMxgqEovAcZsi8S6B5OfIxIRS2jSZYENBzLbXXgSlGNzN
 miDLv17BsrKmmI1kZbInAOZFCN+y1cyD84D904lhBf0hYAdLVR/jG4SDnOG2/StqSYuhwe
 cGp5EbQ0+HS2xPToR3/GnlNfeqANmjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1764067486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCSr+rKQt2HY14bBE5k+NCq9U1d5jtHfS+5Jg/w5XpE=;
 b=mgIxgk3hIeRsmgwlI7laXuAa6CgRRRwV09/5Nd/5o4riPeX1ycdsX/hoNa5wdJmkMvZXjk
 ZwWUvpC1fcK9F/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED4F33EA65;
 Tue, 25 Nov 2025 10:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Xq6COZ2IJWmHCwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 25 Nov 2025 10:44:45 +0000
Date: Tue, 25 Nov 2025 11:45:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <aSWI07xSK9zGsivq@yuki.lan>
References: <202511251654.9c415e9b-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202511251654.9c415e9b-lkp@intel.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [sysctl] 50b496351d: ltp.proc01.fail
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
Cc: lkp@intel.com, linux-kernel@vger.kernel.org,
 Joel Granados <joel.granados@kernel.org>, oe-lkp@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> PATH=/lkp/benchmarks/ltp:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/lkp/lkp/src/bin
> 2025-11-25 05:37:33 cd /lkp/benchmarks/ltp
> 2025-11-25 05:37:33 export LTP_RUNTIME_MUL=2
> 2025-11-25 05:37:33 export LTPROOT=/lkp/benchmarks/ltp
> 2025-11-25 05:37:33 kirk -U ltp -f fs-00

Oliver can you please record the test logs with '-o results.json' and
include that file in the download directory?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
