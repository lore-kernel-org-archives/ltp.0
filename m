Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE02C54E94
	for <ltp@archiver.kernel.org>; Tue, 24 Jan 2023 20:58:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 578723CC7B3
	for <ltp@archiver.kernel.org>; Tue, 24 Jan 2023 21:58:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BBCF3CC780
 for <ltp@lists.linux.it>; Tue, 24 Jan 2023 21:58:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9AD2110006C0
 for <ltp@lists.linux.it>; Tue, 24 Jan 2023 21:58:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 716E01F38D;
 Tue, 24 Jan 2023 20:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674593925;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0yGnNOpAo1JSPDVpRtY41dJMR1A2JxjTW9pULiH4jc=;
 b=29tN3wXOneCJAMMajBlmzLf5D3PIh6WrsrVPGGH9CBE2ytjDc8mNJTi+hXXLVs8DfCIhr0
 PnuffP8Hw+cXDSjQHQ3P6APAyaZeOnYa44RVqO0x1yyDguKnHtg2FTyBF8O8VHY0iWXOSn
 ifaf5ZLGtVdcvACWDn99QFgge5QjfaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674593925;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a0yGnNOpAo1JSPDVpRtY41dJMR1A2JxjTW9pULiH4jc=;
 b=yFUb+XdiKVZ6g6XHCBx3sXdve6ye0RYcEXm23eTHVoI8kdoS29VV93LasHxY/sCqLngbxe
 hwuZ1ivraCkBqIBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 48E4B139FB;
 Tue, 24 Jan 2023 20:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id af9dEIVG0GM8TQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 24 Jan 2023 20:58:45 +0000
Date: Tue, 24 Jan 2023 21:58:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
Message-ID: <Y9BGgsuwmg9CGVs7@pevik>
References: <Y8VRpdW7LUh4uFm9@yuki> <Y8qGFOF2M+VuTpmD@yuki>
 <Y8/TfYoRjXqVwVHq@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8/TfYoRjXqVwVHq@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi all,

> > Hi!
> > I did my share of pre-release testing and apart from the statvfs01 I've
> > send a patch for there rest of results looks green.

> > I also did test the runltp-ng and we fixed a few bugs there in order to
> > have a flawless experince since it will be introduced in the LTP
> > tarball. It would be great if anyone else would do so as well.

> > And given that the mailing list is mostly silent I suppose, unless
> > anybody objects, that we can freeze the git now and declare the next
> > week as pre-release testing week. With that we would be aiming for the
> > release either at Friday 27.01. or at Monday or Tuesday 29-30.01.

> I'd be for Friday (given there is SUSE hackweek since Monday).
> I'm going to do build testing for various architectures.
> I can help to tag the release and upload files (as I did last release).

> But before I'll try to fix nft01.sh -6, which is broken on newest 1.8.9:

> nft01 2 TINFO: Use nft to DROP packets from particular IP
> nft01 2 TINFO: Rule to block icmp from ::1
> nft01 2 TFAIL: nft command failed to append new rule
> Error: syntax error, unexpected junk
> 'add rule ip6 filter INPUT meta l4proto ipv6-icmp ip6 saddr ::1 counter drop'

I'm not sure, but it looks like 83604e7f ("xlate: get rid of escape_quotes")
broke the test (not sure, because xtables-nft-multi which I compiled from
iptables git, which is a symlink to ip6tables-translate, which is used here
always fail, but since 83604e7f the error message is the same as what I see on
openSUSE Tumbleweed	iputils v1.8.9).

I'm not really sure what should be changed in this line:

		$(ip${TST_IPV6}tables-translate $@ | sed 's,\\,,g')

Kind regards,
Petr

> Kind regards,
> Petr

[1] https://git.netfilter.org/iptables/commit/?id=83604e7f7327b6b3197f98b4e579a2b88a4c7356

+++ testcases/network/iptables/iptables_lib.sh
@@ -22,7 +22,7 @@ NFRUN()
 	if [ "$use_iptables" = 1 ]; then
 		ip${TST_IPV6}tables $@
 	else
-		$(ip${TST_IPV6}tables-translate $@ | sed 's,\\,,g')
+		$(ip${TST_IPV6}tables-translate $@)
 	fi
 }
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
