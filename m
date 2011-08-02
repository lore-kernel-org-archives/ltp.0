Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1QoGRT-00030O-O0
	for ltp-list@lists.sourceforge.net; Tue, 02 Aug 2011 14:59:35 +0000
Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QoGRS-0007gL-Qd
	for ltp-list@lists.sourceforge.net; Tue, 02 Aug 2011 14:59:35 +0000
Received: by vws2 with SMTP id 2so7594984vws.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 02 Aug 2011 07:59:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <260174ADA4D63F4AA543B9C81F2DE712B87B@POCITMSEXMB01.LntUniverse.com>
References: <260174ADA4D63F4AA543B9C81F2DE712B34F@POCITMSEXMB01.LntUniverse.com>
	<CAMhs6YzX0srwbYm778ro7o7zLGKZfmpqrRaPUgBTzX+a4arRCQ@mail.gmail.com>
	<260174ADA4D63F4AA543B9C81F2DE712B601@POCITMSEXMB01.LntUniverse.com>
	<CAMhs6Yy76dinKx_SSXfB90+76g3iUL6okPUNgETDMiVHpCrsgw@mail.gmail.com>
	<260174ADA4D63F4AA543B9C81F2DE712B6A2@POCITMSEXMB01.LntUniverse.com>
	<260174ADA4D63F4AA543B9C81F2DE712B7AB@POCITMSEXMB01.LntUniverse.com>
	<CAMhs6Yy17=HN_zc_4yC=1_GYLjisVq6UUR5UU0Kna_Syas154w@mail.gmail.com>
	<260174ADA4D63F4AA543B9C81F2DE712B87B@POCITMSEXMB01.LntUniverse.com>
Date: Tue, 2 Aug 2011 07:59:29 -0700
Message-ID: <CAGH67wTOh0aHCxrS0gdB0CjbBnFfJeNZyD6H9d0ep2MpkKTPhQ@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: G Rajender <G.Rajender@lnties.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Tue, Aug 2, 2011 at 6:27 AM, G Rajender <G.Rajender@lnties.com> wrote:
> Hi Maxin,
>
> Thank you very much for your reply. I have done all the steps that you've=
 mentioned and created LTP-Cross compiled binary images for beagleboard.
>
> I have copied the LTP binaries along with required boot-able &kernel (2.6=
.32) images on to the SD card formating with FAT32 file system. Booted the =
beagleboard =A0and got the command prompt as below and tries to execute "ru=
nalltests.sh" in command prompt. I'm getting the below errors.

...

Use a more recent version of LTP and see if the issues persist.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
BlackBerry&reg; DevCon Americas, Oct. 18-20, San Francisco, CA
The must-attend event for mobile developers. Connect with experts. =

Get tools for creating Super Apps. See the latest technologies.
Sessions, hands-on labs, demos & much more. Register early & save!
http://p.sf.net/sfu/rim-blackberry-1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
