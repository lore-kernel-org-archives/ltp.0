From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 30 Jul 2021 12:35:09 +0200
Subject: [LTP] [PATCH 3/3] mbind01: add more tests for MPOL_LOCAL
In-Reply-To: <CAEemH2cJHtVkaaH5OokAHfVLzPdxU=SqiCf_Gg_ntX_fnWorYw@mail.gmail.com>
References: <20210729132514.1699551-1-liwang@redhat.com>
 <20210729132514.1699551-3-liwang@redhat.com>
 <CAASaF6yQkiZVPWpsoo0ZrryBGFdLSGo3kkoejeWcy8dQMSL3yw@mail.gmail.com>
 <CAEemH2cJHtVkaaH5OokAHfVLzPdxU=SqiCf_Gg_ntX_fnWorYw@mail.gmail.com>
Message-ID: <CAASaF6x2pTo1kMXy+nPJT+B9nEZ4Z+ovNzjtfW5f2WEq1fxc0g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Jul 30, 2021 at 10:03 AM Li Wang <liwang@redhat.com> wrote:

>
>
> On Thu, Jul 29, 2021 at 10:20 PM Jan Stancek <jstancek@redhat.com> wrote:
>
>>
>>
>> On Thu, Jul 29, 2021 at 3:25 PM Li Wang <liwang@redhat.com> wrote:
>>
>>> Signed-off-by: Li Wang <liwang@redhat.com>
>>> ---
>>>  testcases/kernel/syscalls/mbind/mbind01.c | 25 ++++++++++++++++++++---
>>>  1 file changed, 22 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/mbind/mbind01.c
>>> b/testcases/kernel/syscalls/mbind/mbind01.c
>>> index d2cf13c8f..b5c1e948d 100644
>>> --- a/testcases/kernel/syscalls/mbind/mbind01.c
>>> +++ b/testcases/kernel/syscalls/mbind/mbind01.c
>>> @@ -34,7 +34,7 @@ static struct bitmask *nodemask, *getnodemask,
>>> *empty_nodemask;
>>>  static void test_default(unsigned int i, char *p);
>>>  static void test_none(unsigned int i, char *p);
>>>  static void test_invalid_nodemask(unsigned int i, char *p);
>>> -static void check_policy_pref_no_target(int);
>>> +static void check_policy_pref_or_local(int);
>>>
>>>  struct test_case {
>>>         int policy;
>>> @@ -92,7 +92,7 @@ static struct test_case tcase[] = {
>>>                 .ret = 0,
>>>                 .err = 0,
>>>                 .test = test_none,
>>> -               .check_policy = check_policy_pref_no_target,
>>> +               .check_policy = check_policy_pref_or_local,
>>>         },
>>>         {
>>>                 POLICY_DESC(MPOL_PREFERRED),
>>> @@ -101,6 +101,20 @@ static struct test_case tcase[] = {
>>>                 .test = test_default,
>>>                 .exp_nodemask = &nodemask,
>>>         },
>>> +       {
>>> +               POLICY_DESC(MPOL_LOCAL),
>>> +               .ret = 0,
>>> +               .err = 0,
>>> +               .test = test_none,
>>> +               .exp_nodemask = &empty_nodemask,
>>> +               .check_policy = check_policy_pref_or_local,
>>>
>>
>> This is a bit more permissive, it allows for MPOL_LOCAL to return also
>> MPOL_PREFERRED.
>> Shouldn't that still be treated as error?
>>
>
> To strictly this should be an error.
>
> But I slightly think that it's acceptable to get 'MPOL_PREFERRED' on the
> old
> kernel (i.e. 4.18.0, v5.13) because 'MPOL_LOCAL' is not treated as a real
> policy.
> And the situation exists for quite a long time.
>

You're right, on older kernel it failed in similar way for MPOL_LOCAL
as it failed for MPOL_PREFERRED on latest one.

Acked-by: Jan Stancek <jstancek@redhat.com>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210730/18bd325e/attachment.htm>
