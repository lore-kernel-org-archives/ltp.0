Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wzm61-000125-KD
	for ltp-list@lists.sourceforge.net; Wed, 25 Jun 2014 12:14:37 +0000
Date: Wed, 25 Jun 2014 14:14:20 +0200
From: chrubis@suse.cz
Message-ID: <20140625121420.GA8523@rei.Home>
References: <1403690435-18626-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1403690435-18626-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [RFC PATCH] tst_get_unused_pid and
 system_specific_process_info
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
> 1. We remove get_max_pids(), because it's used only in one place (get_free_pids())
>    and can be subsituted with
>    SAFE_FILE_SCANF(cleanup_fn, PID_MAX_PATH, "%d", &pid);
> 
> 2. We rename get_free_pids() to tst_get_free_pids() for consistency. And changing a bit its
>    declaration to use SAFE_FILE_SCANF().
> 
> 3. system_specific_process_info.h is used only in one place - msgctl11.
>    I think it's not a problem if I move its content to test.h. For consistency.
> 
> 4. And add tst_get_unused_pid() to system_specific_process_info.c. To not
>    create a new source file. And this funcion looks logically coupled with tst_get_free_pids().
> 
> I'm going to present pp. 1-3 in one patch, and p. 4 - in a separate patch.
> 
> What do you think about the general idea?

Sounds good to me.

Perhaps we should also rename the system_specific_process_info.c to
something shorter and more to the point. Maybe just process_info.c or
pidutils.c or something similar.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
