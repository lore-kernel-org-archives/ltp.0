Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2841C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 08:23:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4F773CD923
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 09:23:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DEEE3CD0FE
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 09:22:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DE31410149A0
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 09:22:46 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 693A321C28;
 Fri,  1 Dec 2023 08:22:45 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A0381344E;
 Fri,  1 Dec 2023 08:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id bjR1ENWXaWU6VAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 01 Dec 2023 08:22:45 +0000
Date: Fri, 1 Dec 2023 09:22:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Mengchi Cheng <mengcc@amazon.com>
Message-ID: <20231201082243.GA1710028@pevik>
References: <20231130104127.GA3099694@pevik>
 <20231130221522.689680-1-mengcc@amazon.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231130221522.689680-1-mengcc@amazon.com>
X-Spamd-Bar: ++++++
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [6.40 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 ARC_NA(0.00)[]; R_SPF_SOFTFAIL(4.60)[~all];
 DMARC_NA(1.20)[suse.cz];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 RCPT_COUNT_TWO(0.00)[2]; NEURAL_SPAM_LONG(0.71)[0.203];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(2.20)[]; MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 693A321C28
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] rwtest: Confirm df is a symlink to busybox
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

> On Thu, 2023-11-30 10:41:27 +0000, Petr Vorel wrote:

> > Hi Mengchi,

> > > /bin/df can be a symlink to coreutils. It returns correct info with dir
> > > arguments.
> > > Just checking if df is a symlink will include such cases. Need to make
> > > sure it is linking to busybox before ignoring options.

> > > Signed-off-by: Mengchi Cheng <mengcc@amazon.com>
> > > ---
> > >  testcases/kernel/fs/doio/rwtest | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)

> > > diff --git a/testcases/kernel/fs/doio/rwtest b/testcases/kernel/fs/doio/rwtest
> > > index 6725e1426..26659e9d3 100644
> > > --- a/testcases/kernel/fs/doio/rwtest
> > > +++ b/testcases/kernel/fs/doio/rwtest
> > > @@ -329,10 +329,10 @@ do
> > >  		else
> > >  			# If df is a symlink (to busybox) then do not pass the $dir and $dfOpts
> > >  			# parameters because they don't work as expected
> > > -                        if test -h $(which df)
> > > -                           then
> > > -                               dir=""; dfOpts="";
> > > -                        fi
> > > +			if [[ "$(readlink -f "$(which df)")" == *"busybox"* ]]
> > Could you please test if this works?

> > 			if [ "$(readlink -f "$(which df)")" = "busybox" ]

> I just replaced df with a symlink cmd and the string such as zstdmt/zstd in ubuntu.
> It does not work..
> But below should work
> 			if echo "$(readlink -f "$(which df)")" | grep -q "busybox"

Yes, this would work, but this would be better:

if df --version 2>&1 | grep -q 'BusyBox'

this is way simpler and this detection is already used elsewhere.

BTW how can happen that df is symlink on coreutils?
They provide a binary, right?

> However, I linked df to /bin/busybox on my device, df -P ${dir} seems fine.
> The original code may be for a very old version of busybox.
> :/# ls -l /bin/df
> lrwxrwxrwx 1 root root 12 2023-11-16 17:49 /bin/df -> /bin/busybox
> :/# df -P tmp
> Filesystem           1024-blocks    Used Available Capacity Mounted on
> tmpfs                   280848         4    280844   0% /tmp
> :/# /usr/bin/df.coreutils -P tmp
> Filesystem     1024-blocks  Used Available Capacity Mounted on
> tmpfs               280848     4    280844       1% /tmp

> My busybox version is v1.35.0. It might be ok to remove the check completely.

-P was implemented in 2008
https://github.com/mirror/busybox/commit/d66aa3c701ffb83343239e71a8b294407ff5df86

BusyBox has often some features configurable (feature can be disabled), but if I
look correctly -P is not guarded to any config option

https://github.com/mirror/busybox/blob/master/coreutils/df.c

Therefore I'm for removing this option entirely. Please send v2.

Kind regards,
Petr

> Best,
> Mengchi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
