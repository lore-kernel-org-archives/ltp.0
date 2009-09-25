Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mr3IU-0005sE-J7
	for ltp-list@lists.sourceforge.net; Fri, 25 Sep 2009 05:24:46 +0000
Received: from mail-qy0-f204.google.com ([209.85.221.204])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mr3IO-0006Q3-BY
	for ltp-list@lists.sourceforge.net; Fri, 25 Sep 2009 05:24:46 +0000
Received: by qyk42 with SMTP id 42so1975650qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 24 Sep 2009 22:24:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b9d696240909241328p25fdc8dcrac4f8bbfa4adad23@mail.gmail.com>
References: <200909241229.32866.chandru@in.ibm.com>
	<b9d696240909241328p25fdc8dcrac4f8bbfa4adad23@mail.gmail.com>
Date: Thu, 24 Sep 2009 22:24:34 -0700
Message-ID: <364299f40909242224k55db7eaak8cc8b97e32d79788@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] ppoll01: add signal() syscall to register the
	signal handler
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
To: "K.D. Lucas" <kdlucas@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Sep 24, 2009 at 1:28 PM, K.D. Lucas <kdlucas@gmail.com> wrote:
> I applied this patch, and it fixed ppoll01 on an Ubuntu Hardy box which h=
ad
> been failing. Kernel is 2.6.24.
>
> Kelly
>
> On Wed, Sep 23, 2009 at 11:59 PM, Chandru <chandru@in.ibm.com> wrote:
>>
>> The ppoll01 testcase has a signal handler in it but this signal handler =
is
>> not registered with the kernel through the signal() syscal. The testcase
>> fails when it sends a SIGINT to itself as part of one of the case of the
>> test run.
>> The following patch
>> 1. Adds a signal() syscall to register the signal handler
>> 2. Corrects the expected 'revents' for the case where ppoll() is called =
on
>> a file which is only opened in read/write mode, i.e case00.
>> 3. Takes away printing the type of error ( i.e strerror(errno) ) since it
>> only prints the last error seen and does not report the failures seen in=
 the
>> cases before the last failed one. The reporting of NG or OK shoudl take =
care
>> of
>> =A0 =A0letting the user know the cases that have passed and cases that h=
ave
>> failed.
>>
>> Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>

...

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(T=
FAIL, "%s failed - errno =3D %d :
>> %s", TCID, TEST_ERRNO, strerror(TEST_ERRNO));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(T=
FAIL, "%s failed", TCID);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0RPRINTF("=
NG");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cleanup();
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tst_exit(=
);

Please don't change that line.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
