Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D812DD13C2D
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 15:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769440061; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=LJaHrjiuvmsh2crn2Lu5nYWYy4GgrT4w+EdDJRlWlqc=;
 b=kkO6Jz+ML1xx9P1XPEWzN20q41zOkS8Xp7di5AmgjSvpOhWbINC+f2va5Rk2BIhaAT/+W
 7+Rqip7bmL3g4bKRgpWdsT52LgV5sE9JNij5TzbO1dMfbXLJYpsTyMLes6BWD/Kia74ovl+
 8lLVrkqae8dhbMe/jPkshdnspZoeajQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 310443C630C
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 16:07:41 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 083F53C0571
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 16:07:17 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 172EA1A00244
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 16:07:17 +0100 (CET)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6581af9c94aso8970966a12.1
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 07:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769440036; x=1770044836; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UnWe0YvZhcp9qmaffGd2jSvxd924z3z0uG8XqQ5qpwo=;
 b=Bz3ba/N2gpU6ZsBSxl/8P5CZbQb6L121QeBW0WI0wIrS9Q2ZrjV1+L8fNdxfL6RZDq
 j3c6t9M5giemqtEEo1g5exYm7P23g6MeuL/GYdoF2ZwRw5NoQI8SzNPUMcc/vK8eYBoe
 P5k49lUsv0vqQ0Oanc5cxVm7FOuoNs8qYURbiV6quH2qnjBlF4o8m3ZQQ7fM7VE5iqzJ
 QlJCYqAfJX2lZulLV7FagCpEsO6hWnzZFbV1clB/Kdkwz0DFlFy/9K4J34mvPRniLarH
 uGV6pnASm1ZRiBpFi7snICBcwssvjNlfn+U+Gy/qz8dS617PFnt7Bi24+/iOI2YuoUa+
 55+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769440036; x=1770044836;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UnWe0YvZhcp9qmaffGd2jSvxd924z3z0uG8XqQ5qpwo=;
 b=K9UJcaUvjqEMLr1X1ayXy9tB6KzRoQlw4o+24Wgmhgu0/c268pSXe+AxgKEVAT8YJE
 5I3OI+9e+Gmog4IccFRbuJNNQ3CGzmzJAsGpzI1leUIlqyEwmevOXw95o5vcE1ittI+j
 S88OC0L5e0vxrdkaUarpoDGHQkI7xCJfcdxHleDQ61X9LK24/IHojy3/uMiCJ6jeFTOr
 iu0393r/SmPpmVf8U707rF0EBpgVBjmPAOY/VWrcoTl4LvXMMCuQpuAUC+zhklwBm+Yh
 /4T1IKoxe6+0kSgm3z6iR9khRZ9hP2msUgnHgYMVEJr80GpRXco7IKCXYQhCNdMD4u1x
 kuQQ==
X-Gm-Message-State: AOJu0Yzr2HJOBXmKOP0SV9GrGL+PdRGiStK/kOEze61b7qLKkC9E9MfH
 YGIELT4ncMmVLvLuTJXhwFOSSwrWSkLBNST4pUT9WNBB0rKCF5QDxrIwjqLP7gmF7ZQ=
X-Gm-Gg: AZuq6aJEnbQuuAvr7LeREHvXjOZMKi9+pXSNy4xa6JlSnTqex80eCw0noOMgDqYox4x
 0d2Fxlaekb7iwxiLuYJEtBMe8kNumfs+Of3IJpU9gYh8LM20S0URA4ceGC9GoPbyhoFcjCO/A0h
 zuXWwPmHpjJToyV4Mh5sT8xJ5tsdxdGfBjCHh5MHCYuQ71OV6JMd2k5xTNBNdxRQLc+PF/c5pSl
 Yc8B6sGrUY7chTcaJ2o1uvlVBlrEv4PHhQStTcewb4LHlJ4ZAJxz8MmZkrMgytqOPrAX4NH9vdD
 E68zjkTAd++fKrhCTYwxGfEoKtDbyR1+0TlrZSX1xifpenLb5NdCBRDIFej96TT7UYDU3B22eJ/
 OxROHe7MYX83W0tz5K9M19bp4p7nyNDJE2okCT7mwggYroLDPZb7iyO+qweBEB8X7kKqAjsEStw
 eMr5aXFfWRjAKXUqZ9wyT0C32YTk2c2CIx34Pb9R9ZDBLRfwUnJEPm4J525OcN4+6CjmIvLcLJX
 RQt99A=
X-Received: by 2002:a17:907:96a9:b0:b88:60d2:11b8 with SMTP id
 a640c23a62f3a-b8d0a83048dmr350573666b.4.1769440036175; 
 Mon, 26 Jan 2026 07:07:16 -0800 (PST)
Received: from localhost
 (p200300ef2f1649001c626999955e52c8.dip0.t-ipconnect.de.
 [2003:ef:2f16:4900:1c62:6999:955e:52c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b885b75d669sm644263966b.51.2026.01.26.07.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jan 2026 07:07:15 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 26 Jan 2026 16:07:15 +0100
Message-Id: <DFYM56BKO470.2QDB95UE8IOVU@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.18.2
References: <20260126-fix_dio_sparse_slow-v2-1-5dbe1622f5c1@suse.com>
 <aXdTEreda0-s6WID@yuki.lan>
In-Reply-To: <aXdTEreda0-s6WID@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] io: fix really slow dio_sparse on certain
 systems
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Mon Jan 26, 2026 at 12:42 PM CET, Cyril Hrubis wrote:
> Hi!
> > The reason why dio_sparse is happening to be slow on certain systems is
> > that, if data buffering is slow, we run more buffered read() for one
> > single dio write(). This slows down the whole test, because for each
> > read() we always need to move data from kernel space to user space.
>
> I guess it's not about slow buffering. What I suppose happens is that
> every time the writer thread writes with O_DIRECT it invalidates the
> page cache and we have to re-read everything from disk. Which measn that
> the data are often removed from the cache between the reads and the
> reader processes are often forced to re-read the data from the disk. If
> there was no O_DIRECT reader thread the first child that happens to read
> a file block would cause kernel to put it into the page cache and all
> other children would just copy that data without a need to reach the
> disk at all.

This is definetly a possible solution. I sent this patch by waiting for
some feebacks in order to have other opinions. What puzzles me is that
it's only happening in POWER10 on a random node during kernel tests.
Other architectures seem to work fine.

kernel 6.6+ seems to be the affected one.

>
> However the test should finish as fast as the writer finishes writing
> the file. So slow readers shouldn't matter unless there is some serious
> contention on the disk I/O. That's probably the reason you are aligning
> the writer as well.

Exactly, I would expect that.

>
> What is the difference in runtime between test before and after this
> patch on the slow hardware?

DS009 from 4 hours to 30 seconds. I also profiled the list of syscalls
with perf, obtaining a 63+ % of io_read() time consumption. Still, this
patch moves the execution from ~10 secs to ~3 secs on my laptop. There's
a big difference between 4h and 10 secs runtime, no matter the hard disk
which is running below.

>
> The only thing I wonder about is that if we aren't dropping some
> coverage along with speeding up the test. For the reading part I guess
> it doesn't matter that much how big the blocks are (if we speed up the
> test we finish faster and do less operations, but that is something we
> can live with). If we align the writer it may write directly whole
> blocks instead of reading a block, modifying it and writing it back.
> Looking at the runtest files, we do have dio_sparse there with a
> different write block sizes, so the default shouldn't matter that much,
> so why do we bother changing it?

My patch wants to be a default way to fix the problem for all the cases,
instead of adding parameters inside runtest file.


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
