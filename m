From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 29 Jan 2021 19:34:09 +0100
Subject: [LTP] [PATCH 3/5] zram01.sh: Check properly mkfs.* dependencies
In-Reply-To: <YBRM7w0dNypJm2tD@pevik>
References: <20210129121817.12563-1-pvorel@suse.cz>
 <20210129121817.12563-4-pvorel@suse.cz> <YBQzlEoPLUAT3NFi@yuki.lan>
 <YBRM7w0dNypJm2tD@pevik>
Message-ID: <YBRVIRfgCPD+GA4b@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also I'm confused how this is supposed to work, we do limit the dev_num
> > but the zram_filesystems is untouched? That isn't going to work right.
> It actually works due this check in functions it uses:
> [ $i -eq $dev_num ] && break
> (maybe more readable to use -ge ).

So if we have ext3 unsupported we will loop over ext3, ext4 and xfs
there and break just before btrfs?

-- 
Cyril Hrubis
chrubis@suse.cz
