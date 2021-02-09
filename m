From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 9 Feb 2021 16:55:54 +0100
Subject: [LTP] [PATCH] netns_helper: Make iproute version check work
 correctly
In-Reply-To: <YCKim8Pvg+ZTrHXI@rei>
References: <1612772078-29651-1-git-send-email-zhufy.jy@cn.fujitsu.com>
 <YCKim8Pvg+ZTrHXI@rei>
Message-ID: <YCKwiqsfPi47PT/b@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >  static int dummy(void *arg)
> > diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/kernel/containers/netns/netns_helper.sh
> > index a5b77a0..bec43ac 100755
> > --- a/testcases/kernel/containers/netns/netns_helper.sh
> > +++ b/testcases/kernel/containers/netns/netns_helper.sh
> > @@ -50,6 +50,15 @@ tst_check_iproute()
> >  	local cur_ipver="$(ip -V)"
> >  	local spe_ipver="$1"
> >  
> > +	echo $cur_ipver | grep "ip utility, iproute2-ss" > /dev/null
> > +	ret1=$?
> > +	echo $cur_ipver | grep "ip utility, iproute2-" > /dev/null
> > +	ret2=$?
> > +
> > +	if [ $ret1 -ne 0 -a $ret2 -eq 0 ]; then
> > +		return
> > +	fi
> 
> How is this supposed to fix the problem?
> 
> This just skips the test if we haven't found one of the strings in the
                      ^
		      I mean version check, the test iself continues

If nothing else this should TBROK.

-- 
Cyril Hrubis
chrubis@suse.cz
