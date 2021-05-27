From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 27 May 2021 16:14:44 +0100
Subject: [LTP] [PATCH v2 5/6] API/cgroups: tst_require fail gracefully
 with unknown controller
In-Reply-To: <CAEemH2cqGGJuF56LpVO9egB7eLLCLdcXKaVA_2dkFRFmN8=jKw@mail.gmail.com>
References: <20210521102528.21102-1-rpalethorpe@suse.com>
 <20210521102528.21102-6-rpalethorpe@suse.com>
 <CAEemH2cqGGJuF56LpVO9egB7eLLCLdcXKaVA_2dkFRFmN8=jKw@mail.gmail.com>
Message-ID: <87mtsgjjiz.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> On Fri, May 21, 2021 at 6:26 PM Richard Palethorpe via ltp
> <ltp@lists.linux.it> wrote:
>>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>  lib/tst_cgroup.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
>> index 74746f13e..6d94ea41c 100644
>> --- a/lib/tst_cgroup.c
>> +++ b/lib/tst_cgroup.c
>> @@ -599,6 +599,12 @@ void tst_cgroup_require(const char *const ctrl_name,
>>         struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
>>         struct cgroup_root *root;
>>
>> +       if (!ctrl) {
>> +               tst_brk(TBROK, "'%s' controller is unknown to LTP", ctrl_name);
>> +               tst_brk(TBROK, "Calling %s in cleanup?", __func__);
>> +               return;
>
> It'd never go here to perform a return because the first tst_brk
> will break the test directly. And, I don't know why we need the
> second tst_brk to show calling in cleanup, is that possible?

It can return if it is called during cleanup. tst_cgroup_require should
not be called from cleanup. However someone can do it by accident.

We probably need two versions of tst_brk. One which can return if called
from cleanup and one which does not. I suspect most tst_brk callers
assume it will not return. It is really only some safe library functions
which can handle that.



>
>
>> +       }
>> +
>>         if (!options)
>>                 options = &default_opts;
>>
>> --
>> 2.31.1
>>
>>
>> --
>> Mailing list info: https://lists.linux.it/listinfo/ltp
>>


-- 
Thank you,
Richard.
