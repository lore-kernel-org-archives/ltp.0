Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P7mdt-00081S-NY
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 10:08:33 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P7mds-0003OF-PQ
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 10:08:33 +0000
Received: by iwn2 with SMTP id 2so1117462iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Oct 2010 03:08:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CBBAD30.6070403@windriver.com>
References: <4CBBAD30.6070403@windriver.com>
Date: Mon, 18 Oct 2010 03:08:22 -0700
Message-ID: <AANLkTi=aC63h6rTNsqJ5tJ22FOuAR9+SLyp-vTW9KYDK@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [patch] sync_file_range01 change for arm
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
To: "lina.zhao" <lina.zhao@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On Sun, Oct 17, 2010 at 7:13 PM, lina.zhao <lina.zhao@windriver.com> wrote:
> Hi,
>
> arm use __NR_sync_file_range2 not __NR_sync_file_range for system call.
> the test casecheck __NR_sync_file_range for arm,
> So test react "System doesn't support" for arm.
> but actually arm use __NR_sync_file_range2 to support the system call.
>
> powerpc is big endian, arm is small endian, so the parameter dealing is
> different.

    Not true. ARM can be biendian, just like MIPS...
    A better test needs to be derived for endianness than this.
-Garrett

------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
