Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <zohar@us.ibm.com>) id 1Mn1sf-0007p0-Oz
	for ltp-list@lists.sourceforge.net; Mon, 14 Sep 2009 03:05:29 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mn1sZ-0006Fq-If
	for ltp-list@lists.sourceforge.net; Mon, 14 Sep 2009 03:05:29 +0000
In-Reply-To: <1252847784.5357.32.camel@subratamodak.linux.ibm.com>
References: <1252847784.5357.32.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Message-ID: <OF9CA4BE88.68C4CD88-ON85257631.000FA62E-85257631.0010F38E@us.ibm.com>
From: Mimi Zohar <zohar@us.ibm.com>
Date: Sun, 13 Sep 2009 23:05:08 -0400
Subject: Re: [LTP] [Testing 2.6.31] Minimal IMA policy and boot param for
	TCB IMA	policy
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
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sf.net>, James Morris <jmorris@namei.org>, Eric Paris <eparis@redhat.com>

Subrata Modak <subrata@linux.vnet.ibm.com> wrote on 09/13/2009 09:16:22 
AM:

> Hi Mimi,
> 
> I remember talking to you for IMA test cases evaluation during 2.6.30
> release. Now, with the above changes in IMA policies under 2.6.31
> kernel, would you like to submit some fresh patches for the LTP IMA test
> cases ?
> 
> Regards--
> Subrata 

Subrata,

The default IMA policy of 2.6.30 is enabled in 2.6.31 with the kernel
boot parameter 'ima_tcb=1'.  The dependency section of the LTP 
testcases/kernel/security/integrity/ima/README should be updated to
reflect this change.  I'll post a patch with this change.

Mimi

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
