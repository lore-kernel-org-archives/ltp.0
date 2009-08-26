Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mg7xR-0005JZ-Qk
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 02:09:53 +0000
Received: from qw-out-1920.google.com ([74.125.92.147])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mg7xJ-0001HI-FT
	for ltp-list@lists.sourceforge.net; Wed, 26 Aug 2009 02:09:53 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1706920qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 25 Aug 2009 19:09:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A945616.7000805@canonical.com>
References: <20090824093204.31997.18175.sendpatchset@subratamodak.linux.ibm.com>
	<4A928BD0.4000508@canonical.com>
	<1251195139.5534.32.camel@subratamodak.linux.ibm.com>
	<4A945616.7000805@canonical.com>
Date: Tue, 25 Aug 2009 19:09:39 -0700
Message-ID: <364299f40908251909m7ed3e630r475500b21b16a54f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 00/02] Integrate Valgrind Memory Check Tool to LTP
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
To: Paul Larson <paul.larson@canonical.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Tue, Aug 25, 2009 at 2:22 PM, Paul Larson<paul.larson@canonical.com> wro=
te:
> Subrata Modak wrote:
>
>>> really just to "test the tests", would it make sense to put it under
>>> /scratch or /testscripts as a separate script, rather than just include
>>> it as yet-another-option for runltp?
>>
>> But, creating another script say under testscripts will be to duplicate
>> again runltp code, as the same script should be able to parse all the
>> options what we use with runltp. So, keeping it in runltp will just a
>> little overhead. And, may be we can introduce some longoptions or
>> manpage for ltp as suggested by people earlier !!
>
> It doesn't need to have anywhere near the same options available as
> under runltp. =A0Other than being able to specify a set of tests to run, I
> can't really think of a need for many of the others.

Rather than make runltp into a huge long-options setup, why not
separate out the common functionality in runltp into a library, make
it source-able from runltp, runltp-lite, and whatever script is used
to call valgrind?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
