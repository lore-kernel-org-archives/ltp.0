Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SoncE-0005ab-Gw
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 03:29:26 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SoncB-00044T-51
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 03:29:26 +0000
Message-ID: <4FFCF2F3.6000504@cn.fujitsu.com>
Date: Wed, 11 Jul 2012 11:28:51 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <CAGKz=u+6VcdDMGyMq02ZkL3J-75TkSvyjQ78Jz2_UEHp_jgMjg@mail.gmail.com>
In-Reply-To: <CAGKz=u+6VcdDMGyMq02ZkL3J-75TkSvyjQ78Jz2_UEHp_jgMjg@mail.gmail.com>
Subject: Re: [LTP] present but cannot be compiled
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Jeff Hammond <jhammond@alcf.anl.gov>
Cc: ltp-list@lists.sourceforge.net

On 07/05/2012 06:14 AM, Jeff Hammond wrote:
> I'm trying to use LTP on Blue Gene/Q after being told that Open POSIX
> Test was dead.  This is not a Linux kernel but is supposed to be
> Linux-like and POSIX-compliant.  I am using GCC 4.4.6 and GNU
> binutils.
> 
> What kind of information do you want to deal with these issues?

If you just want to test open-posix, please just do

$ cd testcases/open_posix_testsuite/
$ make all

It's no need to compile the ltp part since it's not a Linux-like system,
and some headers may be not consistent with Linux.

Thanks,
Wanlong Gao

> 
> configure: WARNING: linux/genetlink.h: present but cannot be compiled
> configure: WARNING: linux/genetlink.h:     check for missing
> prerequisite headers?
> configure: WARNING: linux/genetlink.h: see the Autoconf documentation
> configure: WARNING: linux/genetlink.h:     section "Present But Cannot
> Be Compiled"
> configure: WARNING: linux/genetlink.h: proceeding with the preprocessor's result
> configure: WARNING: linux/genetlink.h: in the future, the compiler
> will take precedence
> configure: WARNING:     ## --------------------------------------------- ##
> configure: WARNING:     ## Report this to ltp-list@lists.sourceforge.net ##
> configure: WARNING:     ## --------------------------------------------- ##
> ..
> configure: WARNING: linux/netlink.h: present but cannot be compiled
> configure: WARNING: linux/netlink.h:     check for missing prerequisite headers?
> configure: WARNING: linux/netlink.h: see the Autoconf documentation
> configure: WARNING: linux/netlink.h:     section "Present But Cannot
> Be Compiled"
> configure: WARNING: linux/netlink.h: proceeding with the preprocessor's result
> configure: WARNING: linux/netlink.h: in the future, the compiler will
> take precedence
> configure: WARNING:     ## --------------------------------------------- ##
> configure: WARNING:     ## Report this to ltp-list@lists.sourceforge.net ##
> configure: WARNING:     ## --------------------------------------------- ##
> 
> Thanks,
> 
> Jeff
> 



------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
