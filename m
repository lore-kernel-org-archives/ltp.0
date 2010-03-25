Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NuqRJ-0002Ce-8g
	for ltp-list@lists.sourceforge.net; Thu, 25 Mar 2010 17:01:49 +0000
Received: from mail-fx0-f221.google.com ([209.85.220.221])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NuqRI-0006QT-BN
	for ltp-list@lists.sourceforge.net; Thu, 25 Mar 2010 17:01:49 +0000
Received: by fxm21 with SMTP id 21so6236496fxm.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Mar 2010 10:01:42 -0700 (PDT)
References: <E0B6230F32558E43951AF1B0DEBF98102119D5A01E@EUSAACMS0714.eamcs.ericsson.se>
	<1269499707.6264.3.camel@subratamodak.linux.ibm.com>
Message-Id: <BF2906F0-38C4-40A7-B6E8-E716C1F322A9@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1269499707.6264.3.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0 (iPhone Mail 7E18)
Date: Thu, 25 Mar 2010 10:01:32 -0700
Subject: Re: [LTP] Running LTP test suite against modified kernel
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
To: "subrata@linux.vnet.ibm.com" <subrata@linux.vnet.ibm.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>, Anthony Ton <anthony.ton@ericsson.com>

On Mar 24, 2010, at 11:48 PM, Subrata Modak  
<subrata@linux.vnet.ibm.com> wrote:

> On Wed, 2010-03-24 at 18:46 -0400, Anthony Ton wrote:
>> Hello LTP team,
>> Will the compilation of LTP test suites be independent of the OS
>> kernel libraries?  Basically if I compiled the LTP on standard Linux
>> OS and then run against the modified Linux OS kernel, would LTP test
>> suites be able to run?  Or do I need to compile LTP and link with the
>> modified OS kernel libraries?
>
> It should run perfectly well without recompilation even if you had
> rebooted in a new (and much lateest) kernel version. Since LTP talks  
> to
> kernel only through the GLIBC, AIO and other user space libraries, so,
> until they are intact in the system, LTP will just run fine. Now, how
> the user space libraries will interact with the new kernel is a
> different ballgame altogether

There are some kernel modules in ltp which aren't part of the default  
set which wouldn't function on the new kernel.

Also if there is an ABI mismatch between the libs on machine A and  
machine B, you will have to recompile ltp or you will get potentially  
nondeterministic results..

-Garrett
>>

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
