Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MLZzX-0007jR-RY
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 09:51:07 +0000
Received: from [209.85.221.200] (helo=mail-qy0-f200.google.com)
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLZzW-0001Hm-Vb
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 09:51:07 +0000
Received: by qyk38 with SMTP id 38so8213qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Jun 2009 02:50:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1246347680.4819.31.camel@subratamodak.linux.ibm.com>
References: <f5a7b3810906250517k3b8c3bf3gde1957e93c95314@mail.gmail.com>
	<1246015980.6196.20.camel@subratamodak.linux.ibm.com>
	<1246347680.4819.31.camel@subratamodak.linux.ibm.com>
Date: Tue, 30 Jun 2009 15:20:46 +0530
Message-ID: <f5a7b3810906300250o6ee16e3bv672ad77018d34a81@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: Jiri Palecek <jpalecek@web.de>, Pradeep K Surisetty <pradeepkumars@in.ibm.com>, ltp-list@lists.sourceforge.net

On Tue, Jun 30, 2009 at 1:11 PM, Subrata
Modak<subrata@linux.vnet.ibm.com> wrote:
> On Fri, 2009-06-26 at 17:03 +0530, Subrata Modak wrote:
>> > >+#ifdef __NR_personality
>> >
>> > Instead of using
>> > #ifdef __NR_personality
>> > =A0in test code, Better we will add these this syscall numbers in the
>> > ltp/testcases/kernel/include/ARCHXXX.in files.
>> > This can be Multi ARCH support.
>> Great. Send me a patch to update them all ;-)
>>
>
> Naresh ??

Hi Subrata,

I have noticed some issue with personality01.c and personality02.c
test cases in design.
Currently I am investigating and get back to in short.

Best Regards
Naresh Kamboju

>
>> Regards--
>> Subrata
>>
>> > Jiri,
>> > I think you are doing Multi ARCH support right?
>> >
>> > Your suggestions are welcome :)
>> >
>> > Best regards
>> > Naresh Kamboju

>> ------------------------------------------------------------------------=
------
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
