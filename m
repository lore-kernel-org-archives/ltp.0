Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MLvT4-0006oO-2b
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2009 08:47:02 +0000
Received: from qw-out-1920.google.com ([74.125.92.148])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLvT2-0007w2-Qj
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2009 08:47:02 +0000
Received: by qw-out-1920.google.com with SMTP id 5so327968qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 01 Jul 2009 01:47:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1246360333.4819.53.camel@subratamodak.linux.ibm.com>
References: <f5a7b3810906300042w14bc6a4fp8046160d07d8254e@mail.gmail.com>
	<1246360333.4819.53.camel@subratamodak.linux.ibm.com>
Date: Wed, 1 Jul 2009 14:16:59 +0530
Message-ID: <f5a7b3810907010146s247bfbc0w3e6ca9213a927d7@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [FIX PATCHES] ltp-mq_unlink_speculative_7-2
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, Brandon Philips <bphilips@suse.de>, maxin john <maxinbjohn@gmail.com>, Manas Kumar Nayak <maknayak@in.ibm.com>

On Tue, Jun 30, 2009 at 4:42 PM, Subrata
Modak<subrata@linux.vnet.ibm.com> wrote:
> Hi Naresh,
>
> On Tue, 2009-06-30 at 13:12 +0530, naresh kamboju wrote:
>> Hi,
>>
>> I have noticed failure under open_posix_testsuite for
>> mq_unlink/speculative/7-2.c and fixed.
>> After changing the uninitialized to initialized char array of mqname[]
>> test case got PASSED.
>
> Great. Could you also please share with us the test results before and
> after this patch ?

Before patch Results:

conformance/interfaces/mq_unlink/speculative/7-2: execution: FAILED
# ./7-2.test
Test FAILED, error is Invalid argument

After patch Results:

conformance/interfaces/mq_unlink/speculative/7-2: execution: PASS
# ./7-2.test
Test PASSED


Best regards,
Naresh Kamboju

>
> Regards--
> Subrata
>
>>
>> I have attached patch and below.
>> Please review the same.
>>
>>
>> Best Regards
>> Naresh Kamboju
>>
>> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >
>>
>>
>> diff -Naurb a/testcases/open_posix_testsuite/conformance/interfaces/mq_u=
nlink/speculative/7-2.c
>> b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/specul=
ative/7-2.c
>> --- a/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/sp=
eculative/7-2.c
>> 2005-06-03 22:00:59.000000000 +0530
>> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_unlink/sp=
eculative/7-2.c
>> 2009-06-30 12:37:35.000000000 +0530
>> @@ -28,7 +28,7 @@
>>
>> =A0int main()
>> =A0{
>> - =A0 =A0 =A0 char mqname[50];
>> + =A0 =A0 =A0 char mqname[50]=3D"/123";
>>
>> =A0// =A0 =A0 sprintf(mqname, FUNCTION "_" TEST "_%d", getpid());
>
>

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
