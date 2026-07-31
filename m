Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D58C5516F
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 14:58:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEB953E71E2
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 16:57:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 54F593E182A
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 16:57:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 81C34600BC3
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 16:57:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BEBD44199;
 Fri, 31 Jul 2026 14:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785509863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IfbNhJNVlQ1sBW+dFeqpr1WIiUne+s1TBs7fAe69HiY=;
 b=V8Z+AptrL+Aa02sYKYfusgsfulHQd/6IqncsJ0PPkEtoDDxBQcCQxS9zj+Kspc3yktzvbe
 9W4n1INgXA8Rk7sidb68Pe+pHMx3IBVJ6ub8x2uRZXvNeQYnr6ercvrrP33GPinAngVadU
 P6LbPYuNtfnTVwLjhptjJ2t5vYlMZ0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785509863;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IfbNhJNVlQ1sBW+dFeqpr1WIiUne+s1TBs7fAe69HiY=;
 b=/dSh+MlYNgP0Vfgmt8Ta6Adbpkc1wMhLttov3eD9njF2vFPUSHQZ9KYu8wDWHq8xa5qota
 N5EjSX7AFZpjl+DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785509862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IfbNhJNVlQ1sBW+dFeqpr1WIiUne+s1TBs7fAe69HiY=;
 b=e7jhg99IvEqKReGGuM+kosA5ojJ2ka00zxkN1ZP5dYfRZw97VLUxhZg9UMeRKq8qDluU7L
 mQfhNazNV9r7WjoYvblxJMXO0igyZmbP3IJEtGeJ2/WfO6d6UEwzr6rR6QHttnAnYyDYs7
 /JCEa0I1hcTi4e4qOaXH0R/eIA0BBTM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785509862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IfbNhJNVlQ1sBW+dFeqpr1WIiUne+s1TBs7fAe69HiY=;
 b=z7LDA0q1khVjso5bado8uDY0ND+CvbSjJUwdtpVv/MaKz55OhbdoJOla2U92HUA7isH7MI
 OPhehJvCqsQ7iyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1102779C6;
 Fri, 31 Jul 2026 14:57:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cQg2Jua3bGpcHAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 31 Jul 2026 14:57:42 +0000
Date: Fri, 31 Jul 2026 16:57:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Piotr Kubaj <piotr.kubaj@intel.com>
Message-ID: <amy35tLl9KnBS2bK@yuki.lan>
References: <20260611114219.146444-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260611114219.146444-2-piotr.kubaj@intel.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,yuki.lan:mid]; 
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9] cpufreq.c: add new test for cpufreq sysfs
 interface validation
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I've renamed the test to cpufreq_intel.c since it's intel specific and
the name was too generic and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
