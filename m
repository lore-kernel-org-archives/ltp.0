Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1TvVZv-0006fG-9a
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 16:11:03 +0000
Received: from mail-da0-f51.google.com ([209.85.210.51])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TvVZu-0005om-JS
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 16:11:03 +0000
Received: by mail-da0-f51.google.com with SMTP id i30so632555dad.24
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Jan 2013 08:10:56 -0800 (PST)
References: <CA+icZUVOgWZ+B41Hyb2_J-YCXu_c8ucad43H5ts5xsP4uisi7w@mail.gmail.com>
Mime-Version: 1.0 (1.0)
In-Reply-To: <CA+icZUVOgWZ+B41Hyb2_J-YCXu_c8ucad43H5ts5xsP4uisi7w@mail.gmail.com>
Message-Id: <BD6DAD5B-2967-4A8E-81F6-1BB733AE8A77@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Date: Wed, 16 Jan 2013 08:10:54 -0800
Subject: Re: [LTP] Tarballs in Files section @ sf.net
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
To: "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Jan 16, 2013, at 5:43 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:

> Hi,
> 
> why do you name your BZ2-tarballs with the right and common
> file-extensions ".tar.bz2"?
> 
> $ file ltp-full-20130109.bz2
> ltp-full-20130109.bz2: bzip2 compressed data, block size = 900k
> 
> $ bunzip2 ltp-full-20130109.bz2
> 
> $ file ltp-full-20130109
> ltp-full-20130109: POSIX tar archive (GNU)
> 
> $ tar -xf ltp-full-20130109
> 
> $ ls -l
> insgesamt 12
> drwxrwxr-x  3 wearefam wearefam 4096 Jan 16 14:33 ./
> drwxrwxr-x  3 wearefam wearefam 4096 Jan 16 14:33 ../
> drwxr-xr-x 16 wearefam wearefam 4096 Jan  9 10:21 ltp-full-20130109/
> 
> And why don't you use XZ compressor? Even traditional GNU folks
> switched to efficient XZ :-).

Xz didn't become popular until the last couple years. Ltp has been around for a while and still supports old releases of Linux. How far back has never really been clearly communicated afaict.
Thanks,
-Garrett
------------------------------------------------------------------------------
Master Java SE, Java EE, Eclipse, Spring, Hibernate, JavaScript, jQuery
and much more. Keep your Java skills current with LearnJavaNow -
200+ hours of step-by-step video tutorials by Java experts.
SALE $49.99 this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122612 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
