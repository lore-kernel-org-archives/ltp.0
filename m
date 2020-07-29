From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 29 Jul 2020 16:30:54 +0800
Subject: [LTP] [PATCH v1 2/2] libs/libltpnewipc: Add libmsgctl.c into
 new ipc library
In-Reply-To: <CAEemH2ckxPDkncT9m2nyv0-tvJ70SKogun7EfzAN912sc5662A@mail.gmail.com>
References: <1595911224-12470-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595911224-12470-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2eFrsa0rNfjcKrdQpUkV6YvbQR10tbzy4F5jXVQOrra7w@mail.gmail.com>
 <9916b020-27b6-bc12-919b-9046dc7dcee5@cn.fujitsu.com>
 <CAEemH2ckxPDkncT9m2nyv0-tvJ70SKogun7EfzAN912sc5662A@mail.gmail.com>
Message-ID: <598ad053-525b-c4b7-1ed7-f1409e84818f@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li


> 
> Yang Xu <xuyang2018.jy@cn.fujitsu.com 
> <mailto:xuyang2018.jy@cn.fujitsu.com>> wrote:
> 
>     ...
>      > It's fine to maintain only a single System V IPC library in LTP.
>      > BTW, do you have a plan to remove the old libmsgctl.c after
>     merging this?
>     Yes. I have a plan[1] to? remove this old libmsgctl when I clean up
>     msgstress case(I am doing it).
> 
> 
> Great, thank you!
> 
>     Also, I plan to remove get_max_msgqueues()? function in old libipc.c
>     because we can directly use SAFE_FILE_SCANF("/proc/sys/kernel/msgmni",
>     "%d", &nr_msgqs) in test case.
> 
> 
> +1
> 
> Or, maybe if you'd like to do more in next, the libipc.c also could be 
> merged into libnewipc.c since they have some overlaps too. Anyway, it 
> depends on your thoughts :).
I have this idea[1].
I think we should plan to remove old libipc.c when we cleanup all ipc 
test case.

Cyril has cleanup shmctl and Viresh has cleanup semop today, I also have 
a patchset to cleanup msgrcv. It seems we only  have 
semget,shmget,semctl,shmdt case that use old ipc.

# grep -nsr LTPLIBS
semget/Makefile:6:LTPLIBS = ltpipc
msgget/Makefile:6:LTPLIBS = ltpnewipc
msgsnd/Makefile:6:LTPLIBS = ltpnewipc
shmget/Makefile:6:LTPLIBS = ltpipc
shmctl/Makefile:6:LTPLIBS = ltpipc ltpnewipc
msgstress/Makefile:6:LTPLIBS = ltpipc ltpnewipc
msgrcv/Makefile:6:LTPLIBS = ltpipc
msgctl/Makefile:6:LTPLIBS = ltpnewipc
semctl/Makefile:6:LTPLIBS = ltpipc ltpnewipc
shmat/Makefile:6:LTPLIBS = ltpnewipc
shmdt/Makefile:6:LTPLIBS = ltpipc
semop/Makefile:6:LTPLIBS = ltpipc
#

[1]http://lists.linux.it/pipermail/ltp/2020-July/018063.html
> 
> -- 
> Regards,
> Li Wang


