From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 31 Oct 2016 15:36:45 +0100
Subject: [LTP] [PATCH] containers/netns/netns_sysfs.sh: add kernel
 version check
In-Reply-To: <d15b075f-b777-c6fe-8861-74d5a30a3305@redhat.com>
References: <1472544117-7584-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
 <ed067bc2-ab8e-3b7e-476c-d24e39560700@redhat.com>
 <20161031092825.GB30590@rei.lan>
 <d15b075f-b777-c6fe-8861-74d5a30a3305@redhat.com>
Message-ID: <20161031143644.GA13468@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > where the modifiers would stand for:
> > 
> > n  newer
> > nq newer or equal
> > o  older
> > oq older or equal
> 
> If you're going to use letters for this, I suggest re-using what the
> 'test' a.k.a. '[' command has: -eq, -lt, -ge, -ne, etc.
> 
> If multiple options (like in your example) are supported, re-using the
> logic from 'test' could also be a good idea: -a (and), -o (or), although
> shell-based && or || might be more obvious.
> 
> if tst_kvercmp -ge "2.6.35" -a -lt "3.8"; then ...
> 
> if tst_kvercmp -ge "2.6.35" && tst_kvercmp -lt "3.8"; then ...

Sounds good. I will look into this.

-- 
Cyril Hrubis
chrubis@suse.cz
