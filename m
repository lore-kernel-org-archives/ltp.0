Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MXyki-00023p-HE
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 14:43:04 +0000
Received: from mail-ew0-f210.google.com ([209.85.219.210])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MXykd-00061k-Qc
	for ltp-list@lists.sourceforge.net; Mon, 03 Aug 2009 14:43:04 +0000
Received: by ewy6 with SMTP id 6so69498ewy.10
	for <ltp-list@lists.sourceforge.net>;
	Mon, 03 Aug 2009 07:42:53 -0700 (PDT)
Message-ID: <4A76F76B.9070704@petalogix.com>
Date: Mon, 03 Aug 2009 16:42:51 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <200907301305.n6UD5G7F023361@e32.co.us.ibm.com>
	<1249298406.7460.25.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1249298406.7460.25.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] Make the test result codes a real bitfield again
Reply-To: michal.simek@petalogix.com
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
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>, Jiri Palecek <jpalecek@web.de>

Hi Mike and Subrata,
> Mike,
>
> You would need to see this.
>   
Jiri is right. I sent one email about some minutes ago (but not solution).
Please ignore my email and add this change. I tested it and works.

BTW: I haven't seen that Mike's patches on mailing list.

Thanks,
Michal

> Regards--
> Subrata
>
> On Thu, 2009-07-30 at 11:57 +0200, Jiri Palecek wrote: 
>   
>> Hello,
>>
>> the commit "extend the test result to a bit field so we can extend the output further" from July 20th unfortunately changes the code, that was previously a bitfield, to a non-bitfield. This causes FAILED tests to return erroneously 0.
>>
>> This patch changes the test result codes to be individual bits in the bitfield (effectively reverting  a small part of aforementioned patch).
>>
>> Regards
>>     Jiri Palecek
>>
>> ---
>>  include/test.h |   12 ++++++------
>>  1 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/test.h b/include/test.h
>> index 5c325b3..4d9803a 100644
>> --- a/include/test.h
>> +++ b/include/test.h
>> @@ -44,15 +44,15 @@
>>
>>  #include "compiler.h"
>>
>> -/* Use low 4 bits to encode test type */
>> -#define TTYPE_MASK 0xf
>> +/* Use low 6 bits to encode test type */
>> +#define TTYPE_MASK 0x3f
>>  #define TPASS      0    /* Test passed flag */
>>  #define TFAIL      1    /* Test failed flag */
>>  #define TBROK      2    /* Test broken flag */
>> -#define TWARN      3    /* Test warning flag */
>> -#define TRETR      4    /* Test retire flag */
>> -#define TINFO      5    /* Test information flag */
>> -#define TCONF      6    /* Test not appropriate for configuration flag */
>> +#define TWARN      4    /* Test warning flag */
>> +#define TRETR      8    /* Test retire flag */
>> +#define TINFO      16   /* Test information flag */
>> +#define TCONF      32   /* Test not appropriate for configuration flag */
>>  #define TTYPE_RESULT(ttype) ((ttype) & TTYPE_MASK)
>>
>>  #define TERRNO     0x100   /* Append errno information to output */
>>     
>
>
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>   


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
