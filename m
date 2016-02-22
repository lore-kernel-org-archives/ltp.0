From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 22 Feb 2016 10:35:58 -0500 (EST)
Subject: [LTP] [PATCH] numa_helper: don't break is_numa() with TCONF
In-Reply-To: <20160222142633.GD6434@rei>
References: <56CB1519.4040902@redhat.com> <20160222142633.GD6434@rei>
Message-ID: <284803737.25623647.1456155358084.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 22 February, 2016 3:26:33 PM
> Subject: Re: [LTP] [PATCH] numa_helper: don't break is_numa() with TCONF
> 
> Hi!
> > > Now I'm confused. You said that the syscall can exit -1 and ENOSYS.
> > 
> > Correct, get_mempolicy is not implemented on aarch64.
> > 
> > > In that case the filter_nodemask_mem() returns -2 which is propagated
> > > from
> > > get_allowed_nodes_arr() to is_numa() where the test ends with TBROK
> > > rather than with TCONF.
> > 
> > It won't return -2 for ENOSYS, because of this line:
> > +        if (ret < 0 && errno != ENOSYS)
> >                  return -2;
> > 
> > > Or did I miss something?
> > 
> > I didn't make it clear in commit message that patch now silently ignores
> > ENOSYS
> > from get_mempolicy. In this case get_allowed_nodes should return success,
> > but
> > returned node set should be empty (I'll double check that this is the case
> > on aarch64).
> 
> Ah right I somehow missed that (I blame it on not enough coffe in
> bloodstream). So is_numa() returns 0 in that case, which is fine.
> 
> If node set is empty the get_allowed_nodes() will fail since the
> num_nodes will end up set to 0 and get_allowed_nodes() will return with
> -3 and errno EINVAL since we cannot set the requested node. And looks
> like at least oom04 and oom05 call TBROK if there isn't one allowed
> node.

True, these needs some fixing too. I'll check all instances of get_allowed_nodes().

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
