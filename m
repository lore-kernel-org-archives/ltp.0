Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sedat.dilek@gmail.com>) id 1TvTGv-0008Ah-MG
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 13:43:17 +0000
Received: from mail-qa0-f50.google.com ([209.85.216.50])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1TvTGu-0004Oi-1Q
	for ltp-list@lists.sourceforge.net; Wed, 16 Jan 2013 13:43:17 +0000
Received: by mail-qa0-f50.google.com with SMTP id cr7so1139125qab.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 16 Jan 2013 05:43:10 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 16 Jan 2013 14:43:10 +0100
Message-ID: <CA+icZUVOgWZ+B41Hyb2_J-YCXu_c8ucad43H5ts5xsP4uisi7w@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: [LTP]  Tarballs in Files section @ sf.net
Reply-To: sedat.dilek@gmail.com
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

Hi,

why do you name your BZ2-tarballs with the right and common
file-extensions ".tar.bz2"?

$ file ltp-full-20130109.bz2
ltp-full-20130109.bz2: bzip2 compressed data, block size = 900k

$ bunzip2 ltp-full-20130109.bz2

$ file ltp-full-20130109
ltp-full-20130109: POSIX tar archive (GNU)

$ tar -xf ltp-full-20130109

$ ls -l
insgesamt 12
drwxrwxr-x  3 wearefam wearefam 4096 Jan 16 14:33 ./
drwxrwxr-x  3 wearefam wearefam 4096 Jan 16 14:33 ../
drwxr-xr-x 16 wearefam wearefam 4096 Jan  9 10:21 ltp-full-20130109/

And why don't you use XZ compressor? Even traditional GNU folks
switched to efficient XZ :-).

$ tar -c --xz -f ltp-full-20130109.tar.xz ltp-full-20130109/

$ tar -c --bzip2 -f ltp-full-20130109.tar.bz2 ltp-full-20130109/

$ du -k ltp-full-20130109.tar.bz2 ltp-full-20130109.tar.xz
3688    ltp-full-20130109.tar.bz2
2892    ltp-full-20130109.tar.xz

796KiB file-size saved!

Thanks!

Regards,
- Sedat -

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
