From: xuyang2018.jy@fujitsu.com <xuyang2018.jy@fujitsu.com>
Date: Tue, 27 Jul 2021 05:51:25 +0000
Subject: [LTP] [PATCH v2 2/2] msgget03: don't depend on existed shared
 resources
In-Reply-To: <YPq0749ZnnGsAV2q@pevik>
References: <20210712075223.10682-1-aleksei.kodanev@bell-sw.com>
 <20210712075223.10682-2-aleksei.kodanev@bell-sw.com> <YPkkZ0Zq9DyHKBaT@pevik>
 <YPlhMeRRsNnemT05@yuki> <YPlsK8fsMI8T+H7c@pevik> <YPlsVD2gbIiX8JJk@yuki>
 <60FA81E4.3060709@fujitsu.com> <YPq0749ZnnGsAV2q@pevik>
Message-ID: <60FF9EFA.308@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
> Hi all,
>
>> Hi Cyril, Petr
>>> Hi!
>>>>> I think that we allready discussed this in another thread:
>
>>>>> https://lists.linux.it/pipermail/ltp/2021-July/023831.html
>
>>>> Thanks, I forgot this. In that case my approach (not using<=, but count
>>>> segments in /proc/sysvipc/shm before testing) might be more precise.
>>>> But no strong feeling about that, both solutions fix the test, let's chose one
>>>> and merge.
>
>>> As I said previously, there are many SysV IPC tests that do expect that
>>> nobody will add/remove IPC shm/queue/semaphores during the testrun and
>>> some of the testcases cannot even be implemented without this
>>> expectation.
>
>>> Hence I wouldn't complicate the test here and just count how many
>>> segments are there at the start and be done with it.
>> Agree.
>
>> A possible solution(alter get_used_queues api in new ipc lib and add
>> file parametrers, so we can use this api for msgget03) I have mentioned
>> in the previous email, the url as below:
>> https://lists.linux.it/pipermail/ltp/2021-July/023653.html
> LGTM. Or use /proc/sysvipc/shm instead of /proc/sysvipc/msg in get_used_queues()
> as you noted get_used_queues() has not been used yet.
I rename get_used_queues to get_used_sysvipc_cnt. see attached patch.
>
> BTW searching where get_used_queues() appeared, I see [LTP] [PATCH v3 1/4]
> syscalls/ipc: add newipc library for new API [1], but if I'm not mistaken
> get_used_queues() was not used even there, maybe it was in some previous
> versions.
Yes, no new api case use GET_USED_QUEUES api.
>
> Kind regards,
> Petr
>
> [1] https://lists.linux.it/pipermail/ltp/2016-December/003239.html

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 0001-libs-libnewipc-Rename-get_used_queues-as-get_used_sy.patch
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210727/401bfffc/attachment.ksh>
