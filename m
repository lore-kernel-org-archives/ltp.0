Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1PxJdm-00081N-Gy
	for ltp-list@lists.sourceforge.net; Wed, 09 Mar 2011 13:41:26 +0000
Date: Wed, 9 Mar 2011 15:02:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110309140243.GA7793@saboteur.suse.cz>
References: <20110224101921.GA30765@hpt.nay.redhat.com>
	<AANLkTimuSUtaPSL5x1N75_nF2OtXfjMzcvu5wK4b2FJ7@mail.gmail.com>
	<20110225025148.GA2902@hpt.nay.redhat.com>
	<AANLkTi=cqRqDH_JKyVTx0cnRRy74Yidd9T8Ww-cSJMs4@mail.gmail.com>
	<20110225075728.GB2902@hpt.nay.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20110225075728.GB2902@hpt.nay.redhat.com>
Subject: Re: [LTP] [PATCH] basic mlock() testcase from lkml
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Han Pingtian <phan@redhat.com>, ltp-list@lists.sourceforge.net

Hi!
> +static void setup(void)
> +{
> +	tst_tmpdir();
> +
> +	fd = open(testfile, O_CREAT | O_RDWR);

Sorry for not exposing this earlier. But you should specify mode for
open with O_CREAT. That's part of the open() inteface that is kind of
badly engineered...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
