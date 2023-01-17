Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6222CC3DA78
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 10:05:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 050EF3CC8D0
	for <ltp@archiver.kernel.org>; Tue, 17 Jan 2023 11:05:36 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3A423CB49B
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 11:05:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 13DFF60004B
 for <ltp@lists.linux.it>; Tue, 17 Jan 2023 11:05:25 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C80F71F460;
 Tue, 17 Jan 2023 10:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673949924;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hxYrIEFjmW/K7YkIHaQbOzDdKmCpj+99DdM7171IMng=;
 b=DxFdi7s+RAj+qGbM/t2TBbzXaPQx804b+8OKAx0MtTwJZ5N30BF40sb8OciUAkUcvZIce2
 5AQOC0NmbLB9lF5iVJujz7wRcL6huH0QieiwjvTPuSGT7dDixvxEDaFZnDIuLeLgtYbwrq
 qjHGF4pBE155SyCsNFysN+oPPkLsOY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673949924;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hxYrIEFjmW/K7YkIHaQbOzDdKmCpj+99DdM7171IMng=;
 b=IIitzpyIymulmDrRJdYeCQIOQYVZBIhIYZe9AZXPoKnLy2Y3C3QmlucwI88aeDPslhKnmT
 +R0kDW0rzu2bEmBw==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8130C2C141;
 Tue, 17 Jan 2023 10:05:24 +0000 (UTC)
References: <20230116074101.1264-1-wegao@suse.com> <87fscawlku.fsf@suse.de>
 <20230117021631.GA20825@aa>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>, Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Jan 2023 09:23:55 +0000
Organization: Linux Private Site
In-reply-to: <20230117021631.GA20825@aa>
Message-ID: <877cxlwk66.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] readahead02.c: Use fsync instead of sync
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

Wei Gao <wegao@suse.com> writes:

> On Mon, Jan 16, 2023 at 03:08:44PM +0000, Richard Palethorpe wrote:
>> Hello,
>> 
>> Wei Gao via ltp <ltp@lists.linux.it> writes:
>> 
>> > Use fsync on test file instead of sync should faster than syncing
>> > whole system.
>> 
>> The test completes in less than a second in OpenQA. We don't want to
>> risk introducing a regression or spend time reviewing changes unless the
>> performance improvement solves a timeout.
>> 
>> I suggest you convert dup06 to the new API (for example) or investigate
>> a test failure.
>> 
> The motivation of this change is base on the https://github.com/linux-test-project/ltp/issues/972
> which give following suggestion:
> "As we run the test inside a loop device I guess that we can also 
> sync and drop caches just for the device, which should be faster 
> than syncing and dropping the whole system. Possibly we just need 
> to umount it and mount it again."

I see. Well unless Cyril can show that the test is actually failing
somewhere (or there is a strong logical argument this will cause a
failure). Then this task is still valid, but low priority IMO.

>
> But currently i can not find any API to sync and drop caches just 
> ONLY for device, so base my view just replace sync whole 
> system to single file also can make a small help.

If we don't have one or more concrete failures to focus on then we
really have to research whether fsync (or syncfs FYI) or unmounting the
device are the correct thing to do. They will all have subtly different
effects.

>
>> >
>> > Signed-off-by: Wei Gao <wegao@suse.com>
>> > ---
>> >  .../kernel/syscalls/readahead/readahead02.c     | 17 +++++++++++++----
>> >  1 file changed, 13 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
>> > index 7acf4bb18..e04046bc3 100644
>> > --- a/testcases/kernel/syscalls/readahead/readahead02.c
>> > +++ b/testcases/kernel/syscalls/readahead/readahead02.c
>> > @@ -99,6 +99,17 @@ static void drop_caches(void)
>> >  	SAFE_FILE_PRINTF(DROP_CACHES_FNAME, "1");
>> >  }
>> >  
>> > +static void sync_drop_caches(void)
>> > +{
>> > +	int fd;
>> > +
>> > +	fd  = SAFE_OPEN(testfile, O_RDONLY);
>> > +	if (fsync(fd) == -1)
>> > +		tst_brk(TBROK | TERRNO, "fsync()");
>> > +	SAFE_CLOSE(fd);
>> > +	drop_caches();
>> > +}
>> > +
>> >  static unsigned long get_bytes_read(void)
>> >  {
>> >  	unsigned long ret;
>> > @@ -233,8 +244,7 @@ static void test_readahead(unsigned int n)
>> >  	read_testfile(tc, 0, testfile, testfile_size, &read_bytes, &usec,
>> >  		      &cached);
>> >  	cached_high = get_cached_size();
>> > -	sync();
>> > -	drop_caches();
>> > +	sync_drop_caches();
>> >  	cached_low = get_cached_size();
>> >  	cached_max = MAX(cached_max, cached_high - cached_low);
>> >  
>> > @@ -246,8 +256,7 @@ static void test_readahead(unsigned int n)
>> >  	else
>> >  		cached = 0;
>> >  
>> > -	sync();
>> > -	drop_caches();
>> > +	sync_drop_caches();
>> >  	cached_low = get_cached_size();
>> >  	tst_res(TINFO, "read_testfile(1)");
>> >  	ret = read_testfile(tc, 1, testfile, testfile_size, &read_bytes_ra,
>> > -- 
>> > 2.35.3
>> 
>> 
>> -- 
>> Thank you,
>> Richard.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
