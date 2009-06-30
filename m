Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MLd4C-0000iR-BC
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 13:08:08 +0000
Received: from qw-out-1920.google.com ([74.125.92.148])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLd4B-0005bb-Bj
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 13:08:08 +0000
Received: by qw-out-1920.google.com with SMTP id 5so45323qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Jun 2009 06:07:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1246356254.4819.39.camel@subratamodak.linux.ibm.com>
References: <f5a7b3810906250517k3b8c3bf3gde1957e93c95314@mail.gmail.com>
	<1246015980.6196.20.camel@subratamodak.linux.ibm.com>
	<1246347680.4819.31.camel@subratamodak.linux.ibm.com>
	<f5a7b3810906300250o6ee16e3bv672ad77018d34a81@mail.gmail.com>
	<1246356254.4819.39.camel@subratamodak.linux.ibm.com>
Date: Tue, 30 Jun 2009 18:29:04 +0530
Message-ID: <f5a7b3810906300559s5be55da1h477fba50da33e3e4@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [PATCH] Re::personality test case build fails
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
Cc: Jiri Palecek <jpalecek@web.de>, Pradeep K Surisetty <pradeepkumars@in.ibm.com>, ltp-list@lists.sourceforge.net

>> >
>> > Naresh ??
>>
>> Hi Subrata,
>>
>> I have noticed some issue with personality01.c and personality02.c
>> test cases in design.
>
> Great. And what design reviews for the newly ported tests in LTP ?


The personality is different for diff ARCH and there are 23
personalities are available. present test case is design to support
X86 ARCH .Currently checking applicability and making the test cases
as generic to support most of the ARCH.

This is commented test cases under syscalls on ver 1.154

http://ltp.cvs.sourceforge.net/viewvc/ltp/ltp/runtest/syscalls?view=log


#  The personality() system call is poorly documented
#  and difficult to figure out how to use by looking
#  at the different architecture specific kernel files.
#personality01 personality01
#personality02 personality02

Subrata,

Do you want to include these test cases in this release?

If you have issues please let me know.

Best regards,
Naresh Kamboju

>
> Regards--
> Subrata
>
>> Currently I am investigating and get back to in short.
>>
>> Best Regards
>> Naresh Kamboju
>>
>> >
>> >> Regards--
>> >> Subrata
>> >>
>> >> > Jiri,
>> >> > I think you are doing Multi ARCH support right?
>> >> >
>> >> > Your suggestions are welcome :)
>> >> >
>> >> > Best regards
>> >> > Naresh Kamboju
>>
>> >> ------------------------------------------------------------------------------
>> >> _______________________________________________
>> >> Ltp-list mailing list
>> >> Ltp-list@lists.sourceforge.net
>> >> https://lists.sourceforge.net/lists/listinfo/ltp-list
>> >
>> >
>
>

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
