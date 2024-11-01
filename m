Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC5AE6F06F
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 17:03:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E77AD3CDB02
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 18:03:10 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AF2C3CD7EE
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 18:02:55 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 64A9A243620
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 18:02:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 838A021B1E;
 Fri,  1 Nov 2024 17:02:51 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55A41136D9;
 Fri,  1 Nov 2024 17:02:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8ZcwDroJJWfOLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 01 Nov 2024 17:02:50 +0000
Date: Fri, 1 Nov 2024 18:02:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20241101170233.GA1294836@pevik>
References: <20241101-generate_syscalls-v9-0-d2c3820b0323@suse.com>
 <20241101-generate_syscalls-v9-2-d2c3820b0323@suse.com>
 <20241101113019.GA1264676@pevik>
 <d6bf0ba3-92eb-476e-8c6d-b6fcec1c258c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d6bf0ba3-92eb-476e-8c6d-b6fcec1c258c@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 838A021B1E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 2/5] Add script to generate arch(s) dependant
 syscalls
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

> Hi,

> On 11/1/24 12:30, Petr Vorel wrote:
> > Hi Andrea,

> > ...
> > > +		for syscall in $(cat ${TEMP}/syscall-names.txt); do
> > > +			printf "
> > > +		#ifdef __NR_$syscall
> > > +			printf(\"$syscall %%d"
> > > +			# i know the following print is ugly, but dash and bash
> > > +			# treat double quoted strings in a different way and we
> > > +			# really need to inject '\n' character in the C code
> > > +			# rather than carriage return
> > > +			printf '\\n'
> > > +			printf "\", __NR_$syscall);
> > How about using heredocs? IMHO more compatible way of echo/printf "" for new
> > lines:
> > cat << EOF
> > ...
> > EOF

> > I should have noted that at previous version.
> > Hint: looking into tst_test.sh can sometimes help.

> > Also there is echo/printf '' variant:
> > cat << 'EOF'
> > EOF
> > https://unix.stackexchange.com/questions/462593/how-to-escape-a-character-in-a-heredoc-bash-script/462595#462595

> > There is also ~EOF - ignore leading whitespace, even for terminating EOF.

> > Kind regards,
> > Petr

> This method is so ugly: basically the ending EOF must be in the first column
> of the next line, otherwise it won't be parsed. And this breaks readability
> of course (probably some debugging). I really would avoid this way..

I would say EOF if quite standard way of using shell + it allows you to use \n
unescaped:

syscall="XXX"
cat > foo.txt <<EOF
	printf(\"$syscall %%d"
	printf '\n'
EOF

prints into foo.txt:
	printf(\"XXX %%d"
	printf '\n'

But sure, it's just a suggestion based your comment.

Kind regards,
Petr

> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
