Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maxin.john@gmail.com>) id 1Qm4j9-0004hh-6R
	for ltp-list@lists.sourceforge.net; Wed, 27 Jul 2011 14:04:47 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Qm4j5-0000Su-5h
	for ltp-list@lists.sourceforge.net; Wed, 27 Jul 2011 14:04:47 +0000
Received: by gxk3 with SMTP id 3so1383329gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Jul 2011 07:04:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <260174ADA4D63F4AA543B9C81F2DE712B34F@POCITMSEXMB01.LntUniverse.com>
References: <260174ADA4D63F4AA543B9C81F2DE712B34F@POCITMSEXMB01.LntUniverse.com>
Date: Wed, 27 Jul 2011 17:04:37 +0300
Message-ID: <CAMhs6YzX0srwbYm778ro7o7zLGKZfmpqrRaPUgBTzX+a4arRCQ@mail.gmail.com>
From: Maxin B John <maxin.john@gmail.com>
Subject: Re: [LTP] How to test Linux Kernel using LTP on Beagleboard (ARM
 Cortex-A8 based board)
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
To: G Rajender <G.Rajender@lnties.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi Rajender,

On Wed, Jul 27, 2011 at 4:45 PM, G Rajender <G.Rajender@lnties.com> wrote:
> Hi all,
>
>
>
> Can LTP (Linux Test Project) be ported to Embedded boards like Beagleboard
> or beagle clone boards.
> Or
>
> Can LTP runs and test the linux kernel on Beagleboard (Embedded boards or
> Target boards).

The answer is "Yes".

>
> If Yes please share the procedure of how to test kernel using LTP on
> beagleboard (Target board or Embedded board).
>

You need to cross-compile the LTP source using the proper toolchain.
For the  Beagleboard, you can use the Codesourcery tool-chain (can be
downloaded from:
http://www.codesourcery.com/sgpp/lite/arm/portal/release1803).

We can easily build LTP for Beagleboard using the Scratchbox. More
info is available in the below give link:
  http://felipec.wordpress.com/2009/06/07/installing-scratchbox-1-and-2-for-arm-cross-compilation/

Previous discussions on cross-compiling LTP is available here:
http://osdir.com/ml/linux.ltp/2005-06/msg00023.html

Hope this helps.

Warm Regards,
Maxin

------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
