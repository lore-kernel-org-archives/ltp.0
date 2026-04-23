Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C22F589AE
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 12:31:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 783433E537D
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 14:31:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37FB23E1CCD
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 14:31:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8F1BE1000402
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 14:31:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0CDAD5BCCD;
 Thu, 23 Apr 2026 12:31:20 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFCF5593A3;
 Thu, 23 Apr 2026 12:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id smKlNRcR6mkxbgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Apr 2026 12:31:19 +0000
Date: Thu, 23 Apr 2026 14:31:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Sachin Sant <sachinp@linux.ibm.com>
Message-ID: <20260423123110.GA447647@pevik>
References: <20260423112439.69230-1-sachinp@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260423112439.69230-1-sachinp@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 0CDAD5BCCD
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] doc: generate CVE reproducer statistics
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

Hi Sachin,

[ Cc Andrea ]

> Add a Sphinx builder hook to parse runtest/cve, collect CVE
> reproducer metadata, and generate a documentation page with
> per-year counts and links to CVE entries and test sources.

> Also include the generated CVE reproducer statistics page from
> doc/users/stats.rst.

Thanks for implementing this.

I'd prefer this to be on a separate page named "CVE Reproducers"
(OT: I'd also prefer to rename "Statistics" to "Supported syscalls", but that's
separate thing.)


More notes:

* I suppose it shouldn't be too hard to do it similarly as what we do in the test
  catalog [1], have each CVE id + optional binary name in parenthesis in the menu
  on the left:

	CVE-2025-38236
	...
	CVE-2016-5195 (dirtyc0w)
	...

  Or, we could have tables by years (i.e. left menu only years with counted
  number of tests in parenthesis)

	2025 (2)
	2023 (3)

  I don't have a strong preference, which one is better.

* Sort by CVE ID descending (newest CVE on the top, people are mostly
  interested at current problems than about history).
* Maybe link to the file should be linked to the test catalog page (which has
  also link to the test source?), e.g. [2] (link could be relative).
* The description is mostly useless (often just CVE ID or "CVE reproducer
  test"), link to the test catalog would help.
* Year is useless (visible from CVE ID)
* Some of the tests don't have link now, e.g. dirtyc0w, snd_timer01.

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html
[2] https://linux-test-project.readthedocs.io/en/latest/users/test_catalog.html#cve-2016-7042

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
