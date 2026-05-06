Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52532CD3436
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 11:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778067945; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=kiyMugUz40F2SB2+dFqyhHExx6L9Cwd6J+W4OwNiS60=;
 b=NUUs5slclmHalzcBgnIvwK/rpH1JpUZoa+iDitrZrtLdAwTq8WjhkXAsS7uQLCnBvr7FG
 DH0bqkiZHqt0ojXIX5XtCscTQ+2lKt9ljKY3MFNIBy0OsCAX9T6lIhlWI0ifUaucMAuyZKh
 jy48+XLYffVnbb1fIAFByU3TtDVaBH8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7D683E6155
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 13:45:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3F9D33CAD2E
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:45:22 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 80DDB10009F4
 for <ltp@lists.linux.it>; Wed,  6 May 2026 13:45:22 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so70994695e9.2
 for <ltp@lists.linux.it>; Wed, 06 May 2026 04:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778067922; x=1778672722; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=P4L2F83CuKPVqvP0/p1UzwHk8X2RlryZ/PbozkkW4II=;
 b=foTFQj4HNbdfJayO7dNSHxKLLIwYBkwVB7Nr7vFBiWaHsAZooBnQ4iL0sL6WycxKbT
 SbOJu21fy+RzA1P5Nx1guHqXRDzz4rJOA4z7u0mTUztCguw6/rSHS3+P5X59/PRwGa1d
 D9JN0BOgBZs4N3iDQNx7C40qUbErPKXKd6RNFqilPHvWdkIwdDkQvpUIHx/ghzsqi4y8
 m9hclywb01BTTcNBwCCWznSgmx0iEihwHc1G1yDNTHvHX5MuWMUQRRhWP8evIF702mrI
 nOH6fwqKkMTrrSGAc2wR0h0sjRv4eeh1DM/LywC8ojag1zcRuXWyO0eRJhj9A7j2luR5
 /43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778067922; x=1778672722;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P4L2F83CuKPVqvP0/p1UzwHk8X2RlryZ/PbozkkW4II=;
 b=G3IZMB6ztz5pzJ5lSIG/vQIxAqCtZUaAXDlh5dzmdn0orwIv9mFNZjvwBjv0mTM/kP
 hMMgK9TdvUHYjey1Ve2wnFDRMRTsUIzWtbupFfoTdGgUACzUc6MwUfazxE2t/YIKL0L/
 z2V87l6QDXVTo1q6tHZa30KBYGchsPfDJ3qSdx+GY72Dh1F4tPJ/cdYzqecGDV1eV/cf
 S6MilZS1fJep3VAtOcKhEbKvx2nosUmCrWCNZiKfxx+3/7xg04nxfzc/PJrQjt+d5HKG
 mcH4ny686xOIycyJ8iZxuRelNtiGv1D8NcTVXPETFyP+mmHVOEBnjdZMTfYhqlNoZlvP
 9xVQ==
X-Gm-Message-State: AOJu0YyQutEJocr/tEra5axXM0zuXyZDLApT881iYPKW50P+xAge4Ner
 SWKbhNpi/br5kz5VnsT1UAZHIOpD7SWg2+v20zRA1gDM0UwH55ETlRcSyU/31m/zrTNQdJ8KOcT
 QMF85H9E96g==
X-Gm-Gg: AeBDietwzQ2J4IKvXvZJh2ls3xlXY924iqbLq2EAS8Tc4PtTSB6AINEF6cbxJ1hoE85
 tp8CNv3BKK6moQ8oR3JbgsOFTZmAT0DzJNufWi3JED3hLJ8YqKy4PFw8CzhnRI8vfkPr7BHDERZ
 +B5pQJ2EzK0HYr6TwSGMVGwjhmGZcYJ1Y/sB53nJNNThKDez6Tp57YRINgriRKgircaUPoLUIxt
 xXx6700vd2zQLldnexcBv5OfhsjoC4oga8ivPSuwRCbHiYMa5SUZra4bDBC/03EdKfqecZvXK7R
 lgPqANsxFR7pkDK0pNWgd4EZJMUM0wqfhkVbRS6lMifaEccuN7Ra71G8MAxE8Q7RsfWyy9Cm8jb
 LdLCs648oDZ37D3WRvTOtCj3cN9TO+Xtk9pu+8f1nLLmiFb/WpTwN2VEtSsPvLDCtPIIirPxxZE
 h0UPxiqpRJg9Hnwjgcy6fLsrpoBtItX+BGtKMNNaBS/Wz6MH68IUIRP3gp+Q/X/aU6A0/kTNDZx
 GuhSkRW1rrnAYwDzfcmlBcu7+uu2ZQ5uETfwK8AwOtCPXGKhcfZthz/jRkSQjQ0WZCKMUocX2UW
 EorkYYpBkSHN
X-Received: by 2002:a05:600c:47d3:b0:48a:9428:5522 with SMTP id
 5b1f17b1804b1-48e51f37358mr32407675e9.16.1778067921842; 
 Wed, 06 May 2026 04:45:21 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5314bb21sm15644395e9.29.2026.05.06.04.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 04:45:21 -0700 (PDT)
Message-ID: <69fb29d1.050a0220.1a0ae1.230e@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260416121638.11858-1-sachinp@linux.ibm.com>
Date: Wed, 06 May 2026 11:45:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/2] io_uring: Add test for READV and WRITEV
 operations
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Sachin,

is it possible to separate the test into multiple ones?

Having multiple tests scenarios inside a single binary means
that (often) if one scenario fails, the others can't be tested.

In the kernel maintenance it's important to keep distinction
between tested features, so it's easier to debug a bug
in the system by cross-checking different scenarios.

We can have a helper header sharing the common operations and
to define multiple test files. It's a common pattern we use
in LTP.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
