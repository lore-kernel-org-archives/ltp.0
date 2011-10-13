Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1REKSf-000702-Eb
	for ltp-list@lists.sourceforge.net; Thu, 13 Oct 2011 12:32:33 +0000
Date: Thu, 13 Oct 2011 14:36:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111013123608.GA23966@saboteur.suse.cz>
References: <CAFew7vRh3dEFE1FFdfrkcqAw3HpGD9Sj6pggD_T_w9d6xbvdiw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFew7vRh3dEFE1FFdfrkcqAw3HpGD9Sj6pggD_T_w9d6xbvdiw@mail.gmail.com>
Subject: Re: [LTP] Ltp-kdump does not execute
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
To: "shwetabhgoel@gmail.com" <shwetabhgoel@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I am trying to run the LTP's kdump tests on 3.1.0-rc7+ kernel on Rhel6.2
> beta target.
> The LTP version being used is ltp-full-20110915. When I try to do a make all
> for kdump,
> I get the following error:
> 
> [root@Treadstone kdump]# make all
> chmod a+x runkdump.sh lib/*.sh
> ./runkdump.sh
> + conf=runkdump.conf
> + lib=lib
> + log=log
> + . runkdump.conf
> ./runkdump.sh: line 174: .: runkdump.conf: file not found
> make: *** [all] Error 1

The problem seems to be that posix shell behavior is try to find the
runkdump.conf file in $PATH rather than in current directory (because
the filename doesn't start with ./ or /).

Adding ./ before the runkdump.conf in runkdump.sh (around line 196)
should do the trick.

I'll commit patch for this into LTP git.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
