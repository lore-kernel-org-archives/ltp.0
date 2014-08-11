Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XGr9t-00040u-Jk
	for ltp-list@lists.sourceforge.net; Mon, 11 Aug 2014 15:05:13 +0000
Date: Mon, 11 Aug 2014 17:04:14 +0200
From: chrubis@suse.cz
Message-ID: <20140811150413.GC2022@rei.suse.cz>
References: <20140520144246.GA30023@rei.suse.cz>
	<1402996098-12697-3-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1402996098-12697-3-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH V2 3/3] ltp_rt_sigaction.h: added SPARC support
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
I've started to prepare for release and tried to build LTP on as much
arch/distro combination I could, for ia64 the rt_sigaction fails with:

In file included from rt_sigaction01.c:42:
[  349s] ../../../../include/lapi/rt_sigaction.h: In function
'ltp_rt_sigaction':
[  349s] ../../../../include/lapi/rt_sigaction.h:206: error: 'struct
sigaction' has no member named 'sa_restorer'
[  349s] rt_sigaction01.c: In function 'set_handler':
[  349s] rt_sigaction01.c:73: warning: unused parameter 'sig_to_mask'
[  349s] make[4]: *** [rt_sigaction01] Error 1
[  349s] make[4]: Leaving directory
`/usr/src/packages/BUILD/ltp-full-git/testcases/kernel/syscalls/rt_sigaction'
[  349s] make[3]: *** [all] Error 2
[  349s] make[3]: Leaving directory
`/usr/src/packages/BUILD/ltp-full-git/testcases/kernel/syscalls'
[  349s] make[2]: *** [all] Error 2
[  349s] make[2]: Leaving directory
`/usr/src/packages/BUILD/ltp-full-git/testcases/kernel'
[  349s] make[1]: *** [all] Error 2
[  349s] make[1]: Leaving directory
`/usr/src/packages/BUILD/ltp-full-git/testcases'
[  349s] make: *** [testcases-all] Error 2
[  349s] error: Bad exit status from /var/tmp/rpm-tmp.20244 (%build)

Looking into glibc they have #ifdef HAVE_SA_RESTORER around code that
accesses the field. I guess that we have to add corresponding configure
check and ifdef too...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
