Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1M7OcV-0001RF-F4
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 06:52:43 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M7OcR-0007k0-Vd
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 06:52:43 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e8.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n4M6gU63007912
	for <ltp-list@lists.sourceforge.net>; Fri, 22 May 2009 02:42:30 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n4M6qdtI232594
	for <ltp-list@lists.sourceforge.net>; Fri, 22 May 2009 02:52:39 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n4M6oamK019241
	for <ltp-list@lists.sourceforge.net>; Fri, 22 May 2009 02:50:36 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090521.125817.183039017.caiqian@cclom.cn>
References: <d51f89b0905072329u1d7d2e34j1fb95b09f347bf1a@mail.gmail.com>
	<20090511.200555.226785908.caiqian@cclom.cn>
	<d51f89b0905190257t4505860ej1461b32ad789e96@mail.gmail.com>
	<20090521.125817.183039017.caiqian@cclom.cn>
Date: Fri, 22 May 2009 12:22:25 +0530
Message-Id: <1242975146.8760.13.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Patch for "File" test case issue of 30-April-2009 release
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
To: rohit verma <rohit.170309@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, 2009-05-21 at 12:58 +0800, CAI Qian wrote: 
> From: rohit verma <rohit.170309@gmail.com>
> Subject: Re: Patch for [LTP] "File" test case issue of 30-April-2009 release
> Date: Tue, 19 May 2009 02:57:56 -0700
> 
> > Dear Qian,
> > 
> > As rpmbuild path is differenet for FC10 and RHEL, I have fixed the build
> > path using following option
> > 
> >  rpmbuild --define "_topdir  <builddirectory>"
> > 
> >  builddirectory mentioned as /usr/src/redhat in test program
> > 
> > I have attached patch with this mail. I request you to check the patch
> > description  for more details and let me know if any issues.
> > 
> > Note:  I have run checkpatch.pl script on this patch and there no errors and
> > warnings.

Merged.

> >
> 
> Acked-by: CAI Qian <caiqian@cclom.cn>

Thanks.

Regards--
Subrata

