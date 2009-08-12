Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <casey@schaufler-ca.com>) id 1MbI58-0002Ee-PR
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 17:57:50 +0000
Received: from smtp103.prem.mail.sp1.yahoo.com ([98.136.44.58])
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1MbI4z-00055J-Ka
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 17:57:50 +0000
Message-ID: <4A82FBE4.4050601@schaufler-ca.com>
Date: Wed, 12 Aug 2009 10:29:08 -0700
From: Casey Schaufler <casey@schaufler-ca.com>
MIME-Version: 1.0
References: <364299f40907302318o440851ewfde0b34ca561b8a2@mail.gmail.com>	
	<1249298382.7460.23.camel@subratamodak.linux.ibm.com>	
	<20090803141637.GA29108@us.ibm.com>	
	<4A77BF38.7050201@schaufler-ca.com>	
	<1249387670.15587.30.camel@subratamodak.linux.ibm.com>
	<364299f40908040532p5ce58060i22edacbf4f26416c@mail.gmail.com>
In-Reply-To: <364299f40908040532p5ce58060i22edacbf4f26416c@mail.gmail.com>
Subject: Re: [LTP] Quiet down smack test and check for /smack before
	continuing
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
Cc: Casey Schaufler <casey@schaufler-ca.com>, ltp-list <ltp-list@lists.sf.net>, Mimi Zohar <zohar@us.ibm.com>

Garrett Cooper wrote:
> [...]
>
> Well, AFAICT given the documentation smackfs can be mounted to any
> mountpoint, correct?
>
> Also, I realize now that I accidentally used a bashism -- `source
> scriptname' -- I should be using the POSIX standard `. scriptname'. I
> can correct that before commit after you review the changes to make
> sure that they functionally make sense.
>
> Thanks!
> -Garrett
>   


Garrett, you can add my Acked-by: Casey Schaufler <casey@schaufler-ca.com>
to your updates for ltp.

Thank you.



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
