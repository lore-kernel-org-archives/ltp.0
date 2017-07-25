From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 Jul 2017 16:28:27 +0200
Subject: [LTP] [RFC PATCH v7 05/11] lib/test_net.sh: tst_rhost_run: Add
 testcases/bin into PATH for SSH/RSH
In-Reply-To: <8fda8031-0621-3f93-e938-ef446b710013@oracle.com>
References: <20170721040407.868-1-pvorel@suse.cz>
 <20170721040407.868-6-pvorel@suse.cz>
 <8fda8031-0621-3f93-e938-ef446b710013@oracle.com>
Message-ID: <20170725142827.qczqcp3my6lhpxkl@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,
> > +	local newpath="$LTPROOT/testcases/bin"

> Why setting the PATH, LTPROOT can't be done before test run on remote
> host? what if LTPROOT differs b/w machines?

You're right, that setting correct PATH is required by doc [1], so I'll drop this patch
from v8.

But PATH is set in several local scripts, the same is for LTPROOT (see `git grep
LTPROOT=' and `git grep PATH=.*LTPROOT.*testcases/bin'), including our
testscripts/network.sh, so for localhost is not really required. I'd like to have it for
remote host as well.

But of course the whole problem is how to detect correct LTPROOT for remote. I used the
same as I had an idea, that ltp should be installed into same path for lhost and rhost,
but I'm wrong.

BTW this is IMHO better way how to set LTPROOT:
# /opt/ltp/testscripts/network.sh
export LTPROOT="${LTPROOT:-$(cd $(dirname $0)/../testcases/bin; pwd)}"

# /opt/ltp/testcases/bin/test_net.sh
export LTPROOT="${LTPROOT:-$(cd $(dirname $0); pwd)}"


> >  	if [ -n "${TST_USE_SSH:-}" ]; then
> > -		output=`ssh -n -q $user@$RHOST "sh -c \
> > -			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
> > +		output=`ssh -n -q $user@$RHOST "PATH=$newpath:\$PATH \
> > +			sh -c '$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`

> $PATH still expands on local machine with backticks

> echo `echo "\$PATH"` vs echo `echo "\\$PATH"`

> or better use POSIX $(...)

> echo $(echo "\$PATH")
Oh, you're right.


Kind regards,
Petr

[1]: https://github.com/linux-test-project/ltp/tree/master/testcases/network#ltp-setup
