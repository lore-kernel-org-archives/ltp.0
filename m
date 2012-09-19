Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1TEFnn-0007MP-J2
	for ltp-list@lists.sourceforge.net; Wed, 19 Sep 2012 08:38:35 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TEFnl-00024T-7W
	for ltp-list@lists.sourceforge.net; Wed, 19 Sep 2012 08:38:35 +0000
Message-ID: <50598445.5040100@cn.fujitsu.com>
Date: Wed, 19 Sep 2012 16:37:25 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <fee33eeaff94a4fd766417d44fdd341dd50f9784.1348039691.git.jstancek@redhat.com>
In-Reply-To: <fee33eeaff94a4fd766417d44fdd341dd50f9784.1348039691.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2] pthread_detach: avoid threads sharing stack
Reply-To: gaowanlong@cn.fujitsu.com
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
Cc: ltp-list@lists.sourceforge.net, Kang Kai <Kai.Kang@windriver.com>

On 09/19/2012 03:29 PM, Jan Stancek wrote:
> 
> This testcase was observed to crash with segmentation fault:
> http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg14692.html
> 
> Following issues have been found:
> - When detached thread signals it's done, it's not really done yet
>   and it is possible for scheduler to switch to test() thread and create
>   another thread(s) that uses same altstack. sem_post/sem_wait
>   is not reliable way to tell when detached thread is finished.
>   test() thread can continue to spawn new threads and unprivileged user
>   can run out of resources.
> - Threads which fire SIGUSR signals can do so very frequently,
>   so threaded() thread may not progress at all and it starts to
>   progress only when signal threads are told to stop sending signals.
> 
> This patch modifies testcase in following way:
> 
> Before
> -------
> test() loops over all scenarios repeatedly and spawns new threaded()
> as soon as previous one called sem_post.
> 
> main +
>      |\
>      | send_sig1 (thread)
>      |\
>      | send_sig2 (thread)
>      \
>        test (thread)
>          \
>           threaded (detached thread)
> 
> After
> ------
> Only one thread is sending signals (SIGUSR1) with gradually increasing
> sleep time to make sure threaded() can progress. test() loops over
> scenarios just once.
> 
> main() loops for specified time, it spawns new child and waits for it
> to finish. This will avoid using same stack by 2+ threads and there will be
> no more than NSCENAR threads at a time.
> 
> main (procA)
>              \
>               do_child (procB) +
>                                |\
>                                | send_sig (thread)
>                                 \
>                                  test (thread)
>                                    \
>                                     threaded (detached thread)
> 
> Modified version have been succesfully tested by reporter:
> routerstation(mips), x86_64(ubuntu11.10 & redhat 5.3)
> and x86(redhat 5.3) each 100+ times
> 
> and by me: 100+ times as root and unprivileged user on:
> RHEL5.8 (i386, x86_64, ia64, ppc64, s390x)
> RHEL6.0 (i386, x86_64, ppc64, s390x)
> RHEL6.3 (i386, x86_64, ppc64, s390x)
> 
> Following glibc bug has been observed during testing on ppc64:
> Bug 852445 - gcc_assert failure in _Unwind_SetSpColumn() on ppc64
> https://bugzilla.redhat.com/show_bug.cgi?id=852445
> 
> This patch is currently not making any workarounds to avoid
> hitting this issue, because so far it is known to happen only
> rarely on ppc64 when unprivileged user runs the testcase.
> If this issue becomes more significant, testcase can be modified
> to skip scenarios with explicit scheduling if they are run by
> unprivileged user.
> 
> Reported-by: Kang Kai <kai.kang@windriver.com>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Pushed, thank you very much for your work. ;)

Wanlong Gao


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
