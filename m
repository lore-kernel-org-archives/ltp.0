Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37800C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 16:10:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B9F73CA141
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 17:10:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ACB803C9678
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 17:10:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 155651000600
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 17:10:07 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 571B21F37E;
 Fri, 18 Feb 2022 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645200607;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4rsTXW29qxg2+cqluVcJBFladFntt9qoCTA+JqjSLrk=;
 b=ZFDaKIWe/bUBv5prYNrxv+WtyPIGemglovu2IXKqPPuclQj+FHlrEU64/nNMi4Zu+XVDIp
 GxRshN1MfN1Dzzctt3FXKMMKysQ6IedtiL/T69RJLMe/Rgy2pRMqygsGxPAe2eASo0OOdP
 hEXU19fPDvY1DVjROTRZRqG+P5ZTvR0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645200607;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4rsTXW29qxg2+cqluVcJBFladFntt9qoCTA+JqjSLrk=;
 b=vygKWWPjx5N6plc3ussIaGbP9T+RNtNP47URu56hzZi+4wVN21PEDQZ9TPg90Sld91yUHY
 3Tg17KSfHsmIzjCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CC5713CA1;
 Fri, 18 Feb 2022 16:10:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YquCAN/ED2IdOAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 16:10:07 +0000
Date: Fri, 18 Feb 2022 17:10:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Yg/E3aAwnUWYgchY@pevik>
References: <20220218160035.4121-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220218160035.4121-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] netstress: Workaround race between SETSID()
 and exit(0)
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hm, on one of the machines it blocked after 12 runs:

tcp_ipsec 1 TINFO: run server 'netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.txQv6HznbZ'
tcp_ipsec 1 TINFO: run client 'netstress -l -H 10.0.0.1 -n 100 -N 100 -D ltp_ns_veth2 -a 2 -r 100 -d tst_netload.res' 5 times

root     22529  0.0  0.0   4812   792 pts/2    S+   11:02   0:00 ns_exec 3181 net mnt sh -c  netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.txQv6HznbZ  || echo RTERR
root     22530  0.0  0.2  18216  2880 pts/2    S+   11:02   0:00 sh -c  netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.txQv6HznbZ  || echo RTERR
root     22531  0.0  0.0   9072   920 pts/2    S+   11:02   0:00 netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.txQv6HznbZ
root     22532  0.0  0.0   9072   160 pts/2    S    11:02   0:00 netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.txQv6HznbZ
root     22533  0.0  0.0   9072   168 ?        Ss   11:02   0:00 netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.txQv6HznbZ

# strace -p 22531
strace: Process 22531 attached
wait4(22532, strace: Process 22531 detached
 <detached ...>

# strace -p 22532
strace: Process 22532 attached
pause(strace: Process 22532 detached
 <detached ...>

# strace -p 22533
strace: Process 22533 attached
accept(5,  <unfinished ...>)            = ?

But maybe just caused by running in loop without any sleep (was ok next time):
i=0; while true; do i=$((i+1)); echo "=== $i ==="; ./tcp_ipsec.sh -s 100:1000:65535:R65535 || break; done

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
