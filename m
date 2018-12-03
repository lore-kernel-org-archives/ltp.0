From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Mon, 3 Dec 2018 13:14:58 -0200
Subject: [LTP] with-numa/without-numa option not working ?
Message-ID: <9a9b8890-5bc0-1123-1ceb-68dedb6e7a5c@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Daniel has discovered that --with-numa and --without-numa practically
have the same effect, disabling NUMA support. This can be seen when
executing test "migrate_pages03", for example.

In both situations it will display:

tst_test.c:771: CONF: require libnuma >= 2 and it's development packages

config.log shows:

when --with-numa AND when --without-numa are set (or --with-numa=yes or
--with-numa=no):

NUMA_LIBS=''



#define NUMA_ERROR_MSG "NUMA support was disabled during build"



when nothing is specificied:

NUMA_LIBS='-lnuma'



#define HAVE_NUMA_H 1


#define HAVE_NUMAIF_H 1
#define HAVE_NUMA_V2 1
#define NUMA_ERROR_MSG "test requires libnuma >= 2..."

I believe something is wrong with configure.ac for NUMA (maybe some
other options ?). I'm not an autoconf expert, could someone take a look ?

Thank you
-- 
Rafael D. Tinoco
Linaro - Kernel Validation
