Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XwT8v-0000t4-GD
	for ltp-list@lists.sourceforge.net; Thu, 04 Dec 2014 09:56:13 +0000
Date: Thu, 4 Dec 2014 10:55:59 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141204095559.GA15326@rei.suse.de>
References: <000d01d00f87$a9f6a6a0$fde3f3e0$@samsung.com>
	<20141204083436.GA4391@rei.suse.de>
	<002f01d00fa3$8d225df0$a76719d0$@samsung.com>
	<20141204092723.GA15044@rei.suse.de>
	<003001d00fa7$aeec4820$0cc4d860$@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <003001d00fa7$aeec4820$0cc4d860$@samsung.com>
Subject: Re: [LTP] Need help to compile LTP
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
To: Raju <raju.biswas@samsung.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> When we type ./configure --help=sort
> 
> We get list of help for ./configure 
> 
>   --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
>   --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
> 
>   --disable-option-checking  ignore unrecognized --enable/--with options
>   --disable-FEATURE       do not include FEATURE (same as
> --enable-FEATURE=no)
>   --enable-FEATURE[=ARG]  include FEATURE [ARG=yes]
> 
> Are you aware of how do you use these option along with ./configure and how
> does all the above option help.

All the possibilities are listed in the help as well, see for yourself:

...
  --with-power-management-testsuite
                          compile and install the x86 power management
                          testsuite (default=no)
  --with-open-posix-testsuite
                          compile and install the open posix testsuite
                          (default=no)
  --with-realtime-testsuite
                          compile and install the realtime testsuite
                          (default=no)
  --with-linux-version=VERSION
...


You cannot enable/disable single testcases or group of testcases from being
compiled this way. Only whole testsuites that are included in LTP.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
