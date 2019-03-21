From: Vineet Gupta <vineet.gupta1@synopsys.com>
Date: Thu, 21 Mar 2019 15:48:35 +0000
Subject: [LTP] [PATCH v2] autodetect fts support and tests depending on
	it
References: <20190318181940.GA5494@dell5510>
 <1552938764-15101-1-git-send-email-vgupta@synopsys.com>
 <20190320223733.GA5619@dell5510>
 <3601d849-46fa-b9cd-0a6d-882c8ed9c73f@synopsys.com>
 <20190321120645.GB17345@dell5510>
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014643D857@US01WEMBX2.internal.synopsys.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 3/21/19 5:06 AM, Petr Vorel wrote:
> Hi Vineet,
>
>> On 3/20/19 3:37 PM, Petr Vorel wrote:
>>>> +# controllers/cpuset/cpuset_lib/libcpuset.c uses fts
>>>> +# which may not be available/configured in the libc build
>>>> +ifndef HAVE_FTS_H
>>>> +FILTER_OUT_DIRS	+= cpuset
>>>> +endif
>>> Have you tested it? 
>> Absolutely. I verified again. With this patch reverted locally I see errors due to
>> it trying to build the file
> I meant testing with glibc :). 

No I didn't. Sorry missed that aspect of testing.

> Because your patch would bring a regression:
> ifndef HAVE_FTS_H is always true because HAVE_FTS_H as an autotools check is not
> visible to make in this form, no matter what it's set to HAVE_FTS_H in
> include/config.h :(.

OK makes sense.

> We could solve previous problem to make HAVE_FTS_H visible with AC_SUBST, while
> creating proper autotools function check in m4/. Planning to do that? (if not
> I'll do).

It seems you already have a good grasp of both the problem I was trying to solve
and the solution, latter I'll have to dig into myself - not necessarily rocket
science but still. So please go ahead and do that if you have spare cycles.

> My thoughts about dependency problem in shell scripts (TST_TEST_TCONF) was wrong
> as these tests are also under cpuset directory.

OK !

Thx,
-Vineet
