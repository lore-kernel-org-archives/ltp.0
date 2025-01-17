Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E70C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 14:16:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2299C3C7B48
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 15:16:33 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF6163C7B03
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 15:16:17 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E56016001FE
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 15:16:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34E55211D2;
 Fri, 17 Jan 2025 14:16:16 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 079D9139CB;
 Fri, 17 Jan 2025 14:16:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pw2FOy9mimdkegAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 14:16:15 +0000
Date: Fri, 17 Jan 2025 15:16:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250117141606.GA773620@pevik>
References: <20250117122455.7989-1-chrubis@suse.cz>
 <20250117122455.7989-2-chrubis@suse.cz> <Z4pOAZJATd73M02O@yuki.lan>
 <20250117132753.GA766927@pevik> <Z4pe3estBHBQ0RTm@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z4pe3estBHBQ0RTm@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 34E55211D2
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
> > I'm not sure about this. Maybe it's safe, because stderr gets to the output.
> > But in case some network test need to verify something which is defined on
> > stderr it will fails (when tst_rhost_run is run with -s).

> That's why I send the first patch that I know is 100% safe.

+1

> > FYI *without* this patch:

> > 	# route-redirect.sh
> > 	...
> > 	route-redirect 1 TINFO: timeout per run is 0h 5m 0s
> > 	route-redirect 1 TBROK: 'ns-icmp_redirector -I ltp_ns_veth1 -b' failed on '': 'sh: 1: ns-icmp_redirector: not found'
> > 	route-redirect 1 TWARN: 'killall -SIGHUP ns-icmp_redirector' failed on '': 'ns-icmp_redirector: no process found'
> > 	ns-icmp_redirector: no process found

> > and *with* this patch:

> > 	# route-redirect.sh
> > 	...
> > 	route-redirect 1 TINFO: timeout per run is 0h 5m 0s
> > 	sh: 1: ns-icmp_redirector: not found
> > 	route-redirect 1 TBROK: 'ns-icmp_redirector -I ltp_ns_veth1 -b' failed on '': ''
> > 	ns-icmp_redirector: no process found
> > 	route-redirect 1 TWARN: 'killall -SIGHUP ns-icmp_redirector' failed on '': ''

> > Info is there, but not on the same line (second '').

> > Also with the change below it would be more meaningful (fixing first empty ''):

> > route-redirect 1 TBROK: 'ns-icmp_redirector -I ltp_ns_veth1 -b' failed on NETNS: 'sh: 1: ns-icmp_redirector: not found'
> > route-redirect 1 TWARN: 'killall -SIGHUP ns-icmp_redirector' failed on NETNS: 'ns-icmp_redirector: no process found'
> > ns-icmp_redirector: no process found

> > I also wrote conditional quiet on stderr (not sent to ML), but actually if we
> > merge this and need sometimes to parse stderr, the opposite would be needed.

> I supose that we would need to explicitly tell the tst_rhost_run() if we
> want stderr included or not. That's probably something to be done after
> the release.

Generally stderr was always needed. It got broken when tst_ns_exec, which runs
rhost commands on network namespaces, e.g. not the command it runs tst_rhost_run
with -c parameter, but how exactly it is executed. ATM I'm aware only about
tst_rhost_run runs in tst_net_setup_network(), which got broken due eval.

I can send a patch, but IMHO we should concentrate (after the release) on
rewriting as much as we can from tst_net.sh to single C binary + help to
simplify the architecture.

Kind regards,
Petr

init_ltp_netspace()
{
	export LTP_NETNS="${LTP_NETNS:-tst_ns_exec $pid net,mnt}"
	...

tst_rhost_run()
{
	...
	while getopts :bc:su: opt; do
		case "$opt" in
		b) [ "${TST_USE_NETNS:-}" ] && pre_cmd= || pre_cmd="nohup"
		   post_cmd=" > /dev/null 2>&1 &"
		   out="1> /dev/null"
		;;
		c) cmd="$OPTARG" ;;
		s) safe=1 ;;
		u) user="$OPTARG" ;;
		*) tst_brk_ TBROK "tst_rhost_run: unknown option: $OPTARG" ;;
		esac
	done
	...
	sh_cmd="$pre_cmd $cmd $post_cmd"

	if [ -n "${TST_USE_NETNS:-}" ]; then
		use="NETNS"
		rcmd="$LTP_NETNS sh -c"
	else
		tst_require_cmds ssh
		use="SSH"
		rcmd="ssh -nq $user@$RHOST"
	fi
	...
	output=$($rcmd "$sh_cmd" $out 2>&1 || echo 'RTERR')

tst_net_setup_network()
{
...
	eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV4_RHOST \
		|| echo "exit $?")
...
		eval $(tst_net_iface_prefix $IPV6_LHOST || echo "exit $?")
		eval $(tst_rhost_run -c 'tst_net_iface_prefix -r '$IPV6_RHOST \

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
