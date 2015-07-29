Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1ZKLAa-0000aA-07
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 06:48:52 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZKLAY-0001tH-JB
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2015 06:48:51 +0000
Date: Wed, 29 Jul 2015 02:48:43 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1961298991.213904.1438152523150.JavaMail.zimbra@redhat.com>
In-Reply-To: <1590056734.149151438142095446.JavaMail.weblogic@epmlwas07a>
References: <1590056734.149151438142095446.JavaMail.weblogic@epmlwas07a>
MIME-Version: 1.0
Subject: Re: [LTP] Regarding memcg control  testcase (mem_process.c)
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
To: manjeet p <manjeet.p@samsung.com>
Cc: AJEET YADAV <ajeet.y@samsung.com>, ltp-list@lists.sourceforge.net, PANKAJ MISHRA <pankaj.m@samsung.com>





----- Original Message -----
> From: "Manjeet Pawar" <manjeet.p@samsung.com>
> To: "Jan Stancek" <jstancek@redhat.com>, ltp-list@lists.sourceforge.net
> Cc: "AJEET YADAV" <ajeet.y@samsung.com>, "PANKAJ MISHRA" <pankaj.m@samsung.com>
> Sent: Wednesday, 29 July, 2015 5:54:55 AM
> Subject: Re: Re: [LTP]  Regarding memcg control  testcase (mem_process.c)
> 
> Hello Jan,
> After doing analysis, I found that When memory hog process (mem_process)
> tries to mmap double the memory of the cgroup limit which is 4096 . I am
> getting OOM in that situation and send kill signal to process (which is
> expected behaviour) . But it could not kill the process and
>  it sets the process state to uninterrupted sleep state.
> 
> To get this OOM , i need to change oom_adj value of the process '208' from
> -17 to -16. If i dont do this, I dont get OOM and process always stuck at
> mmap and try to allocate 8192 Bytes of memory.

That explains it, -17 means OOM is disabled:
#define OOM_DISABLE (-17)

> logs:-
> [2-74.5749] Memory cgroup out of memory: Kill process 208 (mem_process) score
> 147000 or sacrifice child
> [2-74.5840] Killed process 208 (mem_process) total-vm:2704kB, anon-rss:80kB,
> file-rss:484kB
> by mmap is -1237753856
> Warning: bad syntax, perhaps a bogus '-'? See /usr/share/doc/procps-3.2.8/FAQ
> root       208 39.6  0.0   2704   564 ?        D    00:01   0:02 mem_process
> -m 8192  // D - means uninterrupted sleep
> root       215  0.0  0.0   2412   584 ?        S    00:01   0:00 grep -r 208

No idea why it's getting stuck though. I'd try with oom_adj == 0. If that makes
no difference, /proc/<pid>/stack might give some additional clues.

Do you see similar behaviour with other OOM testcases?

Regards,
Jan

> 
> I am using 3.10.84 kernel. LTP is of latest  version (ltp-full-20150420)
> 
> Regards
> Manjeet
> 
> ------- Original Message -------
> Sender : Jan Stancek<jstancek@redhat.com>
> Date : Jul 27, 2015 17:32 (GMT+09:00)
> Title : Re: [LTP] Regarding memcg control testcase (mem_process.c)
> 
> 
> 
> 

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
