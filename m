Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pev@sketchymonkey.com>) id 1PBRZ2-0001GJ-Gq
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 12:26:40 +0000
Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PBRZ0-0001zg-TJ
	for ltp-list@lists.sourceforge.net; Thu, 28 Oct 2010 12:26:40 +0000
Received: by ywo32 with SMTP id 32so1246498ywo.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 28 Oct 2010 05:26:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=qMFhKNeBQaWWDP7h9UF77e_hJKT+jTzL=55Fd@mail.gmail.com>
References: <AANLkTinKu3Kx0FMdgvvG34rc6tcv4Wt5qV1jaAnGzHnv@mail.gmail.com>
	<4CC8464F.80605@linux.vnet.ibm.com>
	<AANLkTikAcaMa0zZ_pfrW_W8H=VqhCvMge8wm+AFbpSEs@mail.gmail.com>
	<4CC96358.1000108@linux.vnet.ibm.com>
	<AANLkTi=qMFhKNeBQaWWDP7h9UF77e_hJKT+jTzL=55Fd@mail.gmail.com>
Date: Thu, 28 Oct 2010 13:26:33 +0100
Message-ID: <AANLkTino9kmXCtJJOK=bNySpEsUsUNDMYHtjBtbKEXy_@mail.gmail.com>
From: David Peverley <pev@sketchymonkey.com>
Subject: Re: [LTP] Realtime tests on embedded target
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
To: gowrishankar <gowrishankar.m@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On 28 October 2010 13:10, David Peverley <pev@sketchymonkey.com> wrote:
> However, all the scripts for realtime tests are similarly named...! To
> end up in the bin dir they need to be unique so I'd rename along the
> lines of :
..
> I'll take a stab at this this afternoon and submit a patch back if I'm
> successful.
Except typically it's not that simple as the execution scripts rely on
directory traversal rather than scripts under runtest - somewhat more
of a change than expected!

~Pev

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
