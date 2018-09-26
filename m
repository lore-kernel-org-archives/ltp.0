From: Nixiaoming <nixiaoming@huawei.com>
Date: Wed, 26 Sep 2018 01:07:45 +0000
Subject: [LTP] [PATCH] syscalls/fanotify: test fanotify_init new flags
 FAN_EVENT_INFO_TID
In-Reply-To: <CAOQ4uxjWtPA3FjPjMWaUiiEtS9H9GzFxJGHFJwV-qFz9_spMPw@mail.gmail.com>
References: <20180925084344.4397-1-nixiaoming@huawei.com>
 <CAOQ4uxg-6A6R5w-CqRhOonp5OZ8+N3-PVaKpYus1PwpvLB6YkQ@mail.gmail.com>
 <CAOQ4uxjWtPA3FjPjMWaUiiEtS9H9GzFxJGHFJwV-qFz9_spMPw@mail.gmail.com>
Message-ID: <E490CD805F7529488761C40FD9D26EF12A7CC093@DGGEMM527-MBS.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 26, 2018 2:20 AM Amir Goldstein <amir73il@gmail.com> wrote:
>[CC: Jan Kara]
>
>On Tue, Sep 25, 2018 at 5:37 PM Amir Goldstein <amir73il@gmail.com> wrote:
>>
>> On Tue, Sep 25, 2018 at 12:31 PM nixiaoming <nixiaoming@huawei.com> wrote:
>> >
>> > fanotify_info_tid:
>> >         test fanotify_init with FAN_EVENT_INFO_TID
>> >         data->pid is ID(pid)  of the thread that caused the event
>> > fanotify_info_tgid:
>> >         test fanotify_init without FAN_EVENT_INFO_TID
>> >         data->pid is ID(tgid) of the process that caused the event
>>
>> Nixiaoming,
>>
>> These two tests are identical except for probably a single if condition.
>> They should be implemented as a single test with two test cases.
>> See test fanotify10 I posted as an example.
>>
>
>Nixiaoming,
>
>Two more things to add:
>1. Test coverage would be more complete IMO if test would also generate an event
>from a forked child. You have an example of SAFE_FORK and
>'forks_child' in fanotify03.
>You could execute the thread and the child process sequentially,
>reading each event
>before executing the other to simplify the test.
>2. Since FAN_EVENT_INFO_TID is not yet merged and the API not even
>reviewed by Jan,
>it should be made clear when posting a test that this is an RFC and
>not a request for merge
>yet. What you could do though is post the test with a single test case
>that only checks
>tgid and request to merge it. Later post a patch that adds a test case with the
>FAN_EVENT_INFO_TID variant after FAN_EVENT_INFO_TID code is merged upstream
>(before that you can post RFC test of course).
>
>Hope I didn't make the process too complicated to understand...
>Thanks,
>Amir.
>

thanks for your guidance, 
I will refer to your comments and rewrite the test cases as soon as possible.

thanks


