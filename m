Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EA5C0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 14:01:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75FC33CEC4D
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 16:01:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 705F53CEC34
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 16:01:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8F994600D24
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 16:01:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B0361FF65;
 Wed, 25 Oct 2023 14:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698242475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IsbZ7HinrsF77G3lKEHV68M7W50UNBYaGBdFSqaDva4=;
 b=V9eopkCAs02WPAC1RdHFzhPiiYCIoGfY1FjYvfP+tk90O8+7GW02FvC8uKbHroHCr1yGsg
 MxfzEENTN9ZGyHFDbKIRrRUpKyhMY+Lp5P7pGCohhYrEgk4/ZwP0IlHQiZDPC6H53w8MYp
 lHx8FjLN9+kcMNABKHYMW+Dk5DHNheA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698242475;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=IsbZ7HinrsF77G3lKEHV68M7W50UNBYaGBdFSqaDva4=;
 b=ULXBQWrSo2ISWlatATIuDZY+8S/SxUd/L7LkO4V5Ko/A3wCEaq/k+rHwX7xdL1BmEfwmTH
 2u3tJ/HDseJcZACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C24713524;
 Wed, 25 Oct 2023 14:01:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pUBiFqofOWWAEAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 14:01:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 25 Oct 2023 16:01:07 +0200
Message-ID: <20231025140109.340441-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.02 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[15];
 MID_CONTAINS_FROM(1.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.92)[99.65%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Remove CentOS 7 support
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
Cc: Ulrich Hecht <uli@kernel.org>, Richard Palethorpe <rpalethorpe@suse.com>,
 Martin Doucha <martin.doucha@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

we recently had yet another regression on old CentOS 7 (kernel 3.10,
glibc 2.17, gcc 4.8.5 [1]. That brought me to the question if we still
want to support it.

Although we test in SUSE also very old SLES releases, these are tested
with older LTP releases. I suppose Red Hat does the same with RHEL
(Li, Jan, please correct me if not, or feel free to introduce another
CentOS version, as there will none with this patchset), thus why
pretend current LTP is useful on these old releases.

I wonder who is actually interested in keeping LTP compilable for CentOS 7.
According to distrowatch it EOL in 2024-06 [2], but does anybody even run new
LTP on it. If yes, please speak up, but I'd expect that person to
actually maintain CI failures.

The oldest SLES release SUSE actually tests with the latest LTP release is
SLE12-SP2 (kernel 4.4, glibc 2.22 and gcc 4.8.5). The latest kernel LTSS is
4.14. Thus removing CentOS 7 from the CI and re-adding Ubuntu 16.04 LTS
xenial (kernel 4.4, glibc 2.23, gcc 5.3.1) would more or less fit SUSE
needs. It actually EOL, but docker is still supported [3].

The benefit would be to have 3 years younger base kernel and glibc (thus
less lapi fallbacks needed). If this is accepted, I'll have look on
older code and send following patches which removes it.

We currently use -std=gnu99 since dc7be30e2 ("config: Explicitly set gnu99"),
which documents that can't use C99 because LTP is far from compliant.
Therefore I'd keep it the same until we rewrite (or delete) the old code.
(xenial gcc 5.3.1 has the default dialect -std=gnu11 [4], SLE12-SP2 gcc 4.8.5 is
-std=gnu90 [5], C99 is already supported in gcc 4.5, with -fextended-identifiers
[6]).

Kind regards,
Petr

Petr Vorel (2):
  CI: ReAplace CentOS 7 with openSUSE Leap 42.2, Ubuntu xenial
  doc/support: Update the latest tested distros

 .github/workflows/ci.yml                        | 17 +++++++++++------
 ...ed-kernel,-libc,-toolchain-versions.asciidoc |  2 +-
 2 files changed, 12 insertions(+), 7 deletions(-)

-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
