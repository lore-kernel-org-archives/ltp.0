Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Doug.Boari@cubic.com>) id 1Oh0Xu-00085d-St
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 13:31:42 +0000
Received: from exprod6og109.obsmtp.com ([64.18.1.23])
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1Oh0Xt-0004kS-KE
	for ltp-list@lists.sourceforge.net; Thu, 05 Aug 2010 13:31:42 +0000
Received: from bb-corp-ex4.corp.cubic.cub ([149.63.2.70])
	by bb-corp-outmail1.corp.cubic.com (8.13.1/8.13.1) with ESMTP id
	o75DVZhe000422
	for <ltp-list@lists.sourceforge.net>; Thu, 5 Aug 2010 06:31:35 -0700
Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Thu, 5 Aug 2010 14:31:31 +0100
Message-ID: <6A4A1EB0E8FDFB46AC5D6C392E82277006AAB65B@me-ex1.ctsl.cubic.cub>
In-Reply-To: <AANLkTikECYvNp3eH25fRB0Gptf8vMYYYr7T350_rnOQF@mail.gmail.com>
References: <6A4A1EB0E8FDFB46AC5D6C392E82277006AAB652@me-ex1.ctsl.cubic.cub><AANLkTinmH4_cho+2CGekNFa1=b24wbXvmd6n_3NbBne1@mail.gmail.com>
	<AANLkTikECYvNp3eH25fRB0Gptf8vMYYYr7T350_rnOQF@mail.gmail.com>
From: "Boari, Doug" <Doug.Boari@cubic.com>
Subject: Re: [LTP] Install failure when cross compiling for ARM
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
To: ltp-list@lists.sourceforge.net

Hey Everyone,

Thanks for all your suggestions. Unfortunately nothing worked and I was
still left with the install failure.
The interesting thing is that I did actually write an application called
'testgamma' about 18months ago to see if the gamma functions in SDL
worked with our LCD screen.
I don't know how or where make install was getting this information from
as it doesn't even exist on the filesystem anymore let alone in the LTP
build tree. It definitely wasn't from your build scripts though.

Anyway, I gave it to a colleague to try in his VM and it worked exactly
as it should.

Curiouser and Curiouser!

I now have the install and am about to give it a try.
Thanks again for all your help
Doug
**********************************************************************

This document is intended for, and should only be read by,
those persons to whom it is addressed. Its contents are
confidential and if you have received this message in error,
please delete it. Any form of reproduction, dissemination,
copying, disclosure, modification, distribution and / or
publication of this message without our prior written
consent is strictly prohibited. 

Any views expressed in this message are those of the
individual sender, and do not necessarily represent the
position of CTSL. Furthermore CTSL does not authorise
or use e-mail for official contractual correspondence. 
Nothing received in e-mail has any contractual validity.

CTSL and each legal entity in Cubic Corporation reserve 
the right to monitor all e-mail communications through
its networks.

Registered Office:
Cubic Transportation Systems Ltd
AFC House
Honeycrock Lane
Salfords
Surrey
RH1 5LA
United Kingdom

Registered in England under number 01381707
**********************************************************************


------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
