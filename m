Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WXsAr-0005jW-4d
	for ltp-list@lists.sourceforge.net; Wed, 09 Apr 2014 13:04:17 +0000
Date: Wed, 9 Apr 2014 15:03:33 +0200
From: chrubis@suse.cz
Message-ID: <20140409130333.GB22137@rei>
References: <1397025980-26738-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397025980-26738-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH] shm_open_23-1: modified memory protection
 attributes
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
> POSIX doesn't state that if mmap() is given only PROT_WRITE, then
> that memory region will have read access too. It's an implementation
> issue of the platform.
> 
> On a platform which don't imply read access when only PROT_WRITE is given,
> such a situation happens:
>   1) a child process decrements the semaphore with sem_wait(sem)
>   2) then tries to dereference create_cnt via (*create_cnt)++. This
>      will result in a SIGSEGV, and the child will be terminated.
> 
> Therefore the semaphore will be left in a "decremented" state and this
> test case will hang.
> 
> To overcome this problem we should explicitly pass PROT_READ to mmap().

Pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment 
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
