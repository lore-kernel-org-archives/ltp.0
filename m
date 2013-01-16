Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1TvTyq-0002RA-SU
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 14:28:40 +0000
Received: from mail-qa0-f44.google.com ([209.85.216.44])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TvTyn-0002m8-Gc
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 14:28:40 +0000
Received: by mail-qa0-f44.google.com with SMTP id z4so3366919qan.3
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Jan 2013 06:28:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <50F6B2EF.70007@linux.vnet.ibm.com>
References: <CA+icZUUsDzP+uLWD0i=JpMSiK1Qu3Pdux19rE7wTeJJu+-FaZw@mail.gmail.com>
	<50F6B2EF.70007@linux.vnet.ibm.com>
Date: Wed, 16 Jan 2013 15:28:31 +0100
Message-ID: <CA+icZUVRe5yzkkcO3_Lvvkmr53pZ9HmS40GgDGqd3GFdJkLqNA@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [LTP] Spelling "succeded" VS. "succeeded"
Reply-To: sedat.dilek@gmail.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: shubham <shubham@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Jan 16, 2013 at 3:02 PM, shubham <shubham@linux.vnet.ibm.com> wrote:
> On 01/16/2013 06:45 PM, Sedat Dilek wrote:
>>
>> Hi,
>>
>> this is my first email to the LTP ML, so I am new and anot not
>> familiar with known or unknown conventions here.
>>
>> I am using LTP, to be honest the "lite" test to check my Linux
>> (upstream) and Linux-Next kernels.
>> So, having run "runltplite.sh" successfully gives me a 1st impression
>> or orientation this kernel has no bigger issues.
>>
>> To be honest I have checked with a minimal kernel-setup (a
>> localmodconfig-ed setup with some debugging enabled).
>>
>> While looking trough the results especially searching for some
>> pattern, I noticed the different spelling of the word "succeeded" VS.
>> "succeded".
>> The spell-checker integrated in Firefox v18.0 tells me "succeeded"
>> with double-e is correct.
>>
>> [ SUCCEDED - one "E" ]
>>
>> $ egrep -i 'error|fail'
>> runltplite-results_3.8.0-rc3-next20130116-2-iniza-generic.txt | egrep
>> -i succeded
>> flock01     1  TPASS  :  flock() succeded with Shared Lock, returned
>> error number=0
>> flock01     2  TPASS  :  flock() succeded with Unlock, returned error
>> number=0
>> flock01     3  TPASS  :  flock() succeded with Exclusive Lock,
>> returned error number=0
>>
>> [ SUCCEEDED - double "E" ]
>>
>> $ egrep -i 'error|fail'
>> runltplite-results_3.8.0-rc3-next20130116-2-iniza-generic.txt | egrep
>> -i succeeded
>> madvise02    5  TFAIL  :  madvise succeeded unexpectedly
>> open call succeededopen failed with EACCES as expectedopen call
>> succeeded<<<execution_status>>>
>>
>> AFAICS flock01.c needs to be corrected:
>>
>> --- ltp-full-20120903.orig/testcases/kernel/syscalls/flock/flock01.c
>>   2012-09-03 06:39:27.000000000 +0200
>> +++ ltp-full-20120903/testcases/kernel/syscalls/flock/flock01.c
>> 2013-01-16 14:12:36.597859952 +0100
>> @@ -128,7 +128,7 @@ int main(int argc, char **argv)
>>                                  continue;       /*next loop for MTKERNEL
>> */
>>                          } else {
>>                                  tst_resm(TPASS,
>> -                                        "flock() succeded with %s,
>> returned error number=%d",
>> +                                        "flock() succeeded with %s,
>> returned error number=%d",
>>                                           test_cases[i].opt, TEST_ERRNO);
>>                          }
>>
>> Not sure if you like that patch sent via git-email as a separate patch?
>>
>
> We are not very concerned about some typos in log messages. Please come up
> with a fix for a broken test case or something which will really add a value
> to the LTP. Your patches are welcome. Kindly refer the documentation
> provided with LTP for the format of patch.
>

Hi,

as said I am knew to LTP.

Such a typo makes grepping for special search-patterns difficult.
I was searching for real failures by sorting out "expected" and
"succeeded" lines.
Even this is a trivial fix for you - it helped here :-).

Not sure what you are expecting from me.
Might be I flood ltp-results ML with the results of my Linux-Next kernels.
Unsure if this helps people or not.

Personally, I don't like the outputs of results...
Especially start/end tags should include the (file)name of the testcase.
But I had no deeper look into the results and only run the "lite" test-script.

Looking into the README file I see I am missing some kernel-configs to
be enabled.
Not sure if I really what to dig that deep into LTP.

Of course, LTP is a helpful testing-framework.
It gives me a better feeling than just only test my kernels...
1. on bare metal (not in any VM)
2. in daily usage

I could catch a madvise regression in Linux-Next and reported it.

Thanks!

Regards,
- Sedat -

[1] http://marc.info/?l=linux-next&m=135819894717604&w=2

> Thanks
>

------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
