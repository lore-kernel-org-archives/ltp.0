From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 10 Apr 2018 11:56:04 -0400
Subject: [LTP] [RFC PATCH v2 1/4] security/ima: Rewrite tests into new
 API + fixes
In-Reply-To: <20180329085947.hns5mhwu3co2tkox@dell5510>
References: <20180314155731.5943-1-pvorel@suse.cz>
 <20180314155731.5943-2-pvorel@suse.cz>
 <1522177951.3541.180.camel@linux.vnet.ibm.com>
 <20180329085947.hns5mhwu3co2tkox@dell5510>
Message-ID: <1523375764.5268.12.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, 2018-03-29 at 10:59 +0200, Petr Vorel wrote:
> Hi Mimi,

> > >  load_policy()
> ...
> > >  	cat $1 |
> > > -	while read line ; do
> > > -	{
> > > -		if [ "${line#\#}" = "${line}" ] ; then
> > > -			echo $line >&4 2> /dev/null
> > > +	while read line; do
> > > +		if [ "${line#\#}" = "${line}" ]; then
> > > +			echo "$line" >&4 2> /dev/null
> > >  			if [ $? -ne 0 ]; then
> > >  				exec 4>&-
> > >  				return 1
> > >  			fi
> > >  		fi
> > > -	}
> 
> > Originally writing the policy was done one rule at a time, but hasn't
> > been required for a long time.  dracut and systemd 'cat' the policy
> > directly to the pseudo file.
> OK, let's simplify it to catting the content.

Replacing the builtin policy with a new policy in the initramfs was
considered safe.  With commit 38d859f991f3 ("IMA: policy can now be
updated multiple times") the policy can be extended multiple times,
not only from the initramfs.  For it to be safe to extend the IMA
policy (eg. CONFIG_IMA_WRITE_POLICY), the policy must be signed.

These tests assume the policy does not need to be signed.

Mimi

