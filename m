From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 15 Jun 2017 11:23:07 +0200
Subject: [LTP] [PATCH] dio: reduce the number of cycles
In-Reply-To: <20170615065430.GE17436@eguan.usersys.redhat.com>
References: <20170614033830.12736-1-liwang@redhat.com>
 <20170614111610.GC17436@eguan.usersys.redhat.com>
 <20170614134939.GB7604@rei.suse.de>
 <20170615065430.GE17436@eguan.usersys.redhat.com>
Message-ID: <20170615092307.GA27932@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > What's the reliability after the patch btw? What is the actual
> > percentage of undetected failures for at least 10 runs of the test?
> 
> I ran diotest30 10 times with "-i 100" and 8 of them failed. IIRC, it
> was not 100% reproduced either when I first saw the test failure in
> 4.10-rc kernel testing. So I think ~80% probability to reproduce is
> fine.

Fair enough I've added this paragraph to the commit message and pushed,
thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
