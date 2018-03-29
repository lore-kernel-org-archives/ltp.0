From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 29 Mar 2018 10:59:48 +0200
Subject: [LTP] [RFC PATCH v2 1/4] security/ima: Rewrite tests into new
 API + fixes
In-Reply-To: <1522177951.3541.180.camel@linux.vnet.ibm.com>
References: <20180314155731.5943-1-pvorel@suse.cz>
 <20180314155731.5943-2-pvorel@suse.cz>
 <1522177951.3541.180.camel@linux.vnet.ibm.com>
Message-ID: <20180329085947.hns5mhwu3co2tkox@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mimi,

> > * ima_measurements.sh:
> >   - add support for "ima-ng" and "ima-sig" IMA measurement templates
> >   - add support for most of hash algorithms is defined in
> >     include/uapi/linux/hash_info.h (kernel headers); algorithms are
> >     detected from last occurance of tested file in
> >     /sys/kernel/security/ima/ascii_runtime_measurements
> >   - check i_version mount option only for ext[2-4] filesystems (other
> >     filesystems don't report it), TCONF when not mounted with it
> >   - XFS has iversion support from >= V5, TCONF when older version

> Needing the filesystem to be mounted with i_version is changing in
> Linux 4.16.  With commit ac0bf025d2c0 ("ima: Use i_version only when
> filesystem supports it"), files on filesystems, which do not support
> i_version, will now *always* be re-measured (based on policy), making
> i_version a performance improvement.
Thanks for info, I'll update the test.

> >  load_policy()
...
> >  	cat $1 |
> > -	while read line ; do
> > -	{
> > -		if [ "${line#\#}" = "${line}" ] ; then
> > -			echo $line >&4 2> /dev/null
> > +	while read line; do
> > +		if [ "${line#\#}" = "${line}" ]; then
> > +			echo "$line" >&4 2> /dev/null
> >  			if [ $? -ne 0 ]; then
> >  				exec 4>&-
> >  				return 1
> >  			fi
> >  		fi
> > -	}

> Originally writing the policy was done one rule at a time, but hasn't
> been required for a long time.  dracut and systemd 'cat' the policy
> directly to the pseudo file.
OK, let's simplify it to catting the content.

> Mimi


Kind regards,
Petr

