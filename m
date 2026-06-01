Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F015CD6E4C
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 06:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780296644; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=HZEw1uYKBHLTgirkxpBtnBKY+JO1J4Ip8bmq7/JDmu0=;
 b=AY+Wy9B26v8kK6rFuQLwR3Balef5uTFtR03LVpnTC5WmQeIm0vLE01NgL6BTuSpEPmhCw
 f9KYz3W0TYTm2eZFTHVb2/LM1IuwOPt4ZNSxnB96lS+t537E9HKXoujC/q76o8q61JudV+o
 FFxUL/iTQwLObGlseHXVQzzm4rj1XEc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 014253E484D
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 08:50:44 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A1853E483B
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 08:50:23 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C578C60007F
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 08:50:22 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49068493267so52550645e9.1
 for <ltp@lists.linux.it>; Sun, 31 May 2026 23:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780296622; x=1780901422; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zrjql5QRU+yCktxddmp9EqoaD6m0BNXheWb8fMSz5nA=;
 b=dpTkq3s/UsgUYw1+ncZ7KBrD2wsZeTQd5WHlKlUxrBtw4FnROgw87NqnM2hoOiODqx
 YjWcD24JaTQxmnRMMR6hJeFVUtFKiks20iukztoYcirJY8muClpygCSSLrGjjKjgkd9A
 iypUOnkWSAq+8lDthCoFh9IgTnBHJptbqQ463KIDIlt54X5sWVcoxtqKsUPCc+ucfgmL
 Fu1ZNRfdKcypE+isrKztHf2mqljifVIXjFeF7E6i1Pz8VfB0SgdIy/CR6xUd51fgS/mS
 hEcquWiQQpbanHQzexsktF+B0tA6q4AuT8rCMrVNeUrgCHIw0Vzj5g6vvFjHh6KQAmz6
 xvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780296622; x=1780901422;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrjql5QRU+yCktxddmp9EqoaD6m0BNXheWb8fMSz5nA=;
 b=Rb6x0jajr1e1AHhdhMptrUSkgzTIVWcCGxIr4Y/z1ZDOdw22mP3gET1UhDrxYMHlAd
 StnuEfTnMIGd+MZ0LFNSIj6lWb32Mvdd85U5wIu8IuOT0r9r6m5amAA+iO9VSQz9gamD
 2rZaSN38QmAsBW1ZDOksTs0q2KX0ytk3S96doyLb6iHDL4cMb+5fpxtkGk0NtfxY3AQB
 mRA9mbGrvH2q/lA+nZuwTzRcoYVscgNdTZX+3PSl2lzeg4sxj6aWhPTuKDmFDqKtqlg7
 knnitjtQDNXwVAqGgv+JIUl6prXSY8d5oMFOTY8dkea0Oyck0ztObyLO1yHtSvTDziwy
 kOcg==
X-Gm-Message-State: AOJu0YxC2vhLhvxAtBwL9GGHLYrRscV8ZXINr9n92u52tbJ8f7GZxDOb
 e7xpmNtQYFBWLDYi/dOE53yAjpl68PB1AvLvJTNWaozj8FYZ+e85/xzs14jyqcX5iSuLMD2iO9v
 GZA0slZ4=
X-Gm-Gg: Acq92OENWuFYNsgmDIWqXW6mHR/hjjNo+zEHGiTuSIp/iR+cAVISgLMDb36Lstwcy5e
 cji1wZ4uCis6fjmq/qTy1gMkfYh/Kn/Ag4dKtjXbedjzO1fvmChyIB1q1lUccNvaiuswcEFNFNH
 2uvTDBfog3z1Q9ACimYkn9O8PTBFPlEORXOgCMoEjG3Z1wOvMAeKXJZ69YZSLuyp3gxu7Y4djAm
 1vdDxysraNXZP1cseSqqZfSrMpc9lLFBHHqyC/m+YCJ2fp4VSKAR+lD39+0aJCQqF7e9Ym5xQyF
 36DtXwLX37OjCfp37LCODn2uOlsC8QX9mYjgKGuM0/MYhinobTkMH7V0NeV75K8vCWPrlCbI9pp
 er0fbZZx5G0KshEv2jkfcowARfLGftMP/xJkkkF5UZpZlWxEuURWgwbhmjvKFynBJx+xcg3mnWP
 wyL5AVdgLg0r/iKJPBwM8XhaHaEf292UnsH+z8ihu+QRl9epzLvbAtR4RwQ/DMgQD8zbzW8J9LV
 JS+mTBW7fynx06I3yueWTcp16Rd5LPIW7oHoVvRfwl4Lw==
X-Received: by 2002:a05:600c:4e92:b0:48d:366:b962 with SMTP id
 5b1f17b1804b1-490a2900ef2mr181112465e9.6.1780296622105; 
 Sun, 31 May 2026 23:50:22 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4a8800d2346cb1fd1859e6.dip0.t-ipconnect.de.
 [2003:ef:2f4a:8800:d234:6cb1:fd18:59e6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909ca6575csm337171955e9.4.2026.05.31.23.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 May 2026 23:50:21 -0700 (PDT)
Message-ID: <6a1d2bad.97b0ce82.3c3385.8804@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260531124540.70788-1-sachinp@linux.ibm.com>
Date: Mon, 01 Jun 2026 06:50:21 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 0/8] Convert shell-based ACL test
 (tacl_xattr.sh) to C
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

the patch set is not compiling in some systems. Please verify that it
compiles by running the CI in your github branch before sending a new
patch.

https://github.com/linux-test-project/ltp/actions/runs/26713233737

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
