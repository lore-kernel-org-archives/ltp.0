Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VgyVQ-0005Eq-7N
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 15:06:52 +0000
Date: Thu, 14 Nov 2013 16:06:36 +0100
From: chrubis@suse.cz
Message-ID: <20131114150635.GA15449@rei>
References: <1384353022-9088-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1384353022-9088-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] safe_touch and utimensat
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
> Some distributions (RHEL5, for instance) don't have defined utimensat()
> system call. So I introduced an autoconf check for this, otherwise safe_file_ops.c can 
> not be compiled on these distributions.
> 
> Actually, I'm not satisfied with
>     utimes(pathname, NULL)
> because it throws away the time-changing logic from safe_touch().
> 
> How do you think it is safe to explicitly define UTIME_* constants in LTP
> sources (safe_file_ops.h):
> 
> #ifndef UTIME_NOW
> #define UTIME_NOW ((1l << 30) - 1l)
> #endif
> 
> #ifndef UTIME_OMIT
> #define UTIME_OMIT     ((1l << 30) - 2l)
> #endif

That shouldn't be a problem. These constants are part of ABI they will
not change in future.

Actually LTP has several places where such defines are used in order not
to overcomplicate the autoconf checks.

But I would like to start sticking these into a specific directory under
include/. For example to put these two into include/lapi/utime.h and
include it from the safe_file_ops.h.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
