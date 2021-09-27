Return-Path: <SRS0=FiD7=OR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B05C433EF
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 19:10:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B3860F3A
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 19:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89B3860F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B02753C8D7D
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 21:10:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FE9C3C8D0D
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 21:09:54 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 39AC01400DAD
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 21:09:54 +0200 (CEST)
Received: by mail-qv1-xf32.google.com with SMTP id a14so11830006qvb.6
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 12:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=fI1klvrPGTHDBVjyve9OpGfwzPOFAwgwKnf6n8pxkDU=;
 b=NsE928JlQ5JSZdXEnzzwBieGuYMesre+kSygnBTIshnLeEAlxvaRmagyiErMBjuG+j
 QVWZqfPfklYdEnJ7CZq3ud5UriPI3ZRQRl/J30ZcsyylYlF6PVd/6BYbx+//CxS8ZzmL
 RZvoE0pjmBx+pb5DHRcGxaAnjSBJ27g4eZgc1Rm6GP/+/Qb7Lx1C8cavrM0tjIyCNAF2
 fu1TtsK87unDWZpX2vPSVGQ3yMvqga5hMUNUHvARRT7zhYsvusA/hsEYFqUc9et2Vxl9
 nXVohe7DWnTAvrzCQnIDjc7P/agPQOnBo33OdcoxYfXeGiUCtKbK9aBmfCeGLGAoySHn
 st1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=fI1klvrPGTHDBVjyve9OpGfwzPOFAwgwKnf6n8pxkDU=;
 b=zNkxMAFSsLL6rso4thHkplbpEKasb1rp0sqdtpJXzmSmP6AwlzX+NVEe9JMfClT50W
 Bwe1LamNUQ8mWxaBlINuA8XtajCuvwQW2YTaLV1zMsU2uxBdJZL8WpVQYwgoPB9hXdJ4
 7P5v7oCRlVAJf2SX5Ad6rRQjidBaEVvcN5KZMNlkoiodqMEsnZlMkMZZWf9HzlBrQD29
 vvYyEoUp9aIf+HiIvISPgOwr9asPlT42MJ843Nn2Lpg4e1PpDJMmIXMBesf2GNcf974v
 bhuFGyj0sAK+PXLzmC+oOLc9qBqoFQDKV1imd2OlSXLFR/rv7uXTTbqlXLk6eR82qCHa
 swmQ==
X-Gm-Message-State: AOAM532uoneSLeSnUkRSCCl4bm3Sf1CoDBy80LBSzWqjWgIOPcVxbeKD
 m2rP1p9oiqw/1P4H9DyJPz0r2A==
X-Google-Smtp-Source: ABdhPJxItaO3FNXoxUy0HO6YYYSry5Bea+1mHJnQxKQbFL/efeBLLJPHz0R/e0CEiQmPib06h1TJMQ==
X-Received: by 2002:ad4:436b:: with SMTP id u11mr1406792qvt.26.1632769793106; 
 Mon, 27 Sep 2021 12:09:53 -0700 (PDT)
Received: from localhost (rfs.netwinder.org. [206.248.184.2])
 by smtp.gmail.com with ESMTPSA id l3sm11048646qtu.47.2021.09.27.12.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Sep 2021 12:09:52 -0700 (PDT)
Date: Mon, 27 Sep 2021 15:09:51 -0400
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: Li Wang <liwang@redhat.com>
Message-ID: <20210927190951.GC4173236@maple.netwinder.org>
References: <20210924070756.3916953-3-liwang@redhat.com>
 <20210924105234.3927811-1-liwang@redhat.com>
 <YU3fTlVIIUU7Ff3d@pevik>
 <CAEemH2crBA=-piu3Z+CM7+Z3neWWxkuMY6+y9i6vdHSvZukKgw@mail.gmail.com>
 <20210927151220.GB4173236@maple.netwinder.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210927151220.GB4173236@maple.netwinder.org>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] lib: adjust the tmpfs size according to
 .dev_min_size and MemAvailable
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
Cc: LTP List <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Sep 27, 2021 at 11:12:20AM -0400, Ralph Siemsen wrote:
>
>However fallocate06 test is failing with OOM. It seems this one still 
>contains .dev_min_size = 512 , should this be removed?

With .dev_min_size = 512 the test should be skipped on my system since I 
have only ~120 MB of free RAM. But something is wrong with the test.

I added code to print the value returned by tst_available() and found 
that it was a very very large number.

After investigation, the format string "%ld" seems to be the culprit.

--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -65,13 +65,15 @@ void tst_pollute_memory(size_t maxsize, int fillchar)

  long long tst_available_mem(void)
  {
-       long long mem_available;
+       long long mem_available = 0;

-       if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %ld",
+       if (FILE_LINES_SCANF("/proc/meminfo", "MemAvailable: %lld",
		&mem_available)) {
		mem_available = SAFE_READ_MEMINFO("MemFree:")
			+ SAFE_READ_MEMINFO("Cached:");
	}

+       tst_res(TINFO, "RFS: tst_available_mem returning %lld\n", mem_available);
+
	return mem_available;
  }

With the above change, tst_available() returns a reasonable value, and 
the fallocate06 test is skipped:

tst_test.c:1436: TINFO: Testing on tmpfs
tst_test.c:937: TINFO: Skipping mkfs for TMPFS filesystem
tst_memutils.c:81: TINFO: RFS: tst_available_mem return 120592
tst_test.c:907: TINFO: RFS: tmpfs_size = 512 avail=120592
tst_test.c:911: TCONF: No enough memory for tmpfs use


Also, when I remove the .dev_min_size=512 from fallocate06, then it uses 
the default size of 32MB, and the fallocate06 test runs and passes.

Regards,
Ralph

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
