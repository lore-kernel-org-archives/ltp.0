Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4277AECAAA1
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 10:02:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E59A3CAA17
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 12:02:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B89B3CA9E9
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 12:02:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 612B0200FC5
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 12:02:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 516751F8E4;
 Fri,  9 Sep 2022 10:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662717742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h/FJollAtVg4oYG9rx31Lq1Hc7g8wg5Zx7NmVKRsAPg=;
 b=OLzG6O8sS//XasGya7zBEO79GUahz4lHcacXEkjVYQZuMh4+ODZLlUYq3Avn4dVl30FrXI
 yS9OxS/juLiL+9fDChIy9BLj2rk8DK8boDPlyT3fUK7bW5AMMb4FaQ5ksq3xVRH+Txi5oP
 eqV/JObRokez3AD/NfsPDX3odIG/8mM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662717742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h/FJollAtVg4oYG9rx31Lq1Hc7g8wg5Zx7NmVKRsAPg=;
 b=xFl4TfebHr/Svb2zj3FUYvRPIt8im7+hpm58tEMEJH1Uj40M8oeusizPPsQ6pshu0Ebnzj
 5btwPwiuF8lmJ6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 104E513A93;
 Fri,  9 Sep 2022 10:02:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5sOzAi4PG2NibgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 10:02:22 +0000
Date: Fri, 9 Sep 2022 12:02:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YxsPLHR0QLn4gHrb@pevik>
References: <20220902133710.1785-1-pvorel@suse.cz>
 <20220902133710.1785-4-pvorel@suse.cz> <YxsKBI2256Ldmhpn@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxsKBI2256Ldmhpn@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/9] tst_supported_fs: Implement skip list
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > +			fs = optarg;
> > +			for (i = 0; i < cnt; i++)
> > +				skiplist[i] = strtok_r(fs, TST_TO_STR(SKIP_DELIMITER), &fs);
> > +			break;

> It may be a bit cleaner to put this part into a function i.e.

> 	skiplist = parse_skiplist(optarg);

Suppose code below is good enough (will be in v5).
Thanks for your review!

Kind regards,
Petr

char **parse_skiplist(char *fs)
{
	char **skiplist = NULL;
	int i, cnt = 1;

	for (i = 0; fs[i]; i++) {
		if (optarg[i] == SKIP_DELIMITER)
			cnt++;
	}

	skiplist = malloc(++cnt * sizeof(char *));
	if (!skiplist) {
		fprintf(stderr, "malloc() failed\n");
		return NULL;
	}

	for (i = 0; i < cnt; i++)
		skiplist[i] = strtok_r(fs, TST_TO_STR(SKIP_DELIMITER), &fs);

	return skiplist;
}

int main(int argc, char *argv[])
{
	const char *const *filesystems;
	int i, ret;
	char **skiplist = NULL;

	while ((ret = getopt(argc, argv, "hs:"))) {
		if (ret < 0)
			break;

		switch (ret) {
		case '?':
			usage();
			return 1;

		case 'h':
			usage();
			return 0;

		case 's':
			skiplist = parse_skiplist(optarg);
			if (!skiplist)
				return 1;
			break;
		}
	}
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
