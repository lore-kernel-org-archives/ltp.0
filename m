Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E20EE674AC
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 07:40:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E29A3CCFB6
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 08:40:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 877863CCD33
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 08:40:03 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BC0A623AF75
 for <ltp@lists.linux.it>; Fri,  1 Nov 2024 08:40:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6141421D98;
 Fri,  1 Nov 2024 07:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730446798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OFT0c1sfAu4/ULqEDR6VY/JDT8xqavNqJE1fjTtiCV8=;
 b=drTACs7p74NtzEWiNoB/eXVUvyXypog2zX4V1Y0lodJKNC3H7dWN9DlHFyg6O5hUrH1iim
 s+uLS8fKnQwwrV+d48Y2AHU4AU9vevgZj68ugebnLtYyxG2UdGWnSTIia+6rMJU7dOp0je
 4eDzDl/qE5h3M56L+gB2wuk+ZwvY2vU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730446798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OFT0c1sfAu4/ULqEDR6VY/JDT8xqavNqJE1fjTtiCV8=;
 b=LJ8g5uQEmYJ16d/urxovozj0T8HQW3olzXPe86uPlbaACBx3Uy3NBpQj4niCPcCuZvmK9w
 tamJsIopUvkQQyCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=drTACs7p;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LJ8g5uQE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730446798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OFT0c1sfAu4/ULqEDR6VY/JDT8xqavNqJE1fjTtiCV8=;
 b=drTACs7p74NtzEWiNoB/eXVUvyXypog2zX4V1Y0lodJKNC3H7dWN9DlHFyg6O5hUrH1iim
 s+uLS8fKnQwwrV+d48Y2AHU4AU9vevgZj68ugebnLtYyxG2UdGWnSTIia+6rMJU7dOp0je
 4eDzDl/qE5h3M56L+gB2wuk+ZwvY2vU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730446798;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OFT0c1sfAu4/ULqEDR6VY/JDT8xqavNqJE1fjTtiCV8=;
 b=LJ8g5uQEmYJ16d/urxovozj0T8HQW3olzXPe86uPlbaACBx3Uy3NBpQj4niCPcCuZvmK9w
 tamJsIopUvkQQyCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3435013ACC;
 Fri,  1 Nov 2024 07:39:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wRf/Cs6FJGeaHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 01 Nov 2024 07:39:58 +0000
Date: Fri, 1 Nov 2024 08:39:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241101073941.GA1145995@pevik>
References: <20241031-generate_syscalls-v8-0-8e35a9d6783b@suse.com>
 <20241031-generate_syscalls-v8-1-8e35a9d6783b@suse.com>
 <ZyOucZF2mzL-Jame@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZyOucZF2mzL-Jame@yuki.lan>
X-Rspamd-Queue-Id: 6141421D98
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/4] Refactor regen.sh script to generate
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

Hi all,

> Hi!
> > +while IFS= read -r arch; do
> > +	(
> > +		echo
> > +		case ${arch} in
> > +		sparc64) echo "#if defined(__sparc__) && defined(__arch64__)" ;;
> > +		sparc) echo "#if defined(__sparc__) && !defined(__arch64__)" ;;
> > +		s390) echo "#if defined(__s390__) && !defined(__s390x__)" ;;
> > +		mips64n32) echo "#if defined(__mips__) && defined(_ABIN32)" ;;
> > +		mips64) echo "#if defined(__mips__) && defined(_ABI64)" ;;
> > +		mipso32) echo "#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32" ;;

The original code was:

-		mips_n32) echo "#if defined(__mips__) && defined(_ABIN32)" ;;
-		mips_n64) echo "#if defined(__mips__) && defined(_ABI64)" ;;
-		mips_o32) echo "#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32" ;;

ifdefs are the same, the only thing which changed are arch names. And these are
also changed, see below. The only problem I see is that the change in
supported-arch.txt below happens in the following commit. Shouldn't the rename
happen in this commit already? syscalls.h file generated from the first commit
is indeed different from the one generated in 2nd and 3rd (which are the same.

+++ b/include/lapi/syscalls/supported-arch.txt
@@ -1,13 +1,13 @@
-aarch64
 arc
+arm64
 arm
-hppa
 i386
 ia64
-loongarch
-mips_n32
-mips_n64
-mips_o32
+loongarch64
+mips64n32
+mips64
+mipso32
+parisc
 powerpc64
 powerpc
 s390x

1st commit have (which is IMHO wrong)
#ifdef __mips_n32__

2nd and 3rd have:
#if defined(__mips__) && defined(_ABIN32)

The reason due postponed changes is, that some arch use

*) echo "#ifdef __${arch}__" ;;

Whoever will do bisecting, cannot use this commit on mips and other affected
archs due broken syscalls.h. This problem appeared in v5. Previously (v3 and v4)
old names were used in generate_syscalls.sh, and in second commit (when the
generate_arch.sh archs was added) were new ones used.

IMHO clearest solution would be to move rename to 1st commit.

> It would be nice to get a confirmation from someone who knows mips that
> these changes in ifdefs are okay, otherwise:

I guess we know the answer thus we don't have to bother mips folks.
But very good catch.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
