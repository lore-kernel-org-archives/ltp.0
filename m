Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <leon.woestenberg@gmail.com>) id 1M7qhV-0000MA-HZ
	for ltp-list@lists.sourceforge.net; Sat, 23 May 2009 12:51:45 +0000
Received: from yx-out-1718.google.com ([74.125.44.153])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M7qhQ-0000Wl-Vm
	for ltp-list@lists.sourceforge.net; Sat, 23 May 2009 12:51:45 +0000
Received: by yx-out-1718.google.com with SMTP id 6so1208772yxn.82
	for <ltp-list@lists.sourceforge.net>;
	Sat, 23 May 2009 05:51:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1242975141.8760.12.camel@subratamodak.linux.ibm.com>
References: <1238499818.6818.25.camel@subratamodak.linux.ibm.com>
	<c384c5ea0905151027x5a74ee85l294616e0ddae41ce@mail.gmail.com>
	<200905160936.31857.vapier@gentoo.org>
	<1242648066.5161.18.camel@subratamodak.linux.ibm.com>
	<1242975141.8760.12.camel@subratamodak.linux.ibm.com>
Date: Sat, 23 May 2009 14:51:39 +0200
Message-ID: <c384c5ea0905230551q26216366pc9fd1cefecf00ac4@mail.gmail.com>
From: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been Released for
	MARCH 2009
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
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

Hello Subrata,

On Fri, May 22, 2009 at 8:52 AM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Mon, 2009-05-18 at 17:31 +0530, Subrata Modak wrote:
>> On Sat, 2009-05-16 at 09:36 -0400, Mike Frysinger wrote:
>> > On Friday 15 May 2009 13:27:50 Leon Woestenberg wrote:
>> > > 2009/3/31 Subrata Modak <subrata@linux.vnet.ibm.com>:
>> > > > Dear All,
>> > > >
>> > > > The Linux Test Project test suite has been released for the month of
>> > > > MARCH 2009. Please see ltp/INSTALL file carefully, as, there has been
>> > >
>> > > OpenEmbedded builds LTP for a large number of machines / architectures.
>> > >
>> > > JFYI, The LTP January release required some patches, especially in the
>> > > area of cross-compilation:
>> >
>> > then someone should be submitting them so we can give feedback and they'll
>> > update/re-submit
>>
>> True,
>>
>> Please submit them to the LTP mailing list.
>
> Any consideration to submit these to the list soon ?
>
No, I think our current workarounds are indeed ugly ("works-for-us")
hacks to make the LTP project cross-compile.

Mike mentioned a few improvements that need to be addressed.
It's hard to find people willing to address cross-compile support
issue once a working hack is in place.


Regards,
-- 
Leon

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
