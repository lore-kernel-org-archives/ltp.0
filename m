Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F497C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:28:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EB4E3C7BD2
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 14:28:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 531AF3C2204
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:28:00 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 21A201BCFDE1
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:27:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5508321177;
 Fri, 17 Jan 2025 13:27:59 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 359F913332;
 Fri, 17 Jan 2025 13:27:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Hj7gC99aimceawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 13:27:59 +0000
Date: Fri, 17 Jan 2025 14:27:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250117132753.GA766927@pevik>
References: <20250117122455.7989-1-chrubis@suse.cz>
 <20250117122455.7989-2-chrubis@suse.cz> <Z4pOAZJATd73M02O@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z4pOAZJATd73M02O@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 5508321177
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] testcases/lib: tst_net.sh: Do not use stderr
 in tst_rhost_run()
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

> Hi!
> > This is another place that broke the network test on the unrelated
> > changes that caused the SAFE_CLONE() to produce TINFO messages. The test
> > library prints messages into the stdout, because this is something that
>                                       ^
> 				      stderr

+1.

> > is not supposed to be the command output but rather diagnostic messages.
> > So there was no good reason to include the stderr in the data we got
> > from the tst_rhost_run().

> > If this patch does not break anything it should be pushed since this
> > will fix the tst_ns_* helpers even if the they start print diagnostics
> > TINFO messages again.

> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > ---
> >  testcases/lib/tst_net.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
> > index ee0ae1cad..60bc25b79 100644
> > --- a/testcases/lib/tst_net.sh
> > +++ b/testcases/lib/tst_net.sh
> > @@ -257,7 +257,7 @@ tst_rhost_run()
> >  		tst_res_ TINFO "$use: $rcmd \"$sh_cmd\" $out 2>&1"
> >  	fi

> > -	output=$($rcmd "$sh_cmd" $out 2>&1 || echo 'RTERR')
> > +	output=$($rcmd "$sh_cmd" $out || echo 'RTERR')

I'm not sure about this. Maybe it's safe, because stderr gets to the output.
But in case some network test need to verify something which is defined on
stderr it will fails (when tst_rhost_run is run with -s).

FYI *without* this patch:

	# route-redirect.sh
	...
	route-redirect 1 TINFO: timeout per run is 0h 5m 0s
	route-redirect 1 TBROK: 'ns-icmp_redirector -I ltp_ns_veth1 -b' failed on '': 'sh: 1: ns-icmp_redirector: not found'
	route-redirect 1 TWARN: 'killall -SIGHUP ns-icmp_redirector' failed on '': 'ns-icmp_redirector: no process found'
	ns-icmp_redirector: no process found

and *with* this patch:

	# route-redirect.sh
	...
	route-redirect 1 TINFO: timeout per run is 0h 5m 0s
	sh: 1: ns-icmp_redirector: not found
	route-redirect 1 TBROK: 'ns-icmp_redirector -I ltp_ns_veth1 -b' failed on '': ''
	ns-icmp_redirector: no process found
	route-redirect 1 TWARN: 'killall -SIGHUP ns-icmp_redirector' failed on '': ''

Info is there, but not on the same line (second '').

Also with the change below it would be more meaningful (fixing first empty ''):

route-redirect 1 TBROK: 'ns-icmp_redirector -I ltp_ns_veth1 -b' failed on NETNS: 'sh: 1: ns-icmp_redirector: not found'
route-redirect 1 TWARN: 'killall -SIGHUP ns-icmp_redirector' failed on NETNS: 'ns-icmp_redirector: no process found'
ns-icmp_redirector: no process found

I also wrote conditional quiet on stderr (not sent to ML), but actually if we
merge this and need sometimes to parse stderr, the opposite would be needed.

Kind regards,
Petr

+++ testcases/lib/tst_net.sh
@@ -263,7 +263,7 @@ tst_rhost_run()
 	if [ $ret -eq 1 ]; then
 		output=$(echo "$output" | sed 's/RTERR//')
 		[ "$safe" ] && \
-			tst_brk_ TBROK "'$cmd' failed on '$RHOST': '$output'"
+			tst_brk_ TBROK "'$cmd' failed on $use: '$output'"
 	fi
 
 	[ -z "$out" -a -n "$output" ] && echo "$output"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
