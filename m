Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1R64AD-0005VF-Tw
	for ltp-list@lists.sourceforge.net; Tue, 20 Sep 2011 17:31:21 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1R64AC-0006Pm-7W
	for ltp-list@lists.sourceforge.net; Tue, 20 Sep 2011 17:31:21 +0000
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e5.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p8KH0NFG026289
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Sep 2011 13:00:27 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p8KHVAtF224348
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Sep 2011 13:31:10 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p8KDUI6w004569
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Sep 2011 10:30:18 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <260174ADA4D63F4AA543B9C81F2DE7124714C8@POCITMSEXMB02.LntUniverse.com>
References: <260174ADA4D63F4AA543B9C81F2DE7124714C8@POCITMSEXMB02.LntUniverse.com>
Date: Tue, 20 Sep 2011 22:59:45 +0530
Message-Id: <1316539785.4441.6.camel@subratamodak.linux.ibm.com>
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

On Tue, 2011-09-20 at 14:28 +0000, G Rajender wrote:
> Hi,
> 
> I am Cross Compiling LTP-20110228 using arm-linux-androideabi cross
> toolchain.
> Im getting the below errors
> 
> 
> make[4]: Leaving directory
> `/media/C0AA04ADAA04A250/ltp-full-20110228/testcases/commands/ade/nm'
> make[4]: Entering directory
> `/media/C0AA04ADAA04A250/ltp-full-20110228/testcases/commands/ade/objdump'
> arm-linux-androideabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe
> -Wall -g  -I../../../../include -I../../../../include  -c -o
> test_arch.o test_arch.c
> arm-linux-androideabi-gcc   -L../../../../lib  test_arch.o   -o
> test_arch_debug
> arm-linux-androideabi-gcc   -L../../../../lib  test_arch.o   -o
> test_arch_stripped
> strip test_arch_stripped
> strip: Unable to recognise the format of the input file
> `test_arch_stripped'

The Error lies here. Do you have 'strip' from the Cross-Architecture
Binary Utils package. Apart from your GCC (which is from your GCC
package), all the following packages should also be from your CROSS
COMPILE ARCH:

Glibc
Glibc-devel
Binutils

If you see your 'strip' binary, probably it is still belonging to the
machine arch on which you are compiling.

# which strip
/usr/bin/strip

# rpm -qf /usr/bin/strip
binutils-2.20.51.0.2-5.27.el6.ppc64

Check that out first.

Regards--
Subrata

> make[4]: *** [test_arch_stripped] Error 1
> 
> Any suggestion on this erros please......
> 
> Thanks in advance.
> 
> Regards
> 
> Rajender.G
> 
> 
> 
> Larsen & Toubro Limited 
> 
> www.larsentoubro.com 
> 
> This Email may contain confidential or privileged information for the
> intended recipient (s) If you are not the intended recipient, please
> do not use or disseminate the information, notify the sender and
> delete it from your system. 
> ------------------------------------------------------------------------------
> All the data continuously generated in your IT infrastructure contains a
> definitive record of customers, application performance, security
> threats, fraudulent activity and more. Splunk takes this data and makes
> sense of it. Business sense. IT sense. Common sense.
> http://p.sf.net/sfu/splunk-d2dcopy1
> _______________________________________________ Ltp-list mailing list Ltp-list@lists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list


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
