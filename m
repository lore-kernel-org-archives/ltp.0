From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 5 Sep 2016 14:10:33 +0200
Subject: [LTP] [PATCH 3/4] memcg_lib.sh: Get rid of sleep 1 in
 signal_memcg_process
In-Reply-To: <1433899610.1780903.1473070695326.JavaMail.zimbra@redhat.com>
References: <1472750315-30848-1-git-send-email-chrubis@suse.cz>
 <1472750315-30848-3-git-send-email-chrubis@suse.cz>
 <57C94968.5070609@oracle.com>
 <1433899610.1780903.1473070695326.JavaMail.zimbra@redhat.com>
Message-ID: <20160905121033.GB14029@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > >  	kill -s USR1 $pid 2> /dev/null
> > > -	sleep 1
> > > +
> > > +	if [ -z "$size" ]; then
> > > +		return
> > > +	fi
> > > +
> > > +	while kill -0 $pid 2> /dev/null; do
> > > +		local usage=$(cat ${path}memory.usage_in_bytes)
> > > +		local diff_a=$((usage_start - usage))
> > > +		local diff_b=$((usage - usage_start))
> > > +
> > > +		if [ "$diff_a" -ge "$size" -o "$diff_b" -ge "$size" ]; then
> > > +			return
> > > +		fi
> > > +
> > > +		tst_sleep 100ms
> > > +	done
> > 
> > Maybe add some limit on the number of checks? In case the process
> > consumes less memory than in $size.
> 
> This was my concern as well, in unlikely case it won't get killed,
> we could loop here.

OK, will add timeout here.

-- 
Cyril Hrubis
chrubis@suse.cz
