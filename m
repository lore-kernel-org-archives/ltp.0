Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D2DC54731
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 21:09:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D18CE3D2756
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 23:09:43 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 819283C655D
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 23:09:28 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=neilb@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8D74814013A3
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 23:09:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C2841FB91;
 Tue, 27 Aug 2024 21:09:26 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A126313724;
 Tue, 27 Aug 2024 21:09:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BladFYNAzmZKDgAAD6G6ig
 (envelope-from <neilb@suse.de>); Tue, 27 Aug 2024 21:09:23 +0000
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Martin Doucha" <mdoucha@suse.cz>
In-reply-to: <9afef16d-52b2-435d-902a-7ccfa5824968@suse.cz>
References: <>, <9afef16d-52b2-435d-902a-7ccfa5824968@suse.cz>
Date: Wed, 28 Aug 2024 07:09:14 +1000
Message-id: <172479295459.11014.9802161915427616319@noble.neil.brown.name>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 0C2841FB91
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] nfsstat01: Update client RPC calls for
 kernel 6.9
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
Cc: linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
 stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 27 Aug 2024, Martin Doucha wrote:
> On 23. 08. 24 23:59, NeilBrown wrote:
> > On Fri, 23 Aug 2024, Petr Vorel wrote:
> >> We discussed in v1 how to fix tests.  Neil suggested to fix the test the way so
> >> that it works on all kernels. As I note [1]
> >>
> >> 1) either we give up on checking the new functionality still works (if we
> >> fallback to old behavior)
> > 
> > I don't understand.  What exactly do you mean by "the new
> > functionality".
> > As I understand it there is no new functionality.  All there was was and
> > information leak between network namespaces, and we stopped the leak.
> > Do you consider that to be new functionality?
> 
> The new functionality is that the patches add a new file to network 
> namespaces: /proc/net/rpc/nfs. This file did not exist outside the root 
> network namespace at least on some of the kernels where we still need to 
> run this test. So the question is: How aggressively do we want to 
> enforce backporting of these NFS patches into distros with older kernels?

Thanks for explaining that.  I had assumed that the the file was always
visible from all name spaces, but before the fix every namespace saw the
same file.  Clearly I was wrong.

> 
> We have 3 options how to fix the test depending on the answer:
> 1) Don't enforce at all. We'll check whether /proc/net/rpc/nfs exists in 
> the client namespace and read it only if it does. Otherwise we'll fall 
> back on the global file.
> 2) Enforce aggressively. We'll hardcode a minimal kernel version into 
> the test (e.g. v5.4) and if the procfile doesn't exist on any newer 
> kernel, it's a bug.
> 3) Enforce on new kernels only. We'll set a hard requirement for kernel 
> v6.9+ as in option 2) and check for existence of the procfile on any 
> older kernels as in option 1).

I think there are two totally separate questions here.
1/ How to fix the existing test to work on new and old kernels.  The
  existing test checked that the rpc count increased when NFS traffic
  happened.  I think 1 is the correct fix.  I don't think the test
  should check kernel version.

2/ We have discovered a bug and want to add a test to guard against
  regression.  This should be a new test.  That test can simply check if
  the given file exist in a non-init namespace.  I have no particular
  opinion about testing kernel versions.  A credible approach would be
  to choose the oldest kernel which it still maintained at the time that
  that bug was discovered.  Or maybe create a list of kernel versions
  where were maintained at that time and only run the test on versions
  in that list, or after the last in the list.

I really think there is value in having two different tests because we
are testing two different things.

Thanks,
NeilBrown


> 
> -- 
> Martin Doucha   mdoucha@suse.cz
> SW Quality Engineer
> SUSE LINUX, s.r.o.
> CORSO IIa
> Krizikova 148/34
> 186 00 Prague 8
> Czech Republic
> 
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
