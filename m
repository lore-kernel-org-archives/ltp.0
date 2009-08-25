Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <anton.pak@pigeonpoint.com>) id 1MfoqK-0003W3-3X
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 05:45:16 +0000
Received: from [209.59.14.42] (helo=pigeonpoint.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MfoqE-00072z-3F
	for ltp-list@lists.sourceforge.net; Tue, 25 Aug 2009 05:45:16 +0000
Message-ID: <41008.95.24.171.156.1251178978.squirrel@mail.pigeonpoint.com>
In-Reply-To: <1251162918.4388.33.camel@OSLORic>
References: <364299f40908191611x4accc24yc36b344956c7a40c@mail.gmail.com>
	<1251162918.4388.33.camel@OSLORic>
Date: Tue, 25 Aug 2009 01:42:58 -0400 (EDT)
From: anton.pak@pigeonpoint.com
MIME-Version: 1.0
Subject: Re: [LTP] [Openhpi-devel] [PATCH] Cross-compile configure bug
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
To: openhpi-devel@lists.sourceforge.net
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hello!

We have the following lines in include/SaHpi.h:

typedef unsigned char     SaHpiUint8T;
typedef unsigned short    SaHpiUint16T;
typedef unsigned int      SaHpiUint32T;
typedef signed char       SaHpiInt8T;
typedef signed short      SaHpiInt16T;
typedef signed int        SaHpiInt32T;

Also I suspect there can be marshalling issues, i.e. when
daemon on platform with sizeof(int) == 4 but library is not and vice versa.

   Anton Pak


> Hi Garrett,
>
> I was wondering about your addition of the cross_compiling test. If
> there is OpenHPI code that may behave badly on a system where an int
> isn't 4 bytes, I'm thinking that a warning should be issued even for a
> cross compile to such an architecture as well. Like:
>
> if test "x$OH_SIZEOF_INT" != "x4"; then
>     AC_MSG_WARN([
> *** int is not 4 bytes, it is $OH_SIZEOF_INT bytes on this platform
> *** undefined behavior may result from this.
> ])
> fi
>
> Will having a warning instead of an error cause problems for LTP when
> cross compiling?
>
> Does anyone else in the OpenHPI community oppose changing this error to
> a warning?
>
> Best Regards,
> Ric White
>
>
> On Wed, 2009-08-19 at 23:11 +0000, Garrett Cooper wrote:
>> Hi,
>>     Found this bug while trying to cross-compile with the
>> openhpi-test-suite in LTP, and made the ERROR into WARN. Please fix
>> this item as per the attached patch.
>> Thanks,
>> -Garrett
>>
>> PS Please CC my address in all correspondence w.r.t. this email thread.
>>
>> Summary:
>>
>> 1. int != 4 shouldn't be checked for while cross-compiling.
>> 2. Warn instead of erroring out, because we have a _lot_ of 64-bit
>> platforms that we test on which will be negatively impacted by this
>> check.
>>
>> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>>
>> ---
>> /nfs.mac/ltp-upgrade/contrib/ltp/src/testcases/open_hpi_testsuite//configure.ac.orig	2009-08-19
>> 16:04:08.000000000 -0700
>> +++
>> /nfs.mac/ltp-upgrade/contrib/ltp/src/testcases/open_hpi_testsuite//configure.ac	2009-08-19
>> 16:10:47.000000000 -0700
>> @@ -44,14 +44,13 @@
>>  AC_PROG_LN_S
>>  AC_PROG_MAKE_SET
>>
>> -dnl die on int != 32bits.  This is too instrumental to our code right
>> now.
>> +dnl Warn when int != 32bits.  This is too instrumental to our code
>> right now.
>>  dnl AC_MSG_CHECKING(int is 4 bytes)
>>  OH_SET_SIZES
>> -if test "x$OH_SIZEOF_INT" != "x4"; then
>> -    AC_MSG_ERROR([
>> +if test x$cross_compiling != xyes && test "x$OH_SIZEOF_INT" != "x4";
>> then
>> +    AC_MSG_WARN([
>>  *** int is not 4 bytes, it is $OH_SIZEOF_INT bytes on this platform
>> -*** undefined behavior will result
>> -*** please contact the openhpi development team to fix this
>> +*** undefined behavior may result from this.
>>  ])
>>  fi
>>
>> ------------------------------------------------------------------------------
>> Let Crystal Reports handle the reporting - Free Crystal Reports 2008
>> 30-Day
>> trial. Simplify your report design, integration and deployment - and
>> focus on
>> what you do best, core application coding. Discover what's new with
>> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
>> _______________________________________________
>> Openhpi-devel mailing list
>> Openhpi-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openhpi-devel
>
>
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008
> 30-Day
> trial. Simplify your report design, integration and deployment - and focus
> on
> what you do best, core application coding. Discover what's new with
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Openhpi-devel mailing list
> Openhpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openhpi-devel
>



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
