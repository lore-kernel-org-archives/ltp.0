Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MVkCM-0007OJ-BS
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2009 10:46:22 +0000
Received: from mail-yx0-f195.google.com ([209.85.210.195])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MVkCB-0005VA-Rr
	for ltp-list@lists.sourceforge.net; Tue, 28 Jul 2009 10:46:17 +0000
Received: by yxe33 with SMTP id 33so6975251yxe.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 28 Jul 2009 03:46:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2E9E6F5F5978EF44A8590E339E888CF901420A78F4@irsmsx503.ger.corp.intel.com>
References: <f5a7b3810907280207v6e88cadaodbc90831d562d4cf@mail.gmail.com>
	<2E9E6F5F5978EF44A8590E339E888CF901420A78F4@irsmsx503.ger.corp.intel.com>
Date: Tue, 28 Jul 2009 16:16:05 +0530
Message-ID: <f5a7b3810907280346x6ba3fccby80e7a66888d0d646@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] Integration of MCE test suite into LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Kleen, Andi" <andi.kleen@intel.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, "Huang,  Ying" <ying.huang@intel.com>

On Tue, Jul 28, 2009 at 2:48 PM, Kleen, Andi<andi.kleen@intel.com> wrote:
>
>
>>With reference to Linux MCE
>>
>>http://kernel.org/pub/scm/utils/cpu/mce/
>>
>>Are you discussing about this?
>
> This is about machine check exception/event, aka hardware errors,
>
> It has nothing to do with "LinuxMCE"

Oops =85 I was confused.
Now it is clear.

MCE: Machine Check Exception  Event .
http://en.wikipedia.org/wiki/Machine_Check_Exception

>
>>Could you list out the hardware and software requirements to run this
>>application as well test suite.
>
> The test suite should run on any hardware that implements
> the standard Intel machine check architecture, which is near
> all x86 CPUs shipped in the last decade.
>
> It doesn't necessarily work in virtual machines.
>
> -Andi

Do you mean it is not compatible with other than X86 Machines?

Thanks for your info Andi :-)

Best regards,
Naresh Kamboju

>

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
