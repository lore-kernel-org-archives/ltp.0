Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ol8cX-0007CR-8p
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 22:57:33 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ol8cW-0004jr-Ci
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 22:57:33 +0000
Received: by bwz12 with SMTP id 12so3067954bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 16 Aug 2010 15:57:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinN_yVXA1FtbDmwPVf4S+m0OHKxH4SNiJmJx9Sh@mail.gmail.com>
References: <AANLkTinN_yVXA1FtbDmwPVf4S+m0OHKxH4SNiJmJx9Sh@mail.gmail.com>
Date: Mon, 16 Aug 2010 15:57:26 -0700
Message-ID: <AANLkTikvWkrLmc11n9qn_pkB6xteFcxLX90yuf742bTm@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix iogen01 test arguments to generate tmp files
 in TMPDIR in fs runtest file
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Mon, Aug 16, 2010 at 1:45 PM, Henry Yei <hyei@mvista.com> wrote:
> This patch updates the fs runtest file with arguments for the iogen01
> test to honor the tmp directory set by runltp. Without this patch, the
> tmp files are written to <ltp install dir>/testcases/bin.

ACK.

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
