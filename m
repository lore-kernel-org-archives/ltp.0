Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1QqShZ-0007LV-0S
	for ltp-list@lists.sourceforge.net; Mon, 08 Aug 2011 16:29:17 +0000
Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QqShY-0005SF-0G
	for ltp-list@lists.sourceforge.net; Mon, 08 Aug 2011 16:29:16 +0000
Received: by vws2 with SMTP id 2so2828088vws.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Aug 2011 09:29:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <260174ADA4D63F4AA543B9C81F2DE71214B344@POCITMSEXMB02.LntUniverse.com>
References: <260174ADA4D63F4AA543B9C81F2DE712B34F@POCITMSEXMB01.LntUniverse.com>
	<CAMhs6YzX0srwbYm778ro7o7zLGKZfmpqrRaPUgBTzX+a4arRCQ@mail.gmail.com>
	<260174ADA4D63F4AA543B9C81F2DE712B601@POCITMSEXMB01.LntUniverse.com>
	<CAMhs6Yy76dinKx_SSXfB90+76g3iUL6okPUNgETDMiVHpCrsgw@mail.gmail.com>
	<260174ADA4D63F4AA543B9C81F2DE712B6A2@POCITMSEXMB01.LntUniverse.com>
	<260174ADA4D63F4AA543B9C81F2DE712B7AB@POCITMSEXMB01.LntUniverse.com>
	<CAMhs6Yy17=HN_zc_4yC=1_GYLjisVq6UUR5UU0Kna_Syas154w@mail.gmail.com>
	<260174ADA4D63F4AA543B9C81F2DE712B87B@POCITMSEXMB01.LntUniverse.com>
	<CAGH67wTOh0aHCxrS0gdB0CjbBnFfJeNZyD6H9d0ep2MpkKTPhQ@mail.gmail.com>
	<260174ADA4D63F4AA543B9C81F2DE71214B344@POCITMSEXMB02.LntUniverse.com>
Date: Mon, 8 Aug 2011 09:29:10 -0700
Message-ID: <CAGH67wSAxq1xZ8qR9fDmBzisy4Gt0SFuRwXMewnqXBJx8hJYHQ@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: G Rajender <G.Rajender@lnties.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Mon, Aug 8, 2011 at 6:04 AM, G Rajender <G.Rajender@lnties.com> wrote:
> Hi,
>
> Thank you for your reply. I have successfully executed LTP test suite on beagleboard.
>
> I want to add a new test cases in LTP and if possible Camera Module related test cases in LTP.
>
> Can you please suggest how to add a new test case in LTP.
>
> Will LTP contains Camera Module related test cases? If Yes please tell me how many test case exists. If No please tell me how to search and add Camera module related test cases in LTP.

There are video4linux testcases IIRC, but no Camera module testcases.
If the testcase is generic enough where it can test out a specific
subsystem and you plan on providing changes for the test driver, then
yes I think that there is value in it being in LTP. Otherwise, it
probably shouldn't be in LTP.

Cheers :)!
-Garrett

------------------------------------------------------------------------------
BlackBerry&reg; DevCon Americas, Oct. 18-20, San Francisco, CA
The must-attend event for mobile developers. Connect with experts. 
Get tools for creating Super Apps. See the latest technologies.
Sessions, hands-on labs, demos & much more. Register early & save!
http://p.sf.net/sfu/rim-blackberry-1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
