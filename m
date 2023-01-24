Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CE4C25B4E
	for <ltp@archiver.kernel.org>; Tue, 24 Jan 2023 12:29:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 676C43CC77F
	for <ltp@archiver.kernel.org>; Tue, 24 Jan 2023 13:29:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F2DE3CB3A0
 for <ltp@lists.linux.it>; Tue, 24 Jan 2023 13:28:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B35BA2003B1
 for <ltp@lists.linux.it>; Tue, 24 Jan 2023 13:28:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9BB53218A2;
 Tue, 24 Jan 2023 12:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674563327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XW5Bp29wD+NJcgYoyqnqBAGgc+DXt19urBwsuH1+eCQ=;
 b=IQhzDzXe+WyqWnjH/6vmDhQqkNCNmTYramls80KRH4cYVPm/aQUSrXJCXsxTeQeE4tMB5U
 OkgZgQO7B7/iUKfyARn4ALAPD0ywbVe5rdKZDgbHWVukvxlzkHsm5WCwBjy9NeXZvVw/6o
 x8vJ/YJ5YdvxzSKv4jUAN6SRxillGB4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674563327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XW5Bp29wD+NJcgYoyqnqBAGgc+DXt19urBwsuH1+eCQ=;
 b=lbOMXdRukG1f1lgg3Qj2sDwNm/uG44M7v88aLD5kdSCgUVLVAF/kuXV/zwjiw15Sfvw/4+
 SWMAD1VT+w7hejBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69F2E139FB;
 Tue, 24 Jan 2023 12:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xXgiGP/Oz2NhPgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 24 Jan 2023 12:28:47 +0000
Date: Tue, 24 Jan 2023 13:28:45 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, ltp@lists.linux.it
Message-ID: <Y8/O/S/CCh4KCmFV@pevik>
References: <20230124044227.13635-1-akihiko.odaki@daynix.com>
 <Y8/AoCIniws6bVjd@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y8/AoCIniws6bVjd@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] network/stress/http: Do not use SIGPIPE
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

Hi Akihiko,

> > curl ignores SIGPIPE according to:
> > https://github.com/curl/curl/commit/e2bcd2ab9e5ad894a57756fa660d2a07b69171f4

Although curl really does not kill when testing manually, running:
curl -L -o /tmp/delete.iso http://download.opensuse.org/tumbleweed/iso/openSUSE-Tumbleweed-DVD-x86_64-Current.iso

In another terminal this blocks:
killall -w -s SIGPIPE curl

But when I tested with nginx the original code with -s SIGPIPE) it works:

export HTTP_DOWNLOAD_DIR=/srv/www/htdocs/
PATH="/opt/ltp/testcases/bin:$PATH" http-stress.sh -i3

http-stress 1 TINFO: initialize 'lhost' 'ltp_ns_veth2' interface
http-stress 1 TINFO: add local addr 10.0.0.2/24
http-stress 1 TINFO: add local addr fd00:1:1:1::2/64
http-stress 1 TINFO: initialize 'rhost' 'ltp_ns_veth1' interface
http-stress 1 TINFO: add remote addr 10.0.0.1/24
http-stress 1 TINFO: add remote addr fd00:1:1:1::1/64
http-stress 1 TINFO: Network config (local -- remote):
http-stress 1 TINFO: ltp_ns_veth2 -- ltp_ns_veth1
http-stress 1 TINFO: 10.0.0.2/24 -- 10.0.0.1/24
http-stress 1 TINFO: fd00:1:1:1::2/64 -- fd00:1:1:1::1/64
http-stress 1 TINFO: run over IPv4
http-stress 1 TINFO: http client download test file
http-stress01-rmt 1 TINFO: stat: time=0.933851 size=2147483647 speed=2299599879
http-stress 1 TPASS: Test is finished successfully
http-stress 2 TINFO: clients request data asynchronously 10 sec
http-stress02-rmt 1 TINFO: stat: time=1.464465 size=2147483647 speed=1466394654
http-stress 2 TPASS: Test is finished successfully

pgrep -a curl # nothing

Not sure what am I missing, but I don't see any problem to accept this patch.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
