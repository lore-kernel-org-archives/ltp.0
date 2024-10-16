Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65B3D2F7C2
	for <ltp@archiver.kernel.org>; Wed, 16 Oct 2024 21:15:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9599B3C2079
	for <ltp@archiver.kernel.org>; Wed, 16 Oct 2024 23:15:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 876053C12E8
 for <ltp@lists.linux.it>; Wed, 16 Oct 2024 23:15:17 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0725C235C7C
 for <ltp@lists.linux.it>; Wed, 16 Oct 2024 23:15:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A2DD821EFC;
 Wed, 16 Oct 2024 21:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729113314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZvZfn92Gn9lEJIlQxnMss2I+uj9oPfwi9BzOpNQx5R8=;
 b=h6Hg0vXMLjqsVLdC5f2iT/Vdfm9ipcIf3qcgiaq39/uiKNp0dAa43VdzxTcDRlD0FZqUUA
 pSdA+x7Q0urQsQgQ4Q2wNIptGR+xpg6NoHzL9KvMxZHbPuAFHQEmswgJcoQINl2C04KuzR
 X5J8yJVNZBh6YNRiNlja+blWaephqBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729113314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZvZfn92Gn9lEJIlQxnMss2I+uj9oPfwi9BzOpNQx5R8=;
 b=iQxPiGNDzq+9bzGLEeDqN2w1xfdgfIgK8zk/MMHAszkEadfn/DQApq+wLWT2NdawgkETy1
 sGgBFX2pHkavZwAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h6Hg0vXM;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iQxPiGND
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729113314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZvZfn92Gn9lEJIlQxnMss2I+uj9oPfwi9BzOpNQx5R8=;
 b=h6Hg0vXMLjqsVLdC5f2iT/Vdfm9ipcIf3qcgiaq39/uiKNp0dAa43VdzxTcDRlD0FZqUUA
 pSdA+x7Q0urQsQgQ4Q2wNIptGR+xpg6NoHzL9KvMxZHbPuAFHQEmswgJcoQINl2C04KuzR
 X5J8yJVNZBh6YNRiNlja+blWaephqBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729113314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZvZfn92Gn9lEJIlQxnMss2I+uj9oPfwi9BzOpNQx5R8=;
 b=iQxPiGNDzq+9bzGLEeDqN2w1xfdgfIgK8zk/MMHAszkEadfn/DQApq+wLWT2NdawgkETy1
 sGgBFX2pHkavZwAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 859111376C;
 Wed, 16 Oct 2024 21:15:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PFCbH+IsEGf2DgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Oct 2024 21:15:14 +0000
Date: Wed, 16 Oct 2024 23:15:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20241016211513.GA104519@pevik>
References: <20240918100344.21316-1-wegao@suse.com>
 <20240925035756.14873-1-wegao@suse.com>
 <20241015193958.GC46536@pevik> <Zw-15cE2R0_5FOmJ@yuki.lan>
 <66c4cb2a-14de-4967-9c86-843759087dc5@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <66c4cb2a-14de-4967-9c86-843759087dc5@suse.cz>
X-Rspamd-Queue-Id: A2DD821EFC
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ftp01.sh: Add support for test lftp
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

> On 16. 10. 24 14:47, Cyril Hrubis wrote:
> > Hi!
> > > To be honest, I would rather to remove this FTP test because FTP protocol is
> > > legacy. I know it is supposed to be a smoke test, but maybe using modern tools
> > > would be better than keeping test working among various old FTP implementations.
> > > (Also nontrivial setup is required just for few FTP tests:
> > > https://github.com/linux-test-project/ltp/tree/master/testcases/network )
> > > But probably Cyril would be against. @Cyril @Martin WDYT?

> > So where is the ftp server setup code? Or do we expect ftp server to be
> > installed and configured prior to the test execution?

> > The actuall test does not look that complex to me.

> Hi,
> I've replied to patchset v1[1] that the server setup is better left to the
> user, like we do with NFS. In our case, it should be done in OpenQA during
> VM environment setup.

NFS case is kind of different from FTP. 1) There is the only nfsd implementation,
in kernel. But there are more FTP servers (userspace).

Also it's not just about starting the service (I agree with leaving services
enabled in tooling outside LTP, e.g. *not* using testcases/lib/daemonlib.sh),
but there is also service configuration which is required to be done in the test
(part of the testing). NFS tests just run exportfs. All FTP scripts but ftp01.sh
use vsftpd configuration. ftp01.sh could reuse this code (if it's working).

Besides this FTP server it also involves some additional setup [2] (adjust
/etc/ftpusers or /etc/vsftpd.ftpusers), but sure, this could be left for the
test runner.

> I agree that the test could be replaced by a socket test, either using
> improved netstress tool or some new syscall tests for send()/recv()/...

I was also thinking about using netstress.c (which is already used for
network many tests) for FTP download and upload tests.

There are also other tests in runtest/net_stress.appl:

* dns-stress.sh bind9 resolving test - IMHO not relevant for LTP (bind has nice
  CI testing done by ISC).
* ssh-stress.sh sshd stress test - IMHO not relevant for LTP even as a smoke
  test. Also touching ssh configuration can break some LTP users as LTP is often
  used as a connection to SUT.
* http-stress.sh http downloading stress test - IMHO redundant to FTP download
  (if we replace FTP tests with netstress / other C code, we can delete this as well).

Back to ftp01.sh (file modified in this patch). It tests downloading and
uploading with FTP protocol. It looks to me more as FTP client/server test than
anything else (it's not a stress test). IMHO not relevant for LTP.

Kind regards,
Petr

> [1] https://patchwork.ozlabs.org/project/ltp/patch/20240918100344.21316-1-wegao@suse.com/#3381493

[2] https://github.com/linux-test-project/ltp/tree/master/testcases/network#ftp-and-telnet-setup

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
