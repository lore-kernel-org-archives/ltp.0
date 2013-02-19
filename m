Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1U7k0a-00047G-Hp
	for ltp-list@lists.sourceforge.net; Tue, 19 Feb 2013 10:01:08 +0000
Date: Tue, 19 Feb 2013 11:01:39 +0100
From: chrubis@suse.cz
Message-ID: <20130219100138.GA30515@rei>
References: <5122E05A.6010507@cn.fujitsu.com>
	<1360829341.5171174.1361259703806.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1360829341.5171174.1361259703806.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH v3 2/3] setns: add new syscall test setns01
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Thanks, that was error for sure. I just wonder what compiler/version
> Cyril used.

It's glibc feature. If you turn on FORTIFY_SOURCES the
/usr/include/fcntl.h includes /usr/include/bits/fcntl2.h which contains
checks for common open errors.

And there are other checks it enables too.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
