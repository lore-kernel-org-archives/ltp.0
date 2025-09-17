Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282C8CA0EE8
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 11:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758107631; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rqiNZ5eXHOwguivF0k+7j3k8O3+4qWtcwbEKBfpHiPc=;
 b=ErjCI0gpEdMkl53g8pWcYVsL4LY5AjZoSHhTg5rBhWt8s4uQk3HIHGBh5E+PyjRz612Kp
 dMnpsMOWjdipdum/m7APGm/YlzoPqKT1zJs3mpXApgLTmMAmivmHIE+pZmBLQNNkRv9HROu
 KI+JPTA0Joo7FqWN2ZfDqxl0N+ZBT2o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AEAC3CDC16
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 13:13:51 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 88E973C0433
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 13:13:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A45F11A00994
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 13:13:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758107606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HnbDe0mNJ2jfGL2mN2xss7N3a/EF1XZLDkotMXKW/J4=;
 b=FhGiY3HBVxz1+1NPnFjCvdSFYgjTMr8FzwcVx5dO1TBzza+5LDVPM4lzDb1zIj81f6XxMU
 C/vxQCJkEWgzK9gx9DE/h2vAPtWGqD7YGgebC53bdjudHd+FdtZjbyE18L+yd4UHJ8WYTI
 KT+j54MN2be8mnIEcsBROSuv82RYNUI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-384-nf99quPYN2KVq18nA1YKfQ-1; Wed, 17 Sep 2025 07:13:23 -0400
X-MC-Unique: nf99quPYN2KVq18nA1YKfQ-1
X-Mimecast-MFC-AGG-ID: nf99quPYN2KVq18nA1YKfQ_1758107602
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45cb604427fso41379275e9.1
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 04:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758107602; x=1758712402;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HnbDe0mNJ2jfGL2mN2xss7N3a/EF1XZLDkotMXKW/J4=;
 b=GmKn1ZVtgQT/pZYO3s1/ipFfe7IG1bc9v6oMYur4j7HaeaL2JjDZZmkYqc0vJTa5Hu
 vnW5l18S8yGscnYR+Va5I75mEXBF1rIQ73caJIjmuVFT810FJNRBn9hDWGEL1HsRqwNY
 zp5szvpQroz4xNrp25a7NAxxaooc+L/hYqi5xp42kQqBzGpW1dLIEn9XaauJWlyKmUSv
 AiXASeZ0HUxp30N3NVAT3IUYxYsbCpk3CwfGcS19gTaU2rvLx9ewbl0fy0ynfNQQPwoQ
 8yT4hlnDPxEWVBqAJkpskJZbGzUcmr3ik3IJQGYaq6ZK7rCHhDAFUwowMXqHzHLFZxo5
 LGIw==
X-Gm-Message-State: AOJu0Yy9SZR4N+WLnZbgeZzpz2zIVH+9fiY0C8k2g/OemRyowkAqugpJ
 a3e4AKyh+6nKjqHmmoiLNx2QD66BorcCXqsuhD2ZHc6zpwcTTYX9OAdW+gz0HMWHt2G9ccHGmsn
 Kkw1HvAuVycQS9p7at19EMlaD17B+rB4qXZDaSFciYKpmna2KvEaI
X-Gm-Gg: ASbGncsBJgQLkZd6cMUpXMH3eNRNT50QPr86i4BMLe8prHHtO3APyrZXMovIeJf8Mgm
 yZAkxDO+evtL0QfWt0UinYGIdoBYVgOqRjzA6iQnwIc91TnxFY+xiFARgqJkODmIyLV6ALueOSK
 8EPIrcw64re0su0x1QeWiHpG4DqwiM9QwW+jDEmgI7QrsWbiTXNtFW6o4pXpQIxlkBSvoP9lrOd
 pY4DQ9Szt1/UWPNyM4nuzBW4YXo3Ln8ZZfYrNNFjy/tIfmV3BXGftkH+mzupI30vzrjBZOogeW8
 uuQK4aX+TVVyls+TBWpMORcNQpF2kZ5l2EE0X5442ddFsg9WErkvU2G1gQ==
X-Received: by 2002:a05:6000:40e0:b0:3e4:1e29:47db with SMTP id
 ffacd0b85a97d-3ecdfa3c714mr1770782f8f.43.1758107601692; 
 Wed, 17 Sep 2025 04:13:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvEJQp9IcTTklTTcVpBCm2nQFyQOAa99Eb8/WyN5aK0JqjIn9e2NphID88a+HTpKgTb/djOw==
X-Received: by 2002:a05:6000:40e0:b0:3e4:1e29:47db with SMTP id
 ffacd0b85a97d-3ecdfa3c714mr1770757f8f.43.1758107601310; 
 Wed, 17 Sep 2025 04:13:21 -0700 (PDT)
Received: from lida.tpb.lab.eng.brq.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ecdfea6965sm1863153f8f.13.2025.09.17.04.13.20
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Sep 2025 04:13:20 -0700 (PDT)
Date: Wed, 17 Sep 2025 13:13:19 +0200
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20250917111319.wgfpjmkicmv2rjti@lida.tpb.lab.eng.brq.redhat.com>
References: <20250917090712.5tbidlr7yvqvikj7@lida.tpb.lab.eng.brq.redhat.com>
 <20250917103717.GB336745@pevik>
MIME-Version: 1.0
In-Reply-To: <20250917103717.GB336745@pevik>
User-Agent: NeoMutt/20180716
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: G6gLMt8iaOBTThH0MwxJ51hd2yW4F8gSaJZgeyR5aaM_1758107602
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Proposal for new LTP config knob: LTP_QUIET
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On  Wed  2025-09-17  12:37 , Petr Vorel wrote:
> Hi Martin,
> 
> > Hi folks,
> 
> > some time back, LTP_REPRODUCIBLE_OUTPUT was introduced in LTP.
> > I'd like to propose a new, related LTP knob for our Valgrind
> > test automation purposes: LTP_QUIET.  See attached patch.
> 
> > LTP_QUIET is supposed to suppress certain types of test output
> > messages, such as: TCONF, TWARN, TINFO, and TDEBUG.  This would
> > help us keep our test logs briefer, while still keeping the
> > information we need in the logs.
> 
> > Please, consider merging upstream.
> 
> Thanks for contributing this. So the point is to have only the final summary
> printed, right? (summary of TCONF/TWARN/TBROK/...).
> 
> I'm ok for merging this + to introduce the same for shell API (tst_test.sh),
> although you in valgrind don't use it.  And we could even introduce '-q' getopt
> (easier for manual debugging).
> 
> Do we then want to keep the "reproducible output" part? Or should it quiet
> replace it?

Hi Petr,  you are right that these two knobs (LTP_QUIET and
LTP_REPRODUCIBLE_OUTPUT) partly overlap.  In my proposal, LTP_QUIET
doesn't silence everything.  It does silence TCONF, TWARN, TINFO,
and TDEBUG messages.  But it keeps TPASS, TFAIL, and TBROK.

Suppressing everything except the final summary seemed too
aggressive to me initially.  But as we speak, it would work for
Valgrind testing purposes just fine.

> @Cyril, if you agree, do we dare to have it before the release?



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
