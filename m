From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Jun 2020 09:54:57 +0800
Subject: [LTP] [PATCH] clocks/invaliddates.c: relax acceptable delta
In-Reply-To: <CAEemH2fgg9KOO5KxTwr0LpGdL2X0p_aGefNuwQQjajkRNJKk9Q@mail.gmail.com>
References: <53a3e9975f00c50c78528994472ec7e9f8adeb90.1592475774.git.jstancek@redhat.com>
 <CAEemH2fgg9KOO5KxTwr0LpGdL2X0p_aGefNuwQQjajkRNJKk9Q@mail.gmail.com>
Message-ID: <CAEemH2cGcAGuL-sJsLWJdfvKUc+05pyTiZyV9GoVo0ktf_Mxvw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Li Wang <liwang@redhat.com> wrote:


> On Thu, Jun 18, 2020 at 6:24 PM Jan Stancek <jstancek@redhat.com> wrote:
>
>> Test allows just 5ms delta for PASS, and test randomly fails in
>> environments with shared resources and increased steal time.
>>
>> Relax the condition and also print deltas if test fails.
>> Remove DEBUG ifdefs and main parameters to avoid unused variable
>> warning.
>>
>> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>> ---
>>  .../functional/timers/clocks/invaliddates.c   | 25 +++++++------------
>>  1 file changed, 9 insertions(+), 16 deletions(-)
>>
>> diff --git
>> a/testcases/open_posix_testsuite/functional/timers/clocks/invaliddates.c
>> b/testcases/open_posix_testsuite/functional/timers/clocks/invaliddates.c
>> index face334fd250..d4116b1e9bc0 100644
>> ---
>> a/testcases/open_posix_testsuite/functional/timers/clocks/invaliddates.c
>> +++
>> b/testcases/open_posix_testsuite/functional/timers/clocks/invaliddates.c
>> @@ -18,8 +18,7 @@
>>
>>  #define NUMTESTS 5...
>>
>> -#define ACCEPTABLESECDELTA 0
>> -#define ACCEPTABLENSECDELTA 5000000
>> +#define ACCEPTABLESECDELTA 2
>>
>
> It's hard to say what size of the second-delta is a proper value, but to
> increase it can obviously decrease the failure probability. If there is no
> better way I'd go with this patch.
>

But in another word, this test is just focused on invalid dates[1], so
the deviation(caused by sharing resource) in seconds(even 10 seconds) bound
is acceptable I think.

If someone insists to make thing more precise, we can make use of
function tst_is_virt() to apply this method only for virtual machines. But
anyway that's not very important:).

[1].
static int testtimes[NUMTESTS][2] = {
    {INT32_MAX, 999999999}, // large number
    {946713600, 999999999}, // Y2K - Jan 1, 2000
    {951811200, 999999999}, // Y2K - Feb 29, 2000
    {1078041600, 999999999}, // Y2K - Feb 29, 2004
    {1049623200, 999999999}, // daylight savings 2003
};

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200619/32028224/attachment.htm>
