From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 11 Apr 2018 21:03:35 +0200
Subject: [LTP] [RFC PATCH v2 1/4] security/ima: Rewrite tests into new
 API + fixes
In-Reply-To: <1523375764.5268.12.camel@linux.vnet.ibm.com>
References: <20180314155731.5943-1-pvorel@suse.cz>
 <20180314155731.5943-2-pvorel@suse.cz>
 <1522177951.3541.180.camel@linux.vnet.ibm.com>
 <20180329085947.hns5mhwu3co2tkox@dell5510>
 <1523375764.5268.12.camel@linux.vnet.ibm.com>
Message-ID: <20180411190335.GB25859@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mimi,

> > > >  load_policy()
> > ...
> > > >  	cat $1 |
> > > > -	while read line ; do
> > > > -	{
> > > > -		if [ "${line#\#}" = "${line}" ] ; then
> > > > -			echo $line >&4 2> /dev/null
> > > > +	while read line; do
> > > > +		if [ "${line#\#}" = "${line}" ]; then
> > > > +			echo "$line" >&4 2> /dev/null
> > > >  			if [ $? -ne 0 ]; then
> > > >  				exec 4>&-
> > > >  				return 1
> > > >  			fi
> > > >  		fi
> > > > -	}

> > > Originally writing the policy was done one rule at a time, but hasn't
> > > been required for a long time.  dracut and systemd 'cat' the policy
> > > directly to the pseudo file.
> > OK, let's simplify it to catting the content.

> Replacing the builtin policy with a new policy in the initramfs was
> considered safe.  With commit 38d859f991f3 ("IMA: policy can now be
> updated multiple times") the policy can be extended multiple times,
> not only from the initramfs.  For it to be safe to extend the IMA
> policy (eg. CONFIG_IMA_WRITE_POLICY), the policy must be signed.

> These tests assume the policy does not need to be signed.

Is it a good idea to expect that policy must be signed also for older kernels
(kernels before 4.5)?

> Mimi


Kind regards,
Petr
