Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9671C05027
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 08:38:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CDA03CB46D
	for <ltp@archiver.kernel.org>; Fri, 20 Jan 2023 09:38:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31EC03C4D1C
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 09:38:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4B3BB200DE1
 for <ltp@lists.linux.it>; Fri, 20 Jan 2023 09:38:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3989B5D9B2;
 Fri, 20 Jan 2023 08:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674203925;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xKpciVtEnH0cOJtFqQwyaRTEbD5KgurUTkUuZ6DqV6I=;
 b=DMvhqn1P/UDVX3az2vPibuNwiUm67SUzSXdTLinATu4aisMpD952SuE1nuQzXzbBGmwDYE
 WeM5UNQ65buAdDbMFawR0oi2nQd+7jHxvnHqiKBAALZgMnKrLadA4pTKeQIzmwxKkXxpXY
 y2F264pfQDJhrtNQmuOpZk8KJXeX5RM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674203925;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xKpciVtEnH0cOJtFqQwyaRTEbD5KgurUTkUuZ6DqV6I=;
 b=JVWvz/Nyo5TKAPBEhC/r4ZAscrOwIGd+l8fseBL3VhaMgzWnOdeB84A2KWpH3DEj3VMLT4
 CDMg3R/IUcEjdPDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DF9113251;
 Fri, 20 Jan 2023 08:38:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Gob/BRVTymOvFQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 20 Jan 2023 08:38:45 +0000
Date: Fri, 20 Jan 2023 09:38:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Y8pTE3I38qTV2Kez@pevik>
References: <20230117040132.5245-1-wegao@suse.com> <Y8ZdSla1SoyThtBj@pevik>
 <Y8Zg+PIzLUySx2BI@aa>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8Zg+PIzLUySx2BI@aa>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_net.sh: Add more tst_require_cmds check
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

> On Tue, Jan 17, 2023 at 09:33:14AM +0100, Petr Vorel wrote:
> > Hi Wei,

> > > More strict check for ns_xxx etc will help avoid following issue:
> > > https://github.com/linux-test-project/ltp/issues/991

> > > Signed-off-by: Wei Gao <wegao@suse.com>
> > > Suggested-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > >  testcases/lib/tst_net.sh | 2 ++
> > >  1 file changed, 2 insertions(+)

> > > diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> > > index ceb45c98d..ec915ad74 100644
> > > --- a/testcases/lib/tst_net.sh
> > > +++ b/testcases/lib/tst_net.sh
> > > @@ -205,6 +205,7 @@ tst_rhost_run()
> > >  	sh_cmd="$pre_cmd $cmd $post_cmd"

> > >  	if [ -n "${TST_USE_NETNS:-}" ]; then
> > > +		tst_require_cmds ip ns_create ns_exec ns_ifmove
> > Why this? none of these commands is used here.
> This line is the key to avoid wrong configuration(such as add ip inteface etc..) continue even ns_xxx not exist,
> you can check following code, line 222 will execute ns_xxx with error but not exit test immediately, so if we add 
> require_cmds here then we can avoid it. (line 222 $rcmd will contain command ns_xxx)

>  218                 tst_res_ TINFO "tst_rhost_run: cmd: $cmd"
>  219                 tst_res_ TINFO "$use: $rcmd \"$sh_cmd\" $out 2>&1"
>  220         fi
>  221
>  222         output=$($rcmd "$sh_cmd" $out 2>&1 || echo 'RTERR')
>  223
>  224         echo "$output" | grep -q 'RTERR$' && ret=1
>  225         if [ $ret -eq 1 ]; then

Long time ago the first run code for netns was init_ltp_netspace.
I added IPv6 check quite recently. (I originally submitted it as run after, but
in the end it is run before it.)
I need to have a deeper look how tst_net_detect_ipv6 rhost works, calling
tst_rhost_run before init_ltp_netspace should not work (interfaces aren't
configured yet).

But even if "ip ns_create ns_exec ns_ifmove" are needed to be checked to fix
tst_rhost_run (not yet convinced), why to check them each time tst_rhost_run is
called? It should be checked before first tst_rhost_run call to avoid useless
repeating.

Kind regards,
Petr

> > >  		use="NETNS"
> > >  		rcmd="$LTP_NETNS sh -c"
> > >  	else
> > > @@ -1006,6 +1007,7 @@ IPV6_RHOST="${IPV6_RHOST:-fd00:1:1:1::1/64}"
> > >  # tst_net_iface_prefix -h
> > >  # tst_net_vars -h
> > >  if [ -z "$_tst_net_parse_variables" ]; then
> > > +	tst_require_cmds tst_net_ip_prefix
> > This is correct.

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
