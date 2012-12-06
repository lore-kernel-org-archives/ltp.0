Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TgcQO-0003E9-4D
	for ltp-list@lists.sourceforge.net; Thu, 06 Dec 2012 14:27:40 +0000
Date: Thu, 6 Dec 2012 15:27:28 +0100
From: chrubis@suse.cz
Message-ID: <20121206142728.GA29885@rei.nue.novell.com>
References: <50C08A4C.1090402@redhat.com>
 <50C0A844.2020004@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <50C0A844.2020004@cn.fujitsu.com>
Subject: Re: [LTP] open posix testsuite and names of testcases
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> > this testsuite has many testcases, where binary name is in format: [number]-[number].run-test
> > This is not very helpful when trying to find out, which one actually
> > crashed or which one is responsible for kernel oops/hung tasks.
> > For example if I get in dmesg:
> > [  702.018706] 1-5.run-test[10140]: segfault at 7f84e724bed8 ip 0000000000402208 sp 00007f84e724bed0 error 6 in 1-5.run-test[400000+4000]
> > it's not clear, which testcase is responsible.
> 
> I met the same problem before because running the open_posix on recent RHEL6.4alpha and beta
> will cause kernel panic...

Which could still be fixed by a testdriver that ensures that the logfile
was written to the disk before each test is executed. But the renaming
is still a good idea because there may be a rare case where the
filesystem will be trashed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
