Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <pev@sketchymonkey.com>) id 1PB3lu-0001Fq-U4
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:02:22 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB3lt-0002fp-DN
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:02:22 +0000
Received: by yxe42 with SMTP id 42so283683yxe.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Oct 2010 04:02:16 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Oct 2010 11:32:19 +0100
Message-ID: <AANLkTinxTr-HLLpjNUw9tdoMy0oY6EUxSDMc_bBGS+gr@mail.gmail.com>
From: David Peverley <pev@sketchymonkey.com>
Subject: [LTP] LTP GIT access
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

Hi All,

I'm just kicking into gear looking at using LTP with an embedded
target. I've pulled down and run ltp-full-20100831which is going OK -
however I'd like to pull down the latest from RC to work against and
so I can re-submit patches. AFAICT The repo I should be looking at is
:
   http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp.git

Looking at the sf.net project page :
   http://sourceforge.net/projects/ltp/develop/

It states that I should be able to do a :
   git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp

We're behind a proxy here so I normally GIT with an http access type
but this gives me :
   bob:ltp-git $ git clone http://ltp.git.sourceforge.net/gitroot/ltp/ltp
   Initialized empty Git repository in /home/pev/src/ltp-git/ltp/.git/
   fatal: http://ltp.git.sourceforge.net/gitroot/ltp/ltp/info/refs?service=git-upload-pack
not found: did you run git update-server-info on the server?

Is this something that could possibly be fixed? I know I can download
tgz snapshots but obbviously this isn't ideal!

Best Wishes,

David Peverley

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
