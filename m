Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UFqK7-0008Jj-9L
	for ltp-list@lists.sourceforge.net; Wed, 13 Mar 2013 18:22:47 +0000
Date: Wed, 13 Mar 2013 19:23:23 +0100
From: chrubis@suse.cz
Message-ID: <20130313182323.GA4633@rei>
References: <1363183294-21203-1-git-send-email-markos.chandras@gmail.com>
	<1482749503.18144192.1363197480299.JavaMail.root@redhat.com>
	<CAG2jQ8h+u3Ade6ONcde=jBLSipJtF1vzP9q7zE-m3qX-LM1fKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAG2jQ8h+u3Ade6ONcde=jBLSipJtF1vzP9q7zE-m3qX-LM1fKQ@mail.gmail.com>
Subject: Re: [LTP] [PATCH 1/2] syscalls/getdents: Use getdents64 if
 SYS_getdents is not defined
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
To: Markos Chandras <markos.chandras@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> The problem is that for arches that don't have SYS_getdents defined,
> you will not be able to compile LTP on them so you really need to
> hide this codepath from them.
> 
> A similar commit that changes the codepath based on whether a
> particular __NR_XX is defined is this
> https://github.com/linux-test-project/ltp/commit/75201f160b9aa49af70d8f46fb1f087e63d603dd
> 
> I don't see an easy way to determine if __NR_XX is defined or not
> during runtime.

There is code that tries to address this issue in
testcases/kernel/include/linux_syscall_numbers.h
which defines macro ltp_syscall() that turns undefined
syscall numbers into ENOSYS.

The idea is to:

1) include sys/syscall.h to get the definitions system definitons

2) if your system headers are older (i.e. particular __NR_xxx is not defined)
   definitions from arch.in files are used

3) if __NR_xxx is not defined, there are stubs at the end of the header
   that defines the __NR_xxx to 0 which is then used by the ltp_syscall()
   macro to return -1 and set errno to ENOSYS

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
