Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MM0vJ-0004Sy-2R
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2009 14:36:33 +0000
Received: from mail-pz0-f185.google.com ([209.85.222.185])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MM0vI-0002w5-2N
	for ltp-list@lists.sourceforge.net; Wed, 01 Jul 2009 14:36:33 +0000
Received: by pzk15 with SMTP id 15so758107pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 01 Jul 2009 07:36:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1246454022.6978.54.camel@subratamodak.linux.ibm.com>
References: <f5a7b3810906300042w14bc6a4fp8046160d07d8254e@mail.gmail.com>
	<1246360333.4819.53.camel@subratamodak.linux.ibm.com>
	<f5a7b3810907010146s247bfbc0w3e6ca9213a927d7@mail.gmail.com>
	<1246454022.6978.54.camel@subratamodak.linux.ibm.com>
Date: Wed, 1 Jul 2009 19:03:30 +0530
Message-ID: <f5a7b3810907010633y7edfc082n5d8b15d5cd703395@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, Brandon Philips <bphilips@suse.de>, maxin john <maxinbjohn@gmail.com>, Manas Kumar Nayak <maknayak@in.ibm.com>

>> >> After changing the uninitialized to initialized char array of mqname[]
>> >> test case got PASSED.
>> >

>> After patch Results:
>>
>> conformance/interfaces/mq_unlink/speculative/7-2: execution: PASS
>> # ./7-2.test
>> Test PASSED
>
> Thanks. What better way to start July to checkin your patch.

Great News
Thank you... :-)

Best Regards
Naresh Kamboju

>
> Regards--
> Subrata
>
>>
>>
>> Best regards,
>> Naresh Kamboju
>>
>> >
>> >>
>> >>
>> >> Signed-off-by: Naresh Kamboju < naresh.kernel@gmail.com >

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
