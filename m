From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 13 Sep 2018 15:12:54 +0200
Subject: [LTP] [PATCH] syscalls/fanotify: new test for mount ignore mask
In-Reply-To: <CAOQ4uxjb_qLX6O0BcGF3QZpy=0FKHqmwUL52bniDdj=Y7BXtFw@mail.gmail.com>
References: <20180908142453.21532-1-amir73il@gmail.com>
 <20180908142453.21532-2-amir73il@gmail.com>
 <87in3c5rn6.fsf@rpws.prws.suse.cz>
 <CAOQ4uxho8Fh7=eJr962UeTr4dwqnOjFQJZxvJ4ZreMa_MRJDfQ@mail.gmail.com>
 <20180913114531.GA3030@rei.lan>
 <CAOQ4uxjb_qLX6O0BcGF3QZpy=0FKHqmwUL52bniDdj=Y7BXtFw@mail.gmail.com>
Message-ID: <87efdxzgkp.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Amir Goldstein <amir73il@gmail.com> writes:

> On Thu, Sep 13, 2018 at 2:45 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>>
>> Hi!
>> > All right. I have already written this test with a test index to cover
>> > all possible
>> > mixes of mark types include and exclude masks:
>> > https://github.com/amir73il/ltp/blob/fanotify_sb/testcases/kernel/syscalls/fanotify/fanotify13.c
>> > This gives better coverage than fanotify06 and fanotify10 combined.
>> >
>> > However, if I modify test fanotify06 instead of forking test fanotify10, the
>> > test (fanotify06) is going to start failing on non-master kernels.
>> > Is that acceptable for LTP? I am asking because in fstests project, we have
>> > the practice not to change an existing test to failing. When we find a
>> > new regression we write a new variant of the test for it.
>>
>> We do not have a rule lik this but it sounds like a reasonable rule to
>> me, since when existing test starts to fail it does look like a
>> regression in the tests itself.
>>
>> > If changing an existing test to cover more cases is appropriate than I am
>> > going to generalize fanotify06 (as fanotify13 linked above) and then
>> > when FAN_MARK_FILESYSTEM mark type support is added to kernel
>> > all I will need to do is change the test again to add another mark type
>> > to  fanotify_mark_types array.
>>
>> I guess that either would be fine. In the end someone has to look
>> closely at failing tests anyway to say what exactly happened.
>>
>
> So here is what I suggest, which seems most reasonable w.r.t code reuse
> and friendliness to testers:
> - Leave fanotify06 untouched because it checks the common case
>   (ignore on inode mark)
> - Add new test fanotify10 that checks all combinations of marks types
>   (like referenced fanotify13)
> - After FAN_MARK_FILESYSTEM patches are merged, add the new mark
>   type to fanotify10 test matrix, but disable it on runtime if new mark type
>   is not supported by kernel.
>
> Thanks,
> Amir.

Maybe it does make sense to introduce a new test if you are testing a
new feature (even if it is only a minor change). But to clarify, I also
think that for long term maintainability, it makes sense to refactor
common code into a header file.

There are instances in the LTP where a test has been copied, then
various fixes and improvements applied to one copy, but not the others
(sometimes a fix is not needed straight away in a particular test copy,
but then something else changes and it starts failing). Eventually
someone has to combine all the copies in one big painful refactoring,
instead of appying incremental changes along the way.

Obviously if you touch fanotify06 in any way you are increasing the risk
of breaking the test, but I think it is worth the risk over time.

--
Thank you,
Richard.
