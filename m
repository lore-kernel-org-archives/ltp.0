Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NGcSA-0002NC-O8
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 18:00:26 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NGcS3-0005Jw-4z
	for ltp-list@lists.sourceforge.net; Fri, 04 Dec 2009 18:00:26 +0000
From: Jiri Palecek <jpalecek@web.de>
Date: Fri, 4 Dec 2009 19:00:14 +0100
References: <000001ca69a6$d6ad7520$84085f60$@co.jp>
	<364299f40911192224i127c4b87qf0f7777ae0a8377d@mail.gmail.com>
In-Reply-To: <364299f40911192224i127c4b87qf0f7777ae0a8377d@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200912041900.14388.jpalecek@web.de>
Subject: Re: [LTP] move_pages test failed in ltp-2009-11-19.tar.gz
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
Cc: ltp-list@lists.sourceforge.net, Mitani <mitani@ryobi.co.jp>

On Friday 20 November 2009 07:24:29 Garrett Cooper wrote:
> On Thu, Nov 19, 2009 at 10:00 PM, Mitani <mitani@ryobi.co.jp> wrote:
> > Hi,
> >
> > When I ran LTP in RHEL5.4 using ltp-2009-11-19.tar.gz,
> > "move_pages03" and "move_pages11" were failed in each of "syscalls" and
> > "numa" tests like that:
> >
> > ------------
> > move_pages01    1  TCONF  :  NUMA support not provided
> > move_pages02    1  TCONF  :  NUMA support not provided
> > chown: cannot access `move_pages03': No such file or directory
> > move_pages04    1  TCONF  :  NUMA support not provided
> > move_pages05    1  TCONF  :  NUMA support not provided
> > move_pages06    1  TCONF  :  NUMA support not provided
> > move_pages07    1  TCONF  :  NUMA support not provided
> > move_pages08    1  TCONF  :  NUMA support not provided
> > move_pages09    1  TCONF  :  NUMA support not provided
> > move_pages10    1  TCONF  :  NUMA support not provided
> > chown: cannot access `move_pages11': No such file or directory
> > ------------
> >
> >
> > These fails didn't occured with ltp-full-20090930.tgz, but they occured
> > with ltp-full-20091031.tgz.
> > With ltp-full-20090930.tgz, all of move_pagesXX (XX:01-11) were passed
> > (NUMA support not provided) in my system.
> >
> >
> > I compared these version and found out following scenarios changed.
> >  - ${LTPROOT}/runtest/numa
> >  - ${LTPROOT}/runtest/syscalls
> >
> >
> > These scenarios are as follows, and "move_pages03" and "move_pages01"
> > are revised.
> >
> > ------------
> > # cat ./runtest/numa
> > Numa-testcases numa01.sh
> > move_pages01 move_pages.sh 01
> > move_pages02 move_pages.sh 02
> > move_pages03 cd $LTPROOT/bin && chown root move_pages03 && chmod 04755 &&
> > move_pages.sh 03
> > move_pages04 move_pages.sh 04
> > move_pages05 move_pages.sh 05
> > move_pages06 move_pages.sh 06
> > move_pages07 move_pages.sh 07
> > move_pages08 move_pages.sh 08
> > move_pages09 move_pages.sh 09
> > move_pages10 move_pages.sh 10
> > move_pages11 cd $LTPROOT/bin && chown root move_pages11 && chmod 04755 &&
> > move_pages.sh 11
> > # cat ./runtest/syscalls | grep move_page
> > move_pages01 move_pages.sh 01
> > move_pages02 move_pages.sh 02
> > move_pages03 cd $LTPROOT/bin && chown root move_pages03 && chmod 04755 &&
> > move_pages.sh 03
> > move_pages04 move_pages.sh 04
> > move_pages05 move_pages.sh 05
> > move_pages06 move_pages.sh 06
> > move_pages07 move_pages.sh 07
> > move_pages08 move_pages.sh 08
> > move_pages09 move_pages.sh 09
> > move_pages10 move_pages.sh 10
> > move_pages11 cd $LTPROOT/bin && chown root move_pages11 && chmod 04755 &&
> > move_pages.sh 11
> > #------------
> >
> >
> > I think there are two problems in each changes:
> >
> >  - "move_pagesXX" files are in "$LTPROOT/testcases/bin" direcotory,
> >    not in "$LTPROOT/bin" directory.
> >  - "chmod" commands don't have target file.
> >
> >
> > I don't know why these revisions are done. But if these revisions should
> > be validated, they will come to work in the change like following, I think.
> > I wish I can get opinion whether my revision is right or not.
> >
> > ============
> >
> > --- syscalls    2009-11-18 13:24:34.000000000 +0900
> > +++ syscalls.new        2009-11-19 16:15:13.000000000 +0900
> > @@ -571,7 +571,7 @@
> >
> >  move_pages01 move_pages.sh 01
> >  move_pages02 move_pages.sh 02
> > -move_pages03 cd $LTPROOT/bin && chown root move_pages03 && chmod 04755 &&
> > move_pages.sh 03
> > +move_pages03 cd $LTPROOT/testcases/bin && chown root move_pages03 && chmod
> > 04755 move_pages.sh && move_pages.sh 03
> >  move_pages04 move_pages.sh 04
> >  move_pages05 move_pages.sh 05
> >  move_pages06 move_pages.sh 06
> > @@ -579,7 +579,7 @@
> >  move_pages08 move_pages.sh 08
> >  move_pages09 move_pages.sh 09
> >  move_pages10 move_pages.sh 10
> > -move_pages11 cd $LTPROOT/bin && chown root move_pages11 && chmod 04755 &&
> > move_pages.sh 11
> > +move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod
> > 04755 move_pages.sh && move_pages.sh 11
> >
> >  mprotect01 mprotect01
> >  mprotect02 mprotect02
> >
> > --- numa        2009-11-18 13:24:34.000000000 +0900
> > +++ numa.new    2009-11-19 16:15:33.000000000 +0900
> > @@ -1,7 +1,7 @@
> >  Numa-testcases numa01.sh
> >  move_pages01 move_pages.sh 01
> >  move_pages02 move_pages.sh 02
> > -move_pages03 cd $LTPROOT/bin && chown root move_pages03 && chmod 04755 &&
> > move_pages.sh 03
> > +move_pages03 cd $LTPROOT/testcases/bin && chown root move_pages03 && chmod
> > 04755 move_pages.sh && move_pages.sh 03
> >  move_pages04 move_pages.sh 04
> >  move_pages05 move_pages.sh 05
> >  move_pages06 move_pages.sh 06
> > @@ -9,4 +9,4 @@
> >  move_pages08 move_pages.sh 08
> >  move_pages09 move_pages.sh 09
> >  move_pages10 move_pages.sh 10
> > -move_pages11 cd $LTPROOT/bin && chown root move_pages11 && chmod 04755 &&
> > move_pages.sh 11
> > +move_pages11 cd $LTPROOT/testcases/bin && chown root move_pages11 && chmod
> > 04755 move_pages.sh && move_pages.sh 11
> >
> > ============
> >
> >
> > In addition, please teach why this revision was performed, if all right.
> >  - Why do only "move_pages03" and "move_pages11" appoint another directory
> >    not a current directory?
> >  - Why "chmod" is needed?
> 
> Mitani-san,
>     Good catch ><... I made some really silly clerical errors in my
> commits for these runtest files.
>     To answer your questions though:
>     1. I did the cd to ensure that pan is in a consistent location
> when it does the chmod and to avoid having to do
> "$LTPROOT/testcases/bin/move_pages{03,11}".
>     2. The chmod and chown to fix the ownership and to enable the
> sticky bit are being done because the test does seteuid, IIRC. What I
> did was moved the logic from a `build time fix' to a `run time fix',
> especially because the build user may not be root, and thus couldn't
> set the sticky bit for the binary.

Garrett,

can you please point me to a specific reason why this is needed, because I can't see anything that would need it in the test. Note that calling seteuid() [I can't find this in the code] doesn't mean the file has to be setuid-root. The only case where it would matter, would be when the code would drop root and then exec() move_pages{03,11}.

I think it would be good to drop the chown altogether, if there isn't a compelling reason against it. For one thing, you cannot do chown if you install the tests to a read-only filesystem and run them from there, for another, making any file suid-root is a tricky thing security-wise.

I haven't got any NUMA machine, so I cannot properly test these, anybody who can, please check if removing the cd, chmod and chown commands from the runtest file doesn't break anything. Post the results if possible.

Regards
    Jiri Palecek

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
