Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4FDC433FE
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 11:57:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8DDC93CD9BD
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 12:57:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2678D3C2A67
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 12:57:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 191D0600811
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 12:57:39 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0747C1F891;
 Mon,  7 Nov 2022 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667822259;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZ+HZPZ/4Pn+5MwGbBPFVBN4383woH/klGCMchTxb7A=;
 b=uNf4FW+vUwCOcvA+STgQNMpPOaFOtmB8h879zagfObswjRDZSB6CuWdVMv7murcq5JMn7t
 Yrudk60QTOvcEoG4FhJIb0C4iiOa+8wXFofmHwgqsn+P8hXyyIuLTn/u95ToPY38nlQVFB
 acXrFYH2u9SdPOcCyfDV3BoTbOBSDQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667822259;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZ+HZPZ/4Pn+5MwGbBPFVBN4383woH/klGCMchTxb7A=;
 b=teuf9Ymnhunxcwkb200y9rJHhQvx94Yf7EYKbpy584fnRFgwPt97i34vdsvQv4KRyM3Izp
 EYh1fQT9eNQtJwAA==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 9BA1A2C141;
 Mon,  7 Nov 2022 11:57:38 +0000 (UTC)
References: <20221021115333.13725-1-pvorel@suse.cz>
 <20221021115333.13725-2-pvorel@suse.cz>
 <82b10e4d-292f-51c2-da70-0c2ad7722a8f@daynix.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 07 Nov 2022 11:41:15 +0000
Organization: Linux Private Site
In-reply-to: <82b10e4d-292f-51c2-da70-0c2ad7722a8f@daynix.com>
Message-ID: <874jvbx9hq.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] Makefile: set LC_ALL and LANG to C
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2022/10/21 20:53, Petr Vorel wrote:
>> * have reproducible builds (no locale dependencies)
>> * English only output - easier to debug problem
>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> ---
>> NOTE: if we want to have only reproducible build, but keep localized
>> messages, we could use kernel approach:
>> unexport LC_ALL
>> LC_COLLATE=C
>> LC_NUMERIC=C
>> export LC_COLLATE LC_NUMERIC
>> They deliberately kept LC_CTYPE to have localized messages.
>> See also
>> c051346b7db2 ("Makefile: set LC_CTYPE, LC_COLLATE, LC_NUMERIC to C")
>> 07105202bdeb ("Makefile: do not override LC_CTYPE")

I would prefer to copy the kernel. If someone sends us compilation
messages in a language we don't understand then we can ask them to set
the locale before compiling.

I think ensuring our build scripts produce the same executable output on
different locales is nice though.

>>   Makefile | 4 ++++
>>   1 file changed, 4 insertions(+)
>> diff --git a/Makefile b/Makefile
>> index d4399bae6..ea11ac7f3 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -21,6 +21,10 @@
>>   # Ngie Cooper, July 2009
>>   #
>>   +# Avoid funny character set dependencies
>> +export LANG=C
>
> Hi,
>
> Setting LANG should not be necessary as long as LC_ALL is set. That is
> what my patch "tst_test.sh: Normalize the locale" does.

Yes, I don't understand what LANG is doing here. AFAICT it is just sets
a default for undefined settings and will be overrided by LC_ALL.

>
> Regards,
> Akihiko Odaki
>
>> +export LC_ALL=C
>> +
>>   top_srcdir		?= $(CURDIR)
>>     include $(top_srcdir)/include/mk/env_pre.mk

Setting to changes-requested in patchwork because of LANG and LC_ALL is
overkill IMO.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