> 
> > Regards,
> > Rohit
> > 
> > On Mon, May 11, 2009 at 5:05 AM, CAI Qian <caiqian@cclom.cn> wrote:
> > 
> >> From: rohit verma <rohit.170309@gmail.com>
> >> Subject: Patch for [LTP] "File" test case issue of 30-April-2009 release
> >> Date: Fri, 8 May 2009 11:59:35 +0530
> >>
> >> > Dear Qian,
> >> >
> >> > Patch for "file" test case is attached with this mail.
> >> >
> >> > I have changed build directory from "/usr/src/redhat" to "$HOME/rpmbuild"
> >> at
> >> > line no.
> >> >
> >> > 394 in "ltp-full-20090430/testcases/commands/ade/file/file_test.sh"
> >> >
> >> > With these modification test case pass for any user.
> >> >
> >> > Please confirm if this solution is OK.
> >> >
> >>
> >>  $LTPBIN/tst_resm TINFO "TEST #9: file command recognizes RPM files"
> >>  if [ -f /etc/redhat-release ]; then
> >> -       bDIR=/usr/src/redhat
> >> +       bDIR=$HOME/rpmbuild
> >>        bCMD=rpmbuild
> >>  else
> >>        bDIR=/usr/src/packages
> >>
> >> This will not work for systems like RHEL, which are using the default
> >> buildroot in /usr/src/redhat. You can also tell rpmbuild command to use
> >> an user specified buildroot like this,
> >>
> >> rpmbuild --buildroot=$HOME/rpmbuild
> >>
> >> CAI Qian
> >>
> >> >
> >> > Regards,
> >> > rohit
> >> >
> >> >
> >> >
> >> > On Thu, May 7, 2009 at 1:03 PM, CAI Qian <caiqian@cclom.cn> wrote:
> >> >
> >> >> From: rohit verma <rohit.170309@gmail.com>
> >> >> Subject: [LTP] "File" test case issue with Fedoracore10 in 31-March-2009
> >> >> release
> >> >> Date: Mon, 4 May 2009 10:59:54 +0530
> >> >>
> >> >> > Hi,
> >> >> >
> >> >> > O/P of 'File' test case  with fedora core-10 as follows
> >> >> >
> >> >> > *file01      0  INFO  :  TEST #1: file commad recogizes ASCII text
> >> files
> >> >> > file01      7  PASS  :  file: Recognised ASCII file correctly
> >> >> > file02      0  INFO  :  TEST #2: file command recognizes bash shell
> >> >> scripts
> >> >> > file02      2  PASS  :  file: Recognised bash shell script correctly
> >> >> > file03      0  INFO  :  TEST #3: file command recognizes korn shell
> >> >> scripts
> >> >> > file03      3  PASS  :  file: recognised korn shell script
> >> >> > file04      0  INFO  :  TEST #4: file command recognizes C shell
> >> scripts
> >> >> > file04      4  PASS  :  file: Recognised C shell script correctly
> >> >> > file05      0  INFO  :  TEST #5: file command recognizes C programs
> >> text
> >> >> > file05      5  PASS  :  file: Recognised C program text correctly
> >> >> > file06      0  INFO  :  TEST #6: file command recognizes ELF
> >> executables
> >> >> > file06      6  PASS  :  file: Recognized ELF binary executable
> >> >> > file07      0  INFO  :  TEST #7: file command recognizes tar files.
> >> >> > file07      7  PASS  :  file: Recognised tar files
> >> >> > file08      0  INFO  :  TEST #8: file command recognizes tar zip files
> >> >> > file08      8  PASS  :  file: Recognised tar zip file
> >> >> > file09      0  INFO  :  TEST #9: file command recognizes RPM files
> >> >> > file09      9  BROK  :  rpm command brok. Reason:
> >> >> > error: File /root/rpmbuild/SOURCES/cprog.c: No such file or directory
> >> >> > file09     10  BROK  :  Remaining cases broken
> >> >> > file09      9  FAIL  :  file: Failed to Recognize RPM file. Reason:
> >> >> > /usr/src/redhat/SRPMS/cprog-0.0.7-3.src.rpm: cannot open
> >> >> > `/usr/src/redhat/SRPMS/cprog-0.0.7-3.src.rpm' (No such file or
> >> directory)
> >> >> > file10      0  INFO  :  TEST #10: file command recognizes vmlinuz file
> >> >> > file10     10  PASS  :  file: Recognised vmlinuz file correctly *
> >> >> > **
> >> >> >
> >> >> > Default path for 'rpmbuild' command in fc10  is /root/rpmbuild/SOURCES
> >> >> > folder instead of  "/usr/src/redhat" which was present in fc8
> >> rpmbuild.
> >> >> >
> >> >> > In FC10 rpmbuild looks for the cprog.c file  in user's home directory.
> >> >> (i.e
> >> >> > /root/rpmbuild  for root user)
> >> >> >
> >> >> > Please visit the below URL for more information
> >> >> >
> >> >> > http://www.mail-archive.com/fedora-list@redhat.com/msg27958.html
> >> >> >
> >> >> > As per the 'file' test program, it creates the 'cprog.c' file in
> >> >> > /usr/src/redhat and recognize RPM file in same path
> >> >> > which should be changed accordingly to user's home directory.
> >> >> >
> >> >> > Please check the  line number 394 : bDIR=/usr/src/redhat. in
> >> >> file_tests.sh
> >> >> >
> >> >> > So I request you to incorporate the changes according to rpmbuild of
> >> fc10
> >> >> in
> >> >> > file_tests.sh.
> >> >> >
> >> >> > Regards,
> >> >> > rohit
> >> >> >
> >> >>
> >> >> Yes, you are correct. Perhaps we can use,
> >> >>
> >> >> rpmbuild --buildroot=/usr/src/redhat
> >> >>
> >> >> to override the default setting?
> >> >>
> >> >> CAI Qian
> >> >>
> >>
> 
> ------------------------------------------------------------------------------
> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
> is a gathering of tech-side developers & brand creativity professionals. Meet
> the minds behind Google Creative Lab, Visual Complexity, Processing, & 
> iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
> Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
