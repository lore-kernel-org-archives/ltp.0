From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 30 Mar 2017 12:59:21 +0200
Subject: [LTP] Out-of-tree build missing some data files.
In-Reply-To: <CAEemH2cMoGycJxb13zDBP9xijMb5p2OfyTXsXUom-n8zJNFboQ@mail.gmail.com>
References: <BN6PR11MB2051C2F128C4DC206D611144CD3F0@BN6PR11MB2051.namprd11.prod.outlook.com>
 <20170328133708.GF1045@rei>
 <BN6PR11MB20517B46C814B90AB73E3D43CD320@BN6PR11MB2051.namprd11.prod.outlook.com>
 <20170329133156.GF7089@rei.lan>
 <BN6PR11MB20512A7C76A7882343FFDE98CD350@BN6PR11MB2051.namprd11.prod.outlook.com>
 <CAEemH2cMoGycJxb13zDBP9xijMb5p2OfyTXsXUom-n8zJNFboQ@mail.gmail.com>
Message-ID: <20170330105920.GC12095@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm trying to build ltp out of tree but failed with errors like:
> 
> =========
> make[2]: Leaving directory `/root/ltp-build/testcases/lib'
> make[2]: Entering directory `/root/ltp-build/testcases/open_posix_testsuite'
> /root/ltp/testcases/open_posix_testsuite/Makefile:38: Makefile.linux:
> No such file or directory
> make[2]: *** No rule to make target `Makefile.linux'.  Stop.
> make[2]: Leaving directory `/root/ltp-build/testcases/open_posix_testsuite'
> make[1]: *** [all] Error 2
> =========
> 
> Two problems here:
> 
> 1. The open_posix_testuite is also compiling in this time, but I
> remember I didn't pass any parameter to config that.

I noticed it as well, my guess is that this was broken by:

https://github.com/linux-test-project/ltp/issues/143

but I haven't had time to investigate yet.

> 2. It obviously could not build open_posix_testsuite out of tree
> successfully, should we fix this for LTP?

Looks like somebody is already working on that:

https://github.com/linux-test-project/ltp/pull/130

-- 
Cyril Hrubis
chrubis@suse.cz
