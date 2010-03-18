Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Ns8Wq-0004ox-AK
	for ltp-list@lists.sourceforge.net; Thu, 18 Mar 2010 05:44:20 +0000
Received: from e36.co.us.ibm.com ([32.97.110.154])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ns8Wo-00082U-Up
	for ltp-list@lists.sourceforge.net; Thu, 18 Mar 2010 05:44:20 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2I5fG8N003704
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Mar 2010 23:41:16 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2I5iCUZ113198
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Mar 2010 23:44:12 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o2I5iCjm003105
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Mar 2010 23:44:12 -0600
Date: Thu, 18 Mar 2010 11:14:09 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100318054409.GA5977@linux.vnet.ibm.com>
References: <E0B6230F32558E43951AF1B0DEBF98102119CEC9EF@EUSAACMS0714.eamcs.ericsson.se>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E0B6230F32558E43951AF1B0DEBF98102119CEC9EF@EUSAACMS0714.eamcs.ericsson.se>
Subject: Re: [LTP] FW: LTP check_mqns_enable.c missing mqueue.h file
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
To: Anthony Ton <anthony.ton@ericsson.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>


Hi Anthony,

can you please try latest release which has been released yesterday  and let us
know the result. Then we can fix this fast if such problem is still there.

You can download it from here:
https://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20100228.1/ltp-full-20100228.1.tgz/download

Or You can clone through git also.

# git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp-dev.git ltp-dev

Thanks for reporting this failure.

-Rishi
>Hi,
>
>I am using the latest version of LTP ltp-full-20100228.  During make all, the
>compile check_mqns_enable.c complains "mqueue.h: No such file or directory."
>Could you please
>+tell me how to fix this?
>I am greatly appreciate your help.
>>
>Regards,
>Anthony Ton
>
>Error output:
>=========
>ar -rc "libclone.a" libclone.o
>ranlib "libclone.a"
>>make[5]: Leaving directory
`/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel/containers/libclone'
>>gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>-I/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel/include
>+-I/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel/containers/mqns/../libclone
>-I../../../../include -I../../../../include
>+-L/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel/containers/mqns/../libclone
>-L../../../../lib  check_mqns_enabled.c  -lpthread -lrt -lclone -lltp -o
>>+check_mqns_enabled
>In file included from check_mqns_enabled.c:25:
>mqns.h:5:20: mqueue.h: No such file or directory
>check_mqns_enabled.c: In function `main':
>check_mqns_enabled.c:35: error: `mqd_t' undeclared (first use in this function)
>>check_mqns_enabled.c:35: error: (Each undeclared identifier is reported only
>once
>check_mqns_enabled.c:35: error: for each function it appears in.)
>check_mqns_enabled.c:35: error: syntax error before "mqd"
>>check_mqns_enabled.c:40: warning: implicit declaration of function `mq_unlink'
>check_mqns_enabled.c:41: error: `mqd' undeclared (first use in this function)
>check_mqns_enabled.c:41: warning: implicit declaration of function `mq_open'
>check_mqns_enabled.c:41: error: `O_RDWR' undeclared (first use in this function)
>check_mqns_enabled.c:41: error: `O_CREAT' undeclared (first use in this
>function)
>check_mqns_enabled.c:41: error: `O_EXCL' undeclared (first use in this function)
>>check_mqns_enabled.c:46: warning: implicit declaration of function `mq_close'
>make[4]: *** [check_mqns_enabled] Error 1
>make[4]: Leaving directory
>`/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel/containers/mqns'
>make[3]: *** [all] Error 2
>make[3]: Leaving directory
>`/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel/containers'
>>make[2]: *** [all] Error 2
>make[2]: Leaving directory
>`/home/etonant/linux-test-project/ltp-full-20100228/testcases/kernel'
>make[1]: *** [all] Error 2
>make[1]: Leaving directory
>`/home/etonant/linux-test-project/ltp-full-20100228/testcases'
>make: *** [testcases-all] Error 2
>etonant@lxlogin-4-300

-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
