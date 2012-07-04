Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jeff.science@gmail.com>) id 1SmXqk-0006NG-Vx
	for ltp-list@lists.sourceforge.net; Wed, 04 Jul 2012 22:15:06 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SmXqj-00061T-TY
	for ltp-list@lists.sourceforge.net; Wed, 04 Jul 2012 22:15:06 +0000
Received: by yhjj56 with SMTP id j56so8528485yhj.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Jul 2012 15:15:00 -0700 (PDT)
MIME-Version: 1.0
From: Jeff Hammond <jhammond@alcf.anl.gov>
Date: Wed, 4 Jul 2012 17:14:38 -0500
Message-ID: <CAGKz=u+6VcdDMGyMq02ZkL3J-75TkSvyjQ78Jz2_UEHp_jgMjg@mail.gmail.com>
Subject: [LTP] present but cannot be compiled
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
To: ltp-list@lists.sourceforge.net

I'm trying to use LTP on Blue Gene/Q after being told that Open POSIX
Test was dead.  This is not a Linux kernel but is supposed to be
Linux-like and POSIX-compliant.  I am using GCC 4.4.6 and GNU
binutils.

What kind of information do you want to deal with these issues?

configure: WARNING: linux/genetlink.h: present but cannot be compiled
configure: WARNING: linux/genetlink.h:     check for missing
prerequisite headers?
configure: WARNING: linux/genetlink.h: see the Autoconf documentation
configure: WARNING: linux/genetlink.h:     section "Present But Cannot
Be Compiled"
configure: WARNING: linux/genetlink.h: proceeding with the preprocessor's result
configure: WARNING: linux/genetlink.h: in the future, the compiler
will take precedence
configure: WARNING:     ## --------------------------------------------- ##
configure: WARNING:     ## Report this to ltp-list@lists.sourceforge.net ##
configure: WARNING:     ## --------------------------------------------- ##
..
configure: WARNING: linux/netlink.h: present but cannot be compiled
configure: WARNING: linux/netlink.h:     check for missing prerequisite headers?
configure: WARNING: linux/netlink.h: see the Autoconf documentation
configure: WARNING: linux/netlink.h:     section "Present But Cannot
Be Compiled"
configure: WARNING: linux/netlink.h: proceeding with the preprocessor's result
configure: WARNING: linux/netlink.h: in the future, the compiler will
take precedence
configure: WARNING:     ## --------------------------------------------- ##
configure: WARNING:     ## Report this to ltp-list@lists.sourceforge.net ##
configure: WARNING:     ## --------------------------------------------- ##

Thanks,

Jeff

-- 
Jeff Hammond
Argonne Leadership Computing Facility
University of Chicago Computation Institute
jhammond@alcf.anl.gov / (630) 252-5381
http://www.linkedin.com/in/jeffhammond
https://wiki.alcf.anl.gov/parts/index.php/User:Jhammond

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
