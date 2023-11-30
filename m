Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAB6C4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 22:15:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F33E03CE7B5
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 23:15:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B8013CC2C6
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 23:15:38 +0100 (CET)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2AD1E1A00A40
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 23:15:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
 t=1701382537; x=1732918537;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CHAu2uJgVVhwLCJtSJGq5AIve1tOLC9vd+5kSN0m7ck=;
 b=Ub/OOdYKFXJur6kJtutd6PJSbxVVss73SBxQBN31ne48UAk+BTJ2z3kP
 eEC7CGFl9JBFDVOqn2bSSOwD+eIYfQHzw15DyHUMHoJwGkrdAmwVNCVdd
 ZE4+E9xxwPj5bOPqRFRoaKy2FsHudGLxHgc1RftVs1jjL7jZy+ODg4+Hx M=;
X-IronPort-AV: E=Sophos;i="6.04,240,1695686400"; d="scan'208";a="373500692"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO
 email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com) ([10.43.8.2])
 by smtp-border-fw-6001.iad6.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 22:15:35 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev
 (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
 by email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com (Postfix)
 with ESMTPS id 314788094E; Thu, 30 Nov 2023 22:15:34 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:58929]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.242:2525]
 with esmtp (Farcaster)
 id f62c5e14-29d9-4f80-8a31-5de47fa0c637; Thu, 30 Nov 2023 22:15:34 +0000 (UTC)
X-Farcaster-Flow-ID: f62c5e14-29d9-4f80-8a31-5de47fa0c637
Received: from EX19D028UWA002.ant.amazon.com (10.13.138.248) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 30 Nov 2023 22:15:33 +0000
Received: from u3e8e27f4765f5f.ant.amazon.com.com (10.187.171.36) by
 EX19D028UWA002.ant.amazon.com (10.13.138.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 30 Nov 2023 22:15:33 +0000
To: <pvorel@suse.cz>
Date: Thu, 30 Nov 2023 14:15:22 -0800
Message-ID: <20231130221522.689680-1-mengcc@amazon.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231130104127.GA3099694@pevik>
References: <20231130104127.GA3099694@pevik>
MIME-Version: 1.0
X-Originating-IP: [10.187.171.36]
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
 EX19D028UWA002.ant.amazon.com (10.13.138.248)
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] rwtest: Confirm df is a symlink to busybox
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
From: Mengchi Cheng via ltp <ltp@lists.linux.it>
Reply-To: Mengchi Cheng <mengcc@amazon.com>
Cc: mengcc@amazon.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, 2023-11-30 10:41:27 +0000, Petr Vorel wrote:
>
> Hi Mengchi,
> 
> > /bin/df can be a symlink to coreutils. It returns correct info with dir
> > arguments.
> > Just checking if df is a symlink will include such cases. Need to make
> > sure it is linking to busybox before ignoring options.
> 
> > Signed-off-by: Mengchi Cheng <mengcc@amazon.com>
> > ---
> >  testcases/kernel/fs/doio/rwtest | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> > diff --git a/testcases/kernel/fs/doio/rwtest b/testcases/kernel/fs/doio/rwtest
> > index 6725e1426..26659e9d3 100644
> > --- a/testcases/kernel/fs/doio/rwtest
> > +++ b/testcases/kernel/fs/doio/rwtest
> > @@ -329,10 +329,10 @@ do
> >  		else
> >  			# If df is a symlink (to busybox) then do not pass the $dir and $dfOpts
> >  			# parameters because they don't work as expected
> > -                        if test -h $(which df)
> > -                           then
> > -                               dir=""; dfOpts="";
> > -                        fi
> > +			if [[ "$(readlink -f "$(which df)")" == *"busybox"* ]]
> Could you please test if this works?
> 
> 			if [ "$(readlink -f "$(which df)")" = "busybox" ]

I just replaced df with a symlink cmd and the string such as zstdmt/zstd in ubuntu.
It does not work..
But below should work
			if echo "$(readlink -f "$(which df)")" | grep -q "busybox"

However, I linked df to /bin/busybox on my device, df -P ${dir} seems fine.
The original code may be for a very old version of busybox.
:/# ls -l /bin/df
lrwxrwxrwx 1 root root 12 2023-11-16 17:49 /bin/df -> /bin/busybox
:/# df -P tmp
Filesystem           1024-blocks    Used Available Capacity Mounted on
tmpfs                   280848         4    280844   0% /tmp
:/# /usr/bin/df.coreutils -P tmp
Filesystem     1024-blocks  Used Available Capacity Mounted on
tmpfs               280848     4    280844       1% /tmp

My busybox version is v1.35.0. It might be ok to remove the check completely.


Best,
Mengchi
 
> 
> Although this script uses bash, we generally don't want to use it. Thus it'd be
> better to not introduce any bash specific code.
> 
> BTW this is very old and very ugly script, we should cleanup it or delete:
> https://github.com/linux-test-project/ltp/issues/1110
> 
> Kind regards,
> Petr
> 
> > +			then
> > +				dir=""; dfOpts="";
> > +			fi
> 
> >  			blks=$(df $dfOpts $dir |
> >  			(while read fs blks used avail cap mountpoint
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
