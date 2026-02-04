Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04285E95390
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 12:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770206740; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rAlVxf3eGNhg/tmLfAw933ddJCI+L1xrI7VN5V8Mwrw=;
 b=O5aJ0kDkju0k1SwT+k3j3S+Le9ZdYNd1am+l6bq5BkTfyoxh8C2GOflJTY9STk4CaLZ5S
 GGQBfodqqflU8sCSTZkFVomWECHcTqocKZ+McRKwTRYAHeNxUoohpsnz9iCVBypBsRvW7qv
 h0y9wvpF34IEBISyZC3YmYkIoyT1xrw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B9C03CE0CD
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 13:05:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFD003CD0B6
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 13:05:16 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 03DD410009E3
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 13:05:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770206714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pDWPuYBJGIJjILmlDC5OvD1c4r6fTRHesQDEOa90YOk=;
 b=EE9lRBYdFUWt218GnGHy5MFB/bcHrgt96wLuSm/79QMEjHmmHnY1NEtZh0OZ/ghfQmuOMJ
 ck+sKIzsWvEjuGIoSD3a2gcsWt/CYWTOwJNM6TwXxuW2VyCGz1nCjp4Xn8nyln2cR6JvJV
 Yl+pzx6/1/o2FylgUmGS3+HML+a/uxg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-08m629bxMX6XWj8BfRR1YQ-1; Wed, 04 Feb 2026 07:05:12 -0500
X-MC-Unique: 08m629bxMX6XWj8BfRR1YQ-1
X-Mimecast-MFC-AGG-ID: 08m629bxMX6XWj8BfRR1YQ_1770206711
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c613426e8dcso12190278a12.1
 for <ltp@lists.linux.it>; Wed, 04 Feb 2026 04:05:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770206711; x=1770811511;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pDWPuYBJGIJjILmlDC5OvD1c4r6fTRHesQDEOa90YOk=;
 b=oKfKunp/P1EnV+KUxL70cqo6vukIFrxuYf1ZWFievWX7bNyJqXVvtzk3fK/yPrFecZ
 9hBRF1EFSVdbzbVBPkaMO/MUWypyBPjqO0ViKAIdx/VJuaQttr+hs6RZdEmu/XVitE2F
 OV2uGPJvPxzusk0Tx07y3AFAljZ24LAeytKPqbpIto6ym5jpJiHYSqXiMScd4F2YNYAu
 mfTYF5dL8u/YWNVUU3xhCpu0eYOkGg+oYDI493OPEhkvNn6whbADuF9v6aLHjpveVE9h
 6kC0yqe7KHnNwl26BCqBzhOB7pTTMumpsd8tgEWPMr2zGWs0MAvRAqGl2E9aVMC776yB
 +qRg==
X-Gm-Message-State: AOJu0Yxaf9RRBk9JsfwJ755EUYI/ztC/KhfcUfd416Eife0P0NOqXsOo
 8k3z0cDQlrI2QLjeCAEleDZNeb7EcdB9zfxZvtrVwiAwdjK0KnQNzpHF/0f0yF0dqzwiu8Mghtp
 d6H6Ag2k5ypG2Ph50yNeC6J6mXWeSeHQl5UFv99Fmbq72hgsFjqqL
X-Gm-Gg: AZuq6aIBn/d2+eIuOlumkYjSK+owg3YicWU82s7v/WTBJ7H535FQFMMb1tK5iXEm3VX
 0LKeg91I6pWzLTaJTpXvHvkJ7cxdBemWqSw1FB4DFaDUhuHTOWG5sBlbg2TMC8ny61vLatvpEek
 SkSwdbIJtObziC9UiphpkM64INmOFpk73Y9l26qUWCzC0JXM6P6GKhd6FdA+brP7IRCZJewL8iq
 E6AQMXR0beguODggo+YOo6Hb218CkEA+GPwbkb8AURDAHM8UgrD3ZiwfEaUWdMYLB7BAGo+KC3E
 8+y4zHnDqTeZGq/oRQNN2mHwhwyGwpFiYKforBStAErLwlp5x0Ayx9BZMpO0ZbtHS9cnxwxaN2B
 G0Cge
X-Received: by 2002:a05:6a00:a22a:b0:806:12ff:3877 with SMTP id
 d2e1a72fcca58-8241c1b3eebmr2770184b3a.4.1770206711512; 
 Wed, 04 Feb 2026 04:05:11 -0800 (PST)
X-Received: by 2002:a05:6a00:a22a:b0:806:12ff:3877 with SMTP id
 d2e1a72fcca58-8241c1b3eebmr2770162b3a.4.1770206711105; 
 Wed, 04 Feb 2026 04:05:11 -0800 (PST)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6c85064ddcsm2189136a12.24.2026.02.04.04.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 04:05:10 -0800 (PST)
Date: Wed, 4 Feb 2026 20:05:08 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aYM19J5g7dTa5gqO@redhat.com>
References: <20260203024320.227453-1-liwang@redhat.com>
 <20260203024320.227453-2-liwang@redhat.com>
 <20260204115718.GB224465@pevik>
MIME-Version: 1.0
In-Reply-To: <20260204115718.GB224465@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5NSkEW_2ILedHEqrzzN4GckqhNLEKfaNakiYg-iMUE8_1770206711
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] newlib_tests: add tst_filesystems01 to
 .gitignore
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Feb 04, 2026 at 12:57:18PM +0100, Petr Vorel wrote:
> Hi Li,
> 
> obviously correct, thanks!
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Patchset merged, thanks!

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
