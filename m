From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 14 Apr 2017 12:44:53 +0300
Subject: [LTP] [RFC PATCH v4 0/3] Simplify network setup
In-Reply-To: <20170414091742.px3y4evyg7sl6rcy@x230>
References: <20170405204418.3240-1-pvorel@suse.cz>
 <5d196274-519f-fb5c-f971-29ece892330d@oracle.com>
 <20170414091222.ahrdtbid4pydsm2o@x230> <20170414091742.px3y4evyg7sl6rcy@x230>
Message-ID: <3e5e2cda-38f3-b951-2186-46f50740a0ee@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14.04.2017 12:17, Petr Vorel wrote:
> Hi Alexey,
>
>> Silly question, but how did you compile to get this error? I don't get them
>> $ i=testcases/lib/tst_net_vars; rm -fv $i; ma -C `dirname $i`
> Sorry, I mean this:
> $ i=testcases/lib/tst_net_vars; rm -fv $i; make -j$(getconf _NPROCESSORS_ONLN) -C `dirname $i`
> removed 'testcases/lib/tst_net_vars'
> make: Entering directory '/home/pevik/install/src/ltp.git/testcases/lib'
> make -C "/home/pevik/install/src/ltp.git/lib" -f "/home/pevik/install/src/ltp.git/lib/Makefile" all
> make[1]: Entering directory '/home/pevik/install/src/ltp.git/lib'
> make[2]: Entering directory '/home/pevik/install/src/ltp.git/lib/newlib_tests'
> make[2]: Nothing to be done for 'all'.
> make[2]: Leaving directory '/home/pevik/install/src/ltp.git/lib/newlib_tests'
> make[2]: Entering directory '/home/pevik/install/src/ltp.git/lib/tests'
> make[2]: Nothing to be done for 'all'.
> make[2]: Leaving directory '/home/pevik/install/src/ltp.git/lib/tests'
> make[1]: Leaving directory '/home/pevik/install/src/ltp.git/lib'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -D_FORTIFY_SOURCE=2 -I/home/pevik/install/src/ltp.git/testcases/kernel/include -I../../include -I../../include -I../../include/old/   -L../../lib  tst_net_vars.c   -lltp -o tst_net_vars
> make: Leaving directory '/home/pevik/install/src/ltp.git/testcases/lib'

Used default options for gcc in OL6, I guess in my case it has --std=gnu89
by default and you have something different, may be gnu99...

Thanks,
Alexey

