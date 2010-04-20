Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O47PY-00076g-H9
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 06:58:20 +0000
Received: from mail-gx0-f213.google.com ([209.85.217.213])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O47PX-00072R-QU
	for ltp-list@lists.sourceforge.net; Tue, 20 Apr 2010 06:58:20 +0000
Received: by gxk5 with SMTP id 5so3275264gxk.6
	for <ltp-list@lists.sourceforge.net>;
	Mon, 19 Apr 2010 23:58:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BCCCAD4.5090300@mvista.com>
References: <h2v72fb0a5c1004160422iaadc7f8p53f73a00d5af088e@mail.gmail.com>
	<4BCCCAD4.5090300@mvista.com>
Date: Mon, 19 Apr 2010 23:58:14 -0700
Message-ID: <q2h364299f41004192358i9eb663ebge891c5ebfb4182f1@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] problem : please help !!!
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
To: raahul4321@gmail.com
Cc: ltp-list@lists.sourceforge.net

On Mon, Apr 19, 2010 at 2:27 PM, Henry Yei <hyei@mvista.com> wrote:
> On 04/16/2010 04:22 AM, rahul agarwal wrote:
>> I am running the ltp suite on my embedded system and the following two t=
ests
>> are failing :-
>>
>>
>> falloc01 , falloc02 , falloac03 =A0 -> =A0 TFAIL : TEST_ERRNO=3DEFBIG(27=
): File
>> too large
>>
>> clone02, clone03, clone05, clone06 =A0-> =A0TBROK : Unexpected signal 11
>> received
>>
>>
>> I have tried everything to figure out the cause of these test failure bu=
t I
>> still couldn't get the problem solved .
>
> I assume you mean fallocate01, 02, 03, etc. Are you running these on
> ext4 or other filesystem that supports the fallocate calls
> (preallocation feature)?
>
> Your architecture may also hit a problem with the tests.
>
>
> Here are some notes I had with the fallocate tests from a few months
> back that may interest you:
>
> On a couple of architectures (arm, mips) that the original authors never
> tested on, fallocate calls are returning EFBIG (file too large) rather
> than EOPNOTSUPP(not supported) like they are on pcc, and x86 architecture=
s.
>
> I've run it on x86_64 Ubuntu 9.04 with an ext4 system, and the tests
> also seem to fail with EFBIG, when they should pass AFAICT.

Rahul,
    I never ran into this issue on i686, mips*, ppc, or x86_64 when I
used to run these tests to validate releases, but I haven't actively
run LTP for several months, and my environment most likely varied from
your's.
    For starters, read the note about EFBIG for fallocate(2):
http://www.kernel.org/doc/man-pages/online/pages/man2/fallocate.2.html
. After you've done that, do some additional research to solve your
problem:

1. Consider where the file is being is being created (hint: if you
haven't defined $TMPDIR, it's /tmp). Consider what filesystem that
directory is running.
2. Determine what the size of the file is that's being created
(compile the application with -g, run with gdb, determine the size,
etc).
3. Try creating the file with that size.

    Does step 3. pass or fail?
    Once you have these bits, please provide us with the details as
well as your kernel version, architecture, etc.
    We can give you the answer or teach you how to fish. I think that
teaching you how to fish is more worthwhile than fishing for you,
especially when LTP is a group of volunteers interested in testing on
Linux, not a support group.
    We can help you solve your problem if you get stuck, but please do
the initial legwork to help us help you.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
