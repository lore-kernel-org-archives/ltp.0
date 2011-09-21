Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1R6GSR-0003iR-T3
	for ltp-list@lists.sourceforge.net; Wed, 21 Sep 2011 06:38:59 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R6GSQ-0004Zq-Pl
	for ltp-list@lists.sourceforge.net; Wed, 21 Sep 2011 06:38:59 +0000
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p8L684iq024415
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Sep 2011 02:08:04 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8L6cj9v421776
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Sep 2011 02:38:49 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8L6ciBS006209
	for <ltp-list@lists.sourceforge.net>; Wed, 21 Sep 2011 02:38:45 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <260174ADA4D63F4AA543B9C81F2DE71247156D@POCITMSEXMB02.LntUniverse.com>
References: <260174ADA4D63F4AA543B9C81F2DE7124714C8@POCITMSEXMB02.LntUniverse.com>
	,<1316539785.4441.6.camel@subratamodak.linux.ibm.com>
	<260174ADA4D63F4AA543B9C81F2DE71247156D@POCITMSEXMB02.LntUniverse.com>
Date: Wed, 21 Sep 2011 12:08:44 +0530
Message-Id: <1316587124.4544.3.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Cross Compiling LTP for Android platform
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
To: G Rajender <G.Rajender@lnties.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Wed, 2011-09-21 at 06:28 +0000, G Rajender wrote:
> Hi,
> 
> Thank you for your reply and support.
> 
> I have checked for the strip with commands suggested by you.
> # which strip
> /usr/bin/strip
> 
> # rpm -qf /usr/bin/strip
> "file /usr/bin/strip is not owned by any package"

Install the Cross Compile Binutils of the target Arch in this machine.
Or, you can build the Target Arch Binutils in the source machine
provided you have the Binuitls source code.

So just like your 'arm-linux-androideabi-gcc' which shows up in
your /usr/bin/arm-linux-androideabi-gcc,

You will then have all the binaries of the Binutils package here:
/usr/bin/arm-linux-androideabi-stripe
/usr/bin/arm-linux-androideabi-ar
/usr/bin/arm-linux-androideabi-as
/usr/bin/arm-linux-androideabi-ld
/usr/bin/arm-linux-androideabi-nm
/usr/bin/arm-linux-androideabi-objdump

etc.

Regards--
Subrata

> 
> I think strip not owned by any package....
> 
> How to modify or configure my arm-linux-androideabi- strip binutils.
> 
> Any suggestions please......
> 
> Thanks
> Rajender.G
> 
> ________________________________________
> From: Subrata Modak [subrata@linux.vnet.ibm.com]
> Sent: Tuesday, September 20, 2011 10:59 PM
> To: G Rajender
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] Cross Compiling LTP for Android platform
> 
> On Tue, 2011-09-20 at 14:28 +0000, G Rajender wrote:
> > Hi,
> >
> > I am Cross Compiling LTP-20110228 using arm-linux-androideabi cross
> > toolchain.
> > Im getting the below errors
> >
> >
> > make[4]: Leaving directory
> > `/media/C0AA04ADAA04A250/ltp-full-20110228/testcases/commands/ade/nm'
> > make[4]: Entering directory
> > `/media/C0AA04ADAA04A250/ltp-full-20110228/testcases/commands/ade/objdump'
> > arm-linux-androideabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe
> > -Wall -g  -I../../../../include -I../../../../include  -c -o
> > test_arch.o test_arch.c
> > arm-linux-androideabi-gcc   -L../../../../lib  test_arch.o   -o
> > test_arch_debug
> > arm-linux-androideabi-gcc   -L../../../../lib  test_arch.o   -o
> > test_arch_stripped
> > strip test_arch_stripped
> > strip: Unable to recognise the format of the input file
> > `test_arch_stripped'
> 
> The Error lies here. Do you have 'strip' from the Cross-Architecture
> Binary Utils package. Apart from your GCC (which is from your GCC
> package), all the following packages should also be from your CROSS
> COMPILE ARCH:
> 
> Glibc
> Glibc-devel
> Binutils
> 
> If you see your 'strip' binary, probably it is still belonging to the
> machine arch on which you are compiling.
> 
> # which strip
> /usr/bin/strip
> 
> # rpm -qf /usr/bin/strip
> binutils-2.20.51.0.2-5.27.el6.ppc64
> 
> Check that out first.
> 
> Regards--
> Subrata
> 
> > make[4]: *** [test_arch_stripped] Error 1
> >
> > Any suggestion on this erros please......
> >
> > Thanks in advance.
> >
> > Regards
> >
> > Rajender.G
> >
> >
> >
> > Larsen & Toubro Limited
> >
> > www.larsentoubro.com
> >
> > This Email may contain confidential or privileged information for the
> > intended recipient (s) If you are not the intended recipient, please
> > do not use or disseminate the information, notify the sender and
> > delete it from your system.
> > ------------------------------------------------------------------------------
> > All the data continuously generated in your IT infrastructure contains a
> > definitive record of customers, application performance, security
> > threats, fraudulent activity and more. Splunk takes this data and makes
> > sense of it. Business sense. IT sense. Common sense.
> > http://p.sf.net/sfu/splunk-d2dcopy1
> > _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 
> 
> Larsen & Toubro Limited
> 
> www.larsentoubro.com
> 
> This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
> 


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2dcopy1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
