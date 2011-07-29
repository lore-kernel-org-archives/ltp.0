Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <prvs=819194f7e9=G.Rajender@lnties.com>)
	id 1Qmnbd-0000ey-B0
	for ltp-list@lists.sourceforge.net; Fri, 29 Jul 2011 14:00:01 +0000
Received: from mailout2.ltindia.com ([125.18.18.171])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Qmnba-0000wQ-LR
	for ltp-list@lists.sourceforge.net; Fri, 29 Jul 2011 14:00:01 +0000
From: G Rajender <G.Rajender@lnties.com>
Date: Fri, 29 Jul 2011 13:59:46 +0000
Message-ID: <260174ADA4D63F4AA543B9C81F2DE712B6A2@POCITMSEXMB01.LntUniverse.com>
References: <260174ADA4D63F4AA543B9C81F2DE712B34F@POCITMSEXMB01.LntUniverse.com>
	<CAMhs6YzX0srwbYm778ro7o7zLGKZfmpqrRaPUgBTzX+a4arRCQ@mail.gmail.com>
	<260174ADA4D63F4AA543B9C81F2DE712B601@POCITMSEXMB01.LntUniverse.com>
	<CAMhs6Yy76dinKx_SSXfB90+76g3iUL6okPUNgETDMiVHpCrsgw@mail.gmail.com>
In-Reply-To: <CAMhs6Yy76dinKx_SSXfB90+76g3iUL6okPUNgETDMiVHpCrsgw@mail.gmail.com>
Content-Language: en-US
MIME-Version: 1.0
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
To: Maxin B John <maxin.john@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi Maxin,

Thank you very much for reply. Now I understand that I can execute the LTP on target board which tests linux kernel.

I have successfully installed Scratchbox1 and selected the armv7 target in sub-menu. I got shell prompt like "[ sbox- armv7  ~]". I have downloaded the LTP source "ltp-full-20100228.ar.gz" from LTP-web.

Can you please share the procedure of how to Cross-Compile the LTP source code using Scratchbox1 to generate the binaries for the beagleboard.

Thanks in advance for your time.

Rajender


-----Original Message-----
From: Maxin B John [mailto:maxin.john@gmail.com]
Sent: Thursday, July 28, 2011 8:02 PM
To: G Rajender
Subject: Re: [LTP] How to test Linux Kernel using LTP on Beagleboard (ARM Cortex-A8 based board)

Hi Rajender,

Qemu is a machine emulator. If you don't have a particular board, eg:
Beegleboard, you can emulate that board using qemu. So, preparing a cross-compiled binary for Qemu environment is exactly same for the target board.

Once you cross-compile the LTP (using scratchbox or directly using the cross-toolchain), you can transfer the cross-compiled binaries to the board. Transferring process might depend on your setup. Some might prefer to use NFS based user-land. Some might prefer transferring to the board using tftp, wget, ftp, etc. Otherwise, you can copy the LTP binaries to an SD card and then use that binaries from Beegleboard.
Using SD card might create some issues, if it's formatted with FAT file system (due to symbolic link issues for FAT in Gnu/Linux environment).

It's always better to press "Reply-All" option since this was previously discussed in a forum.

Best Regards,
Maxin B. John

On Thu, Jul 28, 2011 at 5:03 PM, G Rajender <G.Rajender@lnties.com> wrote:
> Hi Maxin,
>
> Thanks for your reply.
>
> I have gone through the links you sent to me. Scratch box is toolkit used to cross compile and test the linux kernel in QEMU in Host PC (Ubuntu or any).
>
> But I want to test the linux kernel running on TARGET Board (not on Host PC)  like Beagleboard ( ARM Cortex-a8 based hardware board) using LTP or any other framework. Is this Possible?
>
> If Yes Please share the procedure of how to test the running kernel on Target board ( not QEMU in Host PC).
>
> Thanks in advance.
>
> Rajender
>
>
> -----Original Message-----
> From: Maxin B John [mailto:maxin.john@gmail.com]
> Sent: Wednesday, July 27, 2011 7:35 PM
> To: G Rajender
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] How to test Linux Kernel using LTP on Beagleboard
> (ARM Cortex-A8 based board)
>
> Hi Rajender,
>
> On Wed, Jul 27, 2011 at 4:45 PM, G Rajender <G.Rajender@lnties.com> wrote:
>> Hi all,
>>
>>
>>
>> Can LTP (Linux Test Project) be ported to Embedded boards like
>> Beagleboard or beagle clone boards.
>> Or
>>
>> Can LTP runs and test the linux kernel on Beagleboard (Embedded
>> boards or Target boards).
>
> The answer is "Yes".
>
>>
>> If Yes please share the procedure of how to test kernel using LTP on
>> beagleboard (Target board or Embedded board).
>>
>
> You need to cross-compile the LTP source using the proper toolchain.
> For the  Beagleboard, you can use the Codesourcery tool-chain (can be downloaded from:
> http://www.codesourcery.com/sgpp/lite/arm/portal/release1803).
>
> We can easily build LTP for Beagleboard using the Scratchbox. More info is available in the below give link:
>
> http://felipec.wordpress.com/2009/06/07/installing-scratchbox-1-and-2-
> for-arm-cross-compilation/
>
> Previous discussions on cross-compiling LTP is available here:
> http://osdir.com/ml/linux.ltp/2005-06/msg00023.html
>
> Hope this helps.
>
> Warm Regards,
> Maxin
>
>
> Larsen & Toubro Limited
>
> www.larsentoubro.com
>
> This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
>


Larsen & Toubro Limited

www.larsentoubro.com

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
