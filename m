From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 18 Aug 2016 12:48:06 +0200
Subject: [LTP] [PATCH 8/8] waitpid08: test stopped children
In-Reply-To: <57B58A00.7060707@oracle.com>
References: <1470818466-28109-2-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-4-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-5-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-6-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-7-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-8-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1470818466-28109-9-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160816130316.GA25540@rei.lan> <57B58A00.7060707@oracle.com>
Message-ID: <20160818104805.GB24254@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> No-no, this should not happen, since reap_children() handles stopped
> children this way:
> 
> for (;;) {
>   pid = waitpid();
> 
>   if (pid is a pid of a stopped task) {
>       kill(pid, SIGCONT);
>       continue;
>   }
> 
>   <...>
> }
> 
> i.e. it makes all the stopped children continue.
> 
> So there should not be any children in 'pgroup' after
> reap_children(pgroup) has finished.
> 
> This SIGSTOP-related code is added by the previous patch in the series
> (waitpid13).

Ah, missed that, sorry.

It probably should have been in a separate patch.

-- 
Cyril Hrubis
chrubis@suse.cz
