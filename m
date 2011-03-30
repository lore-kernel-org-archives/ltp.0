Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q4szC-00052l-2g
	for ltp-list@lists.sourceforge.net; Wed, 30 Mar 2011 10:50:50 +0000
Date: Wed, 30 Mar 2011 13:13:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110330111354.GA29707@saboteur.suse.cz>
References: <4D901425.2020803@tataelxsi.co.in>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D901425.2020803@tataelxsi.co.in>
Subject: Re: [LTP] Error with Device driver tests in LTP
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
To: Tijo <tijotj@tataelxsi.co.in>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  I'm new to the LTP mailing list and I'm facing a problem while
> running the device driver tests in LTP. When I try to make the acpi
> driver in LTP, I'm getting an error as
> 
> make -C /lib/modules/2.6.32.TEL-0.7-default/build SUBDIRS=/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi
> modules
> make[1]: Entering directory `/usr/src/linux-2.6.32.12-0.7'
>  CC [M]  /root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.o
> /root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c:
> In function ltpdev_ioctl:
> /root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c:188:
> warning: passing argument 2 of acpi_get_object_info from
> incompatible pointer type
> /root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.c:369:
> *error: implicit declaration of function acpi_get_register*
> make[2]: *** [/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi/LtpAcpiCmds.o]
> Error 1
> make[1]: *** [_module_/root/tijo/LTP-docs/ltp-full-20110228/testcases/kernel/device-drivers/acpi]
> Error 2
> make[1]: Leaving directory `/usr/src/linux-2.6.32.12-0.7'
> make: *** [default] Error 2
> 
> please help on how to solve this problem

The source code says that last update was for kernel 2.6.28, that is
aprox. 2 years old, most likely the acpi api has changed since then.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
