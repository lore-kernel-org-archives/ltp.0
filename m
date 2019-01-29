From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Jan 2019 19:24:39 +0100
Subject: [LTP] [PATCH v3 2/6] shell: Add tst_security.sh helper
In-Reply-To: <20190123162032.GB30191@rei>
References: <20181218010220.2446-1-pvorel@suse.cz>
 <20181218010220.2446-3-pvorel@suse.cz>
 <20190123162007.GA29183@dell5510> <20190123162032.GB30191@rei>
Message-ID: <20190129182439.GA19044@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > +	if [ $TST_BROK -gt 0 -o $TST_CONF -gt 0 -o $TST_FAIL -gt 0 -o $TST_WARN -gt 0 ]; then
> > +		_tst_check_security_modules
> > +	fi

> Not sure about the TCONF here but apart of that it looks good.
Whole patchset merged, without TCONF.

Kind regards,
Petr
