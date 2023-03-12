Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B7AC7618A
	for <ltp@archiver.kernel.org>; Sun, 12 Mar 2023 00:47:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C49B63CD761
	for <ltp@archiver.kernel.org>; Sun, 12 Mar 2023 01:47:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 286EA3CA8D8
 for <ltp@lists.linux.it>; Sun, 12 Mar 2023 01:47:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7F77D1000524
 for <ltp@lists.linux.it>; Sun, 12 Mar 2023 01:47:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BD1101FDEB;
 Sun, 12 Mar 2023 00:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678582039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2L+XMmIpCCeumk4gRYsS5T8u31QKPFh4ES5vT8RFo8w=;
 b=PkJ9z/4VEisWlF0PnfrgdRY+p4pNhjqDVneQu9drw7Io20toW9f9Gn8w2ZScSp4oKEI8lK
 dxOoVNIs6X0C8EknnoyIP04QfArLOasdMoEyXS1YkswjG/K/YCD4CoOHQtBmLavVD6EdDk
 O1kFZaBzjWJtiZIzltFyAjO7fMunBF0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EE501377A;
 Sun, 12 Mar 2023 00:47:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 66YVOhYhDWTuPgAAMHmgww
 (envelope-from <wegao@suse.com>); Sun, 12 Mar 2023 00:47:18 +0000
Date: Sat, 11 Mar 2023 19:47:16 -0500
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <20230312004716.GA17073@localhost>
References: <20230310140407.20137-1-wegao@suse.com> <ZAtEIClci4QximeK@yuki>
 <20230311022309.GA12553@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230311022309.GA12553@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] madvise11.c:Check loadable module before rmmod
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Mar 10, 2023 at 09:23:09PM -0500, Wei Gao via ltp wrote:
> On Fri, Mar 10, 2023 at 03:52:16PM +0100, Cyril Hrubis wrote:
> > Hi!
> > > +static int is_loadable_module(const char *modname)
> > > +{
> > > +	char command[MAX_BUF];
> > > +	char line[MAX_BUF];
> > > +	char *token;
> > > +
> > > +	sprintf(command, "lsmod | grep '^%s'", modname);
> > > +
> > > +	FILE *fp = popen(command, "r");
> > > +
> > > +	if (fp == NULL)
> > > +		tst_brk(TBROK, "Popen command %s failed", command);
> > > +
> > > +	if (fgets(line, MAX_BUF, fp) != NULL) {
> > > +		token = strtok(line, " \t\n");
> > > +		if (strcmp(token, modname) == 0) {
> > > +			pclose(fp);
> > > +			return 1;
> > > +		}
> > > +	}
> > > +
> > > +	pclose(fp);
> > > +	return 0;
> > > +}
> > 
> > The code already has if (!find_in_file("/proc/modules", HW_MODULE)), you
> > are reinventing the wheel.
> There is an issue happen during our test, the fail happen with following failed msg.
> rmmod: ERROR: Module hwpoison_inject is builtin.
> madvise11.c:356: TWARN: rmmod failed (1)
> 
> So i think before rmmod we should check this module can be rmmod or not.
> And every modules which can show in lsmod output, it means the module can be unload.
> I am not sure the output of /proc/modules contain ONLY loadable module, it maybe
> also can contain the buildin module so this function created.
> 
I have found modinfo is more stable way to check whether module is builtin or not.
I have update the patch to v3 now.
> > 
> > -- 
> > Cyril Hrubis
> > chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
