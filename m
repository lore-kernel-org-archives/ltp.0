Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1NSqCI-0002rv-DY
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:06:34 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NSqCH-0000Ma-1n
	for ltp-list@lists.sourceforge.net; Thu, 07 Jan 2010 11:06:34 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e2.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o07AvIaG014484
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 05:57:18 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o07B6PVQ130472
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 06:06:25 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o07B6Ptr032088
	for <ltp-list@lists.sourceforge.net>; Thu, 7 Jan 2010 09:06:25 -0200
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <EB27E34D-BEAD-4BC3-AA0C-15AA4BA148B7@gmail.com>
References: <4B41F7FD.9040904@in.ibm.com>
	<EB27E34D-BEAD-4BC3-AA0C-15AA4BA148B7@gmail.com>
Date: Thu, 07 Jan 2010 16:36:16 +0530
Message-Id: <1262862376.12213.21.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix ld01 test
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
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Suzuki,

Please see this:
http://ltp.cvs.sf.net/viewvc/ltp/ltp/testcases/commands/ade/ld/ld01?view=log,

Regards--
Subrata

On Mon, 2010-01-04 at 18:04 -0800, Garrett Cooper wrote: 
> On Jan 4, 2010, at 6:15 AM, Suzuki Poulose <suzuki@in.ibm.com> wrote:
> 
> > Hi,
> >
> > Please find the patch to fix the "ld" test.  I wonder these tests  
> > were ever tested before committing to the suite !
> >
> > On SLES 11 SP1, I get :
> >
> > plm66:/ltp-full-20091130/testcases/commands/ade/ld # make
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -fPIC - 
> > I../../../../include -I../../../../include  -c -o d1.o d1.c
> > mv d1.o d1.obj
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -fPIC - 
> > I../../../../include -I../../../../include  -c -o f1.o f1.c
> > mv f1.o f1.obj
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -fPIC - 
> > I../../../../include -I../../../../include  -c -o ldmain.o ldmain.c
> > mv ldmain.o ldmain.obj
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -fPIC - 
> > I../../../../include -I../../../../include  -c -o rd1.o rd1.c
> > mv rd1.o rd1.obj
> > gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -fPIC - 
> > I../../../../include -I../../../../include  -c -o rf1.o rf1.c
> > mv rf1.o rf1.obj
> > plm66:/ltp-full-20091130/testcases/commands/ade/ld # ./ld01
> > Assertion 1 ..................
> > -)
> > Assertion 2 ..................
> > -)
> > Assertion 3 ..................
> > -)
> > Assertion 4 ..................
> > -)
> > Assertion 5 ..................
> > ld: /ltp-full-20091130/testcases/commands/ade/ld/f1.o: No such file:  
> > No such file or directory
> > FAIL - ld failed to build a shared object
> >
> >
> > The names used for the object files are not consistent across the  
> > Makefile and the script.
> >
> > Also the method of detecting the ld version is bogus. It will not  
> > work for *all* distros.
> >
> > ./ld01: line 184: [: Public: integer expression expected
> > -)
> >
> >
> > Please find the attached patch which fixes the issue.
> >
> > Thanks
> > Suzuki
> > Signed-Off-by: Suzuki K P <suzuki@in.ibm.com>
> >
> > Issues fixed:
> >
> >    1) Consistency with the names used for object files in Makefile  
> > vs. script
> >    2) Better method for finding the version of "ld"
> >
> > --- ld01    2006-04-10 23:09:50.000000000 +0530
> > +++ ld01.new    2010-01-05 01:01:03.000000000 +0530
> > @@ -140,11 +140,11 @@ fi
> > ##
> > echo "Assertion 5 .................."
> >  # Check for ppc64 architecture
> > - file f1.o | grep PowerPC | grep 64-bit >/dev/null 2>&1
> > + file f1.obj | grep PowerPC | grep 64-bit >/dev/null 2>&1
> >  if [ $? -eq 0 ]; then
> > -    ld -m elf64ppc -shared $TCdat/f1.o $TCdat/d1.o -o $TCtmp/test.lib
> > +    ld -m elf64ppc -shared $TCdat/f1.obj $TCdat/d1.obj -o $TCtmp/ 
> > test.lib
> >  else
> > -    ld -shared $TCdat/f1.o $TCdat/d1.o -o $TCtmp/test.lib
> > +    ld -shared $TCdat/f1.obj $TCdat/d1.obj -o $TCtmp/test.lib
> >  fi
> > file $TCtmp/test.lib | grep -q shared
> > if [ $? -eq 0 ]
> > @@ -164,23 +164,29 @@ fi
> > echo "Assertion 6 .................."
> >
> > # Check for ppc64 architecture
> > - file f1.o | grep PowerPC | grep 64-bit >/dev/null 2>&1
> > + file f1.obj | grep PowerPC | grep 64-bit >/dev/null 2>&1
> >  if [ $? -eq 0 ]; then
> > -    ld -m elf64ppc -Bdynamic -shared $TCdat/f1.o $TCdat/d1.o -o  
> > $TCtmp/lola 2>$TCtmp/errmsg.out
> > -    ld -m elf64ppc -Bstatic  -L. $TCdat/ldmain.o $TCdat/rd1.o  
> > $TCtmp/lola -o $TCtmp/a.out 2> $TCtmp/errmsg.out
> > +    ld -m elf64ppc -Bdynamic -shared $TCdat/f1.obj $TCdat/d1.obj -o  
> > $TCtmp/lola 2>$TCtmp/errmsg.out
> > +    ld -m elf64ppc -Bstatic  -L. $TCdat/ldmain.obj $TCdat/rd1.obj  
> > $TCtmp/lola -o $TCtmp/a.out 2> $TCtmp/errmsg.out
> >  else
> > -    ld -Bdynamic -shared $TCdat/f1.o $TCdat/d1.o -o $TCtmp/lola 2> 
> > $TCtmp/errmsg.out
> > -    ld -Bstatic  -L. $TCdat/ldmain.o $TCdat/rd1.o $TCtmp/lola -o  
> > $TCtmp/a.out 2> $TCtmp/errmsg.out
> > +    ld -Bdynamic -shared $TCdat/f1.obj $TCdat/d1.obj -o $TCtmp/lola  
> > 2>$TCtmp/errmsg.out
> > +
> > +    ld -Bstatic  -L. $TCdat/ldmain.obj $TCdat/rd1.obj $TCtmp/lola - 
> > o $TCtmp/a.out 2> $TCtmp/errmsg.out
> >  fi
> > #nm $TCtmp/a.out | grep -q DYNAMIC
> > rc_code=$?
> >
> > -    version_num=`ld --version | grep version | \
> > -     awk -F ' ' '{ print $4 }' | cut -d '.' -f 1`
> > -
> > -    version_num_level2=`ld --version | grep version |\
> > -     awk -F ' ' '{ print $4 }' | cut -d '.' -f 2`
> > -
> > +#    This method doesn't work on all distro.
> > +#    version_num=`ld --version | grep version | \
> > +#     awk -F ' ' '{ print $4 }' | cut -d '.' -f 1`
> > +#
> > +#    version_num_level2=`ld --version | grep version |\
> > +#     awk -F ' ' '{ print $4 }' | cut -d '.' -f 2`
> > +#
> > +# Better way to get the version of ld
> > +# Search for a pattern that starts with <SPACE><DIGITS><DOT><DIGITS>
> > +version_num=`ld -v | sed "s/.*\ \([0-9]\+\)\.\([0-9]\+\).*/\1/"`
> > +version_num_level2=`ld -v | sed "s/.*\ \([0-9]\+\)\.\([0-9]\+\).*/ 
> > \2/"`
> > if [ "$version_num" -le "2"  -a "$version_num_level2" -le "15" ]; then
> >    if [ $rc_code -eq 0 ]
> >    then
> > @@ -214,8 +220,8 @@ if [ "$version_num" -le "2"  -a "$versio
> >
> >
> > echo "Assertion 7 .................."
> > -ld -Bdynamic -shared $TCdat/ldmain.o $TCdat/f1.o $TCdat/rf1.o -o  
> > $TCtmp/lola -L/usr/lib/
> > -ld -Bstatic -r  $TCdat/ldmain.o $TCdat/f1.o $TCdat/rf1.o $TCtmp/ 
> > lola -L/usr/lib/ 2> $TCtmp/errmsg.out
> > +ld -Bdynamic -shared $TCdat/ldmain.obj $TCdat/f1.obj $TCdat/rf1.obj  
> > -o $TCtmp/lola -L/usr/lib/
> > +ld -Bstatic -r  $TCdat/ldmain.obj $TCdat/f1.obj $TCdat/rf1.obj  
> > $TCtmp/lola -L/usr/lib/ 2> $TCtmp/errmsg.out
> > cat <<EOF > $TCtmp/errmsg.exp
> > $TCtmp/lola: could not read symbols: Invalid operation
> > EOF
> 
>      This was actually fixed a few weeks ago.. Please try again with  
> the version off cvs.
> Thanks!
> -Garrett
> 
> ------------------------------------------------------------------------------
> This SF.Net email is sponsored by the Verizon Developer Community
> Take advantage of Verizon's best-in-class app development support
> A streamlined, 14 day to market process makes app distribution fast and easy
> Join now and get one step closer to millions of Verizon customers
> http://p.sf.net/sfu/verizon-dev2dev 
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


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
