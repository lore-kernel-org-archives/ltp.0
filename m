Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A538BCDB465
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 10:02:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A8C2B3CD40E
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 12:02:12 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFB003C84F2
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 12:02:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F26C214098BF
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 12:01:59 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6BCFB216DA
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 10:01:58 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1B7E12C4E7
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 10:01:58 +0000 (UTC)
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: LTP List <ltp@lists.linux.it>
Date: Thu, 19 Oct 2023 10:31:10 +0100
Organization: Linux Private Site
Message-ID: <875y33vsks.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [0.73 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; REPLYTO_ADDR_EQ_FROM(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 R_SPF_SOFTFAIL(0.60)[~all:c]; RCPT_COUNT_ONE(0.00)[1];
 HAS_ORG_HEADER(0.00)[]; DMARC_NA(0.20)[suse.de];
 TO_DN_ALL(0.00)[]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; VIOLATED_DIRECT_SPF(3.50)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(0.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-0.06)[61.20%]
X-Rspamd-Queue-Id: 6BCFB216DA
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] LTP open monthly meeting
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
Reply-To: rpalethorpe@suse.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

I propose a meeting once a month to discuss non-technical things such as
patch review policy, overall direction and bike shed discussions. Anyone
is welcome who is interested in that.

Originally I thought just to include myself and some SUSE colleagues in
an ad-hoc meeting to deal with Reviewed-by tag delegation. However I
think the real problem is we have no LTP meeting in which to discuss
these things and chat. The ML is not adequate for this IMO.

For me any time and day would be fine excluding 22:00 to 09:00
UTC/GMT. Probably Monday to Friday would be best for most.

The agenda for the first meeting would be to discuss how to deal with
the situation where someone reviews the V1 of a patch, but does not add
their Reviewed-by tag in subsequent versions.

After that just introductions, questions and anything someone would like
to bring up.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
