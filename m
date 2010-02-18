Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maxin.john@gmail.com>) id 1NiAWd-0001qU-Bl
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 17:50:55 +0000
Received: from mail-px0-f201.google.com ([209.85.216.201])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NiAWc-0007F4-AC
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 17:50:55 +0000
Received: by pxi40 with SMTP id 40so1156586pxi.22
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Feb 2010 09:50:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100218040850.GB13013@rishikesh.in.ibm.com>
References: <4B7BA709.8080306@linux.vnet.ibm.com>
	<70aae6bd1002170035j6b8ad2a3la26a90d13b7b800e@mail.gmail.com>
	<20100217120746.GA5966@rishikesh.in.ibm.com>
	<70aae6bd1002171928r7b86a5c2g568117a65dc462fe@mail.gmail.com>
	<20100218040850.GB13013@rishikesh.in.ibm.com>
Date: Thu, 18 Feb 2010 23:20:45 +0530
Message-ID: <9debc4411002180950r16a98d89n64b8eba7ed16113d@mail.gmail.com>
From: Maxin John <maxin.john@gmail.com>
Subject: Re: [LTP] CAN LTP BE CROSS COMPILED FOR ANDROID PLATFORM
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: Rishikesh <risrajak@in.ibm.com>, ltp-list@lists.sourceforge.net, md zafar ziya <md.zafar.ziya@gmail.com>

Hi Rishikesh,

>> 1.All LTP application has to compiled against Android bionic library.
>> 2.Use Android Target Cross compiler for building Testcases executables(That
>> use compiler builtin API also).
>> 3.Android libraray dont have -lrt and -lpthread library,Real time
>> library(rt) and Thread library(pthread) are not defined inside Bionic,so
>> just remove these entries from Makefile because these library function are
>> being moved to bionic C library and for thread API include proper header
>> file only.
>> 4.Header files are placed to different location in bionic ,So update the
>> source as per requirement.
>> 5.to run LTP on android based target,use busybox(Cross compiled for
>> android:Path-http://benno.id.au/blog/2007/11/14/android-busybox).Push to
>> target and use.
>> 6.Modify script as per requirement because android based target has
>> different interpretation.
>> 7.Push only scripts and binary of the executables(because of memory
>> constraints) inside target.
>> 8.Run runltp

Adding some more comments:

  1. I have observed that the 'ash' shell present in the busybox will
not be supporting all the functionalities required for running LTP on
Android. To resolve this, we need to cross compile the bash-4.1 for
Android.  This change is working fine for me.

2 . Remount the '/' in read write mode in Android. Create /bin and
/tmp directories (most of the LTP test cases depends on the existence
of these directories ie: #!/bin/sh ). Push the cross compiled bash to
/bin directory and create the symbolic link 'sh' from 'bash'. We can
also place the above mentioned busybox in the /bin directory and
create the required links.

3. Bionic header files are placed in different directories eg: in LTP
<wait.h> should be modified as <sys/wait.h> , <sys/fcntl.h> should be
modified as <fcntl.h> ... etc :)

4. Some syscalls should be modified using
"syscall(__N_syscallname,parameters...)" which is present in
<sys/syscall.h>

5. Better to have cross compiled 'perl' binary since we need to run
some perl scripts also.

Finally push all the above mentioned binaries along with cross
compiled LTP binaries to Android for the 'real test'.

Best Regards,
Maxin B. John

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
