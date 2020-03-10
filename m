From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Mar 2020 17:44:41 +0100
Subject: [LTP] [PATCH 2/2] nfs: Detect disabled UDP
In-Reply-To: <21baaca8-7c4e-7c11-2ff3-d10cf3e492e5@oracle.com>
References: <20200305192716.10313-1-pvorel@suse.cz>
 <20200305192716.10313-2-pvorel@suse.cz>
 <21baaca8-7c4e-7c11-2ff3-d10cf3e492e5@oracle.com>
Message-ID: <20200310164441.GC29541@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> > +	tst_rhost_run -c "grep -q '^[[:space:]]*udp[[:space:]]*=[[:space:]]*y' /etc/nfs.conf $config"

> Looks like the pattern doesn't detect when udp enabled by
> default and the config has commented default values,
> i.e. '# udp=y'.

> grep '^[# ]*udp *= *y' /etc/nfs.conf $config
Correct, this should be covered.
I'll send v2 with your much simpler regex, although I hoped we'd have something
error prone than just relying on content of config files. But IMHO checking
nfs-utils version cannot be easily done:

1) exportfs (which we require) does not print version (could be checked in
strings $(which exportfs), but we don't want unnecessary string dependency).
2) checking nfsstat (which will be probably presented on the server and even we
don't require it's presented, via if tst_cmd_available nfsstat && ...) can be
done, but we probably don't want to bother to parse it's version (UDP was
disabled in fbd7623d, which was in added in 2.1.2-rc2 and actually released in 2.2.1).

Kind regards,
Petr
