Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB726C00140
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 02:58:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7343F3C9456
	for <ltp@archiver.kernel.org>; Tue,  9 Aug 2022 04:57:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 685193C1B37
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 04:57:47 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B7CB720091A
 for <ltp@lists.linux.it>; Tue,  9 Aug 2022 04:57:44 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 2792vbro032940;
 Tue, 9 Aug 2022 10:57:37 +0800 (+08)
 (envelope-from dylan@andestech.com)
Received: from atcsi01 (10.0.15.167) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Tue, 9 Aug 2022 10:57:34 +0800
Date: Tue, 9 Aug 2022 10:57:34 +0800
From: Dylan Jhong <dylan@andestech.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YvHNHt87WPxg7faE@atcsi01>
References: <20220808110416.2244071-1-dylan@andestech.com>
 <YvEHNbOm0dSSmjoI@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YvEHNbOm0dSSmjoI@pevik>
User-Agent: Mutt/2.2.1 (2022-02-19)
X-Originating-IP: [10.0.15.167]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 2792vbro032940
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fs_bind: Fix incorrect mount option
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
Cc: "x5710999x@gmail.com" <x5710999x@gmail.com>, "Alan Quey-Liang
 Kao\(\(\(\(\(\(\(\(\(\(\)" <alankao@andestech.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr:

Thanks for the review.

>>>>> I wonder why test didn't failed (at least on SUT I tested it).
Some mount command implementations[*1] use getopt_long() to parse mount 
options, but getopt_long() seems to treat "--make-share" and "--make-shared"
as the same option.

The error I encounter this time is using busybox's mount command[*2], which 
uses strncasecmp() to parse the argements, It will treat "--make-share" and 
"--make-shared" as different options.

According to the manual of mount command, "--make-shared" should be the correct
option.

reference:
    [*1] https://kernel.googlesource.com/pub/scm/utils/util-linux/util-linux/+/stable/v2.13/mount/mount.c#1816
    [*2] https://github.com/brgl/busybox/blob/master/util-linux/mount.c#L372
    [*3] https://linux.die.net/man/8/mount

Best,
Dylan

On Mon, Aug 08, 2022 at 08:53:09PM +0800, Petr Vorel wrote:
> Hi Dylan,
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> I wonder why test didn't failed (at least on SUT I tested it).
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
