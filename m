From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Jan 2018 12:42:36 +0100
Subject: [LTP] LTP release
In-Reply-To: <977653471.5142457.1515583573139.JavaMail.zimbra@redhat.com>
References: <20171220113323.GD6688@rei> <20180109181745.GA11221@rei.lan>
 <1073451511.4987996.1515523657228.JavaMail.zimbra@redhat.com>
 <CAEemH2ep93OYxwXbj_fwdQDiFhCBaKd3Aj2nrt1k4uim+RBRDQ@mail.gmail.com>
 <977653471.5142457.1515583573139.JavaMail.zimbra@redhat.com>
Message-ID: <20180110114236.GA1226@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > msgctl11  FAIL  s390x
> > ----------------------
> > msgctl11    0  TINFO  :  Found 32000 available message queues
> > msgctl11    0  TINFO  :  Using upto 32698 pids
> > Fork failure in the second child of child group 682
> > Fork failure in the first child of child group 9
> > Fork failure in the first child of child group 191
> > ...
> > Fork failure in the first child of child group 1490
> > Fork failure in the first child of child group 1432
> > Fork failure in the second child of child group 1326
> > Fork failure in the first child of child group 1327
> > Fork failure in the first child of child group 638
> > msgctl11    1  TFAIL  :  msgctl11.c:205: Fork failed (may be OK if under
> > stress)
> 
> I have very old note this test spawns large number of children, so
> I'm assuming this is not a regression.

This fails unless you have at lest 2GB of memory on x86_64 but may need
more depending on system page size and system overcommit settings. I
recall that at some point kernel tracking of available memory got better
which caused this test to fail (instead of causing period of heavy
swapping).

-- 
Cyril Hrubis
chrubis@suse.cz
