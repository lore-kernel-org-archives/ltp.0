Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35D6C47DB7
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 19:38:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D6FA3CE271
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 20:38:13 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFD823CAF8E
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 20:37:59 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 081AB2002DF
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 20:37:58 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1B0522123;
 Sun, 21 Jan 2024 19:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705865878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bAd545dadJKmD+qdKuXaSVFPmPqCd5bCYcF4+v9/sos=;
 b=L08DXtsOyBYgI8XxQa2zKaH18W1sOdriWYqxkvF9pUODtvT+WrbJnJAc5rr/Qnq08Wsl5R
 OCzNdMbrJStFF51WXARHVvXptj/BAdenrHivtfxk3vrksUrloPxCuvDbyjhCUP848BvTIQ
 LuwMOBjvzhlpIh42ShLdkUNWa/83qDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705865878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bAd545dadJKmD+qdKuXaSVFPmPqCd5bCYcF4+v9/sos=;
 b=HSV3xMbrRncyODikZTSzs6rxzSCLFd7o6QeFaqAI1BXY1/56Tp4sCE2lmVhsY0jOVFPlWo
 pLw12kbXMJIOH2AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705865877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bAd545dadJKmD+qdKuXaSVFPmPqCd5bCYcF4+v9/sos=;
 b=XpCnGRA3pyNr4nI2oCK3qkM2ajDRYdWOS+H7U0SD+FwHsVSXt4snKa/T3V5ACUY8gtd12+
 iiVx1nBSiemJ+OZ5hoY/fP2f/rnmu1eiGt8ZZ5O4uJPmh9GFdIg412Jsa3QDk2f5WfekJm
 V6SfQukVyJceK3O4vjvnSwkrr2SE8ik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705865877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bAd545dadJKmD+qdKuXaSVFPmPqCd5bCYcF4+v9/sos=;
 b=mcbBNZehLBIdwiog23y/nRs4ymrmjSv+EZQKG6tvHU/nkVWsV21OFg7i9Qcp7481gVux55
 WRq5KQgAmoWqD1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AF7D1136F5;
 Sun, 21 Jan 2024 19:37:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wOiEKJVyrWVbKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sun, 21 Jan 2024 19:37:57 +0000
Date: Sun, 21 Jan 2024 20:37:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240121193756.GB51882@pevik>
References: <20231031160918.17845-1-pvorel@suse.cz>
 <20231031160918.17845-2-pvorel@suse.cz> <ZaqjLqW1PAUUNMwE@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZaqjLqW1PAUUNMwE@yuki>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XpCnGRA3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mcbBNZeh
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: D1B0522123
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] runtest/net.nfs: Rename test names
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
> > -nfs01_06  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
> > -nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
> > -nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
> > +nfs06.sh_v3_v4_ipv4_tcp_udp  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
> > +nfs06.sh_vall_ipv4tcp nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
> > +nfs06.sh_v4*_ipv6_tcp nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"

> Putting * into a test name is asking for a trouble, who knows where it
> may expand...

Hi Cyril,

would be nfs06.sh_v4+_ipv6_tcp better? or nfs06.sh_v4plus_ipv6_tcp
Or should I merge as nfs06.sh_v4_ipv6_tcp

Thanks a lot for having a look!

Kind regards,
Petr

> Otherwise I'm all for having more descriptive names:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
