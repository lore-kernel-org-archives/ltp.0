From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 20 Jul 2020 13:53:45 +0200
Subject: [LTP] [PATCH v2 6/7] net/test: Add basic testing for
 tst_rhost_run
In-Reply-To: <5F155DB2.8080709@cn.fujitsu.com>
References: <20200710172044.21592-1-pvorel@suse.cz>
 <20200710172044.21592-7-pvorel@suse.cz>
 <5F155DB2.8080709@cn.fujitsu.com>
Message-ID: <20200720115345.GA21201@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > +	tst_rhost_run -c 'which grep > /dev/null' || \
> > +		tst_res TCONF "grep not found on rhost"
> Hi Petr,

> 1) Do you want to discard stderr as well? For example:
> -------------------------------------------------
> # which gre >/dev/null
> /usr/bin/which: no gre in
> (/opt/ltp/testcases/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:/root/bin)

That's not needed because tst_rhost_run already redirect stderr to stdout.

> -------------------------------------------------
> 2) Is it necessary to continue if grep command is not found on rhost?
> How about calling tst_brk?
Good catch, I should use tst_brk on both places.

> > +
> > +	tst_rhost_run -c "[ -f $file ]" || \
> > +		tst_res TCONF "$file not found on rhost"
> Call tst_brk as well?

> Thanks,
> Xiao Yang

Thanks!
Petr
