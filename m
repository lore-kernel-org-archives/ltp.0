Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF5BEB64D9
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 11:50:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09B483C9999
	for <ltp@archiver.kernel.org>; Tue,  4 Jul 2023 13:50:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C80073C997D
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 13:50:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 85BCC1A00801
 for <ltp@lists.linux.it>; Tue,  4 Jul 2023 13:50:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EAA3822819;
 Tue,  4 Jul 2023 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688471414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTSMUvSrPjEVmoXhk5sTK8DkvDsIl6W4AGd3x081O6A=;
 b=bu+XHK+r6uDtEvgu8DwyjVe+U7OckgBn3c7oT7xxvI7wHHUCs1YhtMSs9qBk0AT8TPzNs6
 vGgKmoOnrei8QZFmu2KgBdCHhCy+reZpLSgzvDAksfzxl036ILIbvSDsQrBhLCuanGbN04
 QmdH3HlvOCD63jR0xSKU1v/lOruGd1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688471414;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XTSMUvSrPjEVmoXhk5sTK8DkvDsIl6W4AGd3x081O6A=;
 b=WiS666TuQhD3QZllcOtad+C4/pNzQMXR9B6d4rfQ5f6TGuvdAW95YgoI5srthCyvDlWC1/
 3XMbOB3wtm+KjZCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D110F133F7;
 Tue,  4 Jul 2023 11:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JrMXMnYHpGRIHgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Jul 2023 11:50:14 +0000
Date: Tue, 4 Jul 2023 13:50:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230704115013.GD507064@pevik>
References: <20230704091933.496989-1-pvorel@suse.cz>
 <20230704091933.496989-3-pvorel@suse.cz> <ZKP1afDMgcKSIESE@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZKP1afDMgcKSIESE@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 2/3] lib/C-API: Add option -V to print LTP
 version
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

Hi Cyril,

...
> > @@ -686,6 +688,10 @@ static void parse_opts(int argc, char *argv[])
> >  			else
> >  				duration = SAFE_STRTOF(optarg, 0.1, HUGE_VALF);
> >  		break;
> > +		case 'V':
> > +			fprintf(stderr, LTP_VERSION "\n");
> > +			exit(0);
> > +		break;

> Why don't we print that as a part of help? Do we really need to allocate
> a flag for this?

Well, people expect -V or --verbose. But because I add printing also on running
test, we could just move it to -h.

BTW I was also thinking about using getopt_long(), at least to allow --help,
I guess you don't think any value in it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
