Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <oberpar@linux.vnet.ibm.com>) id 1XTtrY-0000Ns-NO
	for ltp-list@lists.sourceforge.net; Tue, 16 Sep 2014 14:36:12 +0000
Received: from e06smtp12.uk.ibm.com ([195.75.94.108])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XTtrW-00065W-50
	for ltp-list@lists.sourceforge.net; Tue, 16 Sep 2014 14:36:12 +0000
Received: from /spool/local
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <oberpar@linux.vnet.ibm.com>; 
	Tue, 16 Sep 2014 15:36:03 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
	(d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id C8DA517D8045
	for <ltp-list@lists.sourceforge.net>;
	Tue, 16 Sep 2014 15:38:03 +0100 (BST)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
	[9.149.37.250])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id s8GEa0qu39846026
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Sep 2014 14:36:00 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with
	ESMTP id s8GEZxve029555
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Sep 2014 08:35:59 -0600
Message-ID: <54184ACE.3080200@linux.vnet.ibm.com>
Date: Tue, 16 Sep 2014 16:35:58 +0200
From: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <CAOi2z=w4wLnZ_8Uf9226G5n_nXwE4DQKgd=BKqn1PWSnWgdMOg@mail.gmail.com>
	<CAOi2z=xF76SVQZ+-pGJevr8BiSXVh4O9jVYGnfJ2kOU-Gne6HA@mail.gmail.com>
In-Reply-To: <CAOi2z=xF76SVQZ+-pGJevr8BiSXVh4O9jVYGnfJ2kOU-Gne6HA@mail.gmail.com>
Subject: Re: [LTP] Questions about gcov/lcov and Fortran 90
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
To: Christophe Taillan <taillanchristophe@gmail.com>, ltp-list@lists.sourceforge.net

On 14.09.2014 14:27, Christophe Taillan wrote:
> I am currently using gcov/lcov to study coverage of a large Fortran 90
> code. The goal is to find and erase unused code.
> Due to the size of the program, I'm looking for a way to automatize the
> process.
> 
> But I've got some trouble :
>    -  with nested "if": if the main condition is not validated, all the
> code in the "if" block should be tagged as "####", in fact, it seems
> that other "if" lines are not... 
>    -  lines read once seems not to be tagged as "1",
>    -  lines like "use some_module" are not tagged either.
> 
> So my question is, is there any existing tools to manage with these
> problems or did I miss any option in gcov?

gcov can only report coverage data for lines for which GCC generated
actual code. While I don't have any experience with Fortran 90, my guess
would be that "use some_module" does not actually generate code.

Also turning off all optimization options when compiling the code in
question can help improve the accuracy of gcov/lcov. See also:

https://gcc.gnu.org/onlinedocs/gcc/Gcov-Intro.html


Regards,
  Peter Oberparleiter

-- 
Peter Oberparleiter
Linux on System z Development - IBM Germany


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce.
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
