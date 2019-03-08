From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 8 Mar 2019 15:03:54 +0100
Subject: [LTP] [PATCH 2/2 v2] libs: Hook up libs into the build system
In-Reply-To: <20190308133347.GB20072@rei>
References: <20190308124257.25282-1-chrubis@suse.cz>
 <20190308124257.25282-2-chrubis@suse.cz>
 <1327941462.6119620.1552050333572.JavaMail.zimbra@redhat.com>
 <20190308132634.GA23955@dell5510> <20190308133347.GB20072@rei>
Message-ID: <20190308140354.GC20072@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > I tested v2 as far back as RHEL6.2, ACK.
> > Jan, have you tested out of tree build?
> > 
> > Still failing [1], mostly for out-of-tree builds [2]:
> > make: Entering directory '/usr/src/ltp-build'
> > make -C "lib" \
> > 	-f "/usr/src/ltp/lib/Makefile" all
> > make -C "libs" \
> > 	-f "/usr/src/ltp/libs/Makefile" all
> > make[1]: Entering directory '/usr/src/ltp-build/lib'
> > mkdir -m 00755 -p "newlib_tests"
> > make[1]: Entering directory '/usr/src/ltp-build'
> > make[1]: *** libs: No such file or directory.  Stop.
> > make[1]: Leaving directory '/usr/src/ltp-build'
> > /usr/src/ltp/Makefile:114: recipe for target 'libs-all' failed
> > make: *** [libs-all] Error 2
> > make: *** Waiting for unfinished jobs....
> 
> Sigh, the out-of-tree build is always making things unnecessary
> difficuilt. I have no idea why the directory is not created in the build
> tree.

And on my machine out-of-tree build does not managed to get past
configure step, it fails somewhere in the ffsb configure step.

-- 
Cyril Hrubis
chrubis@suse.cz
