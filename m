From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Wed, 14 Jul 2021 10:17:04 +0000
Subject: [LTP] [PATCH] shmget03: fix test when some shm segments already
 exist
In-Reply-To: <YO61swgamAEnoAFj@pevik>
References: <381b8420-3dba-d7c1-027c-e2e2adc719de@bell-sw.com>
 <CAEemH2fcubrbMpeoeSJJoZtD+xaiRrs_upG_+KQXB_8C9m3eQg@mail.gmail.com>
 <60E50AB4.7050404@fujitsu.com> <YObbKCNKUoC7lSxd@pevik>
 <YObpRzTjx8T2GAZn@yuki> <60EBA9C3.4050103@fujitsu.com>
 <c81eee80-6cea-de14-aeff-8919495c4396@bell-sw.com> <YOwASqNKNXBl4lqe@pevik>
 <0b622e21-453c-5dc2-214e-c9c0a5d48f44@bell-sw.com> <YO6vZDRj4C15sg7K@yuki>
 <YO61swgamAEnoAFj@pevik>
Message-ID: <60EEB9CF.7040001@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Petr
> Hi,
>
> ...
>> We will need to have some kind of flag that would tell the testrunner
>> that the test is using/modifying SysV IPC anyways as without namespaces
>> these tests cannot run in parallel at all.
>
>> So I would say that we should:
>
>> * Write these tests in a way that they expect that they are the only
>>    process that modifies these resources during the testrun
>
>> * Mark all these tests with .sysv_ipc flag in the tst_test structure
>
>> * Then we can easily add support for running them in a separate
>>    namespace in the test library
>
>> Does that sound reasonable?
> +1

+1

Since now ltp test libary uses fork_testrun, I wonder whether we should 
add clone_testrun. So test's setup/test/cleanup function are all in new 
namespace.

Maybe we should support two ways for running test cases in 
lib/tst_test(fork and clone)?

And we can add clone and flag argument(the value can be 
CLONE_NEWIPC/CLONE_NEWNET/CLONENEWPID or more ) in tst_test struct.

ps: Just a initial idea

Best Regards
Yang Xu


> Kind regards,
> Petr
