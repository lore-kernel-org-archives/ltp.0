Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <maxin.john@gmail.com>) id 1Qnt6z-000505-Aa
	for ltp-list@lists.sourceforge.net; Mon, 01 Aug 2011 14:04:53 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1Qnt6y-0001tC-8y
	for ltp-list@lists.sourceforge.net; Mon, 01 Aug 2011 14:04:53 +0000
Received: by gxk3 with SMTP id 3so4570125gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 01 Aug 2011 07:04:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <260174ADA4D63F4AA543B9C81F2DE712B7AB@POCITMSEXMB01.LntUniverse.com>
References: <260174ADA4D63F4AA543B9C81F2DE712B34F@POCITMSEXMB01.LntUniverse.com>
	<CAMhs6YzX0srwbYm778ro7o7zLGKZfmpqrRaPUgBTzX+a4arRCQ@mail.gmail.com>
	<260174ADA4D63F4AA543B9C81F2DE712B601@POCITMSEXMB01.LntUniverse.com>
	<CAMhs6Yy76dinKx_SSXfB90+76g3iUL6okPUNgETDMiVHpCrsgw@mail.gmail.com>
	<260174ADA4D63F4AA543B9C81F2DE712B6A2@POCITMSEXMB01.LntUniverse.com>
	<260174ADA4D63F4AA543B9C81F2DE712B7AB@POCITMSEXMB01.LntUniverse.com>
Date: Mon, 1 Aug 2011 17:04:46 +0300
Message-ID: <CAMhs6Yy17=HN_zc_4yC=1_GYLjisVq6UUR5UU0Kna_Syas154w@mail.gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: G Rajender <G.Rajender@lnties.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi Rajender,

On Mon, Aug 1, 2011 at 4:13 PM, G Rajender <G.Rajender@lnties.com> wrote:
>
> I have successfully installed Scratchbox1 and selected the armv7 target i=
n sub-menu. I got shell prompt like "[ sbox- armv7 =A0~]". I have downloade=
d the LTP source "ltp-full-20100228.ar.gz" from LTP-web.
>
> Can you please share the procedure of how to Cross-Compile the LTP source=
 code using Scratchbox1 to generate the binaries for the beagleboard.
>

The Scratchbox environment simplifies the cross-compilation process.
Within the Scratchbox environment, perform the following steps:

# tar zxvf ltp-full-20100228.tar.gz
# cd ltp-full-20100228
# ./configure
# make
# make install

You will find the cross-compiled binaries in "/opt/ltp" directory in
Scratchbox. Move these binaries to your Beagleboard to execute LTP
test-suite on the target board.

Hope this helps.
Maxin B. John

---------------------------------------------------------------------------=
---
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
