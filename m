From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Tue, 27 Mar 2018 15:12:31 -0400
Subject: [LTP] [RFC PATCH v2 1/4] security/ima: Rewrite tests into new
 API + fixes
In-Reply-To: <20180314155731.5943-2-pvorel@suse.cz>
References: <20180314155731.5943-1-pvorel@suse.cz>
 <20180314155731.5943-2-pvorel@suse.cz>
Message-ID: <1522177951.3541.180.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Wed, 2018-03-14 at 16:57 +0100, Petr Vorel wrote:
> * simplify code, remove duplicity
> 
> * ima_measurements.sh:
>   - add support for "ima-ng" and "ima-sig" IMA measurement templates
>   - add support for most of hash algorithms is defined in
>     include/uapi/linux/hash_info.h (kernel headers); algorithms are
>     detected from last occurance of tested file in
>     /sys/kernel/security/ima/ascii_runtime_measurements
>   - check i_version mount option only for ext[2-4] filesystems (other
>     filesystems don't report it), TCONF when not mounted with it
>   - XFS has iversion support from >= V5, TCONF when older version

Needing the filesystem to be mounted with i_version is changing in
Linux 4.16.  With commit ac0bf025d2c0 ("ima: Use i_version only when
filesystem supports it"), files on filesystems, which do not support
i_version, will now *always* be re-measured (based on policy), making
i_version a performance improvement.

[...]

>  load_policy()
>  {
> +	local ret
> +
>  	exec 2>/dev/null 4>$IMA_POLICY
> -	if [ $? -ne 0 ]; then
> -		exit 1
> -	fi
> +	[ $? -eq 0 ] || exit 1
> 
>  	cat $1 |
> -	while read line ; do
> -	{
> -		if [ "${line#\#}" = "${line}" ] ; then
> -			echo $line >&4 2> /dev/null
> +	while read line; do
> +		if [ "${line#\#}" = "${line}" ]; then
> +			echo "$line" >&4 2> /dev/null
>  			if [ $? -ne 0 ]; then
>  				exec 4>&-
>  				return 1
>  			fi
>  		fi
> -	}

Originally writing the policy was done one rule at a time, but hasn't
been required for a long time.  dracut and systemd 'cat' the policy
directly to the pseudo file.

Mimi

