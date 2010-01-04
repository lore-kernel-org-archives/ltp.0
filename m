Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NRvtm-0000DO-OV
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 22:59:42 +0000
Received: from mail-gx0-f223.google.com ([209.85.217.223])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NRvtl-0000I5-R9
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 22:59:42 +0000
Received: by gxk23 with SMTP id 23so17190773gxk.2
	for <ltp-list@lists.sourceforge.net>;
	Mon, 04 Jan 2010 14:59:36 -0800 (PST)
References: <20100104171643.GA545@us.ibm.com>
Message-Id: <D107C512-245B-4187-9A8D-7FDC28234A0D@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <20100104171643.GA545@us.ibm.com>
Mime-Version: 1.0 (iPhone Mail 7D11)
Date: Mon, 4 Jan 2010 14:59:22 -0800
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Jan 4, 2010, at 9:16 AM, "Serge E. Hallyn" <serue@us.ibm.com> wrote:

> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> ---
> testcases/kernel/security/p9auth/p9priv.sh |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/testcases/kernel/security/p9auth/p9priv.sh b/testcases/ 
> kernel/security/p9auth/p9priv.sh
> index ad2eead..c1a14d0 100755
> --- a/testcases/kernel/security/p9auth/p9priv.sh
> +++ b/testcases/kernel/security/p9auth/p9priv.sh
> @@ -101,7 +101,7 @@ while [ ! -f $LTPTMP/d/childready ]; do :; done
> touch $LTPTMP/childgo
> while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ];  
> do :; done;
> if [ -f $LTPTMP/d/childpass ]; then
> -    echo "PASS: child could setuid from wrong source uid"
> +    echo "FAIL: child could setuid from wrong source uid"
>    exit 1
> fi
> echo "PASS: child couldn't setuid from wrong source uid"
> -- 
> 1.6.1.1

Is there a reason why this isn't using tst_resm?
Thanks,
-Garrett

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
