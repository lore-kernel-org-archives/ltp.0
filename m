Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NV44n-0006kZ-JX
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 14:20:01 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NV44m-0006AT-K6
	for ltp-list@lists.sourceforge.net; Wed, 13 Jan 2010 14:20:01 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <87babb031001120135h17a8e5ddwda507ceb794d31af@mail.gmail.com>
References: <87babb031001120135h17a8e5ddwda507ceb794d31af@mail.gmail.com>
Date: Wed, 13 Jan 2010 19:49:29 +0530
Message-Id: <1263392369.5591.30.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] LTP help
Reply-To: subrata@linux.vnet.ibm.com
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
To: Mihaly Sagi <sagimihaly@gmail.com>
Cc: ltp-list <ltp-list@lists.sf.net>

Hi,

On Tue, 2010-01-12 at 10:35 +0100, Mihaly Sagi wrote: 
> Dear Mr. Subrata,
> 
> I am a 4th year college student from the Faculty of Technical Sciences
> in Novi Sad, Serbia.
> As a project of ours, we are making a simple linux derivation from the
> 2.6.28-11 vanila kernel, to understand the basics of operating
> systems.
> For now, we have just taken out the basic parts of linux: kernel, mm,
> block, fs, tty, ttyS, lpt, SCSI (for the sata disk, but only RAMFS for
> now) without any modifications.
> (and of course no user space)
> 
> I would like to ask you for a bit of help.
> We would like to set up LTP to test the simple OS we made, but we
> don`t know how. Can you provide some kind of help, guide or tutorial?
> Or tell me if there is a possibility to set it up?
> The tests will pass of course, but the next phase of our project is to
> change the source code we copied and it will need testing.

Download the code from: http://ltp.sourceforge.net/, untar it. Then see
the instructions to build, install, run and interpreting the results
inside the following file:

     1. ltp/README* 
     2. ltp/INSTALL

Do share your investigation with us.

Regards--
Subrata

> 
> Sincerely,


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
