From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 31 Oct 2016 10:28:25 +0100
Subject: [LTP] [PATCH] containers/netns/netns_sysfs.sh: add kernel
 version check
In-Reply-To: <ed067bc2-ab8e-3b7e-476c-d24e39560700@redhat.com>
References: <1472544117-7584-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <ed067bc2-ab8e-3b7e-476c-d24e39560700@redhat.com>
Message-ID: <20161031092825.GB30590@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +tst_kvercmp 2 6 35
> > +if [ $? -eq 0 ]; then
> 
> Just out of curiosity - I see this used on more places, but can't
> understand why would you use this instead of simply
> 
>   if tst_kvercmp 2 6 35; then
> 
> Any reason behind that? Am I missing a test writing rule?

The most probable reason would be that the tst_kvercmp actually returns
ternary result (older than, equal or newer is mapped to 0, 1, 2) so if
you want to anything else than "kernel is older" check you have to
examine the $?.

Maybe I sould write a new tst_kvercmp for the new shell library that
would work similar to the test shell buildin so that we can do something
as:

if tst_kvercmp -nq "2.6.35" -o "3.8"; then
	...
fi

where the modifiers would stand for:

n  newer
nq newer or equal
o  older
oq older or equal

-- 
Cyril Hrubis
chrubis@suse.cz
