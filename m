Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0663DCF58EA
	for <ltp@archiver.kernel.org>; Fri, 20 Sep 2024 10:31:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 658F23C304E
	for <ltp@archiver.kernel.org>; Fri, 20 Sep 2024 12:31:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D4D93C0CCC
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 12:31:21 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 04DF260B046
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 12:31:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C9031F7F1;
 Fri, 20 Sep 2024 10:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726828278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=shDtUoCL6lWBXIWD+R8d5E/wcH6AUhyy3m73n1D8QHk=;
 b=FTjiSx3TQRwKbUOU61ohEwoVqfZ1nTZdosUH8m85dTf8kRp4bQiZ3VKd+h3lrWMvCdqk4L
 cXFxW5IzqHSe84ASEG72VOKhjawe7PZeD2s6rXyg4NaMTDdTW/RyPUNBju6x3N/5f8jD8F
 tEkKY0D+iyRQq5v6MMr+uxyM9gstQjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726828278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=shDtUoCL6lWBXIWD+R8d5E/wcH6AUhyy3m73n1D8QHk=;
 b=/nE+n9SaEpruNiB1Dpli0d3hUzGeCJeqfY0ckfqVt5ovKjA/5aXjyKhGxS4jGPHW2J7WB4
 Rn1MSB4Pw5NKZJAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726828278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=shDtUoCL6lWBXIWD+R8d5E/wcH6AUhyy3m73n1D8QHk=;
 b=FTjiSx3TQRwKbUOU61ohEwoVqfZ1nTZdosUH8m85dTf8kRp4bQiZ3VKd+h3lrWMvCdqk4L
 cXFxW5IzqHSe84ASEG72VOKhjawe7PZeD2s6rXyg4NaMTDdTW/RyPUNBju6x3N/5f8jD8F
 tEkKY0D+iyRQq5v6MMr+uxyM9gstQjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726828278;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=shDtUoCL6lWBXIWD+R8d5E/wcH6AUhyy3m73n1D8QHk=;
 b=/nE+n9SaEpruNiB1Dpli0d3hUzGeCJeqfY0ckfqVt5ovKjA/5aXjyKhGxS4jGPHW2J7WB4
 Rn1MSB4Pw5NKZJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D86913AA7;
 Fri, 20 Sep 2024 10:31:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iy1KBvZO7WZLBgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Sep 2024 10:31:18 +0000
Date: Fri, 20 Sep 2024 12:30:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Zu1OtElEn1MOKWSG@yuki.lan>
References: <ZtWLSQSSqmh0tn13@yuki.lan> <ZufqsLiVuMG_TqQN@yuki.lan>
 <ZuruTPoOHdW5G2jm@yuki.lan>
 <CAEemH2c_hKCMwRVFxV7Hqz2N5NN8iSgQ5bJ83XOWgStxEMkWQg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c_hKCMwRVFxV7Hqz2N5NN8iSgQ5bJ83XOWgStxEMkWQg@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url, imap1.dmz-prg2.suse.org:helo,
 suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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
> LTP pre-release tests (on RHEL series products and mainline kernel
> v6.11-rc6)
> all look good from my side.

Thanks.

> And I have a tiny fix that may need merge:
>   https://lists.linux.it/pipermail/ltp/2024-September/040288.html

I haven't had time to get to this yet but I plan to review the patch
before the release.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
