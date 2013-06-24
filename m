Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ceh@ti.com>) id 1Ur52Q-0005ni-5v
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 11:34:26 +0000
Received: from bear.ext.ti.com ([192.94.94.41])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ur52O-0005wO-Ab
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 11:34:26 +0000
Message-ID: <51C82EB9.1060107@ti.com>
Date: Mon, 24 Jun 2013 07:34:17 -0400
From: Carlos Hernandez <ceh@ti.com>
MIME-Version: 1.0
References: <CA+icZUXJ_PAUPTrJqF013yowkpDgGtrOgnTnDy0Qj_iNCokorA@mail.gmail.com>
In-Reply-To: <CA+icZUXJ_PAUPTrJqF013yowkpDgGtrOgnTnDy0Qj_iNCokorA@mail.gmail.com>
Subject: Re: [LTP] How to run only a specific test series like for example
 IPC?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4092609717389573397=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: sedat.dilek@gmail.com
Cc: ltp-list@lists.sourceforge.net

--===============4092609717389573397==
Content-Type: multipart/alternative;
	boundary="------------090808000909080100090201"

--------------090808000909080100090201
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 06/23/2013 09:09 AM, Sedat Dilek wrote:
> Hi,
>
> I wanted to only run the IPC tests as I have troubles with IPC(-MSG)
> in Linux-Next.
>
> This is what I did...
>
> root# cd/opt/ltp/
>
> root# ./runltp ./runtest/ipc
>
> ...is that the correct way? Wrong?
./runltp -f ipc  should work

--------------090808000909080100090201
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 06/23/2013 09:09 AM, Sedat Dilek
      wrote:<br>
    </div>
    <blockquote
cite="mid:CA+icZUXJ_PAUPTrJqF013yowkpDgGtrOgnTnDy0Qj_iNCokorA@mail.gmail.com"
      type="cite">
      <pre wrap="">Hi,

I wanted to only run the IPC tests as I have troubles with IPC(-MSG)
in Linux-Next.

This is what I did...

root# cd <i class="moz-txt-slash"><span class="moz-txt-tag">/</span>opt/ltp<span class="moz-txt-tag">/</span></i>

root# ./runltp ./runtest/ipc

...is that the correct way? Wrong?
</pre>
    </blockquote>
    ./runltp -f ipc&nbsp; should work<br>
  </body>
</html>

--------------090808000909080100090201--


--===============4092609717389573397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
--===============4092609717389573397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4092609717389573397==--

