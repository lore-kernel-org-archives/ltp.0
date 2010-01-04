Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1NRwTV-0001hc-3Q
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 23:36:37 +0000
Received: from e31.co.us.ibm.com ([32.97.110.149])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NRwTR-00033c-3M
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 23:36:37 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o04NSY8L017875
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 16:28:35 -0700
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o04NaOYP154738
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 16:36:24 -0700
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o04NcOVO005857
	for <ltp-list@lists.sourceforge.net>; Mon, 4 Jan 2010 16:38:24 -0700
Date: Mon, 4 Jan 2010 17:36:22 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100104233622.GA9018@us.ibm.com>
References: <20100104171643.GA545@us.ibm.com>
	<D107C512-245B-4187-9A8D-7FDC28234A0D@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <D107C512-245B-4187-9A8D-7FDC28234A0D@gmail.com>
Subject: Re: [LTP] [PATCH 1/1] say FAIL not PASS when we failed
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Quoting Garrett Cooper (yanegomi@gmail.com):
> On Jan 4, 2010, at 9:16 AM, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
> 
> >Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> >---
> >testcases/kernel/security/p9auth/p9priv.sh |    2 +-
> >1 files changed, 1 insertions(+), 1 deletions(-)
> >
> >diff --git a/testcases/kernel/security/p9auth/p9priv.sh
> >b/testcases/kernel/security/p9auth/p9priv.sh
> >index ad2eead..c1a14d0 100755
> >--- a/testcases/kernel/security/p9auth/p9priv.sh
> >+++ b/testcases/kernel/security/p9auth/p9priv.sh
> >@@ -101,7 +101,7 @@ while [ ! -f $LTPTMP/d/childready ]; do :; done
> >touch $LTPTMP/childgo
> >while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do
> >:; done;
> >if [ -f $LTPTMP/d/childpass ]; then
> >-    echo "PASS: child could setuid from wrong source uid"
> >+    echo "FAIL: child could setuid from wrong source uid"
> >   exit 1
> >fi
> >echo "PASS: child couldn't setuid from wrong source uid"
> >-- 
> >1.6.1.1
> 
> Is there a reason why this isn't using tst_resm?

No good reason

thanks,
-serge

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
