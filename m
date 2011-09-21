Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <prvs=8245b581d5=G.Rajender@lnties.com>)
	id 1R6GJ3-0003PZ-OR
	for ltp-list@lists.sourceforge.net; Wed, 21 Sep 2011 06:29:17 +0000
Received: from mailout2.ltindia.com ([125.18.18.171])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1R6GJ1-0001n0-6Q
	for ltp-list@lists.sourceforge.net; Wed, 21 Sep 2011 06:29:17 +0000
From: G Rajender <G.Rajender@lnties.com>
Date: Wed, 21 Sep 2011 06:28:58 +0000
Message-ID: <260174ADA4D63F4AA543B9C81F2DE71247156D@POCITMSEXMB02.LntUniverse.com>
References: <260174ADA4D63F4AA543B9C81F2DE7124714C8@POCITMSEXMB02.LntUniverse.com>,
	<1316539785.4441.6.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1316539785.4441.6.camel@subratamodak.linux.ibm.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] Cross Compiling LTP for Android platform
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi,

Thank you for your reply and support.

I have checked for the strip with commands suggested by you.
# which strip
/usr/bin/strip

# rpm -qf /usr/bin/strip
"file /usr/bin/strip is not owned by any package"

I think strip not owned by any package....

How to modify or configure my arm-linux-androideabi- strip binutils.

Any suggestions please......

Thanks
Rajender.G

________________________________________
From: Subrata Modak [subrata@linux.vnet.ibm.com]
Sent: Tuesday, September 20, 2011 10:59 PM
To: G Rajender
Cc: ltp-list@lists.sourceforge.net
Subject: Re: [LTP] Cross Compiling LTP for Android platform

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



Larsen & Toubro Limited

www.larsentoubro.com

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

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
