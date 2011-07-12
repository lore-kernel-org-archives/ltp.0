Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1QggPj-00051E-9Z
	for ltp-list@lists.sourceforge.net; Tue, 12 Jul 2011 17:06:27 +0000
Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QggPf-0003CF-8T
	for ltp-list@lists.sourceforge.net; Tue, 12 Jul 2011 17:06:27 +0000
Received: by vxa37 with SMTP id 37so5324888vxa.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jul 2011 10:06:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E1C6FCE.1010402@st.com>
References: <4e1c09b0.04af2a0a.2ccb.ffffab1eSMTPIN_ADDED@mx.google.com>
	<CAGH67wQ4knG70q-bpPV0fmTOsmf9ciyPN-k65M=ysMk1o5_uFg@mail.gmail.com>
	<4E1C6FCE.1010402@st.com>
Date: Tue, 12 Jul 2011 10:06:17 -0700
Message-ID: <CAGH67wQukZnBezvFWZz8uGzsqoeErzijPASKc3woJjHCuzWJbw@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Added proper return code (TPASS) in case of exit
 without errors.
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
To: Carmelo AMOROSO <carmelo.amoroso@st.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Jul 12, 2011 at 9:01 AM, Carmelo AMOROSO <carmelo.amoroso@st.com> w=
rote:
> On 12/07/2011 16.38, Garrett Cooper wrote:
>> On Tue, Jul 12, 2011 at 1:45 AM, Francesco RUNDO <francesco.rundo@st.com=
> wrote:
>>> From: Francesco Rundo <francesco.rundo@st.com>
>>>
>>> The "kill05" testcase checks if EPERM is correctly raised by the system.
>>> The testcase manages the error exit codes correctly while it didn't ret=
urn
>>> any exit code in case of no errors occured i.e. the system has raised E=
PERM.
>>> The correct exit-code "TPASS" has been added in case of the test works =
fine without
>>> errors.
>>>
>>> Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
>>> Reviewed-by: Carmelo Amoroso <carmelo.amoroso@st.com>
>>
>> =A0 =A0 Please properly styleize this; this doesn't conform to Linux
>> coding standards..
>
> I've noted there is a trailing white space ?
> is this the only problem ?

    No. Many software projects written in C, python, etc don't allow
conditionals with inline test statements, e.g.

    if (foo) bar;

    This is almost always done like 1):

    if (foo)
        bar;

    or 2):

    if (foo) {
        bar;
    }

    See K&R and the LKML for more details on what should be done.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
AppSumo Presents a FREE Video for the SourceForge Community by Eric =

Ries, the creator of the Lean Startup Methodology on "Lean Startup =

Secrets Revealed." This video shows you how to validate your ideas, =

optimize your ideas and identify your business strategy.
http://p.sf.net/sfu/appsumosfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
