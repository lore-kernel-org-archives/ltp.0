Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE4EFCD0B0
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 05:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773812194; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=NauFt0aaWaPSgtyUvzS3I3afsUXLFwNadoL2pYeSJ8Q=;
 b=GDxke4gyluPg5sTMWhP47bCt5IaDlzEDxqC+dliEJEsWrKmpWyWufRE+JanLFcvAVDYF9
 BJQ0b0NyD/3hAYQNvUR/W3SyrE4Qu9f1XmwGUHZTPsRkY586z4eEtghYq1V9TWCLdt3+m/d
 MrrWz2qXZcTw9zGqb2ReLyvXIHbVWow=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 657AB3DE1B8
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 06:36:34 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6CBD3DE1B8
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 06:36:10 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 19B03100094C
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 06:36:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773812168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CWFVkW+asX8ktfL/XnAcpWJeWCgLZ96/nrxdl427OoM=;
 b=gWoF8u+TCVhqkvv+b7Fpi2idwDBOmcUe3m+niLnVLSP+Sbo9XwR0FSDjuf10zWrEsAhCzO
 HtV2E3JRb8uXVUa6GWTC0viHz2Zc07sHSxTfyJ828amTRn6XBhL0trg4mJYXE8Y5fiWq/F
 H6Fp8Us+YRuthqgaRnlZuEqToXC+xrU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-5uQdbR0kOwGgTSlxx_pjNA-1; Wed, 18 Mar 2026 01:36:06 -0400
X-MC-Unique: 5uQdbR0kOwGgTSlxx_pjNA-1
X-Mimecast-MFC-AGG-ID: 5uQdbR0kOwGgTSlxx_pjNA_1773812165
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b05a3c2421so34641245ad.1
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 22:36:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773812165; x=1774416965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CWFVkW+asX8ktfL/XnAcpWJeWCgLZ96/nrxdl427OoM=;
 b=Cqkw/MAh4MJogJrNA6wmi/aINM6EBmpJ2NghVMjEUoVIRyW8w/uXuAdU5RU7fbLW9U
 ZpKQdYc9F+utq30AW3dtG8zeQFGPYSCDbGfFRC3mE8QLHOxJfW7MtC3zeyav6gk1rg7y
 DihTZ5f+MNhie2zpext2MZHmq0eXHuA4XKLUgUYkrB9NoEp1JCo4lLvKLvFnsz4sB1SS
 ziv6UAd5QQF9sqd7MA44V3dgfaLX63L871tg6M2k7ALFk5Dk26GBqJ+jfterMr3t5d/g
 nGHK4FtYors0B5YHy4v8j4NszuCo8EbKPO3eUILJ3kcvf/VDmBxyk3YUA4SxuY0LVCH6
 DZSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSoOnlwoO2J8PhEyff9qrljHIjsPLlwKjFntDsJieU1vIa7Zi49cLRXvALtQUG4zhd/6g=@lists.linux.it
X-Gm-Message-State: AOJu0Yx3PQpLRixMIjB8sek5FtfyKk2pLof31SKuuVqmXr3F/nrNVaHT
 ZAzTj7jK+Qu2/DkP6vLS+qKwEzZYg5jJMdTJ4tjW7jOjHrNqnpRJBby57kgC0XRjv5kwbNKmQbZ
 WlGTmyD9rUAKGSeNeZZ19GWhJdNJqCzewC1NBic3gMGzhsldq8IQS
X-Gm-Gg: ATEYQzwue5JnG6IMJlW8u487XsBwANKEqNlkQdhBj9CFTvu0xGXwzyiHe/92gf5BmJk
 KR8i0O2n0MHB4bPIBH/vYeUfCz+NjDyEYcrqXh1sLu/kUNLzMDlgxu/uOAAf67ImXVCjaX5amlm
 NMCQZBn3X7IonxYoSecM7pKJ34cAg7DEGv+KfvYqOlrrWcFF0rvBjU7uSHRAvJl9aLFkvM3G0yJ
 +6knw8l/24FwL4Z3OHfWJGrju0DgED48sIz28lAnH76algj8mjoF/P35K9/B3ilMhM6xc4FJvK4
 p/n2vXBtI0UTmaLyg0b65dyJhgTAQBXkqRDf3EW+JhlNzjXtnrUq6bOJr10BtK1TqB6EFkQzCnX
 GI9uxu21jGpSuI1uB5A==
X-Received: by 2002:a17:902:ef44:b0:2ae:aca4:b120 with SMTP id
 d9443c01a7336-2b06e2da24cmr21108745ad.4.1773812165105; 
 Tue, 17 Mar 2026 22:36:05 -0700 (PDT)
X-Received: by 2002:a17:902:ef44:b0:2ae:aca4:b120 with SMTP id
 d9443c01a7336-2b06e2da24cmr21108485ad.4.1773812164694; 
 Tue, 17 Mar 2026 22:36:04 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e44f04csm13749885ad.36.2026.03.17.22.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 22:36:04 -0700 (PDT)
Date: Wed, 18 Mar 2026 13:36:02 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <abo5wgYIYzo9_yo0@redhat.com>
References: <20260317115828.GA365182@pevik>
 <69b945ab.050a0220.1eaaec.d93b@mx.google.com>
 <20260317223920.GA370623@pevik>
MIME-Version: 1.0
In-Reply-To: <20260317223920.GA370623@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kQZlYJ60UHQ0_pKwLEfnNGKEYR-AjeueBy4PrR-grgM_1773812165
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP old API conversion
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: Sebastian Chlad <schlad@suse.de>, ltp@lists.linux.it,
 Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Mar 17, 2026 at 11:39:20PM +0100, Petr Vorel wrote:
> > Hi Petr,
> 
> > > I'd vote for limiting patchsets to max tests in a single directory.
> > > Why? Smaller patchset is easier to review. And if just some of the commits are
> > > accepted then fewer commits need to be rebased.
> 
> > Do you mean one patch-set for multiple (unrelated) tests (for instance syscalls
> > folder) [1], or one patch-set per testing suite [2] ?
> 
> I meant [2], i.e. tests from certain folder (usually tests related to single syscall).
> But it's just a suggestion, feel free to do it differently if it's significantly
> simpler.

Some tests may relocate their folder after the refacoring.

Regardless of which method we ultimately adopt, I recommend that
the AI send no more than 10 patches per week [1].

Furthermore, new patches should be sent only after the previous
patchset has been fully processed.

[1] Given that the total number of legacy tests is only 242,
the cleanup work will not take much time.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
