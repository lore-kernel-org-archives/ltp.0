Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA50CDB465
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 15:49:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E10FE3CFA45
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 17:49:09 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFA063C8689
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 17:49:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C06BA100096D
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 17:48:58 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1BDD821C1E;
 Mon, 16 Oct 2023 15:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697471338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NnGmGUs5OKpPyBST+XW4cTXDXY3NGLjW9kceXUH/HTs=;
 b=NggqpFTsydzUi3exB0XDOW8JwR8jQrZ/G6pm4mZ7Uz+TT90r9YbhFKz63CTXw5Dh94MEgH
 hHiCqjvSpANG1jSYGNbn0Kli25+O1W1+0w9wTrMGGzyucF715VvP4+QHACHPQ5U0Inysco
 V64XAri98ltWW0IJlxHkVl5kx1qNeLo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697471338;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NnGmGUs5OKpPyBST+XW4cTXDXY3NGLjW9kceXUH/HTs=;
 b=DXtZJuuoguzYbqId33Gvfh3GNLJ4J1kh3cUJjnj5YVSxK6FuYfkOrUviFsFTKKVckwwB19
 ZPHkyPQaun9B1cAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A4EA138EF;
 Mon, 16 Oct 2023 15:48:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bJ10AmpbLWWCDgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 16 Oct 2023 15:48:58 +0000
Date: Mon, 16 Oct 2023 17:49:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZS1bjvd84DVj9hUX@yuki>
References: <20231012111333.32004-1-wegao@suse.com>
 <20231012112548.6887-1-wegao@suse.com> <ZSf9IdW9ciTDjkFm@yuki>
 <ZSoMsDNyf4Y+w8d3@wegao>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZSoMsDNyf4Y+w8d3@wegao>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.25 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.65)[-0.654]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_SPAM_LONG(3.00)[1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add test for UI_GET_NAME ioctl
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
> > > +static int check_ui_get_sysname_ioctl(int fd)
> > > +{
> > > +	char name[256];
> > > +
> > > +	SAFE_IOCTL(NULL, fd, UI_GET_SYSNAME(sizeof(name)), name, NULL);
> > > +
> > > +	DIR *test_dir;
> > > +
> > > +	struct dirent *ent;
> > > +
> > > +	test_dir = SAFE_OPENDIR(NULL, "/sys/devices/virtual/input/");
> > > +
> > > +	while ((ent = SAFE_READDIR(NULL, test_dir))) {
> > > +		if (!strcmp(ent->d_name, name))
> > > +			return 1;
> > > +		else
> > > +			continue;
> > > +	}
> > 
> > Why do we loop over the directory here? Can't we just directly check
> > that the path /sys/devices/virtual/input/$name/ exists?
> > 
> > I guess that we can as well read the
> > /sys/devices/virtual/input/$name/dev and match that against fstat() on
> > the fd.
> Seems no dev node can be found under /sys/devices/virtual/input/$name/.
> 
> ll /sys/devices/virtual/input/input13/
> total 0
> drwxr-xr-x 2 root root    0 Oct 13 21:32 capabilities
> drwxr-xr-x 3 root root    0 Oct 13 21:32 event8
> drwxr-xr-x 2 root root    0 Oct 13 21:32 id
> -rw-r--r-- 1 root root 4.0K Oct 13 21:33 inhibited
> -r--r--r-- 1 root root 4.0K Oct 13 21:33 modalias
> drwxr-xr-x 3 root root    0 Oct 13 21:32 mouse3
> -r--r--r-- 1 root root 4.0K Oct 13 21:32 name
> -r--r--r-- 1 root root 4.0K Oct 13 21:32 phys
> drwxr-xr-x 2 root root    0 Oct 13 21:33 power
> -r--r--r-- 1 root root 4.0K Oct 13 21:32 properties
> lrwxrwxrwx 1 root root    0 Oct 13 21:32 subsystem -> ../../../../class/input
> -rw-r--r-- 1 root root 4.0K Oct 13 21:32 uevent
> -r--r--r-- 1 root root 4.0K Oct 13 21:33 uniq

Ah, right, it's under the event8 directory in this case. I guess that we
can match name againts the VIRTUAL_DEVICE string instead.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
