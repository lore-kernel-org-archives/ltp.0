Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <srikanth007m@gmail.com>) id 1ZeK6L-0003SP-Hp
	for Ltp-list@lists.sourceforge.net; Tue, 22 Sep 2015 09:43:05 +0000
Received: from mail-qg0-f43.google.com ([209.85.192.43])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZeK6K-0002LN-KT
	for Ltp-list@lists.sourceforge.net; Tue, 22 Sep 2015 09:43:05 +0000
Received: by qgez77 with SMTP id z77so111891537qge.1
	for <Ltp-list@lists.sourceforge.net>;
	Tue, 22 Sep 2015 02:42:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAO0kMxBSMF4fTMDSvzbQSsTnteSDoSE9ByCampY3AntKTe=62w@mail.gmail.com>
References: <CAO0kMxBSMF4fTMDSvzbQSsTnteSDoSE9ByCampY3AntKTe=62w@mail.gmail.com>
Date: Tue, 22 Sep 2015 15:12:59 +0530
Message-ID: <CANKSX+ESWx-7xKAu-NyiUNRF73EVZ_ukRkFLhtaBEeme2JJ7qw@mail.gmail.com>
From: "$rik@nth " <srikanth007m@gmail.com>
Subject: Re: [LTP] About to cross compile LTP...
Reply-To: srikanth007m@gmail.com
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
To: kamal p <pkamalbhaskar@gmail.com>
Cc: Ltp-list@lists.sourceforge.net

You can cross compile LTP either in chroot environment or with ARM toolchain.

If it is with toolchain, then make sure you are setting them in the
environment before compiling.

configure AR=arm-linux-gnueabi-ar CC=arm-linux-gnueabi-gcc
RANLIB=arm-linux-gnueabi-gcc-ranlib-4.7 STRIP=arm-linux-gnueabi-strip
--host=arm-linux --target=arm-linux CFLAGS="-static" LDFLAGS="-static
-pthread"

On Tue, Sep 22, 2015 at 1:00 PM, kamal p <pkamalbhaskar@gmail.com> wrote:
> Hi,
>
>    I want to cross compile LTP test suite and test it on my target embedded
> linux system.can I compile like this?.If we can do please tell me the
> procedure ( i.e cross compilation tool & other components required) to
> accomplish these task.
>
> Regards,
> Kamal bhaskar.
>
> ------------------------------------------------------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>



-- 
Thanks & Regards,
M.Srikanth Kumar.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
