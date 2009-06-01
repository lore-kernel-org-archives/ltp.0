Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rohit.170309@gmail.com>) id 1MB6xz-0002jQ-EO
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2009 12:50:15 +0000
Received: from fg-out-1718.google.com ([72.14.220.155])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MB6xu-0007i9-K9
	for ltp-list@lists.sourceforge.net; Mon, 01 Jun 2009 12:50:15 +0000
MIME-Version: 1.0
In-Reply-To: <1243601687.5188.34.camel@subratamodak.linux.ibm.com>
References: <20090526142706.20166.3813.sendpatchset@subratamodak.linux.ibm.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0158B359A4@exch.hq.tensilica.com>
	<d51f89b0905262344h46722756vb255541a47904dbe@mail.gmail.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0158B35AB4@exch.hq.tensilica.com>
	<1243434255.10447.19.camel@subratamodak.linux.ibm.com>
	<522C1DF17AF50042AD8AE87F7887BD3D0158B35ACE@exch.hq.tensilica.com>
	<1243601687.5188.34.camel@subratamodak.linux.ibm.com>
Date: Mon, 1 Jun 2009 18:17:00 +0530
Message-ID: <d51f89b0906010547r675533b2v2a2d36a7c07beba9@mail.gmail.com>
From: rohit verma <rohit.170309@gmail.com>
Subject: Re: [LTP] [PATCH] Detect test results more accurately when
	generating HTML
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
Cc: Ltp-List <ltp-list@lists.sf.net>

Hi Subrata,

PFA the patch for the changes to pan driver for a possible fix to the
report generation issue.

I have modified genhtml.pl script to reflect changes in pan driver.

Note: The 'Initiation-status' column is now present after Test-output column.

Please check the same and provide your feedback.

Regards,
Rohit.

On Fri, May 29, 2009 at 6:24 PM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> On Wed, 2009-05-27 at 07:58 -0700, Marc Gauthier wrote:
>> Subrata Modak wrote:
>> > On Wed, 2009-05-27 at 05:05 -0700, Marc Gauthier wrote:
>> > > Just so you know, the updated genhtml.pl script recently submitted
>> > > should work just fine without changes, when moving status after
>> > > <<<execution_status>>> (it only looks at tag names, not positions).
>> >
>> > Be careful, it looks for <<<execution_status>>> only in between
>> > <<test_start>> & <<test_output>>.
>>
>> You mean, between <<<test_start>>> and <<<test_end>>> ?
>> (the script I submitted recently that is, was careful about this)
>
> You made changes in genhtml.pl. I want the change(s) in ltp-pan.c.
>
> Regards--
> Subrata
>
>>
>> -Marc
>
>

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
