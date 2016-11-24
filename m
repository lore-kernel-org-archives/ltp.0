From: Li Wang <liwang@redhat.com>
Date: Thu, 24 Nov 2016 18:08:55 +0800
Subject: [LTP] [PATCH] cgroup: fix mount errors on cgroup subsys
In-Reply-To: <20161123123521.GE3346@rei.lan>
References: <1479899346-4261-1-git-send-email-liwang@redhat.com>
 <20161123123521.GE3346@rei.lan>
Message-ID: <CAEemH2eDEy+JHEyJ_NQwMmosXsBmrUYoPan1ACWwjAgzR_wy6Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 23, 2016 at 8:35 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> ---
>>  .../controllers/cgroup/cgroup_regression_test.sh   | 46 +++++++++++++++++++++-
>>  1 file changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> index 30d0dbf..971243f 100755
>> --- a/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> +++ b/testcases/kernel/controllers/cgroup/cgroup_regression_test.sh
>> @@ -181,10 +181,17 @@ test_3()
>>               return
>>       fi
>>
>> +     local cpu=cpu
>> +
>> +     # For rhel7.3 or later, cpu is always binding with cpuacct subsys
>> +     if grep -w cpu /proc/mounts ; then
>> +             cpu=$(basename $(grep -w cpu /proc/mounts | cut -d ' ' -f 2))
>> +     fi
>> +
>>       # Run the test for 30 secs
>> -     mount -t cgroup -o cpu xxx cgroup/
>> +     mount -t cgroup -o $cpu xxx cgroup/
>>       if [ $? -ne 0 ]; then
>> -             tst_resm TFAIL "Failed to mount cpu subsys"
>> +             tst_resm TFAIL "Failed to mount $cpu subsys"
>>               failed=1
>>               return
>>       fi
>
> Why can't we mount the cgroup only when it's not mounted yet and
> use the path it's mounted on otherwise? We do that for the functional
> tetscases already.

I thought that the original case including cgroup mounted test, so I
unmount the system cgroup and do itself mount & testing there.

>
> And I do not think that umounting system cgroups is a good idea either.
> I would say that the test should use whatever is mounted on the system
> and if that is not possible I would rather produce TCONF than fiddle
> with umounting cgroups from the standard system path.

Using system cgroups is not a bad idea, I hesitated about doing that
or just doing tiny fix. now you help me make a decision.

Thanks for your comments, I will rewrite this PATCH.

-- 
Regards,
Li Wang
Email: liwang@redhat.com
