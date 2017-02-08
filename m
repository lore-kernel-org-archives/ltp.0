From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 8 Feb 2017 09:18:01 -0500 (EST)
Subject: [LTP] [PATCH v2] getrandom02: relax check for returned data
In-Reply-To: <20170208141250.GE16139@rei.lan>
References: <886b49c2db9b9b6f65f7d92a2e91dbf3943e9607.1486562481.git.jstancek@redhat.com>
 <20170208141250.GE16139@rei.lan>
Message-ID: <978127210.1621709.1486563481471.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, 8 February, 2017 3:12:51 PM
> Subject: Re: [PATCH v2] getrandom02: relax check for returned data
> 
> Hi!
> > "nb * 0.1" can easily fail for nb < 20, since all we need
> > are 2 identical bytes. Worst case (nb == 19) is almost
> > identical to "birthday problem", but with smaller pool.
> > Chance of hitting 2 identical bytes in pool of 19
> > is close to 50%.
> > 
> > Adjust formula to allow small repetitions in small pools.
> > Chance we fail now should be pretty unlikely, ~10^-16.
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> 
> Acked.

Pushed.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
