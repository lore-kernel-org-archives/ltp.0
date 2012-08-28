Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1T6HIY-0006Pn-L2
	for ltp-list@lists.sourceforge.net; Tue, 28 Aug 2012 08:37:22 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T6HIV-00023q-9A
	for ltp-list@lists.sourceforge.net; Tue, 28 Aug 2012 08:37:22 +0000
Date: Tue, 28 Aug 2012 04:37:13 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1527836506.11605302.1346143033089.JavaMail.root@redhat.com>
In-Reply-To: <5036EB22.9090303@windriver.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] pthread_detach/4-3: workaround for segment fault
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net, Zhenfeng Zhao <Zhenfeng.Zhao@windriver.com>



----- Original Message -----
> From: "Kang Kai" <Kai.Kang@windriver.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net, "Zhenfeng Zhao" <Zhenfeng.Zhao@windriver.com>
> Sent: Friday, 24 August, 2012 4:46:58 AM
> Subject: Re: [LTP] [PATCH] pthread_detach/4-3: workaround for segment fault
> >> I was thinking usleep(sleep_time) that progressively increases. So
> >> it
> >> starts firing signals as quickly as it can and slows down over
> >> time.
> >> Each pthread_detach() would reset the sleep_time.
> >>
> >> As for our original issue, idea I'm playing with is:
> >>
> >> main (procA) - do_child (procB) - send_sig (thread)
> >>                                  \
> >>                                    test (thread) - threaded
> >>                                    (detached thread)
> >>
> >> - turn 'while' in test() to single 'for' loop
> >> - loop in main, fork and call do_child, wait for child to finish
> > Hi,
> >
> > attached is v1 of the idea above. I ran it 100x times on various
> > setups as root and unprivileged user.
> 
> Hi Jan,
> 
> Great!
> > Kai, would you like to give a try?
> I have test it on routerstation, x86_64(ubuntu11.10 & redhat 5.3) and
> x86(redhat 5.3) each 100+ times, and all PASS.
> 

Hi,

I'm still looking at this testcase. I have been testing v1 more on different
releases and arches and I'm hitting an issue on ppc64 RHEL6.3.

I'm getting abort from gcc_assert. The most interesting thing is that
thread, which aborts shouldn't exist, because for this scenario pthread_create
returns 1 (EPERM).

(gdb) bt
#0  0x0000008066374e50 in raise (sig=<value optimized out>) at ../nptl/sysdeps/unix/sysv/linux/raise.c:64
#1  0x0000008066376de4 in abort () at abort.c:92
#2  0x000000806687e504 in _Unwind_SetSpColumn (context=0xfff97a0df58, outer_cfa=0xfff97a0e610, outer_ra=0x8066548904) at ../../../gcc/unwind-dw2.c:1265
#3  uw_init_context_1 (context=0xfff97a0df58, outer_cfa=0xfff97a0e610, outer_ra=0x8066548904) at ../../../gcc/unwind-dw2.c:1472
#4  0x000000806687ebe0 in _Unwind_ForcedUnwind (exc=0xfff97a0f670, stop=@0x8066560ad8: 0x8066545660 <unwind_stop>, stop_argument=0xfff97a0e880) at ../../../gcc/unwind.inc:201
#5  0x0000008066548904 in _Unwind_ForcedUnwind (exc=<value optimized out>, stop=<value optimized out>, stop_argument=<value optimized out>) at ../nptl/sysdeps/pthread/unwind-forcedunwind.c:132
#6  0x0000008066545600 in __pthread_unwind (buf=<value optimized out>) at unwind.c:130
#7  0x0000008066545bac in __do_cancel () at pthreadP.h:265
#8  __pthread_enable_asynccancel () at cancellation.c:49
#9  0x000000806653c568 in start_thread (arg=0xfff97a0f200) at pthread_create.c:289
#10 0x000000806643a32c in .__clone () from /lib64/libc-2.12.so

(gdb) frame 2
#2  0x000000806687e504 in _Unwind_SetSpColumn (context=0xfff97a0df58, outer_cfa=0xfff97a0e610, outer_ra=0x8066548904) at ../../../gcc/unwind-dw2.c:1265
1265          gcc_assert (size == sizeof(_Unwind_Word));

The arg in threaded() is not used for anything, so I passed scenario number as parameter.
(gdb) p/x ((struct pthread *) 0xfff97a0f200)->arg
$1 = 0x12

So it's thread for scenario 0x12. This scenario tries to set explicit scheduling with max
priority. When you run this as unprivileged user, pthread_create gives you EPERM.

This comment is interesting, same gcc_assert(), also power7:
http://gcc.gnu.org/bugzilla/show_bug.cgi?id=52839#c10

Regards,
Jan

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
