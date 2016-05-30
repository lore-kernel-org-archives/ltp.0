From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 May 2016 18:30:11 +0200
Subject: [LTP] [LTP-20160510] acl_test01: 44: .: test.sh: not found
In-Reply-To: <CA+icZUXB6jxR6Ro==fZ8SSAKpHQ5PLd412CNg-x7SzD+vatBxg@mail.gmail.com>
References: <CA+icZUWdzSCUCPM_91Rg3vk1LNGQ7iuAWVqxbPRcjs5ijKSFaw@mail.gmail.com>
 <20160530142131.GA7416@rei>
 <CA+icZUWRAiAx6bJKNC=Ci6bjR8+jk61ea+xBLcD1Rchu6u7GYg@mail.gmail.com>
 <20160530151115.GA8207@rei.lan>
 <CA+icZUVDvU2JK8AbPn2hVE8QHRUAxmk0k1QHeFgw+Ncsb2V9FA@mail.gmail.com>
 <20160530153220.GB8207@rei.lan>
 <CA+icZUXB6jxR6Ro==fZ8SSAKpHQ5PLd412CNg-x7SzD+vatBxg@mail.gmail.com>
Message-ID: <20160530163011.GC8207@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> # echo $PATH
> /opt/cmake/bin:/opt/xorg/bin:/opt/llvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> 
> # cd /opt/ltp ; LC_ALL=C ./runltp -s acl_test01 | tee acl_test01.log
> ...
> TESTING ACLS FOR USER root
> Trying extended acls for files
> acltest01 1 TPASS : Extended acls for files.
> Trying extended acls for file links
> acltest01 2 TPASS : Extended acls for links.
> /opt/ltp/testcases/bin/acl_test01: 44: .: test.sh: not found
> 
> loop: can't delete device /dev/loop2: No such device or address
> incrementing stop
> <<<execution_status>>>
> ...
> 
> # echo $PATH
> /opt/cmake/bin:/opt/xorg/bin:/opt/llvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> 
> No change in $PATH after executing runltp.

Once again the $PATH is set _ONLY_ inside of the runltp script and is
inherited for everything that is executed from it not the other way
around. You _HAVE_ to print the $PATH from the runltp script after it
was initialized.

And I've reproduced it on Debian 7.2, looks like the "su $TEST_USER1"
replaces $PATH completly on Debian while it seems to retain the added
path to /opt/ltp/testcases/bin on the rest of the systems I've tried.

-- 
Cyril Hrubis
chrubis@suse.cz
