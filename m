Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MWalv-0000Wr-EL
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:54:35 +0000
Received: from rv-out-0708.google.com ([209.85.198.248])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MWaln-0005gy-RZ
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:54:32 +0000
Received: by rv-out-0708.google.com with SMTP id b17so420478rvf.22
	for <ltp-list@lists.sourceforge.net>;
	Thu, 30 Jul 2009 11:54:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <50FD90C65C53FB45BADEEBCD84FF07F2019697F4@ATCPCS06.andestech.com>
References: <50FD90C65C53FB45BADEEBCD84FF07F2019697F4@ATCPCS06.andestech.com>
Date: Thu, 30 Jul 2009 11:54:22 -0700
Message-ID: <364299f40907301154k12b41e8at1c8663787862093b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fixed static build which needs to link thepthread
	library in pidns and pipeio.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: nobuhiro@andestech.com
Cc: ltp-list@lists.sourceforge.net

2009/7/26  <nobuhiro@andestech.com>:
> Hi Matt,
>
> When static linking, the pthread stuff is due to the undefined pthread sy=
mbols in librt.a and libgcc_eh.a.
> make[4]: Entering directory `/home/nobuhiro/git_repo/os/ltp/testcases/ker=
nel/ipc/pipeio'
> cc -Wall =A0-static -Wall =A0-I../../../../include =A0 pipeio.c =A0-L../.=
./../../lib -lltp -lrt -o pipeio
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_susp=
end.o): In function `cleanup':
> (.text+0xa): undefined reference to `pthread_mutex_lock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_susp=
end.o): In function `aio_suspend64':
> (.text+0x137): undefined reference to `pthread_mutex_lock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_susp=
end.o): In function `aio_suspend64':
> (.text+0x289): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_susp=
end.o): In function `aio_suspend64':
> (.text+0x2e2): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_susp=
end.o): In function `aio_suspend64':
> (.text+0x38e): undefined reference to `pthread_mutex_lock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_susp=
end.o): In function `cleanup':
> (.text+0x97): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(lio_list=
io.o): In function `lio_listio_internal':
> (.text+0x5c): undefined reference to `pthread_mutex_lock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(lio_list=
io.o): In function `lio_listio_internal':
> (.text+0x278): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(lio_list=
io.o): In function `lio_listio_internal':
> (.text+0x296): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(lio_list=
io.o): In function `lio_listio_internal':
> (.text+0x2d5): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(lio_list=
io.o): In function `lio_listio_internal':
> (.text+0x30f): undefined reference to `pthread_mutex_lock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_noti=
fy.o): In function `__aio_notify_only':
> (.text+0x9c): undefined reference to `pthread_create'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_noti=
fy.o): In function `__aio_notify_only':
> (.text+0xc4): undefined reference to `pthread_attr_init'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_noti=
fy.o): In function `__aio_notify_only':
> (.text+0xd1): undefined reference to `pthread_attr_setdetachstate'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `aio_init':
> (.text+0x10a): undefined reference to `pthread_mutex_lock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `__aio_enqueue_request':
> (.text+0x191): undefined reference to `pthread_self'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `__aio_enqueue_request':
> (.text+0x1a9): undefined reference to `pthread_getschedparam'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `__aio_enqueue_request':
> (.text+0x1c6): undefined reference to `pthread_mutex_lock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `__aio_enqueue_request':
> (.text+0x2f5): undefined reference to `pthread_cond_signal'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `__aio_enqueue_request':
> (.text+0x30a): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `__aio_enqueue_request':
> (.text+0x3c4): undefined reference to `pthread_attr_init'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `__aio_enqueue_request':
> (.text+0x3d1): undefined reference to `pthread_attr_setdetachstate'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `__aio_enqueue_request':
> (.text+0x3de): undefined reference to `pthread_attr_setstacksize'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `__aio_enqueue_request':
> (.text+0x414): undefined reference to `pthread_create'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `__aio_enqueue_request':
> (.text+0x433): undefined reference to `pthread_attr_destroy'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `__aio_enqueue_request':
> (.text+0x58a): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `handle_fildes_io':
> (.text+0x768): undefined reference to `pthread_self'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `handle_fildes_io':
> (.text+0x77d): undefined reference to `pthread_getschedparam'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `handle_fildes_io':
> (.text+0x7d6): undefined reference to `pthread_mutex_lock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `handle_fildes_io':
> (.text+0x8ad): undefined reference to `pthread_cond_signal'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `handle_fildes_io':
> (.text+0x8b7): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `handle_fildes_io':
> (.text+0x903): undefined reference to `pthread_setschedparam'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `handle_fildes_io':
> (.text+0xa9e): undefined reference to `pthread_attr_init'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `handle_fildes_io':
> (.text+0xaab): undefined reference to `pthread_attr_setdetachstate'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `handle_fildes_io':
> (.text+0xabf): undefined reference to `pthread_create'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `handle_fildes_io':
> (.text+0xb65): undefined reference to `pthread_cond_timedwait'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `handle_fildes_io':
> (.text+0xb8d): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `handle_fildes_io':
> (.text+0xbae): undefined reference to `pthread_mutex_lock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(aio_misc=
.o): In function `aio_init':
> (.text+0x12c): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2-fde-glibc.o=
): In function `__register_frame_info_bases':
> (.text+0x42): undefined reference to `pthread_mutex_lock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2-fde-glibc.o=
): In function `__register_frame_info_table_bases':
> (.text+0xbd): undefined reference to `pthread_mutex_lock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2-fde-glibc.o=
): In function `_Unwind_Find_FDE':
> (.text+0x157d): undefined reference to `pthread_mutex_lock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2-fde-glibc.o=
): In function `_Unwind_Find_FDE':
> (.text+0x15d1): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2-fde-glibc.o=
): In function `__deregister_frame_info_bases':
> (.text+0x177c): undefined reference to `pthread_mutex_lock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2-fde-glibc.o=
): In function `__deregister_frame_info_bases':
> (.text+0x1800): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2-fde-glibc.o=
): In function `__register_frame_info_bases':
> (.text+0x61): undefined reference to `pthread_mutex_unlock'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2-fde-glibc.o=
): In function `__register_frame_info_table_bases':
> (.text+0xdc): undefined reference to `pthread_mutex_unlock'
> collect2: ld returned 1 exit status
> make[4]: *** [pipeio] Error 1
> make[4]: Leaving directory `/home/nobuhiro/git_repo/os/ltp/testcases/kern=
el/ipc/pipeio'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/home/nobuhiro/git_repo/os/ltp/testcases/kern=
el/ipc'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/home/nobuhiro/git_repo/os/ltp/testcases/kern=
el'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/nobuhiro/git_repo/os/ltp/testcases'
> make: *** [all] Error 2
>
> Also same here.
> make[4]: Entering directory `/home/nobuhiro/git_repo/os/ltp/testcases/ker=
nel/containers/pidns'
> cc -Wall =A0-static -Wall =A0-I../../../../include -I../libclone =A0 pidn=
s30.c =A0-L../../../../lib -L../libclone ../libclone/libclone.a -lltp -lrt =
-o pidns30
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `mq_notify':
> (.text+0x8b): undefined reference to `pthread_once'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `change_sigmask':
> (.text+0x1ee): undefined reference to `pthread_sigmask'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `init_mq_netlink':
> (.text+0x2b9): undefined reference to `pthread_barrier_init'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `init_mq_netlink':
> (.text+0x379): undefined reference to `pthread_attr_init'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `init_mq_netlink':
> (.text+0x386): undefined reference to `pthread_attr_setdetachstate'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `init_mq_netlink':
> (.text+0x393): undefined reference to `pthread_attr_setstacksize'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `init_mq_netlink':
> (.text+0x3b6): undefined reference to `pthread_create'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `init_mq_netlink':
> (.text+0x3c5): undefined reference to `pthread_attr_destroy'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `init_mq_netlink':
> (.text+0x3f6): undefined reference to `pthread_sigmask'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `init_mq_netlink':
> (.text+0x406): undefined reference to `pthread_atfork'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `init_mq_netlink':
> (.text+0x417): undefined reference to `pthread_cancel'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `helper_thread':
> (.text+0x489): undefined reference to `pthread_create'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `helper_thread':
> (.text+0x497): undefined reference to `pthread_barrier_wait'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `notification_function':
> (.text+0x4bb): undefined reference to `pthread_barrier_wait'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `notification_function':
> (.text+0x4c0): undefined reference to `pthread_self'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/../../../../lib64/librt.a(mq_notif=
y.o): In function `notification_function':
> (.text+0x4c8): undefined reference to `pthread_detach'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2.o): In func=
tion `uw_init_context_1':
> (.text+0x20a2): undefined reference to `pthread_cancel'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2.o): In func=
tion `uw_init_context_1':
> (.text+0x20b8): undefined reference to `pthread_once'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2-fde-glibc.o=
): In function `__register_frame_info_bases':
> (.text+0x33): undefined reference to `pthread_cancel'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2-fde-glibc.o=
): In function `__register_frame_info_table_bases':
> (.text+0xae): undefined reference to `pthread_cancel'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2-fde-glibc.o=
): In function `_Unwind_Find_FDE':
> (.text+0x156c): undefined reference to `pthread_cancel'
> /usr/lib/gcc/x86_64-pc-linux-gnu/4.3.3/libgcc_eh.a(unwind-dw2-fde-glibc.o=
): In function `__deregister_frame_info_bases':
> (.text+0x176b): undefined reference to `pthread_cancel'
> collect2: ld returned 1 exit status
> make[4]: *** [pidns30] Error 1
> make[4]: Leaving directory `/home/nobuhiro/git_repo/os/ltp/testcases/kern=
el/containers/pidns'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory `/home/nobuhiro/git_repo/os/ltp/testcases/kern=
el/containers'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/home/nobuhiro/git_repo/os/ltp/testcases/kern=
el'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/nobuhiro/git_repo/os/ltp/testcases'
> make: *** [all] Error 2

    This may be glibc specific, s.t. you'll have to maintain this
patch now in-house and we'll revisit it after the release, as there
may be an additional needed requirement for the libraries linked in
with these testcases, either at the specific library level, or the
toolchain level.
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
