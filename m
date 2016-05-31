From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 May 2016 17:14:17 +0200
Subject: [LTP] [LTP-20160510] acl_test01: 44: .: test.sh: not found
In-Reply-To: <CA+icZUUzUC2ik7C8F8tpmjkctVoZhpQmsfRj1ozL+pj1gYgD+w@mail.gmail.com>
References: <CA+icZUWdzSCUCPM_91Rg3vk1LNGQ7iuAWVqxbPRcjs5ijKSFaw@mail.gmail.com>
 <20160530142131.GA7416@rei>
 <CA+icZUWRAiAx6bJKNC=Ci6bjR8+jk61ea+xBLcD1Rchu6u7GYg@mail.gmail.com>
 <20160530151115.GA8207@rei.lan>
 <CA+icZUVDvU2JK8AbPn2hVE8QHRUAxmk0k1QHeFgw+Ncsb2V9FA@mail.gmail.com>
 <20160530153220.GB8207@rei.lan>
 <CA+icZUXB6jxR6Ro==fZ8SSAKpHQ5PLd412CNg-x7SzD+vatBxg@mail.gmail.com>
 <20160530163011.GC8207@rei.lan>
 <CA+icZUUzUC2ik7C8F8tpmjkctVoZhpQmsfRj1ozL+pj1gYgD+w@mail.gmail.com>
Message-ID: <20160531151416.GA14283@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Once again the $PATH is set _ONLY_ inside of the runltp script and is
> > inherited for everything that is executed from it not the other way
> > around. You _HAVE_ to print the $PATH from the runltp script after it
> > was initialized.
> >
> > And I've reproduced it on Debian 7.2, looks like the "su $TEST_USER1"
> > replaces $PATH completly on Debian while it seems to retain the added
> > path to /opt/ltp/testcases/bin on the rest of the systems I've tried.
> >
> 
> Thanks for testing with Debian.

I've fixed the problems in three patches.

The message about loop device that could not be deleted turned out to be
harmless, the cleanup attempted to detach the device twice. Anyway the
test should be all fixed now.

-- 
Cyril Hrubis
chrubis@suse.cz
