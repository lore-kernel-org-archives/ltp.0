From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 30 May 2016 17:32:20 +0200
Subject: [LTP] [LTP-20160510] acl_test01: 44: .: test.sh: not found
In-Reply-To: <CA+icZUVDvU2JK8AbPn2hVE8QHRUAxmk0k1QHeFgw+Ncsb2V9FA@mail.gmail.com>
References: <CA+icZUWdzSCUCPM_91Rg3vk1LNGQ7iuAWVqxbPRcjs5ijKSFaw@mail.gmail.com>
 <20160530142131.GA7416@rei>
 <CA+icZUWRAiAx6bJKNC=Ci6bjR8+jk61ea+xBLcD1Rchu6u7GYg@mail.gmail.com>
 <20160530151115.GA8207@rei.lan>
 <CA+icZUVDvU2JK8AbPn2hVE8QHRUAxmk0k1QHeFgw+Ncsb2V9FA@mail.gmail.com>
Message-ID: <20160530153220.GB8207@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> root# echo $PATH
> /opt/cmake/bin:/opt/xorg/bin:/opt/llvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

The path is added to the $PATH at the start of the runltp script, if you
want to know if it was added correctly you have to do echo $PATH at the
end of the setup() in runltp script.

> root# cd /opt/ltp ; LC_ALL=C ./runltp -s acl_test01 | tee acl_test01.log
> 
> [...]
> TESTING ACLS FOR USER root
> Trying extended acls for files
> acltest01 1 TPASS : Extended acls for files.
> Trying extended acls for file links
> acltest01 2 TPASS : Extended acls for links.
> /opt/ltp/testcases/bin/acl_test01: 44: .: test.sh: not found

This is certainly unexpected.

What is /bin/sh pointing to? Is this debian with dash?

Still this should really work.

> > Should be fixed -> I'm about to push a fix, stay tuned.
> >
> > The cleanup has been executefd twice at least since 2010 and possibly
> > since the testcase was introduced.
> >
> 
> OK, I am patient.
> Thanks for the explanations.

Fixed in:

https://github.com/linux-test-project/ltp/commit/ee2d3ee269264198837726304873195134a4232c

> > And I am only a test maintainer.
> >
> > But seriously I've glanced over the patches and it seems to implement
> > {get,set,remove}xattr via generic handlers instead of fs specific
> > handlers. And we have syscall tests for {get,set,remove}xattr...
> >
> 
> Is there a testcase around - runnable via "runltp -s $testcase_script".

These are executed as a part of syscall tests.

You can simply do ./runltp -s xattr to execute all testcases that have
xattr in their name.

-- 
Cyril Hrubis
chrubis@suse.cz
