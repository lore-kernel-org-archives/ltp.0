From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Jan 2021 18:59:11 +0100
Subject: [LTP] [PATCH 3/5] zram01.sh: Check properly mkfs.* dependencies
In-Reply-To: <YBQzlEoPLUAT3NFi@yuki.lan>
References: <20210129121817.12563-1-pvorel@suse.cz>
 <20210129121817.12563-4-pvorel@suse.cz> <YBQzlEoPLUAT3NFi@yuki.lan>
Message-ID: <YBRM7w0dNypJm2tD@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > +check_fs_support()
> > +{
> > +	local fs unsupported
> > +	local msg="missing kernel support or mkfs for filesystems:"
> > +	dev_num=0
> > +
> > +	for fs in $zram_filesystems; do
> > +		if tst_supported_fs $fs 2> /dev/null; then

> Why are we silencing the output here?

> > +			dev_num=$((dev_num+1))
> > +		else
> > +			unsupported="$unsupported $fs"
> > +		fi
> > +	done

> Maybe we should put the Btrfs space check here as well, so that all
> checks are in a single place.

> > +	if [ $dev_num -eq 0 -a "$fallback_filesystem" != "$FS_TYPE" ]; then
> > +		if tst_supported_fs $fallback_filesystem 2> /dev/null; then
> > +			dev_num=1
> > +		fi
> > +	fi
> > +
> > +	if [ $dev_num -eq 0 ]; then
> > +		tst_res TINFO "filesystems on the system"
> > +		tst_supported_fs > /dev/null

> And producing different output here.

> > +		msg="$msg $zram_filesystems"
> > +		if [ "$fallback_filesystem" != "$FS_TYPE" ]; then
> > +			msg="$msg $fallback_filesystem"
> > +		fi
> > +		tst_brk TCONF "$msg"
> > +	fi
> > +
> > +	[ "$unsupported" ] && tst_res TINFO "$msg$unsupported"

> And here.

> I guess that we end up with a bit nicer output but the code is much more
> complex.
You're right.


> Also I'm confused how this is supposed to work, we do limit the dev_num
> but the zram_filesystems is untouched? That isn't going to work right.
It actually works due this check in functions it uses:
[ $i -eq $dev_num ] && break
(maybe more readable to use -ge ).

> I guess the best shoot would be generating the zram_filesystems here on
> the fly based on output of the tst_supported_fs.
Very good idea. I still wasn't happy with the patchset and this was the missing
piece. Also generating other variables. I overlooked that only size for BTRFS is
different. In that case [ $i -eq $dev_num ] && break should not be needed.

I also introduced fallback_filesystem, because I thought that FS_TYPE and FS_SIZE
(as uppercase) are for LTP API. But they're not, that's TST_FS_TYPE (and there
is no *SIZE variable). These (if still used) should be lower case).

Thanks for your review!

Kind regards,
Petr
