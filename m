Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39C5C433F5
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 11:41:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C08203CA54E
	for <ltp@archiver.kernel.org>; Tue, 12 Apr 2022 13:41:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DFD803C5785
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 13:40:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3E8AF6002A0
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 13:40:56 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 87DBA210E3
 for <ltp@lists.linux.it>; Tue, 12 Apr 2022 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649763656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZfoPbyBTT+lJMtW7TJlyzFaAKnvt5BMbS4h6aX7+9eQ=;
 b=KLrtUwiiD0SPfCGa7Qg4UTxM8HL+vXQefCuwNSdahAiPjJS6Lv8ZWk6Nyx6mfB30vOXV9m
 1s11xlgMj8xSk2vcBSpoCEMCWsKePZC4TwPLUnOWBRgNJb6HrQJwiW0Gq/ID5OkcCVfqLM
 MGhBn7dGmGRa2QUzGmU0P8VV/MTr0Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649763656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZfoPbyBTT+lJMtW7TJlyzFaAKnvt5BMbS4h6aX7+9eQ=;
 b=/Ryu9sJ3065cLJzuSvGLAZ10QM9bC75XI90Y5LcPAlAD7pxNTJcPZMnH3yRd1GvUB4aNJl
 VcqJWKKTsrs+OxDQ==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4ABBBA3B88;
 Tue, 12 Apr 2022 11:40:56 +0000 (UTC)
References: <20220329074440.26214-1-rpalethorpe@suse.com>
 <20220329074440.26214-3-rpalethorpe@suse.com> <Yka3Iu1NLRzLnIlk@pevik>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 12 Apr 2022 12:28:16 +0100
In-reply-to: <Yka3Iu1NLRzLnIlk@pevik>
Message-ID: <87lewazfzs.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] cgroups: Add first IO controller test
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

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> +++ b/testcases/kernel/controllers/io/io_control01.c
>> @@ -0,0 +1,155 @@
>> +// SPDX-License-Identifier: GPL-2.0
> nit: not sure if it was deliberate not adding it, but you may want to
> add your/SUSE copyright.
>
>> +/*\
>> + *
>> + * [Description]
>> + *
>> + * Perform some I/O on a file and check if at least some of it is
>> + * recorded by the I/O controller.
>> + *
>> + * The exact amount of I/O performed is dependent on the file system,
>> + * page cache, scheduler and block driver. We call sync and drop the
>> + * file's page cache to force reading and writing. We also write
>> + * random data to try to prevent compression.
>> + *
>> + * The pagecache is a particular issue for reading. If the call to
>> + * fadvise is ignored then the data may only be read from the
>> + * cache. So that no I/O requests are made.
>> + */
>> +
> ...
>> +static int read_io_stats(const char *const line, struct io_stats *const stat)
>> +{
>> +	return sscanf(line,
>> +		      "%u:%u rbytes=%lu wbytes=%lu rios=%lu wios=%lu dbytes=%lu dios=%lu",
>> +		      &stat->mjr, &stat->mnr,
>> +		      &stat->rbytes, &stat->wbytes, &stat->rios, &stat->wios,
>> +		      &stat->dbytes, &stat->dios);
>> +}
> checkpatch.pl false positive:
> io_control01.c:40: WARNING: unchecked sscanf return value
> Obviously perl parsing has some limitations as we check read_io_stats() return
> value.

I'm not sure what to do about this other than switch to a macro which is
a bit silly.

IMO sscanf should have the warn_unused_result attribute and this should
be inherited by read_io_stats. All of which is better handled by the
compiler.

>
> ...
>> +static void setup(void)
>> +{
>> +	char buf[PATH_MAX] = { 0 };
>> +	char *path = SAFE_GETCWD(buf, PATH_MAX - sizeof("mnt") - 1);
>> +	struct stat st;
>> +
>> +	strcpy(path + strlen(path), "/mnt");
>> +
>> +	tst_stat_mount_dev(path, &st);
>> +	dev_major = major(st.st_rdev);
>> +	dev_minor = minor(st.st_rdev);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.needs_device = 1,
> nit: testcases/kernel/controllers/io/io_control01.c: useless tag: needs_device

Pushed with fixes (including needs_device).
-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
