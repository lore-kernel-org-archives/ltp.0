Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OwT3J-00078X-Aa
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 05:00:01 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OwT3I-0004L4-Gn
	for ltp-list@lists.sourceforge.net; Fri, 17 Sep 2010 05:00:01 +0000
Received: by gxk10 with SMTP id 10so851467gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 16 Sep 2010 21:59:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <OFC53D59D5.2022C102-ON8525779E.005D5AC2-8525779E.005E5AC9@us.ibm.com>
References: <OFD6B689AE.1AE38E72-ON8525779D.0054A722-8525779E.0049DA86@us.ibm.com>
	<AANLkTimGFWgvZcinBK-SHkY2H-Ew6D+x=L2EyedRQKn4@mail.gmail.com>
	<OFC53D59D5.2022C102-ON8525779E.005D5AC2-8525779E.005E5AC9@us.ibm.com>
Date: Thu, 16 Sep 2010 21:59:53 -0700
Message-ID: <AANLkTi=5MUpvY3MD4xOMaLGG3p+GM62vM7srii-JRLor@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] 20100831 release hugetlb tests bug and patch (re-post
 with sign-off line)
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
To: Scott Romanowski <romansc@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Sep 14, 2010 at 10:10 AM, Scott Romanowski <romansc@us.ibm.com> wro=
te:
> Garrett Cooper <yanegomi@gmail.com> wrote on 09/14/2010 12:43:47 PM:
>> 1. It doesn't make sense why you're doing this, unless you're
>> purposely trying to impose a limit to get the consumer to fail on the
>> next round. What happens if you make this 0 instead?
>
> You're right; this should be 0. =A0I foolishly just copied the structure =
from
> the functions above.

Ok.

>> 2. Also, have you tried inverting the logic to test out whether or not
>> this case functions as expected (i.e. #ifndef __linux__ ... #else
>> return (size_t) -1; #endif)?
>> 3. This also exposes type bugs in the tests; example:
>
> I didn't test the LTP on a non-Linux platform. =A0I'm new to this, sorry.

I would just remove the __linux__ check because hugepages are a
Linux-only feature.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
