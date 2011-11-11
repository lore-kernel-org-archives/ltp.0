Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1ROsWY-0007C5-OY
	for ltp-list@lists.sourceforge.net; Fri, 11 Nov 2011 14:56:10 +0000
Date: Fri, 11 Nov 2011 16:02:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20111111150221.GD13045@saboteur.suse.cz>
References: <CANoG8sX-GKK2dbxiHAocviCue8Y7rU1O10=wzbNmZhrMZZQhbA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANoG8sX-GKK2dbxiHAocviCue8Y7rU1O10=wzbNmZhrMZZQhbA@mail.gmail.com>
Subject: Re: [LTP] Incorrect mode on nfsv3 filesystem
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
To: Romu <huruomu@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> chmod03     1  TFAIL  :  testfile: Incorrect modes 0100777, Expected 0777
> fchmod03    1  TFAIL  :  testfile: Incorrect modes 0100777, Expected 0777
> chown02     1  TFAIL  :  testfile1: incorrect mode permissions
> 0106770, Expected 0100770
> 
> I have no idea whether they are kernel issue.  Any idea?

Seems like your nfs doesn't support sticky bit (note the messages from
the tests are wrong and should be "Expected 1777").

And the chown02 does something with set UID and set GID bits.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
