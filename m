Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0655C25B67
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 08:30:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0E2A3CEB8B
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 10:30:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F6163CCA98
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 10:30:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D1E16141CE8C
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 10:30:19 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D04E61FEDC
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 08:30:17 +0000 (UTC)
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6AAD22CFFD;
 Fri, 27 Oct 2023 08:30:17 +0000 (UTC)
References: <20231026094957.15371-1-rpalethorpe@suse.com>
 <20231026110659.GA593730@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 27 Oct 2023 09:21:11 +0100
Organization: Linux Private Site
In-reply-to: <20231026110659.GA593730@pevik>
Message-ID: <87cyx0tqli.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [0.79 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(0.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-0.00)[11.09%]
X-Rspamd-Queue-Id: D04E61FEDC
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cgroup: Handle trailing new line in
 cgroup.controllers
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
>> V2:
>> * Add underscore
>> * Add length check
>> * Expand commit message
>> * Use shorter syntax
> +1
>
>>  lib/tst_cgroup.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>
>> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
>> index 5240aadaa..c5cb20505 100644
>> --- a/lib/tst_cgroup.c
>> +++ b/lib/tst_cgroup.c
>> @@ -433,9 +433,20 @@ __attribute__ ((nonnull, warn_unused_result))
>>  static struct cgroup_ctrl *cgroup_find_ctrl(const char *const ctrl_name)
>>  {
>>  	struct cgroup_ctrl *ctrl;
>> +	int l = 0;
>> +	char c = ctrl_name[l];
>> +
>> +	while (c == '_' || (c >= 'a' && c <= 'z'))
>> +		c = ctrl_name[++l];
>> +
>> +	if (l > 32)
> +1 for this check.
> I would slightly prefer to add MAX_CGROUP_TYPE_NAMELEN definition into our
> include/tst_cgroup.h, but it can stay as is.
>
> BTW include/linux/cgroup-defs.h contains also MAX_CGROUP_ROOT_NAMELEN, there are
> also other checks in C files (CGROUP_FILE_NAME_MAX) in case it makes sense to
> have some checks for these (I have no idea).

I'm not sure about this. On the one hand it may detect a bug in the
library or kernel. On the other it's not exposed to userland or defined
anywhere.

For me the main thing is to avoid janitorial work like creating and
merging patches just to increase some internal kernel value that was
increased or is ignored in some corner case.

I'll post another patch if there is some obvious way to check the root
name length that would help the library.

Thanks for the review, I'll merge this now.

>
> Kind regards,
> Petr
>
>> +		tst_res(TWARN, "Subsys name len greater than max known value of MAX_CGROUP_TYPE_NAMELEN: %d > 32", l);
>
>> +
>> +	if (!(c == '\n' || c == '\0'))
>> +		tst_brk(TBROK, "Unexpected char in %s: %c", ctrl_name, c);
>
>>  	for_each_ctrl(ctrl) {
>> -		if (!strcmp(ctrl_name, ctrl->ctrl_name))
>> +		if (!strncmp(ctrl_name, ctrl->ctrl_name, l))
>>  			return ctrl;
>>  	}


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
