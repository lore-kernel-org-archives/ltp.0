Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ashish.g@teldevice.co.jp>) id 1NYCUo-0007q9-PX
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 05:55:50 +0000
Received: from mail-gw.teldevice.co.jp ([124.215.243.245] helo=teldevice.co.jp)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NYCUn-0002RL-5n
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 05:55:50 +0000
Message-ID: <4B593DD8.2080207@teldevice.co.jp>
Date: Fri, 22 Jan 2010 14:55:36 +0900
From: TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>
MIME-Version: 1.0
Subject: Re: [LTP] LTP installation configure Error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: shanmuga.jayabalan@sasken.com
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

Hello Shanmuga

This is Ashish Agarwal.

I also had the same problem as you fight with Quota ....

what i got at end is it may be something related to the tools and sw installed over my system.

i also had fight with the issue last week.

>I am doing cross compilation of LTP with ARM.

>When I do ./configure, I'm also getting the same error message in
>ltp-full-20091231 release.

>       configure: error: Couldn't find functional copy of quota v2 - are you >
>running 2.4.x ?
>As per your suggestion I have tried to do `man 2 quotactl', I'm getting the
>following message.
>        No manual entry for quotactl in section 2
>I have ubuntu in my system. I'm able to cross compile with the previous release
>"ltp-full-20091130".
>Is there any setup is missing in my system for this release?
>Help me to resolve this issue.



i had some info mail list achieve can be found at

http://tinyurl.com/yzntwqt
[converted to tiny URL]

i was able to do it for the installed kernel over x86 PC. (Fedora 7, kernel 2.6.23.17-88 )

but now what i want is to CROSS compile this, if you have any source of info about CROSS_COMPILE Issue plz let me know :)

I didn't find any steps how to start with cross compile. :(

i greped the source ltp-full-20091231 for CROSS_COMPILER but it is not present to how to start with cross compile is still :x for me

i know it is tricky to ask info from you this way,
but
"Everything is legal in War , Development and L*V* ."
[original]
--
Ashish Agarwal
アガルワル・アシッシュ


------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
